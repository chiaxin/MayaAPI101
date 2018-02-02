# Maya Command Chapter 1 : Basic

## Create a Custom Command

### In `listSelectionsCmd.h`

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

#endif
```

### In `listSelectionsCmd.cpp`

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

### In `pluginMain.cpp`

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

## listSelectionCmd.h

+ In head file, we need write `#ifndef` and `#define` in the top
  to avoid `duplicated include`.</br>

```cpp
#ifndef _LIST_SELECTIONS_CMD_H
#define _LIST_SELECTIONS_CMD_H
```

+ Maya API command would be inherit from `MPxCommand` in `MPxCommand.h`.</br>
  and use `public` inherit.</br>
+ The convention is topper-case in first character, and `Cmd` suffix.</br>
  [Check Detail](../Maya_API_naming_conventions.md)

```cpp
#include <maya/MPxCommand.h>

class ListSelectionsCmd : public MPxCommand
{
public:
    //...
};
```

+ In the basic, Maya API command have 4 methods in `public` block.</br>

1. Constructor
2. Destructor
3. creator
4. doIt

+ `creator` is a `static` method and return `void*` with no arguments.
+ It is for register command.

```cpp
    static void * creator();
```

+ `doIt` is from `MPxCommand` provided `virtual` method, You must implement it.</br>
  It will return `MStatus` and has one argument - `MArgList` (constant reference).</br>
  In head file, You not need to provide formal parameter name.</br>

```cpp
    MStatus doIt(const MArgList &);
```

+ And we need a `command name definition`, I put it in class member.
+ It is a `static const char *` type, Just like a constant string.

```cpp
    static const char * kCmdName;
```

+ Finally, use `#endif` in the end to match previous `#ifndef`

```cpp
#endif
```

## listSelectionCmd.cpp

+ Include head file at the top.

```cpp
#include "listSelectionCmd.h"
#include <maya/MGlobal.h>
#include <maya/MSelectionList.h>
#include <maya/MStatus.h>
```

+ Define command's name.

```cpp
const char * ListSelectionCmd::kCmdName = "listSelection";
```

+ In this case, constructor and destructor would do nothing.

```cpp
ListSelectionCmd::ListSelectionCmd()
{
}

ListSelectionCmd::~ListSelectionCmd()
{
}
```

+ `creator` method is return this class's instance.

```cpp
void * ListSelectionCmd::creator()
{
    return new ListSelectionCmd();
}
```

+ `doIt` method will launch when command was call.

```cpp
MStatus ListSelectionCmd::doIt(const MArgList & argList)
{
    // ... implements
}
```

## Register command

Please see other page : [register_maya_object.md](./register_maya_object.md)