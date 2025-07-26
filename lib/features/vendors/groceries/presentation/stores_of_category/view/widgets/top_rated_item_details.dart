import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/add_icon.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class TopRatedItemDetails extends StatelessWidget {
  const TopRatedItemDetails({super.key, required this.item, required this.shadowColor});
  final GenericItemEntity item;
  final ValueNotifier<Color> shadowColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: ValueListenableBuilder(
                valueListenable: shadowColor,
                builder: (context, value, child) => PhysicalModel(
                  color: Colors.transparent,
                  shadowColor: value,
                  shape: BoxShape.circle,
                  elevation: 12,
                  child: child,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(item.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  const CircleAvatar(radius: 24, backgroundColor: Co.second2),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.name,
                              style: TStyle.whiteBold(16).copyWith(fontWeight: TStyle.bolder),
                            ),
                            AddIcon(
                              onTap: () {},
                            ),
                          ],
                        ),
                        Text(
                          item.description,
                          style: TStyle.whiteSemi(14).copyWith(color: Colors.white60),
                        ),
                        Row(
                          spacing: 12,
                          children: [
                            Text(
                              Helpers.getProperPrice(item.price),
                              style: TStyle.whiteBold(12),
                            ),
                            if ((item.priceBeforeDiscount ?? 0) > 0)
                              Text(
                                Helpers.getProperPrice(item.priceBeforeDiscount!),
                                style: TStyle.secondaryBold(12).copyWith(
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            Expanded(
                              child: Row(
                                spacing: 6,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.star, color: Co.secondary, size: 20),
                                  Text(
                                    item.rate.toStringAsFixed(2),
                                    style: TStyle.secondaryBold(12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
