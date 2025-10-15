import 'package:gazzer/features/dailyOffers/domain/entities/daily_offer_store_entity.dart';
import 'package:gazzer/features/vendors/common/domain/offer_entity.dart';

/// Item entity for Daily Offers cards (compatible data with product/plate card)
class DailyOfferItemEntity {
  final int id;
  final String name;
  final String image;
  final double price;
  final OfferEntity? offer;
  final String itemType; // Product | Plate
  final DailyOfferStoreEntity? store;

  const DailyOfferItemEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.itemType,
    this.offer,
    this.store,
  });
}
