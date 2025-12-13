import 'package:flutter/material.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/color_utils.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/spiky_shape_widget.dart';

class DetailedBannerWidget extends StatelessWidget {
  const DetailedBannerWidget({super.key, required this.banner});
  final BannerEntity banner;
  @override
  Widget build(BuildContext context) {
    if (banner.type != BannerType.detailed) return SizedBox.fromSize();
    return InkWell(
      child: SpikyShapeWidget(
        heroTag: Tags.spickyShape,
        color: ColorUtils.safeHexToColor(banner.backgroundColor),
        image: banner.image,
        rtChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (banner.title != null) Text(banner.title!, style: TStyle.robotBlackSubTitle().copyWith(color: Co.purple)),
            if (banner.subtitle != null) Text(banner.subtitle!, style: TStyle.robotBlackMedium().copyWith(color: Co.purple)),
          ],
        ),
      ),
    );
  }
}
