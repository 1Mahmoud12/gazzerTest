import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_item_entity.dart';

/// Tile widget for displaying an order item with checkbox selection
class MissingItemTile extends StatelessWidget {
  const MissingItemTile({
    super.key,
    required this.item,
    required this.isSelected,
    required this.quantity,
    required this.onTap,
    required this.onQuantityChanged,
  });

  final OrderDetailItemEntity item;
  final bool isSelected;
  final int quantity;
  final VoidCallback onTap;
  final ValueChanged<int> onQuantityChanged;

  static const double _imageSize = 60.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? Co.purple : Colors.transparent, width: isSelected ? 2 : 0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Transform.scale(
                  scale: 1.1,
                  child: Checkbox(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: isSelected,
                    visualDensity: VisualDensity.compact,
                    activeColor: Co.purple,
                    onChanged: (_) => onTap(),
                  ),
                ),
                const HorizontalSpacing(8),
                ClipOval(
                  child: CustomNetworkImage(item.image, width: _imageSize, height: _imageSize, fit: BoxFit.cover),
                ),
                const HorizontalSpacing(8),
                Expanded(
                  child: Column(
                    children: [
                      Text(item.name, style: context.style14400, maxLines: 1, overflow: TextOverflow.ellipsis),
                      if (isSelected) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text('${L10n.tr().quantity}: ', style: context.style12400),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Co.lightPurple),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: quantity > 1 ? () => onQuantityChanged(quantity - 1) : () => onQuantityChanged(0),
                                    child: const Icon(Icons.remove, size: 18),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Text('$quantity', style: context.style14400),
                                  ),
                                  InkWell(
                                    onTap: quantity < item.quantity
                                        ? () => onQuantityChanged(quantity + 1)
                                        : () {
                                            Alerts.showToast(L10n.tr().max_quantity_reached_for_product);
                                          },
                                    child: Icon(Icons.add, size: 18, color: quantity < item.quantity ? null : Co.grey.withOpacityNew(.5)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const HorizontalSpacing(8),
                Text(Helpers.getProperPrice(item.price), style: context.style14400.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
