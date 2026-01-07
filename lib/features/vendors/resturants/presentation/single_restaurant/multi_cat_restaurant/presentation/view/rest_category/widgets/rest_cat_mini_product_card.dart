import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/doubled_decorated_widget.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';

class RestCatMiniProductCard extends StatelessWidget {
  const RestCatMiniProductCard({super.key, required this.prod});
  final GenericItemEntity prod;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Co.bg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppConst.defaultInnerRadius),
          topRight: Radius.circular(AppConst.defaultInnerRadius),
          bottomLeft: Radius.circular(AppConst.defaultRadius),
          bottomRight: Radius.circular(AppConst.defaultRadius),
        ),
        boxShadow: [const BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 4, offset: Offset(0, 0))],
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.2,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: const Radius.circular(30)),
              child: Image.asset(prod.image, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(prod.name, style: context.style14400.copyWith(fontWeight: TStyle.bold)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DoubledDecoratedWidget(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                        child: InkWell(
                          onTap: () {
                            SystemSound.play(SystemSoundType.click);
                            PlateDetailsRoute(id: prod.id).push(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(Icons.add, color: Co.second2, size: 20),
                          ),
                        ),
                      ),
                      DecoratedFavoriteWidget(
                        isDarkContainer: false,
                        size: 16,
                        padding: 6,
                        borderRadius: AppConst.defaultInnerBorderRadius,
                        fovorable: prod,
                      ),
                    ],
                  ),
                  Row(
                    spacing: 6,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Co.secondary, size: 20),
                      Text(
                        prod.rate.toStringAsFixed(1),
                        style: context.style14400.copyWith(fontWeight: TStyle.bold, color: Co.secondary).copyWith(color: Co.secondary),
                      ),
                    ],
                  ),
                  Text(Helpers.getProperPrice(prod.price), style: context.style14400.copyWith(fontWeight: TStyle.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
