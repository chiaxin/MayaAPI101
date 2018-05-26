# Maya API cpp Plug-in register

## Plug-in Function

`MStatus initializePlugin(MObject)` and `MStatus uninitializePlugin(MObject)`</br>
are plugin `load` and `unload` functions.</br>
In general, They are in `pluginMain.cpp` file (better maintainable).

They have one argument - MObject.

```cpp
#include <maya/MFnPlugin.h>

MStatus initializePlugin(MObject mobject)
{
    //...
}

MStatus uninitializePlugin(MObject mobject)
{
    //...
}
```

In the first, create a `MStatus` object,</br>
and create a `MFnPlugin` object to register Maya objects.</br>
It can input `Vendor`, `Version`, `Required Api Version` by the string.

```cpp
MStatus initializePlugin(MObject mobject)
{
    MStatus stat = MS::kSuccess;
    MFnPlugin fnPlugin(mobject, "Author", "1.0", "Any", &stat);
}
```

## Register Command

Use `MFnPlugin::registerCommand` method.</br>
`commandName` is a string,</br>
`creatorFunction` is a function pointer point to creator method.</br>
`createSyntaxFunction` is a function pointer point to new syntax method,</br>
It can be ignore if your command have no syntax.

```cpp
stat = fnPlugin.registerCommand(
    commandName,
    creatorFunction,
    createSyntaxFunction
);
```

## Check status

```cpp
if (stat != MS::kSuccess)
{
    MGlobal::displayError("# Failed to register command : CommandName");
    return stat;
}
```

## Deregister Command

In the `uninitializePlugin`, just simple input command's name.

```cpp
MStatus uninitializePlugin(MObject mobject)
{
    MStatus stat = MS::kSuccess;
    MFnPlugin fnPlugin(mobject);
    stat = fnPlugin.deregisterCommand(commandName);
    if (stat != MS::kSuccess)
    {
        MGlobal::displayError("# Failed to deregister command : CommandName");
        return stat;
    }
    return stat;
}
```

## Register Dependency Node

In the function `initializePlugin` :

```cpp
MStatus initializePlugin(MObject mobject)
{
    MStatus stat = MS::kSuccess;
    MFnPlugin fnPlugin(mobject);
    stat = fnPlugin.registerNode(
        CustomNode::kNodeName,
        CustomNode::id,
        CustomNode::creator,
        CustomNode::initialize,
        MPxNode::kDependNode
    );
}
```

## Deregister Dependency Node

In the function `uninitializePlugin` :

```cpp
MStatus uninitializePlugin(MObject mobject)
{
    MStatus stat = MS::kSuccess;
    MFnPlugin fnPlugin(mobject);
    stat = fnPlugin.deregisterNode(CustomNode::id);
}
```