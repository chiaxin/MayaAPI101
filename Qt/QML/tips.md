# Abuot QML Tips

## How to place QQuickViewer inot QMainWindow

Use __QWidget::createWindowContainer()__

```cpp
void MainWindow::initUI()
{
    QQuickViewer * viewer = new QQuickViewer;
    viewer->setMainQmlFile(QStringLiteral("main.qml"));
    createWindowContainer(viewer, this);
}
```