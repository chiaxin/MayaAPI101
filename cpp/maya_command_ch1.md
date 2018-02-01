# Maya Command Chapter 1

## Create a Custom Command

In `listSelectionsCmd.h`

```cpp
#ifndef _LIST_SELECTIONS_CMD_H
#define _LIST_SELECTIONS_CMD_H

#include <maya/MPxCommand.h>

class ListSelectionsCmd : public MPxCommand
{
public:
    Command();          // constructor
    virtual ~Command(); // destructor
    MStatus doIt(const MArgList &) override;
private:
};

#endif
```

---

+ In all head file, we need write `#ifndef` and `#define` in the top
  to avoid `duplicated include`.</br>
  在所有的標頭檔，我們需要加上 `#ifndef` 和 `#define` 為了避免重複引用。

```cpp
#ifndef _LIST_SELECTIONS_CMD_H
#define _LIST_SELECTIONS_CMD_H
```

+ All API command would be inherit from `MPxCommand` in `MPxCommand.h`.</br>
  Maya API command 都必須繼承自 `MPxCommand` 從 `MPxCommand.h`。

```cpp
#include <maya/MPxCommand.h>

class ListSelectionsCmd : public MPxCommand
```

+ The convention is topper-case in first character, and `Cmd` suffix.</br>
  習慣上 Command Class 命名都會以大寫開頭，以 `Cmd` 結尾。</br>
  [Check Detail](../Maya_API_naming_conventions.md)