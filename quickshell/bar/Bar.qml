import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import ".."

Scope {
    Variants {
        model: Quickshell.screens.filter(s => s.name === "DP-1")

        delegate: Component {
            PanelWindow {
                id: barWindow
                required property ShellScreen modelData

                screen: modelData
                anchors.top: true
                anchors.left: true
                anchors.right: true
                implicitHeight: 32
                color: Theme.base

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    spacing: 14

                    Clock {}

                    Rectangle { width: 1; Layout.fillHeight: true; Layout.topMargin: 6; Layout.bottomMargin: 6; color: Theme.surface1 }

                    VolumeSlider {}

                    Item { Layout.fillWidth: true }

                    Workspaces {}

                    Item { Layout.fillWidth: true }

                    SystemStats {}
                }
            }
        }
    }
}
