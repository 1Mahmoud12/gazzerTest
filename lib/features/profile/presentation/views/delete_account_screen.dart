import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:gazzer/features/auth/login/presentation/login_screen.dart';
import 'package:gazzer/features/auth/verify/presentation/widgets/otp_widget.dart';
import 'package:gazzer/features/profile/data/models/delete_account_req.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_states.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key, required this.sessionId});
  final String sessionId;
  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  int? selectedId;
  late final ProfileCubit cubit;
  final reasonController = TextEditingController();
  final otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Timer timer;
  late final ValueNotifier<int> seconds;
  final counter = 60;
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
    cubit = context.read<ProfileCubit>();
    seconds = ValueNotifier(counter);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getDeleteAccountReasons();
      _setTimer();
    });
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    reasonController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ClassicAppBar(),
      body: Padding(
        padding: AppConst.defaultHrPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpacing(12),
            GradientText(
              text: L10n.tr().reason,
              style: TStyle.blackBold(16),
            ),
            Divider(height: 33, color: Co.purple.withAlpha(120)),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(color: Co.white, borderRadius: AppConst.defaultBorderRadius),
                child: BlocBuilder<ProfileCubit, ProfileStates>(
                  buildWhen: (previous, current) => current is FetchDeleteAccountReasonsLoading || previous is FetchDeleteAccountReasonsLoading,
                  builder: (context, state) {
                    if (state is FetchDeleteAccountReasonsLoading) {
                      return const Center(child: AdaptiveProgressIndicator());
                    } else if (state is FetchDeleteAccountReasonsSuccess) {
                      final items = state.reasons;
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: items.length + 1,
                        itemBuilder: (context, index) {
                          if (index == items.length) {
                            return RadioListTile(
                              value: -1,
                              groupValue: selectedId,
                              splashRadius: AppConst.defaultRadius,
                              contentPadding: EdgeInsets.zero,
                              title: Text(L10n.tr().other),
                              onChanged: (value) {
                                setState(() => selectedId = value);
                              },
                            );
                          }
                          return RadioListTile(
                            value: items[index].id,
                            title: Text(items[index].reason),
                            splashRadius: AppConst.defaultRadius,
                            contentPadding: EdgeInsets.zero,
                            groupValue: selectedId,
                            onChanged: (value) {
                              reasonController.clear();
                              setState(() => selectedId = value);
                            },
                          );
                        },
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
            const VerticalSpacing(12),
            Form(
              key: _formKey,
              child: MainTextField(
                enabled: selectedId == -1,
                showBorder: false,
                bgColor: Co.white,
                disabledColor: Colors.grey,
                controller: reasonController,
                hintText: L10n.tr().reason,
                validator: (v) => selectedId != -1 ? null : Validators.valueAtLeastNum(v, L10n.tr().reason, 10),
              ),
            ),
            Divider(height: 25, color: Co.purple.withAlpha(120)),

            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "${L10n.tr().anOTPhasBeenSentTo} +20${cubit.client?.phoneNumber}",
                        maxLines: 3,
                        style: TStyle.greySemi(14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    BlocBuilder<ProfileCubit, ProfileStates>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: state is RequestDeleteAccountLoading ? MainAxisAlignment.center : MainAxisAlignment.end,
                          children: [
                            state is RequestDeleteAccountLoading
                                ? const SizedBox(height: 32, width: 32, child: AdaptiveProgressIndicator())
                                : ValueListenableBuilder(
                                    valueListenable: seconds,
                                    builder: (context, value, child) {
                                      final finished = value <= 0;
                                      return TextButton(
                                        onPressed: finished ? () => cubit.requestDeleteAccount() : null,
                                        child: Row(
                                          children: [
                                            Text(
                                              L10n.tr().resendCode,
                                              style: TStyle.primarySemi(16).copyWith(color: Co.purple),
                                            ),
                                            if (!finished)
                                              ConstrainedBox(
                                                constraints: const BoxConstraints(minWidth: 45),
                                                child: Text(
                                                  " ${value ~/ 60}:${(value % 60).toString().padLeft(2, '0')}",
                                                  style: TStyle.primarySemi(16).copyWith(color: Co.tertiary),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                const VerticalSpacing(6),
                OtpWidget(controller: otpController, count: 6, width: 60, height: 50, spacing: 8),
                const VerticalSpacing(12),
              ],
            ),
            BlocConsumer<ProfileCubit, ProfileStates>(
              listener: (context, state) {
                if (state is DeleteAccountError) {
                  Alerts.showToast(state.message);
                } else if (state is DeleteAccountSuccess) {
                  Alerts.showToast(state.message, isInfo: true);
                  AppNavigator().pushAndRemoveUntil(
                    BlocProvider(create: (context) => di<LoginCubit>(), child: const LoginScreen()),
                    parent: Parent.main,
                  );
                }
              },
              builder: (context, state) => MainBtn(
                isLoading: state is DeleteAccountLoading,
                onPressed: () {
                  if (_formKey.currentState?.validate() != true) return;
                  if (otpController.text.length != 6) {
                    return Alerts.showToast(L10n.tr().valueMustBeNum(6, L10n.tr().code));
                  }
                  cubit.confirmDeleteAccount(
                    DeleteAccountReq(
                      otpCode: otpController.text.trim(),
                      reasonId: selectedId == -1 ? null : selectedId,
                      sessionId: widget.sessionId,
                      reasonText: selectedId == -1 ? reasonController.text.trim() : null,
                    ),
                  );
                },

                bgColor: Colors.transparent,
                borderColor: Co.secondary,
                radius: AppConst.defaultRadius,
                textStyle: TStyle.secondarySemi(14),
                text: L10n.tr().deleteAccount,
              ),
            ),
            const VerticalSpacing(12),
          ],
        ),
      ),
    );
  }
}
