import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "../OtherPages"        as Pages
import "../Component/Header"
import "../Component/Drawer"

Item {
    anchors.fill: parent
    Component.onCompleted: forceActiveFocus()

    signal backClicked

    // Call Header Component
    Header { id: mainHeader; anchors.top: parent.top; width: parent.width; z:2 }
    Drawer { id: drawer                                                        }

    StackView {
        id: stackView
        width: parent.width
        anchors.top: mainHeader.bottom
        anchors.bottom: parent.bottom
        initialItem:  defultPage
        Keys.enabled: true
        Keys.priority: Keys.BeforeItem
        focus: true

        Keys.onReleased: {
            if(event.key === Qt.Key_Back && depth != 1)
            {
                event.accepted = true;
                stackView.pop()
            }
        }
    }

    // Create Form Object
    Component { id: defultPage;     Pages.FrmDefultPage   {} }
    Component { id: newContact;     Pages.FrmNewContact   {} }
    Component { id: deleteContact;  Pages.FrmDeleteContact{} }
    Component { id: contactList;    Pages.FrmContactList  {} }
    Component { id: searchContact;  Pages.FrmSearchContact{} }
}

