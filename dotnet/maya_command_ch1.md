# Maya Command Chapter 1

## Commands

[assembly: MPxCommandClass(typeof(MPxCommandDerivedClass), "CommandName")]

+ MPxCommandClass : This attribute ensures that the command class is registered in Maya.
+ MPxCommandDerivedClass : The name of your C# class that derives from MPxCommand,</br>
  You need to specify the full path, including the class namespace.
+ CommandName : The name of the command as it appears in Maya's script editor.
+ Example :

```csharp
[assembly: MPxCommandClass(typeof(MayaNetTest.WhatIsCmd), "netWhatIs")]

namespace MayaNetTest
{
    public class WhatIsCmd : MPxCommand, IMPxCommand
    {
        override public void doIt(MArgList args)
        {
            //...
        }
    }
}
```

## Command arguments

[MPxCommandSyntaxArg(typeof(ArgType))]

+ MPxCommandSyntaxArg : This attribute ensures that this argument is added to the syntax.
+ ArgType : The type of the argument (for example : System.String)
+ Example :

```csharp
[MpxCommandSyntaxArg(typeof(System.String))] // a string argument
[MPxCommandSyntaxArg(typeof(System.Int32))] // a integer argument
```