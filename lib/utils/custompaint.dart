import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/utils/functions.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.linear(
        Offset(size.width * 0.01, size.height * -0.01),
        Offset(size.width * 1.01, size.height * -0.01),
        [Color(0xff8700ff), Color(0xff9400ff), Color(0xff0069ff)],
        [0.00, 0.32, 1.00]);

    Path path0 = Path();
    path0.moveTo(size.width * 1.0060000, size.height * -0.0060000);
    path0.lineTo(size.width * 0.0110000, size.height * -0.0060000);
    path0.lineTo(size.width * 1.0060000, size.height * -0.0060000);
    path0.close();

    canvas.drawPath(path0, paint0);

    Paint paint1 = Paint()
      ..color = ThemeCol.mainColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path1 = Path();
    path1.moveTo(size.width * 0.5010000, size.height * -2.8447800);
    path1.cubicTo(
        size.width * 0.8447500,
        size.height * -2.8447800,
        size.width * 1.3606800,
        size.height * -2.3635600,
        size.width * 1.3606800,
        size.height * -1.1260000);
    path1.cubicTo(
        size.width * 1.3606800,
        size.height * -0.4384000,
        size.width * 1.1026600,
        size.height * 0.5927600,
        size.width * 0.5010000,
        size.height * 0.5927600);
    path1.cubicTo(
        size.width * 0.1572500,
        size.height * 0.5927600,
        size.width * -0.3586800,
        size.height * 0.0777600,
        size.width * -0.3586800,
        size.height * -1.1260000);
    path1.cubicTo(
        size.width * -0.3586800,
        size.height * -1.8131800,
        size.width * -0.1006600,
        size.height * -2.8447800,
        size.width * 0.5010000,
        size.height * -2.8447800);
    path1.close();

    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

Widget customHeader(BuildContext context) {
  return CustomPaint(
    size: Size(
        width(context),
        (width(context) * .2)
            .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
    painter: RPSCustomPainter(),
  );
}
