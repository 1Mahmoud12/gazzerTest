import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/auth/presentation/views/reset_password_screen.dart';
import 'package:gazzer/features/auth/presentation/views/widgets/otp_widget.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final otp = TextEditingController();

  late Timer timer;
  late final ValueNotifier<int> seconds;

  setTimer() {
    seconds.value = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value <= 0) {
        timer.cancel();
      } else {
        seconds.value--;
      }
    });
  }

  @override
  void initState() {
    seconds = ValueNotifier<int>(60);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setTimer();
    });
    super.initState();
  }

  @override
  void dispose() {
    otp.dispose();
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
                children: [GradientText(text: "OTP verification", style: TStyle.mainwBold(32), gradient: Grad.textGradient)],
              ),
              const VerticalSpacing(8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text("An OTP was sent to verify your information.", maxLines: 2, style: TStyle.greySemi(16), textAlign: TextAlign.center),
              ),
              const VerticalSpacing(24),
              OtpWidget(controller: otp, count: 4, width: 60, height: 60, spacing: 32),
              const VerticalSpacing(24),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  Text("Didn't receive the code? ", style: TStyle.greySemi(16)),
                  ValueListenableBuilder(
                    valueListenable: seconds,
                    builder: (context, value, child) {
                      final finished = value <= 0;
                      return TextButton(
                        onPressed: finished ? () => setTimer() : null,
                        child: Text(
                          finished ? "Resend code" : "Resend in ${value}s",
                          style: TStyle.primarySemi(16).copyWith(color: finished ? Co.purple : Co.dark),
                        ),
                      );
                    },
                  ),
                ],
              ),
              VerticalSpacing(80),
              Hero(
                tag: Tags.btn,
                child: OptionBtn(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      context.myPush(const ResetPasswordScreen());
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
