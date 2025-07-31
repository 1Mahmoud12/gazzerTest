import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/vendor_info_card.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/plate_options_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/product_extras_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/product_price_summary.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/ordered_with_cubit/ordered_with_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/ordered_with_cubit/ordered_with_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/single_restaurant_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/single_cat_restaurant/view/widgets/add_special_note.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'single_cat_restaurant_details.g.dart';
part 'widgets/food_details_widget.dart';
part 'widgets/food_images_gallery.dart';

@TypedGoRoute<SingleCatRestaurantRoute>(path: SingleCatRestaurantScreen.route)
@immutable
class SingleCatRestaurantRoute extends GoRouteData with _$SingleCatRestaurantRoute {
  const SingleCatRestaurantRoute({required this.$extra});
  final SingleRestaurantStates $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => di<SingleCatRestaurantCubit>(
        param1: $extra.restaurant.id,
        param2: $extra.categoriesWithPlates.first.$2.first.id,
      ),
      child: SingleCatRestaurantScreen(hasParentProvider: true, state: $extra),
    );
  }
}

class SingleCatRestaurantScreen extends StatefulWidget {
  static const route = '/single-cat-restaurant';

  /// [hasParentProvider] is used in loading state to hide both the ordered with section & product price summary
  const SingleCatRestaurantScreen({super.key, required this.hasParentProvider, required this.state});
  final bool hasParentProvider;
  final SingleRestaurantStates state;

  @override
  State<SingleCatRestaurantScreen> createState() => _SingleCatRestaurantScreenState();
}

class _SingleCatRestaurantScreenState extends State<SingleCatRestaurantScreen> {
  PlateEntity? selectedPlate;
  late final RestaurantEntity restaurant;
  late final List<PlateEntity> plates;
  @override
  void initState() {
    if (!widget.hasParentProvider) {
      restaurant = Fakers.restaurant;
      plates = Fakers.plates;
    } else {
      restaurant = widget.state.restaurant;
      plates = widget.state.categoriesWithPlates.first.$2;
    }
    selectedPlate = plates.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.paddingOf(context).bottom + 16),
            child: Column(
              spacing: 12,
              children: [
                if (selectedPlate == null)
                  Text(L10n.tr().couldnotLoadDataPleaseTryyAgain)
                else ...[
                  VendorInfoCard(
                    restaurant,
                    padding: EdgeInsets.zero,
                    categories: null,
                  ),
                  const SizedBox.shrink(),
                  OverflowBox(
                    maxWidth: constraints.maxWidth,
                    minWidth: constraints.maxWidth,
                    fit: OverflowBoxFit.deferToChild,
                    child: _FoodImagesGallery(
                      plates: plates,
                      selected: selectedPlate!,
                      onSelect: (plate) {
                        if (plate.id == selectedPlate?.id) return;
                        if (widget.hasParentProvider) {
                          context.read<SingleCatRestaurantCubit>().loadItems(plate.id);
                          context.read<SingleCatRestaurantCubit>().loadPlateDetails(plate.id);
                        }
                        setState(() => selectedPlate = plate);
                      },
                    ),
                  ),
                  if (widget.hasParentProvider)
                    BlocBuilder<SingleCatRestaurantCubit, SingleCatRestaurantStates>(
                      buildWhen: (previous, current) => current is PlateDetailsStates,
                      builder: (context, state) {
                        if (state is! PlateDetailsStates) return const SizedBox.shrink();
                        return Skeletonizer(
                          enabled: state is PlateDetailsLoading,
                          child: Column(
                            children: [
                              _FoodDetailsWidget(product: state.plate),
                              ...List.generate(
                                state.options.length,
                                (index) {
                                  return PlateOptionsWidget(
                                    option: state.options[index],
                                    onSelection: (ids) => true,
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  if (widget.hasParentProvider)
                    BlocBuilder<SingleCatRestaurantCubit, SingleCatRestaurantStates>(
                      buildWhen: (previous, current) => current is OrderedWithStates,
                      builder: (context, state) {
                        if (state is! OrderedWithStates || state.items.isEmpty) return const SizedBox.shrink();
                        return Skeletonizer(
                          enabled: state is OrderedWithLoading,
                          child: OrderedWithComponent(products: state.items),
                        );
                      },
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AddSpecialNote(
                        onNoteChange: (p0) {},
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const Skeleton.shade(child: ProductPriceSummary()),
    );
  }
}
