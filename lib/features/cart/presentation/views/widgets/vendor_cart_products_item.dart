import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/features/cart/domain/entities/cart_vendor_entity.dart';
import 'package:gazzer/features/cart/presentation/views/widgets/cart_item_card.dart';

class VendorCartProductsItem extends StatelessWidget {
  const VendorCartProductsItem({super.key, required this.cartVendor});
  final CartVendorEntity cartVendor;
  @override
  Widget build(BuildContext context) {
    final availableVendor = cartVendor.isOpen;
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Column(
          children: [
            Opacity(
              opacity: availableVendor ? 0.5 : 1,
              child: IgnorePointer(
                ignoring: availableVendor,
                child: Padding(
                  padding: AppConst.defaultHrPadding,
                  child: Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipOval(child: CustomNetworkImage(cartVendor.image, width: 40, height: 40, fit: BoxFit.cover)),
                          const HorizontalSpacing(8),
                          Text(cartVendor.name, style: TStyle.robotBlackMedium()),
                          const Spacer(),
                          if (!availableVendor)
                            Row(
                              spacing: 4,
                              children: [
                                const VectorGraphicsWidget(
                                  Assets.assetsSvgCart,
                                  colorFilter: ColorFilter.mode(Co.black, BlendMode.srcIn),
                                  height: 25,
                                  width: 25,
                                ),
                                Text('${cartVendor.items.length} ${L10n.tr().items}', style: TStyle.robotBlackRegular()),
                              ],
                            ),
                        ],
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartVendor.items.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => const VerticalSpacing(12),
                        itemBuilder: (context, index) {
                          return CartItemCard(item: cartVendor.items[index]);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (availableVendor)
              Container(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 12),
                color: Co.gr200,
                child: Row(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_outline, size: 18),

                    Expanded(child: Text(L10n.tr().restaurant_not_available_message, style: TStyle.robotBlackThin())),
                  ],
                ),
              ),
          ],
        ),
        if (availableVendor)
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text(L10n.tr().remove_all, style: TStyle.robotBlackRegular().copyWith(color: Co.darkRed))],
            ),
          ),
      ],
    );
  }
}
