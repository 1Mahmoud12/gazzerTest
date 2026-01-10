import 'package:flutter/widgets.dart';

class HomeUtils {
  static double headerWidth(BuildContext context) => (MediaQuery.sizeOf(context).width * 1.29) > 570 ? 570 : MediaQuery.sizeOf(context).width * 1.29;
  static double headerHeight(BuildContext context) => headerWidth(context) * 0.42 + MediaQuery.viewPaddingOf(context).top;
}
