import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/dialogs.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_bus.dart';
import 'package:gazzer/features/vendors/common/domain/item_option_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/add_to_cart_cubit.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/add_to_cart_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/components/ordered_with_component.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/product_price_summary.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/single_cat_restaurant/view/widgets/add_special_note.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/cubit/product_details_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/cubit/product_details_states.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/widgets/product_details_widget.dart';
import 'package:go_router/go_router.dart';

part 'product_details_screen.g.dart';

@TypedGoRoute<ProductDetailsRoute>(path: ProductDetailsScreen.route)
@immutable
class ProductDetailsRoute extends GoRouteData with _$ProductDetailsRoute {
  const ProductDetailsRoute({required this.productId, this.$extra});
  final int productId;
  final CartItemEntity? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => di<ProductDetailsCubit>(param1: productId),
      child: ProductDetailsScreen(productId: productId, cartItem: $extra),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  static const route = '/product-details';

  const ProductDetailsScreen({
    super.key,
    required this.productId,
    required this.cartItem,
  });
  final int productId;
  final CartItemEntity? cartItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        if (state is ProductDetailsError) {
          return Scaffold(
            appBar: MainAppBar(
              showCart: true,
              onShare: () {},
              showNotification: false,
            ),
            body: FailureComponent(
              message: state.message,
              onRetry: () => context.read<ProductDetailsCubit>().loadProductDetails(),
            ),
          );
        }
        if (state is ProductDetailsLoaded) {
          final cartItemToUse = cartItem;

          return BlocProvider(
            // TODO : will store item have options or not ?????? ask backend
            create: (context) => di<AddToCartCubit>(
              param1: (state.product, <ItemOptionEntity>[]),
              param2: cartItemToUse,
            ),
            child: Builder(
              builder: (context) {
                return Scaffold(
                  appBar: MainAppBar(
                    showCart: true,
                    onShare: () {},
                    showBadge: true,
                  ),
                  body: ListView(
                    children: [
                      Padding(
                        padding: AppConst.defaultHrPadding,
                        child: Text(
                          state.product.name,
                          style: TStyle.primaryBold(20),
                        ),
                      ),
                      ProductDetailsWidget(
                        product: state.product,
                      ),
                      const VerticalSpacing(16),

                      Padding(
                        padding: AppConst.defaultHrPadding,
                        child: Column(
                          children: [
                            OrderedWithComponent(
                              products: state.orderedWith,
                              type: CartItemType.product,
                              title: L10n.tr().youMayAlsoLike,
                              isDisabled: false,
                              //initialQuantities: context.read<AddToCartCubit>().orderedWithSelections,
                              //onQuantityChanged: (id, qty) => context.read<AddToCartCubit>().setOrderedWithQuantity(id, qty),
                            ),
                            const VerticalSpacing(16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                BlocBuilder<AddToCartCubit, AddToCartStates>(
                                  builder: (context, state) => AddSpecialNote(
                                    note: state.note,
                                    onNoteChange: context.read<AddToCartCubit>().setNote,
                                  ),
                                ),
                              ],
                            ),
                            const VerticalSpacing(16),
                          ],
                        ),
                      ),
                    ],
                  ),
                  bottomNavigationBar: state.product.quantityInStock == 0
                      ? const SizedBox()
                      : BlocConsumer<AddToCartCubit, AddToCartStates>(
                          listener: (context, cartState) {
                            if (cartState.status == ApiStatus.success) {
                              // Reload CartCubit to reflect the updated cart state
                              context.read<CartCubit>().loadCart();
                              Alerts.showToast(cartState.message, error: false);
                              context.pop(
                                true,
                              ); // ** to declare that the cart has changed
                            } else if (cartState.status == ApiStatus.error) {
                              Alerts.showToast(cartState.message);
                            }
                          },
                          builder: (context, cartState) {
                            final cubit = context.read<AddToCartCubit>();
                            if (cartState.quantity == 0) return const SizedBox.shrink();
                            return PopScope(
                              canPop: Session().client == null || !cartState.hasUserInteracted,
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
                                        cubit.userRequestClose();
                                        if (context.mounted) context.pop();
                                      }
                                    });
                                  }
                                }
                              },
                              child: ProductPriceSummary(
                                isLoading: cartState.status == ApiStatus.loading,
                                price: cartState.totalPrice,
                                quantity: cartState.quantity,
                                maxQuantity: state.product.quantityInStock,
                                onChangeQuantity: (isAdding) {
                                  if (isAdding) {
                                    cubit.increment();
                                  } else {
                                    cubit.decrement();
                                  }
                                },
                                onsubmit: () async {
                                  cubit.addToCart(context);
                                },
                              ),
                            );
                          },
                        ),
                );
              },
            ),
          );
        }
        return Scaffold(
          appBar: MainAppBar(
            showCart: true,
            onShare: () {},
            showNotification: false,
          ),
          body: const Center(child: AdaptiveProgressIndicator()),
        );
      },
    );
  }
}
