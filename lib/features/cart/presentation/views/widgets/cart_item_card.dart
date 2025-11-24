import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/dialogs.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';
import 'package:gazzer/features/cart/presentation/views/widgets/cart_edit_note.dart';
import 'package:gazzer/features/cart/presentation/views/widgets/cart_option_widget.dart';
import 'package:gazzer/features/cart/presentation/views/widgets/cart_ordered_with_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/increment_widget_white.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key, required this.item});
  final CartItemEntity item;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    final imageSize = 100.0;
    final horzSpacing = 6.0;
    return InkWell(
      onTap: () {
        switch (item.type) {
          case CartItemType.product:
            ProductDetailsRoute(
              productId: item.prod.id,
              $extra: item,
            ).push<bool>(context).then((hasChanged) {
              log('hasCartChanges $hasChanged');
              if (hasChanged == true) cubit.loadCart();
            });
            break;
          case CartItemType.restaurantItem:
            // TODO restaurant item isn't retrivied from cart,
            // TODO and will not show the correct item if navigated to plate details
            break;
          case CartItemType.plate:
            PlateDetailsRoute(
              id: item.prod.id,
              $extra: item,
            ).push(context).then((hasChanged) {
              if (hasChanged == true) cubit.loadCart();
            });
            break;
        }
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Co.secText.withAlpha(80),
              offset: const Offset(0, 0),
              blurRadius: 0,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: AppConst.defaultPadding,
          child: Row(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: BlocBuilder<CartCubit, CartStates>(
                  buildWhen: (previous, current) => current is UpdateItemStates && current.cartId == item.cartId,
                  builder: (context, state) => ConstrainedBox(
                    constraints: BoxConstraints(minHeight: imageSize),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          spacing: 6,
                          children: [
                            Expanded(
                              child: Text(
                                item.prod.name,
                                style: TStyle.blackBold(12),
                                maxLines: 2,
                              ),
                            ),
                            Text(
                              item.prod.price.toString(),
                              style: TStyle.blackBold(12),
                            ),
                            Text(L10n.tr().egp, style: TStyle.blackBold(12)),
                          ],
                        ),

                        if (item.options.isNotEmpty)
                          ...List.generate(
                            item.options.length,
                            (index) => CartOptionWidget(option: item.options[index]),
                          ),
                        if (item.orderedWith.isNotEmpty)
                          ...List.generate(
                            item.orderedWith.length,
                            (index) => CartOrderedWithWidget(
                              orderedWith: item.orderedWith[index],
                            ),
                          ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          spacing: 6,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
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
                                          onPressed: () async {
                                            if (state is UpdateItemLoading) return;
                                            final note = await showModalBottomSheet<String>(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor: Colors.transparent,
                                              builder: (context) => CartEditNote(item: item),
                                            );
                                            if (note != null && note != item.notes) {
                                              cubit.updateItemNote(
                                                item.cartId,
                                                note,
                                              );
                                            }
                                          },
                                          style: IconButton.styleFrom(
                                            padding: const EdgeInsets.all(4),
                                            minimumSize: Size.zero,
                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          ),
                                          icon: state is UpdateItemStates && state.isEditNote
                                              ? const AdaptiveProgressIndicator(
                                                  size: 18,
                                                )
                                              : const Icon(
                                                  Icons.edit_outlined,
                                                  size: 18,
                                                  color: Co.purple,
                                                ),
                                        ),
                                      ],
                                    ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IncrementWidgetWhite(
                                        initVal: item.quantity,
                                        isRemoving: state is UpdateItemLoading && state.isRemoving,
                                        isAdding: state is UpdateItemLoading && state.isAdding,
                                        isIncrementDisabled: state is UpdateItemError && state.cartId == item.cartId && state.isMaxQuantityReached,
                                        onChanged: (isAdding) {
                                          cubit.updateItemQuantity(
                                            item.cartId,
                                            item.quantity + (isAdding ? 1 : -1),
                                            isAdding,
                                            context,
                                          );
                                        },
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          if (state is UpdateItemLoading) return;
                                          final confirmed = await showDialog<bool>(
                                            context: context,
                                            builder: (context) {
                                              return Dialogs.confirmDialog(
                                                title: L10n.tr().warning,
                                                message: L10n.tr().areYouSureYouWantToDeleteThisItem,
                                                okBgColor: Co.red,
                                                context: context,
                                              );
                                            },
                                          );
                                          if (confirmed == true) {
                                            cubit.removeItemFromCart(
                                              item.cartId,
                                            );
                                          }
                                        },
                                        style: IconButton.styleFrom(
                                          padding: const EdgeInsets.all(4),
                                          minimumSize: Size.zero,
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        icon: state is UpdateItemLoading && state.isDeleting
                                            ? const AdaptiveProgressIndicator(
                                                size: 18,
                                              )
                                            : const Icon(
                                                CupertinoIcons.delete,
                                                size: 18,
                                                color: Co.purple,
                                              ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Row(
                                spacing: horzSpacing,
                                children: [
                                  Text(
                                    item.totalPrice.toString(),
                                    style: TStyle.primaryBold(12),
                                  ),
                                  Text(
                                    L10n.tr().egp,
                                    style: TStyle.primaryBold(12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: imageSize,
                width: imageSize,
                child: CustomNetworkImage(
                  item.prod.image,
                  borderRaduis: 12,
                  height: imageSize,
                  width: imageSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
