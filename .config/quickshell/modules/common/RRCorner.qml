import QtQuick 2.9
import "internal"

Item {
    id: root

    property int size: 25
    property color color: "#000000"

    onColorChanged: {
        canvas.requestPaint();
    }

    property CornerEnum cornerEnum: CornerEnum {}

    property int corner: cornerEnum.topLeft // Default to TopLeft

    width: size
    height: size

    Canvas {
        id: canvas

        anchors.fill: parent
        antialiasing: true

        onPaint: {
            var ctx = getContext("2d");
            var r = root.size;

            ctx.beginPath();
            switch (root.corner) {
            case root.cornerEnum.topLeft:
                ctx.arc(r, r, r, Math.PI, 3 * Math.PI / 2);
                ctx.lineTo(0, 0);
                break;
            case root.cornerEnum.topRight:
                ctx.arc(0, r, r, 3 * Math.PI / 2, 2 * Math.PI);
                ctx.lineTo(r, 0);
                break;
            case root.cornerEnum.bottomLeft:
                ctx.arc(r, 0, r, Math.PI / 2, Math.PI);
                ctx.lineTo(0, r);
                break;
            case root.cornerEnum.bottomRight:
                ctx.arc(0, 0, r, 0, Math.PI / 2);
                ctx.lineTo(r, r);
                break;
            }
            ctx.closePath();
            ctx.fillStyle = root.color;
            ctx.fill();
        }
    }
}
