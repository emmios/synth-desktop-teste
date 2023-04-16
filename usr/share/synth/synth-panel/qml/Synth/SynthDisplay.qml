import QtQuick 2.12

Item {
    id: root
    x: 0
    y: 0
    width: dsize
    height: dsize

    property double dsize: plugins.size * 14
    property int displayCount: 2
    property int displaySelected: 0
    property string detailColor: "#ffffff"
    property string tooltipColor: "#ffffff"

    GridView {
        id: gridDisplay
        anchors.fill: parent
        contentWidth: parent.width
        cellWidth: parent.width / 2
        cellHeight: parent.width / 2
        model: 0

        delegate: Item {
            id: item
            width: parent.width / 2
            height: parent.width / 2
            Rectangle {
                anchors.fill: parent
                anchors.margins: item.width / 22
                color: root.tooltipColor
                opacity: 0.2
            }
            Item {
                id: btnAdd
                anchors.fill: parent
                anchors.margins: item.width / 22
                property bool less: index === (gridDisplay.count - 1) ? true : index === (gridDisplay.count - 2) ? true : false
                property bool more: index === (gridDisplay.count - 1) ? true : false

                Text {
                    text: index + 1
                    anchors.centerIn: parent
                    color: root.displaySelected === index ? root.detailColor : root.tooltipColor
                    visible: index === (gridDisplay.count - 1) || index === (gridDisplay.count - 2) ? false : true
                    //opacity: 0.5
                    font {
                        pixelSize: plugins.size * 2.6
                        bold: true
                    }
                }
                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width / 3
                    height: parent.width / 10
                    radius: (parent.width / 3) / 2
                    color: root.tooltipColor
                    visible: btnAdd.less
                }
                Rectangle {
                    anchors.centerIn: parent
                    width: parent.width / 10
                    height: parent.width / 3
                    radius: (parent.width / 3) / 2
                    color: root.tooltipColor
                    visible: btnAdd.more
                }
                MouseArea {
                    anchors.fill: parent
                    anchors.margins: item.width / 22
                    hoverEnabled: true
                    onHoveredChanged: {
                        //exit.enabled = false
                        cursorShape = Qt.PointingHandCursor
                    }
                    onExited: {
                        cursorShape = Qt.ArrowCursor
                        //exit.enabled = true
                    }
                    onClicked: {
                        if (index === (gridDisplay.count - 1)) {
                            gridDisplay.model += 1
                        } else if (index === (gridDisplay.count - 2)) {
                            if (index > 1) gridDisplay.model -= 1
                        } else {
                            root.displaySelected = index
                            ContextPlugin.displaychange(index)
                        }
                    }
                }
            }
        }

        onModelChanged: {
            ContextPlugin.displayadd(count - 2)
            parent.displayCount = count - 2
        }
    }

    function atualize() {
        ContextPlugin.displayadd(root.displayCount)
        gridDisplay.model = root.displayCount + 2
        root.width = root.dsize
        root.height = root.dsize
        gridDisplay.contentHeight = root.dsize * gridDisplay.count
    }

    Component.onCompleted: {
        atualize()
    }
}
