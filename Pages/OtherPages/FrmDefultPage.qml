import QtQuick 2.10
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3


//top Image of Content
Flickable{
    id: categoryPage
    contentHeight: parent.height + 1

    GridView {
        id: tableView
        anchors.fill: parent
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 10

        model: categoryListModel
        delegate: categoryDelegate
        cellHeight: width / 3
        cellWidth: width / 3
        clip: true
        interactive: false
    }

    ListModel{
        id: categoryListModel
        ListElement{ title: "New Contact";    icon: "/Image/Drawer/new.svg";     objName: "newContact"    }
        ListElement{ title: "Delete Contact"; icon: "/Image/Drawer/delete.svg";  objName: "deleteContact" }
        ListElement{ title: "Contact List";   icon: "/Image/Drawer/list.svg";    objName: "courseList"    }
        ListElement{ title: "Search";         icon: "/Image/Drawer/search.svg";  objName: "search"        }
        ListElement{ title: "Exit";           icon: "/Image/Drawer/exit.svg";    objName: "exit"          }
    }

    Component {
        id: categoryDelegate

        Rectangle {
            id: myRec
            width: parent.width / 3
            height: parent.width / 3
            clip: true
            color: "transparent"

            Rectangle {
                width: ( categoryPage.width < 400 ) ? parent.width  - 10 : 130
                height: ( categoryPage.width < 400 ) ? parent.height - 10 : 130 //( categoryPage.height > categoryPage.width ) ?  parent.width - 15 : 85
                radius: 10
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                border.width: 1
                border.color: "black"
                clip: true

                ColumnLayout{
                    width: parent.width
                    height: 40+ labelCategory.contentHeight
                    anchors.centerIn: parent
                    spacing: 5

                    Image {
                        id: myImage
                        width: 40; height: 40
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
