import Quickshell.Wayland
import QtQuick
import Qt5Compat.GraphicalEffects
import ".."

WlSessionLockSurface {
    id: surface
    color: Theme.base

    signal unlockRequested()

    property bool isPrimary: screen?.name === "DP-1"

    // Primary: blurred wallpaper background
    Item {
        anchors.fill: parent
        visible: surface.isPrimary

        Image {
            id: wallpaperBg
            anchors.fill: parent
            source: "file://" + (Theme.wallpapers[surface.screen?.name] || "")
            fillMode: Image.PreserveAspectCrop
            visible: true
        }

        // Commented out for now, to re-enable toggle visible on the image and allow this to render
        // FastBlur {
        //     anchors.fill: parent
        //     source: wallpaperBg
        //     radius: 64
        // }

        Rectangle {
            anchors.fill: parent
            color: Theme.base
            opacity: 0.4
        }
    }

    // Non-primary: solid dark background, no UI
    Rectangle {
        anchors.fill: parent
        color: Theme.crust
        visible: !surface.isPrimary
    }

    // Primary: full lock UI
    LockContent {
        anchors.fill: parent
        visible: surface.isPrimary
        onUnlockRequested: surface.unlockRequested()
    }
}
