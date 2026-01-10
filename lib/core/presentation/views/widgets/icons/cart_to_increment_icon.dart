import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/add_icon.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/features/auth/login/presentation/login_screen.dart';
import 'package:gazzer/features/cart/data/requests/cart_item_request.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/global_increment_widget.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';
import 'package:go_router/go_router.dart';

/// A widget that displays either an add-to-cart button or increment/decrement controls
/// based on whether the item is already in the cart.
///
/// Integrates with [CartCubit] for all cart operations and real-time updates.
class CartToIncrementIcon extends StatelessWidget {
  const CartToIncrementIcon({
    super.key,
    required this.product,
    required this.isHorizonal,
    required this.iconSize,
    required this.isDarkContainer,
    this.isCartIcon = true,
    this.newUi = false,
  });

  final GenericItemEntity product;
  final bool isHorizonal;
  final double iconSize;
  final bool isDarkContainer;
  final bool isCartIcon;
  final bool newUi;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {
        // Show alert when there's an error updating the cart
        if (state is UpdateItemError) {
          final cubit = context.read<CartCubit>();
          final cartItem = findCartItem(cubit, product);
          if (state.needsNewPouchApproval) {
            return;
          }
          // Check if error is for this product (either by cartId or product id)
          if (state.cartId == cartItem?.cartId || state.cartId == product.id) {
            Alerts.showToast(state.message);
          }
        }
      },
      buildWhen: _shouldRebuild,
      builder: (context, state) => Container(
        constraints: BoxConstraints(maxHeight: 40.h),
        child: _buildCartWidget(context, state),
      ),
    );
  }

  // ==================== Build When Logic ====================

  bool _shouldRebuild(CartStates previous, CartStates current) {
    // Rebuild on any cart state change that affects cart items
    // This ensures the widget updates when:
    // - Cart is loaded/updated (FullCartStates)
    // - Items are added/removed/updated (UpdateItemStates)
    // - Navigating back after updating items in detail screens
    return current is FullCartStates || current is UpdateItemStates;
  }

  // ==================== Main Builder ====================

  Widget _buildCartWidget(BuildContext context, CartStates state) {
    final cubit = context.read<CartCubit>();
    final cartItem = findCartItem(cubit, product);
    final updateState = _extractUpdateState(state);

    if (cartItem != null) {
      return _buildIncrementWidget(context, cartItem, updateState);
    } else {
      return _buildAddToCartWidget(context, updateState);
    }
  }

  UpdateItemStates? _extractUpdateState(CartStates state) {
    return state is UpdateItemStates ? state : null;
  }

  // ==================== Increment Widget (Item in Cart) ====================

  Widget _buildIncrementWidget(BuildContext context, CartItemEntity cartItem, UpdateItemStates? updateState) {
    final isUpdating = _isItemBeingUpdated(cartItem, updateState);
    final hasReachedMaxStock = _hasReachedStockLimit(cartItem);

    return GlobalIncrementWidget(
      iconSize: iconSize,
      isDarkContainer: isDarkContainer,
      isAdding: isUpdating && updateState!.isAdding,
      isRemoving: isUpdating && updateState!.isRemoving,
      onChanged: ({required isAdding}) => _handleQuantityChange(context, cartItem, isAdding, hasReachedMaxStock),
      initVal: cartItem.quantity,
      isHorizonal: isHorizonal,
      canAdd: !hasReachedMaxStock,
    );
  }

  bool _isItemBeingUpdated(CartItemEntity cartItem, UpdateItemStates? updateState) {
    return updateState != null && updateState.cartId == cartItem.cartId;
  }

  bool _hasReachedStockLimit(CartItemEntity cartItem) {
    return cartItem.quantityInStock != null && cartItem.quantity >= cartItem.quantityInStock!;
  }

  void _handleQuantityChange(BuildContext context, CartItemEntity cartItem, bool isAdding, bool hasReachedMaxStock) {
    if (isAdding) {
      // Navigate to details if product has options (customization required)
      if (product.hasOptions) {
        _navigateToProductDetails(context, cartItem);
        return;
      }
      _handleAddQuantity(context, cartItem, hasReachedMaxStock);
    } else {
      _handleReduceQuantity(context, cartItem);
    }
  }

  void _handleAddQuantity(BuildContext context, CartItemEntity cartItem, bool hasReachedMaxStock) {
    // Prevent adding beyond stock limit
    if (hasReachedMaxStock) {
      Alerts.showToast(L10n.tr(context).max_quantity_reached_for_product);
      return;
    }

    context.read<CartCubit>().updateItemQuantity(cartItem.cartId, cartItem.quantity + 1, true, context);
  }

  void _handleReduceQuantity(BuildContext context, CartItemEntity cartItem) {
    final cubit = context.read<CartCubit>();

    if (cartItem.quantity == 1) {
      // Remove item if quantity would become 0
      cubit.removeItemFromCart(cartItem.cartId);
    } else {
      // Decrease quantity
      cubit.updateItemQuantity(cartItem.cartId, cartItem.quantity - 1, false, context);
    }
  }

  // ==================== Add to Cart Widget (Item Not in Cart) ====================

  Widget _buildAddToCartWidget(BuildContext context, UpdateItemStates? updateState) {
    final isAdding = _isItemBeingAdded(updateState);

    return isCartIcon ? _buildCartIconButton(context, isAdding) : _buildSimpleAddIcon(context, isAdding);
  }

  bool _isItemBeingAdded(UpdateItemStates? updateState) {
    return updateState != null && updateState.cartId == product.id && updateState.isAdding;
  }

  Widget _buildSimpleAddIcon(BuildContext context, bool isLoading) {
    return AddIcon(isLoading: isLoading, onTap: () => _handleAddToCart(context));
  }

  Widget _buildCartIconButton(BuildContext context, bool isLoading) {
    return isLoading ? _buildLoadingIndicator() : _buildCartButton(context);
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: AdaptiveProgressIndicator(size: 20, color: isDarkContainer ? Co.secondary : Co.purple),
    );
  }

  Widget _buildCartButton(BuildContext context) {
    return InkWell(
      onTap: () => _handleAddToCart(context),
      child: newUi
          ? FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.bottomEnd,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(color: Co.purple, borderRadius: BorderRadius.circular(100)),
                child: Text(L10n.tr().addToCart, style: context.style16400.copyWith(color: Co.white)),
              ),
            )
          : FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.bottomEnd,
              child: Container(
                decoration: BoxDecoration(color: Co.purple, borderRadius: BorderRadius.circular(100)),
                padding: const EdgeInsets.all(8.0),

                child: const VectorGraphicsWidget(Assets.cartIc, height: 20, width: 20, colorFilter: ColorFilter.mode(Co.white, BlendMode.srcIn)),
              ),
            ),
    );
  }

  void _handleAddToCart(BuildContext context) {
    if (Session().client == null) {
      Alerts.showToast(L10n.tr().pleaseLoginToUseCart);
      context.push(LoginScreen.route);
      return;
    }
    // Navigate to details if product has options (customization required)
    if (product.hasOptions) {
      _navigateToProductDetails(context, null);
      return;
    }

    // Add item to cart with default options
    context.read<CartCubit>().addToCart(
      context,
      CartableItemRequest(id: product.id, quantity: 1, options: {}, type: getProductType(product), note: null, cartItemId: null),
    );
  }

  // ==================== Navigation ====================

  void _navigateToProductDetails(BuildContext context, CartItemEntity? cartItem) {
    switch (product) {
      case PlateEntity():
        PlateDetailsRoute(id: product.id /*$extra: cartItem*/).push(context);
        break;
      case ProductEntity():
        ProductDetailsRoute(
          productId: product.id,
          //  $extra: cartItem,
        ).push(context);
        break;
      case OrderedWithEntity():
        // No details screen for ordered items
        break;
    }
  }
}
// ==================== Cart Item Retrieval ====================

CartItemEntity? findCartItem(CartCubit cubit, GenericItemEntity product) {
  final allCartItems = cubit.vendors.expand((vendor) => vendor.items);
  return allCartItems.firstWhereOrNull((item) => item.prod.id == product.id && item.type == getProductType(product));
}
// ==================== Helper Methods ====================

CartItemType getProductType(GenericItemEntity product) {
  return switch (product) {
    PlateEntity() => CartItemType.plate,
    ProductEntity() => CartItemType.product,
    OrderedWithEntity() => CartItemType.restaurantItem,
  };
}
