import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart' show MainTextField, PhoneTextField;
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/auth/login/presentation/login_screen.dart';
import 'package:gazzer/features/auth/register/data/register_request.dart';
import 'package:gazzer/features/auth/register/domain/register_repo.dart';
import 'package:gazzer/features/auth/register/presentation/view/create_password_screen.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:gazzer/features/intro/presentation/loading_screen.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const route = '/register';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

enum ReferralCodeState { initial, success, error }

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _referralCodeController = TextEditingController();
  final _isChecking = ValueNotifier<bool>(false);
  final _isCheckingReferral = ValueNotifier<bool>(false);
  ReferralCodeState _referralCodeState = ReferralCodeState.initial;
  String? _referralCodeErrorMessage;
  String countryCode = 'EG';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _referralCodeController.dispose();
    _isChecking.dispose();
    _isCheckingReferral.dispose();
    super.dispose();
  }

  Future<void> _applyReferralCode() async {
    final code = _referralCodeController.text.trim();
    if (code.isEmpty) {
      setState(() {
        _referralCodeState = ReferralCodeState.error;
        _referralCodeErrorMessage = 'Please enter a referral code';
      });
      return;
    }

    _isCheckingReferral.value = true;
    setState(() {
      _referralCodeState = ReferralCodeState.initial;
      _referralCodeErrorMessage = null;
    });

    // TODO: Replace with actual API call to validate referral code
    await Future.delayed(const Duration(seconds: 1));

    _isCheckingReferral.value = false;

    // Simulate validation - replace with actual API call
    if (code == '12345') {
      setState(() {
        _referralCodeState = ReferralCodeState.success;
        _referralCodeErrorMessage = null;
      });
    } else {
      setState(() {
        _referralCodeState = ReferralCodeState.error;
        _referralCodeErrorMessage = 'Referral code is invalid.';
      });
    }
  }

  Future<void> _checkAndProceed() async {
    if (!_formKey.currentState!.validate()) return;

    TextInput.finishAutofillContext();

    // Remove leading 0 if exists to ensure 10 digits
    String phoneNumber = _phoneController.text.trim();
    if (phoneNumber.startsWith('0')) {
      phoneNumber = phoneNumber.substring(1);
    }

    final email = _emailController.text.trim();

    // Show loading
    _isChecking.value = true;

    // Call check API
    final repo = di<RegisterRepo>();
    final result = await repo.checkPhoneEmail(phoneNumber, email.isEmpty ? null : email);

    _isChecking.value = false;

    switch (result) {
      case final Ok ok:
        final data = ok.value;

        // Check if phone or email is already registered
        if (data.phoneFound && data.emailFound) {
          Alerts.showToast(L10n.tr().phoneAndEmailAlreadyRegistered);
          return;
        } else if (data.phoneFound) {
          Alerts.showToast(L10n.tr().phoneAlreadyRegistered);
          return;
        } else if (data.emailFound) {
          Alerts.showToast(L10n.tr().emailAlreadyRegistered);
          return;
        }

        // Proceed to password screen if both are available
        if (mounted) {
          context.push(
            CreatePasswordScreen.routeWithExtra,
            extra: RegisterRequest(
              name: _nameController.text.trim(),
              countryIso: countryCode,
              phone: phoneNumber,
              email: email,
              password: '',
              passwordConfirmation: '',
              referralCode: _referralCodeState == ReferralCodeState.success ? _referralCodeController.text.trim() : null,
            ),
          );
        }
        break;

      case final Err err:
        Alerts.showToast(err.error.message);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
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
            const VerticalSpacing(8),
            Text(
              L10n.tr().singUpToExploreWideVarietyOfProducts,
              maxLines: 2,
              style: TStyle.robotBlackSmall().copyWith(color: Co.gr100),
              textAlign: TextAlign.center,
            ),

            const VerticalSpacing(24),
            AutofillGroup(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(L10n.tr().fullName, maxLines: 1, style: TStyle.robotBlackRegular14()),
                  const VerticalSpacing(8),
                  MainTextField(
                    controller: _nameController,
                    hintText: L10n.tr().yourFullName,
                    bgColor: Colors.transparent,
                    max: 250,
                    autofillHints: const [AutofillHints.username, AutofillHints.name],
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return L10n.tr().fullNameIsRequired;
                      }
                      return null;
                    },
                  ),
                  const VerticalSpacing(16),
                  Text(L10n.tr().emailAddress, maxLines: 1, style: TStyle.robotBlackRegular14()),
                  const VerticalSpacing(8),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: MainTextField(
                      controller: _emailController,
                      hintText: L10n.tr().enterYourFullEmail,
                      bgColor: Colors.transparent,
                      max: 250,
                      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                      validator: (value) {
                        if (value != null && value.isNotEmpty) {
                          return Validators.emailValidator(value.trim());
                        }
                        return null;
                      },
                      autofillHints: const [AutofillHints.email],
                    ),
                  ),
                  const VerticalSpacing(16),
                  Text(L10n.tr().mobileNumber, maxLines: 1, style: TStyle.robotBlackRegular14()),
                  const VerticalSpacing(8),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: PhoneTextField(
                      controller: _phoneController,
                      hasLabel: false,
                      hasHint: true,
                      code: countryCode,
                      onChange: (phone) {
                        // Check if exactly 10 digits
                        if (phone.number.length > 11) {
                          _phoneController.text = phone.number.substring(0, 11);
                        }
                      },
                      validator: (v, code) {
                        countryCode = code;
                        if (v == null || v.isEmpty) {
                          return L10n.tr().enterYourMobileNumber;
                        }

                        final String phoneNumber = v.trim();
                        // Check if all characters are digits
                        if (!RegExp(r'^\d+$').hasMatch(phoneNumber)) {
                          return L10n.tr().phoneMustContainOnlyDigits;
                        }
                        final bool startsWithZero = phoneNumber.startsWith('0');
                        if (startsWithZero) {
                          if (phoneNumber.length != 11) {
                            return L10n.tr().phoneMustBeElevenDigits;
                          }
                        } else {
                          if (phoneNumber.length != 10) {
                            return L10n.tr().phoneMustBeTenDigits;
                          }
                        }
                        final normalizedNumber = startsWithZero ? phoneNumber.substring(1) : phoneNumber;
                        if (normalizedNumber.isEmpty || !normalizedNumber.startsWith('1')) {
                          return L10n.tr().phoneMustMatchEgyptPrefix;
                        }
                        if (normalizedNumber.length < 2 || !['0', '1', '2', '5'].contains(normalizedNumber[1])) {
                          return L10n.tr().phoneMustMatchEgyptPrefix;
                        }
                        return null;
                      },
                    ),
                  ),
                  const VerticalSpacing(16),
                  // Referral Code Section
                  Text('${L10n.tr().referralCode} (${L10n.tr().optional})', style: TStyle.robotBlackRegular14()),
                  const VerticalSpacing(8),
                  Row(
                    children: [
                      Expanded(
                        child: MainTextField(
                          controller: _referralCodeController,
                          hintText: L10n.tr().enterCode,
                          bgColor: Colors.transparent,
                          borderColor: _referralCodeState == ReferralCodeState.success
                              ? Colors.green
                              : _referralCodeState == ReferralCodeState.error
                              ? Colors.red
                              : Co.borderColor,
                          enabled: _referralCodeState != ReferralCodeState.success,
                          onChange: (value) {
                            if (_referralCodeState != ReferralCodeState.initial) {
                              setState(() {
                                _referralCodeState = ReferralCodeState.initial;
                                _referralCodeErrorMessage = null;
                              });
                            }
                          },
                        ),
                      ),
                      const HorizontalSpacing(8),
                      ValueListenableBuilder<bool>(
                        valueListenable: _isCheckingReferral,
                        builder: (context, isChecking, child) {
                          final isApplied = _referralCodeState == ReferralCodeState.success;
                          return MainBtn(
                            onPressed: _referralCodeController.text.isEmpty ? () {} : _applyReferralCode,
                            isEnabled: !isApplied && !isChecking,
                            isLoading: isChecking,
                            bgColor: _referralCodeController.text.isNotEmpty ? Co.purple : Co.purple100,
                            radius: 24,
                            width: MediaQuery.sizeOf(context).width * .3,
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: isApplied
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(L10n.tr().applied, style: TStyle.whiteSemi(14)),
                                      const HorizontalSpacing(4),
                                      const Icon(Icons.check, color: Colors.white, size: 16),
                                    ],
                                  )
                                : Text(
                                    L10n.tr().apply,
                                    style: TStyle.robotBlackMedium().copyWith(color: Co.black),
                                    textAlign: TextAlign.center,
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                  if (_referralCodeState == ReferralCodeState.success) ...[
                    const VerticalSpacing(8),
                    Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.green, size: 16),
                        const HorizontalSpacing(4),
                        Text(L10n.tr().codeAppliedSuccessfully, style: TStyle.robotBlackRegular14().copyWith(color: Colors.green)),
                      ],
                    ),
                  ] else if (_referralCodeState == ReferralCodeState.error && _referralCodeErrorMessage != null) ...[
                    const VerticalSpacing(8),
                    Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 16),
                        const HorizontalSpacing(4),
                        Expanded(
                          child: Text(_referralCodeErrorMessage!, style: TStyle.robotBlackRegular14().copyWith(color: Colors.red)),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const VerticalSpacing(24),
            Hero(
              tag: Tags.btn,
              child: ValueListenableBuilder<bool>(
                valueListenable: _isChecking,
                builder: (context, isChecking, child) {
                  return MainBtn(
                    isLoading: isChecking,
                    onPressed: () {
                      if (!isChecking) _checkAndProceed();
                    },
                    bgColor: Co.purple,
                    radius: 24,
                    child: Text(L10n.tr().signUp, style: TStyle.whiteSemi(16)),
                  );
                },
              ),
            ),
            const VerticalSpacing(16),
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
            const VerticalSpacing(16),
            MainBtn(
              onPressed: () {
                context.push(LoginScreen.route);
              },
              bgColor: Colors.transparent,
              borderColor: Co.purple,
              radius: 24,
              child: Text(L10n.tr().login, style: TStyle.robotBlackMedium()),
            ),
            const VerticalSpacing(8),
            MainBtn(
              onPressed: () {
                if (Navigator.canPop(context)) return context.pop();
                const LoadingScreenRoute(navigateToRoute: HomeScreen.route).go(context);
              },
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
            // const VerticalSpacing(24),
            // Center(child: Text(L10n.tr().or, style: TStyle.greyRegular(16))),
            // const VerticalSpacing(10),
            // const SocialAuthWidget(),
          ],
        ),
      ),
    );
  }
}
