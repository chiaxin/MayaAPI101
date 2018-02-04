# Maya API naming conventions

## Kind of Plug-in

In general, the following naming convention is used by the examples so you can identify the kind of plug-in the example based on its file name.

| Suffix      |       Description               |
| ----------- | ------------------------------- |
| Cmd         |       new commands              |
| Tool        |       new interactive tools     |
| Node        |       new node types            |
| Translator  |       new file translators      |
| Shader      |       new shading nodes         |
| Manip       |       new manipulators          |
| Field       |       new dynamic fields        |
| Emitter     |       new dynamic emitters      |
| Spring      |       new dynamic springs       |
| Shape       |       new shapes                |

Example :

In `customWorkCmd.h`

```cpp
class CustomWorkCmd : public MPxCommand
{
    // Declarations
};
```

---

## The Command's Name Identify

Use `kCmdName` in class members

Example :

In `customWorkCmd.h`

```cpp
class CustomWorkCmd : public MPxCommand
{
public:
    static const char * kCmdName;
}
```

In `customWorkCmd.cpp`

```cpp
const char * CustomWorkCmd::kCmdName = "customWork";
```

---

## The Command's Flag Name

Prefix by `"k"` (constant variable)

| Suffix      |     Description         |
| ----------- | ----------------------- |
| SN          | The flag's short name   |
| LN          | The flag's long name    |

Example :

```cpp
const char * kListSelectedSN = "-ls";
const char * kListSelectedLN = "-listSelected";
```

Useful Macro :

```cpp
#define FLAG(f, sn, ln) \
    const char * f##SN = sn; \
    const char * f##LN = ln;

FLAG(kListSelected, -ls, -listSelected);
```

---

## The Maya Object Prefix Suggestion

| Prefix    | Description               |
| --------- | ------------------------- |
| `mo`Obj   | `MObject` objects         |
| `fn`Obj   | Maya Function objects     |
| `it`Obj   | Maya Iteration objects    |
