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

enum CardType {
  typeOne('One'),
  typeTwo('Two'),
  typeThree('Three'),
  typeFour('Four');

  final String type;

  const CardType(this.type);

  factory CardType.fromString(String type) {
    return CardType.values.firstWhere((e) => e.type == type, orElse: () => typeOne);
  }
}
