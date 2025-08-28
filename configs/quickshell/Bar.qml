import Quickshell
import QtQuick

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar

            required property var modelData
            screen: modelData

            color: Appearance.barColor

            anchors {
                top: true
                left: true
                bottom: true
            }

            implicitWidth: 40

            ClockWidget {
                anchors.centerIn: parent
            }

            SysTray {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 10
            }
        }
    }
}
