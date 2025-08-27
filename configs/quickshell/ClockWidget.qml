import Quickshell
import QtQuick

Rectangle {
    id: clockWidget
    color: "transparent"

    property color barColor

    radius: 5

    implicitWidth: parent.width - 10
    implicitHeight: clockText.implicitHeight + 10

    Text {
        id: clockText
        anchors.centerIn: clockWidget
        text: SysClock.format("hh\nmm")
    }

    PopupWindow {
        id: clockPopup
        color: "transparent"

        anchor {
            item: clockWidget
            rect {
                x: clockWidget.width + 15
                y: clockWidget.height / 4 - 5
            }
        }

        visible: false

        implicitWidth: contentRect.implicitWidth
        implicitHeight: contentRect.implicitHeight

        Rectangle {
            id: contentRect
            color: clockWidget.barColor
            radius: 5

            implicitWidth: contentText.implicitWidth + 10
            implicitHeight: contentText.implicitHeight + 10

            Text {
                id: contentText
                anchors.centerIn: parent
                text: SysClock.format("yyyy-MM-dd hh:mm:ss")
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onEntered: clockPopup.visible = true
        onExited: clockPopup.visible = false
    }
}
