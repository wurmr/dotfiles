import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

Scope {
    id: root
    property bool lockRequested: false

    GlobalShortcut {
        name: "lock"
        description: "Lock the session"
        onPressed: root.lockRequested = true
    }

    IdleMonitor {
        timeout: 300
        onIsIdleChanged: if (isIdle) root.lockRequested = true
    }

    IdleMonitor {
        timeout: 1200
        onIsIdleChanged: if (isIdle) suspendProc.running = true
    }

    Process {
        id: suspendProc
        command: ["systemctl", "suspend"]
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
