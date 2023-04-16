import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "./components/"

Item {
    id: wifi
    x: 0
    y: 0
    width: 0
    height: 0
    property int win: 0
    property string detailColor: "#ffffff"
    property string tooltipColor: "#ffffff"

    FontLoader {
        id: fontIcons
        name: "Font Awesome 5 Free"
        source: "qrc:fonts/Font Awesome 5 Free-Solid-900.otf"
    }

    Window {
        id: popup
        flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.WindowFullScreen
        width: Screen.width
        height: Screen.height
        color: "#00000000"

        Rectangle {
            anchors.fill: parent
            color: "#000"
            opacity: 0.9
        }

        Item {
            id: area
            x: parent.width / 2 - width / 2
            y: parent.height / 2 - height / 2
            width: plugins.size * 42
            height: plugins.size * 24
            clip: true
            opacity: 1

            Rectangle {
                anchors.fill: parent
                color: "#333" //window.tooltipBgColor
                opacity: 0.9 //window.tooltipOpc
            }

            Label {
                x: 10
                y: 4
                text: "\uf00d"
                font.bold: true
                font.pixelSize: plugins.size * 2.2
                font.family: fontIcons.name
                color: "#fff"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onHoveredChanged: {
                        cursorShape = Qt.PointingHandCursor
                    }
                    onExited: {
                        cursorShape = Qt.ArrowCursor
                    }
                    onClicked: {
                        popup.close()
                    }
                }
            }

            Label {
                id: closeSession
                x: (shutdown.x - shutdown.width) - 40
                y: shutdown.y
                text: "\uf2f1"
                font.bold: true
                font.pixelSize: shutdown.font.pixelSize
                font.family: fontIcons.name
                color: "#fff"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onHoveredChanged: {
                        closeSession.color = detailColor
                        cursorShape = Qt.PointingHandCursor
                    }
                    onExited: {
                        closeSession.color = "#fff"
                        cursorShape = Qt.ArrowCursor
                    }
                    onClicked: {
                        ContextPlugin.logoff()
                    }
                }

                Label {
                    y: closeSession.y + 40
                    x: (parent.width / 2) - (width / 2)
                    text: qsTr("Sessão")
                    font.pixelSize: plugins.size * 1.4
                    color: "#fff"
                }
            }

            Label {
                id: shutdown
                x: (parent.width / 2) - (width / 2)
                y: ((parent.height / 2) - (height / 2)) - 20
                text: "\uf011"
                font.bold: true
                font.pixelSize: plugins.size * 8
                font.family: fontIcons.name
                color: "#fff"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onHoveredChanged: {
                        shutdown.color = detailColor
                        cursorShape = Qt.PointingHandCursor
                    }
                    onExited: {
                        shutdown.color = "#fff"
                        cursorShape = Qt.ArrowCursor
                    }
                    onClicked: {
                        ContextPlugin.shutdown()
                    }
                }

                Label {
                    y: shutdown.y + 40
                    x: (parent.width / 2) - (width / 2)
                    text: qsTr("Desligar")
                    font.pixelSize: plugins.size * 1.4
                    color: "#fff"
                }
            }

            Label {
                id: restart
                x: shutdown.x + shutdown.width + 40
                y: shutdown.y
                text: "\uf2ea"
                font.bold: true
                font.pixelSize: shutdown.font.pixelSize
                font.family: fontIcons.name
                color: "#fff"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onHoveredChanged: {
                        restart.color = detailColor
                        cursorShape = Qt.PointingHandCursor
                    }
                    onExited: {
                        restart.color = "#fff"
                        cursorShape = Qt.ArrowCursor
                    }
                    onClicked: {
                        ContextPlugin.restart()
                    }
                }

                Label {
                    y: restart.y + 40
                    x: (parent.width / 2) - (width / 2)
                    text: qsTr("Reiniciar")
                    font.pixelSize: plugins.size * 1.4
                    color: "#fff"
                }
            }
        }
    }

    onVisibleChanged: {
        if (visible) {
            popup.showFullScreen()
        } else {
           popup.close()
        }
    }

    function atualize() {

    }
}
