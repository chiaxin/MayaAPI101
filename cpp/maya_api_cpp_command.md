# Maya API CPP Command

## Declare and Define a Custom Command

Basic :

1. Inherit `MPxCommand` class from Maya API.
2. Write a static method `void * creator()`.
3. Override `MStatus doIt(const MArgList &)` method.
4. It need a command name for Maya.

Advance :

1. We need a method such as `MSyntax newSyntax()` to add flags.
2. We need a parse method to parse flags from user input in Maya,</br>
   For example, implement a method `MStatus parseSyntax(const MArgList &)`.

About flags details, you can see [command argument](./maya_api_cpp_command_argument.md).

## Example

This example want to create a command it can be list user selected on the screen.

### In the head file `listSelectionsCmd.h`

```cpp
#ifndef _LIST_SELECTIONS_CMD_H
#define _LIST_SELECTIONS_CMD_H

#include <maya/MPxCommand.h>

class ListSelectionsCmd : public MPxCommand
{
public:
    static const char * kCmdName; // Command's name
    ListSelectionsCmd();          // Constructor
    virtual ~ListSelectionCmd();  // Destructor
    static void * creator();      // Creator
    MStatus doIt(const MArgList &) override; // Do it method
};

#endif /* _LIST_SELECTIONS_CMD_H */
```

+ In head file, we need write `#ifndef` and `#define` in the top to avoid `duplicated include`.
+ Maya API command should be public inherit from `MPxCommand` in `MPxCommand.h`.
+ The convention is topper-case in first character, and `Cmd` suffix.
  [Check Detail](../Maya_API_naming_conventions.md)
+ In the basic, Maya API command have 4 methods in `public` block.

1. Constructor
2. Destructor
3. creator
4. doIt

+ The `creator` is a `static method` and return `void *` type with no arguments.
  It is for register command.
+ The `MStatus doIt(const MArgList &)` is from `MPxCommand` provided virtual method.
    + You must implement it to define command's behavior.
    + It will return `MStatus` and has one argument - `MArgList` (by constant reference).
    + In the head file, You not need to provide formal parameter name.
+ And we need a `command name definition`.
    + I place it into class member.
    + You can just place it out of the class also.
+ Finally, use `#endif` in the end to match previous `#ifndef`

### In the cpp file `listSelectionsCmd.cpp`

```cpp
#include "listSelectionsCmd.h"
#include <maya/MSelectionList.h>
#include <maya/MGlobal.h>
#include <maya/MStatus.h>

const char * ListSelectionsCmd::kCmdName = "listSelection";

ListSelectionsCmd::ListSelectionCmd()
{
}

ListSelectionsCmd::~ListSelectionCmd()
{
}

void * ListSelectionsCmd::creator()
{
    return new ListSelectionsCmd();
}

MStatus ListSelectionsCmd::doIt(const MArgList & argList)
{
    MStatus stat = MS::kSuccess;
    MSelectionList selectionList;
    MGlobal::getActiveSelectionList(selectionList);
    if (selectionList.length() > 0) {
        for (int i = 0 ; i < selectionList.length() ; i++) {
            MDagPath dagPath;
            selectionList.getDagPath(dagPath, i, &stat);
            if (stat != MS::kSuccess) {
                MGlobal::displayError("Failed get dag path!");
            }
            MGlobal::displayInfo(dagPath.fullPathName());
        }
    }
    return stat;
}
```

+ In this case, constructor and destructor does nothing.
+ The `creator` method is return this class's instance.
+ The `doIt` method will launch when command calling.

### Register Command In `pluginMain.cpp`

```cpp
#include "listSelectionsCmd.h"
#include <maya/MFnPlugin.h>

MStatus initializePlugin(MObject mobject)
{
    MStatus stat = MS::kSuccess;
    MFnPlugin fnPlugin(mobject, "Author", "1.0", "Any", &stat);
    stat = fnPlugin.registerCommand(
        ListSelectionsCmd::kCmdName,
        ListSelectionsCmd::creator
    );
    if (stat != MS::kSuccess)
    {
        MGlobal::displayError("Failed to register command : listSelection");
    }
    return stat;
}

MStatus uninitializePlugin(MObject mobject)
{
    MStatus stat = MS::kSuccess;
    MFnPlugin fnPlugin(mobject);
    stat = fnPlugin.deregisterCommand(ListSelectionsCmd::kCmdName);
    if (stat != MS::kSuccess)
    {
        MGlobal::dispalyError("Failed to deregister command : listSelection");
    }
    return stat;
}
```

## Get Result

### Get a result

Use `MPxCommand::setResult`

### Get a Result Array

Use `MPxCommand::appendToResult`

### Other Static Method in MPxCommand

+ Clean result - use `MPxCommand::clearResult`.
+ Check the result is array - use `MPxCommand::isCurrentResultArray`.
+ Check current result type - use `MPxCommand::currentResultType`.