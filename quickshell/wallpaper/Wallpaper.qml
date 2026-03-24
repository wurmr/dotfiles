import Quickshell
import Quickshell.Wayland
import QtQuick
import ".."

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        delegate: Component {
            PanelWindow {
                id: wallpaperWindow
                required property ShellScreen modelData

                screen: modelData
                WlrLayershell.layer: WlrLayer.Background
                WlrLayershell.namespace: "quickshell-wallpaper"
                exclusionMode: ExclusionMode.Ignore
                anchors.top: true
                anchors.bottom: true
                anchors.left: true
                anchors.right: true
                color: Theme.base

                Image {
                    anchors.fill: parent
                    source: Theme.wallpapers[wallpaperWindow.modelData.name] || ""
                    fillMode: Image.PreserveAspectCrop
                    visible: source !== ""
                }
            }
        }
    }
}
