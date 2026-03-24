import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import ".."

RowLayout {
    spacing: 0

    // Define your workspace groups here
    property var groups: [[1, 2], [7, 8], [9, 10]]

    Repeater {
        model: parent.groups

        RowLayout {
            required property var modelData
            required property int index

            spacing: 6

            // Separator before every group except the first
            Rectangle {
                visible: index > 0
                width: 1
                height: 10
                color: Theme.surface2
                opacity: 0.6
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 6
                Layout.rightMargin: 6
            }

            Repeater {
                model: parent.modelData

                Text {
                    required property int modelData
                    property var ws: Hyprland.workspaces.values.find(w => w.id === modelData)
                    property bool isActive: Hyprland.focusedWorkspace?.id === modelData

                    text: "●"
                    color: isActive ? Theme.mauve : (ws ? Theme.lavender : Theme.surface1)
                    font.family: Theme.fontFamily
                    font.bold: true
                    font.pixelSize: isActive ? Theme.fontSize + 5 : Theme.fontSize

                    MouseArea {
                        anchors.fill: parent
                        onClicked: Hyprland.dispatch("workspace " + parent.modelData)
                    }
                }
            }
        }
    }
}
