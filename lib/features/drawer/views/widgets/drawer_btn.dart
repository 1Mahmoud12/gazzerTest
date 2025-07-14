import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';

class DrawerBtn extends StatelessWidget {
  const DrawerBtn({super.key, required this.title, required this.svgImg, required this.onTap, this.icon})
    : assert(svgImg != null || icon != null, "Either svgImg or icon must be provided.");
  final String title;
  final String? svgImg;
  final Widget? icon;
  final Function(BuildContext ctx) onTap;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(gradient: Grad().bglightLinear, borderRadius: AppConst.defaultBorderRadius),
      child: InkWell(
        onTap: () {
          Scaffold.of(context).closeEndDrawer();
          SystemSound.play(SystemSoundType.click);
          onTap(context);
        },
        borderRadius: AppConst.defaultBorderRadius,
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TStyle.primaryBold(14)),
              icon ??
                  SvgPicture.asset(
                    svgImg!,
                    height: 20,
                    width: 20,
                    colorFilter: const ColorFilter.mode(Co.tertiary, BlendMode.srcIn),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
