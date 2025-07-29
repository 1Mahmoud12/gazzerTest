import 'package:flutter/material.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_card_one.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_card_two.dart';

class GrocCardSwitcher<T> extends StatelessWidget {
  const GrocCardSwitcher({
    super.key,
    required this.cardStyle,
    required this.width,
    this.height,
    required this.entity,
    this.onPressed,
  });
  final CardStyle cardStyle;
  final double width;
  final double? height;
  final T entity;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    switch (cardStyle) {
      case CardStyle.typeOne:
        if (entity is StoreEntity) {
          return GrocCardOne(
            vendor: entity as StoreEntity,
            width: width,
            height: height,
            onPressed: onPressed,
          );
        } else {
          return const SizedBox.shrink();
        }
      case CardStyle.typeTwo:
        if (entity is StoreEntity) {
          return GrocCardTwo(
            vendor: entity as StoreEntity,
            width: width,
            height: height,
            onPressed: onPressed,
          );
        } else {
          return const SizedBox.shrink();
        }
      case CardStyle.typeThree:
        if (entity is StoreEntity) {
          return GrocCardOne(
            vendor: entity as StoreEntity,
            width: width,
            height: height,
            onPressed: onPressed,
          );
        } else {
          return const SizedBox.shrink();
        }
      case CardStyle.typeFour:
        if (entity is StoreEntity) {
          return GrocCardTwo(
            vendor: entity as StoreEntity,
            width: width,
            height: height,
            onPressed: onPressed,
          );
        } else {
          return const SizedBox.shrink();
        }
    }
  }
}
