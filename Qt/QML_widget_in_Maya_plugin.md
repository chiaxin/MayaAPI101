# QML widget in Maya Plugin

## *.pro additions

In *.pro

```qmake
QT += qml quick
DEFINES += QT_QML_LIB QT_QUICK_LIB
```

## How to launch QML Widget

Binding with custom Maya command

Including

```cpp
#include <QQuickView>
```

We have a simple qml file - test.qml

```qml
import QtQuick 2.0

Rectangle {
    width : 360
    height: 360
    Text {
        text : qsTr("Hello World")
        anchors.centerIn: parent
    }
    MouseArea {
        anchors.fill: parent
        onClicked : {
            Qt.quit();
        }
    }
}
```

In header file

```cpp
#include <maya/MSyntax.h>
#include <maya/MString.h>

class MyCustomCmd : public MPxCommand
{
public:
    // Implement...
    static MSyntax newSyntax();
    MStatus parseSyntax(const MArgList &);
private:
    static QPointer<QQuickView> qp_viewer;
    static MString qml_path;
};
```

In source file

```cpp
#include <maya/MArgDatabase.h>

QPointer<QQuickView> MyCustomCmd::qp_viewer;
MString MyCustomCmd::qml_path = "";

MSyntax MyCustomCmd::newSyntax()
{
    MStatus stat = MS::kSuccess;
    MSyntax syntax;
    syntax.addFlag("-qm", "-qmlPath", MSyntax::kString);
    return syntax;
}

MStatus MyCustomCmd::parseSyntax(const MArgList & argList)
{
    MStatus stat = MS::kSuccess;
    MArgDatabase parser(syntax(), argList);
    if (parser.isFlagSet("-qm")) {
        stat = parser.getFlagArgument("-qm", 0, qml_path);
    }
    return stat;
}

MStatus MyCustomCmd::doIt(const MArgList & argList)
{
    if (qp_viewer.isNull()) {
        qp_viewer = new QQuickView;
        qp_viewer->setSource(QUrl::fromLocalFile(QStringLiteral(qml_path)));
    }
}
```
