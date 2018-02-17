# Visual Studio Debugging in Maya CPP API

## Property Setup

Project -> Properties -> Configuration Properties -> Debugging

Switch `Debugger to launch` to `Remote Windows Debugger`</br>
Remote Command : __Your Maya application location__</br>
For example, _C:\Program Files\Autodesk\Maya2017\bin\maya.exe_

And `Attach` set to __Yes__

![vs cpp debugging setup](./images/cpp/vscpp_debugging_setup.png)

## Start Debugging

DEBUG -> Start Debugging</br>
Swith to `Remote Windwos Debugger`</br>
Or press \<F5> to start debugging

![vs cpp remote debugging](./images/cpp/vscpp_debugging_remote.png)

Before debugging, you must copy *.mll to the folder that Maya can be find.</br>
But if the plug-in has been loaded by Maya, Can not override it.</br>
So you have to __unload plug-in__ before copy.

![vs cpp debugging start](./images/cpp/vscpp_debugging_start.png)

## Debugging Attach

You can join `break point` (F9), if attach Maya successful, it should be red point.

![vs cpp debugging attach](./images/cpp/vscpp_debugging_attach_successful.png)

But if no attached, it will be white point.

![vs cpp debugging no attach](./images/cpp/vscpp_debugging_no_attach.png)

## Debug Step

Use `Step Into` \<F11> and `Step Over` \<F10> to step debugging</br>

![vs cpp debugging step](./images/cpp/vscpp_debugging_step.png)