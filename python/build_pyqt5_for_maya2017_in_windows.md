# Build PyQt5 For Maya 2017 In Windows

## Reference Link

[around-the-corner](http://around-the-corner.typepad.com/adn/2017/06/how-to-build-pyqt5-for-autodesk-maya-2017-64bit.html)

## Download Resource

PyQt :</br>
[](http://www.riverbankcomputing.com/software/pyqt/download)

Version : 5.7 (PyQt5-gpl-5.7.tar.gz)

SIP :</br>
[](http://www.riverbankcomputing.com/software/sip/download)

Version : 4.18.1 (sip-4.18.1.tar.gz)

## Environment Setup Batch File

```batch
@echo off

set MAYAVERSION=2017
set ADSKQTVERSION=5.6.1
set SIPVERSION=4.18.1
set PYQTVERSION=5.7
set MAYADRIVE=m:
set BUILDDRIVE=v:

if exist %MAYADRIVE%\nul subst %MAYADRIVE% /d
subst %MAYADRIVE% "C:\Program Files\Autodesk\Maya%MAYAVERSION%"
set MAYA_LOCATION=%MAYADRIVE%

set MAYAPYQTBUILD=%~dp0
rem Removing trailing \
set MAYAPYQTBUILD=%MAYAPYQTBUILD:~0,-1%

if exist %BUILDDRIVE%\nul subst %BUILDDRIVE% /d
subst %BUILDDRIVE% "%MAYAPYQTBUILD%"

set SIPDIR=%BUILDDRIVE%\sip-%SIPVERSION%
set PYQTDIR=%BUILDDRIVE%\PyQt5_gpl-%PYQTVERSION%
rem set ADSKQTDIR=%BUILDDRIVE%\qt-%ADSKQTVERSION%
set QTDIR=%MAYA_LOCATION%

set PATH=%QTDIR%\bin;%PATH%
set MSVC_VERSION=2012
set MSVC_DIR=C:\Program Files (x86)\Microsoft Visual Studio 11.0
set QMAKESPEC=%QTDIR%\mkspecs\win32-msvc%MSVC_VERSION%
set _QMAKESPEC_=win32-msvc%MSVC_VERSION%

if ["%LIBPATH%"]==[""] call "%MSVC_DIR%\VC\vcvarsall" amd64

set INCLUDE=%INCLUDE%;%MAYA_LOCATION%\include\python2.7
set LIB=%LIB%;%MAYA_LOCATION%\lib
```

## Build SIP

build-sip-maya2017.bat

```batch
@echo off
set XXX=%~dp0
if ["%MAYAPYQTBUILD%"]==[""] call "%XXX%setup.bat"

pushd %SIPDIR%
rem "%MAYA_LOCATION%\bin\mayapy" configure-ng.py --spec %_QMAKESPEC_%
"%MAYA_LOCATION%\bin\mayapy" configure.py
nmake
nmake install
popd
```

## Build PyQt

build-pyqt5-maya2017.bat

```bat
@echo off
set XXX=%~dp0
if ["%MAYAPYQTBUILD%"]==[""] call "%XXX%setup.bat"

set QMAKESPEC=%QTDIR%\mkspecs\%_QMAKESPEC_%
if not exist "%QMAKESPEC%\qmake.conf" (
    echo "You need to uncompress %MAYA_LOCATION%\mkspecs\qt-5.6.1-mkspecs.tar.gz !"
    goto end
)
if not exist "%MAYA_LOCATION%\include\Qt\QtCore\qdir.h" (
    echo "You need to uncompress %MAYA_LOCATION%\include\qt-5.6.1-include.tar.gz in %MAYA_LOCATION%\include\Qt !"
    goto end
)
findstr /L /C:"Headers=include/Qt" "%MAYA_LOCATION%\bin\qt.conf" >nul 2>&1
if ERRORLEVEL 1 (
    echo "You need to edit %MAYA_LOCATION%\bin\qt.conf to use 'Headers=include/Qt'"
    goto end
)
findstr /L /C:"-lqtmain -lshell32" "%QTDIR%\mkspecs\common\msvc-desktop.conf" >nul 2>&1
if ERRORLEVEL 1 (
    echo "You need to edit %QTDIR%\mkspecs\common\msvc-desktop.conf to use 'QMAKE_LIBS_QT_ENTRY     = -lqtmain -lshell32'"
    goto end
)
if not exist "%MAYA_LOCATION%\include\Qt\qtnfc.disabled" (
    echo "You need to rename %MAYA_LOCATION%\include\Qt\qtnfc to %MAYA_LOCATION\include\Qt\qtnfc.disabled"
    goto end
)
    
pushd %PYQTDIR%

"%MAYA_LOCATION%\bin\mayapy" configure.py --spec %QMAKESPEC% LIBDIR_QT="%QTDIR%\lib" INCDIR_QT="%QTDIR%\include\Qt" MOC="%QTDIR%\bin\moc.exe" --sip="%QTDIR%\Python\sip.exe" --sip-incdir="%QTDIR%\Python\include" -w --no-designer-plugin
nmake
nmake install
popd

:end
```

## Before Build

+ C:\Program Files\Autodesk\Maya2017\include\Qt\qtnfc rename to `qtnfc.disabled`
+ In C:\Program Files\Autodesk\Maya2017\include\Qt\qt.conf</br>
  Backup and correct it.

```txt
[Paths]
Prefix=$(MAYA_LOCATION)
Libraries=lib
Binaries=bin
Headers=include/Qt
Data=.
Plugins=qt-plugins
Translations=qt-translations
Qml2Imports=qml
```