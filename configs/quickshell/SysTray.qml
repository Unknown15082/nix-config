import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    color: Appearance.cellColor
    radius: 5

    implicitWidth: parent.width - 10
    implicitHeight: layout.implicitHeight + 10

    ColumnLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 5

        Repeater {
            id: trayItems
            model: SystemTray.items

            SysTrayItem {}
        }
    }
}
