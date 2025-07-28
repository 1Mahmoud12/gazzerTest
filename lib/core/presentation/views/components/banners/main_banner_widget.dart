import 'package:flutter/material.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/views/components/banners/count_doun_banner.dart';
import 'package:gazzer/core/presentation/views/components/banners/detailed_banner_widget.dart';
import 'package:gazzer/core/presentation/views/components/banners/horizontal_carousal.dart';
import 'package:gazzer/core/presentation/views/components/banners/longtudinal_carousal.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/widgets/cat_rest_shaking_img_add_widget.dart';

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
            BannerType.image => CustomNetworkImage(
              banner.image!,
              fit: BoxFit.fill,
            ),
            BannerType.sliderHorizontal => banner.images?.isNotEmpty != true ? const SizedBox.shrink() : HorizontalCarousal(images: banner.images!),

            /// ** the commented one the sliding overlaping carousal
            //  OverlapingCardsSlider(
            //     itemCount: banner.images!.length,
            //     builder: (context, index) {
            //       return AspectRatio(
            //         aspectRatio: bannerAspectRation,
            //         child: CustomNetworkImage(
            //           banner.images![index],
            //           width: double.infinity,
            //           height: double.infinity,
            //           fit: BoxFit.fill,
            //         ),
            //       );
            //     },
            //   ),
            BannerType.countdown => CountDownBanner(banner: banner),
            BannerType.shaking => const ShakingBanner(
              backGround: Assets.assetsPngShakingAddBg,
              foreGround: Assets.assetsPngPizza,
            ),
            BannerType.sliderVertical => LongitudinalCarousal(banner.images ?? []),

            _ => const SizedBox.shrink(),
          },
        ),
      ),
    );
  }
}
