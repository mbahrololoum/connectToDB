import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    id:mainStyle

    // Load Fonts
    FontLoader         { id: iranSFontB; source: "qrc:/Fonts/iranSanceBold.ttf"   }
    FontLoader         { id: iranSFontL; source: "qrc:/Fonts/iranSanceLight.ttf"  }
    FontLoader         { id: iranSFontM; source: "qrc:/Fonts/iranSanceMedium.ttf" }

    property font iranSanceFontL:
        switch (Qt.platform.os) {
        case "android": return Qt.font({ family: iranSFontL.name, italic: false, pointSize: 11, capitalization: Font.AllLowercase })
        case "ios":     return Qt.font({ family: iranSFontL.name, italic: false, pointSize: 13, capitalization: Font.AllLowercase })
        case "osx":     return Qt.font({ family: iranSFontL.name, italic: false, pointSize: 11, capitalization: Font.AllLowercase })
        case "linux":   return Qt.font({ family: iranSFontL.name, italic: false, pointSize: 11, capitalization: Font.AllLowercase })
        }

    property font iranSanceFontM:
        switch (Qt.platform.os) {
        case "android": return Qt.font({ family: iranSFontM.name, italic: false, pointSize: 11, capitalization: Font.AllLowercase })
        case "ios":     return Qt.font({ family: iranSFontM.name, italic: false, pointSize: 13, capitalization: Font.AllLowercase })
        case "osx":     return Qt.font({ family: iranSFontM.name, italic: false, pointSize: 11, capitalization: Font.AllLowercase })
        case "linux":   return Qt.font({ family: iranSFontM.name, italic: false, pointSize: 11, capitalization: Font.AllLowercase })
        }

    property font iranSanceFontB:
        switch (Qt.platform.os) {
        case "android": return Qt.font({ family: iranSFontB.name, italic: false, pointSize: 11, capitalization: Font.AllLowercase })
        case "ios":     return Qt.font({ family: iranSFontB.name, italic: false, pointSize: 13, capitalization: Font.AllLowercase })
        case "osx":     return Qt.font({ family: iranSFontB.name, italic: false, pointSize: 11, capitalization: Font.AllLowercase })
        case "linux":   return Qt.font({ family: iranSFontB.name, italic: false, pointSize: 11, capitalization: Font.AllLowercase })
        }

    // Drawer
    property string imageNewContact   : "/Image/Drawer/new.svg"
    property string imageDeleteContact: "/Image/Drawer/delete.svg"
    property string imageContactList  : "/Image/Drawer/list.svg"
    property string imageSearch       : "/Image/Drawer/search.svg"
    property string imageExit         : "/Image/Drawer/exit.svg"

    // Image Header
    property string imageDrawer:             "/Image/Header/drawer.svg"
    property string imageBack:               "/Image/Header/back.svg"

    // Image Logo
    property string imageLogo:               "/Image/Logo/logo.png"

    // Image Login Icone
    property string imageUser:               "/Image/login/user.svg"
    property string imagePass:               "/Image/login/pass.svg"
}
