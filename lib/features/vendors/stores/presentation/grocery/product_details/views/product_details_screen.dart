import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/failure_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/dialogs.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_bus.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/add_to_cart_cubit.dart';
import 'package:gazzer/features/vendors/common/presentation/cubit/add_to_cart_states.dart';
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
  const ProductDetailsScreen({super.key, required this.productId, required this.cartItem});
  final int productId;
  final CartItemEntity? cartItem;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        if (state is ProductDetailsError) {
          return Scaffold(
            appBar: MainAppBar(showCart: true, onShare: () {}, showNotification: false),
            body: FailureWidget(
              message: state.message,
              onRetry: () => context.read<ProductDetailsCubit>().loadProductDetails(),
            ),
          );
        }
        if (state is ProductDetailsLoaded) {
          return BlocProvider(
            // TODO : will store item have options or not ?????? ask backend
            create: (context) => di<AddToCartCubit>(param1: (state.product, <ItemOptionEntity>[]), param2: cartItem),
            child: Builder(
              builder: (context) {
                return Scaffold(
                  appBar: MainAppBar(showCart: true, onShare: () {}, showNotification: false),
                  body: ListView(
                    children: [
                      Padding(
                        padding: AppConst.defaultHrPadding,
                        child: Text(state.product.name, style: TStyle.primaryBold(20)),
                      ),
                      ProductDetailsWidget(
                        product: state.product,
                      ),
                      const VerticalSpacing(16),

                      Padding(
                        padding: AppConst.defaultHrPadding,
                        child: Column(
                          children: [
                            // OrderedWithComponent(products: Fakers.plateOrderedWith),
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
                  bottomNavigationBar: BlocConsumer<AddToCartCubit, AddToCartStates>(
                    listener: (context, state) {
                      if (state.status == ApiStatus.success) {
                        Alerts.showToast(state.message, error: false);
                        context.pop(true); // ** to declare that the cart has changed
                      } else if (state.status == ApiStatus.error) {
                        Alerts.showToast(state.message);
                      }
                    },
                    builder: (context, cartState) {
                      final cubit = context.read<AddToCartCubit>();
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
                          onChangeQuantity: (isAdding) {
                            if (isAdding) {
                              cubit.increment();
                            } else {
                              cubit.decrement();
                            }
                          },
                          onsubmit: cubit.addToCart,
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
          appBar: MainAppBar(showCart: true, onShare: () {}, showNotification: false),
          body: const Center(child: AdaptiveProgressIndicator()),
        );
      },
    );
  }
}
