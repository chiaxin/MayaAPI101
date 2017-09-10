# How to setup environment in Visual Studio for Maya C++ API

## Variablies Definition

+ $(MayaInstallationPath) : Your Maya installation directory

+ $(MayaPluginPath) : Your Maya plug-ins directory

## Configuration

## Release

### General in Release

+ Configuration Type : Dynamic Library

+ Target Ext : .mll

### C/C++ in Release

+ General -> Additional Include Directories : $(MayaInstallationPath)\include

+ General -> DebugInformationFormat : ProgramDatabase (/Zi)

+ General -> Warning Level : Level3 (/W3)

+ Optimization -> Optimization : Maximize Speed (/O2)

+ Preprocessor -> PreprocessorDefinitions (add below)

  + NDEBUG WIN32 \_WINDOWS \_USRDLL NT_PLUGIN \_HAS_ITERATOR_DEBUGGING=0 \_SECURE_SCL=0  \_SECURE_SCL_THROWS=0  \_SECURE_SCL_DEPRECATE=0  \_CRT_SECURE_NO_DEPRECATE  TBB_USE_DEBUG=0  \_\_TBB_LIB_NAME=tbb.lib REQUIRE_IOSTREAM AW_NEW_IOSTREAMS Bits64_

+ Code Generation -> RuntimeLibrary : Multi-threaded DLL (/MD)

+ Code Generation -> Enable String Pooling : True

### Linker in Release

+ General -> Additional Library Directories : $(MayaInstallationPath)\lib

+ Input -> Additional Dependencies (add below)

  + Foundation.lib<br>OpenMaya.lib<br>(optional) OpenMayaAnim.lib<br>(optional) OpenMayaFX.lib<br>(optional) OpenMayaRender.lib<br>(optional) OpenMayaUI.lib

+ Advanced -> Randomized Base Address : No (/DYNAMICBASE:NO)

+ Command Line -> Additional Options : /export:initializePlugin /export:uninitializePlugin

---

## Debug

### General in Debug

+ Configuration Type : DynamicLibrary

+ Target Ext : .mll

### C/C++ in Debug

+ General -> Additional Include Directories : $(MayaInstallationPath)\include

+ General -> DebugInformationFormat : ProgramDatabase (/Zi)

+ General -> Warning Level : Level3 (/W3)

+ Optimization -> Optimization : Disabled (/Od)

+ Preprocessor -> PreprocessorDefinitions (add below)

  + \_DEBUG<br>WIN32<br>\_WINDOWS<br>\_USRDLL<br>NT_PLUGIN<br>\_HAS_ITERATOR_DEBUGGING=0  \_SECURE_SCL=0<br>\_SECURE_SCL_THROWS=0<br>\_SECURE_SCL_DEPRECATE=0<br>\_CRT_SECURE_NO_DEPRECATE  TBB_USE_DEBUG=0<br>\_\_TBB_LIB_NAME=tbb.lib<br>REQUIRE_IOSTREAM<br>AW_NEW_IOSTREAMS<br>Bits64_

+ Code Generation -> RuntimeLibrary : Multi-threaded Debug DLL (/MDd)

+ Code Generation -> Enable String Pooling : True

### Linker in Debug

+ General -> Additional Library Directories : $(MayaInstallationPath)\lib

+ Input -> Additional Dependencies (add below)

  + Foundation.lib<br>OpenMaya.lib<br>(optional) OpenMayaAnim.lib<br>(optional) OpenMayaFX.lib<br>(optional) OpenMayaRender.lib<br>(optional) OpenMayaUI.lib

+ Advanced -> Randomized Base Address : No (/DYNAMICBASE:NO)

+ Command Line -> Additional Options : /export:initializePlugin /export:uninitializePlugin

---

## Additional (Helper)

### Copy .mll file to your plug-in folder after build.

+ Build Events -> Post-Build Eevnt : xcopy /Y "$(TargetPath)" "$(MayaPluginPath)"
