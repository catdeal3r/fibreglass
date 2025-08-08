import QtQuick
import QtQuick.Shapes

Item {
    id: root

    enum CornerEnum { TopLeft, TopRight, BottomLeft, BottomRight }
    property var corner: RRCorner.CornerEnum.TopLeft // Default to TopLeft

    property int size: 25
    property color color: "#000000"

    implicitWidth: size
    implicitHeight: size

    Shape {
        anchors.fill: parent
        layer.enabled: true
        layer.smooth: true
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            id: shapePath
            strokeWidth: 0

            fillColor: root.color
            startX: switch (root.corner) {
                case RRCorner.CornerEnum.TopLeft: return 0;
                case RRCorner.CornerEnum.TopRight: return root.size;
                case RRCorner.CornerEnum.BottomLeft: return 0;
                case RRCorner.CornerEnum.BottomRight: return root.size;
            }
            startY: switch (root.corner) {
                case RRCorner.CornerEnum.TopLeft: return 0;
                case RRCorner.CornerEnum.TopRight: return 0;
                case RRCorner.CornerEnum.BottomLeft: return root.size;
                case RRCorner.CornerEnum.BottomRight: return root.size;
            }
            PathAngleArc {
                moveToStart: false
                centerX: root.size - shapePath.startX
                centerY: root.size - shapePath.startY
                radiusX: root.size
                radiusY: root.size
                startAngle: switch (root.corner) {
                    case RRCorner.CornerEnum.TopLeft: return 180;
                    case RRCorner.CornerEnum.TopRight: return -90;
                    case RRCorner.CornerEnum.BottomLeft: return 90;
                    case RRCorner.CornerEnum.BottomRight: return 0;
                }
                sweepAngle: 90
            }
            PathLine {
                x: shapePath.startX
                y: shapePath.startY
            }
        }
    }
}
