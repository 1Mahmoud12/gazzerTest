import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/image_background_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart' show MainTextField;
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/auth/forgot_password/presentation/forgot_password_btn.dart';
import 'package:gazzer/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:gazzer/features/auth/login/presentation/cubit/login_states.dart';
import 'package:gazzer/features/auth/register/presentation/view/register_screen.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:gazzer/features/intro/presentation/loading_screen.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const route = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneOrEmailController = TextEditingController();
  final _pasword = TextEditingController();
  TextInputFormatter? _inputFormatter;
  final social = [
    Assets.assetsSvgFacebook,
    Assets.assetsSvgGoogle,
    Assets.assetsSvgApple,
  ];

  @override
  void dispose() {
    _pasword.dispose();
    _phoneOrEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<LoginCubit>(),
      child: Builder(
        builder: (context) {
          return ImageBackgroundWidget(
            image: Assets.assetsPngLoginShape,
            child: Scaffold(
              backgroundColor: Colors.transparent,
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
                        child: SvgPicture.asset(
                          Assets.assetsSvgCharacter,
                          height: 130,
                        ),
                      ),
                      Row(
                        children: [
                          GradientText(
                            text: L10n.tr().login,
                            style: TStyle.mainwBold(32),
                            gradient: Grad().textGradient,
                          ),
                        ],
                      ),
                      // const VerticalSpacing(16),
                      // Text(
                      //   L10n.tr().howToLogin,
                      //   style: TStyle.blackSemi(16),
                      // ),
                      const VerticalSpacing(16),

                      AutofillGroup(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${L10n.tr().mobileNumber} / ${L10n.tr().emailAddress}',
                              maxLines: 1,
                              style: TStyle.greySemi(16),
                            ),
                            const VerticalSpacing(8),
                            MainTextField(
                              controller: _phoneOrEmailController,
                              hintText: '${L10n.tr().mobileNumber} / ${L10n.tr().emailAddress}',
                              bgColor: Colors.transparent,
                              max: 250,
                              inputFormatters: _inputFormatter,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return L10n.tr().thisFieldIsRequired;
                                }

                                final trimmedValue = value.trim();

                                // Check if first character is a digit (phone number)
                                if (RegExp(r'^\d').hasMatch(trimmedValue)) {
                                  // Phone validation
                                  if (!trimmedValue.startsWith('0')) {
                                    return L10n.tr().phoneMustStartWithZero;
                                  }
                                  if (trimmedValue.length != 11) {
                                    return L10n.tr().phoneMustBeElevenDigits;
                                  }
                                  if (!RegExp(
                                    r'^\d+$',
                                  ).hasMatch(trimmedValue)) {
                                    return L10n.tr().phoneMustContainOnlyDigits;
                                  }
                                  return null;
                                } else {
                                  // Email validation
                                  return Validators.emailValidator(
                                    trimmedValue,
                                  );
                                }
                              },
                              onChange: (value) {
                                // Update keyboard type based on first character
                                if (value.isNotEmpty) {
                                  final firstChar = value[0];
                                  if (RegExp(r'\d').hasMatch(firstChar)) {
                                    // First char is digit - switch to number keyboard
                                    if (_inputFormatter != FilteringTextInputFormatter.digitsOnly) {
                                      setState(() {
                                        _inputFormatter = FilteringTextInputFormatter.digitsOnly;
                                      });
                                    }
                                  } else {
                                    // First char is letter - switch to text keyboard
                                    if (_inputFormatter != null) {
                                      setState(() {
                                        _inputFormatter = null;
                                      });
                                    }
                                  }
                                } else {
                                  // Empty field - reset to text keyboard
                                  if (_inputFormatter != null) {
                                    setState(() {
                                      _inputFormatter = null;
                                    });
                                  }
                                }

                                // Remove spaces on the fly
                                if (value.contains(' ')) {
                                  final newValue = value.replaceAll(' ', '');
                                  _phoneOrEmailController.value = TextEditingValue(
                                    text: newValue,
                                    selection: TextSelection.collapsed(
                                      offset: newValue.length,
                                    ),
                                  );
                                }
                              },
                              autofillHints: [
                                AutofillHints.email,
                                AutofillHints.telephoneNumber,
                              ],
                            ),
                            const VerticalSpacing(16),
                            Text(
                              L10n.tr().password,
                              maxLines: 1,
                              style: TStyle.greySemi(16),
                            ),
                            const VerticalSpacing(8),
                            MainTextField(
                              controller: _pasword,
                              hintText: L10n.tr().enterYourPassword,
                              bgColor: Colors.transparent,
                              isPassword: true,
                              borderRadius: 32,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 16,
                              ),
                              validator: Validators.notEmpty,
                              autofillHints: [AutofillHints.newPassword],
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [ForgetPasswordBtn()],
                            ),
                          ],
                        ),
                      ),

                      // const VerticalSpacing(8),
                      BlocConsumer<LoginCubit, LoginStates>(
                        listener: (context, state) {
                          if (state is LoginSuccessState) {
                            Alerts.showToast(state.message, error: false);
                            const LoadingScreenRoute(
                              navigateToRoute: HomeScreen.route,
                            ).go(context);
                          } else if (state is LoginErrorState) {
                            Alerts.showToast(state.error);
                          }
                        },
                        builder: (context, state) => Hero(
                          tag: Tags.btn,
                          child: OptionBtn(
                            isLoading: state is LoginLoadingState,
                            onPressed: () {
                              if (_formKey.currentState?.validate() == true) {
                                TextInput.finishAutofillContext();
                                final input = _phoneOrEmailController.text.trim().replaceAll(' ', '');

                                // If it's a phone number (starts with digit), remove first char
                                final loginValue = RegExp(r'^\d').hasMatch(input) ? input.substring(1) : input;

                                context.read<LoginCubit>().login(
                                  loginValue,
                                  _pasword.text.trim(),
                                );
                              }
                            },
                            textStyle: TStyle.mainwSemi(15),
                            bgColor: Colors.transparent,
                            child: GradientText(
                              text: L10n.tr().login,
                              style: TStyle.blackSemi(16),
                            ),
                          ),
                        ),
                      ),
                      const VerticalSpacing(16),
                      Row(
                        spacing: 16,
                        children: [
                          Expanded(
                            child: OptionBtn(
                              onPressed: () {
                                if (Navigator.canPop(context)) return context.pop();
                                const LoadingScreenRoute(
                                  navigateToRoute: HomeScreen.route,
                                ).go(context);
                              },
                              textStyle: TStyle.mainwSemi(15),
                              bgColor: Colors.transparent,
                              child: Text(
                                L10n.tr().skip,
                                style: TStyle.primarySemi(16),
                              ),
                            ),
                          ),
                          Expanded(
                            child: OptionBtn(
                              onPressed: () {
                                context.push(RegisterScreen.route);
                              },
                              textStyle: TStyle.mainwSemi(15),
                              bgColor: Colors.transparent,
                              child: Text(
                                L10n.tr().signUp,
                                style: TStyle.primarySemi(16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // const VerticalSpacing(8),
                      // Center(child: Text(L10n.tr().or, style: TStyle.greyRegular(16))),
                      // const VerticalSpacing(8),
                      // const SocialAuthWidget(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
