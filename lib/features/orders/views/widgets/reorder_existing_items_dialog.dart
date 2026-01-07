import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:go_router/go_router.dart';

Future<bool?> showReorderExistingItemsDialog({
  required BuildContext context,
  required bool existingItemsCount,
  required bool addNewPouchApproval,
  String? message,
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
              L10n.tr().warning,
              style: TStyle.robotBlackMedium().copyWith(fontWeight: TStyle.bold, color: Co.purple),
              textAlign: TextAlign.center,
            ),
            const VerticalSpacing(10),
            Text(message ?? '', style: TStyle.robotBlackMedium(), textAlign: TextAlign.center),
            const VerticalSpacing(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: MainBtn(
                      text: L10n.tr().clear,
                      bgColor: Colors.transparent,
                      borderColor: Co.buttonGradient.withOpacityNew(.35),
                      textStyle: context.style14400.copyWith(color: Co.purple),
                      borderThickness: 2,
                      onPressed: () {
                        context.pop(false); // false = clear existing items
                      },
                    ),
                  ),
                  const HorizontalSpacing(20),
                  Expanded(
                    child: MainBtn(
                      text: L10n.tr().keep,
                      bgColor: Colors.transparent,
                      borderThickness: 2,
                      borderColor: Co.buttonGradient.withOpacityNew(.35),
                      textStyle: context.style14400.copyWith(color: Co.purple),
                      onPressed: () {
                        context.pop(true); // true = keep existing items
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
