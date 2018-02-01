# How to setup environment in Visual Studio for Maya C++ API

## Visual Studio Suggestion

Visual Studio 2012 update 5

## Variable Definition

+ $(MayaInstallationPath) : Your Maya installation directory
+ $(MayaPluginPath) : Your Maya plug-ins directory

## Configuration

### [Release]

#### General in Release

+ Configuration Properties -> Project Defaults -> Configuration Type -> `Dynamic Library`
+ Configuration Properties -> General -> Target Extension -> `.mll`

#### C/C++ in Release

+ Configuration Properties -> C/C++ -> General -> Additional Include Directories -> [$(MayaInstallationPath)\include](https://msdn.microsoft.com/en-us/library/hhzbb5c8(v=vs.110).aspx)
+ Configuration Properties -> C/C++ -> General -> Debug Information Format -> [ProgramDatabase (/Zi)](https://msdn.microsoft.com/en-us/library/958x11bc(v=vs.110).aspx)
+ Configuration Properties -> C/C++ -> General -> Warning Level -> [Level3 (/W3)](https://msdn.microsoft.com/en-us/library/thxezb7y(v=vs.110).aspx)
+ Configuration Properties -> C/C++ -> Optimization -> Optimization -> [Maximize Speed (/O2)](https://msdn.microsoft.com/en-us/us-en/library/8f8h5cxt(v=vs.110).aspx)
+ Configuration Properties -> Preprocessor -> Preprocessor Definitions -> [(Fill below)](https://msdn.microsoft.com/en-us/library/hhzbb5c8(v=vs.110).aspx)

NDEBUG</br>
WIN32</br>
\_WINDOWS</br>
\_USRDLL</br>
NT\_PLUGIN</br>
\_HAS\_ITERATOR\_DEBUGGING=0</br>
\_SECURE\_SCL=0</br>
\_SECURE\_SCL\_THROWS=0</br>
\_SECURE\_SCL\_DEPRECATE=0</br>
\_CRT\_SECURE\_NO\_DEPRECATE</br>
TBB\_USE\_DEBUG=0</br>
\_\_TBB\_LIB_NAME=tbb.lib</br>
REQUIRE\_IOSTREAM</br>
AW\_NEW\_IOSTREAMS</br>
Bits64\_

+ Configuration Properties -> C/C++ -> Code Generation -> Runtime Library -> [Multi-threaded DLL (/MD)](https://msdn.microsoft.com/en-us/library/2kzt1wy3(v=vs.110).aspx)
+ Configuration Properties -> C/C++ -> Code Generation -> Enable String Pooling -> [True](https://msdn.microsoft.com/en-us/library/s0s0asdt(v=vs.110).aspx)

#### Linker in Release

+ Configuration Properties -> Linker -> General -> Additional Library Directories -> [$(MayaInstallationPath)\lib](https://msdn.microsoft.com/en-us/library/ee855621(v=vs.110).aspx)
+ Configuration Properties -> Linker -> Input -> Additional Dependencies -> [(Fill below)](https://msdn.microsoft.com/en-us/library/1xhzskbe(v=vs.110).aspx)

Foundation.lib</br>
OpenMaya.lib</br>
OpenMayaAnim.lib `(optional)`</br>
OpenMayaFX.lib `(optional)`</br>
OpenMayaRender.lib `(optional)`</br>
OpenMayaUI.lib `(optional)`

+ Configuration Properties -> Linker -> Advanced -> Randomized Base Address -> [No (/DYNAMICBASE:NO)](https://msdn.microsoft.com/en-us/library/bb384887(v=vs.110).aspx)
+ Command Line -> Additional Options -> `/export:initializePlugin /export:uninitializePlugin`

---

### [Debug]

#### General in Debug

+ Configuration Properties -> Project Defaults -> Configuration Type -> `Dynamic Library`
+ Configuration Properties -> General -> Target Extension -> `.mll`

#### C/C++ in Debug

+ Configuration Properties -> C/C++ -> General -> Additional Include Directories -> [$(MayaInstallationPath)\include](https://msdn.microsoft.com/en-us/library/hhzbb5c8(v=vs.110).aspx)
+ Configuration Properties -> C/C++ -> General -> Debug Information Format -> [ProgramDatabase (/Zi)](https://msdn.microsoft.com/en-us/library/958x11bc(v=vs.110).aspx)
+ Configuration Properties -> C/C++ -> General -> Warning Level -> [Level3 (/W3)](https://msdn.microsoft.com/en-us/library/thxezb7y(v=vs.110).aspx)
+ Configuration Properties -> C/C++ -> Optimization -> Optimization -> [Disabled (/Od)](https://msdn.microsoft.com/en-us/us-en/library/8f8h5cxt(v=vs.110).aspx)
+ Configuration Properties -> Preprocessor -> Preprocessor Definitions -> [(Fill below)](https://msdn.microsoft.com/en-us/library/hhzbb5c8(v=vs.110).aspx)

\_DEBUG</br>
WIN32</br>
\_WINDOWS</br>
\_USRDLL</br>
NT\_PLUGIN</br>
\_HAS\_ITERATOR\_DEBUGGING=0</br>
\_SECURE\_SCL=0</br>
\_SECURE\_SCL\_THROWS=0</br>
\_SECURE\_SCL\_DEPRECATE=0</br>
\_CRT\_SECURE\_NO\_DEPRECATE</br> TBB\_USE\_DEBUG=0</br>
\_\_TBB\_LIB\_NAME=tbb.lib</br>
REQUIRE\_IOSTREAM</br>
AW\_NEW\_IOSTREAMS</br>
Bits64\_

+ Configuration Properties -> C/C++ -> Code Generation -> Runtime Library -> [Multi-threaded Debug DLL (/MDd)](https://msdn.microsoft.com/en-us/library/2kzt1wy3(v=vs.110).aspx)
+ Configuration Properties -> C/C++ -> Code Generation -> Enable String Pooling -> [True](https://msdn.microsoft.com/en-us/library/s0s0asdt(v=vs.110).aspx)

#### Linker in Debug

+ Configuration Properties -> Linker -> General -> Additional Library Directories -> [$(MayaInstallationPath)\lib](https://msdn.microsoft.com/en-us/library/ee855621(v=vs.110).aspx)
+ Configuration Properties -> Linker -> Input -> Additional Dependencies -> [(Fill below)](https://msdn.microsoft.com/en-us/library/1xhzskbe(v=vs.110).aspx)

Foundation.lib</br>
OpenMaya.lib</br>
OpenMayaAnim.lib `(optional)`</br>
OpenMayaFX.lib `(optional)`</br>
OpenMayaRender.lib `(optional)`</br>
OpenMayaUI.lib `(optional)`

+ Configuration Properties -> Linker -> Advanced -> Randomized Base Address -> [No (/DYNAMICBASE:NO)](https://msdn.microsoft.com/en-us/library/bb384887(v=vs.110).aspx)
+ Command Line -> Additional Options -> `/export:initializePlugin /export:uninitializePlugin`

---

### Additional (Helper)

#### Copy .mll file to your plug-in folder after build

+ Configuration Properties -> Build Events -> Post-Build Event -> `xcopy /Y "$(TargetPath)" "$(MayaPluginPath)"`
