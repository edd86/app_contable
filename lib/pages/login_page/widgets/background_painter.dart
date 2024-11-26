import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color.fromARGB(148, 104, 58, 183);
    final paint2 = Paint()..color = const Color.fromARGB(183, 255, 255, 255);

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.8, 0);
    path.lineTo(0, size.height * .35);
    path.close();
    canvas.drawPath(path, paint);

    final path2 = Path();
    path2.moveTo(size.width, 0);
    path2.lineTo(size.width, size.height * .05);
    path2.lineTo(0, size.height * .4);
    path2.lineTo(0, size.height * .375);
    path2.close();
    canvas.drawPath(path2, paint);

    final path3 = Path();
    path3.moveTo(size.width, size.height);
    path3.lineTo(0, size.height * .5);
    path3.lineTo(0, size.height * .725);
    path3.lineTo(size.width * .5, size.height);
    path3.close();
    canvas.drawPath(path3, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
