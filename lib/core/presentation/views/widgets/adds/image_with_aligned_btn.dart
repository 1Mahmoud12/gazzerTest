import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

class ImageWithAlignedBtn extends StatelessWidget {
  const ImageWithAlignedBtn({
    super.key,
    required this.image,
    required this.align,
    required this.btnText,
  });
  final String image;
  final Alignment align;
  final String btnText;
  // final int id;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.4,

      child: Stack(
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Align(
            alignment: align,
            child: MainBtn(
              onPressed: () {},
              width: 115,
              height: 35,
              text: L10n.tr().orderNow,
              bgColor: Co.secondary,
              textStyle: context.style14400.copyWith(color: Co.purple),
            ),
          ),
        ],
      ),
    );
  }
}
