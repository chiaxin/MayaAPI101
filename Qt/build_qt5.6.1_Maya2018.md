# How to build QT 5.6.1 for Maya 2018  (update 3) in Windows x64

## Reference

+ [around-the-corner](http://around-the-corner.typepad.com/adn/2016/09/how-to-build-customized-qt-561-for-maya-2017-on-windows.html)

## Required Resource

+ 7-zip
+ Microsoft Visual Studio 2012 Update 4 or 5
+ Qt 5.6.1 source code modified for Maya 2017 (Update 4)
+ Qt vs add-in 1.2.5
+ ActivePerl 5
+ Python 2.7
+ OpenSSL-1.0.1l
+ ICU53_1

## Resources Download

+ [Visual Studio 2012](https://www.visualstudio.com/vs/)
+ [Qt vs add-in 1.2.5](https://download.qt.io/official_releases/vsaddin/)
+ [Autodesk open source distribution](https://www.autodesk.com/company/legal-notices-trademarks/open-source-distribution)
  Maya-Qt5.6.1-2018.3.tar (Qt 5.6.1 modified for Maya 2018 Update 3)
+ [ActivePerl 5](https://www.activestate.com/activeperl/downloads)
+ [Python 2.7](https://www.python.org/downloads/release/python-2713/)
+ [7 zip](http://www.7-zip.org/)
+ [ICU_53_1 msvc 2012 x64](http://download.qt.io/development_releases/prebuilt/icu/prebuilt/msvc2012/)
  icu_53_1_msvc_2012_64_devel.7z
+ [OpenSSL 1.0.1l](https://ftp.openssl.org/source/old/1.0.1/)
  openssl-1.0.1l.tar.gz

## Required Folders

+ Create a QT folder example as `D:\Qt`
+ Create a folder example as `D:\Qt\Qt_5.6.1\Maya2017\msvc2012`
+ Create a install folder example as `D:\Qt\install\Qt_5.6.1\Maya2017\msvc2012`
+ Uncompress `Qt561ForMaya2017Update4.zip` into install folder
+ Uncompress `icu_53_1_msvc_2012_64_devel.7z` into `D:\Qt\icu53_1`
+ Create a openssl folder, example as `D:\Qt\openssl-1.0.1l`
+ Uncompress openssl-1.0.1l.tar.gz into `D:\Qt\install\openssl-1.0.1l`

## Compile OpenSSL

+ create debug and release folder into `D:\Qt\openssl-1.0.1l`  
  We have `D:\Qt\openssl-1.0.1l\release` and `D:\Qt\openssl-1.0.1l\debug`
+ Open command prompt - `VS2012 x64 Native Tools Command Prompt`.

We can execute that bat file to ensure we get correct environment.

```batch
"%PROGRAMFILESX86%\Microsoft Visual Studio 11.0\VC\vcvarsall.bat" x64
```

Go to openssl source code folder.

```batch
cd/d D:\Qt\install\openssl-1.0.1l
```

Compile debug source:

```batch
perl configure debug-VC-WIN64A --prefix D:\Qt\openssl-1.0.1l\debug no-asm
```

```batch
ms\do_win64a
```

```batch
nmake -f ms\nt.mak
```

```batch
nmake -f ms\nt.mak install
```

Compile release source:

```batch
perl configure VC-WIN64A --prefix=D:\Qt\openssl-1.0.1l\release no-asm
```

```batch
ms\do_win64a
```

```batch
nmake -f ms\nt.mak
```

```batch
nmake -f ms\nt.mak install
```

## Compile Qt Library

+ Open command prompt - `VS2012 x64 Native Tools Command Prompt`.

We can execute that bat file to ensure we get correct environment.

```batch
"%PROGRAMFILESX86%\Microsoft Visual Studio 11.0\VC\vcvarsall.bat" x64
```

Go to Qt's source code folder.

```batch
cd/d D:\Qt\install\Qt_5.6.1\Maya2017\msvc2012\src
```

```batch
configure^
 -icu^
 -opensource^
 -confirm-license^
 -debug-and-release^
 -platform win64-msvc2012^
 -force-debug-info^
 -opengl desktop^
 -directwrite^
 -openssl^
 -openssl-linked^
 -plugin-sql-sqlite^
 -prefix D:\Qt\Qt_5.6.1\msvc2012^
 -I D:\Qt\openssl-1.0.1l\release\include^
 -I D:\Qt\icu53_1\include^
 -L D:\Qt\openssl-1.0.1l\release\lib^
 -L D:\Qt\icu53_1\lib^
 -no-warnings-are-errors^
 -nomake examples^
 -nomake tests
```

```batch
nmake
```

```batch
nmake install
```
