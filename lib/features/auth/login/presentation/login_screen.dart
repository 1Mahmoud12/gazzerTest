import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
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
  final social = [Assets.assetsSvgFacebook, Assets.assetsSvgGoogle, Assets.assetsSvgApple];

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
          return Scaffold(
            appBar: const ClassicAppBar(),
            body: Form(
              key: _formKey,
              child: ListView(
                padding: AppConst.defaultHrPadding,
                children: [
                  Center(child: SvgPicture.asset(Assets.assetsSvgCharacter, height: 130)),
                  Text(
                    L10n.tr().welcomeToGazzer,
                    style: TStyle.robotBlackHead().copyWith(color: Co.purple),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    L10n.tr().createYourAccountOrLogin,
                    style: TStyle.robotBlackSmall().copyWith(color: Co.gr100),
                    textAlign: TextAlign.center,
                  ),
                  // Row(
                  //   children: [GradientText(text: L10n.tr().login, style: TStyle.mainwBold(32), gradient: Grad().textGradient)],
                  // ),
                  // const VerticalSpacing(16),
                  // Text(
                  //   L10n.tr().howToLogin,
                  //   style: TStyle.robotBlackMedium(),
                  // ),
                  const VerticalSpacing(32),

                  AutofillGroup(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${L10n.tr().mobileNumber} / ${L10n.tr().emailAddress}', maxLines: 1, style: context.style14400),
                        const VerticalSpacing(8),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: MainTextField(
                            controller: _phoneOrEmailController,
                            hintText: '${L10n.tr().mobileNumber} / ${L10n.tr().emailAddress}',
                            bgColor: Colors.transparent,
                            max: 250,
                            inputFormatters: _inputFormatter != null ? [_inputFormatter!] : null,
                            keyboardType: TextInputType.visiblePassword,
                            borderColor: Co.borderColor,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return L10n.tr().thisFieldIsRequired;
                              }

                              final trimmedValue = value.trim();

                              // Check if first character is a digit (phone number)
                              if (RegExp(r'^\d').hasMatch(trimmedValue)) {
                                // Phone validation
                                String phoneNumber = trimmedValue;
                                // Remove leading 0 if exists
                                if (phoneNumber.startsWith('0')) {
                                  phoneNumber = phoneNumber.substring(1);
                                }
                                // Check if exactly 10 digits
                                if (phoneNumber.length != 10) {
                                  return L10n.tr().phoneMustBeTenOrElevenDigits;
                                }
                                if (!RegExp(r'^\d+$').hasMatch(phoneNumber)) {
                                  return L10n.tr().phoneMustContainOnlyDigits;
                                }
                                return null;
                              } else {
                                // Email validation
                                return Validators.emailValidator(trimmedValue);
                              }
                            },
                            onChange: (value) {
                              // Update keyboard type based on first character
                              if (value.isNotEmpty) {
                                final firstChar = value[0];
                                if (RegExp(r'\d').hasMatch(firstChar)) {
                                  // Check if exactly 10 digits
                                  if (value.length > 11) _phoneOrEmailController.text = value.substring(0, 11);

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
                                  selection: TextSelection.collapsed(offset: newValue.length),
                                );
                              }
                            },
                            autofillHints: const [AutofillHints.email, AutofillHints.telephoneNumber],
                          ),
                        ),
                        const VerticalSpacing(16),
                        Text(L10n.tr().password, maxLines: 1, style: context.style14400),
                        const VerticalSpacing(8),
                        Directionality(
                          textDirection: TextDirection.ltr,

                          child: MainTextField(
                            controller: _pasword,
                            hintText: L10n.tr().enterYourPassword,
                            bgColor: Colors.transparent,
                            isPassword: true,
                            borderRadius: 32,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                            validator: Validators.notEmpty,
                            prefix: SvgPicture.asset(Assets.lockIc),
                            autofillHints: const [AutofillHints.newPassword],
                          ),
                        ),
                        const Row(mainAxisAlignment: MainAxisAlignment.end, children: [ForgetPasswordBtn()]),
                      ],
                    ),
                  ),

                  // const VerticalSpacing(8),
                  BlocConsumer<LoginCubit, LoginStates>(
                    listener: (context, state) {
                      if (state is LoginSuccessState) {
                        Alerts.showToast(state.message, error: false);
                        const LoadingScreenRoute(navigateToRoute: HomeScreen.route).go(context);
                      } else if (state is LoginErrorState) {
                        Alerts.showToast(state.error);
                      }
                    },
                    builder: (context, state) => Hero(
                      tag: Tags.btn,
                      child: MainBtn(
                        isLoading: state is LoginLoadingState,
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            TextInput.finishAutofillContext();
                            final input = _phoneOrEmailController.text.trim().replaceAll(' ', '');

                            // If it's a phone number (starts with digit), ensure 10 digits
                            String loginValue;
                            if (RegExp(r'^\d').hasMatch(input)) {
                              // Remove leading 0 if exists
                              loginValue = input.startsWith('0') ? input.substring(1) : input;
                              // Ensure exactly 10 digits
                              if (loginValue.length != 10) {
                                Alerts.showToast(L10n.tr().phoneMustBeTenDigits);
                                return;
                              }
                            } else {
                              loginValue = input;
                            }

                            context.read<LoginCubit>().login(loginValue, _pasword.text.trim());
                          }
                        },
                        textStyle: context.style14400.copyWith(fontWeight: TStyle.semi),

                        child: Text(L10n.tr().login, style: TStyle.robotBlackMedium().copyWith(color: Co.white)),
                      ),
                    ),
                  ),
                  const VerticalSpacing(16),

                  MainBtn(
                    onPressed: () {
                      context.push(RegisterScreen.route);
                    },
                    textStyle: context.style14400.copyWith(fontWeight: TStyle.semi),
                    bgColor: Colors.transparent,
                    borderColor: Co.purple,
                    child: Text(L10n.tr().signUp, style: TStyle.robotBlackMedium()),
                  ),
                  const VerticalSpacing(8),
                  Row(
                    children: [
                      const Expanded(child: Divider()),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(L10n.tr().or, style: TStyle.robotBlackSmall()),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const VerticalSpacing(8),
                  MainBtn(
                    onPressed: () {
                      if (Navigator.canPop(context)) return context.pop();
                      const LoadingScreenRoute(navigateToRoute: HomeScreen.route).go(context);
                    },
                    textStyle: context.style14400.copyWith(fontWeight: TStyle.semi),
                    bgColor: Colors.transparent,
                    borderColor: Colors.transparent,
                    child: RichText(
                      text: TextSpan(
                        style: TStyle.robotBlackMedium(),
                        children: [
                          TextSpan(
                            text: L10n.tr().continu,
                            style: TStyle.robotBlackMedium().copyWith(color: Colors.black87),
                          ),
                          TextSpan(
                            text: ' ${L10n.tr().to} ',
                            style: TStyle.robotBlackMedium().copyWith(color: Colors.black87),
                          ),
                          TextSpan(
                            text: L10n.tr().guestMode,
                            style: TStyle.robotBlackMedium().copyWith(color: Co.purple),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
