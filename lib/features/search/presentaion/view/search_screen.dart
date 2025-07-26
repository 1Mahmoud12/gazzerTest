import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/search/presentaion/view/widgets/recent_searches_widget.dart';
import 'package:gazzer/features/search/presentaion/view/widgets/search_result_vendor.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const route = '/search';
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(showCart: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          spacing: 16,
          children: [
            Hero(
              tag: Tags.searchBar,
              child: MainTextField(
                controller: controller,
                height: 80,
                borderRadius: 64,
                hintText: L10n.tr().searchForStoresItemsAndCAtegories,
                bgColor: Colors.transparent,
                prefix: const Icon(Icons.search, color: Co.purple, size: 24),
              ),
            ),
            const RecentSearchesWidget(),
            Expanded(
              child: ListView.separated(
                itemCount: Fakers.restaurants.length,
                separatorBuilder: (context, index) => const VerticalSpacing(16),
                itemBuilder: (context, index) {
                  return SearchResultVendor(vendor: Fakers.restaurants[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
