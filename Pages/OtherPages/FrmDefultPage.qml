import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Flickable{
    Component.onCompleted: forceActiveFocus()
    contentHeight: parent.height + 1

    GridView {
        id: gridView
        anchors.fill: parent
        anchors.margins: 0
        model: listModel
        delegate: component
        cellHeight: width / 3
        cellWidth:  width / 3
        clip: true
    }

    ListModel{
        id: listModel
        ListElement{ title: "New Contact";    icon: "/Image/Drawer/new.svg";     objName: "newContact"    }
        ListElement{ title: "Delete Contact"; icon: "/Image/Drawer/delete.svg";  objName: "deleteContact" }
        ListElement{ title: "Contact List";   icon: "/Image/Drawer/list.svg";    objName: "courseList"    }
        ListElement{ title: "Search";         icon: "/Image/Drawer/search.svg";  objName: "search"        }
        ListElement{ title: "Exit";           icon: "/Image/Drawer/exit.svg";    objName: "exit"          }
    }

    Component {
        id: component

        Rectangle {
            id: myRec
            width: parent.width / 3
            height: parent.width / 3
            clip: true
            color: "transparent"

            Rectangle {
                width:  ( parent.width < 400 ) ? parent.width  - 10 : 130
                height: ( parent.width < 400 ) ? parent.height - 10 : 130
                radius: 10
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1
                border.color: "black"
                clip: true

                ColumnLayout{
                    width: parent.width
                    height: 40 + labelCategory.contentHeight
                    anchors.centerIn: parent
                    spacing: 5

                    Image {
                        id: myImage
                        source:icon; sourceSize: "40x40"
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Label {
                        id: labelCategory
                        text: title
                        color: "black"
                        Layout.preferredWidth: parent.width - 5
                        wrapMode: Text.Wrap
                        font: myStyle.iranSanceFontL
                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignHCenter
                    }
                }

                // Mouse area to react on click events
                MouseArea {
                    hoverEnabled: true
                    anchors.fill: parent
                    onExited:     myRec.scale = 1.0
                    onPressed:    myRec.scale = 1.05
                    onCanceled:   myRec.scale = 1.0
                    onClicked:
                        switch(objName) {
                        case "newContact":    stackView.push(newContact);            break
                        case "deleteContact": stackView.push(deleteContact);         break
                        case "courseList":    stackView.push(contactList);           break
                        case "search":        stackView.push(searchContact);         break
                        case "exit":          mainLoader.sourceComponent = frmLogin; break
                        }
                }
            }
        }
    }
}
