import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/option_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/auth/login/presentation/login_screen.dart';
import 'package:gazzer/features/auth/verify/presentation/widgets/otp_widget.dart';
import 'package:gazzer/features/profile/data/models/delete_account_req.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_states.dart';
import 'package:go_router/go_router.dart';

class DeleteAccountSheet extends StatefulWidget {
  const DeleteAccountSheet({super.key, required this.req, this.initialRemainingSeconds});
  final DeleteAccountReq req;
  final int? initialRemainingSeconds;
  @override
  State<DeleteAccountSheet> createState() => _DeleteAccountSheetState();
}

class _DeleteAccountSheetState extends State<DeleteAccountSheet> {
  final _formKey = GlobalKey<FormState>();
  final otpCont = TextEditingController();
  late Timer timer;
  late final ValueNotifier<int> seconds;
  late DeleteAccountReq req;
  final counter = 30;
  final showSupport = ValueNotifier<bool>(false);

  void _setTimer({int? counter}) {
    final initialValue = counter ?? this.counter;
    seconds.value = initialValue;
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
    req = widget.req.copyWith();
    final initialCounter = widget.initialRemainingSeconds ?? counter;
    seconds = ValueNotifier<int>(initialCounter);
    if (widget.initialRemainingSeconds != null) {
      showSupport.value = true;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setTimer(counter: initialCounter);
    });
    super.initState();
  }

  @override
  void dispose() {
    otpCont.dispose();
    seconds.dispose();
    showSupport.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is DeleteAccountSuccess) {
            Alerts.showToast(state.message, error: false);
            Session().clear();
            context.go(LoginScreen.route);
          } else if (state is DeleteAccountError) {
            Alerts.showToast(state.message);
          }
        },
        builder: (context, state) => Column(
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
                      "${L10n.tr().anOTPhasBeenSentTo} ${L10n.isAr(context) ? '' : '(+20)-'}${Session().client?.phoneNumber ?? ''}${!L10n.isAr(context) ? '' : '-(20+)'}",
                      maxLines: 2,
                      style: TStyle.robotBlackThin().copyWith(color: Co.darkGrey, fontWeight: TStyle.medium),
                      textAlign: TextAlign.start,
                    ),
                    const VerticalSpacing(24),
                    Form(
                      key: _formKey,

                      child: OtpWidget(controller: otpCont, count: 6, width: 60, height: 50, spacing: 8),
                    ),
                    const VerticalSpacing(24),
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.timer, color: Co.purple, size: 25),
                                const HorizontalSpacing(8),
                                Text(L10n.tr().resendCode, style: context.style14400.copyWith(color: Co.purple)),
                              ],
                            ),
                          ),
                          BlocConsumer<ProfileCubit, ProfileStates>(
                            listener: (context, state) {
                              if (state is RequestDeleteAccountSuccess) {
                                req = req.copyWith(sessionId: state.sessionId);
                                _setTimer();
                                Alerts.showToast(L10n.tr().otpSentSuccessfully, error: false);
                              } else if (state is RequestDeleteAccountRateLimitError) {
                                // Handle rate limit error with remaining seconds
                                showSupport.value = true;
                                _setTimer(counter: state.remainingSeconds);
                                Alerts.showToast(state.message);
                              }
                            },
                            builder: (context, state) {
                              if (state is RequestDeleteAccountLoading) {
                                return const Center(child: SizedBox(height: 50, width: 50, child: AdaptiveProgressIndicator()));
                              }

                              return ValueListenableBuilder(
                                valueListenable: seconds,
                                builder: (context, value, child) {
                                  final finished = value <= 0;
                                  if (!finished) {
                                    return Text(
                                      "${value ~/ 60}:${(value % 60).toString().padLeft(2, '0')}",
                                      textAlign: TextAlign.end,
                                      style: TStyle.robotBlackMedium().copyWith(color: Co.purple),
                                    );
                                  }

                                  return InkWell(
                                    onTap: () => context.read<ProfileCubit>().requestDeleteAccount(),
                                    child: const Icon(Icons.refresh, color: Co.purple, size: 24),
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
                      builder: (context, value, child) =>
                          AnimatedScale(scale: value ? 1 : 0, duration: const Duration(milliseconds: 200), child: child),
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
                                    const Icon(Icons.phone, size: 32, color: Co.purple),
                                    Text(L10n.tr().callSupport, style: TStyle.robotBlackMedium().copyWith(color: Co.purple)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const VerticalSpacing(20),
                    OptionBtn(
                      isLoading: state is DeleteAccountLoading,
                      onPressed: () async {
                        if (_formKey.currentState?.validate() != true) {
                          return Alerts.showToast(L10n.tr().valueMustBeNum(6, L10n.tr().code));
                        }
                        final newReq = req.copyWith(otpCode: otpCont.text.trim());
                        context.read<ProfileCubit>().confirmDeleteAccount(newReq);
                      },
                      textStyle: context.style14400.copyWith(fontWeight: TStyle.semi),
                      bgColor: Colors.transparent,
                      child: Text(L10n.tr().continu, style: TStyle.robotBlackMedium().copyWith(color: Co.purple)),
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
