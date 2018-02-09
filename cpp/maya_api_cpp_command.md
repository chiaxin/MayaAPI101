# Maya API cpp Command

## Declaration and Define Command

### In head file `listSelectionsCmd.h`

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

+ In head file, we need write `#ifndef` and `#define` in the top
  to avoid `duplicated include`.</br>
+ Maya API command should be inherit from `MPxCommand` in `MPxCommand.h`.</br>
  and use `public` inherit.</br>
+ The convention is topper-case in first character, and `Cmd` suffix.</br>
  [Check Detail](../Maya_API_naming_conventions.md)
+ In the basic, Maya API command have 4 methods in `public` block.</br>

1. Constructor
2. Destructor
3. creator
4. doIt

+ The `creator` is a `static` method and return `void*` with no arguments.
+ It is for register command.
+ The `doIt` is from `MPxCommand` provided `virtual` method</br>
  You must implement that core method.</br>
  It will return `MStatus` and has one argument - `MArgList` (by constant reference).</br>
  In head file, You not need to provide formal parameter name.</br>
+ And we need a `command name definition`, I place it into class member.</br>
  You can just place it out of the class. It is a `static const char *` type,</br>
  Just is a constant string.
+ Finally, use `#endif` in the end to match previous `#ifndef`

### In cpp file `listSelectionsCmd.cpp`

```cpp
#include "listSelectionsCmd.h"
#include <maya/MGlobal.h>
#include <maya/MSelectionList.h>
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
    if (selectionList.length() > 0)
    {
        for (int i = 0 ; i < selectionList.length() ; i++)
        {
            MDagPath dagPath;
            selectionList.getDagPath(dagPath, i, &stat);
            if (stat != MS::kSuccess)
            {
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
