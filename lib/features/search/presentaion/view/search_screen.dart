import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/search/presentaion/view/widgets/recent_searches_widget.dart';
import 'package:gazzer/features/search/presentaion/view/widgets/search_result_vendor.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

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
                hintText: "Search for restaurants, items, or categories",
                bgColor: Colors.transparent,
                prefix: const Icon(Icons.search, color: Co.purple, size: 24),
              ),
            ),
            const RecentSearchesWidget(),
            Expanded(
              child: ListView.separated(
                itemCount: Fakers.vendors.length,
                separatorBuilder: (context, index) => const VerticalSpacing(16),
                itemBuilder: (context, index) {
                  return SearchResultVendor(vendor: Fakers.vendors[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
