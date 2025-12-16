import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/cart/domain/entities/cart_option_entity.dart';

class CartOptionWidget extends StatelessWidget {
  const CartOptionWidget({super.key, required this.option});
  final CartOptionEntity option;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '',
        children: List.generate(option.values.length, (index) {
          return TextSpan(
            text: '- ${option.values[index].name}',
            style: TStyle.robotBlackRegular14().copyWith(color: Co.darkGrey),
          );
        }),
      ),
    );
  }
}
