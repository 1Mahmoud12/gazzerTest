import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';

/// Reusable button for uploading prescriptions in pharmacy screens
class PrescriptionUploadButton extends StatelessWidget {
  const PrescriptionUploadButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MainBtn(
      onPressed: onTap,
      bgColor: Co.secondary,
      radius: 16,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Text(
        L10n.tr().uploadPrescription,
        style: TStyle.burbleBold(16),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
