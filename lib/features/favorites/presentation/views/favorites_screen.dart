import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_bus.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_events.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorites_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});
  static const route = '/favorites';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final controller = TextEditingController();
  late final FavoriteBus bus;
  @override
  void initState() {
    bus = di<FavoriteBus>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bus.getFavorites();
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
            child: StreamBuilder(
              stream: bus.getStream<FavoriteEvents>(),
              builder: (context, snapshot) {
                // print("favs of restaurant  ${bus.favorites[FavoriteType.restaurant]}");
                if (snapshot.data is GetFavoriteLoading) {
                  return const Center(child: AdaptiveProgressIndicator());
                }
                if (snapshot.data?.favorites == null || snapshot.data!.favorites.isEmpty) {
                  return Center(
                    child: Text(
                      L10n.tr().youHaveNoFavoritesYet,
                      style: TStyle.primaryBold(20),
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    bus.getFavorites();
                  },
                  child: ListView.separated(
                    itemCount: snapshot.data!.favorites.length,
                    padding: AppConst.defaultPadding,
                    separatorBuilder: (context, index) => const VerticalSpacing(24),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Text(snapshot.data!.favorites.keys.elementAt(index).trName, style: TStyle.primaryBold(20)),
                          SizedBox(
                            height: 180,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.favorites.values.elementAt(index).length,
                              separatorBuilder: (context, index) => const HorizontalSpacing(16),
                              itemBuilder: (context, i) {
                                final prod = snapshot.data!.favorites.values.elementAt(index).values.elementAt(i);
                                return FavoriteCard(
                                  favorite: prod,
                                  onTap: () {
                                    ///
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
