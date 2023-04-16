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
    property var redes: null
    property var wifilist: null

    FontLoader {
        id: fontIcons
        name: "Font Awesome 5 Free"
        source: "qrc:fonts/Font Awesome 5 Free-Solid-900.otf"
    }

    onRedesChanged: {
        if (redes) {
            console.log("redes", redes)
        }
    }

    onWifilistChanged: {
        listModel.clear()

        if (wifilist) {
            var parts = wifilist.split(';')

            for (var i = 2; i < parts.length; i++) {
                var part = parts[i].split(',') // 5
                if (part[0] === "*") {
                    listModel.append({'connected': true, 'signal': part[1], 'security': part[2] === "--" ? false : true, 'ssid': part[3], 'ifname': part[4], 'add': part[5]})
                } else {
                    listModel.append({'connected': false, 'signal': part[0], 'security': part[1] === "--" ? false : true, 'ssid': part[2], 'ifname': part[3], 'add': part[4]})
                }
            }
        }
    }

    ListModel {
        id: listModel
    }

    ListView {
        id: listView
        anchors.fill: parent
        model: listModel
        delegate: Item {
            id: item
            width: parent.width
            height: plugins.size * 3.2
            clip: true
            Rectangle {
                id: bg
                anchors.fill: parent
                color: "#00000000"
            }
            Text {
                id: name
                y: parent.height / 2 - height / 2
                x: 12
                text: signal + "\uf295 " + (security ? "\uf023" : "\uf09c") + (connected ? " \uf058 " : "  ") + ssid
                color: tooltipColor
                font.bold: true
                font.pixelSize: plugins.size * 1.4
                font.family: fontIcons.name
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onHoveredChanged: {
                    bg.color = detailColor
                    cursorShape = Qt.PointingHandCursor
                }
                onExited: {
                    bg.color = "#00000000"
                    cursorShape = Qt.ArrowCursor
                }
                onClicked: {
                    popup.showFullScreen()
                    popup.connectText = connected  ? "Desconectar" : "Conectar"
                    popup.isPassword = connected ? false : security
                    popup.title = ssid
                    popup.ssid = ssid
                    popup.isConnected = connected ? 1 : 0
                    popup.ifname = ifname
                    popup.add = add
                }
            }
        }
    }

    Window {
        id: popup
        flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.WindowFullScreen
        width: Screen.width
        height: Screen.height
        color: "#00000000"

        property int isConnected: 0
        property string ssid: ""
        property string  ifname: ""
        property int add: 0
        property alias isPassword: textField.visible
        property alias connectText: btnConnect.text

        Rectangle {
            anchors.fill: parent
            color: "#000"
            opacity: 0.9
        }

        Item {
            id: area
            x: parent.width / 2 - width / 2
            y: parent.height / 2 - height / 2
            width: 0
            height: 300
            clip: true
            opacity: 1

            Rectangle {
                anchors.fill: parent
                color: "#333" //window.tooltipBgColor
                opacity: 1 //window.tooltipOpc
            }
            /*
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    textField.text = ""
                    textField.input.echoMode = TextInput.Normal
                    textField.input.forceActiveFocus()
                }
            }*/

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

            Text {
                id: redeName
                y: 24
                x: parent.width / 2 - width / 2
                text: popup.ssid
                color: "#fff" //wifi.tooltipColor
                font.bold: true
                font.pixelSize: plugins.size * 1.6
                onTextChanged: {
                    if (textField.visible) {
                        textField.text = ""
                        textField.input.forceActiveFocus()
                        btnCancel.y = textField.y + textField.height + 24
                        btnConnect.y = textField.y + textField.height + 24
                    } else {
                        btnCancel.y = redeName.y + redeName.height + 24
                        btnConnect.y = redeName.y + redeName.height + 24
                    }

                    var w = text.length * (plugins.size * 1.6)
                    area.width = w > 300 ? w : 300
                    area.height = btnConnect.y + btnConnect.height + 24
                }
            }

            TextField {
                id: textField
                y: redeName.y + redeName.height + 24
                x: 20
                width: parent.width - 40
                height: redeName.height + 12
                text: ""
                textColor: "#fff" //wifi.tooltipColor
                detailColor: wifi.detailColor
                border {color: "#ccc"; width: 1}
                maxLength: 512
                size: plugins.size * 1.2
                visible: false
                clip: true
                input.echoMode: TextInput.Password
                input.focus: true
                input.cursorVisible: true
                onVisibleChanged: {
                    if (visible) textField.input.forceActiveFocus()
                }
                onClicked: {
                    textField.input.forceActiveFocus()
                }
            }

            Button {
                id: btnCancel
                x: 20
                y: textField.y + textField.height + 24
                text: "Esquecer"
                textColor: "#fff" //wifi.tooltipColor
                detailColor: wifi.detailColor
                size: plugins.size * 1.1
                onClick: {
                    window.toRemove(popup.ssid, popup.isCoonected)
                    popup.close()
                }
            }

            Button {
                id: btnConnect
                x: (parent.width - width) - 20
                y: textField.y + textField.height + 24
                text: "Conectar"
                textColor: "#fff" //wifi.tooltipColor
                detailColor: wifi.detailColor
                size: plugins.size * 1.1
                onClick: {
                    window.toConnect(popup.ssid, textField.text, popup.ifname, popup.add, popup.isConnected)
                    popup.close()
                }
            }
        }
    }

    function atualize() {
        wifi.width = 20 * plugins.size
        wifi.height = listModel.count * (plugins.size * 3.2)
    }
}
