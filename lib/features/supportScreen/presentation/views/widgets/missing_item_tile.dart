import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_item_entity.dart';

/// Tile widget for displaying an order item with checkbox selection
class MissingItemTile extends StatelessWidget {
  const MissingItemTile({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final OrderDetailItemEntity item;
  final bool isSelected;
  final VoidCallback onTap;

  static const double _imageSize = 60.0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Co.purple : Colors.transparent,
            width: isSelected ? 2 : 0,
          ),
        ),
        child: Row(
          children: [
            Transform.scale(
              scale: 1.1,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: isSelected,
                visualDensity: VisualDensity.compact,
                activeColor: Co.purple,
                onChanged: (_) => onTap(),
              ),
            ),
            const SizedBox(width: 12),
            ClipOval(
              child: CustomNetworkImage(
                item.image,
                width: _imageSize,
                height: _imageSize,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.name,
                style: TStyle.blackMedium(14),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              Helpers.getProperPrice(item.price),
              style: TStyle.blackBold(14),
            ),
          ],
        ),
      ),
    );
  }
}
