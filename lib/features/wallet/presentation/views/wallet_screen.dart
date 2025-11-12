import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/cart/presentation/views/component/un_auth_component.dart';
import 'package:gazzer/features/wallet/presentation/views/widgets/add_fund_widget.dart';
import 'package:gazzer/features/wallet/presentation/views/widgets/balance_widget.dart';
import 'package:gazzer/features/wallet/presentation/views/widgets/convert_points_to_voucher_widget.dart';
import 'package:gazzer/features/wallet/presentation/views/widgets/convert_points_widget.dart';
import 'package:gazzer/features/wallet/presentation/views/widgets/wallet_history_widget.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  static const route = '/wallet-screen';

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        showCart: false,
        iconsColor: Co.secondary,
        title: L10n.tr().wallet,
        titleStyle: TStyle.burbleMed(22, font: FFamily.roboto),
      ),

      body: Session().client == null
          ? Expanded(
              child: UnAuthComponent(msg: L10n.tr().pleaseLoginToUseLoyalty),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24,
              ),
              children: [
                const BalanceWidget(),
                const VerticalSpacing(24),
                const AddFundWidget(),
                const VerticalSpacing(24),
                const ConvertPointsWidget(),
                const VerticalSpacing(24),
                const ConvertPointsToVoucherWidget(),
                const VerticalSpacing(24),
                const WalletHistoryWidget(),
              ],
            ),
    );
  }
}
