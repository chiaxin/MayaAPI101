# Maya API CPP node

## Inherit MPxNode

### In head file - Declarations

```cpp
#ifndef __CUSTOM_NODE_H
#define __CUSTOM_NODE_H

#include <maya/MPxNode.h>
#include <maya/MPlug.h>
#include <maya/MDataBlock.h>
#include <maya/MTypeId.h>

class CustomNode : public MPxNode
{
public:
    MPxNode();
    virtual ~MPxNode();
    static void * creator();
    static const char * kNodeName;
    static MStatus initialize();
    static MTypeId id;
    MStatus compute(const MPlug &, MDataBlock &) override;
    // Attributes
    static MObject moInput;
    static MObject moOutput;
    // Attribute name
    static const char * kInputSN;
    static const char * kInputLN;
    static const char * kOutputSN;
    static const char * kOutputLN;
};

#endif /* __CUSTOM_NODE_H */
```

### In cpp file - Definitions

```cpp
#include "customNode.h"
#include <maya/MPxNode.h>
#include <maya/MPlug.h>
#include <maya/MDataBlock.h>
#include <maya/MDataHandle.h>
#include <maya/MTypeId.h>
#include <maya/MFnNumericAttribute.h>
```

+ Node name definition.
+ Attribute name definitions.

```cpp
const char * CustomNode::kNodeName= "customNode";
const char * CustomNode::kInputSN = "in";
const char * CustomNode::kInputLN = "input";
const char * CustomNode::kOutputSN= "out";
const char * CustomNode::kOutputLN= "output";
```

+ Node Type Id definition.
+ Id range is between 0x00000000 - 0x0007ffff.

```cpp
MTypeId CustomNode::id(0x80012);
```

+ Initialize attributes to NULL values.

```cpp
MObject CustomNode::moInput;
MObject CustomNode::moOutput;
```

+ Write a simple function to set input and output attributes.

```cpp
MStatus make_input(MFnAttribute & attr)
{
    MStatus stat = MS::kSuccess;
    stat = attr.setKeyable(true);
    stat = attr.setStorable(true);
    stat = attr.setReadable(true);
    stat = attr.setWritable(true);
    return stat;
}

MStatus make_output(MFnAttribute & attr)
{
    MStatus stat = MS::kSuccess;
    stat = attr.setKeyable(false);
    stat = attr.setStorable(false);
    stat = attr.setReadable(true);
    stat = attr.setWritable(false);
    return stat;
}
```

+ Constructor and Destructor.

```cpp
CustomNode::CustomNode()
{
}

CustomNode::~CustomNode()
{
}
```

+ Creator - return this new instance.

```cpp
void * CustomNode::creator()
{
    return new CustomNode();
}
```

+ Initialize your attributes - create, add and affects.
+ The `MFnNumericAttribute` is derived from `MFnAttribute`.</br>
  The `MFnAttribute` have many child class can be create attributes.</br>
  In general, we need to provide full and brief name.</br>
+ `MPxNode::addAttribute` can be add attribute to this node</br>
+ `MPxNode::attributeAffects()` can be specifies that a particular input</br>
  attribute affects a specific output attribute.</br>
  The output attribute cannot be keyable, if they are keyable, this method will fail.

```cpp
MStatus Custom::initialize()
{
    MStatus stat = MS::kSuccess;
    MFnNumericAttribute fnAttr;
    
    // Create attributes by MFnNumericAttribute::create().
    moInput = fnAttr.create(kInputLN, kInputSN, MFnNumericData::kDouble, 0.0, &stat);
    if (stat != MS::kSuccess)
    {
        MGlobal::displayError("Failed to create attribute : " + kInputLN);
        return stat;
    }
    CHECK_MSTATUS_AND_RETURN_IT(make_input(fnAttr));
    moOutput = fnAttr.create(kOutputLN, kOutputSN, MFnNumericData::kDouble, 0.0, &stat);
    if (stat != MS::kSuccess)
    {
        MGlobal::displayError("Failed to create attribute : " + kOutputLN);
        return stat;
    }
    CHECK_MSTATUS_AND_RETURN_IT(make_output(fnAttr));

    // Use MPxNode::addAttribute to add attributes.
    CHECK_MSTATUS_AND_RETURN_IT(addAttribute(omInput));
    CHECK_MSTATUS_AND_RETURN_IT(addAttribute(omOutput));

    // Use MPxNode::attributeAffects to make affects.
    CHECK_MSTATUS_AND_RETURN_IT(attributeAffects(omInput, omOutput));
    
    return stat;
}
```

+ `MPxNode::compute` is core of MPxNode, we have to implement it.
+ We must use `MDataHandle` to get or set values.

```cpp
MStatus CustomNode::compute(const MPlug & plug, MDataBlock &)
{
    if (plug != omOutput)
    {
        return MS::kUnknownParameter;
    }
    MStatus stat;
    // Create a data handle from input data block.
    MDataHandle input_handle = data.inputValue(omInput, &stat);
    CHECK_MSTATUS_AND_RETURN_IT(stat);
    // Create a data handle from output data block.
    MDataHandle output_handle = data.outputValue(omOutput, &stat);
    CHECK_MSTATUS_AND_RETURN_IT(stat);
    // Calculate your data.
    float input_value = input_handle.asFloat();
    // Make input value double.
    float double_value = input_value * 2.0;
    // Set output data value, and set clean.
    output_handle.set(double_value);
    output_handle.setClean();
    //
    return stat;
}
```

## About Maya Attributes

The Maya attribute is `MObject`.</br>
By default, attributes are :

+ Readable.
+ Writable.
+ Connectable.
+ Storable.
+ Cached.
+ Not keyable.
+ Not hidden.
+ Not used as colors.
+ Not indeterminant.
+ Not arrays.
+ Have indices that matter.
+ Do not use an array builder.
+ Set to disconnect behavior kNothing.

### Attribute Notes

If attribute is keyable and writable, it will be displayed in the channel box.</br>

### MFnAttribute's children

| Class                | Description                                   |
| -------------------- | --------------------------------------------- |
| MFnCompoundAttribute | set compound dependency node attributes.      |
| MFnEnumAttribute     | enumerated attributes.                        |
| MFnGenericAttribute  | accept several types of data.                 |
| MFnLightDataAttribute| set light data attribute.                     |
| MFnMatrixAttribute   | set matrix attributes.                        |
| MFnMessageAttribute  | set message attributes.                       |
| MFnNumericAttribute  | set numeric attributes.                       |
| MFnTypedAttribute    | set typed attributes.                         |
| MFnUnitAttribute     | fundamental types of Maya data.               |

### How to check out attribute type use mel

```mel
attributeQuery -node "pCubeShape1" -at "uvSet";
// Result: compound //
attributeQuery -node "file1" -at "filterType";
// Result : enum //
attributeQuery -node "file1" -at "coverage";
// Result: float2 //
```

### Set Disconnect Behavior

Use `MFnAttribute::setDisconnectBehavior` to set disconnection behavior</br>

| enum       | Behavior                                  |
| ---------- | ----------------------------------------- |
| kDelete    | Delete array element(array attribute only)|
| kReset     | Reset the attribute to its default.       |
| kNothing   | Do nothing to the attribute's value.      |
