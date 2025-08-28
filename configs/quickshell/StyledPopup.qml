import Quickshell
import QtQuick

Scope {
    id: root

    required property Item item

    property alias content: container.data

    Component.onCompleted: {
        mouseArea.parent = root.item;
        mouseArea.anchors.fill = root.item;
    }

    MouseArea {
        id: mouseArea
        hoverEnabled: true

        onEntered: popup.visible = true
        onExited: popup.visible = false
    }

    PopupWindow {
        id: popup

        color: "transparent"
        visible: false
        implicitWidth: container.childrenRect.width
        implicitHeight: container.childrenRect.height

        anchor {
            item: root.item
            rect {
                x: root.item.width + 10
                y: root.item.height / 4
            }
        }

        Item {
            id: container
        }
    }
}
