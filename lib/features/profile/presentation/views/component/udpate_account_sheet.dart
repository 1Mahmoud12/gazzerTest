import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_phone_field.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/profile/data/models/update_profile_req.dart';
import 'package:go_router/go_router.dart';

class UdpateAccountSheet extends StatefulWidget {
  const UdpateAccountSheet({super.key});

  @override
  State<UdpateAccountSheet> createState() => _UdpateAccountSheetState();
}

class _UdpateAccountSheetState extends State<UdpateAccountSheet> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    final client = Session().client;
    _nameController.text = client?.clientName ?? '';
    _emailController.text = client?.email ?? '';
    _phoneController.text = client?.phoneNumber ?? '';

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            L10n.tr().editAccountInformation,
            style: context.style16500.copyWith(
              color: !context.isDarkMode ? Co.purple : null,
            ),
          ),
          Divider(
            height: 8,
            thickness: 1,
            color: context.isDarkMode
                ? Co.darkModeStroke
                : Co.purple.withAlpha(90),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 24,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 14,
                  children: [
                    SvgPicture.asset(Assets.fullNameIc),
                    Expanded(
                      child: Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              L10n.tr().fullName,
                              style: context.style16400,
                            ),
                          ),
                          MainTextField(
                            controller: _nameController,
                            hintText: L10n.tr().yourFullName,

                            showBorder: false,

                            validator: (v) {
                              return Validators.dashedCharactersOnly(v) ??
                                  Validators.valueAtLeastNum(
                                    v,
                                    L10n.tr().fullName,
                                    3,
                                    msg: L10n.tr()
                                        .fullNameShouldBeThreeLettersOrMore,
                                  );
                            },
                            autofillHints: const [
                              AutofillHints.username,
                              AutofillHints.name,
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 14,
                  children: [
                    const Icon(
                      Icons.email_outlined,
                      size: 25,
                      color: Co.secondary,
                    ),
                    Expanded(
                      child: Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              L10n.tr().emailAddress,
                              style: context.style16400,
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,

                            child: MainTextField(
                              controller: _emailController,
                              hintText: L10n.tr().emailAddress,
                              showBorder: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                              ],
                              validator: (v) {
                                if (v?.trim().isNotEmpty != true) return null;
                                return Validators.emailValidator(v);
                              },
                              autofillHints: const [
                                AutofillHints.username,
                                AutofillHints.name,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 14,
                  children: [
                    const Icon(
                      Icons.phone_outlined,
                      size: 25,
                      color: Co.secondary,
                    ),
                    Expanded(
                      child: Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              L10n.tr().mobileNumber,
                              style: context.style16400,
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: PhoneTextField(
                              controller: _phoneController,
                              hasLabel: false,
                              hasHint: true,
                              borderColor: Colors.red,
                              bgColor: Co.w900,
                              showBorder: false,
                              code: 'EG',
                              onChange: (phone) {
                                // Check if exactly 10 digits
                                if (phone.number.length > 11) {
                                  _phoneController.text = phone.number
                                      .substring(0, 11);
                                }
                              },
                              validator: (v, code) {
                                if (v == null || v.isEmpty) {
                                  return L10n.tr().enterYourMobileNumber;
                                }

                                // Phone validation - remove leading 0 if exists and ensure 10 digits
                                String phoneNumber = v;
                                if (phoneNumber.startsWith('0')) {
                                  phoneNumber = phoneNumber.substring(1);
                                }

                                // Check if exactly 10 digits
                                if (phoneNumber.length != 10) {
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
                  ],
                ),
              ],
            ),
          ),
          const SizedBox.shrink(),
          MainBtn(
            onPressed: () {
              if (_formKey.currentState?.validate() != true) return;

              // Remove leading 0 if exists and ensure 10 digits for API
              String phone = _phoneController.text.trim();
              if (phone.startsWith('0')) {
                phone = phone.substring(1);
              }

              final req = UpdateProfileReq(
                name: _nameController.text.trim(),
                email: _emailController.text.trim(),
                phone: phone,
              );
              context.pop(req);
            },
            radius: 24,
            child: Text(
              L10n.tr().saveChanges,
              style: context.style20500.copyWith(color: Co.white),
              textAlign: TextAlign.center,
            ),
          ),
          const VerticalSpacing(100),
        ],
      ),
    );
  }
}
