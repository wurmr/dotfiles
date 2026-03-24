import Quickshell
import Quickshell.Services.Pam
import QtQuick
import Qt5Compat.GraphicalEffects
import ".."

Item {
    id: content

    signal unlockRequested()

    property string lockState: "idle"

    PamContext {
        id: pam
        config: "login"

        onPamMessage: {
            if (responseRequired) pam.respond(passwordInput.text)
        }

        onCompleted: result => {
            if (result === PamResult.Success) {
                content.unlockRequested()
            } else {
                content.lockState = "failed"
                passwordInput.text = ""
                failTimer.start()
            }
        }

        onError: {
            content.lockState = "failed"
            passwordInput.text = ""
            failTimer.start()
        }
    }

    Timer {
        id: failTimer
        interval: 3000
        onTriggered: content.lockState = "idle"
    }

    // Time and date anchored to top
    Column {
        anchors.top: parent.top
        anchors.topMargin: 48
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 8

        Text {
            id: timeLabel
            anchors.horizontalCenter: parent.horizontalCenter
            color: Theme.text
            font { family: Theme.fontFamily; pixelSize: 90 }
            text: Qt.formatDateTime(new Date(), "hh:mm AP")

            Timer {
                interval: 30000
                running: true
                repeat: true
                onTriggered: timeLabel.text = Qt.formatDateTime(new Date(), "hh:mm AP")
            }
        }

        Text {
            id: dateLabel
            anchors.horizontalCenter: parent.horizontalCenter
            color: Theme.subtext0
            font { family: Theme.fontFamily; pixelSize: 25 }
            text: Qt.formatDateTime(new Date(), "dddd, dd MMMM yyyy")

            Timer {
                interval: 60000
                running: true
                repeat: true
                onTriggered: dateLabel.text = Qt.formatDateTime(new Date(), "dddd, dd MMMM yyyy")
            }
        }
    }

    // Avatar and password centered in the screen
    Column {
        anchors.centerIn: parent
        spacing: 16

        // Avatar + username
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 20

            Rectangle {
                width: 108; height: 108
                radius: 54
                color: "transparent"
                border.color: content.lockState === "failed" ? Theme.red : Theme.mauve
                border.width: 3

                Image {
                    id: avatarImage
                    anchors.centerIn: parent
                    width: 100; height: 100
                    source: "file:///home/jkarg/.face"
                    fillMode: Image.PreserveAspectCrop
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: Rectangle {
                            width: avatarImage.width
                            height: avatarImage.height
                            radius: width / 2
                            visible: false
                        }
                    }
                }
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "@" + Quickshell.env("USER")
                color: Theme.subtext0
                font { family: Theme.fontFamily; pixelSize: 22 }
            }
        }

        // Password input
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 300; height: 60
            radius: 30
            color: Theme.surface0
            border.color: content.lockState === "failed" ? Theme.red : Theme.mauve
            border.width: 3

            TextInput {
                id: passwordInput
                anchors.fill: parent
                anchors.margins: 12
                horizontalAlignment: TextInput.AlignHCenter
                verticalAlignment: TextInput.AlignVCenter
                color: Theme.text
                font { family: Theme.fontFamily; pixelSize: Theme.fontSize }
                echoMode: TextInput.Password
                focus: true
                enabled: content.lockState !== "verifying"
                cursorDelegate: Item {}

                Text {
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "󰌾 Locked"
                    color: Theme.subtext0
                    font: passwordInput.font
                    visible: passwordInput.text.length === 0
                }

                onAccepted: {
                    if (passwordInput.text.length === 0) return
                    content.lockState = "verifying"
                    pam.start()
                }
            }
        }

        // Feedback
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            color: Theme.red
            font { family: Theme.fontFamily; pixelSize: Theme.fontSize }
            text: content.lockState === "failed" ? "Authentication failed" :
                  content.lockState === "verifying" ? "Verifying..." : ""
        }
    }
}
