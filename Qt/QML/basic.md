# QML Basic

## Basic Syntax

```qml
import QtQuick 2.0

Rectangle {
    id: rect
    color: "white"
    width: 360; height: 240
}
```

Rectangle {} is a widget component, look like javaScript object.  
The `id: rect` is one of Rectangle's `attribute: value`

If there have multi attributes in one line, separate their by semi-colons.

`color: "white"` is a attribute of Rectangle also,   
The attribute is `color` and the value is `"white"`,  
the attribute's type is string (quote it by double-quote).

The width and height's attribute type is `integer`.

## Text

Use `Text` add a static text.  

```qml
import QtQuick 2.0

Rectangle {
    id: rect
    
    Text {
        id: label
        x: 120; y: 30
        text: "Pressed: " + numberOfPressMe + " time(s)"
        property int numberOfPressMe: 0
        focus: true
        Keys.onSpacePressed: {
            increment()
        }
        Keys.onEscapePressed: {
            numberOfPressMe = 0
        }
        function increment() {
            numberOfPressMe = numberOfPressMe + 1
        }
    }
}
```

We can see `Text {}` is in the `Rectangle`,  
so it will into the `Rectangle`. This is simple to layout them.

`property int numberOfPressMe: 0` is a way to define custom attribute,  
The syntax is `property \<Type> \<Name>: \<Value>`.  
Must add colon between the name and value.

`text: "Pressed: " + numberOfPressMe + " time(s)"`,
Not only define the text, but also make connection in `text` and `numberOfPressMe`.  
Now, if `numberOfPressMe` is update, the `text` will update also.

`Keys.onEscapePressed: {}` and `Key.onSpacePressed: {}`  
is a event when key pressed, `escape` and `space`.

`function increment() {}` is a way to define custom function.

## Image

```qml
Rectangle {
    id: rect

    Image {
        id: myicon
        x: (parent.width) - width/2; y: 40
        source: "../icons/image.png"
    }
}
```

Define a attribute could be use expression,  
the operand could from other object's attribute.
Such as the image's `x` that is a expression with rect (parent).  
`source: "..."` is a attribute to specific the image's path.