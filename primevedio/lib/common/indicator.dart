import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primevedio/utils/ui_data.dart';

class StubTabIndicator extends Decoration {
  final BoxPainter _painter;
  StubTabIndicator({required Color color}) : _painter = StubPainter(color);

  @override
  BoxPainter createBoxPainter([void onChanged]) => _painter;
}

class StubPainter extends BoxPainter {
  final Paint _paint;

  StubPainter(Color color)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final double width = UIData.spaceSizeWith100;
    final double height = UIData.spaceSizeHeight40;
    final double radius = ScreenUtil().radius(48.7);
    final double left = offset.dx + cfg.size!.width / 2 - width / 2;
    canvas.drawRRect(
        RRect.fromLTRBR(
          left,
          cfg.size!.height - height,
          left + width,
          cfg.size!.height,
          Radius.circular(radius),
        ),
        _paint);
  }
}
