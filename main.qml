import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import QtQuick.Dialogs 1.3

import Company.Connection 1.0

import "Pages/Home"
import "Pages/Login"
import "Style"

ApplicationWindow {
    visible: true
    width  : 320  //Screen.desktopAvailableWidth
    height : 568  //Screen.desktopAvailableHeight
    title  : qsTr("Qt Database Example")
    Component.onCompleted: mainLoader.sourceComponent = frmLogin

    property int controlWidth: (width < height) ? width * 2 / 3 : width * 2 / 4

    QtObject{
        id: objProfile
        property string name     : ""
        property string family   : ""
        property bool   favority : false
        property string gender   : ""
    }

    QtObject{
        id: objLogin
        property bool   remmember: false
        property string username : ""
        property string password : ""
    }

    Style { id: myStyle }

    MessageDialog { id: messageDialog }

    Connection{
        id: connection
        onSigSendProfile   : { objProfile.name = name; objProfile.family = family                                                             }
        onSigSendOneContact: { objProfile.name = name; objProfile.family = family; objProfile.favority = favority; objProfile.gender = gender }
        onSigGetSetting    : { objLogin.remmember = lastState; objLogin.username = username; objLogin.password = password                     }
    }

    // Manage Pages
    Loader {
        id: mainLoader
        width: parent.width
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        //sourceComponent: login
        asynchronous: true
        Keys.onReleased: {
            if(event.key === Qt.Key_Back && mainLoader.sourceComponent === joined)
            {
                event.accepted = true;
                mainLoader.sourceComponent = loginPage
            }
        }
    }

    Component{ id:frmLogin; FrmLogin{ onSignalLogin: mainLoader.sourceComponent = frmHome  } }
    Component{ id:frmHome;  FrmHome { onBackClicked: mainLoader.sourceComponent = frmLogin } }
}
