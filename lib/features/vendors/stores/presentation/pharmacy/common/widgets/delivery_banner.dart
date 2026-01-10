import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';

/// Reusable banner for displaying delivery information
class DeliveryBanner extends StatelessWidget {
  const DeliveryBanner({super.key, required this.message, this.icon = Icons.local_shipping_outlined, this.backgroundColor = const Color(0xFFF5F5F5)});

  final String message;
  final IconData icon;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(12)),
      child: Text(
        message,
        style: context.style20500.copyWith(
          shadows: [
            const Shadow(
              color: Color(0xADFF9900), // #FF9900AD
              blurRadius: 5.2,
            ),
          ],
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
