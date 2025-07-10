import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';

extension AlignmentLocale on Alignment {
  static Alignment centerStart(BuildContext context) {
    return L10n.isAr(context) ? Alignment.centerRight : Alignment.centerLeft;
  }

  static Alignment centerEnd(BuildContext context) {
    return L10n.isAr(context) ? Alignment.centerLeft : Alignment.centerRight;
  }

  static Alignment topStart(BuildContext context) {
    return L10n.isAr(context) ? Alignment.topRight : Alignment.topLeft;
  }

  static Alignment topEnd(BuildContext context) {
    return L10n.isAr(context) ? Alignment.topLeft : Alignment.topRight;
  }

  static Alignment bottomStart(BuildContext context) {
    return L10n.isAr(context) ? Alignment.bottomRight : Alignment.bottomLeft;
  }

  static Alignment bottomEnd(BuildContext context) {
    return L10n.isAr(context) ? Alignment.bottomLeft : Alignment.bottomRight;
  }
}
