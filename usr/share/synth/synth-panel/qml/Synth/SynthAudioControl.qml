import QtQuick 2.12
import QtQuick.Controls 2.12
import "components/"

Item {
    id: audioControl
    x: 0
    y: 0
    width: 0
    height: 0
    property string tooltipColor: "#ffffff"
    property string detailColor: "#fff"

    FontLoader {
        id: fontIcons
        name: "Font Awesome 5 Free"
        source: "qrc:fonts/Font Awesome 5 Free-Solid-900.otf"
    }

    Controller {
        id: audio
        y: parent.height / 4
        x: ((iconAudio.width + 12 + parent.width) / 2) - (width / 2)
        width: plugins.size * 9
        height: plugins.size * 0.8
        detail: audioControl.detailColor
        //perValue: 4
        percentage: ContextPlugin.volume()
        bg.color: audioControl.tooltipColor
        onChange: {
            if (perValue <= 0) {
                iconAudio.text = "\uf026"
            } else {
                iconAudio.text = "\uf028"
            }
            ContextPlugin.volume(perValue)
            percentage = perValue
        }
    }

    Label {
        id: iconAudio
        y: (audio.y - audio.height / 2) - 2
        x: audio.x - (width + 12)
        text: "\uf028"
        color: audioControl.tooltipColor //audioControl.detailColor
        font.bold: true
        font.pixelSize: plugins.size * 2
        font.family: fontIcons.name
    }

    Controller {
        id: micro
        y: parent.height - parent.height / 3
        x: ((iconMicro.width + 12 + parent.width) / 2) - (width / 2)
        width: plugins.size * 9
        height: plugins.size * 0.8
        detail: audioControl.detailColor
        percentage: ContextPlugin.micro()
        bg.color: audioControl.tooltipColor
        onChange: {
            if (perValue <= 0) {
                iconMicro.text = "\uf131"
            } else {
                iconMicro.text = "\uf130"
            }
            ContextPlugin.micro(perValue)
            percentage = perValue
        }
    }

    Label {
        id: iconMicro
        y: (micro.y - micro.height / 2) - 2
        x: micro.x - (width + 12)
        text: "\uf131"
        color: audioControl.tooltipColor //audioControl.detailColor
        font.bold: true
        font.pixelSize: plugins.size * 2
        font.family: fontIcons.name
    }

    function atualize() {
        audioControl.width = plugins.size * 15
        audioControl.height = plugins.size * 8
    }
}
