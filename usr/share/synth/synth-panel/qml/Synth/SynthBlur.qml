import QtQuick 2.12
import QtGraphicalEffects 1.12

Rectangle {
    id: blur
    property var target: null
    property int croptype: 0
    property bool refresh: false
    property bool start: true
    property alias time: blurTimer
    property string source: ""
    property alias blurradius: fastBlur.radius
    property alias saturation: saturation.saturation
    property alias colorLayer: layer.color
    property alias colorOpc: layer.opacity
    property bool previewborder: false
    property bool aside: false
    color: "#00000000"
    clip: true
    onSourceChanged: {
        imgBlur.source = source
    }
    Image {
        id: imgBlur
        anchors.fill: parent
        visible: false
        cache: true
    }

    FastBlur {
        id: fastBlur
        anchors.fill: imgBlur
        source: imgBlur
        radius: 60
        visible: false
    }
    HueSaturation {
        id: saturation
        anchors.fill: imgBlur
        source: fastBlur
        hue: 0
        saturation: 0.8
        lightness: 0
        visible: true
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: imgBlur.width
                height: imgBlur.height
                Rectangle {
                    anchors.centerIn: parent
                    width: imgBlur.width
                    height: imgBlur.height
                    radius: blur.radius
                }
            }
        }
    }
    Rectangle {
        id: layer
        anchors.fill: parent
        color: "#000000"
        opacity: 0.5
        radius: parent.radius
    }
    Image {
        id: noise
        anchors.fill: parent
        opacity: 0.1
        cache: true
        source: "qrc:/resources/noise.png"
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: noise.width
                height: noise.height
                Rectangle {
                    anchors.centerIn: parent
                    width: noise.width
                    height: noise.height
                    radius: blur.radius
                }
            }
        }
    }
    border {
        width: previewborder ? 1 : 0
        color: "#ffffff"
    }
    Timer {
        id: blurTimer
        running: false
        interval: 2000
        repeat: refresh
        onTriggered: {
            var result = context.getThumbToBlur(target, croptype)
            if (result) {
                var parts = result.split('|')
                source = parts[1]
                if (aside) {
                    var geo = parts[0].split('-')
                    imgBlur.x = geo[0]
                    imgBlur.y = geo[1]
                    imgBlur.width = geo[2]
                    imgBlur.height = geo[3]
                }
            }
        }
    }
    Component.onCompleted: {
        if (start) {
            blurTimer.stop()
            blurTimer.start()
        }
    }
}
