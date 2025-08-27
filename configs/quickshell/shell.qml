import Quickshell
import QtQuick

PanelWindow {
	anchors {
		top: true
		left: true
		bottom: true
	}

	implicitWidth: 30

	Text {
		anchors.centerIn: parent
		text: "vertical bar"
	}
}
