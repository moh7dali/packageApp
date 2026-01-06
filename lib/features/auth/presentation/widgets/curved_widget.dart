import 'package:flutter/widgets.dart';

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double w = size.width;
    final double h = size.height;

    const double yTop = 0.0;

    final double yValley = h * 0.18;

    final path = Path()
      ..moveTo(0, yTop)
      ..quadraticBezierTo(w * 0.25, yValley, w * 0.5, yValley)
      ..quadraticBezierTo(w * 0.75, yValley, w, yTop)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
