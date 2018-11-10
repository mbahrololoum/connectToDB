import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ToolBar {
    height: 55

    RowLayout{
        anchors.fill: parent

        ToolButton {
            id: btnDrawer
            height: 80; width: 80
            anchors.left: parent.left
            contentItem: Image {
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: stackView.depth === 1 ? myStyle.imageDrawer : myStyle.imageBack
                sourceSize: "25x25"
                asynchronous: true
            }
            onReleased: btnDrawer.scale = 1.0
            onPressed:  btnDrawer.scale = 0.9
            onClicked:  stackView.depth === 1 ? drawer.open() : stackView.pop()
        }

        Label{
            id: titleBar
            anchors.centerIn: parent
            text: title
            font { family: myStyle.iranSanceFontM; pixelSize: 14 }
        }
    }
}

