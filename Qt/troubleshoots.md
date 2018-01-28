# Trobleshoots

## 1. Debug

### 1-1. Maya say "unable to dynamically load" if compile debug plug-in file

+ Because "bin" of the Maya install directory not have Qt debug version yet.</br>
 so you need copy debug Qt dll into there, such as "Qt5Guid.dll", "Qt5Cored.dll" or "Qt5Widgets.dll"</br>
 or any you want to load modules.

### 1-2. When run debug with Maya (Attach), no OpenMaya.pdb warning will break debugging

+ Please install visual studio extension called : Disable No Source Available Tab,</br>
 It could be ignore Maya's pdb if it not found.