import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TitleWithMore extends StatelessWidget {
  const TitleWithMore({super.key, required this.title, this.titleStyle, this.onPressed});
  final String? title;
  final TextStyle? titleStyle;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final isHovering = ValueNotifier<bool>(false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (title != null && title!.isNotEmpty)
          Expanded(
            child: Skeleton.shade(
              child: GradientText(
                text: title!,
                style: titleStyle ?? TStyle.robotBlackTitle(),
                gradient: Grad().textGradient,
                textAlign: TextAlign.start,
                // maxLines: 1,
              ),
            ),
          ),
        if (onPressed != null)
          ValueListenableBuilder(
            valueListenable: isHovering,
            builder: (context, value, child) => DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: AppConst.defaultBorderRadius,
                gradient: value ? Grad().hoverGradient : null,
                // boxShadow: value
                //     ? []
                //     : [const BoxShadow(color: Co.darkMain, blurRadius: 0, spreadRadius: 0, offset: Offset(0, 0))],
              ),
              child: child!,
            ),
            child: ElevatedButton(
              onPressed: onPressed ?? () {},
              onHover: (v) {
                isHovering.value = v;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shadowColor: Colors.transparent,
                minimumSize: Size.zero,
                shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
                disabledBackgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                overlayColor: Colors.transparent,
              ),
              child: Text(L10n.tr().viewAll, style: TStyle.robotBlackRegular()),
            ),
          ),
      ],
    );
  }
}
