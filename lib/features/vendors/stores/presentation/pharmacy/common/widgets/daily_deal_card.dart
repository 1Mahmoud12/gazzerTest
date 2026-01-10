import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

/// Reusable daily deal card with countdown timer for pharmacy promotions
class DailyDealCard extends StatefulWidget {
  const DailyDealCard({super.key, required this.imageUrl, required this.discountPercentage, required this.endTime, this.onTap});

  final String imageUrl;
  final int discountPercentage;
  final DateTime endTime;
  final VoidCallback? onTap;

  @override
  State<DailyDealCard> createState() => _DailyDealCardState();
}

class _DailyDealCardState extends State<DailyDealCard> {
  Timer? _timer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calculateRemainingTime();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _calculateRemainingTime() {
    final now = DateTime.now();
    _remainingTime = widget.endTime.difference(now);
    if (_remainingTime.isNegative) {
      _remainingTime = Duration.zero;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        _remainingTime = widget.endTime.difference(DateTime.now());
        if (_remainingTime.isNegative) {
          _remainingTime = Duration.zero;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacityNew(0.08), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Stack(
          children: [
            // Purple Wave Background
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [Co.purple, Color(0xFF6B4FA0)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                  child: CustomPaint(painter: _WavePainter()),
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Product Image with Discount Badge
                  _buildProductImage(),
                  const SizedBox(width: 20),

                  // Deal Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          L10n.tr().dailyDeal,
                          style: context.style12400.copyWith(color: Co.purple, fontWeight: TStyle.bold),
                        ),
                        const SizedBox(height: 8),
                        _buildCountdownTimer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Stack(
      children: [
        // Circular Product Image
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            image: DecorationImage(image: NetworkImage(widget.imageUrl), fit: BoxFit.cover),
          ),
        ),

        // Discount Badge
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(gradient: Grad().shadowGrad(), borderRadius: BorderRadius.circular(12)),
            child: Text(
              '${widget.discountPercentage}%',
              style: context.style16400.copyWith(color: Co.purple, fontWeight: TStyle.semi),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCountdownTimer() {
    final hours = _remainingTime.inHours.toString().padLeft(2, '0');
    final minutes = (_remainingTime.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_remainingTime.inSeconds % 60).toString().padLeft(2, '0');

    return Row(
      children: [
        _buildTimeBox(hours, L10n.tr().hours),
        const SizedBox(width: 4),
        Text(
          ' : ',
          style: context.style16500.copyWith(color: Co.white, fontWeight: TStyle.bold),
        ),
        const SizedBox(width: 4),
        _buildTimeBox(minutes, L10n.tr().mins),
        const SizedBox(width: 4),
        Text(
          ' : ',
          style: context.style16500.copyWith(color: Co.white, fontWeight: TStyle.bold),
        ),
        const SizedBox(width: 4),
        _buildTimeBox(seconds, L10n.tr().secs),
      ],
    );
  }

  Widget _buildTimeBox(String value, String label) {
    return Column(
      children: [
        Text(value, style: context.style20500.copyWith(color: Co.white)),
        const SizedBox(height: 2),
        Text(label, style: context.style12400.copyWith(color: Colors.white.withOpacityNew(0.8))),
      ],
    );
  }
}

/// Custom painter for wave effect in background
class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF8B6BB7).withOpacityNew(0.3)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.6, size.width * 0.5, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.8, size.width, size.height * 0.7);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
