import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class VendorClosingTimer extends StatefulWidget {
  const VendorClosingTimer({super.key, required this.endTime, required this.name});
  final DateTime endTime;
  final String name;
  @override
  State<VendorClosingTimer> createState() => _VendorClosingTimerState();
}

class _VendorClosingTimerState extends State<VendorClosingTimer> {
  Timer? timer;
  late bool isClosed;
  final difference = ValueNotifier(0);
  void _checkDifference() {
    if (widget.endTime.isBefore(DateTime.now())) {
      isClosed = true;
      timer?.cancel();
    } else {
      difference.value = widget.endTime.difference(DateTime.now()).inSeconds;
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkDifference();
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _checkDifference();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    difference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Co.darkRed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              L10n.tr().vendorClosesInMinutes(difference.value ~/ 60, widget.name),
              style: TStyle.whiteBold(12, font: FFamily.inter),
            ),
            ValueListenableBuilder(
              valueListenable: difference,
              builder: (context, value, child) {
                if (value == 0) return const SizedBox.shrink();
                return Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: (value ~/ 60).toString().padLeft(2, '0'),
                        style: TStyle.whiteBold(12),
                      ),
                      const TextSpan(text: '  '),
                      TextSpan(
                        text: (value % 60).toString().padLeft(2, '0'),
                        style: TStyle.whiteBold(14, font: FFamily.playfair),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
