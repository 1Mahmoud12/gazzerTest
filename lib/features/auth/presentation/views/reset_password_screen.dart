import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/auth/presentation/views/select_location_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  void dispose() {
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ClassicAppBar(),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Co.purple.withAlpha(50), Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: AppConst.defaultHrPadding,
            children: [
              Center(child: SvgPicture.asset(Assets.assetsSvgCharacter, height: 130)),
              Row(
                children: [GradientText(text: "Reset Password", style: TStyle.mainwBold(32), gradient: Grad.textGradient)],
              ),
              const VerticalSpacing(8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text("Sign in to start exploring our wide variety of Groceries.", maxLines: 2, style: TStyle.greySemi(16), textAlign: TextAlign.center),
              ),
              const VerticalSpacing(32),
              AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Password", style: TStyle.blackBold(20)),
                    const VerticalSpacing(8),
                    MainTextField(
                      controller: password,
                      hintText: "Your New Password",
                      bgColor: Colors.transparent,
                      isPassword: true,
                      validator: Validators.moreThanSix,
                      autofillHints: [AutofillHints.newPassword],
                    ),
                    const VerticalSpacing(32),
                    Text("Confirm Password", style: TStyle.blackBold(20)),
                    const VerticalSpacing(8),
                    MainTextField(
                      controller: confirmPassword,
                      hintText: "Confirm New Password",
                      bgColor: Colors.transparent,
                      isPassword: true,
                      validator: (v) {
                        if (v != password.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                      autofillHints: [AutofillHints.newPassword],
                    ),
                  ],
                ),
              ),

              const VerticalSpacing(70),
              Hero(
                tag: Tags.btn,
                child: OptionBtn(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      TextInput.finishAutofillContext();
                      context.myPush(const SelectLocationScreen());
                    }
                  },
                  textStyle: TStyle.mainwSemi(15),
                  bgColor: Colors.transparent,
                  child: GradientText(text: "Continue", style: TStyle.blackSemi(16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
