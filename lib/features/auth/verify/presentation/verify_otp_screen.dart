import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/auth/verify/domain/verify_repo.dart';
import 'package:gazzer/features/auth/verify/presentation/widgets/otp_widget.dart';
import 'package:go_router/go_router.dart';

part 'verify_otp_screen.g.dart';

@TypedGoRoute<VerifyOTPScreenRoute>(path: VerifyOTPScreen.route)
@immutable
class VerifyOTPScreenRoute extends GoRouteData with _$VerifyOTPScreenRoute {
  const VerifyOTPScreenRoute({
    required this.$extra,
    required this.initPhone,
    required this.data,
  });
  final (VerifyRepo repo, Function(BuildContext ctx) onSuccess) $extra;
  final String initPhone;
  final String data;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return VerifyOTPScreen(extra: $extra, initPhone: initPhone, data: data);
  }
}

class VerifyOTPScreen extends StatefulWidget {
  static const route = '/verify-otp';
  const VerifyOTPScreen({
    super.key,
    required this.extra,
    required this.initPhone,
    required this.data,
  });
  final String initPhone;
  final String data;
  final (VerifyRepo repo, Function(BuildContext ctx) onSuccess) extra;
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
  final counter = 60;
  late String phoneNumber;
  final showSupport = ValueNotifier<bool>(false);
  late final VerifyRepo repo;

  Future<void> resend() async {
    isResendingOtp.value = true;
    final res = await repo.resend(widget.data);
    switch (res) {
      case Ok<String> ok:
        Alerts.showToast(ok.value, error: false);
        _setTimer();
        break;
      case Err err:
        // Check if it's an OTP rate limit error
        if (err.error is OtpRateLimitError) {
          final rateLimitError = err.error as OtpRateLimitError;
          final remainingSeconds = rateLimitError.remainingSeconds.ceil();
          showSupport.value = true;
          _setTimer(counter: remainingSeconds);
          Alerts.showToast(rateLimitError.message);
        } else {
          showSupport.value = true;
          _setTimer(counter: 60 * 10);
          Alerts.showToast(err.error.message);
        }
    }
    isResendingOtp.value = false;
  }

  void _setTimer({int counter = 60}) {
    seconds.value = counter;
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
    repo = widget.extra.$1;
    phoneNumber = widget.initPhone;
    seconds = ValueNotifier<int>(counter);
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
              Center(
                child: SvgPicture.asset(Assets.assetsSvgCharacter, height: 130),
              ),
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
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Flexible(
              //       child: Text(
              //         "${L10n.tr().anOTPhasBeenSentTo} ${L10n.isAr(context) ? '' : '(+20)-'}$phoneNumber${!L10n.isAr(context) ? '' : '-(20+)'}",
              //         maxLines: 3,
              //         style: TStyle.greySemi(16),
              //         textAlign: TextAlign.start,
              //       ),
              //     ),
              //     if (repo.canChangePhone)
              //       TextButton(
              //         onPressed: () async {
              //           showModalBottomSheet(
              //             context: context,
              //             isScrollControlled: true,
              //             backgroundColor: Colors.transparent,
              //             builder: (context) {
              //               return ChangePhoneNumberSheet(
              //                 initialPhone: phoneNumber,
              //                 onConfirm: (val) async {
              //                   final res = await repo.onChangePhone(
              //                     val,
              //                     widget.data,
              //                   );
              //                   switch (res) {
              //                     case Ok<String> ok:
              //                       Alerts.showToast(ok.value, error: false);
              //                       if (context.mounted) {
              //                         setState(() => phoneNumber = val);
              //                         timer.cancel();
              //                         _setTimer();
              //                       }
              //                       return true;
              //                     case Err err:
              //                       Alerts.showToast(err.error.message);
              //                       return false;
              //                   }
              //                 },
              //               );
              //             },
              //           );
              //         },
              //         child: Text(
              //           L10n.tr().wrongNumber,
              //           style: TStyle.primaryBold(14),
              //         ),
              //       ),
              //   ],
              // ),
              const VerticalSpacing(24),
              OtpWidget(
                controller: otpCont,
                count: 6,
                width: 60,
                height: 50,
                spacing: 8,
              ),
              const VerticalSpacing(24),

              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.timer, color: Co.purple, size: 25),
                          const HorizontalSpacing(8),
                          Text(
                            L10n.tr().resendCode,
                            style: TStyle.primaryBold(14),
                          ),
                        ],
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: seconds,
                      builder: (context, value, child) {
                        final finished = value <= 0;
                        if (!finished) {
                          return Text(
                            "${value ~/ 60}:${(value % 60).toString().padLeft(2, '0')}",
                            textAlign: TextAlign.end,
                            style: TStyle.primarySemi(16).copyWith(
                              color: Co.tertiary,
                            ),
                          );
                        }

                        return ValueListenableBuilder(
                          valueListenable: isResendingOtp,
                          builder: (context, isResending, child) {
                            if (isResending) {
                              return const Center(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: AdaptiveProgressIndicator(),
                                ),
                              );
                            }

                            return InkWell(
                              onTap: () => resend(),

                              child: const Icon(
                                Icons.refresh,
                                color: Co.purple,
                                size: 24,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder(
                valueListenable: showSupport,
                builder: (context, value, child) => AnimatedScale(
                  scale: value ? 1 : 0,
                  duration: Durations.short4,
                  child: child,
                ),
                child: Column(
                  children: [
                    const Divider(),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => Helpers.callSupport(context),
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Row(
                            spacing: 12,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.phone,
                                size: 32,
                                color: Co.purple,
                              ),
                              Text(
                                L10n.tr().callSupport,
                                style: TStyle.primarySemi(16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const VerticalSpacing(80),
              SizedBox(
                height: 70,
                child: Hero(
                  tag: Tags.btn,
                  child: ValueListenableBuilder(
                    valueListenable: isSubmitting,
                    builder: (context, value, child) => OptionBtn(
                      isLoading: value,
                      onPressed: () async {
                        if (_formKey.currentState?.validate() != true) {
                          return Alerts.showToast(
                            L10n.tr().valueMustBeNum(6, L10n.tr().code),
                          );
                        }
                        isSubmitting.value = true;
                        final res = await repo.verify(
                          otpCont.text,
                          widget.data,
                        );
                        isSubmitting.value = false;
                        switch (res) {
                          case Ok<String> ok:
                            Alerts.showToast(ok.value, error: false);
                            if (context.mounted) widget.extra.$2(context);
                            break;
                          case Err err:
                            otpCont.clear();
                            Alerts.showToast(err.error.message);
                            break;
                        }
                      },
                      textStyle: TStyle.mainwSemi(15),
                      bgColor: Colors.transparent,
                      child: GradientText(
                        text: L10n.tr().continu,
                        style: TStyle.blackSemi(16),
                      ),
                    ),
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
