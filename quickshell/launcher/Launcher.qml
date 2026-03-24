import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import Qt5Compat.GraphicalEffects
import ".."
import "EmojiData.js" as EmojiData

Scope {
    id: root
    property bool isOpen: false
    property string query: ""
    property var freq: ({})
    readonly property string freqPath: Quickshell.statePath("launcher-freq.json")

    GlobalShortcut {
        name: "launcher"
        description: "Open app launcher"
        onPressed: { root.isOpen = true; root.query = "" }
    }

    // Load freq on startup
    property string _freqBuf: ""
    Process {
        id: loadFreqProc
        command: ["sh", "-c", "cat \"$FREQ_FILE\" 2>/dev/null || echo '{}'"]
        environment: ({ "FREQ_FILE": root.freqPath })
        running: true
        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => root._freqBuf = data
        }
        onExited: {
            try { root.freq = JSON.parse(root._freqBuf) } catch(e) { root.freq = ({}) }
        }
    }

    // Save freq after each launch
    Process {
        id: writeFreqProc
        environment: ({})
        command: ["sh", "-c", "mkdir -p \"$(dirname \"$FREQ_FILE\")\" && printf '%s' \"$FREQ_DATA\" > \"$FREQ_FILE\""]
    }

    function saveFreq() {
        writeFreqProc.environment = {
            "FREQ_DATA": JSON.stringify(root.freq),
            "FREQ_FILE": root.freqPath
        }
        writeFreqProc.running = true
    }

    function recordLaunch(name) {
        var f = Object.assign({}, root.freq)
        f[name] = (f[name] || 0) + 1
        root.freq = f
        saveFreq()
    }

    // Shell exec and emoji copy processes
    Process { id: shellProc }
    Process { id: copyProc }

    PanelWindow {
        id: win
        visible: root.isOpen
        anchors.top: true; anchors.bottom: true; anchors.left: true; anchors.right: true
        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
        color: "transparent"

        readonly property int rowH: 36
        readonly property int maxRows: 10

        readonly property string mode: {
            if (root.query.startsWith(">")) return "shell"
            if (root.query.startsWith("#")) return "emoji"
            return "apps"
        }

        property var entries: {
            var q = root.query
            if (mode === "shell") {
                var cmd = q.slice(1).trim()
                return cmd ? [{ name: cmd, cmd: cmd }] : []
            }
            if (mode === "emoji") {
                var search = q.slice(1).toLowerCase()
                return EmojiData.emoji.filter(e =>
                    !search || e.name.includes(search)
                ).slice(0, maxRows)
            }
            var lower = q.toLowerCase()
            var apps = DesktopEntries.applications.values.filter(e =>
                !lower || e.name.toLowerCase().includes(lower)
            )
            return apps.slice().sort((a, b) =>
                (root.freq[b.name] || 0) - (root.freq[a.name] || 0)
            )
        }

        readonly property int visibleRows: Math.min(entries.length, maxRows)
        property int sel: 0
        onEntriesChanged: sel = 0

        function close() { root.isOpen = false; root.query = "" }

        function launch() {
            if (entries.length === 0) return
            var e = entries[sel]
            if (mode === "shell") {
                shellProc.command = ["sh", "-c", e.cmd]
                shellProc.running = true
            } else if (mode === "emoji") {
                copyProc.command = ["wl-copy", e.char]
                copyProc.running = true
            } else {
                root.recordLaunch(e.name)
                e.execute()
            }
            close()
        }

        MouseArea { anchors.fill: parent; onClicked: win.close() }

        Item {
            id: launcher
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
            width: 550
            height: popup.height

            transform: Translate { id: slideY; y: 0 }

            Connections {
                target: root
                function onIsOpenChanged() {
                    if (root.isOpen) {
                        slideY.y = launcher.height + 8
                        slideAnim.start()
                    }
                }
            }

            NumberAnimation {
                id: slideAnim
                target: slideY
                property: "y"
                to: 0
                duration: 170
                easing.type: Easing.OutBack
                easing.overshoot: 0.75
            }

            // Shadow layer — upward offset for bottom-anchored feel
            Rectangle {
                width: popup.width
                height: popup.height
                radius: popup.radius
                color: Theme.base
                layer.enabled: true
                layer.effect: DropShadow {
                    radius: 16
                    samples: 33
                    color: Theme.crust
                    horizontalOffset: 0
                    verticalOffset: -6
                    spread: 0
                }
            }

            Rectangle {
                id: popup
                width: parent.width
                height: (win.visibleRows > 0 ? win.visibleRows * win.rowH + 1 : 0) + 44
                radius: 10
                color: Theme.base
                border.color: Theme.surface2
                border.width: 1
                clip: true

                MouseArea { anchors.fill: parent; onClicked: {} }

                Column {
                    width: parent.width

                    // Results — above the search bar
                    Repeater {
                        model: win.visibleRows

                        Item {
                            required property int index
                            property var entry: win.entries[index]
                            property bool isSelected: index === win.sel

                            width: popup.width
                            height: win.rowH

                            Rectangle {
                                anchors.fill: parent
                                color: isSelected ? Theme.lavender : "transparent"
                            }

                            // App icon (apps mode)
                            Image {
                                id: appIcon
                                x: 12; anchors.verticalCenter: parent.verticalCenter
                                width: 20; height: 20
                                source: (win.mode === "apps" && entry && entry.icon)
                                    ? Quickshell.iconPath(entry.icon) : ""
                                fillMode: Image.PreserveAspectFit
                                visible: win.mode === "apps" && status === Image.Ready
                            }

                            // Emoji char / shell prefix (non-apps modes)
                            Text {
                                id: modeGlyph
                                x: 12; anchors.verticalCenter: parent.verticalCenter
                                text: win.mode === "emoji" ? (entry.char ?? "") : ">"
                                font.pixelSize: win.mode === "emoji" ? 18 : Theme.fontSize
                                color: isSelected ? Theme.base : Theme.subtext1
                                visible: win.mode !== "apps"
                            }

                            Text {
                                anchors.left: parent.left
                                anchors.leftMargin: (win.mode === "apps" && !appIcon.visible) ? 12 : 42
                                anchors.right: parent.right
                                anchors.rightMargin: 12
                                anchors.verticalCenter: parent.verticalCenter
                                text: entry.name ?? ""
                                color: isSelected ? Theme.base : Theme.text
                                font { family: Theme.fontFamily; pixelSize: Theme.fontSize }
                                elide: Text.ElideRight
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: { win.sel = index; win.launch() }
                                onEntered: win.sel = index
                            }
                        }
                    }

                    // Divider
                    Rectangle {
                        width: parent.width
                        height: 1
                        color: Theme.surface2
                        visible: win.visibleRows > 0
                    }

                    // Search input — fixed at bottom
                    Item {
                        width: parent.width
                        height: 44

                        TextInput {
                            anchors.fill: parent
                            anchors.leftMargin: 12
                            anchors.rightMargin: 12
                            verticalAlignment: TextInput.AlignVCenter
                            color: Theme.text
                            font { family: Theme.fontFamily; pixelSize: Theme.fontSize }
                            text: root.query
                            focus: root.isOpen
                            cursorDelegate: Item {}
                            onTextChanged: root.query = text
                            Keys.onEscapePressed: win.close()
                            Keys.onReturnPressed: win.launch()
                            Keys.onUpPressed:   win.sel = Math.max(0, win.sel - 1)
                            Keys.onDownPressed: win.sel = Math.min(win.entries.length - 1, win.sel + 1)
                        }

                        Text {
                            anchors.fill: parent
                            anchors.leftMargin: 12
                            verticalAlignment: Text.AlignVCenter
                            text: "Search applications…"
                            color: Theme.overlay0
                            font { family: Theme.fontFamily; pixelSize: Theme.fontSize }
                            visible: root.query.length === 0
                        }
                    }
                }
            }
        }
    }
}
