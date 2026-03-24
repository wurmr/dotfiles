import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import ".."

RowLayout {
    id: root
    spacing: 8

    readonly property var players: Mpris.players.values
    readonly property var activePlayer: {
        // 1. Bulletproof check: Find the player that actually has an Artist defined.
        // This inherently skips the generic Chromium instance.
        let best = players.find(p => p.trackArtist && p.trackArtist.length > 0);
        
        // 2. Fallback: Check explicitly for the plasma integration bus name
        if (!best) best = players.find(p => p.busName && p.busName.includes("plasma-browser-integration"));
        
        // 3. Fallback: Whatever is currently playing
        if (!best) best = players.find(p => p.isPlaying);
        
        return best || (players.length > 0 ? players[0] : null);
    }

    visible: activePlayer !== null

    // Helper component to keep icons perfectly centered
    component ControlIcon : Text {
        property bool active: true
        Layout.alignment: Qt.AlignVCenter
        font { family: Theme.fontFamily; pixelSize: Theme.fontSize }
        color: active ? Theme.text : Theme.dimColor
        verticalAlignment: Text.AlignVCenter
    }

    ControlIcon {
        text: "󰒮"
        active: activePlayer?.canGoPrevious ?? false
        MouseArea {
            anchors.fill: parent
            onClicked: { if (activePlayer?.canGoPrevious) activePlayer.previous() }
        }
    }

    ControlIcon {
        text: activePlayer?.isPlaying ? "󰏤" : "󰐊"
        active: activePlayer?.canTogglePlaying ?? false
        color: active ? Theme.green : Theme.dimColor
        font.pixelSize: Theme.fontSize + 2 
        
        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (!activePlayer?.canTogglePlaying) return
                if (activePlayer.isPlaying) activePlayer.pause()
                else activePlayer.play()
            }
        }
    }

    ControlIcon {
        text: "󰒭"
        active: activePlayer?.canGoNext ?? false
        MouseArea {
            anchors.fill: parent
            onClicked: { if (activePlayer?.canGoNext) activePlayer.next() }
        }
    }

    Text {
        Layout.alignment: Qt.AlignVCenter
        Layout.maximumWidth: 250
        elide: Text.ElideRight
        
        text: {
            if (!activePlayer) return ""
            const title = activePlayer.trackTitle || ""
            const artist = activePlayer.trackArtist || ""
            
            // Now that we have the right source, this will format beautifully:
            // "Rainbow Kitten Surprise - Seven (Live from Athens Georgia)"
            if (artist && title) return artist + " - " + title
            return title || activePlayer.identity || "Media"
        }
        
        color: Theme.text
        font { family: Theme.fontFamily; pixelSize: Theme.fontSize - 1 }
        verticalAlignment: Text.AlignVCenter
    }
}
