import 'package:gazzer/features/dailyOffers/domain/entities/daily_offer_item_entity.dart';
import 'package:gazzer/features/dailyOffers/domain/entities/daily_offer_store_entity.dart';

/// Aggregate entity that groups the item with its store for Daily Offers
class DailyOfferEntity {
  final List<DailyOfferItemEntity>? item;
  final List<DailyOfferStoreEntity>? store;

  const DailyOfferEntity({
    required this.item,
    this.store,
  });
}
