import 'package:flutter/widgets.dart';

class AppConst {
  AppConst._();
  static final navKey = GlobalKey<NavigatorState>();
  static final defaultRadius = 16.0;
  static final defaultInnerRadius = 32.0;
  static final defaultBorderRadius = BorderRadius.circular(defaultRadius);
  static final defaultInnerBorderRadius = BorderRadius.circular(defaultInnerRadius);
  static final defaultPadding = EdgeInsets.all(16.0);
  static final defaultHrPadding = EdgeInsets.symmetric(horizontal: 16.0);

}
