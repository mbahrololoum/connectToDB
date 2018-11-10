import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import QtQuick.Dialogs 1.3

import "../Component/Button" as MyButtonComponent

Item {
    Component.onCompleted: { connection.contactList(); opacityAnimation.start() }

    property bool    refreshBusy: false
    property string  selectItems: ""

    NumberAnimation { id: opacityAnimation;  target: itemsListview; properties: "opacity"; from: 0.0; to: 1.0; duration: 700 }

    MessageDialog   {
        id: messageDialog
        onYes: {
            if(!selectItems)
            {
                messageDialog.title = "Warning"
                messageDialog.text  = "Please Select Item List"
                messageDialog.standardButtons = StandardButton.Ok
                messageDialog.open()
            }
            else
            {
                connection.deleteContactList(selectItems.substring(0, selectItems.length-1))
                connection.contactList();
                selectItems = "";
            }
        }
    }

    ListView {
        id: itemsListview
        model: connection.modelContactList.listProperty
        delegate: delegateContent
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: btnDelete.top
        anchors.margins: 10
        spacing: 5
        cacheBuffer: 2000
        displayMarginBeginning: 400
        displayMarginEnd: 400
        ScrollIndicator.vertical: ScrollIndicator { }
        // highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
        focus: true
        opacity: 0
        clip: true

        onFlickStarted:{
            if (atYBeginning)
                if (contentY < -50 ){
                    refreshBusy = true
                    connection.contactList();
                }
        }

        header: BusyIndicator {
            id: busyIndicatorRefresh; width: 40
            height:  refreshBusy ? 40 : 0
            visible: refreshBusy
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    MyButtonComponent.CustomeButton {
        id: btnDelete
        buttonText: "Delete Contact"
        buttonBackColor: Material.color(Material.Red)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom; anchors.bottomMargin: 10
        onClicked: {
            messageDialog.title = "Question"
            messageDialog.text  = "Do you want delete contact?"
            messageDialog.standardButtons = StandardButton.Yes | StandardButton.No
            messageDialog.open()
        }
    }

    Timer{
        id: timer
        interval: 2000
        running: false
        onTriggered: { refreshBusy = false; running = false }
    }

    Component {
        id :delegateContent

        RowLayout{
            spacing: 10
            width: itemsListview.width
            Component.onCompleted: timer.running = true

            Image {
                fillMode: Image.PreserveAspectFit
                source: "/Image/profile/user-"+ lbPhoneNumber.text.substring(11,10) +".svg"
                sourceSize: "30x30"
            }

            CheckBox {
                id:checkBox
                Layout.preferredWidth: 20;
                Layout.alignment: Qt.AlignLeft
                onCheckStateChanged: checkBox.checked ? selectItems += "'"+ lbPhoneNumber.text + "'," : selectItems = selectItems.replace("'"+ lbPhoneNumber.text + "',", "")
            }

            Label {
                id: lbName
                Layout.alignment: Qt.AlignLeft
                text: family + " " + name
                Layout.preferredWidth: parent.width - 180
                elide: Text.ElideRight
                font { family: myStyle.iranSanceFontL; pixelSize: 12 }
            }

            Label {
                id: lbPhoneNumber
                Layout.alignment: Qt.AlignRight
                text: phoneNumber
                Layout.preferredWidth: 100
                font { family: myStyle.iranSanceFontL; pixelSize: 12 }
            }

            MouseArea{
                anchors.fill: parent
                onClicked: checkBox.checked = !checkBox.checked
            }
        }
    }
}
