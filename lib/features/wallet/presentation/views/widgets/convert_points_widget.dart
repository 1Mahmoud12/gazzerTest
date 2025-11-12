import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

class ConvertPointsWidget extends StatefulWidget {
  const ConvertPointsWidget({super.key});

  @override
  State<ConvertPointsWidget> createState() => _ConvertPointsWidgetState();
}

class _ConvertPointsWidgetState extends State<ConvertPointsWidget> {
  static const int _availablePoints = 2450;
  static const int _step = 100;
  static const double _conversionRate = 0.02; // 100 points => 2.0 EGP

  int _selectedPoints = 1000;

  double get _convertedAmount => _selectedPoints * _conversionRate;

  void _increment() {
    setState(() {
      _selectedPoints = (_selectedPoints + _step).clamp(0, _availablePoints);
    });
  }

  void _decrement() {
    setState(() {
      _selectedPoints = (_selectedPoints - _step).clamp(0, _availablePoints);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          L10n.tr().walletConvertPointsToMoney,
          style: TStyle.robotBlackTitle(),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Co.bg,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Co.purple100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      L10n.tr().walletConvertLoyaltyPoints,
                      style: TStyle.robotBlackSubTitle(font: FFamily.roboto),
                    ),
                  ),
                  const HorizontalSpacing(12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: const BoxDecoration(
                      color: Co.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$_availablePoints',
                          style: TStyle.whiteBold(16, font: FFamily.roboto),
                        ),
                        Text(
                          L10n.tr().points,
                          style: TStyle.whiteSemi(12, font: FFamily.roboto),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool isVertical = constraints.maxWidth < 350;

                  final controls = _PointsSelector(
                    value: _selectedPoints,
                    onDecrement: _decrement,
                    onIncrement: _increment,
                  );

                  final amountPreview = _AmountPreview(
                    amount: _convertedAmount,
                  );

                  final convertButton = MainBtn(
                    onPressed: () {},
                    bgColor: Co.purple,
                    text: L10n.tr().convert,
                    textStyle: TStyle.whiteBold(16, font: FFamily.roboto),
                    radius: 40,
                    width: double.infinity,
                  );

                  final exchangeIcon = SvgPicture.asset(Assets.convertIc);

                  if (isVertical) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        controls,
                        const SizedBox(height: 16),
                        Center(child: exchangeIcon),
                        const SizedBox(height: 16),
                        amountPreview,
                        const SizedBox(height: 24),
                        convertButton,
                      ],
                    );
                  }

                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 2, child: controls),
                          const SizedBox(width: 16),
                          exchangeIcon,
                          const SizedBox(width: 16),
                          Expanded(flex: 2, child: amountPreview),
                        ],
                      ),
                      const VerticalSpacing(10),
                      convertButton,
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PointsSelector extends StatelessWidget {
  const _PointsSelector({
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Co.bg,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Co.lightGrey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: _RoundIconButton(icon: Icons.remove, onTap: onDecrement),
          ),
          const SizedBox(width: 12),
          Text(
            '$value',
            style: TStyle.blackBold(18, font: FFamily.roboto),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _RoundIconButton(icon: Icons.add, onTap: onIncrement),
          ),
        ],
      ),
    );
  }
}

class _AmountPreview extends StatelessWidget {
  const _AmountPreview({required this.amount});

  final double amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Co.bg,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Co.lightGrey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            amount.toStringAsFixed(2),
            style: TStyle.blackBold(18, font: FFamily.roboto),
          ),
          Text(
            L10n.tr().egp,
            style: TStyle.blackMedium(16, font: FFamily.roboto),
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Co.grey.withOpacityNew(0.5)),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Icon(icon, color: Co.dark, size: 18),
        ),
      ),
    );
  }
}
