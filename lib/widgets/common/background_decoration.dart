import 'package:flutter/material.dart';

import '../../configs/themes/app_colors.dart';

class BackgroundDecoration extends StatelessWidget {
  final Widget child;
  final bool showGradient;

  const BackgroundDecoration(
      {super.key, this.showGradient = false, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: showGradient ? null : Theme.of(context).primaryColor,
              gradient: showGradient ? mainGradient() : null,
            ),
            child: CustomPaint(
              painter: BackgroundPainter(),
            ),
          ),
        ),
        Positioned.fill(child: SafeArea(child: child)),
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white.withOpacity(.1);
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * .2, 0);
    path.lineTo(0, size.height * .4);
    path.close();
    canvas.drawPath(path, paint);

     final path1 = Path();
    path1.moveTo(size.width, 0);
    path1.lineTo(size.width * .8, 0);
    path1.lineTo(size.width*.2, size.height);
    path1.lineTo(size.width, size.height);
    path1.close();
    canvas.drawPath(path1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}