import 'package:gazzer/features/home/main_home/data/banner_dto.dart';
import 'package:gazzer/features/home/main_home/data/section_dto.dart';
import 'package:gazzer/features/home/main_home/data/section_item_dto.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';

class HomeReponse {
  late final (List<CategoryEntity>, BannerDTO?)? categories;
  late final (List<SectionItemDTO>, BannerDTO?)? dailyOffers;
  late final (List<SectionItemDTO>, BannerDTO?)? suggested;
  late final (List<SectionItemDTO>, BannerDTO?)? topItems;
  late final (List<SectionItemDTO>, BannerDTO?)? topVendors;
  late final (List<SectionItemDTO>, BannerDTO?)? bestPopular;

  HomeReponse({
    required this.categories,
    required this.dailyOffers,
    required this.suggested,
    required this.topItems,
    required this.topVendors,
    required this.bestPopular,
  });

  HomeReponse.fromJson(Map<String, dynamic> json) {
    final sections = <SectionDTO>[];
    for (var item in json['data']) {
      sections.add(SectionDTO.fromJson(item));
    }
    for (final sec in sections) {
      switch (sec.type) {
        case SectionType.categories:
          categories = (sec.data!.cast<CategoryDTO>().map((e) => e.toCategoryEntity()).toList(), sec.banner);
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
          topVendors = (sec.data!.cast<SectionItemDTO>(), sec.banner);
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
}
