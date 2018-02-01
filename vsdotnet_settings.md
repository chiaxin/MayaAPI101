# How to setup environment in Visual Studio for Maya .NET(C#) API

## Limits

+ Maya .NET SDK is available in 64-bit only
+ The version must upper than Maya 2013 Extension 2
+ .NET 4.5 Framework or .NET 4.0 Framework

## Recommended

+ Visual Studio 2012 with .NET 4.5 Framework

## Extension

+ Maya .NET API extension is .nll.dll

## Variables

+ $(MayaInstallationPath) : Your Maya installation directory
+ $(MayaPluginPath) : Your Maya plug-ins directory

## Project Settings

+ Start from C# Class Library</br>
  Other Languages -> Visual C# -> `Class Library`

  ![New Project](/images/dotnet/dotnet_new_project.png)

+ Solution Properties `(Alt + Enter)` -> Reference Paths -> add `$(MayaInstallationPath)/bin`

  ![Add New Reference Paths](/images/dotnet/add_new_reference_paths.png)

+ Solution Explorer -> References -> Add Reference</br>
  Extensions -> Check `openmayacs`

  ![openmayacs](/images/dotnet/openmayacs.png)

+ Solution Properties `(Alt + Enter)` -> Build Events -> Post-build event command line</br>
  -> copy /Y "$(TargetPath)" "$(MayaPluginPath)\$(TargetName).nll.dll"

## using `OpenMaya` at head

```csharp
using Autodesk.Maya.OpenMaya;
```