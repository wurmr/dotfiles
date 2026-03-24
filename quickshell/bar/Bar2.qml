import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import ".."

Scope {
    Variants {
        model: Quickshell.screens.filter(s => s.name === "DP-3")

        delegate: Component {
            PanelWindow {
                id: barWindow2
                required property ShellScreen modelData

                screen: modelData
                anchors.bottom: true
                anchors.left: true
                anchors.right: true
                implicitHeight: 32
                color: Theme.base

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    spacing: 14

                    Item { Layout.fillWidth: true }

                    MediaControls {}

                    Item { Layout.fillWidth: true }

                    SysTray { panelWindow: barWindow2 }
                }
            }
        }
    }
}
