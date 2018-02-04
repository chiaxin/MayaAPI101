# Maya CPP API Snippets

## DAG

### DAG-001 Check dag visible

```cpp
bool isVisible(MFnDagNode& fnDag, MStatus& stat)
{
    // Is dag intermediate object ?
    if(fnDag.isIntermediateObject())
    {
        return false;
    }
    // Get attribute "visibility".
    MPlug visible_plug = fnDag.findPlug("visibility", &stat);
    if (MStatus::kFailure == stat)
    {
        MGlobal::displayError("MPlug::findPlug");
        return false;
    }
    else
    {
        bool visible;
        stat = visible_plug.getValue(visible);
        if (MStatus::kFailure == status)
        {
            MGlobal::displayError("MPlug::getValue");
        }
        return visible;
    }
}
```

## Name

### Name-001 Get last name in namespace

Use `MNamespace::stripNamespaceFromName`

```cpp
#include <maya/MNamespace.h>
MStatus stat = MS::kSuccess;
MString ns_name = "A:B:C:D";
MString last_name = MNamespace::stripNamespaceFromName(ns_name, &stat);
// Get "D"
```