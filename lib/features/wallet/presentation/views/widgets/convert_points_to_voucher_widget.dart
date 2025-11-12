import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/wallet/presentation/views/voucher_vendors_screen.dart';

class ConvertPointsToVoucherWidget extends StatelessWidget {
  const ConvertPointsToVoucherWidget({super.key});

  static const _vouchers = [
    _Voucher(
      discountValue: 100,
      requiredPoints: 2000,
      validUntil: '30-11-2025',
    ),
    _Voucher(
      discountValue: 100,
      requiredPoints: 2000,
      validUntil: '30-11-2025',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          L10n.tr().walletConvertPointsToVoucher,
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
            children: [
              for (int i = 0; i < _vouchers.length; i++) ...[
                _VoucherTile(voucher: _vouchers[i]),
                if (i != _vouchers.length - 1) const VerticalSpacing(12),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _Voucher {
  const _Voucher({
    required this.discountValue,
    required this.requiredPoints,
    required this.validUntil,
  });

  final int discountValue;
  final int requiredPoints;
  final String validUntil;
}

class _VoucherTile extends StatelessWidget {
  const _VoucherTile({required this.voucher});

  final _Voucher voucher;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Co.bg,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Co.lightGrey.withOpacityNew(0.6)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const VoucherVendorsScreen(title: '100 EGP off Using 2000 Points', id: -1)),
          );
        },
        child: Row(
          children: [
            RotatedBox(
              quarterTurns: L10n.isAr(context) ? 2 : 0,
              child: SvgPicture.asset(
                Assets.voucherIc,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '100 EGP off Using 2000 Points',
                    style: TStyle.robotBlackMedium(
                      fontSize: 18,
                      font: FFamily.roboto,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    L10n.tr().walletValidUntil(voucher.validUntil),
                    style: TStyle.greySemi(14, font: FFamily.roboto),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.arrow_forward_ios, color: Co.darkGrey),
          ],
        ),
      ),
    );
  }
}
