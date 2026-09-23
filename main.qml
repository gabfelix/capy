import QtQuick
import QtQuick.Controls

Window {
    width: 800
    height: 600
    visible: true
    title: "Capy Window"

    Button {
        text: "Hello world"
        x: 10
        y: 10

        onClicked: {
            console.log("Executing my window!")
        }
    }
}
