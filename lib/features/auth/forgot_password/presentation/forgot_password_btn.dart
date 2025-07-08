import 'package:flutter/material.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/auth/common/widgets/change_phone_number_sheet.dart';
import 'package:gazzer/features/auth/forgot_password/domain/forgot_password_repo.dart';
import 'package:gazzer/features/auth/forgot_password/presentation/reset_password_screen.dart';
import 'package:gazzer/features/auth/verify/presentation/verify_otp_screen.dart';

class ForgetPasswordBtn extends StatelessWidget {
  const ForgetPasswordBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        ///
        bool isSentOtp = false;
        String phone = '';

        ///
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return ChangePhoneNumberSheet(
              initialPhone: null,
              title: L10n.tr().enterYourMobileNumber,
              onConfirm: (val) async {
                final res = await di<ForgotPasswordRepo>().forgotPassword(val);
                switch (res) {
                  case Ok<String> ok:
                    isSentOtp = true;
                    phone = val;
                    Alerts.showToast(ok.value, error: false);
                    return true;
                  case Error err:
                    Alerts.showToast(err.error.message ?? ' ');
                    return false;
                }
              },
            );
          },
        );

        ///
        if (isSentOtp && context.mounted) {
          context.myPush(
            VerifyOTPScreen(
              repo: di<ForgotPasswordRepo>(),
              initPhone: phone,
              onSuccess: (ctx) => ctx.myPushReplacement(const ResetPasswordScreen()),
            ),
          );
        }
      },
      style: TextButton.styleFrom(minimumSize: Size.zero),
      child: Text(L10n.tr().forgotPassword, style: TStyle.primaryBold(12)),
    );
  }
}
