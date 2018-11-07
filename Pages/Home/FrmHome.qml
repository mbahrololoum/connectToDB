import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "../OtherPages"        as Pages
import "../Componnet/Header"
import "../Componnet/Drawer"

Item {
    anchors.fill: parent
    signal backClicked

    // Call Header Component
    Header { id: mainHeader; anchors.top: parent.top; width: parent.width; z:2 }
    Drawer { id: drawer }

    StackView {
        id: stackView
        width: parent.width
        anchors.top: mainHeader.bottom
        anchors.bottom: parent.bottom
        initialItem: defultPage
        Keys.enabled: true
        Keys.priority: Keys.BeforeItem
        focus: true

        Keys.onReleased: {
            //        if(event.key === Qt.Key_Back && depth != 1)
            //        { event.accepted = true; managmentActivePage.pop(); stackView.pop() }
        }

        onDepthChanged: {
            //            if(managmentActivePage[managmentActivePage.length-1]      === "Home"         ||
            //                    managmentActivePage[managmentActivePage.length-1] === "GridCategory" ||
            //                    managmentActivePage[managmentActivePage.length-1] === "SubCategory")
            //                searchAnimation = false
            //            else
            //                searchAnimation = true

            //            depthStack = depth
            //            if(stackView.depth == 1)  mainHeader.visableBack = false
            //            else                      mainHeader.visableBack = true
        }
    }

    // Create Form Object
    Component { id: defultPage;     Pages.FrmDefultPage   {} }
    Component { id: newContact;     Pages.FrmNewContact   {} }
    Component { id: deleteContact;  Pages.FrmDeleteContact{} }
    Component { id: contactList;    Pages.FrmContactList  {} }
    Component { id: searchContact;  Pages.FrmSearchContact{} }
}

