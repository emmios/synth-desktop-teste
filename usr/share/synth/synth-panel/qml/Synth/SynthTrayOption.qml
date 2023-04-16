import QtQuick 2.12

Item {
    id: trayOption
	x: 0
	y: 0
	width: 0
	height: 0
    property int win: 0
    property string detailColor: "#ffffff"
    property string tooltipColor: "#ffffff"

    Rectangle {
        id: btnRestore
        width: trayOption.width
        height: plugins.size * 3.8
        color: "#00000000"
        //opacity: 0.8
        Text {
            id: textRestore
            y: 12
            anchors.centerIn: parent
            text: "Restaurar"
            color: trayOption.tooltipColor
            font {
                pixelSize: plugins.size * 1.2
                bold: false
            }
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onHoveredChanged: {
                btnClose.color = "#00000000"
                btnRestore.color = trayOption.detailColor
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                btnRestore.color = "#00000000"
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                plugins.instance.restoreWindow()
                plugins.close()
            }
        }
    }

    Rectangle {
        id: btnClose
        y: btnRestore.y + btnRestore.height
        width: trayOption.width
        height: plugins.size * 3.8
        color: trayOption.detailColor
        //opacity: 0.8
        Text {
            id: textClose
            y: 12
            anchors.centerIn: parent
            text: "Sair"
            color: trayOption.tooltipColor
            font {
                pixelSize: plugins.size * 1.2
                bold: false
            }
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onHoveredChanged: {
                btnRestore.color = "#00000000"
                btnClose.color = trayOption.detailColor
                cursorShape = Qt.PointingHandCursor
            }
            onExited: {
                btnClose.color = "#00000000"
                cursorShape = Qt.ArrowCursor
            }
            onClicked: {
                plugins.instance.killWindow()
                plugins.close()
            }
        }
    }

	function atualize() {
        var w = textRestore.width + 30

        if (w < textClose.width + 30) {
            w = textClose.width + 30
        }

        btnRestore.width = w
        btnClose.width = w
        trayOption.width = btnRestore.width
        trayOption.height = btnRestore.height +
                      btnClose.height
	}
}
