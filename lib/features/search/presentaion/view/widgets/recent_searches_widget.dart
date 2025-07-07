import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class RecentSearchesWidget extends StatefulWidget {
  const RecentSearchesWidget({super.key});

  @override
  State<RecentSearchesWidget> createState() => _RecentSearchesWidgetState();
}

class _RecentSearchesWidgetState extends State<RecentSearchesWidget> {
  final searchWords = ["Pizza", "Burger", "Sushi", "Pasta", "Salad", "Ice Cream", "Coffee", "Tea"];

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: SizedBox(
        height: searchWords.isEmpty ? 0 : null,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(L10n.tr().recentSearches, style: TStyle.primaryBold(16)),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      searchWords.clear();
                    });
                  },
                  child: Text(L10n.tr().clear, style: TStyle.tertiaryBold(14).copyWith(color: Co.second2)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 8,
                runSpacing: 12,
                children: List.generate(searchWords.length, (index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      border: GradientBoxBorder(gradient: Grad.shadowGrad()),
                      borderRadius: AppConst.defaultBorderRadius,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 8,
                        children: [
                          Transform.flip(flipX: true, child: const Icon(Icons.replay, size: 20)),
                          Text(searchWords[index], style: TStyle.blackSemi(12)),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
