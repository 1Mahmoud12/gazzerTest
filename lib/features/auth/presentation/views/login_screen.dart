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
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart'
    show PhoneTextField;
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/auth/presentation/views/select_location_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  final social = [Assets.assetsSvgFacebook, Assets.assetsSvgGoogle, Assets.assetsSvgApple];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ClassicAppBar(),
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
                children: [GradientText(text: "Log-in", style: TStyle.mainwBold(32), gradient: Grad.textGradient)],
              ),
              const VerticalSpacing(8),
              Text("Mobile Number", maxLines: 1, style: TStyle.greySemi(16)),
              const VerticalSpacing(24),
              AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(L10n.tr().mobileNumber, style: TStyle.blackBold(20)),
                    const VerticalSpacing(8),
                    PhoneTextField(
                      hasLabel: false,
                      hasHint: true,
                      controller: _phoneController,
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

              Center(
                child: Text(
                  "or", // L10n.tr().or,
                  style: TStyle.greyRegular(16),
                ),
              ),
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
              const VerticalSpacing(24),

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
                  child: GradientText(text: "Log in", style: TStyle.blackSemi(16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
