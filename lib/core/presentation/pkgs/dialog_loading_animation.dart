import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

void animationDialogLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black26,
    barrierDismissible: false,
    builder: (context) => const Dialog(
      backgroundColor: Colors.transparent,
      child: LoadingWidget(),
    ),
  );
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 50,
      width: 50,
      child: SpinKitChasingDots(
        color: Co.purple,
      ),
    );
  }
}

void closeDialog(BuildContext context) {
  Navigator.pop(context);
}
