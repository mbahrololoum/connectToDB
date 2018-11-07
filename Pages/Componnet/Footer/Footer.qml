import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

import "../../Style"

ToolBar
{
    id : myHeaderRectangle
    width: parent.width; height: 45; clip : true
    background: Rectangle{ color: myStyle.foreground}

    signal sigHome
    signal sigStorsList
    signal sigBuyBasket
    signal sigProfile
    signal sigLocation

    Rectangle{ width: parent.width; height: 1; color: myStyle.shadowColor; anchors.top: parent.top }

    RowLayout{
        anchors.fill: parent
        anchors.topMargin: -15

        Button {
            id: btnLocation
            Layout.preferredWidth: 40
            Layout.preferredHeight: myHeaderRectangle.height + 20
            Layout.fillWidth: true

            Image {
                id: imgLocation
                source: myStyle.imageLocationBlack
                sourceSize: "20x20"
                anchors.centerIn: parent
                horizontalAlignment: Image.AlignHCenter
                asynchronous: true
            }

            Text{
                text: "اصناف"
                anchors.top: imgLocation.bottom
                font { family: myStyle.iranSanceFontM; pixelSize: 11 }
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }

            Material.elevation: 0
            onReleased: btnLocation.scale = 1.0
            onPressed:  btnLocation.scale = 0.9
            onClicked:  sigLocation()
        }

        Button {
            id: btnProfile
            Layout.preferredWidth: 40
            Layout.preferredHeight: myHeaderRectangle.height + 20
            Layout.fillWidth: true

            Image {
                id: imgProfile
                source: myStyle.imageProfileBlack
                sourceSize: "20x20"
                anchors.centerIn: parent
                horizontalAlignment: Image.AlignHCenter
                asynchronous: true
            }

            Text{
                text: "پروفایل"
                anchors.top: imgProfile.bottom
                font { family: myStyle.iranSanceFontM; pixelSize: 11 }
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }

            Material.elevation: 0
            onReleased: btnProfile.scale = 1.0
            onPressed:  btnProfile.scale = 0.9
            onClicked:  sigProfile()
        }

        Button {
            id: btnCard
            Layout.preferredWidth: 40
            Layout.preferredHeight: myHeaderRectangle.height + 20
            Layout.fillWidth: true

            Image {
                id: imgCard
                source: myStyle.imageBuyBlack
                sourceSize: "20x20"
                anchors.centerIn: parent
                horizontalAlignment: Image.AlignHCenter
                asynchronous: true
            }

            Rectangle {
                height: 25;width: 25;radius:13
                border.color: myStyle.foreground
                color: myStyle.accent
                anchors.left: imgCard.right
                anchors.leftMargin: -3
                anchors.verticalCenter: parent.verticalCenter
                visible: totalCount==0 ? false : true

                Text {
                    text: persianNum(totalCount)
                    font: myStyle.iranSanceFontM
                    anchors.horizontalCenter : parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 4
                    verticalAlignment: Text.AlignBottom
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Text{
                text: "سبد خرید"
                anchors.top: imgCard.bottom
                font { family: myStyle.iranSanceFontM; pixelSize: 11 }
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }

            Material.elevation: 0
            onReleased: btnCard.scale = 1.0
            onPressed:  btnCard.scale = 0.9
            onClicked:  sigBuyBasket()
        }

        Button {
            id: btnCategory
            Layout.preferredWidth: 40
            Layout.preferredHeight: myHeaderRectangle.height + 20
            Layout.fillWidth: true

            Image {
                id:imgCategory
                source: myStyle.imageCategoryBlack
                sourceSize: "20x20"
                anchors.centerIn: parent
                horizontalAlignment: Image.AlignHCenter
                asynchronous: true
            }

            Text{
                text: "دسته بندی"
                anchors.top: imgCategory.bottom
                font { family: myStyle.iranSanceFontM; pixelSize: 11 }
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }

            Material.elevation: 0
            onReleased: btnCategory.scale = 1.0
            onPressed:  btnCategory.scale = 0.9
            onClicked:  sigStorsList()
        }

        Button {
            id: btnHome
            Layout.preferredWidth: 40
            Layout.preferredHeight: myHeaderRectangle.height + 20
            Layout.fillWidth: true

            Image {
                id:imgHome
                source: myStyle.imageHomeBlack
                sourceSize: "20x20"
                anchors.centerIn: parent
                horizontalAlignment: Image.AlignHCenter
                asynchronous: true
            }

            Text{
                text: "خانه"
                anchors.top: imgHome.bottom
                font { family: myStyle.iranSanceFontM; pixelSize: 11 }
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }

            Material.elevation: 0
            onReleased: btnHome.scale = 1.0
            onPressed:  btnHome.scale = 0.9
            onClicked:  sigHome()
        }
    }
}
