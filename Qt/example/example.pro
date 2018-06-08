# ----------------------------------------------------
# Generate Maya Plug-in with QT
# ----------------------------------------------------
MY_TARGET = mytool
TEMPLATE = lib
TARGET_EXT = .mll
QT += core widgets gui
DEPENDPATH += .
UI_DIR += ./GeneratedFiles
RCC_DIR += ./GeneratedFiles
QMAKE_INCDIR = $(QTDIR)/include
QMAKE_LIB = $(QTDIR)/lib
QMAKE_MOC = $(QTDIR)/bin/moc.exe
QMAKE_QMAKE = $(QTDIR)/bin/qmake.exe
win32 {
	MAYA_DIR = C:/Program Files/Autodesk/Maya2017
	MAYA_PLUGIN_PATH = D:\Maya\x64\2017\plug-ins
	QMAKE_LFLAGS = /export:initializePlugin /export:uninitializePlugin
	QMAKE_POST_LINK = xcopy /Y "$(TargetPath)" "$${MAYA_PLUGIN_PATH}"
	DEFINES += WIN64 QT_DLL QT_WIDGETS_LIB _WINDOWS _USRDLL NT_PLUGIN \
		_HAS_ITERATOR_DEBUGGING=0 _SECURE_SCL=0 _SECURE_SCL_THROWS=0 \
		_SECURE_SCL_DEPRECATE TBB_USE_DEBUG=0 _TBB_LIB_NAME=tbb.lib \
		REQUIRE_IOSTREAM AW_NEW_IOSTREAMS Bits64
	Release {
		TARGET = $${MY_TARGET}
		DESTDIR = output/Maya2017/windows/x64/release
		OBJECTS_DIR += release
		CONFIG += qt release plugin warn_on
		DEFINES += NDEBUG
		INCLUDEPATH += . \
			./GeneratedFiles \
			./GeneratedFiles/release \
			"$${MAYA_DIR}/include"
		MOC_DIR += ./GeneratedFiles/release
	}
	Debug {
		TARGET = $${MY_TARGET}
		DESTDIR = output/Maya2017/windows/x64/debug
		OBJECTS_DIR += debug
		CONFIG += qt debug plugin warn_on
		DEFINES += _DEBUG
		INCLUDEPATH += . \
			./GeneratedFiles \
			./GeneratedFiles/debug \
			"$${MAYA_DIR}/include"
		MOC_DIR += ./GeneratedFiles/debug
	}
}
LIBS += -L"$${MAYA_DIR}/lib" -lFoundation -lOpenMaya -lOpenMayaUI
include(mytool.pri)