import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

Drawer{
    id: drawer
    width:    0.66 * parent.width
    height:   parent.height
    onClosed: if(selectExit) mainLoader.sourceComponent = frmLogin

    property bool selectExit: false

    ColumnLayout{
        anchors.fill: parent
        spacing: 10

        Image{
            id: imgLogo
            sourceSize: "50x50"
            fillMode: Image.PreserveAspectFit
            source:  myStyle.imageLogo
            asynchronous: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
        }

        Rectangle{ anchors.top: imgLogo.bottom; anchors.topMargin: 5; Layout.preferredWidth: drawer.width; Layout.preferredHeight: 1; color: "white"; opacity: 0.2 }

        Label {
            id: lbNameFamily
            text: objProfile.nameFamily
            font { family: myStyle.iranSanceFontM; pixelSize: 16 }
            Layout.preferredWidth: contentWidth;   Layout.preferredHeight: 22
            anchors.left: parent.left;             anchors.leftMargin:   20
            anchors.top: imgLogo.bottom;           anchors.topMargin: 15
        }

        Rectangle{ anchors.top: lbNameFamily.bottom; anchors.topMargin: 5; Layout.preferredWidth: drawer.width; Layout.preferredHeight: 1; color: "white"; opacity: 0.2 }

        ListView{
            id: drawerListView
            anchors.top:    lbNameFamily.bottom
            anchors.bottom: parent.bottom
            anchors.right:  parent.right
            anchors.left:   parent.left
            anchors.margins: 20
            delegate: contactDelegate
            model:    contactModel
            clip: true
        }
    }

    ListModel{
        id:contactModel
        ListElement{ nameItem: "New Contact";    imgSource: "/Image/Drawer/new.svg";    source: "NewContact"    }
        ListElement{ nameItem: "Delete Contact"; imgSource: "/Image/Drawer/delete.svg"; source: "DeleteContact" }
        ListElement{ nameItem: "Contact List";   imgSource: "/Image/Drawer/list.svg";   source: "ContactList"   }
        ListElement{ nameItem: "Search";         imgSource: "/Image/Drawer/search.svg"; source: "Search"        }
        ListElement{ nameItem: "Exit";           imgSource: "/Image/Drawer/exit.svg";   source: "Exit"          }
    }

    Component{
        id: contactDelegate

        RowLayout {
            spacing: 10
            height: 40

            Image {
                source: imgSource
                sourceSize: "20x20"
                asynchronous: true
            }

            Label {
                text:  nameItem
                font { family: myStyle.iranSanceFontL; pixelSize: 13 }
                horizontalAlignment: Text.AlignLeft
                verticalAlignment:   Text.AlignVCenter
            }

            MouseArea {
                anchors.fill: parent
                onPressed:  parent.scale = 1.1
                onReleased: parent.scale = 1
                onClicked: {
                    if(source === "NewContact" )
                        stackView.push(newContact)
                    else if(source === "DeleteContact" )
                        stackView.push(deleteContact)
                    else if(source === "ContactList" )
                        stackView.push(contactList)
                    else if(source === "Search" )
                        stackView.push(searchContact)
                    else if(source === "Exit" )
                        selectExit = true

                    drawer.close();
                }
            }
        }
    }
}
