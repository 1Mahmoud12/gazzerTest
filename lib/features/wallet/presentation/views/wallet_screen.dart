import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';
import 'package:gazzer/features/cart/presentation/views/component/un_auth_component.dart';
import 'package:gazzer/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:gazzer/features/wallet/presentation/cubit/wallet_state.dart';
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
    // delete
    Session().setClient = ClientEntity.domy();

    return BlocProvider(
      create: (_) => di<WalletCubit>()..load(),
      child: Scaffold(
        appBar: MainAppBar(title: L10n.tr().wallet),

        body: Session().client == null
            ? Expanded(
                child: UnAuthComponent(msg: L10n.tr().pleaseLoginToUseWallet),
              )
            : BlocBuilder<WalletCubit, WalletState>(
                builder: (context, state) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await context.read<WalletCubit>().load(
                        forceRefresh: true,
                      );
                    },
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 24,
                      ),
                      children: [

                        BalanceWidget(
                          balance: state is WalletLoaded
                              ? state.data.wallet?.balance
                              : null,
                        ),

                        
                        const VerticalSpacing(24),
                        const AddFundWidget(),
                        const VerticalSpacing(24),
                        ConvertPointsWidget(
                          loyaltyPoints: state is WalletLoaded
                              ? state.data.loyaltyPoints
                              : null,
                        ),
                        const VerticalSpacing(24),
                        ConvertPointsToVoucherWidget(
                          availablePoints: state is WalletLoaded
                              ? (state.data.loyaltyPoints?.availablePoints ?? 0)
                                    .toDouble()
                              : 0,
                        ),
                        const VerticalSpacing(24),
                        WalletHistoryWidget(
                          transactions: state is WalletLoaded
                              ? state.data.recentTransactions
                              : const [],
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
