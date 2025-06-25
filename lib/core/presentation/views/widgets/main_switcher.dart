import 'package:flutter/material.dart';

extension ScaledSwither on Switch {
  withScale({double? scale, double? scalex, double? scaley, Alignment alignment = Alignment.center}) {
    if (scalex != null || scaley != null) {
      return Transform.scale(alignment: alignment, scaleX: scalex ?? scale, scaleY: scaley ?? scale, child: this);
    }
    return Transform.scale(alignment: alignment, scale: scale, child: this);
  }
}
