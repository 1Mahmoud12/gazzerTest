import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/option_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/auth/verify/presentation/widgets/otp_widget.dart';
import 'package:gazzer/features/profile/data/models/profile_verify_otp_req.dart';
import 'package:gazzer/features/profile/data/models/update_profile_req.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_states.dart';
import 'package:go_router/go_router.dart';

class ProfileVerifyOtpScreen extends StatefulWidget {
  const ProfileVerifyOtpScreen({super.key, required this.sessionId, required this.req});
  final String sessionId;
  final UpdateProfileReq req;
  @override
  State<ProfileVerifyOtpScreen> createState() => _ProfileVerifyOtpScreenState();
}

class _ProfileVerifyOtpScreenState extends State<ProfileVerifyOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final otpCont = TextEditingController();
  late Timer timer;
  late final ValueNotifier<int> seconds;
  late String phoneNumber;
  late String sessionId;
  final counter = 30;

  Future<void> resend() async {
    final result = await context.read<ProfileCubit>().updateProfile(widget.req);
    if (result) {
      Alerts.showToast(L10n.tr().otpSentSuccessfully, error: false);
      _setTimer();
    }
  }

  void _setTimer() {
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
    sessionId = widget.sessionId;
    phoneNumber = widget.req.phone;
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
      backgroundColor: Colors.transparent,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: Co.white, borderRadius: AppConst.defaultBorderRadius),
              child: Padding(
                padding: const EdgeInsetsGeometry.symmetric(vertical: 32, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${L10n.tr().anOTPhasBeenSentTo} (+20)-$phoneNumber",
                      maxLines: 2,
                      style: TStyle.greySemi(16),
                      textAlign: TextAlign.start,
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
                          child: BlocConsumer<ProfileCubit, ProfileStates>(
                            listener: (context, state) {
                              if (state is UpdateSuccessWithSession) {
                                sessionId = state.sessionId;
                              }
                            },
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment: state is UpdateProfileLoading
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.end,
                                children: [
                                  state is! UpdateProfileLoading
                                      ? ValueListenableBuilder(
                                          valueListenable: seconds,
                                          builder: (context, value, child) {
                                            final finished = value <= 0;
                                            return TextButton(
                                              onPressed: finished ? () => resend() : null,

                                              child: Text(
                                                finished
                                                    ? L10n.tr().resendCode
                                                    : "${value ~/ 60}:${(value % 60).toString().padLeft(2, '0')}",
                                                textAlign: TextAlign.end,
                                                style: TStyle.primarySemi(
                                                  16,
                                                ).copyWith(color: finished ? Co.purple : Co.tertiary),
                                              ),
                                            );
                                          },
                                        )
                                      : const SizedBox(height: 32, width: 32, child: AdaptiveProgressIndicator()),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox.shrink(),
                      ],
                    ),

                    const VerticalSpacing(20),
                    BlocConsumer<ProfileCubit, ProfileStates>(
                      listener: (context, state) {
                        if (state is VerifyOTPSuccess) {
                          Alerts.showToast(state.message, error: false);
                          context.pop();
                        } else if (state is VerifyOTPError) {
                          Alerts.showToast(state.message);
                        }
                      },
                      builder: (context, state) => OptionBtn(
                        isLoading: state is VerifyOTPLoading,
                        onPressed: () async {
                          if (_formKey.currentState?.validate() != true) {
                            return Alerts.showToast(L10n.tr().valueMustBeNum(6, L10n.tr().code));
                          }
                          context.read<ProfileCubit>().verifyOtp(
                            ProfileVerifyOtpReq(otpCode: otpCont.text, sessionId: sessionId),
                          );
                        },
                        textStyle: TStyle.mainwSemi(15),
                        bgColor: Colors.transparent,
                        child: Text(L10n.tr().continu, style: TStyle.primarySemi(16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
