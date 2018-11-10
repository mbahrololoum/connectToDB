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
        property string nameFamily : ""
    }

    QtObject{
        id: objSearch
        property string name     : ""
        property string family   : ""
        property bool   favority : false
        property string gender   : ""
    }

    QtObject{
        id: objLogin
        property bool   remember : false
        property string username : ""
        property string password : ""
    }

    Style         { id: myStyle       }

    MessageDialog { id: messageDialog }

    Connection{
        id: connection
        onSigSendProfile   : { objProfile.nameFamily = name + " " + family                                                                }
        onSigSendOneContact: { objSearch.name = name; objSearch.family = family; objSearch.favority = favority; objSearch.gender = gender }
        onSigGetSetting    : { objLogin.remember = lastState; objLogin.username = username; objLogin.password = password                  }
    }

    // Manage Pages
    Loader {
        id: mainLoader
        width: parent.width
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        asynchronous: true
        focus: true
        Keys.onReleased: {
            if(event.key === Qt.Key_Back && mainLoader.sourceComponent === frmHome)
            {
                event.accepted = true;
                mainLoader.sourceComponent = frmLogin
            }
        }
    }

    Component{ id:frmLogin; FrmLogin{ onSignalLogin: mainLoader.sourceComponent = frmHome  } }
    Component{ id:frmHome;  FrmHome { onBackClicked: mainLoader.sourceComponent = frmLogin } }

    onClosing: {
        if(mainLoader.sourceComponent === frmLogin)
            close.accepted = true
        if(mainLoader.sourceComponent === frmHome)
            close.accepted = true
        else
            close.accepted = false
    }
}
