import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';

extension AlignmentLocale on Alignment {
  static Alignment centerStart(BuildContext ctx) {
    return L10n.isAr(ctx) ? Alignment.centerRight : Alignment.centerLeft;
  }

  static Alignment centerEnd(BuildContext ctx) {
    return L10n.isAr(ctx) ? Alignment.centerLeft : Alignment.centerRight;
  }

  static Alignment topStart(BuildContext ctx) {
    return L10n.isAr(ctx) ? Alignment.topRight : Alignment.topLeft;
  }

  static Alignment topEnd(BuildContext ctx) {
    return L10n.isAr(ctx) ? Alignment.topLeft : Alignment.topRight;
  }

  static Alignment bottomStart(BuildContext ctx) {
    return L10n.isAr(ctx) ? Alignment.bottomRight : Alignment.bottomLeft;
  }

  static Alignment bottomEnd(BuildContext ctx) {
    return L10n.isAr(ctx) ? Alignment.bottomLeft : Alignment.bottomRight;
  }
}
