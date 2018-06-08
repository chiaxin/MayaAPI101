# Maya Module Pipeline

See details [Autodesk Maya Document](http://help.autodesk.com/view/MAYAUL/2017/ENU//?guid=__files_GUID_130A3F57_2A5D_4E56_B066_6B86F68EEA22_htm)

## Module Folder Structure

+ ./bin      : dynamic libraries or execute file.
+ ./devkit   : The sources that provide API to user.
+ ./docs     : Documents.
+ ./icons    : Images for Maya plug-ins or UI (user interface).
+ ./include  : All header file that provide interface to user.
+ ./lib      : The libraries files.
+ ./plug-ins : *.mll (Maya Plug-in).
+ ./presets  : Maya presets.
+ ./resources: Resources, Localization.
    + ./resources/I10n/ja_JP
    + ./resources/I10n/zh_CN
    + ./resources/I10m/en_US
+ ./scripts  : mel, python script, AETemplate scripts.
+ ./shaders  : shaders.

## mod file

The *.mod file could be tell Maya where are module's elements

In the first, start by + to specifies the

+ Maya Version
+ Operating System
    + PLATFORM:win64
    + PLATFORM:mac
    + PLATFORM:linux
+ Locale
    + LOCALE:en_UI
    + LOCALE:ja_JP
    + LOCALE:zh_CH

For example :

```txt
+ MAYAVERSION:2017 PLATFORM:win64 LOCALE:en_US mytool 1.0 C:\mytool
```

In this example, the "mytool" plug-in would only be loaded for Maya 2017,  
Windows x64, locale set to English.

The root directory is "C:\mytool"

### Add Subfolders

```txt
+ MAYAVERSION:2017 PLATFORM:win64 LOCALE:en_US mytool 1.0 C:\mytool
PATH+:= bin
[r] scripts: scripts
presets: presets
icons: icon
```

[r] Prefix is represent recursive subfolders.  
But if the folder is starting with ".", it will be ignored.

### Add Environment Variables

For example, if you want to set PYTHONPATH to C:\mytool\python

```txt
PYTHONPATH:=python
```

":=" will add prefix by plug-in path,  
For this instance, PYTHONPATH is C:\mytool\python

"=" will just add a environment variable without plug-in path.