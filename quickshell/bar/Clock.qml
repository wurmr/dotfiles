import QtQuick
import ".."

Text {
    id: clock
    color: Theme.blue
    font { family: Theme.fontFamily; pixelSize: Theme.fontSize; bold: true }
    text: Qt.formatDateTime(new Date(), "ddd, MMM dd  h:mm AP")

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clock.text = Qt.formatDateTime(new Date(), "ddd, MMM dd  h:mm AP")
    }
}
