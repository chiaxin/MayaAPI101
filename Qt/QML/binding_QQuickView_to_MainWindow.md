# Binding QQuickView to MainWindow

```cpp

// In the MainWindow
QQuickVeiw ptr_view = new QQuickVeiw;
QString qml_path = "D:\\Temp\\dialog.qml";
ptr_view->setSource(
    QUrl::fromLocalFile(
        QUrl::fromLocalFile(qml_path)
    )
);
QWidget * container = QWidget::createWindowContainer(ptr_view, this);
```