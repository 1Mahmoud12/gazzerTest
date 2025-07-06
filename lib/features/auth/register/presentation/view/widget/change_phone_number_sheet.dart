import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

class ChangePhoneNumberSheet extends StatefulWidget {
  const ChangePhoneNumberSheet({super.key, required this.onConfirm, this.initialPhone});
  final Future<bool> Function(String phone) onConfirm;
  final String? initialPhone;
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
          Expanded(
            child: GestureDetector(
              onTap: () => context.myPop(),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsetsGeometry.symmetric(vertical: 48, horizontal: 24),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    const SizedBox.shrink(),
                    Text(
                      "L10n.tr().editYourNumber",
                      style: TStyle.primaryBold(16),
                    ),
                    const SizedBox.shrink(),
                    Text(
                      L10n.tr().mobileNumber,
                      style: TStyle.greyBold(16),
                    ),
                    Form(
                      key: _formKey,
                      child: PhoneTextField(
                        controller: _phoneController,
                        hasLabel: false,
                        hasHint: true,
                        code: countryCode,
                        validator: (v, code) {
                          countryCode = code;
                          if (code == 'EG') {
                            return Validators.mobileEGValidator(v);
                          }
                          return Validators.valueAtLeastNum(v, L10n.tr().mobileNumber, 6);
                        },
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: isLoading,
                      builder: (context, value, child) => OptionBtn(
                        onPressed: () async {
                          if (widget.initialPhone == _phoneController.text.trim()) {
                            context.myPop();
                            return;
                          }
                          if (_formKey.currentState?.validate() != true) return;
                          isLoading.value = true;
                          final phone = _phoneController.text.trim();
                          final res = await widget.onConfirm(phone);
                          if (context.mounted) {
                            isLoading.value = true;
                            if (res) context.myPop();
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
