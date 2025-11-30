import 'package:gazzer/features/home/main_home/data/product_item_dto.dart';

/// Minimal store entity derived from DailyOffers DTO (StoreInfo)
class DailyOfferStoreEntity {
  final int id;
  final String name;
  final String image;
  final String type; // restaurant | grocery | pharmacy ...
  final bool isOpen;

  const DailyOfferStoreEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    required this.isOpen,
  });

  factory DailyOfferStoreEntity.fromDto(StoreInfo dto) {
    return DailyOfferStoreEntity(
      id: dto.storeId ?? 0,
      name: dto.storeName ?? '',
      image: dto.storeImage ?? '',
      type: dto.storeCategoryType ?? '',
      isOpen: dto.isOpen == 1,
    );
  }
}
