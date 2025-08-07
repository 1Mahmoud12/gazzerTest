import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_bus.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_events.dart';
import 'package:gazzer/features/cart/presentation/views/widgets/cart_option_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/increment_widget_white.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key, required this.item});
  final CartItemEntity item;
  @override
  Widget build(BuildContext context) {
    final bus = di<CartBus>();
    return StreamBuilder(
      stream: bus.getStream<UpdateCartItems>(),
      builder: (context, snapshot) => Badge(
        alignment: Alignment.center,
        backgroundColor: Colors.transparent,
        isLabelVisible: snapshot.data is UpdateCartItemsLoading && snapshot.data?.cartId == item.id,
        label: const AdaptiveProgressIndicator(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Co.secText.withAlpha(80), offset: const Offset(0, 0), blurRadius: 0, spreadRadius: 0)],
          ),
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: snapshot.data is UpdateCartItemsLoading && snapshot.data?.cartId == item.id ? Colors.white38 : null,
          ),
          padding: AppConst.defaultPadding,
          child: Row(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Expanded(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 120),
                        child: Column(
                          spacing: 6,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.prod.name,
                              style: TStyle.blackBold(12),
                              maxLines: 2,
                            ),
                            if (item.notes?.trim().isNotEmpty == true)
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.notes!,
                                      style: TStyle.greyRegular(12),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    style: IconButton.styleFrom(
                                      padding: const EdgeInsets.all(4),
                                      minimumSize: Size.zero,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    icon: const Icon(Icons.edit_outlined, size: 24, color: Co.purple),
                                  ),
                                ],
                              ),
                            if (item.options.isNotEmpty)
                              ...List.generate(
                                item.options.length,
                                (index) => CartOptionWidget(option: item.options[index]),
                              ),
                            const VerticalSpacing(8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IncrementWidgetWhite(
                                  initVal: item.quantity,
                                  onChanged: (isAdding) {
                                    if (isAdding) {
                                      bus.updateItemQuantity(item.id, item.quantity + 1);
                                    } else {
                                      bus.updateItemQuantity(item.id, item.quantity - 1);
                                    }
                                  },
                                  isLoading: false,
                                ),
                                IconButton(
                                  onPressed: () {
                                    bus.removeItemFromCart(item.id);
                                  },
                                  style: IconButton.styleFrom(
                                    padding: const EdgeInsets.all(4),
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  icon: const Icon(CupertinoIcons.delete, size: 24, color: Co.purple),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 120),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.prod.price.toString(), style: TStyle.blackBold(12)),
                          Text(item.totalPrice.toString(), style: TStyle.primaryBold(16)),
                        ],
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 120),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text(L10n.tr().egp, style: TStyle.blackBold(12)),
                          Text(L10n.tr().egp, style: TStyle.primaryBold(16)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 120,
                width: 120,
                child: CustomNetworkImage(
                  item.prod.image,
                  borderReduis: 12,
                  height: 120,
                  width: 120,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
