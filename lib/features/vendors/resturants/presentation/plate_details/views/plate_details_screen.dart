import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/dialogs.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/share/data/share_models.dart';
import 'package:gazzer/features/share/presentation/share_service.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/item_option_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/add_to_cart_cubit.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/add_to_cart_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/cubit/plate_details_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/cubit/plate_details_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/components/ordered_with_component.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/plate_options_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/product_price_summary.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/product_summary_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'plate_details_screen.g.dart';

@TypedGoRoute<PlateDetailsRoute>(path: SinglePlateScreen.route)
@immutable
class PlateDetailsRoute extends GoRouteData with _$PlateDetailsRoute {
  const PlateDetailsRoute({required this.id, this.$extra});
  final int id;
  final CartItemEntity? $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => di<PlateDetailsCubit>(param1: id),
      child: SinglePlateScreen(itemToEdit: $extra),
    );
  }
}

class SinglePlateScreen extends StatelessWidget {
  static const route = '/single-plate';
  const SinglePlateScreen({super.key, this.itemToEdit});
  final CartItemEntity? itemToEdit;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light));
    return BlocBuilder<PlateDetailsCubit, PlateDetailsStates>(
      builder: (context, detailsState) {
        if (detailsState is PlateDetailsError) {
          return Scaffold(
            appBar: MainAppBar(showBadge: true, showCart: true, onShare: () {}),
            body: FailureComponent(
              message: L10n.tr().couldnotLoadDataPleaseTryAgain,
              onRetry: () => context.read<PlateDetailsCubit>().loadPlateDetails(),
            ),
          );
        } else if (detailsState is PlateDetailsLoaded) {
          // Find cart item from current cart state using findCartItem
          // final cartCubit = context.read<CartCubit>();
          //final cartItemInCart = findCartItem(cartCubit, detailsState.plate);

          // Use cart item from cart state, fallback to itemToEdit from route
          final cartItemToUse = itemToEdit;
          return BlocProvider(
            create: (context) => di<AddToCartCubit>(param1: (detailsState.plate, detailsState.options), param2: cartItemToUse),
            child: Builder(
              builder: (context) {
                final cubit = context.read<AddToCartCubit>();
                final canPop = ValueNotifier(true);

                // Ensure default selections are applied
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  cubit.ensureDefaultSelections();
                  // Seed ordered-with prices so totals update when quantities change
                  final prices = {for (final ow in detailsState.orderedWith) ow.id: ow.price};
                  cubit.setOrderedWithPrices(prices);
                });

                return ValueListenableBuilder(
                  valueListenable: canPop,
                  builder: (context, value, child) => PopScope(
                    canPop: Session().client == null || value,
                    onPopInvokedWithResult: (didPop, result) {
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
                            canPop.value = true;
                            if (context.mounted) context.pop();
                          }
                        });
                      }
                    },
                    child: child!,
                  ),
                  child: Scaffold(
                    body: Stack(
                      children: [
                        Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: _ProductImageHeader(
                                image: detailsState.plate.image,
                                plate: detailsState.plate,
                                onBack: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                IgnorePointer(child: VerticalSpacing(MediaQuery.of(context).size.height * 0.27)),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Co.bg,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ProductSummaryWidget(plate: detailsState.plate),
                                      const VerticalSpacing(16),
                                      if (detailsState.plate.store != null) ...[_VendorInfo(plate: detailsState.plate), const VerticalSpacing(24)],
                                      BlocConsumer<AddToCartCubit, AddToCartStates>(
                                        listener: (context, state) {
                                          canPop.value = !state.hasUserInteracted;
                                          if (state.status == ApiStatus.success) {
                                            context.read<CartCubit>().loadCart();
                                            Alerts.showToast(state.message, error: false);
                                            context.pop(true);
                                          } else if (state.status == ApiStatus.error) {
                                            Alerts.showToast(state.message);
                                          }
                                        },
                                        builder: (context, cartState) {
                                          return Column(
                                            children: detailsState.options.map((option) {
                                              return Padding(
                                                padding: const EdgeInsets.only(bottom: 12),
                                                child: _CollapsibleOption(
                                                  optionId: option.id,
                                                  optionName: option.name,
                                                  values: option.subAddons,
                                                  type: option.type,
                                                  isRequired: option.isRequired,
                                                  selectedId: cartState.selectedOptions[option.id] ?? {},
                                                  getSelectedOptions: (path) => cartState.selectedOptions[path] ?? {},
                                                  onValueSelected: ({required fullPath, required id}) =>
                                                      cubit.setOptionValue(id, fullPath, option.type),
                                                ),
                                              );
                                            }).toList(),
                                          );
                                        },
                                      ),
                                      if (detailsState.orderedWith.isNotEmpty) ...[
                                        const VerticalSpacing(12),
                                        OrderedWithComponent(
                                          products: detailsState.orderedWith,
                                          title: L10n.tr().alsoOrderWith,
                                          type: CartItemType.restaurantItem,
                                          isDisabled: false,
                                          initialQuantities: context.read<AddToCartCubit>().orderedWithSelections,
                                          onQuantityChanged: (id, qty) => context.read<AddToCartCubit>().setOrderedWithQuantity(id, qty),
                                        ),
                                      ],
                                      const VerticalSpacing(24),
                                      BlocBuilder<AddToCartCubit, AddToCartStates>(
                                        buildWhen: (previous, current) => previous.note != current.note,
                                        builder: (context, state) => _NotesSection(note: state.note, onNoteChange: (note) => cubit.setNote(note)),
                                      ),
                                      const VerticalSpacing(100),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.arrow_back, color: Colors.black),
                                  ),
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: FavoriteWidget(size: 24, padding: 4, fovorable: detailsState.plate),
                                    ),
                                    const SizedBox(width: 8),
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: InkWell(
                                        onTap: () async {
                                          animationDialogLoading();
                                          final result = await ShareService().generateShareLink(
                                            type: ShareEnumType.restaurant_plates.name,
                                            shareableType: ShareEnumType.restaurant_plates.name,
                                            shareableId: detailsState.plate.id.toString(),
                                          );
                                          closeDialog();
                                          switch (result) {
                                            case Ok<ShareGenerateResponse>(value: final response):
                                              await Clipboard.setData(ClipboardData(text: response.shareLink));
                                              if (context.mounted) {
                                                Alerts.showToast(L10n.tr().link_copied_to_clipboard, error: false);
                                              }
                                            case Err<ShareGenerateResponse>(error: final error):
                                              if (context.mounted) {
                                                Alerts.showToast(error.message);
                                              }
                                          }
                                        },
                                        child: const VectorGraphicsWidget(Assets.shareIc),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    bottomNavigationBar: Skeleton.shade(
                      child: BlocBuilder<AddToCartCubit, AddToCartStates>(
                        builder: (context, cartState) {
                          return ProductPriceSummary(
                            isLoading: cartState.status == ApiStatus.loading,
                            price: cartState.totalPrice,
                            quantity: cartState.quantity,
                            onChangeQuantity: ({required isAdding}) {
                              if (isAdding) return cubit.increment();
                              return cubit.decrement();
                            },
                            onsubmit: () async {
                              cubit.addToCart(context);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const Scaffold(
          appBar: MainAppBar(),
          body: Center(child: AdaptiveProgressIndicator()),
        );
      },
    );
  }
}

// Product Image Header with overlay buttons
class _ProductImageHeader extends StatelessWidget {
  const _ProductImageHeader({required this.image, required this.plate, required this.onBack});

  final String image;
  final PlateEntity plate;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomNetworkImage(image, fit: BoxFit.fill, width: double.infinity, height: MediaQuery.of(context).size.height * 0.3),
        if (plate.offer != null)
          Positioned(
            bottom: 40,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Text(
                '${plate.offer!.discount} ${plate.offer!.discountType == DiscountType.percentage ? '%' : ''}',
                style: context.style14400.copyWith(fontWeight: TStyle.bold),
              ),
            ),
          ),
      ],
    );
  }
}

// Vendor Info Widget
class _VendorInfo extends StatelessWidget {
  const _VendorInfo({required this.plate});

  final PlateEntity plate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const VectorGraphicsWidget(Assets.restaurantNameIc),
        const SizedBox(width: 12),
        Expanded(
          child: Text(plate.store!.name, style: context.style16400.copyWith(fontWeight: TStyle.bold)),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(Helpers.getProperPrice(plate.price), style: context.style16500),
            if (plate.offer != null)
              Text(Helpers.getProperPrice(plate.priceBeforeDiscount!), style: context.style14400.copyWith(decoration: TextDecoration.lineThrough)),
          ],
        ),
      ],
    );
  }
}

// Collapsible Option Widget
class _CollapsibleOption extends StatefulWidget {
  const _CollapsibleOption({
    required this.optionId,
    required this.optionName,
    required this.values,
    required this.type,
    required this.isRequired,
    required this.selectedId,
    required this.getSelectedOptions,
    required this.onValueSelected,
  });

  final String optionId;
  final String optionName;
  final List<SubAddonEntity> values;
  final OptionType type;
  final bool isRequired;
  final Set<String> selectedId;
  final Function(String path) getSelectedOptions;
  final Function({required String fullPath, required String id}) onValueSelected;

  @override
  State<_CollapsibleOption> createState() => _CollapsibleOptionState();
}

class _CollapsibleOptionState extends State<_CollapsibleOption> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Co.bg, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(color: Co.w900, borderRadius: BorderRadius.circular(12)),

            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Co.secondary.withOpacityNew(0.1), borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.fastfood, color: Co.secondary, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          Text(widget.optionName, style: context.style16400),
                          Text(
                            widget.type == OptionType.radio ? L10n.tr().select_1 : L10n.tr().multi_select,
                            style: context.style14400.copyWith(color: Co.darkGrey),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.isRequired ? Co.lightPurple : Co.grey.withOpacityNew(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.isRequired ? L10n.tr().required : L10n.tr().optional,
                        style: context.style12400.copyWith(fontWeight: FontWeight.w500, color: widget.isRequired ? Co.black : Co.grey),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(_isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ),
          if (_isExpanded)
            PlateOptionsWidget(
              optionId: widget.optionId,
              optionName: widget.optionName,
              values: widget.values,
              type: widget.type,
              selectedId: widget.selectedId,
              getSelectedOptions: widget.getSelectedOptions,
              onValueSelected: widget.onValueSelected,
            ),
        ],
      ),
    );
  }
}

// Notes Section
class _NotesSection extends StatelessWidget {
  const _NotesSection({required this.note, required this.onNoteChange});

  final String? note;
  final Function(String) onNoteChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(L10n.tr().notes, style: context.style16400.copyWith(fontWeight: TStyle.bold)),
        const SizedBox(height: 12),
        MainTextField(
          controller: TextEditingController(text: note),
          maxLines: 3,
          hintText: L10n.tr().addYourNotes,
          onChange: onNoteChange,
        ),
      ],
    );
  }
}
