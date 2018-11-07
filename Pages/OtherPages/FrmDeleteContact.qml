import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

import "../Componnet/Button" as MyButtonComponnent

Item {

    Component.onCompleted: searchClmOpacity.start()

    NumberAnimation { id: showContactClmOpacity;   target: showContactClm; properties: "opacity"; from: 0.0; to: 1.0; duration: 700 }
    NumberAnimation { id: hiddenContactClmOpacity; target: showContactClm; properties: "opacity"; from: 1.0; to: 0.0; duration: 700 }

    NumberAnimation { id: showCheckBtnOpacity;     target: checkBtn;       properties: "opacity"; from: 0.0; to: 1.0; duration: 700 }
    NumberAnimation { id: hiddencheckBtnOpacity;   target: checkBtn;       properties: "opacity"; from: 1.0; to: 0.0; duration: 700 }

    NumberAnimation { id: searchClmOpacity;        target: searchClm;      properties: "opacity"; from: 0.0; to: 1.0; duration: 700 }

    Flickable {
        id: searchClm
        anchors.fill: parent
        contentHeight: parent.height + 10
        opacity: 0

        ColumnLayout{
            anchors.centerIn: parent
            spacing: 15

            Label {
                id: titleWelcom
                text: "Delete Contact"
                font { family: myStyle.iranSanceFontL; pixelSize: 20 }
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                text: "Please insert mobile  number for\ndelete contact."
                font { family: myStyle.iranSanceFontL; pixelSize: 14 }
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignLeft
            }

            TextField {
                id: phoneNumberTxt
                placeholderText: qsTr("Phone Number")
                font { family: myStyle.iranSanceFontL; pixelSize: 14 }
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.preferredWidth: controlWidth
                height: 45
                horizontalAlignment: Text.AlignLeft
                validator: RegExpValidator { regExp: /(^(09)[0-9]{9}\\d$)/ }
                inputMethodHints: Qt.ImhDialableCharactersOnly
                focus: true
            }

            MyButtonComponnent.CustomeButton {
                id: checkBtn
                buttonText: "Check Contact"
                enabled: true
                buttonFontSize: 14
                anchors.horizontalCenter: parent.horizontalCenter
                width: controlWidth
                buttonHeight: 35
                onClicked: {
                    if(phoneNumberTxt.text.length !== 11)
                    {
                        messageDialog.title = "Error"
                        messageDialog.text  = "Please enter mobile number."
                        messageDialog.open()
                        return
                    }
                    if(connection.checkContact(phoneNumberTxt.text))
                    {
                        nameTxt.text = objProfile.name
                        familyTxt.text = objProfile.family
                        favirotySw.checked = objProfile.favority

                        objProfile.gender === "Male" ? maleRadio.checked = true : femaleRadio.checked = true

                        showContactClmOpacity.start()
                        hiddencheckBtnOpacity.start()
                    }
                    else
                    {
                        messageDialog.title = "Error"
                        messageDialog.text  = "Contact could not exist"
                        messageDialog.open()
                    }
                }
            }

            ColumnLayout{
                id: showContactClm
                spacing: 15
                opacity: 0

                TextField {
                    id: nameTxt
                    placeholderText: qsTr("Name")
                    font { family: myStyle.iranSanceFontL; pixelSize: 14 }
                    anchors.horizontalCenter: parent.horizontalCenter
                    Layout.preferredWidth: controlWidth
                    height: 45
                    horizontalAlignment: Text.AlignLeft
                    focus: true
                }

                TextField {
                    id: familyTxt
                    placeholderText: qsTr("Family")
                    font { family: myStyle.iranSanceFontL; pixelSize: 14 }
                    anchors.horizontalCenter: parent.horizontalCenter
                    Layout.preferredWidth: controlWidth
                    height: 45
                    horizontalAlignment: Text.AlignLeft
                    focus: true
                }

                RowLayout {
                    spacing: 5

                    Label  { text: "Favority" }
                    Switch { id: favirotySw;  }
                }

                RowLayout {
                    spacing: 5

                    Label       { text: "gender"                                         }
                    RadioButton { id: femaleRadio; enabled: false; text: qsTr("female")  }
                    RadioButton { id: maleRadio;   enabled: false; text: qsTr("Male")    }
                }

                RowLayout {
                    spacing: 5

                    MyButtonComponnent.CustomeButton {
                        id: myButtonDelete
                        buttonText: "Delete"
                        enabled: true
                        buttonBackColor: Material.color(Material.Red)
                        buttonFontSize: 14
                        width: controlWidth / 2
                        buttonHeight: 35
                        onClicked: {
                            if(connection.deleteContact(phoneNumberTxt.text))
                            {
                                hiddenContactClmOpacity.start()
                                showCheckBtnOpacity.start()
                                phoneNumberTxt.text = ""
                                messageDialog.title = "Delete"
                                messageDialog.text  = "Information was Delete successfully"
                                messageDialog.open()
                            }
                            else
                            {
                                messageDialog.title = "Error"
                                messageDialog.text  = "Contact could not Delete"
                                messageDialog.open()
                            }
                        }
                    }

                    MyButtonComponnent.CustomeButton {
                        id: myButtonCancel
                        buttonText: "Cancel"
                        enabled: true
                        buttonBackColor: Material.color(Material.Green)
                        buttonFontSize: 14
                        width: controlWidth / 2
                        buttonHeight: 35
                        onClicked: { hiddenContactClmOpacity.start(); showCheckBtnOpacity.start() }
                    }
                }
            }
        }
    }
}
