# Build Maya API with QT Environment in Visual Studio

We can use QMake to generate `vcxproj` (Visual Studio project configuration)

+ Visual Studio 2012
+ Maya 2017
+ QT 5.6.1 for May 2017

## Write *.pro and *.pri

In this example, we want to build a Maya plug-in called "mytool".

__mytool.pro__

```
# ----------------------------------------------------
# Generate Maya Plug-in with QT
# ----------------------------------------------------
MY_TARGET = mytool
TEMPLATE = lib
TARGET_EXT = .mll
QT += core widgets gui
DEPENDPATH += .
UI_DIR += ./GeneratedFiles
RCC_DIR += ./GeneratedFiles
QMAKE_INCDIR = $(QTDIR)/include
QMAKE_LIB = $(QTDIR)/lib
QMAKE_MOC = $(QTDIR)/bin/moc.exe
QMAKE_QMAKE = $(QTDIR)/bin/qmake.exe
win32 {
	MAYA_DIR = C:/Program Files/Autodesk/Maya2017
	MAYA_PLUGIN_PATH = D:\Maya\x64\2017\plug-ins
	QMAKE_LFLAGS = /export:initializePlugin /export:uninitializePlugin
	QMAKE_POST_LINK = xcopy /Y "$(TargetPath)" "$${MAYA_PLUGIN_PATH}"
	DEFINES += WIN64 QT_DLL QT_WIDGETS_LIB _WINDOWS _USRDLL NT_PLUGIN \
		_HAS_ITERATOR_DEBUGGING=0 _SECURE_SCL=0 _SECURE_SCL_THROWS=0 \
		_SECURE_SCL_DEPRECATE TBB_USE_DEBUG=0 _TBB_LIB_NAME=tbb.lib \
		REQUIRE_IOSTREAM AW_NEW_IOSTREAMS Bits64
	Release {
		TARGET = $${MY_TARGET}
		DESTDIR = output/Maya2017/windows/x64/release
		OBJECTS_DIR += release
		CONFIG += qt release plugin warn_on
		DEFINES += NDEBUG
		INCLUDEPATH += . \
			./GeneratedFiles \
			./GeneratedFiles/release \
			"$${MAYA_DIR}/include"
		MOC_DIR += ./GeneratedFiles/release
	}
	Debug {
		TARGET = $${MY_TARGET}
		DESTDIR = output/Maya2017/windows/x64/debug
		OBJECTS_DIR += debug
		CONFIG += qt debug plugin warn_on
		DEFINES += _DEBUG
		INCLUDEPATH += . \
			./GeneratedFiles \
			./GeneratedFiles/debug \
			"$${MAYA_DIR}/include"
		MOC_DIR += ./GeneratedFiles/debug
	}
}
LIBS += -L"$${MAYA_DIR}/lib" -lFoundation -lOpenMaya -lOpenMayaUI
include(mytool.pri)
```
+ The block win32 {} is for Windows platform.
+ MAYA_DIR : Define a variable that located the Maya install path.
  if your Maya install path is not in there, Just correct it.
+ MAYA_PLUGIN_PATH : 
+ TEMPLATE : `lib` because we want build a plug-in, it is a dynamic link library.
+ TARGET : Specifies project name.
+ DESTDIR : Specifies where to output the target file, This is could be change if you need.
+ QT : Specifies the Qt modules.
+ CONFIG : Specifies the QT configurations.
    + [QT config options](http://doc.qt.io/qt-5/qmake-variable-reference.html)
+ DEFINES : Specifie the QT definitions.
+ INCLUDEPATH : Specifies the #include directories which should be searched when compiling the project.
    + If the path containing spaces, must quote the path.
        + For example : __INCLUDEPATH += "C:/Program Files/Autodesk/Maya2017/include"__
+ LIBS : Specifies list of libraries to be linked into the project.
    + -L\<PATH> -l\<LIB>
        + If the path containing space, must quote the path.
            + For example : __LIBS += "C:/Program Files/Autodesk/Maya2017/lib/openmaya.lib"__
+ DEPENDPATH : Specifies a list of all directories to look in to resolve dependencies.
+ MOC_DIR : Specifies the directory where all intermediate moc files should be placed.
+ OBJECTS_DIR : Specifies the directory where all intermediate objects should be placed.
+ UI_DIR : Specifies the ui file directory.
+ RCC_DIR : Specifies the rcc file directory.
+ TARGET_EXT : Specifies the plug-in's extension, Maya plug-in is `.mll`.
+ QMAKE_LFLAGS : Specifies a general set of flags that are passed to the linker.  
 In Maya plug-in, /export:initializePlugin /export:uninitializePlugin are required.
+ `include()` is a pro file function, It could be include other config file.

__mytool.pri__

```
HEADERS += /<Your head files>
SOURCES += /<Your source files>
RESOURCES += /<Your resources>
```

+ HEADERS : Specifies all header files (*.h)
	+ Example : HEADERS += ./mytool.h
+ SOURCES : Specifies all source files (*.cpp)
	+ Example : SOURCES += ./mytool.cpp
+ RESOURCES : Specifies all resources files, such as *.qrc, *.qml...etc.

## Generate .vcxproj file from .pro by QMake

Open `command prompt`

Check out the environment %QTDIR% is located correct path.  
For example : "D:\Qt\Qt5.6.1\msvc2012"

```bat
echo %QTDIR%
```

Check out the qmake.exe is available.  
If qmake.exe is not found, make sure the QT bin folder is in the %PATH%.  
For example : "D:\Qt\Qt5.6.1\msvc2012\bin"

```bat
qmake -v
```

Try to generate vcxproj file.

```bat
qmake -tp vc "mytool.pro" -o "mytool.vcxproj"
```