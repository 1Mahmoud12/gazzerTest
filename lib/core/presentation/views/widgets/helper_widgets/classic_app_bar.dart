import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/main_back_icon.dart';

class ClassicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ClassicAppBar({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Navigator.canPop(context) ? MainBackIcon(color: color) : null,
      leadingWidth: 65,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
