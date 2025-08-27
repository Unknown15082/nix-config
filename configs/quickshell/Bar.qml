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

            color: "#bb89b4fa"

            anchors {
                top: true
                left: true
                bottom: true
            }

            implicitWidth: 40

            ClockWidget {
                anchors.centerIn: parent
                barColor: "#89b4fa"
            }
        }
    }
}
