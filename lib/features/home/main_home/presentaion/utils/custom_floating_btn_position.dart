import 'package:flutter/material.dart';

class CustomFloatingBtnPosition extends FloatingActionButtonLocation {
  final double topPadding;
  final double rightOffset;

  const CustomFloatingBtnPosition(this.topPadding, this.rightOffset);
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final isAr = scaffoldGeometry.textDirection == TextDirection.rtl;
    if (isAr) return Offset(rightOffset, topPadding);
    return Offset(
      scaffoldGeometry.scaffoldSize.width - rightOffset,
      topPadding,
    );
  }
}
