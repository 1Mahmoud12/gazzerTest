import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/widgets/favorite_widget.dart';

class VerticalProductCard extends StatelessWidget {
  const VerticalProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Stack(
            children: [
              SizedBox.expand(child: SvgPicture.asset(Assets.assetsSvgProdCard, fit: BoxFit.fill)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: GradientBoxBorder(gradient: Grad.shadowGrad(false), width: 4),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: ClipOval(
                            child: Image.asset(
                              Assets.assetsPngFastFood,
                              fit: BoxFit.fitHeight,
                              height: constraints.maxWidth * 0.7,
                              width: constraints.maxWidth * 0.7,
                            ),
                          ),
                        ),
                      ),
                      FavoriteWidget(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Fresh Mart", style: TStyle.primaryBold(18)),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Co.secondary, size: 16),
                                Text("4.5", style: TStyle.mainwSemi(14).copyWith(color: Co.secondary)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.55,
                          child: Text(
                            "Valid until May 15, 2025",
                            style: TStyle.mainwSemi(14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: Grad.radialGradient,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("40%\nOFF", style: TStyle.mainwBold(13).copyWith(color: Co.secondary)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
