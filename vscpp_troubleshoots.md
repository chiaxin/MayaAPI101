# Troubleshoots in Maya API compile use Visual Studio

## LNK2005: MApiVersion already defined in *.obj

+ Please check out the include <maya/MFnPlugin.h> must just in register cpp file.
 that have initializePlugin() and uninitializePlugin() functions,
 If MFnPlugin duplicated appear in other cpp file, It will occur this compile error.
