import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/cart_to_increment_icon.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class OrderedWithComponent extends StatefulWidget {
  const OrderedWithComponent({
    super.key,
    required this.products,
    required this.title,
    required this.type,
    required this.isDisabled,
    this.onQuantityChanged,
    this.initialQuantities,
  });
  final List<OrderedWithEntity> products;
  final String title;
  final CartItemType type;
  final bool isDisabled;
  final void Function(int id, int quantity)? onQuantityChanged;
  final Map<int, int>? initialQuantities;

  @override
  State<OrderedWithComponent> createState() => _OrderedWithComponentState();
}

class _OrderedWithComponentState extends State<OrderedWithComponent> {
  late final Map<int, int> _quantities;

  @override
  void initState() {
    super.initState();
    _quantities = Map<int, int>.from(widget.initialQuantities ?? {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        const VerticalSpacing(16),
        Padding(
          padding: AppConst.defaultHrPadding,
          child: Text(widget.title, style: TStyle.robotBlackSubTitle().copyWith(color: Co.purple)),
        ),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),

          child: Row(
            children: List.generate(widget.products.length, (index) {
              final p = widget.products[index];
              return Container(
                width: MediaQuery.sizeOf(context).width / 3,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CustomNetworkImage(p.image, width: double.infinity, height: 120, borderRaduis: 20),
                        FavoriteWidget(size: 24, fovorable: p),
                      ],
                    ),
                    const VerticalSpacing(8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(p.name, style: TStyle.primaryBold(15), maxLines: 1, overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(width: 10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(Assets.starRateIc, width: 20, height: 20),
                            const HorizontalSpacing(4),
                            Text(p.rate.toStringAsFixed(1), style: TStyle.robotBlackRegular()),
                          ],
                        ),
                      ],
                    ),
                    const VerticalSpacing(8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Wrap(
                            //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            runAlignment: WrapAlignment.spaceBetween,
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Column(
                                children: [
                                  FittedBox(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(Helpers.getProperPrice(p.price), style: TStyle.robotBlackMedium().copyWith(color: Co.purple)),
                                  ),
                                  if (p.offer != null)
                                    FittedBox(
                                      alignment: AlignmentDirectional.centerStart,
                                      child: Text(
                                        Helpers.getProperPrice(p.priceBeforeDiscount!),
                                        style: TStyle.robotBlackMedium().copyWith(decoration: TextDecoration.lineThrough, color: Co.greyText),
                                      ),
                                    ),
                                ],
                              ),

                              const SizedBox(width: 8),
                              CartToIncrementIcon(isHorizonal: true, product: p, iconSize: 25, isDarkContainer: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
