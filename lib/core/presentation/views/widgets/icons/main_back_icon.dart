import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';

class MainBackIcon extends StatelessWidget {
  const MainBackIcon({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        SystemSound.play(SystemSoundType.click);
        Navigator.maybePop(context);
      },
      icon: Icon(Icons.arrow_back_ios, color: color),
    );
  }
}
