import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';

class ClassicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ClassicAppBar({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Navigator.canPop(context)
          ? IconButton(
              onPressed: () {
                SystemSound.play(SystemSoundType.click);
                Navigator.maybePop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: color,
              ),
            )
          : null,
      leadingWidth: 65,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
