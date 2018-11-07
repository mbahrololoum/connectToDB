import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "../Componnet/Button" as MyButtonComponnent

Item {
    id: loginPages
    Component.onCompleted: connection.getSetting()

    signal signalLogin

    Rectangle {
        id: myColumn
        anchors.fill: parent
        color:"transparent"

        Flickable {
            anchors.fill: parent
            contentHeight: parent.height + 10

            Image {
                id: logo
                fillMode: Image.PreserveAspectFit
                source: myStyle.imageLogo
                sourceSize: "60x60"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 100
                asynchronous: true
            }

            TextField {
                id: usernameTxt
                placeholderText: qsTr("Phone Number")
                font { family: myStyle.iranSanceFontL; pixelSize: 14 }
                anchors.horizontalCenter: parent.horizontalCenter
                width: controlWidth
                height: 45
                horizontalAlignment: Text.AlignLeft
                anchors.top: logo.bottom
                anchors.topMargin: 40
                leftPadding: 30
                validator: RegExpValidator { regExp: /(^(09)[0-9]{9}\\d$)/ }
                inputMethodHints: Qt.ImhDialableCharactersOnly
                focus: true
                text: objLogin.username
            }

            Image {
                id: imageUser
                fillMode: Image.PreserveAspectFit
                source: myStyle.imageUser
                anchors.left: usernameTxt.left
                anchors.leftMargin: 0
                anchors.top: usernameTxt.top
                anchors.topMargin: 10
                asynchronous: true
                sourceSize: "20x20"
            }

            TextField {
                id: passwordTxt
                placeholderText: qsTr("Password")
                font { family: myStyle.iranSanceFontL; pixelSize: 14 }
                anchors.horizontalCenter: parent.horizontalCenter
                width: controlWidth
                height: 55
                horizontalAlignment: Text.AlignLeft
                anchors.top: usernameTxt.bottom
                anchors.topMargin: 0
                echoMode: TextInput.Password
                leftPadding: 30
                inputMethodHints: Qt.ImhExclusiveInputMask
                text: objLogin.password
            }

            Image {
                id: imagePass
                source: myStyle.imagePass
                fillMode: Image.PreserveAspectFit
                anchors.left: passwordTxt.left
                anchors.leftMargin: 0
                anchors.top: passwordTxt.top
                anchors.topMargin: 10
                asynchronous: true
                sourceSize: "20x20"
            }

            MyButtonComponnent.CustomeButton {
                id: myButtonRegister
                buttonText: "Login"
                enabled: true
                buttonFontSize: 14
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: passwordTxt.bottom
                anchors.topMargin: 20
                width: controlWidth
                buttonHeight: 35
                onClicked: {
                    if(connection.checkUser(usernameTxt.text, passwordTxt.text))
                    {
                        signalLogin()
                    }
                    else
                    {
                        messageDialog.title = "Warning"
                        messageDialog.text  = "Incorrect Username or password"
                        messageDialog.open()
                    }
                }
            }

            CheckBox {
                id: chkRemmember
                text: qsTr("Remmember")
                checked: objLogin.remmember
                anchors.top: myButtonRegister.bottom; anchors.topMargin: 10
                anchors.left: myButtonRegister.left;  anchors.leftMargin: 0
                onCheckedChanged: connection.setSetting(checked, usernameTxt.text, passwordTxt.text)
            }
        }
        Label {
            id: lbCreateAccount
            text: qsTr("Copyright @ 2018 Example. All rights reserved.")
            font { family: myStyle.iranSanceFontL; pixelSize: 10 }
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30

            MouseArea {
                anchors.fill: parent
                onReleased: lbCreateAccount.scale = 1.0
                onPressed:  lbCreateAccount.scale = 1.1
                onClicked:  sigRegisterAccount()
            }
        }
    }
}
