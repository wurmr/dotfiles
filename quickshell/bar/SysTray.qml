import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import ".."

RowLayout {
    id: tray
    spacing: 4

    required property var panelWindow

    Repeater {
        model: SystemTray.items

        Image {
            required property SystemTrayItem modelData

            source: modelData.icon
            sourceSize.width: 18
            sourceSize.height: 18
            width: 18
            height: 18

            QsMenuAnchor {
                id: menuAnchor
                menu: modelData.menu
                anchor.window: tray.panelWindow
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: event => {
                    if (event.button === Qt.LeftButton) {
                        if (modelData.onlyMenu) {
                            menuAnchor.open()
                        } else {
                            modelData.activate()
                        }
                    } else if (event.button === Qt.RightButton) {
                        if (modelData.hasMenu) menuAnchor.open()
                    }
                }
            }
        }
    }
}
