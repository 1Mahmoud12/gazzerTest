import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/widgets/main_phone_field.dart';
import 'package:gazzer/core/presentation/widgets/main_text_field.dart';
import 'package:gazzer/core/presentation/widgets/option_btn.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Co.burble.withAlpha(50), Colors.transparent],
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
                children: [GradientText(text: "Sign-Up", style: TStyle.mainwBold(32), gradient: Grad.radialGradient)],
              ),
              VerticalSpacing(8),
              Text("Sign-in to start exploring our wide variety of orders!", maxLines: 2, style: TStyle.greySemi(16)),
              VerticalSpacing(24),
              Text("Full Name", style: TStyle.blackBold(20)),
              VerticalSpacing(8),
              MainTextField(
                controller: _nameController,
                hintText: "Yout Full Name",
                bgColor: Colors.transparent,
                validator: Validators.notEmpty,
              ),
              VerticalSpacing(24),
              Text("Phone Number", style: TStyle.blackBold(20)),
              VerticalSpacing(8),
              PhoneTextField(
                validator: (v, code) {
                  if (code == 'EG') {
                    return Validators.mobileEGValidator(v);
                  }
                  return Validators.moreThanSix(v);
                },
              ),
              VerticalSpacing(24),
              OptionBtn(
                onPressed: () {
                  _formKey.currentState?.validate();
                },
                text: "Continue",
                textStyle: TStyle.mainwSemi(15),
                bgColor: Colors.transparent,
              ),
              VerticalSpacing(24),
              Center(child: Text("Or", style: TStyle.greyBold(16))),
            ],
          ),
        ),
      ),
    );
  }
}
