import 'package:flutter/material.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart' show MainTextField;
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/auth/register/domain/register_repo.dart';

enum ReferralCodeState { initial, success, error }

class ReferralCodeWidget extends StatefulWidget {
  const ReferralCodeWidget({super.key, this.onValidationChanged, this.initialCode});

  final ValueChanged<String?>? onValidationChanged;
  final String? initialCode;

  @override
  State<ReferralCodeWidget> createState() => _ReferralCodeWidgetState();
}

class _ReferralCodeWidgetState extends State<ReferralCodeWidget> {
  final _referralCodeController = TextEditingController();
  final _isCheckingReferral = ValueNotifier<bool>(false);
  ReferralCodeState _referralCodeState = ReferralCodeState.initial;
  String? _referralCodeErrorMessage;
  bool _hasInitialized = false;

  String? get validatedCode => _referralCodeState == ReferralCodeState.success ? _referralCodeController.text.trim() : null;

  @override
  void initState() {
    super.initState();
    // Pre-fill with initial code if provided
    if (widget.initialCode != null && widget.initialCode!.isNotEmpty) {
      // Automatically validate the initial code
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _referralCodeController.text = widget.initialCode!.toUpperCase();

        if (mounted && !_hasInitialized) {
          _hasInitialized = true;
          _applyReferralCode();
        }
        setState(() {});
      });
    }
  }

  @override
  void didUpdateWidget(covariant ReferralCodeWidget oldWidget) {
    // Pre-fill with initial code if provided
    if (widget.initialCode != null && widget.initialCode!.isNotEmpty) {
      // Automatically validate the initial code
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _referralCodeController.text = widget.initialCode!.toUpperCase();

        if (mounted && !_hasInitialized) {
          _hasInitialized = true;
          _applyReferralCode();
        }
        setState(() {});
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _referralCodeController.dispose();
    _isCheckingReferral.dispose();
    super.dispose();
  }

  Future<void> _applyReferralCode() async {
    final code = _referralCodeController.text.trim();
    if (code.isEmpty) {
      setState(() {
        _referralCodeState = ReferralCodeState.error;
        _referralCodeErrorMessage = L10n.tr().please_enter_referral_code;
      });
      widget.onValidationChanged?.call(null);
      return;
    }

    _isCheckingReferral.value = true;
    setState(() {
      _referralCodeState = ReferralCodeState.initial;
      _referralCodeErrorMessage = null;
    });

    final repo = di<RegisterRepo>();
    final result = await repo.validateReferralCode(code);
    _isCheckingReferral.value = false;
    if (!mounted) return;

    switch (result) {
      case Ok<String> _:
        setState(() {
          _referralCodeState = ReferralCodeState.success;
          _referralCodeErrorMessage = null;
        });
        widget.onValidationChanged?.call(code);
        break;
      case final Err err:
        setState(() {
          _referralCodeState = ReferralCodeState.error;
          _referralCodeErrorMessage = err.error.message.isNotEmpty ? err.error.message : L10n.tr().referral_code_invalid;
        });
        widget.onValidationChanged?.call(null);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  _referralCodeController.text = value.toUpperCase();
                  setState(() {
                    _referralCodeState = ReferralCodeState.initial;
                    _referralCodeErrorMessage = null;
                  });
                  widget.onValidationChanged?.call(null);
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
                          style: TStyle.robotBlackMedium().copyWith(color: _referralCodeController.text.isNotEmpty ? Co.white : Co.black),
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
    );
  }
}
