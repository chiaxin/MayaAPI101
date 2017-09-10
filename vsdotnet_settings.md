# How to setup environment in Visual Studio for Maya .NET(C#) API

## Extension

+ Maya .NET API extension is .nll.dll

## Variablies

+ $(MayaInstallationPath) : Your Maya installation directory

+ $(MayaPluginPath) : Your Maya plug-ins directory

## Project Settings

+ Start from C# Class Library

  ![New Project](/images/dotnet/dotnet_new_project.png)

+ Application -> Output type : Class Library

+ Reference Paths -> add $(MayaInstallationPath)/bin

  ![openmayacs](/images/dotnet/openmayacs.png)

+ Build Events \ Post-build event command line -> copy /Y "$(TargetPath)" "$(MayaPluginPath)\$(TargetName).nll.dll"

## Reference

+ Extensions -> check openmayacs

## using at head

```csharp
using Autodesk.Maya.OpenMaya;
```