# Dependency Node Snippets

## How to create a Maya node with Maya C++ API

```cpp
#include <maya/MDGModifier.h>

MStatus create_node(const MString & name)
{
    // In this example, I want to create a node : somethingNode.
    // Use "MDGModifier::create" to create a node.
    // It will return a MObject, you can rename it after created.
    // When you call "MDGModifier::doIt", Maya will create it and rename.
    MStatus stat;
    MDGModifier dgModifier;
    MObject obj = dgModifier.create(MString("somethingNode"), &stat);
    dgModifier.renameNode(obj, name);
    stat = dgModifier.doIt();
    return stat;
}
```