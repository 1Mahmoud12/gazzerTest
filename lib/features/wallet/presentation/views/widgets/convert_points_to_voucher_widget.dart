import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_entity.dart';
import 'package:gazzer/features/wallet/presentation/cubit/voucher_vendors_cubit.dart';
import 'package:gazzer/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:gazzer/features/wallet/presentation/cubit/wallet_state.dart';
import 'package:gazzer/features/wallet/presentation/views/voucher_vendors_screen.dart';

class ConvertPointsToVoucherWidget extends StatelessWidget {
  final double availablePoints;

  const ConvertPointsToVoucherWidget({
    super.key,
    required this.availablePoints,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        final vouchers = state is WalletLoaded ? state.data.availableVoucherAmounts : const <VoucherAmountEntity>[];

        if (vouchers.isEmpty) {
          return const SizedBox.shrink();
        }

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
                  for (int i = 0; i < vouchers.length; i++) ...[
                    _VoucherTile(
                      voucher: vouchers[i],
                      availablePoints: availablePoints,
                    ),
                    if (i != vouchers.length - 1) const VerticalSpacing(12),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _VoucherTile extends StatelessWidget {
  const _VoucherTile({required this.voucher, required this.availablePoints});

  final VoucherAmountEntity voucher;
  final double availablePoints;

  @override
  Widget build(BuildContext context) {
    final title = L10n.tr().walletVoucherOffer(
      voucher.amount,
      voucher.pointsNeeded,
      L10n.tr().points,
    );
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
          final walletCubit = context.read<WalletCubit>();
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: walletCubit),
                      BlocProvider(
                        create: (context) => di<VoucherVendorsCubit>(),
                      ),
                    ],
                    child: VoucherVendorsScreen(
                      title: title,
                      id: voucher.amount,
                      pointsNeed: voucher.pointsNeeded,
                      availablePoints: availablePoints,
                    ),
                  ),
                ),
              )
              .then((_) {
                // Refresh wallet data when coming back
                walletCubit.load(forceRefresh: true);
              });
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
                    title,
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
