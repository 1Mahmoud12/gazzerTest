import 'package:flutter/material.dart';
import 'package:gazzer/core/domain/banner_entity.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/spiky_shape_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text.dart';
import 'package:gazzer/core/utils/color_utils.dart';

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
            if (banner.title != null) GradientText(text: banner.title!, style: TStyle.blackBold(22), gradient: Grad().radialGradient),
            if (banner.subtitle != null)
              Text(
                banner.subtitle!,
                style: TStyle.blackRegular(12),
              ),
          ],
        ),
      ),
    );
  }
}
