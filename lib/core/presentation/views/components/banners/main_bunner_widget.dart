import 'package:flutter/material.dart';
import 'package:gazzer/core/domain/banner_entity.dart';
import 'package:gazzer/core/presentation/views/components/banners/detailed_banner_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/animations/overlaping_cards_slider.dart';

class MainBannerWidget extends StatelessWidget {
  const MainBannerWidget({super.key, required this.banner});
  final BannerEntity banner;
  @override
  Widget build(BuildContext context) {
    switch (banner.type) {
      case BannerType.detailed:
        return DetailedBannerWidget(banner: banner);
      case BannerType.image:
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            banner.image!,
            fit: BoxFit.cover,
          ),
        );
      case BannerType.slider:
        if (banner.images?.isNotEmpty != true) return SizedBox.shrink();
        return OverlapingCardsSlider(
          itemCount: banner.images!.length,
          builder: (context, index) {
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(banner.images![index], width: double.infinity, height: double.infinity, fit: BoxFit.cover),
            );
          },
        );
      case BannerType.countdown:
      // TODO: Implement countdown banner widget here

      default:
        return SizedBox.shrink();
    }
  }
}
