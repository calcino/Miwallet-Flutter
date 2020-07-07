import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CustomRockPainter extends CustomPainter {
  final List<Color> gradientColor;

  const CustomRockPainter(
      [this.gradientColor = const [Color(0xffEEF4FB), Color(0xffFFFFFF)]]);

  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.moveTo(0, height * 0.15);
    path.lineTo(width * 0.15, 0);
    path.lineTo(width * 0.55, height * 0.3);
    path.lineTo(width * 0.9, height * 0.2);
    path.lineTo(width, height * 0.3);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(width / 2, 0), Offset(width / 2, height), gradientColor);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
