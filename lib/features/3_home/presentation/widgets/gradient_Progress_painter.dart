



import 'package:flutter/material.dart';

class GradientProgressPainter extends CustomPainter {
  final double progress;
  final Gradient gradient;
  final Paint _paint;

  GradientProgressPainter({
    required this.progress,
    required this.gradient,
  }) : _paint = Paint()
    ..style = PaintingStyle.fill
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width * progress, size.height);
    _paint.shader = gradient.createShader(rect);
    canvas.drawRect(rect, _paint);
  }

  @override
  bool shouldRepaint(GradientProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}