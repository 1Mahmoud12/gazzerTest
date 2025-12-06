import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/success_dialog.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_entity.dart';
import 'package:gazzer/features/wallet/presentation/cubit/convert_points_cubit.dart';
import 'package:gazzer/features/wallet/presentation/cubit/convert_points_state.dart';
import 'package:gazzer/features/wallet/presentation/cubit/wallet_cubit.dart';

class ConvertPointsWidget extends StatefulWidget {
  const ConvertPointsWidget({
    super.key,
    this.loyaltyPoints,
  });

  final WalletLoyaltyPointsEntity? loyaltyPoints;

  @override
  State<ConvertPointsWidget> createState() => _ConvertPointsWidgetState();
}

class _ConvertPointsWidgetState extends State<ConvertPointsWidget> {
  int _selectedPoints = 0;

  int get _availablePoints => widget.loyaltyPoints?.availablePoints ?? 0;

  int get _conversionRate => (widget.loyaltyPoints?.conversionRate?.points ?? 0).toInt();

  int get _conversionRateBerTransaction => (widget.loyaltyPoints?.conversionRateBerTransaction ?? 0).toInt();

  double get _estimatedValue => widget.loyaltyPoints?.estimatedValue ?? 0.0;

  double get _convertedAmount => _selectedPoints / _conversionRate;

  @override
  void initState() {
    super.initState();
    _selectedPoints = 0;
  }

  @override
  void didUpdateWidget(ConvertPointsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.loyaltyPoints?.conversionRate != widget.loyaltyPoints?.conversionRate) {
      _selectedPoints = 0;
    }
  }

  void _increment() {
    setState(() {
      _selectedPoints = (_selectedPoints + _conversionRateBerTransaction).clamp(
        0,
        _availablePoints,
      );
    });
  }

  void _decrement() {
    setState(() {
      _selectedPoints = (_selectedPoints - _conversionRateBerTransaction).clamp(
        0,
        _availablePoints,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<ConvertPointsCubit>(),
      child: BlocConsumer<ConvertPointsCubit, ConvertPointsState>(
        listener: (context, state) async {
          if (state is ConvertPointsSuccess) {
            await showSuccessDialog(
              context,
              title: L10n.tr().youJustCashedPoints(
                _selectedPoints,
                _convertedAmount,
              ),
              subTitle: L10n.tr().keepCollecting,
              iconAsset: Assets.successfullyAddPointsIc,
            );
            // Refresh wallet data after successful conversion
            context.read<WalletCubit>().load(forceRefresh: true);
            // Reset selected points
            setState(() {
              _selectedPoints = _conversionRate;
            });
          } else if (state is ConvertPointsError) {
            Alerts.showToast(state.message);
          }
        },
        builder: (context, convertState) {
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
                            style: TStyle.robotBlackSubTitle(
                              font: FFamily.roboto,
                            ),
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
                                style: TStyle.whiteBold(
                                  16,
                                  font: FFamily.roboto,
                                ),
                              ),
                              Text(
                                L10n.tr().points,
                                style: TStyle.whiteSemi(
                                  12,
                                  font: FFamily.roboto,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final bool isVertical = constraints.maxWidth < 300;
                        final isLoading = convertState is ConvertPointsLoading;

                        // Check if increment is allowed: available points must be >= conversionRateBerTransaction
                        // and adding it won't exceed available points
                        final canIncrement =
                            !isLoading &&
                            _availablePoints >= _conversionRateBerTransaction &&
                            (_selectedPoints + _conversionRateBerTransaction) <= _availablePoints;

                        final controls = _PointsSelector(
                          value: _selectedPoints,
                          onDecrement: isLoading || _selectedPoints <= 0 ? null : _decrement,
                          onIncrement: canIncrement ? _increment : null,
                        );

                        final amountPreview = _AmountPreview(
                          amount: _convertedAmount,
                          estimatedValue: _estimatedValue,
                        );

                        final convertButton = MainBtn(
                          onPressed: () {
                            context.read<ConvertPointsCubit>().convertPoints(
                              _selectedPoints,
                            );
                          },
                          isEnabled: !isLoading && _selectedPoints > 0,
                          isLoading: isLoading,
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
        },
      ),
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
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

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
            child: _RoundIconButton(
              icon: Icons.remove,
              color: onDecrement == null ? Co.grey.withOpacityNew(.5) : null,
              onTap: () {
                if (onDecrement == null) {
                  Alerts.showToast(L10n.tr().cantConvertLessZanZero);
                } else {
                  onDecrement?.call();
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '$value',
            style: TStyle.blackBold(18, font: FFamily.roboto),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _RoundIconButton(
              icon: Icons.add,
              color: onIncrement == null ? Co.grey.withOpacityNew(.5) : null,

              onTap: () {
                if (onIncrement == null) {
                  Alerts.showToast(L10n.tr().cantConvertMoreThanAvailable);
                } else {
                  onIncrement?.call();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AmountPreview extends StatelessWidget {
  const _AmountPreview({
    required this.amount,
    required this.estimatedValue,
  });

  final double amount;
  final double estimatedValue;

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
  const _RoundIconButton({required this.icon, required this.onTap, this.color});

  final IconData icon;
  final Color? color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color ?? Co.grey.withOpacityNew(0.5)),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Icon(icon, color: color ?? Co.dark, size: 18),
        ),
      ),
    );
  }
}
