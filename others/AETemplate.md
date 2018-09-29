# AETemplate

The AETemplate Mel file is a special script file for UI in attribute editor

## Naming Rules

You have to provide below two files :

+ AE\<node-name>Template.mel
+ AE\<node-name>Template.res.mel

## AE\<node-name>Template

There need a proc called `AE<node-name>Template(string $nodeName)`

`editorTemplate` is a command for control attribute editor ui.

editorTemplate -beginScrollLayout;</br>
editorTemplate -endScrollLayout;

```mel
global proc AEcustomNodeTemplate(string $nodeName)
{
    // Do something...
}
```