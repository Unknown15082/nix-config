import Quickshell
import QtQuick
import QtQuick.Shapes

Rectangle {
    id: clockWidget
    color: Appearance.cellColor

    radius: 5

    implicitWidth: parent.width - 10
    implicitHeight: clockText.implicitHeight + 10

    Text {
        id: clockText
        anchors.centerIn: clockWidget
        text: SysClock.format("hh\nmm")
    }

    StyledPopup {
        item: clockWidget

        content: Rectangle {
            id: content
            color: Appearance.cellColor
            radius: 5

            implicitWidth: text.implicitWidth + 10
            implicitHeight: text.implicitHeight + 10

            Text {
                id: text
                anchors.centerIn: parent
                text: SysClock.format("yyyy-MM-dd hh:mm:ss")
            }
        }
    }
}
