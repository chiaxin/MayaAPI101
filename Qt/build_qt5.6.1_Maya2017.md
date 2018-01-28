# How to build QT 5.6.1 for Maya 2017 (update 4) in Windows x64

## Reference

+ [around-the-corner](http://around-the-corner.typepad.com/adn/2016/09/how-to-build-customized-qt-561-for-maya-2017-on-windows.html)

## What are we need

+ Microsoft Visual Studio 2012 Update 4 or 5
+ Qt 5.6.1 source code modified for Maya 2017 (Update 4)
+ Qt vs add-in (1.2.5)
+ ActivePerl 5
+ Python 2.7
+ 7-zip
+ OpenSSL (1.0.1l)
+ ICU53_1

## Resources Download

+ [Visual Studio 2012](https://www.visualstudio.com/vs/)
+ [Qt vs addin 1.2.5](https://download.qt.io/official_releases/vsaddin/)
+ [Autodesk open source distribution](https://www.autodesk.com/company/legal-notices-trademarks/open-source-distribution)
download : Qt561ForMaya2017Update4.zip
+ [ActivePerl 5](https://www.activestate.com/activeperl/downloads)
+ [Python 2.7](https://www.python.org/downloads/release/python-2713/)
+ [7 zip](http://www.7-zip.org/)
+ [ICU_53_1 msvc 2012 64 devel](http://download.qt.io/development_releases/prebuilt/icu/prebuilt/msvc2012/)
download : icu\_53\_1\_msvc\_2012\_64\_devel.7z
+ [OpenSSL 1.0.1l](https://ftp.openssl.org/source/old/1.0.1/)

download : openssl-1.0.1l.tar.gz

## Required Folders

+ Create a QT folder example as `D:\Qt`
+ Create a folder example as `D:\Qt\Qt_5.6.1\msvc2012`
+ Create a install folder example as `D:\Qt\Qt\_5.6.1_install`
+ Uncompress `Qt561ForMaya2017Update4.zip` into install folder
+ Uncompress icu\_53\_1\_msvc\_2012\_64\_devel.7z into `D:\Qt\icu53_1`
+ Create a openssl folder example as `D:\Qt\openssl`
+ Uncompress openssl-1.0.1l.tar.gz into `D:\Qt\openssl_install`

## Compile openSSL

+ create debug and release folder in `D:\Qt\openssl`
+ From vs2012 start folder open `VS2012 x64 Native Tools Command Prompt`
+ Key CD/D `D:\Qt\openssl_isntall` go to that folder
+ Ready to build debug
+ Key

```batch
perl configure debug-VC-WIN64A --prefix D:\Qt\openssl\debug no-asm
```

+ Key

```batch
ms\do_win64a
```

+ Key

```batch
notepad ms\nt.mak to open nt.mak file
```

+ Find `APP_CFLAG=xxx` and `LIB\_CFLAG=xxx` remove right be `APP\_CFLAG=` and `LIB\_CFLAG=`
+ Find `LFLAGS=xxx` and remove `/debug` at tail
+ Save this file
+ Key 

```batch
nmake -f ms\nt.mak
```

+ Key

```batch
nmake -f ms\nt.mak install
```

+ Wait for compile done
+ Ready to build release
+ Key

```batch
perl configure VC-WIN64A --prefix=D:\Qt\openssl\release no-asm
```

+ Others same as debug

## Compile Qt

+ From vs2012 start folder open `VS2012 x64 Native Tools Command Prompt`
+ Key : CD/D D:\Qt\Qt\_5.6.1\_install\qt_adsk-5.6.1
+ Do configure :

```batch
configure^
 -icu^
 -opensource^
 -confirm-license^
 -debug-and-release^
 -platform win32-msvc2012^
 -force-debug-info^
 -opengl desktop^
 -directwrite^
 -openssl^
 -openssl-linked^
 -plugin-sql-sqlite^
 -prefix D:\Qt\Qt_5.6.1\msvc2012^
 -I D:\Qt\openssl\release\include^
 -I D:\Qt\icu53_1\include^
 -L D:\Qt\openssl\release\lib^
 -L D:\Qt\icu53_1\lib^
 -no-warnings-are-errors^
 -nomake examples^
 -nomake tests
```

+ Do nmake

```batch
nmake install
```

## Done
