import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:go_router/go_router.dart';

class ChangePhoneNumberSheet extends StatefulWidget {
  const ChangePhoneNumberSheet({super.key, required this.onConfirm, this.initialPhone, this.title});
  final Future<bool> Function(String phone) onConfirm;
  final String? initialPhone;
  final String? title;
  @override
  State<ChangePhoneNumberSheet> createState() => _ChangePhoneNumberSheetState();
}

class _ChangePhoneNumberSheetState extends State<ChangePhoneNumberSheet> {
  late final TextEditingController _phoneController;
  String countryCode = 'EG'; // Default country code
  final _formKey = GlobalKey<FormState>();
  final isLoading = ValueNotifier(false);

  @override
  void initState() {
    _phoneController = TextEditingController(text: widget.initialPhone ?? '');

    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: GestureDetector(onTap: () => context.pop())),
          Card(
            color: Co.bg,
            child: Padding(
              padding: const EdgeInsetsGeometry.symmetric(vertical: 48, horizontal: 24),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    const SizedBox.shrink(),
                    Text(widget.title ?? L10n.tr().editYourNumber, style: TStyle.robotBlackTitle().copyWith(color: Co.purple)),
                    const SizedBox.shrink(),
                    Text(L10n.tr().mobileNumber, style: context.style14400),
                    Form(
                      key: _formKey,
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
                    ValueListenableBuilder(
                      valueListenable: isLoading,
                      builder: (context, value, child) => MainBtn(
                        onPressed: () async {
                          if (widget.initialPhone == _phoneController.text.trim()) {
                            context.pop();
                            return;
                          }
                          if (_formKey.currentState?.validate() != true) return;
                          isLoading.value = true;
                          final phone = _phoneController.text.trim()[0] == '0'
                              ? _phoneController.text.trim().substring(1)
                              : _phoneController.text.trim();
                          final res = await widget.onConfirm(phone);
                          if (context.mounted) {
                            isLoading.value = false;
                            if (res) context.pop();
                          }
                        },
                        isLoading: value,
                        text: L10n.tr().confirm,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
