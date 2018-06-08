# QT Resource Collection File *.qrc

## Add Image

For example, we have a images called "myicon.png",  
put it into ./images/myicon.png.

Write a qrc file called "mytool.qrc"

```xml
<!DOCTYPE RCC><RCC version="1.0">
    <qresource prefix="/src">
        <file alias="icon.png">images/myicon.png</file>
    </qresource>
</RCC>
```

Add line into *.pro or *.pri file

```
RESOURCES = mytool.qrc
```

Re-build this project, you will find "Resource Files" filter in Solution Explorer

![resource collection](../images/Qt/resource_collection.png)

The RCC will auto generate qrc_*.cpp file

Example : Add image  
In this instance, I want add "./images/myicon.png".  
":/src/icon.png" is its alias. (specific it by *.qrc)

```cpp
QLabel * label = new QLabel;
label->setPixmap(QPixmap(":/src/icon.png"));
```

See details in [http://doc.qt.io/qt-5/resources.html](http://doc.qt.io/qt-5/resources.html)
