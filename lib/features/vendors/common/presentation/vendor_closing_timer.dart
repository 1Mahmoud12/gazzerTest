import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/date_time.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class VendorClosingTimer extends StatefulWidget {
  const VendorClosingTimer({super.key, required this.endTime, required this.name, required this.startTime});
  final DateTime endTime;
  final DateTime? startTime;
  final String name;
  @override
  State<VendorClosingTimer> createState() => _VendorClosingTimerState();
}

class _VendorClosingTimerState extends State<VendorClosingTimer> {
  Timer? timer;
  late bool isClosed;
  late int difference;
  void _checkDifference() {
    if (widget.endTime.isBefore(DateTime.now())) {
      isClosed = true;
      timer?.cancel();
    } else {
      setState(() {
        difference = widget.endTime.difference(DateTime.now()).inSeconds;
      });
    }
  }

  @override
  void initState() {
    difference = widget.endTime.difference(DateTime.now()).inSeconds;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Co.darkRed, borderRadius: difference < 1 ? AppConst.defaultBorderRadius : null),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          mainAxisAlignment: difference < 1 ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
          children: [
            if (difference < 1)
              Expanded(
                child: Text(
                  L10n.tr().nameisCurrentlyyClosedWeWillOpenAt(
                    widget.name,
                    widget.startTime?.defaultTimeFormat ?? L10n.tr().soon,
                  ),
                  style: TStyle.whiteBold(12, font: FFamily.inter),
                  textAlign: TextAlign.center,
                ),
              )
            else ...[
              Text(
                L10n.tr().vendorClosesInMinutes(difference ~/ 60, widget.name),
                style: TStyle.whiteBold(12, font: FFamily.inter),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: (difference ~/ 60).toString().padLeft(2, '0'),
                      style: TStyle.whiteBold(12),
                    ),
                    const TextSpan(text: '  '),
                    TextSpan(
                      text: (difference % 60).toString().padLeft(2, '0'),
                      style: TStyle.whiteBold(14, font: FFamily.playfair),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
