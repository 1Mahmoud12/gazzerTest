import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/date_time.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_entity.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_transactions_entity.dart';
import 'package:gazzer/features/wallet/presentation/cubit/wallet_transactions_cubit.dart';
import 'package:gazzer/features/wallet/presentation/cubit/wallet_transactions_state.dart';
import 'package:gazzer/features/wallet/presentation/views/widgets/wallet_history_tile.dart';
import 'package:intl/intl.dart';

class WalletHistoryScreen extends StatefulWidget {
  const WalletHistoryScreen({super.key});

  static const route = '/wallet-history';

  @override
  State<WalletHistoryScreen> createState() => _WalletHistoryScreenState();
}

enum WalletHistoryFilter { all, deposit, withdrawal, adjustment }

class _WalletHistoryScreenState extends State<WalletHistoryScreen> {
  WalletHistoryFilter selectedFilter = WalletHistoryFilter.all;
  final ScrollController _scrollController = ScrollController();

  String? _getTypeFromFilter(WalletHistoryFilter filter) {
    switch (filter) {
      case WalletHistoryFilter.deposit:
        return 'deposit';
      case WalletHistoryFilter.withdrawal:
        return 'withdrawal';
      case WalletHistoryFilter.adjustment:
        return 'adjustment';
      case WalletHistoryFilter.all:
        return null;
    }
  }

  List<WalletHistoryEntry> _convertTransactionsToEntries(List<TransactionEntity> transactions) {
    final l10n = L10n.tr();
    return transactions.map((transaction) {
      String title;
      String subtitle;
      String iconAssets;

      switch (transaction.type.toLowerCase()) {
        case 'deposit':
          if (transaction.source == 'loyalty_points') {
            title = l10n.walletPointsConversion;
            subtitle = transaction.note ?? '';
            iconAssets = Assets.convertPointsIc;
          } else {
            title = l10n.walletRecharge;
            subtitle = transaction.note ?? '';
            iconAssets = Assets.rechargeIc;
          }

          break;
        case 'withdrawal':
          title = l10n.paid;
          subtitle = transaction.note ?? '';
          iconAssets = Assets.paidIc;

          break;
        case 'adjustment':
          title = l10n.paid;
          subtitle = transaction.note ?? '';
          iconAssets = Assets.convertPointsIc;

          break;
        default:
          iconAssets = Assets.rechargeIc;

          title = transaction.type;
          subtitle = transaction.note ?? '';
      }

      final date = DateFormat('dd\\MM\\yyyy').format(transaction.createdAt);
      final time = transaction.createdAt.defaultTimeFormat;

      return WalletHistoryEntry(title: title, subtitle: subtitle, date: date, time: time, amount: transaction.amount.toInt(), iconAsset: iconAssets);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9) {
      final state = context.read<WalletTransactionsCubit>().state;
      if (state is WalletTransactionsLoaded && state.pagination?.hasMorePages == true) {
        context.read<WalletTransactionsCubit>().loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<WalletTransactionsCubit>()..load(),
      child: Scaffold(
        appBar: MainAppBar(title: L10n.tr().walletHistoryTitle),
        body: BlocBuilder<WalletTransactionsCubit, WalletTransactionsState>(
          builder: (context, state) {
            final l10n = L10n.tr();
            final filters = [
              (WalletHistoryFilter.all, l10n.walletFilterAll),
              (WalletHistoryFilter.deposit, l10n.walletFilterAdded),
              (WalletHistoryFilter.withdrawal, l10n.walletFilterSpent),
              (WalletHistoryFilter.adjustment, l10n.walletAdjustment),
            ];

            List<TransactionEntity> transactionsList = [];
            PaginationEntity? paginationValue;
            bool isLoading = false;
            bool isLoadingMore = false;

            switch (state) {
              case WalletTransactionsLoading(:final isInitial):
                isLoading = isInitial;
                break;
              case WalletTransactionsLoadingMore(:final transactions, :final pagination):
                isLoadingMore = true;
                transactionsList = transactions;
                paginationValue = pagination;
                break;
              case WalletTransactionsLoaded(:final transactions, :final pagination):
                transactionsList = transactions;
                paginationValue = pagination;
                break;
              case WalletTransactionsError(:final cachedTransactions, :final cachedPagination):
                transactionsList = cachedTransactions ?? [];
                paginationValue = cachedPagination;
                break;
              default:
                break;
            }

            final entries = _convertTransactionsToEntries(transactionsList);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),

                  child: Row(
                    children: filters.map((filter) {
                      final isSelected = selectedFilter == filter.$1;

                      return Padding(
                        padding: const EdgeInsetsDirectional.only(end: 12),
                        child: ChoiceChip(
                          label: Text(filter.$2, style: TStyle.robotBlackRegular().copyWith(color: isSelected ? Co.white : Co.black)),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() {
                              selectedFilter = filter.$1;
                            });
                            context.read<WalletTransactionsCubit>().filterByType(_getTypeFromFilter(filter.$1));
                          },
                          checkmarkColor: isSelected ? Co.white : Co.purple,
                          selectedColor: Co.purple,
                          backgroundColor: Co.bg,
                          labelStyle: TStyle.robotBlackRegular().copyWith(color: isSelected ? Co.white : Co.dark),
                          shape: StadiumBorder(side: BorderSide(color: isSelected ? Co.purple : Co.lightGrey)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: isLoading && entries.isEmpty
                      ? const Center(child: AdaptiveProgressIndicator())
                      : entries.isEmpty
                      ? Center(
                          child: Text(
                            l10n.walletHistorySubtitle,
                            textAlign: TextAlign.center,
                            style: TStyle.robotBlackRegular().copyWith(color: Co.grey),
                          ),
                        )
                      : NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification is ScrollUpdateNotification) {
                              if (notification.metrics.pixels >= notification.metrics.maxScrollExtent * 0.9) {
                                if (paginationValue?.hasMorePages == true && !isLoadingMore) {
                                  context.read<WalletTransactionsCubit>().loadMore();
                                }
                              }
                            }
                            return false;
                          },
                          child: ListView.separated(
                            controller: _scrollController,
                            itemCount: entries.length + (isLoadingMore ? 1 : 0),
                            separatorBuilder: (_, __) => const SizedBox(height: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 8),

                            itemBuilder: (context, index) {
                              if (index == entries.length) {
                                return const Center(
                                  child: Padding(padding: EdgeInsets.all(16.0), child: AdaptiveProgressIndicator()),
                                );
                              }
                              return WalletHistoryTile(entry: entries[index]);
                            },
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
