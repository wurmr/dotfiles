import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import ".."

RowLayout {
    id: stats
    spacing: 8

    property int cpuUsage: 0
    property int memUsage: 0
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var p = data.trim().split(/\s+/)
                var idle = parseInt(p[4]) + parseInt(p[5])
                var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
                if (stats.lastCpuTotal > 0) {
                    stats.cpuUsage = Math.round(100 * (1 - (idle - stats.lastCpuIdle) / (total - stats.lastCpuTotal)))
                }
                stats.lastCpuTotal = total
                stats.lastCpuIdle = idle
            }
        }
        Component.onCompleted: running = true
    }

    Process {
        id: memProc
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                if (!data) return
                var parts = data.trim().split(/\s+/)
                var total = parseInt(parts[1]) || 1
                var used = parseInt(parts[2]) || 0
                stats.memUsage = Math.round(100 * used / total)
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true
            memProc.running = true
        }
    }

    Text {
        text: "CPU " + stats.cpuUsage + "%"
        color: Theme.yellow
        font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
    }

    Text {
        text: "Mem " + stats.memUsage + "%"
        color: Theme.teal
        font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
    }
}
