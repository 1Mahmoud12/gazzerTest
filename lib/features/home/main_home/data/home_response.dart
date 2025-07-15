import 'package:gazzer/features/home/main_home/data/banner_dto.dart';
import 'package:gazzer/features/home/main_home/data/section_dto.dart';
import 'package:gazzer/features/home/main_home/data/section_item_dto.dart';
import 'package:gazzer/features/home/main_home/presentaion/data/home_response_model.dart';

class HomeResponseDTO {
  late final (List<CategoryDTO>, BannerDTO?)? categories;
  late final (List<SectionItemDTO?>, BannerDTO?)? dailyOffers;
  late final (List<SectionItemDTO?>, BannerDTO?)? suggested;
  late final (List<SectionItemDTO?>, BannerDTO?)? topItems;
  late final (List<VendorDTO?>, BannerDTO?)? topVendors;
  late final (List<SectionItemDTO?>, BannerDTO?)? bestPopular;

  HomeResponseDTO({
    required this.categories,
    required this.dailyOffers,
    required this.suggested,
    required this.topItems,
    required this.topVendors,
    required this.bestPopular,
  });

  HomeResponseDTO.fromJson(Map<String, dynamic> json) {
    final sections = <SectionDTO>[];
    for (var item in json['data']) {
      sections.add(SectionDTO.fromJson(item));
    }
    for (final sec in sections) {
      switch (sec.type) {
        case SectionType.categories:
          categories = (sec.data!.cast<CategoryDTO>(), sec.banner);
          break;
        case SectionType.dailyOffers:
          dailyOffers = (sec.data!.cast<SectionItemDTO>(), sec.banner);
          break;
        case SectionType.suggested:
          suggested = (sec.data!.cast<SectionItemDTO>(), sec.banner);
          break;
        case SectionType.topItems:
          topItems = (sec.data!.cast<SectionItemDTO>(), sec.banner);
          break;
        case SectionType.topVendors:
          topVendors = (sec.data!.cast<VendorDTO>(), sec.banner);
          break;
        case SectionType.bestPopular:
          bestPopular = (sec.data!.cast<SectionItemDTO>(), sec.banner);
          break;
        case SectionType.unknown:
          // Handle unknown section type if necessary
          break;
      }
    }
  }

  HomeDataModel toModel() {
    return HomeDataModel(
      categories: categories == null ? null : (categories!.$1.map((e) => e.toCategoryEntity()).toList(), categories!.$2?.toEntity()),
      dailyOffers: dailyOffers == null ? null : (dailyOffers!.$1.map((e) => e?.toEntity()).toList(), dailyOffers!.$2?.toEntity()),
      suggested: suggested == null ? null : (suggested!.$1.map((e) => e?.toEntity()).toList(), suggested!.$2?.toEntity()),
      topItems: topItems == null ? null : (topItems!.$1.map((e) => e?.toEntity()).toList(), topItems!.$2?.toEntity()),
      topVendors: topVendors == null ? null : (topVendors!.$1.map((e) => e?.toEntity()).toList(), topVendors!.$2?.toEntity()),
      bestPopular: bestPopular == null ? null : (bestPopular!.$1.map((e) => e?.toEntity()).toList(), bestPopular!.$2?.toEntity()),
    );
  }
}
