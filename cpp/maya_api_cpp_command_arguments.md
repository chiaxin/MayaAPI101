# Maya API CPP Command Arguments

## Strategy

1. Use `MSyntax` object to add and define all flag and arguments you need.
2. Register a new syntax object.
3. Use `MArgDatabase` or `MArgParser` to analisys user arguments.

### Flag Limited and Rules

1. Use `MSyntax::addFlag` to add new flag with 3 arguments</br>
   short name(brief name), long name and argument type.
2. The flag short name less than 4 character.
3. The flag long name gather than 3 character.
4. A flag can be multi-usage, if you call `MSyntax::makeFlagMultiUse`.
5. A flag can be receive 6 parameter at most, They can be difference type.
6. The special flag -e (-edit) and -q (-query) enable them use `enableEdit` and `enableQuery`.

### Arguments

Define argument have TWO ways : `command argument` and `objects`.

#### Command Arguments

1. Use `MSyntax::addArg` to add a new command argument.

#### Objects Arguments

1. Use `MSyntax::setObjectType` to add a new command argument.
2. It can be define minimum and maximum on number of objects.
3. Pass `MSyntax::kStringObjects` enum it no check object exists in the scene</br>
   and get it as `MStringArray`.
4. Pass `MSyntax::kSelectionList` enum it can check object exists in the scene</br>
   and get it as `MSelectionList`.
5. Pass `MSyntax::kNone` enum it have no any parameter.

## Maya Command Structure

command (-edit|-query) `-flag1 arg1 arg2 arg3` `-flag2 arg1 arg2 arg3` argument;

| Segments  | Description                                           |
| --------- | ----------------------------------------------------- |
| command   | The command name identify.                            |
| -edit     | A special flag, could be represents `edit` mode.      |
| -query    | A special flag, could be represents `query` mode.     |
| -flag     | There are represent all flags and arguments.          |
| argument  | That is a command argument at the end of command.     |

+ The flag can be multi-use if you set it to multi-usage.

## Register Custom `MSyntax` to Define Custom Flags

### Using MSyntax::addFlag and MSyntax::addArg

The `MSyntax::addFlag` can be add a new flag in command.</br>
We need specific its type in 3rd argument by MSyntax's enum.</br>
For example, We want to add a flag called "-f" and "-flag".</br>
And it is a "string" type argument.

```cpp
// In new syntax method.
stat = syntax.addFlag("-f", "-flag", MSyntax::kString);
```

The `MSyntax::addArg` can be add a new argument in command.</br>
We need specific its type by MSyntax's enum.

```cpp
// In new syntax method.
stat = syntax.addArg(MSyntax::kString);
```

### If You Want Make User Selected Objects to Command Argument

```cpp
// In new syntax method.
syntax.useSelectionAsDefault(true);
```

And you have to retrieve them from `MArgDatabase::getObjects`

```cpp
// In parse method.
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

For example :</br>
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

For example :</br>
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