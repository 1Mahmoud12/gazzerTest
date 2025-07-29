import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_rotated_img_card.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/add_food_to_cart_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});
  static const route = '/favorites';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final controller = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // AppNavigator().initContext = context;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favs = [L10n.tr().recentRestaurants, L10n.tr().recentGroceries, L10n.tr().recentPharmacies];
    return Scaffold(
      appBar: const MainAppBar(showCart: false),
      body: Column(
        spacing: 12,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: MainTextField(
              controller: controller,
              height: 80,
              borderRadius: 64,
              hintText: L10n.tr().searchForStoresItemsAndCAtegories,
              bgColor: Colors.transparent,
              prefix: const Icon(Icons.search, color: Co.purple, size: 24),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: favs.length,
              padding: AppConst.defaultPadding,
              separatorBuilder: (context, index) => const VerticalSpacing(24),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(favs[index], style: TStyle.primaryBold(20)),
                    SizedBox(
                      height: 180,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        separatorBuilder: (context, index) => const HorizontalSpacing(16),
                        itemBuilder: (context, index) {
                          final prod = Fakers.plates[index];
                          return VerticalRotatedImgCard(
                            prod: prod,
                            onTap: () {
                              AddFoodToCartRoute($extra: prod).push(context);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
