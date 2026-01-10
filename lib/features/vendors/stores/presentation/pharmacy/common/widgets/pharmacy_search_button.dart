import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

/// Search button for pharmacy store
class PharmacySearchButton extends StatelessWidget {
  const PharmacySearchButton({super.key, this.onTap, this.hintText});

  final VoidCallback? onTap;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Co.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(64),
          border: Border.all(
            color: Co.buttonGradient.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Co.buttonGradient.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Co.purple, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                hintText ?? L10n.tr().searchForStoresItemsAndCAtegories,
                style: context.style14400.copyWith(color: Co.darkGrey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
