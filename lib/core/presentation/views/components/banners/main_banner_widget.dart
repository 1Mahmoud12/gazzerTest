import 'package:flutter/material.dart';
import 'package:gazzer/core/domain/banner_entity.dart';
import 'package:gazzer/core/presentation/views/components/banners/count_doun_banner.dart';
import 'package:gazzer/core/presentation/views/components/banners/detailed_banner_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/animations/overlaping_cards_slider.dart';

class MainBannerWidget extends StatelessWidget {
  const MainBannerWidget({super.key, required this.banner});
  final BannerEntity banner;
  @override
  Widget build(BuildContext context) {
    final bannerAspectRation = 16 / 9;
    return InkWell(
      onTap: () {
        // TODO  Implement banner tap action
      },
      child: SizedBox(
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: bannerAspectRation,
          child: switch (banner.type) {
            BannerType.detailed => DetailedBannerWidget(banner: banner),
            BannerType.image => Image.network(
              banner.image!,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.info_outline, size: 32),
            ),
            BannerType.slider =>
              banner.images?.isNotEmpty != true
                  ? const SizedBox.shrink()
                  : OverlapingCardsSlider(
                      itemCount: banner.images!.length,
                      builder: (context, index) {
                        return AspectRatio(
                          aspectRatio: bannerAspectRation,
                          child: Image.network(banner.images![index], width: double.infinity, height: double.infinity, fit: BoxFit.fill),
                        );
                      },
                    ),
            BannerType.countdown => CountDownBanner(banner: banner),

            _ => const SizedBox.shrink(),
          },
        ),
      ),
    );
  }
}
