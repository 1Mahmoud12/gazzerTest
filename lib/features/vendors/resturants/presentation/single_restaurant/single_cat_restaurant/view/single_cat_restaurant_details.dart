import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/dialogs.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/add_to_cart_cubit.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/add_to_cart_states.dart';
import 'package:gazzer/features/vendors/common/presentation/vendor_info_card.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/components/ordered_with_component.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/plate_options_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/product_price_summary.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/ordered_with_cubit/ordered_with_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/ordered_with_cubit/ordered_with_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/single_restaurant_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
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
  const SingleCatRestaurantScreen({
    super.key,
    required this.hasParentProvider,
    required this.state,
  });
  final bool hasParentProvider;
  final SingleRestaurantStates state;

  @override
  State<SingleCatRestaurantScreen> createState() => _SingleCatRestaurantScreenState();
}

class _SingleCatRestaurantScreenState extends State<SingleCatRestaurantScreen> {
  PlateEntity? selectedPlate;
  late final RestaurantEntity restaurant;
  late final List<PlateEntity> plates;
  final canLeaveItem = ValueNotifier(true);

  final noteNotifier = ValueNotifier<String?>(null);
  final priceNQntyNLoading = ValueNotifier<(double, int, bool)>((0, 1, false));
  Function(bool isAdding) onChangeQuantity = (isAdding) {};
  Future Function() onsubmit = () async {};
  Function(String) onNoteChange = (p0) {};

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
  void dispose() {
    canLeaveItem.dispose();
    noteNotifier.dispose();
    priceNQntyNLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: canLeaveItem,
      builder: (context, value, child) => PopScope(
        canPop: Session().client == null || value,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            if (!didPop) {
              showDialog<bool>(
                context: context,
                builder: (context) => Dialogs.confirmDialog(
                  title: L10n.tr().alert,
                  context: context,
                  okBgColor: Colors.redAccent,
                  message: L10n.tr().yourChoicesWillBeClearedBecauseYouDidntAddToCart,
                ),
              ).then((confirmed) {
                if (confirmed == true) {
                  if (context.mounted) {
                    canLeaveItem.value = true;
                    context.pop();
                  }
                }
              });
            }
          }
        },
        child: child!,
      ),
      child: Scaffold(
        appBar: MainAppBar(
          showBadge: true,
          showCart: true,
          showNotification: false,
          onShare: () {},
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                16,
                0,
                16,
                MediaQuery.paddingOf(context).bottom + 16,
              ),
              child: Column(
                spacing: 12,
                children: [
                  if (selectedPlate == null)
                    Text(L10n.tr().couldnotLoadDataPleaseTryAgain)
                  else ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: VendorInfoCard(
                        restaurant,
                        padding: EdgeInsets.zero,
                        categories: null,
                        onTimerFinish: (ctx) {
                          context.pop();
                          RestaurantDetailsRoute(
                            id: restaurant.id,
                          ).pushReplacement(context);
                        },
                      ),
                    ),
                    const SizedBox.shrink(),
                    OverflowBox(
                      maxWidth: constraints.maxWidth,
                      minWidth: constraints.maxWidth,
                      fit: OverflowBoxFit.deferToChild,
                      child: _FoodImagesGallery(
                        plates: plates,
                        selected: selectedPlate!,
                        onSelect: (plate) async {
                          if (plate.id == selectedPlate?.id) return false;
                          if (widget.hasParentProvider) {
                            if (canLeaveItem.value == false) {
                              final isConfirmed = await showDialog<bool>(
                                context: context,
                                builder: (context) => Dialogs.confirmDialog(
                                  title: L10n.tr().alert,
                                  context: context,
                                  okBgColor: Colors.redAccent,
                                  message: L10n.tr().yourChoicesWillBeClearedBecauseYouDidntAddToCart,
                                ),
                              );
                              if (isConfirmed != true) return false;
                            }
                            if (context.mounted) {
                              canLeaveItem.value = true;
                              context.read<SingleCatRestaurantCubit>().loadItems(plate.id);
                              context.read<SingleCatRestaurantCubit>().loadPlateDetails(plate.id);
                              setState(() => selectedPlate = plate);
                            }
                            return true;
                          } else {
                            return false;
                          }
                        },
                      ),
                    ),
                    if (widget.hasParentProvider)
                      BlocBuilder<SingleCatRestaurantCubit, SingleCatRestaurantStates>(
                        buildWhen: (previous, current) => current is PlateDetailsStates,
                        builder: (context, state) {
                          if (state is! PlateDetailsStates) return const SizedBox.shrink();
                          if (state is PlateDetailsLoading)
                            return const Center(
                              child: AdaptiveProgressIndicator(),
                            );
                          return Column(
                            children: [
                              _FoodDetailsWidget(product: state.plate),
                              BlocProvider(
                                create: (context) => di<AddToCartCubit>(
                                  param1: (state.plate, state.options),
                                ),
                                child: Builder(
                                  builder: (context) {
                                    final addCubit = context.read<AddToCartCubit>();
                                    onChangeQuantity = (v) => v ? addCubit.increment() : addCubit.decrement();
                                    onsubmit = addCubit.addToCart;
                                    onNoteChange = addCubit.setNote;

                                    // Ensure default selections are applied
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      addCubit.ensureDefaultSelections();
                                    });
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      canLeaveItem.value = addCubit.cartItem == null;
                                      priceNQntyNLoading.value = (
                                        0,
                                        0,
                                        false,
                                      );
                                      priceNQntyNLoading.value = (
                                        addCubit.state.totalPrice,
                                        addCubit.state.quantity,
                                        addCubit.state.status == ApiStatus.loading,
                                      );
                                    });
                                    return BlocConsumer<AddToCartCubit, AddToCartStates>(
                                      listener: (context, cartState) {
                                        noteNotifier.value = cartState.note;
                                        canLeaveItem.value = !cartState.hasUserInteracted;
                                        priceNQntyNLoading.value = (
                                          cartState.totalPrice,
                                          cartState.quantity,
                                          cartState.status == ApiStatus.loading,
                                        );
                                        if (cartState.status == ApiStatus.success) {
                                          Alerts.showToast(
                                            cartState.message,
                                            error: false,
                                          );
                                          addCubit.resetState();
                                        } else if (cartState.status == ApiStatus.error) {
                                          Alerts.showToast(cartState.message);
                                        }
                                      },
                                      builder: (context, cartState) {
                                        // Show all options directly (no dynamic visibility)
                                        return Column(
                                          children: state.options.map((
                                            option,
                                          ) {
                                            return AbsorbPointer(
                                              absorbing: restaurant.isClosed,
                                              child: PlateOptionsWidget(
                                                optionId: option.id,
                                                optionName: option.name,
                                                values: option.subAddons,
                                                type: option.type,
                                                selectedId: cartState.selectedOptions[option.id] ?? {},
                                                getSelectedOptions: (path) => cartState.selectedOptions[path] ?? {},
                                                onValueSelected:
                                                    ({
                                                      required fullPath,
                                                      required id,
                                                    }) => addCubit.setOptionValue(
                                                      id,
                                                      fullPath,
                                                      option.type,
                                                    ),
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              if (widget.hasParentProvider)
                                BlocBuilder<SingleCatRestaurantCubit, SingleCatRestaurantStates>(
                                  buildWhen: (previous, current) => current is OrderedWithStates,
                                  builder: (context, state) {
                                    if (state is! OrderedWithStates || state.items.isEmpty) {
                                      return const SizedBox.shrink();
                                    }
                                    return Skeletonizer(
                                      enabled: state is OrderedWithLoading,
                                      child: OrderedWithComponent(
                                        products: state.items,
                                        title: L10n.tr().alsoOrderWith,
                                        type: CartItemType.restaurantItem,
                                        isDisabled: restaurant.isClosed,
                                        initialQuantities: context.read<AddToCartCubit>().orderedWithSelections,
                                        onQuantityChanged: (id, qty) => context.read<AddToCartCubit>().setOrderedWithQuantity(id, qty),
                                      ),
                                    );
                                  },
                                ),
                              if (!restaurant.isClosed)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ValueListenableBuilder(
                                      valueListenable: noteNotifier,
                                      builder: (context, value, child) => AddSpecialNote(
                                        onNoteChange: onNoteChange,
                                        note: value,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          );
                        },
                      ),
                  ],
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: restaurant.isClosed
            ? const SizedBox.shrink()
            : Skeleton.shade(
                child: ValueListenableBuilder(
                  valueListenable: priceNQntyNLoading,
                  builder: (context, value, child) => ProductPriceSummary(
                    isLoading: value.$3,
                    price: value.$1,
                    quantity: value.$2,
                    onChangeQuantity: onChangeQuantity,
                    onsubmit: onsubmit,
                  ),
                ),
              ),
      ),
    );
  }
}
