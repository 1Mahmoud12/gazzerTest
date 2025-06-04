import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/widgets/main_phone_field.dart';
import 'package:gazzer/core/presentation/widgets/main_text_field.dart';
import 'package:gazzer/core/presentation/widgets/option_btn.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/auth/views/select_location_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  final social = [Assets.assetsSvgSocialFacebook, Assets.assetsSvgSocialGoogle, Assets.assetsSvgSocialApple];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Co.purple.withAlpha(50), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: AppConst.defaultHrPadding,
            children: [
              Center(child: SvgPicture.asset(Assets.assetsSvgCharacter, height: 130)),
              Row(
                children: [
                  GradientText(text: L10n.tr().signUp, style: TStyle.mainwBold(32), gradient: Grad.radialGradient),
                ],
              ),
              const VerticalSpacing(8),
              Text(L10n.tr().singUpToExploreWideVarietyOfProducts, maxLines: 2, style: TStyle.greySemi(16)),
              const VerticalSpacing(24),
              Text(L10n.tr().fullName, style: TStyle.blackBold(20)),
              const VerticalSpacing(8),
              MainTextField(
                controller: _nameController,
                hintText: L10n.tr().yourFullName,
                bgColor: Colors.transparent,
                validator: Validators.notEmpty,
              ),
              const VerticalSpacing(24),
              Text(L10n.tr().mobileNumber, style: TStyle.blackBold(20)),
              const VerticalSpacing(8),
              PhoneTextField(
                controller: _phoneController,
                validator: (v, code) {
                  if (code == 'EG') {
                    return Validators.mobileEGValidator(v);
                  }
                  return Validators.moreThanSix(v);
                },
              ),
              const VerticalSpacing(24),
              Hero(
                tag: Tags.btn,
                child: OptionBtn(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      context.myPush(const SelectLocationScreen());
                    }
                  },
                  text: L10n.tr().continu,
                  textStyle: TStyle.mainwSemi(15),
                  bgColor: Colors.transparent,
                ),
              ),
              const VerticalSpacing(24),
              Center(child: Text(L10n.tr().or, style: TStyle.greySemi(16))),
              const VerticalSpacing(10),
              Row(
                spacing: 16,
                children: List.generate(social.length, (index) {
                  return Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: SvgPicture.asset(social[index], height: 24),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
