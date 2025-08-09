import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/auth/login/presentation/login_screen.dart';
import 'package:go_router/go_router.dart';

class UnAuthCartComponent extends StatelessWidget {
  const UnAuthCartComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(),
          Text(
            L10n.tr().pleaseLoginToUseCart,
            style: TStyle.primarySemi(16),
          ),
          const VerticalSpacing(24),
          MainBtn(
            onPressed: () {
              context.push(LoginScreen.route);
            },
            bgColor: Co.secondary,
            radius: 16,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: Row(
              spacing: 16,
              children: [
                const Icon(Icons.login_outlined, size: 20, color: Co.purple),
                Expanded(
                  child: Text(
                    L10n.tr().login,
                    style: TStyle.primaryBold(14, font: FFamily.inter),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
