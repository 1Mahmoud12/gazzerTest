import 'package:flutter/material.dart';

class ClassicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ClassicAppBar({super.key, this.showCart = true});
  final bool showCart;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Navigator.canPop(context) ? IconButton(onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back_ios)) : null,
      leadingWidth: 65,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
