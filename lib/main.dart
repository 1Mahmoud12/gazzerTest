import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/widgets/main_text_field.dart';
import 'package:gazzer/gazzer_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.light,
      systemStatusBarContrastEnforced: true,
    ),
  );
  runApp(const GazzerApp());
}
