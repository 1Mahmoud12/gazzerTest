import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/auth/forgot_password/domain/forgot_password_repo.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  static const route = '/reset-password';
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final isLading = ValueNotifier(false);

  Future<void> _resetPassword() async {
    isLading.value = true;
    final resp = await di<ForgotPasswordRepo>().resetPassword(password.text);
    isLading.value = false;
    switch (resp) {
      case final Ok<String> ok:
        Alerts.showToast(ok.value, error: false);
        if (mounted) context.pop();
        break;
      case final Err err:
        return Alerts.showToast(err.error.message);
    }
  }

  @override
  void dispose() {
    isLading.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ClassicAppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: AppConst.defaultHrPadding,
          children: [
            Center(
              child: SvgPicture.asset(Assets.assetsSvgCharacter, height: 130),
            ),
            Text(
              L10n.tr().resetPassword,
              style: context.style32700.copyWith(color: Co.purple),
              textAlign: TextAlign.center,
            ),
            const VerticalSpacing(32),
            AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(L10n.tr().password, style: context.style14400),
                  const VerticalSpacing(8),
                  MainTextField(
                    controller: password,
                    hintText: L10n.tr().yourNewPassword,
                    bgColor: Colors.transparent,
                    isPassword: true,
                    prefix: SvgPicture.asset(Assets.lockIc),

                    validator: Validators.passwordValidation,
                    autofillHints: const [AutofillHints.newPassword],
                  ),
                  const VerticalSpacing(16),
                  Text(L10n.tr().confirmPassword, style: context.style14400),
                  const VerticalSpacing(8),
                  MainTextField(
                    controller: confirmPassword,
                    hintText: L10n.tr().confirmNewPassword,
                    bgColor: Colors.transparent,
                    isPassword: true,
                    prefix: SvgPicture.asset(Assets.lockIc),

                    validator: (value) {
                      if (value != password.text) {
                        return L10n.tr().passwordsDoNotMatch;
                      }
                      return null;
                    },
                    autofillHints: const [AutofillHints.newPassword],
                  ),
                ],
              ),
            ),

            const VerticalSpacing(40),
            Hero(
              tag: Tags.btn,
              child: ValueListenableBuilder(
                valueListenable: isLading,
                builder: (context, value, child) => MainBtn(
                  isLoading: value,
                  onPressed: () {
                    if (_formKey.currentState?.validate() != true) return;
                    TextInput.finishAutofillContext();
                    _resetPassword();
                  },
                  text: L10n.tr().confirm,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
