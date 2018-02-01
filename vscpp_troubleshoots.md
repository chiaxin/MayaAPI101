# Troubleshoots in Maya API compile use Visual Studio

## LNK2005: MApiVersion already defined in *.obj

Please check out the including `<maya/MFnPlugin.h>` must in cpp file for register only.</br>
that have initializePlugin() and uninitializePlugin() functions,</br>
If MFnPlugin is duplicated in other cpp file, It will occur this compile error.
