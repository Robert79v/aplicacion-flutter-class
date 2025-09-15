import 'package:flutter/material.dart';
import 'dart:math' as math;

final String heart = 'assets/heart.png';
final String weapon = 'assets/weapon.png';
final String shield = 'assets/shield.png';

class AttributeWidget extends StatelessWidget {
  final double size;
  final double progress;
  final Widget? child;

  const AttributeWidget({
    Key? key,
    required this.progress,
    this.size = 45, 
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Colores según el tema
    final Color bgColor = isDark ? Color.fromARGB(255, 35, 2, 56) : const Color.fromARGB(255, 4, 50, 83); //Morado para dark, blanco para light
    final Color strokeFilledColor = isDark ? Colors.white : const Color.fromARGB(255, 255, 255, 255); // Blanco para dark, negro para light
    final Color strokeBgColor = isDark
        ? Colors.white.withOpacity(0.25) // contorno para dark
        : Colors.black.withOpacity(0.25); // contorno para light

    return CustomPaint(
      painter: AttributePainter(
        progressPercent: progress,
        bgColor: bgColor,
        strokeBgColor: strokeBgColor,
        strokeFilledColor: strokeFilledColor,
      ),
      size: Size(size, size),
      child: Container(
        padding: EdgeInsets.all(size / 5.5),
        width: size,
        height: size,
        child: child,
      ),
    );
  }
}

class AttributePainter extends CustomPainter {
  final double progressPercent;
  final double strokeWidth, filledStrokeWidth;

  final Color bgColor;
  final Color strokeBgColor;
  final Color strokeFilledColor;

  AttributePainter({
    required this.progressPercent,
    this.strokeWidth = 2.0,
    this.filledStrokeWidth = 4.0,
    required this.bgColor,
    required this.strokeBgColor,
    required this.strokeFilledColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final bgPaint = Paint()..color = bgColor;
    final strokeBgPaint = Paint()..color = strokeBgColor;
    final strokeFilledPaint = Paint()
      ..color = strokeFilledColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = filledStrokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawCircle(center, radius - strokeWidth, strokeBgPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - (strokeWidth / 2)),
      -math.pi / 2,
      (progressPercent / 100) * math.pi * 2,
      false,
      strokeFilledPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
