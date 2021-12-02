import 'package:flutter/cupertino.dart';

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // path.moveTo(0, size.height * 0.25);
    // path.lineTo(0, size.height * 0.8);
    // path.quadraticBezierTo(0, size.height, size.width * 0.1, size.height);
    // path.lineTo(size.width * 0.9, size.height);
    // path.quadraticBezierTo(
    //     size.width, size.height, size.width, size.height * 0.8);
    //
    // path.lineTo(size.width, size.height * 0.25);
    // path.quadraticBezierTo(size.width, 0, size.width / 3, 0);
    // path.lineTo(size.width / 2, 0);
    // path.moveTo(size.width * 0.6, 0);
    // path.quadraticBezierTo(0, 0, 0, size.height * 0.25);
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width * 0.05, size.height * 0.1);
    path.quadraticBezierTo(0, size.height * 0.15, 0, size.height * 0.2);
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(0, size.height, size.width * 0.1, size.height);
    path.lineTo(size.width * 0.9, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height * 0.8);
    path.lineTo(size.width, size.height * 0.2);
    path.quadraticBezierTo(
        size.width, size.height * 0.15, size.width * 0.95, size.height * 0.1);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

@immutable
class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  const ClipShadowPath({
    Key? key,
    required this.shadow,
    required this.clipper,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      key: UniqueKey(),
      painter: _ClipShadowShadowPainter(
        clipper: clipper,
        shadow: shadow,
      ),
      child: ClipPath(child: child, clipper: clipper),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
