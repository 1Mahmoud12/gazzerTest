import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart' show MainTextField, PhoneTextField;
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/auth/register/data/register_request.dart';
import 'package:gazzer/features/auth/register/domain/register_repo.dart';
import 'package:gazzer/features/auth/register/presentation/view/create_password_screen.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const route = '/register';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _isChecking = ValueNotifier<bool>(false);
  String countryCode = "EG";

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _isChecking.dispose();
    super.dispose();
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
    final result = await repo.checkPhoneEmail(
      phoneNumber,
      email.isEmpty ? null : email,
    );

    _isChecking.value = false;

    switch (result) {
      case Ok ok:
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
            ),
          );
        }
        break;

      case Err err:
        Alerts.showToast(err.error.message);
        break;
    }
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
                    text: L10n.tr().signUp,
                    style: TStyle.mainwBold(32),
                    gradient: Grad().textGradient,
                  ),
                ],
              ),
              const VerticalSpacing(8),
              Text(
                L10n.tr().singUpToExploreWideVarietyOfProducts,
                maxLines: 2,
                style: TStyle.greySemi(16),
              ),

              const VerticalSpacing(24),
              AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(L10n.tr().fullName, style: TStyle.blackBold(20)),
                    const VerticalSpacing(8),
                    MainTextField(
                      controller: _nameController,
                      hintText: L10n.tr().yourFullName,
                      bgColor: Colors.transparent,
                      max: 250,
                      autofillHints: [
                        AutofillHints.username,
                        AutofillHints.name,
                      ],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return L10n.tr().fullNameIsRequired;
                        }
                        return null;
                      },
                    ),
                    const VerticalSpacing(24),
                    Text(L10n.tr().emailAddress, style: TStyle.blackBold(20)),
                    const VerticalSpacing(8),
                    Directionality(
                      textDirection: TextDirection.ltr,

                      child: MainTextField(
                        controller: _emailController,
                        hintText: L10n.tr().enterYourFullEmail,
                        bgColor: Colors.transparent,
                        max: 250,
                        inputFormatters: FilteringTextInputFormatter.deny(
                          RegExp(r'\s'),
                        ),
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            return Validators.emailValidator(value.trim());
                          }
                          return null;
                        },
                        autofillHints: [AutofillHints.email],
                      ),
                    ),
                    const VerticalSpacing(24),
                    Text(L10n.tr().mobileNumber, style: TStyle.blackBold(20)),
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
                            _phoneController.text = phone.number.substring(
                              0,
                              11,
                            );
                          }
                        },
                        validator: (v, code) {
                          countryCode = code;
                          if (v == null || v.isEmpty) {
                            return L10n.tr().enterYourMobileNumber;
                          }
                          // Remove leading 0 if exists and check if exactly 10 digits
                          String phoneNumber = v;
                          if (phoneNumber.startsWith('0')) {
                            phoneNumber = phoneNumber.substring(1);
                          }
                          if (phoneNumber.length > 11) {
                            return L10n.tr().phoneMustBeTenOrElevenDigits;
                          }
                          // Check if all characters are digits
                          if (!RegExp(r'^\d+$').hasMatch(phoneNumber)) {
                            return L10n.tr().phoneMustContainOnlyDigits;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const VerticalSpacing(24),
              const VerticalSpacing(24),
              Hero(
                tag: Tags.btn,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isChecking,
                  builder: (context, isChecking, child) {
                    return OptionBtn(
                      isLoading: isChecking,
                      onPressed: () {
                        if (!isChecking) _checkAndProceed();
                      },
                      textStyle: TStyle.mainwSemi(15),
                      bgColor: Colors.transparent,
                      child: GradientText(
                        text: L10n.tr().continu,
                        style: TStyle.blackSemi(16),
                      ),
                    );
                  },
                ),
              ),
              // const VerticalSpacing(24),
              // Center(child: Text(L10n.tr().or, style: TStyle.greyRegular(16))),
              // const VerticalSpacing(10),
              // const SocialAuthWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
