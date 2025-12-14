import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';

class AdaptiveProgressIndicator extends StatelessWidget {
  const AdaptiveProgressIndicator({super.key, this.size, this.color});
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? 50,
      width: size ?? 50,
      child: Platform.isIOS ? CupertinoActivityIndicator(radius: (size ?? 30) / 2, color: color) : Center(child: LoadingWidget(color: color)),
    );
  }
}
