# Maya API CPP Command Arguments

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
+ The flag argument can be multi-usage after the flag.

## Register your `MSyntax` to define your flags

### Use MSyntax::addFlag and MSyntax::addArg

`MSyntax::addFlag` can be add new flag in command.</br>
We need specific its type in 3rd argument use MSyntax's enum.

```cpp
// For example
stat = syntax.addFlag("-f", "-flag", MSyntax::kString);
```

`MSyntax::addArg` can be add new argument in command.

```cpp
// For example
stat = syntax.addArg(MSyntax::kString);
```

### If you want make user selected objects to command argument

```cpp
syntax.useSelectionAsDefault(true);
```

And you can retrieve them from `MArgParser::getObjects`

```cpp
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
    if (stat != MS::kSuccess)
    {
        return syntax;
    }
    // Use MSyntax::makeFlagMultiUse(flag)
    stat = syntax.makeFlagMultiUse("-a");
    if (stat != MS::kSuccess)
    {
        return syntax;
    }
    return syntax
}
```

## Parse your MArgList object

in `CustomCmd::parseSyntax(const MArgList & argList)`

### Use `MArgParser::numOfFlagUsed` to got how many specific flag used

For example :

In this case, we wil get a integer "4".</br>
Because we have 4 difference flags.

```cpp
    // In C++
    unsigned int num_of_flag_used = parser.numOfFlagUsed();
```

```mel
    // In MEL
    command -flagA 1 -flagB 2 -flagC 3 -flagD 4;
```

### Use `MArgParser::numOfFlagUses` to get how many flag arguments has been set

__Attention : If you want use numOfFlagUses method to parse, You must set it is `multi-usage`__

For example :

In this case, we will get a integer "3".</br>
Because this flag is 3 times appears in command.

```cpp
    // In C++
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

`getFlagArgumentPosition` can be get the position of specific flag.

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
    if (stat != MS::kSuccess)
    {
        return stat;
    }
    if (parser.isFlagSet("-a", &stat) && stat == MS::kSuccess)
    {
        unsigned int num_flag_used = parser.numOfFlagUses("-a");
        for (unsigned int i = 0 ; i < num_flag_used ; i++)
        {
            MArgList flag_arg_list;
            stat = parser.getFlagArgumentList("-a", i, flag_arg_list);
            if (stat != MS::kSuccess)
            {
                MGlobal::displayError("Failed to get flag argument list : -a");
                continue;
            }
            else
            {
                MString arg_str = flag_arg_list.asString(0, &stat);
                if (stat == MS::kSuccess)
                {
                    // Do something...
                }
            }
        }
    }
}
```