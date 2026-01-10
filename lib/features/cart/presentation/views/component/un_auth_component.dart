import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/auth/login/presentation/login_screen.dart';
import 'package:go_router/go_router.dart';

class UnAuthComponent extends StatelessWidget {
  const UnAuthComponent({super.key, required this.msg});
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(),
        Text(msg, style: context.style16500.copyWith(color: Co.purple)),
        const VerticalSpacing(24),
        MainBtn(
          onPressed: () {
            context.push(LoginScreen.route);
          },
          bgColor: Co.purple,
          radius: 16,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Row(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.login_outlined, size: 20, color: Co.white),

              Text(
                L10n.tr().login,
                style: context.style16400.copyWith(color: Co.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
