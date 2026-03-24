import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import ".."

PanelWindow {
    id: volumeOsd

    width: 320 
    height: 120
    color: "transparent"

    WlrLayershell.layer: WlrLayershell.Overlay
    WlrLayershell.namespace: "volume-osd"
    WlrLayershell.exclusiveZone: -1
    WlrLayershell.keyboardFocus: WlrLayershell.None

    // anchors.bottom: true
    // margins.bottom: 100

    property PwNode sink: Pipewire.defaultAudioSink

    PwObjectTracker {
        objects: [sink]
    }

    Connections {
        target: sink?.audio
        ignoreUnknownSignals: true

        function onVolumeChanged() { showOsd() }
        function onMutedChanged() { showOsd() }
    }

    function showOsd() {
        osd.visible = true
        osd.opacity = 1
        osd.scale = 1
        osd.y = -8
        hideTimer.restart()
    }

    Timer {
        id: hideTimer
        interval: 1000 
        repeat: false
        onTriggered: {
            osd.opacity = 0
            osd.scale = 0.92
            osd.y = 0
        }
    }

    Item {
        anchors.fill: parent

        Rectangle {
            id: osd

            width: 320
            height: 54

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom

            radius: 14
            opacity: 0
            scale: 0.92

            color: Qt.rgba(
              Theme.surface0.r,
              Theme.surface0.g,
              Theme.surface0.b,
              0.92
            )
            border.color: Theme.overlay0
            border.width: 1

            layer.enabled: true
            layer.smooth: true

            Behavior on opacity {
                NumberAnimation { duration: 160; easing.type: Easing.OutCubic }
            }

            Behavior on scale {
                NumberAnimation { duration: 220; easing.type: Easing.OutBack }
            }

            Behavior on y {
                NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
            }

            Rectangle {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 8

                height: parent.height - 16
                radius: 10

                width: (parent.width - 16) *
                       (sink?.audio
                        ? Math.min(sink.audio.volume, 1.0)
                        : 0)

                color: (sink?.audio?.muted)
                       ? Theme.red 
                       : Theme.lavender 

                Behavior on width {
                    NumberAnimation {
                        duration: 180
                        easing.type: Easing.OutCubic
                    }
                }
            }

            Text {
                anchors.centerIn: parent

                color: Theme.text
                font.family: Theme.fontFamily
                font.pixelSize: Theme.fontSize + 2

                text: sink?.audio
                      ? (sink.audio.muted
                         ? "MUTED"
                         : Math.round(sink.audio.volume * 100) + "%")
                      : ""
            }
        }
    }
}
