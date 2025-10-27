import 'package:gazzer/core/data/dto/banner_dto.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';
import 'package:gazzer/features/home/main_home/data/dtos/best_popular_dto.dart';
import 'package:gazzer/features/home/main_home/data/product_item_dto.dart';
import 'package:gazzer/features/home/main_home/data/section_dto.dart';
import 'package:gazzer/features/home/main_home/presentaion/data/home_response_model.dart';

class HomeResponseDTO {
  final (List<MainCategoryDTO>?, BannerDTO?)? categories;
  final (List<SectionItemDTO?>?, BannerDTO?)? dailyOffers;
  final (List<SectionItemDTO?>?, BannerDTO?)? suggested;
  final (List<SectionItemDTO?>?, BannerDTO?)? topItems;
  final (List<VendorDTO?>?, BannerDTO?)? topVendors;
  final (List<VendorEntity?>?, BannerDTO?)? bestPopular;

  HomeResponseDTO({
    this.categories,
    this.dailyOffers,
    this.suggested,
    this.topItems,
    this.topVendors,
    this.bestPopular,
  });

  factory HomeResponseDTO.fromJson(Map<String, dynamic> json) {
    (List<MainCategoryDTO>?, BannerDTO?)? categories;
    (List<SectionItemDTO?>?, BannerDTO?)? dailyOffers;
    (List<SectionItemDTO?>?, BannerDTO?)? suggested;
    (List<SectionItemDTO?>?, BannerDTO?)? topItems;
    (List<VendorDTO?>?, BannerDTO?)? topVendors;
    (List<VendorEntity?>?, BannerDTO?)? bestPopular;

    if (json['data'] != null && json['data'] is List) {
      final sections = <SectionDTO>[];
      for (var item in json['data']) {
        sections.add(SectionDTO.fromJson(item));
      }

      for (final sec in sections) {
        switch (sec.type) {
          case SectionType.categories:
            categories = (sec.data?.cast<MainCategoryDTO>(), sec.banner);
            break;
          case SectionType.dailyOffers:
            dailyOffers = (sec.data?.cast<SectionItemDTO>(), sec.banner);
            break;
          case SectionType.suggested:
            suggested = (sec.data?.cast<SectionItemDTO>(), sec.banner);
            break;
          case SectionType.topItems:
            topItems = (sec.data?.cast<SectionItemDTO>(), sec.banner);
            break;
          case SectionType.topVendors:
            topVendors = (sec.data?.cast<VendorDTO>(), sec.banner);
            break;
          case SectionType.bestPopular:
            // Parse best popular from raw JSON data
            final rawSections = json['data'] as List;
            for (var rawSection in rawSections) {
              if (rawSection['type'] == 'best_popular' && rawSection['data'] != null) {
                final stores = (rawSection['data'] as List)
                    .map(
                      (store) => BestPopularStoreDto.fromJson(store).toEntity(),
                    )
                    .toList();
                bestPopular = (stores, sec.banner);
                break;
              }
            }
            break;
          case SectionType.unknown:
            break;
        }
      }
    }

    return HomeResponseDTO(
      categories: categories,
      dailyOffers: dailyOffers,
      suggested: suggested,
      topItems: topItems,
      topVendors: topVendors,
      bestPopular: bestPopular,
    );
  }

  HomeDataModel toModel() {
    return HomeDataModel(
      categories: categories?.$1?.map((e) => e.toEntity()).toList() ?? [],
      categoriesBanner: categories?.$2?.toEntity(),
      dailyOffers: dailyOffers?.$1?.map((e) => e?.toEntity()).toList() ?? [],
      dailyOffersBanner: dailyOffers?.$2?.toEntity(),
      suggested: suggested?.$1?.map((e) => e?.toEntity()).toList() ?? [],
      suggestedBanner: suggested?.$2?.toEntity(),
      topItems: topItems?.$1?.map((e) => e?.toEntity()).toList() ?? [],
      topItemsBanner: topItems?.$2?.toEntity(),
      topVendors: topVendors?.$1?.map((e) => e?.toEntity()).toList() ?? [],
      topVendorsBanner: topVendors?.$2?.toEntity(),
      bestPopular: bestPopular?.$1 ?? [],
      bestPopularBanner: bestPopular?.$2?.toEntity(),
    );
  }
}
