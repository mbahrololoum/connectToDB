import QtQuick 2.9
import QtQuick.Controls.Material 2.2

Item {
    id: myBtn
    width : parent.width
    height: buttonHeight

    property alias  buttonText        : innerText.text;
    property int    buttonHeight      : 40
    property int    buttonBorderWide  : 0
    property int    buttonFontSize    : 16
    property int    buttonRadius      : 3
    property color  buttonBorderColor : "transparent"
    property var    buttonBackColor   : Material.color(Material.Orange)

    signal clicked

    //Rectangle to draw the button
    Rectangle {
        id: rectangleButton
        color: buttonBackColor
        anchors.fill: parent
        border.color: buttonBorderColor
        border.width: buttonBorderWide
        radius: buttonRadius

        Text {
            id: innerText
            font.pointSize: buttonFontSize
            anchors.centerIn: parent
            color: Material.foreground
            font { family: myStyle.iranSanceFontM; pixelSize: buttonFontSize; weight: Font.Normal }
            scale: state === "Pressed" ? 0.98 : 1.0
        }
    }

    states: [
        State { name: "Hovering"; PropertyChanges { target: innerText; font.pixelSize: buttonFontSize     } } ,
        State { name: "Pressed" ; PropertyChanges { target: innerText; font.pixelSize: buttonFontSize + 2 } }
    ]

    MouseArea {
        enabled: true
        hoverEnabled: true
        anchors.fill: myBtn
        onEntered : { myBtn.state="Hovering"                                         }
        onExited  : { myBtn.state=''                                                 }
        onClicked : { myBtn.clicked()                                                }
        onPressed : { myBtn.state="Pressed"                                          }
        onReleased: { if (containsMouse) myBtn.state="Hovering"; else myBtn.state="" }
    }
}
