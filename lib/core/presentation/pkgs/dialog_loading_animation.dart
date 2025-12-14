import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

void animationDialogLoading([BuildContext? context]) {
  final targetContext = context ?? AppNavigator.mainKey.currentContext;
  if (targetContext == null) return;

  showDialog(
    context: targetContext,
    barrierColor: Colors.black26,
    barrierDismissible: false,
    useRootNavigator: true,
    builder: (dialogContext) => const Dialog(backgroundColor: Colors.transparent, child: LoadingWidget()),
  );
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.color});

  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 50, width: 50, child: SpinKitChasingDots(color: color ?? Co.purple));
  }
}

void closeDialog([BuildContext? context]) {
  final navigatorState = AppNavigator.mainKey.currentState;
  if (navigatorState != null && navigatorState.canPop()) {
    navigatorState.pop();
    return;
  }

  final targetContext = context ?? AppNavigator.mainKey.currentContext;
  if (targetContext == null) return;

  final navigator = Navigator.of(targetContext, rootNavigator: true);
  if (navigator.canPop()) {
    navigator.pop();
  }
}
