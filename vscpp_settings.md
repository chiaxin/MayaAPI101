# How to setup environment in Visual Studio for Maya API

## Variablies Definition

+ $(MayaInstallationPath) : Your Maya installation directory

+ $(MayaPluginPath) : Your Maya plug-ins directory

## Configuration

## Release

#### General in Release

+ Configuration Type : DynamicLibrary

+ Target Ext : .mll

#### C/C++ in Release

+ General -> Additional Include Directories : $(MayaInstallationPath)\include

+ General -> DebugInformationFormat : ProgramDatabase (/Zi)

+ General -> Warning Level : Level3 (/W3)

+ Optimization -> Optimization : Maximize Speed (/O2)

+ Preprocessor -> PreprocessorDefinitions 

>NDEBUG  
WIN32  
\_WINDOWS  
\_USRDLL  
NT_PLUGIN  
\_HAS_ITERATOR_DEBUGGING=0  
\_SECURE_SCL=0  
\_SECURE_SCL_THROWS=0  
\_SECURE_SCL_DEPRECATE=0  
\_CRT_SECURE_NO_DEPRECATE  
TBB_USE_DEBUG=0  
\_\_TBB_LIB_NAME=tbb.lib  
REQUIRE_IOSTREAM  
AW_NEW_IOSTREAMS  
Bits64_  

+ Code Generation -> RuntimeLibrary : Multi-threaded DLL (/MD)

+ Code Generation -> Enable String Pooling : True

#### Linker in Release

+ General -> Additional Library Directories : $(MayaInstallationPath)\lib

+ Input -> Additional Dependencies :

>Foundation.lib  
OpenMaya.lib  
(optional)OpenMayaAnim.lib  
(optional)OpenMayaFX.lib  
(optional)OpenMayaRender.lib  
(optional)OpenMayaUI.lib  

+ Advanced -> Randomized Base Address : No (/DYNAMICBASE:NO)

+ Command Line -> Additional Options : /export:initializePlugin /export:uninitializePlugin

---

## Debug

#### General in Debug

+ Configuration Type : DynamicLibrary

+ Target Ext : .mll

#### C/C++ in Debug

+ General -> Additional Include Directories : $(MayaInstallationPath)\include

+ General -> DebugInformationFormat : ProgramDatabase (/Zi)

+ General -> Warning Level : Level3 (/W3)

+ Optimization -> Optimization : Disabled (/Od)

+ Preprocessor -> PreprocessorDefinitions  

>\_DEBUG  
WIN32  
\_WINDOWS  
\_USRDLL  
NT_PLUGIN  
\_HAS_ITERATOR_DEBUGGING=0  
\_SECURE_SCL=0  
\_SECURE_SCL_THROWS=0  
\_SECURE_SCL_DEPRECATE=0  
\_CRT_SECURE_NO_DEPRECATE  
TBB_USE_DEBUG=0  
\_\_TBB_LIB_NAME=tbb.lib  
REQUIRE_IOSTREAM  
AW_NEW_IOSTREAMS  
Bits64_  

+ Code Generation -> RuntimeLibrary : Multi-threaded Debug DLL (/MDd)

+ Code Generation -> Enable String Pooling : True

#### Linker in Debug

+ General -> Additional Library Directories : $(MayaInstallationPath)\lib

+ Input -> Additional Dependencies :  

> Foundation.lib  
OpenMaya.lib  
(optional)OpenMayaAnim.lib  
(optional)OpenMayaFX.lib  
(optional)OpenMayaRender.lib  
(optional)OpenMayaUI.lib  

+ Advanced -> Randomized Base Address : No (/DYNAMICBASE:NO)

+ Command Line -> Additional Options : /export:initializePlugin /export:uninitializePlugin

---

### Additional

#### Copy .mll file to your folder

+ Build Events -> Post-Build Eevnt : xcopy /Y "$(TargetPath)" "$(MayaPluginPath)"
