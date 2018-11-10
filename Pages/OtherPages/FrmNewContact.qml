import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "../Component/Button" as MyButtonComponent

Item {
    Component.onCompleted: { opacityAnimation.start(); forceActiveFocus() }

    NumberAnimation { id: opacityAnimation;  target: flickable; properties: "opacity"; from: 0.0; to: 1.0; duration: 700 }

    Flickable {
        id: flickable
        anchors.fill: parent
        contentHeight: parent.height + 10
        opacity: 0

        ColumnLayout{
            anchors.centerIn: parent
            spacing: 20

            Label {
                id: titleWelcom
                text: "Create New Contact"
                font { family: myStyle.iranSanceFontL; pixelSize: 20 }
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
            }

            TextField {
                id: nameTxt
                placeholderText: qsTr("Name")
                font { family: myStyle.iranSanceFontL; pixelSize: 14 }
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.preferredWidth: controlWidth
                horizontalAlignment: Text.AlignLeft
                focus: true
            }

            TextField {
                id: familyTxt
                placeholderText: qsTr("Family")
                font { family: myStyle.iranSanceFontL; pixelSize: 14 }
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.preferredWidth: controlWidth
                horizontalAlignment: Text.AlignLeft
            }

            TextField {
                id: phoneNumberTxt
                placeholderText: qsTr("Phone Number")
                font { family: myStyle.iranSanceFontL; pixelSize: 14 }
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.preferredWidth: controlWidth
                horizontalAlignment: Text.AlignLeft
                validator: RegExpValidator { regExp: /(^(09)[0-9]{9}\\d$)/ }
                inputMethodHints: Qt.ImhDialableCharactersOnly
            }

            RowLayout {
                spacing: 5

                Label  { text: "Favority"               }
                Switch { id: favirotySw; checked: false }
            }

            RowLayout {
                spacing: 5

                Label       { text: "gender"                     }
                RadioButton { id: femaleRadio; text: qsTr("Female"); checked: true }
                RadioButton { id: maleRadio;   text: qsTr("Male")                  }
            }

            MyButtonComponent.CustomeButton {
                id: myButtonRegister
                buttonText: "Register"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    if(nameTxt.text === "" || familyTxt.text === "" || phoneNumberTxt.text.length !== 11)
                    {
                        messageDialog.title = "Error"
                        messageDialog.text  = "Please enter all fields."
                        messageDialog.open()
                        return
                    }
                    if(connection.newContact(nameTxt.text, familyTxt.text, phoneNumberTxt.text, favirotySw.checked , femaleRadio.checked ? "Female" : "Male"))
                    {
                        nameTxt.text        = ""
                        familyTxt.text      = ""
                        phoneNumberTxt.text = ""
                        favirotySw.checked  = false
                        femaleRadio.checked = true

                        messageDialog.title = "Save"
                        messageDialog.text  = "Information was saved successfully"
                        messageDialog.open()
                    }
                    else
                    {
                        messageDialog.title = "Error"
                        messageDialog.text  = "Information could not saved"
                        messageDialog.open()
                    }
                }
            }
        }
    }
}
