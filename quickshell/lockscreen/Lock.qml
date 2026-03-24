import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick

Scope {
    id: root
    property bool lockRequested: false

    GlobalShortcut {
        name: "lock"
        description: "Lock the session"
        onPressed: root.lockRequested = true
    }

    WlSessionLock {
        locked: root.lockRequested

        surface: Component {
            LockSurface {
                onUnlockRequested: root.lockRequested = false
            }
        }
    }
}
