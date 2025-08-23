 import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  List<Offset> points;
  CurvePainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final strokePaint = Paint()
      ..color = const Color.fromRGBO(40, 60, 73, 1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = const Color.fromRGBO(80, 120, 160, 0.2) // same color, 20% opacity
      ..style = PaintingStyle.fill;

    // Create the stroke path
    final path = _createCatmullRomPath(points, 0.5);

    // Create a copy for the fill
    final fillPath = Path.from(path);

    // Complete the fill path by going down to bottom and back to start
    fillPath.lineTo(points.last.dx, 140); // down to bottom
    fillPath.lineTo(points[0].dx, 140);   // across to start X
    fillPath.close();

    // Draw filled area below the curve
    canvas.drawPath(fillPath, fillPaint);

    // Draw curve stroke
    canvas.drawPath(path, strokePaint);
  }

  Path _createCatmullRomPath(List<Offset> points, double tension) {
    final path = Path();
    if (points.length < 2) return path;

    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      Offset p0 = points[i];
      Offset p1 = points[i + 1];
      Offset midPoint = Offset(
        (p0.dx + p1.dx) / 2,
        (p0.dy + p1.dy) / 2,
      );

      path.quadraticBezierTo(p0.dx, p0.dy, midPoint.dx, midPoint.dy);
    }

    path.lineTo(points.last.dx, points.last.dy);
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
