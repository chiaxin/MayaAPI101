# Maya API CPP Command Arguments

## Strategy

+ Use `MSyntax` object to add and define all flag and arguments you need.
+ Register the new syntax object when register command.
+ Use `MArgDatabase` or `MArgParser` to analisys user argument inputs.

## Maya Command Structure

command (-edit|-query) `-flag1 arg1 arg2 arg3` `-flag2 arg1 arg2 arg3` argument;

| Segments  | Description                                           |
| --------- | ----------------------------------------------------- |
| command   | The command name identify.                            |
| -edit(-e) | A special flag, could be represents `edit` mode.      |
| -query(-q)| A special flag, could be represents `query` mode.     |
| -flag     | There are represent all flags and arguments.          |
| argument  | That is a command argument at the end of command.     |

+ The flag can be multi-use if you set it in `multi-usage`.

## Flags Arguments

+ Use `MSyntax::addFlag` to add new flag :   
  `MSyntax::addFlag(const char * shortName, const char * longName, MArgType argType1=kNoArg,...)`.
+ The flag short name must less than 4 characters.
+ The flag long name must gather than 3 characters.
+ A flag can be multi-usage when you call `MSyntax::makeFlagMultiUse(const char * flag)`.
+ A flag can be receive 6 parameter at most, They can be difference type.
+ The special flag -edit(-e) and -query(-q);  
  enable them use `MSyntax::enableEdit(bool supportsEdit=true)`  
  and `MSyntax::enableQuery(bool supportsQuery=true)`.

## Command Arguments

Define command arguments have two ways - `command arguments` and `objects`.

### Add Command Argument

+ Use `MSyntax::addArg(MArgType arg)` to add command argument.

MSyntax::MArgType Enum have 12 types.

| Enumerator        | A                |
| ----------------- | ---------------- |
| kInvalidArgType   | .                |
| kNoArg            | .                |
| kBoolean          | boolean, true or false         |
| kLong             | Integer long number            |
| kDouble           | Double float number            |
| kString           | String                         |
| kUnsigned         | .                |
| kDistance         | .                |
| kAngle            | .                |
| kTime             | .                |
| kSelectionItem    | .                |
| kLastArgType      | .                |

### Add Objects

+ Use `MSyntax::setObjectType(MObjectFormat objectFormat, unsigned int minimumObjects=0)`  
  to specific object type.
+ It can be specific minimum and maximum number of objects;  
  `MSyntax::setMinObjects(unsigned int minimumObjectCount)` and  
  `MSyntax::setMaxObjects(unsigned int maximumObjectCount)`
+ Pass `MSyntax::kStringObjects` enum it would no check out object exists  
   and get it as a wrapper object - `MStringArray`.
+ Pass `MSyntax::kSelectionList` enum it will check out object exists  
   and get it as a wrapper object - `MSelectionList`.
+ Pass `MSyntax::kNone` enum it have no any parameter.

### Using MSyntax::addFlag and MSyntax::addArg

The `MSyntax::addFlag()` can be add a new flag in command.  
We need specific its type in 3rd argument by MSyntax's enum.  
For example, We want to add a flag called "-f" and "-flag".  
And it is a "string" type argument.

```cpp
// In newSyntax() member method.
stat = syntax.addFlag("-f", "-flag", MSyntax::kString);
```

The `MSyntax::addArg()` can be add a argument in command.  
We need specific its type by MSyntax's enum - MSyntax::MArgType.

```cpp
// In newSyntax member method.
stat = syntax.addArg(MSyntax::kString);
```

### If You Want Make User Selected Objects to Command Argument

```cpp
// In newSyntax member method.
syntax.useSelectionAsDefault(true);
```

And you have to retrieve them from `MArgDatabase::getObjects`.

```cpp
// In parse member method.
MSelectionList selectionList;
stat = parser.getObjects(selections);
```

### Example

```cpp
MSyntax CustomCmd::newSyntax()
{
    MStatus stat = MS::kSuccess;
    MSyntax syntax;
    stat = syntax.addFlag("-a", "-argument", MSyntax::kString);
    if (stat != MS::kSuccess) {
        return syntax;
    }
    // Use MSyntax::makeFlagMultiUse(flag)
    stat = syntax.makeFlagMultiUse("-a");
    if (stat != MS::kSuccess) {
        return syntax;
    }
    return syntax
}
```

## Parse your MArgList object

In `CustomCmd::parseSyntax(const MArgList & argList)`

### Use `MArgDatabase::numOfFlagUsed` to Got How Many Specific Flag is Used

For example -  
In below case, we wil get a integer "4", because we have 4 difference flags.

```cpp
// In parse method
unsigned int num_of_flag_used = parser.numOfFlagUsed();
```

```mel
// In MEL
command -flagA 1 -flagB 2 -flagC 3 -flagD 4;
```

### Use `MArgDatabase::numOfFlagUses` to Get How Many Flag Arguments Has Been Set

__Attention : If you want use numOfFlagUses method to parse, You must set it to `multi-usage`__

For example -  
In below case, we will get a integer "3". because this flag is 3 times appears in command.

```cpp
// In parse method
unsigned int num_of_flag_uses = parser.numOfFlagUses("-flagA");
```

```mel
// In MEL
command -flagA arg1 -flagA arg2 -flagA arg3;
```

## Get flag's arguments

### Use `MArgParser::isFlagSet` to check out the flag is set or not

```cpp
if (parser.isFlagSet("-myflag"))
{
    // Do next...
}
```

### Use `isEdit` and `isQuery` to check out `-e` and `-q` is set or not

__Attention : If you want to use `isEdit`, you must use `enableEdit` in MSyntax__</br>
__Attention : If you want to use `isQuery`, you must use `enableQuery` in MSyntax__</br>

```cpp
if (parser.isEdit())
{
    // Do edit...
}
if (parser.isQuery())
{
    // Do query...
}
```

### Use series of `getFlagArgument` to get flag arguments

__Attention : `getFlagArgument` just available in C++__

In this case, we get "abcdef".

```cpp
// In c++
MStatus stat;
MString temp;
stat = parser.getFlagArgument("-flag", 0, temp);
```

```mel
// In mel
command -flag abcdef;
```

### Use series of `getCommandArgument` to get command arguments

__Attention : `getCommandArgument` just available in C++__

In this case, we get "aaa".

```cpp
// In c++
MStatus stat;
MString temp;
stat = parser.getCommandArgument(0, temp);
```

```mel
// In mel
command -flag abcdef "aaa";
```

### Other MArgParser and MArgDatabase methods

The `getFlagArgumentPosition` can be get the position of specific flag.

```cpp
// In cpp
unsigned int pos;
parser.getFlagArgumentPosition("-flagA", 0, pos);
// pos is get 0
parser.getFlagArgumentPosition("-flagA", 1, pos);
// pos is get 2
parser.getFlagArgumentPosition("-flagC", 0, pos);
// pos is get 6
```

```mel
// In mel
command -flagA abc -flagA efg -flagB 123 -flagC 456;
```

| Position |    0    |    1    |    2    |    3    |    4    |    5    |    6    |    7    |
| -------- | ------- | ------- | ------- | ------- | ------- | --------| --------| ------- |
| Segments | -flagA  |   abc   | -flagA  |   efg   | -flagB  |   123   |  -flagC |   456   |

## Example in parseSyntax

```cpp
MStatus CustomCmd::parseSyntax(const MArgList & argList)
{
    MStatus stat = MS::kSuccess;
    MArgDatabase parser(syntax(), argList, &stat);
    if (stat != MS::kSuccess) {
        return stat;
    }
    if (parser.isFlagSet("-a", &stat) && stat == MS::kSuccess) {
        unsigned int num_flag_used = parser.numOfFlagUses("-a");
        for (unsigned int i = 0 ; i < num_flag_used ; i++) {
            MArgList flag_arg_list;
            stat = parser.getFlagArgumentList("-a", i, flag_arg_list);
            if (stat != MS::kSuccess) {
                MGlobal::displayError("Failed to get flag argument list : -a");
                continue;
            } else {
                MString arg_str = flag_arg_list.asString(0, &stat);
                if (stat == MS::kSuccess) {
                    // Do something...
                }
            }
        }
    }
}
```