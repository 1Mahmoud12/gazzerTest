import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/components/loading_full_screen.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/decoration_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/failure_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/profile/data/models/delete_account_req.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_states.dart';
import 'package:gazzer/features/profile/presentation/views/component/delete_account_confirm_sheet.dart';
import 'package:gazzer/features/profile/presentation/views/component/delete_account_otp_sheet.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'delete_account_screen.g.dart';

@TypedGoRoute<DeleteAccountRoute>(path: DeleteAccountScreen.routeWzCubit)
@immutable
class DeleteAccountRoute extends GoRouteData with _$DeleteAccountRoute {
  const DeleteAccountRoute({required this.$extra});
  final ProfileCubit $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider.value(value: $extra, child: const DeleteAccountScreen());
  }
}

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});
  static const routeWzCubit = '/delete-account';
  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  int? reasonId;
  late final ProfileCubit cubit;
  final reasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    cubit = context.read<ProfileCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getDeleteAccountReasons();
    });
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is RequestDeleteAccountSuccess) {
          if (ModalRoute.of(context)?.isCurrent != true) return;
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            useSafeArea: true,
            builder: (context) {
              return BlocProvider.value(
                value: cubit,
                child: DeleteAccountSheet(
                  req: DeleteAccountReq(
                    otpCode: '',
                    sessionId: state.sessionId,
                    reasonId: reasonId,
                    reasonText: reasonController.text.trim(),
                  ),
                ),
              );
            },
          );
        } else if (state is RequestDeleteAccountError) {
          Alerts.showToast(state.message);
        }
      },
      buildWhen: (previous, current) => current is RequestDeleteAccountLoading || previous is RequestDeleteAccountLoading,
      builder: (context, state) => LoadingFullScreen(
        isLoading: state is RequestDeleteAccountLoading,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: const ClassicAppBar(color: Colors.white),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DoubledDecoratedWidget(
                borderRadius: BorderRadius.zero,
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.paddingOf(context).top + kToolbarHeight + 50,
                  child: Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Padding(
                      padding: AppConst.defaultPadding,
                      child: Text(
                        L10n.tr().deleteAccount,
                        style: TStyle.secondarySemi(20),
                      ),
                    ),
                  ),
                ),
              ),
              const VerticalSpacing(12),
              Padding(
                padding: AppConst.defaultHrPadding,
                child: Column(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: L10n.tr().whyAreYouDeletingYourAccount,
                          ),
                          const TextSpan(text: '\n'),
                          TextSpan(
                            text: L10n.tr().thisFeedbackHelpsUsImproveOurServices,
                            style: TStyle.greySemi(12),
                          ),
                        ],
                        style: TStyle.blackBold(14).copyWith(height: 1.7),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<ProfileCubit, ProfileStates>(
                  buildWhen: (previous, current) => current is FetchDeleteAccountReasonsLoading || previous is FetchDeleteAccountReasonsLoading,
                  builder: (context, state) {
                    if (state is FetchDeleteAccountReasonsError) {
                      return FailureWidget(
                        message: state.message,
                        onRetry: () => cubit.getDeleteAccountReasons(),
                      );
                    } else {
                      final items = state is FetchDeleteAccountReasonsSuccess ? state.reasons : Fakers().reasons;
                      return Skeletonizer(
                        effect: const PulseEffect(),
                        containersColor: Co.secText,
                        enabled: state is FetchDeleteAccountReasonsLoading,
                        child: ListView.builder(
                          padding: AppConst.defaultPadding,
                          itemCount: items.length + 1,
                          itemBuilder: (context, index) {
                            if (index == items.length) {
                              return RadioListTile(
                                value: -1,
                                groupValue: reasonId,
                                splashRadius: AppConst.defaultRadius,
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  L10n.tr().otherReason,
                                  style: TStyle.blackBold(14),
                                ),
                                onChanged: (value) {
                                  setState(() => reasonId = value);
                                },
                              );
                            }
                            return RadioListTile(
                              value: items[index].id,

                              subtitle: Text(items[index].description, style: TStyle.greySemi(12)),
                              title: Text(
                                items[index].title,
                                style: TStyle.blackBold(14),
                              ),
                              splashRadius: AppConst.defaultRadius,
                              contentPadding: EdgeInsets.zero,
                              groupValue: reasonId,
                              onChanged: (value) {
                                reasonController.clear();
                                setState(() => reasonId = value);
                              },
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
              const VerticalSpacing(12),
              Padding(
                padding: AppConst.defaultHrPadding,
                child: Column(
                  spacing: 24,
                  children: [
                    Form(
                      key: _formKey,
                      child: FocusScope(
                        onFocusChange: (hasFocus) {
                          if (hasFocus) {
                            setState(() {
                              reasonId = -1;
                            });
                          }
                        },
                        child: MainTextField(
                          maxLines: 3,
                          action: TextInputAction.done,
                          bgColor: Colors.transparent,
                          controller: reasonController,
                          hintText: L10n.tr().reason,
                          validator: (v) => reasonId != -1 ? null : Validators.valueAtLeastNum(v, L10n.tr().reason, 10),
                        ),
                      ),
                    ),
                    SafeArea(
                      top: false,
                      left: false,
                      right: false,
                      bottom: true,
                      child: MainBtn(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() != true) return;
                          if (reasonId == null) {
                            Alerts.showToast(L10n.tr().pleaseSelectReason);
                            return;
                          }
                          final res = await showModalBottomSheet<bool>(
                            context: context,
                            useSafeArea: true,
                            constraints: const BoxConstraints(minHeight: 250),
                            builder: (context) {
                              return const DeleteAccountConfirmSheet();
                            },
                          );
                          if (res == true) cubit.requestDeleteAccount();
                        },

                        radius: AppConst.defaultRadius,
                        textStyle: TStyle.secondarySemi(14),
                        text: L10n.tr().continu,
                      ),
                    ),
                  ],
                ),
              ),

              const VerticalSpacing(12),
            ],
          ),
        ),
      ),
    );
  }
}
