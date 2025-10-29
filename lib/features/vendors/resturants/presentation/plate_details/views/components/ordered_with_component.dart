import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/utils/product_shape_painter.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show GradientText, HorizontalSpacing;
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/add_icon.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/global_increment_widget.dart';

class OrderedWithComponent extends StatefulWidget {
  const OrderedWithComponent({
    super.key,
    required this.products,
    required this.title,
    required this.type,
    required this.isDisabled,
    required this.onQuantityChanged,
    this.initialQuantities,
  });
  final List<OrderedWithEntity> products;
  final String title;
  final CartItemType type;
  final bool isDisabled;
  final void Function(int id, int quantity) onQuantityChanged;
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

  void _updateQuantity(int id, bool isIncrement) {
    if (widget.isDisabled) return;
    final current = _quantities[id] ?? 0;
    final next = isIncrement ? current + 1 : (current - 1).clamp(0, 999999);
    setState(() {
      if (next <= 0) {
        _quantities.remove(id);
      } else {
        _quantities[id] = next;
      }
    });
    widget.onQuantityChanged(id, next <= 0 ? 0 : next);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        const VerticalSpacing(16),
        GradientText(text: widget.title, style: TStyle.blackBold(18)),

        SizedBox(
          height: 190,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: widget.products.length,
            separatorBuilder: (context, index) => const HorizontalSpacing(12),
            itemBuilder: (context, index) {
              final p = widget.products[index];
              final qty = _quantities[p.id] ?? 0;
              return SizedBox(
                width: 150,
                child: CustomPaint(
                  painter: ProductShapePaint(),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: 12,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CircleGradientBorderedImage(
                                  image: p.image,
                                  shadow: const BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                  showBorder: false,
                                ),
                              ),
                              FavoriteWidget(size: 24, fovorable: p),
                            ],
                          ),
                          const VerticalSpacing(8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        p.name,
                                        style: TStyle.primaryBold(15),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  Helpers.getProperPrice(p.price),
                                  style: TStyle.blackSemi(
                                    12,
                                  ).copyWith(shadows: AppDec.blackTextShadow),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4, bottom: 4),
                          child: qty > 0
                              ? AbsorbPointer(
                                  absorbing: widget.isDisabled,
                                  child: GlobalIncrementWidget(
                                    isDarkContainer: true,
                                    isHorizonal: true,
                                    isAdding: false,
                                    isRemoving: false,
                                    onChanged: (isAdding) => _updateQuantity(p.id, isAdding),
                                    initVal: qty,
                                  ),
                                )
                              : AbsorbPointer(
                                  absorbing: widget.isDisabled,
                                  child: AddIcon(
                                    isLoading: false,
                                    onTap: () => _updateQuantity(p.id, true),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
