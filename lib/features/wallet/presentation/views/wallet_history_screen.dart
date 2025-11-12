import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/wallet/presentation/views/widgets/wallet_history_tile.dart';

class WalletHistoryScreen extends StatefulWidget {
  const WalletHistoryScreen({super.key, required this.entries});

  static const route = '/wallet-history';

  final List<WalletHistoryEntry> entries;

  @override
  State<WalletHistoryScreen> createState() => _WalletHistoryScreenState();
}

enum WalletHistoryFilter { all, added, spent, fromPoints }

class _WalletHistoryScreenState extends State<WalletHistoryScreen> {
  WalletHistoryFilter selectedFilter = WalletHistoryFilter.all;

  List<WalletHistoryEntry> get _filteredEntries {
    switch (selectedFilter) {
      case WalletHistoryFilter.added:
        return widget.entries.where((entry) => entry.amount > 0).toList();
      case WalletHistoryFilter.spent:
        return widget.entries.where((entry) => entry.amount < 0).toList();
      case WalletHistoryFilter.fromPoints:
        return widget.entries.where((entry) => entry.title == L10n.tr().walletPointsConversion).toList();
      case WalletHistoryFilter.all:
        return widget.entries;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    final filters = [
      (WalletHistoryFilter.all, l10n.walletFilterAll),
      (WalletHistoryFilter.added, l10n.walletFilterAdded),
      (WalletHistoryFilter.spent, l10n.walletFilterSpent),
      (WalletHistoryFilter.fromPoints, l10n.walletFilterFromPoints),
    ];

    return Scaffold(
      appBar: MainAppBar(
        title: l10n.walletHistoryTitle,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   l10n.walletHistorySubtitle,
            //   style: TStyle.robotBlackRegular(font: FFamily.roboto).copyWith(color: Co.grey),
            // ),
            // const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: filters.map((filter) {
                  final isSelected = selectedFilter == filter.$1;

                  return Padding(
                    padding: const EdgeInsetsDirectional.only(end: 12),
                    child: ChoiceChip(
                      label: Text(filter.$2, style: TStyle.robotBlackRegular().copyWith(color: isSelected ? Co.white : Co.black)),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() => selectedFilter = filter.$1);
                      },

                      checkmarkColor: isSelected ? Co.white : Co.purple,
                      selectedColor: Co.purple,
                      backgroundColor: Co.bg,
                      labelStyle: TStyle.robotBlackRegular(font: FFamily.roboto).copyWith(
                        color: isSelected ? Co.white : Co.dark,
                      ),
                      shape: StadiumBorder(
                        side: BorderSide(color: isSelected ? Co.purple : Co.lightGrey),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _filteredEntries.isEmpty
                  ? Center(
                      child: Text(
                        l10n.walletHistorySubtitle,
                        textAlign: TextAlign.center,
                        style: TStyle.robotBlackRegular(font: FFamily.roboto).copyWith(color: Co.grey),
                      ),
                    )
                  : ListView.separated(
                      itemCount: _filteredEntries.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) => WalletHistoryTile(
                        entry: _filteredEntries[index],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
