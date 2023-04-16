import QtQuick 2.12
import QtQuick.Controls 2.12
import "components/"

Item {
    id: brightness
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
        id: bright
        y: brightness.height / 2 - height / 2
        x: (parent.width / 2 - width / 2) + (iconBright.width / 2 + 4)
        width: plugins.size * 9
        height: plugins.size * 0.8
        detail: brightness.detailColor
        //perValue: 4
        percentage: ContextPlugin.brightness()
        bg.color: brightness.tooltipColor
        onChange: {
            if (perValue > 10 && perValue < 101) {
                ContextPlugin.brightness(perValue)
                percentage = perValue
            }
        }
    }

    Label {
        id: iconBright
        y: (bright.y - bright.height / 2) - 2
        x: bright.x - (width + 12)
        text: "\uf185"
        color: brightness.tooltipColor
        font.bold: true
        font.pixelSize: plugins.size * 2
        font.family: fontIcons.name
    }

    function atualize() {
        brightness.width = plugins.size * 15
        brightness.height = plugins.size * 4
    }
}
