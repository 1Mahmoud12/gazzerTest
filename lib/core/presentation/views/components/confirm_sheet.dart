import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text.dart';
import 'package:go_router/go_router.dart';

class ConfirmSheet extends StatelessWidget {
  const ConfirmSheet({super.key, required this.btnText, required this.msg});
  final String btnText;
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        spacing: 24,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GradientText(
              text: msg,
              style: TStyle.robotBlackSubTitle().copyWith(color: Co.purple),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              context.pop(true);
            },
            style: OutlinedButton.styleFrom(
              fixedSize: const Size(250, 60),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(btnText, style: TStyle.robotBlackRegular14().copyWith(color: Co.purple)),
          ),
        ],
      ),
    );
  }
}
