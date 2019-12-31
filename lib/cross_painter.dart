import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CrossPainter extends CustomPainter {
  Paint _paint;
  double lineOneFraction = 0, lineTwoFraction = 0;

  CrossPainter(this.lineOneFraction, this.lineTwoFraction) {
    _paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(
      size.topLeft(Offset.zero),
      size.bottomRight(Offset.zero) * lineOneFraction,
      _paint,
    );
    canvas.drawLine(
      size.topRight(Offset.zero),
      Offset.lerp(size.topRight(Offset.zero), size.bottomLeft(Offset.zero),
          lineTwoFraction),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate.hashCode != hashCode;
  }
}
