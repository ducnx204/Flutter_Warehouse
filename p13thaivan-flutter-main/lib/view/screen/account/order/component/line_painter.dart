import 'package:flutter/material.dart';

class LineDashedPainter extends CustomPainter {
  Color color;

  LineDashedPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..color = color;
    var max = 40;
    const dashWidth = 5;
    const dashSpace = 5;
    double startY = 0;
    while (max >= 0) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      const space = dashSpace + dashWidth;
      startY += space;
      max -= space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
