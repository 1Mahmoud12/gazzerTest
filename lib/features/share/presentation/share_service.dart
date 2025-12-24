import 'package:flutter/material.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/share/data/share_models.dart';
import 'package:gazzer/features/share/domain/share_repo.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/store/pharmacy_store_screen.dart';
import 'package:go_router/go_router.dart';

enum ShareEnumType { vendor, store_item, restaurant_plates, store, restaurant_items, offer, cart }

class ShareService {
  final ShareRepo _shareRepo = di.get<ShareRepo>();

  /// Generate a share link
  Future<Result<ShareGenerateResponse>> generateShareLink({
    required String type, // vendor, store_items, restaurant_plates, restaurant_items, offer, cart
    required String shareableType, // vendor, store_items, restaurant_plates, restaurant_items, offer
    required String shareableId,
    String channel = 'copy_link',
  }) async {
    final request = ShareGenerateRequest(type: type, shareableType: shareableType, shareableId: shareableId, channel: channel);

    return _shareRepo.generateShareLink(request);
  }

  /// Handle opening a share link
  Future<void> handleShareLink(BuildContext context, String token) async {
    animationDialogLoading();
    final result = await _shareRepo.openShareLink(token);
    closeDialog();
    switch (result) {
      case Ok<ShareOpenResponse>(value: final response):
        _navigateToShareContent(context, response);
      case Err<ShareOpenResponse>(error: final error):
        Alerts.showToast(error.message);
    }
  }

  /// Navigate to the appropriate page based on share type
  void _navigateToShareContent(BuildContext context, ShareOpenResponse response) {
    final shareType = response.shareType;
    final shareableId = response.shareableId;

    switch (shareType) {
      case 'store_items':
        // Navigate to product details
        ProductDetailsRoute(productId: shareableId).push(context);
        break;

      case 'restaurant_plates':
      case 'restaurant_items':
        // Navigate to plate details
        PlateDetailsRoute(id: shareableId).push(context);
        break;

      case 'store':
        // Navigate to restaurant/store details
        // Check shareable_type to determine if it's a restaurant or store
        // If shareable_type contains "Store" or "store", navigate to store details
        // Otherwise, navigate to restaurant details
        if (response.storeCategoryType == VendorType.restaurant.value) {
          RestaurantDetailsRoute(id: response.shareableId).push(context);
        } else if (response.storeCategoryType == VendorType.grocery.value) {
          StoreDetailsRoute(storeId: response.shareableId).push(context);
        } else if (response.storeCategoryType == VendorType.pharmacy.value) {
          PharmacyStoreScreenRoute(id: response.shareableId).push(context);
        }
        break;

      case 'cart':
        // Navigate to cart
        context.push('/cart');
        break;

      default:
        Alerts.showToast('Unknown share type: $shareType');
    }
  }
}
