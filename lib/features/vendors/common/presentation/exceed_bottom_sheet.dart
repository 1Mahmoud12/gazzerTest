import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:go_router/go_router.dart';

Future<bool?> warningAlert({
  required String title,
  required BuildContext context,
  String? message,
  String? okBtn,
  Color? okColor,
  Color? okBgColor,
  String? cancelBtn,
  Color? cancelColor,
  Color? cancelBgColor,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      decoration: BoxDecoration(color: Co.white, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const VerticalSpacing(20),
            Text(
              title,
              style: TStyle.burbleBold(18),
              textAlign: TextAlign.center,
            ),
            const VerticalSpacing(10),
            if (message != null)
              Text(
                message,
                style: TStyle.blackRegular(16),
                textAlign: TextAlign.center,
              ),
            // const VericalSpacing(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: MainBtn(
                      text: cancelBtn ?? L10n.tr().cancel,
                      bgColor: Colors.transparent,

                      // bgColor: cancelBgColor ?? Co.greyText,
                      borderColor: Co.buttonGradient.withOpacityNew(.35),
                      textStyle: TStyle.burbleRegular(14).copyWith(color: Co.purple),
                      borderThickness: 2,
                      onPressed: () {
                        context.pop(false);
                      },
                    ),
                  ),
                  const HorizontalSpacing(20),
                  Expanded(
                    child: MainBtn(
                      text: okBtn ?? L10n.tr().confirm,
                      bgColor: Colors.transparent,
                      borderThickness: 2,
                      borderColor: Co.buttonGradient.withOpacityNew(.35),
                      textStyle: TStyle.burbleRegular(14).copyWith(color: Co.purple),
                      onPressed: () {
                        context.pop(true);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
