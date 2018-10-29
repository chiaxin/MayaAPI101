# QT Troubleshoots

## 1. Debug

### 1-1. Maya say "unable to dynamically load" if compile debug plug-in file

+ Because "bin" of the Maya install directory not have Qt debug version yet.  
  so you need copy debug Qt dll into there, such as "Qt5Guid.dll", "Qt5Cored.dll" or "Qt5Widgets.dll"  
  or any you want to load modules.

### 1-2. When run debug with Maya (Attach), no OpenMaya.pdb warning will break debugging

+ Please install visual studio extension called : `Disable No Source Available Tab`,  
  It could be ignore Maya's pdb if it not found.

## 2. Compile

2-1. Building Qt in Visual Studio 2012 failed, it say about x86 and x64 incompatible

+ Call `C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\vcvarsall.bat` before.  
  Make sure you have correct environment variables and try it again.