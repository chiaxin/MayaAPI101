# VSCPP Load Dynamic Library

This article would be studies how to load dynamic library in Maya plug-in on Windows.

In this example, I use dynamic load by `LoadLibrary` function from `windows.h`.

## Summary

1. Write and compile a dynamic library (*.dll).
2. Copy the dll file into a specify path (such as `C:\bin`)
3. Write a Maya plug-in and use `windows.h` function - `LoadLibrary` to load it.
4. Add a path that have dll file we made it into environment variable `PATH`.
5. Try to load plug-in and call that command in Maya.

## Write a simple dynamic library

In the first, build a empty c++ project in Visual Studio.

Set project to dynamic library :  
Property -> General -> Project Defaults -> Configuration Type -> `Dynamic Library (.dll)`

Set definition for `library export`
Property -> C/C++ -> Preprocessor -> Preprocessor Definitions -> `MYMATH_DLL_EXPORTS`

Write a header file `MyMath.h` below :

```cpp
#ifndef _MY_MATH_H
#define _MY_MATH_H

#ifdef __cplusplus
extern "C" {
#endif

#ifdef MY_MATH_EXPORTS
#define MYMATH_DLL_API __declspec(dllexport)
#else
#define MYMATH_DLL_API __declspec(dllimport)
#endif

MYMATH_DLL_API double add(double, double);
MYMATH_DLL_API double sub(double, double);

#ifdef __cplusplus
}
#endif

#endif /* MyMath.h */
```

Implement it `MyMath.cpp` below :

```cpp
#include "MyMath.h"

double add(double a, double b)
{
    return a + b;
}

double sub(double a, double b)
{
    return a - b;
}
```

Compile it. if success, copy `MyMath.dll` into `C:\bin` (There just for example, you should copy to you desired.)

## Add PATH in Maya.env

Open `Maya.env` in text editor, add a line such as below if you never added.

```
PATH = %PATH%;C:\bin
```

This could be let Maya know where can find out my custom libray.

## Write a Maya command

* Ohter line would be ignore in here, I just show `MPxCommand::doIt()` implements.

```cpp
// We must include windows api
#include <windows.h>

// MGlobal.h just we want to display result for test.
#include <maya/MGlobal.h>

// sstream standard library just for convert double to string.
#include <sstream>

// Define a pointer function alias
typedef double (*pf_MyMathAddFunc)(double, double);

// ... Your command implements here.

MStatus MyCommand::doIt(const MArgList & argList)
{
    MStatus stat = MS::kSuccess;
    HINSTANCE hLibrary = LoadLibrary(LPCTSTR("MyMath.dll"));
    if (hLibrary) {
        MGlobal::displayInfo("Load dynamic library successful : MyMath.dll");

        // Create a pointer function : double pf(double, double)
        pf_MyMathAddFunc pfAdd;

        // Use GetProcAddress to get add function in MyMat.dll.
        pfAdd = (pf_MyMathAddFunc)GetProcAddress(hLibrary, "add");

        // Check the function is found.
        if (pfAdd) {
            std::stringstream ss;
            ss << add(3.5, 6.8);
            MGlobal::displayInfo(MString(ss.str().c_str()));
        } else {
            MGlobal::displayError("Failed to get function add in MyMath.dll");
        }
    } else {
        MGlobal::displayError("Failed to load dynamic library : MyMath.dll");
    }
    return stat;
}
```

## Drill

### Head File

The head file need :

```cpp
#ifdef __cplusplus
extern "C" {
#endif

// Implement...

#ifdef __cplusplus
}
#endif
```

Because the C++ have `function overloading`, the function will get a special name when compile.  
But we want use original name from library, if __cplusplus is defined, we use `extern "C" {}`;  
Include all function declarations. Otherwise `GetProcAddress(HISTANCE, Name)` could'nt find out.

We can see lines below :

```cpp
#ifdef MY_MATH_EXPORTS
#define MYMATH_DLL_EXPORTS __declspec(dllexport)
#else
#define MYMATH_DLL_EXPORTS __declspec(dllimport)
#endif
```

And we need set definition `MY_MATH_EXPORTS` in this DLL project.  

Because we had `MY_MATH_EXPORTS` definition, The `MYMATH_DLL_EXPORTS` will be `__declspec(dllexport)`.  
That definition be able to export code from library.