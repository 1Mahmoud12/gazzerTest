import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/auth/common/widgets/change_phone_number_sheet.dart';
import 'package:gazzer/features/auth/verify/domain/verify_repo.dart';
import 'package:gazzer/features/auth/verify/presentation/widgets/otp_widget.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({
    super.key,
    required this.repo,
    required this.onSuccess,
    required this.initPhone,
    required this.data,
  });
  final VerifyRepo repo;
  final String initPhone;
  final String data;
  final Function(BuildContext ctx) onSuccess;
  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final _formKey = GlobalKey<FormState>();
  final otpCont = TextEditingController();
  final isResendingOtp = ValueNotifier<bool>(false);
  final isSubmitting = ValueNotifier<bool>(false);
  late Timer timer;
  late final ValueNotifier<int> seconds;
  late String phoneNumber;

  Future<void> resend() async {
    isResendingOtp.value = true;
    final res = await widget.repo.resend(widget.data);
    switch (res) {
      case Ok<String> ok:
        Alerts.showToast(ok.value, error: false);
        _setTimer();
        break;
      case Err err:
        Alerts.showToast(err.error.message);
    }
    isResendingOtp.value = false;
  }

  void _setTimer() {
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
    phoneNumber = widget.initPhone;
    seconds = ValueNotifier<int>(60);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setTimer();
    });
    super.initState();
  }

  @override
  void dispose() {
    otpCont.dispose();
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
                children: [
                  GradientText(
                    text: L10n.tr().otpVerification,
                    style: TStyle.mainwBold(32),
                    gradient: Grad().textGradient,
                  ),
                ],
              ),
              const VerticalSpacing(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    L10n.tr().anOTPhasBeenSentTo + "\n( +20$phoneNumber",
                    maxLines: 2,
                    style: TStyle.greySemi(16),
                    textAlign: TextAlign.start,
                  ),
                  if (widget.repo.canChangePhone)
                    TextButton(
                      onPressed: () async {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) {
                            return ChangePhoneNumberSheet(
                              initialPhone: phoneNumber,
                              onConfirm: (val) async {
                                final res = await widget.repo.onChangePhone(val, widget.data);
                                switch (res) {
                                  case Ok<String> ok:
                                    Alerts.showToast(ok.value, error: false);
                                    if (context.mounted) {
                                      setState(() => phoneNumber = val);
                                      timer.cancel();
                                      _setTimer();
                                    }
                                    return true;
                                  case Err err:
                                    Alerts.showToast(err.error.message);
                                    return false;
                                }
                              },
                            );
                          },
                        );
                      },
                      child: Text(L10n.tr().wrongNumber, style: TStyle.primaryBold(16)),
                    ),
                ],
              ),
              const VerticalSpacing(24),
              OtpWidget(controller: otpCont, count: 6, width: 60, height: 50, spacing: 8),
              const VerticalSpacing(24),
              Row(
                children: [
                  const Icon(Icons.message, color: Co.purple, size: 32),
                  const HorizontalSpacing(12),
                  Text(
                    L10n.tr().resendCode,
                    style: TStyle.primaryBold(14),
                  ),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: isResendingOtp,
                      builder: (context, value, child) {
                        return Row(
                          mainAxisAlignment: value ? MainAxisAlignment.center : MainAxisAlignment.end,
                          children: [
                            !value ? child! : const SizedBox(height: 32, width: 32, child: AdaptiveProgressIndicator()),
                          ],
                        );
                      },
                      child: ValueListenableBuilder(
                        valueListenable: seconds,
                        builder: (context, value, child) {
                          final finished = value <= 0;
                          return TextButton(
                            onPressed: finished ? () => resend() : null,

                            child: Text(
                              finished ? L10n.tr().resendCode : "${value ~/ 60}:${(value % 60).toString().padLeft(2, '0')}",
                              textAlign: TextAlign.end,
                              style: TStyle.primarySemi(16).copyWith(color: finished ? Co.purple : Co.tertiary),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox.shrink(),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Row(
                      spacing: 12,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.wifi_calling_3, size: 32, color: Co.purple),
                        Text(L10n.tr().support),
                      ],
                    ),
                  ),
                ],
              ),
              const VerticalSpacing(80),
              Hero(
                tag: Tags.btn,
                child: ValueListenableBuilder(
                  valueListenable: isSubmitting,
                  builder: (context, value, child) => OptionBtn(
                    isLoading: value,
                    onPressed: () async {
                      if (_formKey.currentState?.validate() != true) {
                        return Alerts.showToast(L10n.tr().valueMustBeNum(6, L10n.tr().code));
                      }
                      isSubmitting.value = true;
                      final res = await widget.repo.verify(otpCont.text, widget.data);
                      isSubmitting.value = false;
                      switch (res) {
                        case Ok<String> ok:
                          Alerts.showToast(ok.value, error: false);
                          if (context.mounted) widget.onSuccess(context);
                          break;
                        case Err err:
                          otpCont.clear();
                          Alerts.showToast(err.error.message);
                          break;
                      }
                    },
                    textStyle: TStyle.mainwSemi(15),
                    bgColor: Colors.transparent,
                    child: GradientText(text: L10n.tr().continu, style: TStyle.blackSemi(16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
