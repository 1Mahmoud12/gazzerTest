import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

/// Reusable button for uploading prescriptions in pharmacy screens
class PrescriptionUploadButton extends StatelessWidget {
  const PrescriptionUploadButton({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Co.secondary),
        child: Text(
          L10n.tr().uploadPrescription,
          style: TStyle.burbleBold(14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
