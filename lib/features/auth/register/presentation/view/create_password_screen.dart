import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/auth/common/widgets/change_phone_number_sheet.dart';
import 'package:gazzer/features/auth/common/widgets/select_location_screen.dart';
import 'package:gazzer/features/auth/register/data/register_request.dart';
import 'package:gazzer/features/auth/register/domain/register_repo.dart';
import 'package:gazzer/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:gazzer/features/auth/register/presentation/cubit/register_states.dart';
import 'package:gazzer/features/auth/verify/presentation/verify_otp_screen.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key, required this.req});
  final RegisterRequest req;
  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  late RegisterRequest req;

  @override
  void initState() {
    req = widget.req;
    super.initState();
  }

  @override
  void dispose() {
    password.dispose();
    confirmPassword.dispose();
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
                    text: L10n.tr().createPassword,
                    style: TStyle.mainwBold(32),
                    gradient: Grad.textGradient,
                  ),
                ],
              ),
              const VerticalSpacing(8),
              Row(
                children: [
                  Text(
                    L10n.tr().createPasswordToVerify,
                    maxLines: 2,
                    style: TStyle.greySemi(16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return ChangePhoneNumberSheet(
                            initialPhone: widget.req.phone,
                            onConfirm: (val) async {
                              req = req.copyWith(phone: val);
                              return true;
                            },
                          );
                        },
                      );
                    },
                    child: Text(L10n.tr().wrongNumber, style: TStyle.primaryBold(16)),
                  ),
                ],
              ),
              const VerticalSpacing(32),
              AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(L10n.tr().password, style: TStyle.blackBold(20)),
                    const VerticalSpacing(8),
                    MainTextField(
                      controller: password,
                      hintText: L10n.tr().yourNewPassword,
                      bgColor: Colors.transparent,
                      isPassword: true,
                      validator: Validators.passwordValidation,
                      autofillHints: [AutofillHints.newPassword],
                    ),
                    const VerticalSpacing(32),
                    Text(L10n.tr().confirmPassword, style: TStyle.blackBold(20)),
                    const VerticalSpacing(8),
                    MainTextField(
                      controller: confirmPassword,
                      hintText: L10n.tr().confirmNewPassword,
                      bgColor: Colors.transparent,
                      isPassword: true,
                      validator: (value) {
                        if (value != password.text) {
                          return L10n.tr().passwordsDoNotMatch;
                        }
                        return null;
                      },
                      autofillHints: [AutofillHints.newPassword],
                    ),
                  ],
                ),
              ),

              const VerticalSpacing(70),
              BlocConsumer<RegisterCubit, RegisterStates>(
                listener: (context, state) {
                  if (state is RegisterSuccess) {
                    Alerts.showToast(state.resp.msg, error: false);
                    context.myPush(
                      VerifyOTPScreen(
                        initPhone: req.phone,
                        repo: di<RegisterRepo>(),
                        data: state.resp.sessionId ?? '',
                        onSuccess: (ctx) => ctx.myPushAndRemoveUntil(const SelectLocationScreen()),
                      ),
                    );
                  } else if (state is RegisterError) {
                    if (state.error.message != null) Alerts.showToast(state.error.message!);
                  }
                },
                builder: (context, state) => Hero(
                  tag: Tags.btn,
                  child: OptionBtn(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        TextInput.finishAutofillContext();
                        req = req.copyWith(
                          password: password.text,
                          passwordConfirmation: confirmPassword.text,
                        );
                        context.read<RegisterCubit>().register(req);
                      }
                    },
                    isLoading: state is RegisterLoading,
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
