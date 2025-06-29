import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart' show MainTextField, PhoneTextField;
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/auth/presentation/views/otp_screen.dart';
import 'package:gazzer/features/auth/presentation/views/widgets/social_auth_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
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
                children: [GradientText(text: L10n.tr().signUp, style: TStyle.mainwBold(32), gradient: Grad.textGradient)],
              ),
              const VerticalSpacing(8),
              Text(L10n.tr().singUpToExploreWideVarietyOfProducts, maxLines: 2, style: TStyle.greySemi(16)),
              const VerticalSpacing(24),
              AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(L10n.tr().fullName, style: TStyle.blackBold(20)),
                    const VerticalSpacing(8),
                    MainTextField(
                      controller: _nameController,
                      hintText: L10n.tr().yourFullName,
                      bgColor: Colors.transparent,
                      validator: Validators.notEmpty,
                      autofillHints: [AutofillHints.username, AutofillHints.name],
                    ),
                    const VerticalSpacing(24),
                    Text(L10n.tr().mobileNumber, style: TStyle.blackBold(20)),
                    const VerticalSpacing(8),
                    PhoneTextField(
                      controller: _phoneController,
                      hasLabel: false,
                      hasHint: true,
                      validator: (v, code) {
                        if (code == 'EG') {
                          return Validators.mobileEGValidator(v);
                        }
                        return Validators.moreThanSix(v);
                      },
                    ),
                  ],
                ),
              ),
              const VerticalSpacing(24),
              const VerticalSpacing(24),
              Hero(
                tag: Tags.btn,
                child: OptionBtn(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      TextInput.finishAutofillContext();
                      context.myPush(const OtpScreen());
                    }
                  },
                  textStyle: TStyle.mainwSemi(15),
                  bgColor: Colors.transparent,
                  child: GradientText(text: L10n.tr().continu, style: TStyle.blackSemi(16)),
                ),
              ),
              const VerticalSpacing(24),
              Center(
                child: Text(
                  "or", // L10n.tr().or,
                  style: TStyle.greyRegular(16),
                ),
              ),
              const VerticalSpacing(10),
              const SocialAuthWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
