import QtQuick 2.12

Item {
	id: calendar
	x: 0
	y: 0
	width: 0
	height: 0
    property string detailColor: "#ffffff"
    property string tooltipColor: "#ffffff"
	Rectangle {
	    id: calendarTop
	    width: calendar.width
        height: plugins.size * 4.3
        color: calendar.detailColor
        //opacity: 0.8
	    Text {
            id: weekenday
            y: 12
            anchors.centerIn: parent
            color: calendar.tooltipColor
            font {
                pixelSize: plugins.size * 1.4
                bold: true
            }
	    }
	}
	Text {
	    id: day
	    y: calendarTop.height * 1
	    anchors.horizontalCenter: parent.horizontalCenter
        color: calendar.tooltipColor
        //opacity: 0.5
	    font {
            pixelSize: plugins.size * 5
            bold: true
	    }
	}
	Text {
	    id: mouthYear
        y: day.height * 1.8
	    anchors.horizontalCenter: parent.horizontalCenter
        color: calendar.tooltipColor
        //opacity: 0.5
	    font {
            pixelSize: plugins.size * 1.1
            bold: true
	    }
	}
	function atualize() {
	    var date = new Date().toLocaleDateString()
	    weekenday.text = date.split(',')[0]
	    day.text = date.split(' ')[1]
	    mouthYear.text = date.split(' ')[3] +
		             ' ' + date.split(' ')[4] +
		             ' ' + date.split(' ')[5]

	    calendarTop.width = mouthYear.width + 30
	    calendar.width = calendarTop.width
	    calendar.height = calendarTop.height +
		              day.height +
		              mouthYear.height + 30
	}
}
