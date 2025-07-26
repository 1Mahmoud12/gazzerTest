import 'package:flutter/material.dart';

part 'enum_parser.dart';

enum Corner { topLeft, topRight, bottomLeft, bottomRight }

extension AlignmentCorner on Corner {
  Alignment get alignment {
    switch (this) {
      case Corner.topLeft:
        return Alignment.topLeft;
      case Corner.topRight:
        return Alignment.topRight;
      case Corner.bottomLeft:
        return Alignment.bottomLeft;
      case Corner.bottomRight:
        return Alignment.bottomRight;
    }
  }
}

enum CardStyle {
  typeOne('One'),
  typeTwo('Two'),
  typeThree('Three'),
  typeFour('Four');

  final String type;

  const CardStyle(this.type);

  factory CardStyle.fromString(String type) {
    return CardStyle.values.firstWhere((e) => e.type == type, orElse: () => typeOne);
  }
}

enum LayoutType {
  horizontal('Horizontal'),
  vertical('Vertical'),
  grid('Grid');

  final String type;

  const LayoutType(this.type);

  factory LayoutType.fromString(String type) {
    return LayoutType.values.firstWhere((e) => e.type == type, orElse: () => horizontal);
  }
}
