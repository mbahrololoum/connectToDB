import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ToolBar {

    RowLayout{
        anchors.fill: parent

        ToolButton {
            id: btnDrawer
            height: 70; width: 70
            anchors.left: parent.left
            contentItem: Image {
                fillMode: Image.Pad
                horizontalAlignment: Image.AlignHCenter
                verticalAlignment: Image.AlignVCenter
                source: stackView.depth === 1 ? myStyle.imageDrawer : myStyle.imageBack
                sourceSize: "22x22"
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
        }
    }
}

