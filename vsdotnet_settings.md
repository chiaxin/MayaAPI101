# How to setup environment in Visual Studio for Maya .NET(C#) API

## Extension

+ Maya .NET API is .nll.dll

## Variablies

+ $(MayaInstallationPath) : Your Maya installation directory

+ $(MayaPluginPath) : Your Maya plug-ins directory

## Properties

+ Application -> Output type : Class Library

+ Build Events \ Post-build event command line -> copy /Y "$(TargetPath)" "$(MayaPluginPath)\$(TargetName).nll.dll"

+ Reference Paths -> add $(MayaInstallationPath)/bin

## Reference

+ Extensions -> check openmayacs

## using

```csharp

using Autodesk.Maya.OpenMaya

```

## Start New Project

![New Project](images\dotnet\dotnet_new_project.png)

## Add Maya API Reference

![openmayacs](images\dotnet\openmayacs.png)