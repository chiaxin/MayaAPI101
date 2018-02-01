# Build Maya Module Pipeline

## Module Folder Structure

+ /bin      : dll(dynamic libraries) or exe(execute file)
+ /devkit   : All any source that provide API to user
+ /docs     : Documents
+ /icons    : Images for Maya plug-ins or UI (user interface)
+ /include  : All header file that provide interface to user
+ /lib      : All lib(libraries) file
+ /plug-ins : mll (Maya Plug-in)
+ /presets  : Maya presets
+ /resources: Resources
+ /scripts  : All mel or python scripts, include AETemplate file

## mod file

### The *.mod file could be tell Maya where are module's elements

```txt
+ LOCALE:en_US <plugin-name> <version> <location>
```