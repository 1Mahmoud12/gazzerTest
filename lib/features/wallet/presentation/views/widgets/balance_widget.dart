import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Co.purple,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  L10n.tr().walletKeepItUp,
                  style: TStyle.whiteBold(22, font: FFamily.roboto),
                ),
                Text(
                  L10n.tr().walletNewAchievements,
                  style: TStyle.whiteSemi(16, font: FFamily.roboto),
                ),
                Text(
                  L10n.tr().walletBalanceLabel('1260', L10n.tr().egp),
                  style: TStyle.whiteSemi(16, font: FFamily.roboto),
                ),
              ],
            ),
          ),
          _DashedBorder(
            color: Co.customWalletColor,
            strokeWidth: 1.5,
            dashLength: 6,
            gapLength: 3,
            borderRadius: 90,

            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: Text(
                '1220 \n ${L10n.tr().egp}',
                textAlign: TextAlign.center,
                style: TStyle.whiteBold(22, font: FFamily.roboto),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedBorder extends StatelessWidget {
  const _DashedBorder({
    required this.child,
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.gapLength,
    required this.borderRadius,
  });

  final Widget child;
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        dashLength: dashLength,
        gapLength: gapLength,
        borderRadius: borderRadius,
      ),
      child: Padding(
        padding: EdgeInsets.all(strokeWidth),
        child: child,
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.gapLength,
    required this.borderRadius,
  });

  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      math.max(0, size.width - strokeWidth),
      math.max(0, size.height - strokeWidth),
    );
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    final path = Path()..addRRect(rrect);

    final dashedPath = _createDashedPath(path, dashLength, gapLength);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawPath(dashedPath, paint);
  }

  Path _createDashedPath(Path sourcePath, double dashLength, double gapLength) {
    final Path dashed = Path();
    for (final metric in sourcePath.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double nextDash = math.min(dashLength, metric.length - distance);
        dashed.addPath(
          metric.extractPath(distance, distance + nextDash),
          Offset.zero,
        );
        distance += nextDash + gapLength;
      }
    }
    return dashed;
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.gapLength != gapLength ||
        oldDelegate.borderRadius != borderRadius;
  }
}
