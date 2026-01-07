import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

/// Tile widget for support screen options
class SupportOptionTile extends StatelessWidget {
  const SupportOptionTile({super.key, required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(color: Co.lightPurple, borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Expanded(child: Text(title, style: TStyle.robotBlackMedium())),
            const Icon(Icons.chevron_right, color: Co.purple),
          ],
        ),
      ),
    );
  }
}
