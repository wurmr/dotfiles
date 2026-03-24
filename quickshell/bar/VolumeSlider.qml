import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import ".."

RowLayout {
    spacing: 4

    property PwNode sink: Pipewire.defaultAudioSink

    PwObjectTracker {
        objects: [sink]
    }

    Text {
        text: {
            if (!sink?.audio || sink.audio.muted) return "󰝟"
            var vol = Math.round(sink.audio.volume * 100)
            if (vol > 66) return "󰕾"
            if (vol > 33) return "󰖀"
            return "󰕿"
        }
        color: sink?.audio?.muted ? Theme.red : Theme.teal
        font { family: Theme.fontFamily; pixelSize: Theme.fontSize + 2 }
    }

    Text {
        text: sink?.audio ? Math.round(sink.audio.volume * 100) + "%" : "--"
        color: sink?.audio?.muted ? Theme.red : Theme.teal
        font { family: Theme.fontFamily; pixelSize: Theme.fontSize }

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            onClicked: {
                if (sink?.audio) sink.audio.muted = !sink.audio.muted
            }
            onWheel: wheel => {
                if (!sink?.audio) return
                var delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05
                sink.audio.volume = Math.max(0, Math.min(1.5, sink.audio.volume + delta))
            }
        }
    }
}
