import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:go_router/go_router.dart';

Future<bool?> voucherAlert({
  required String title,
  required BuildContext context,
  String? message,
  String? okBtn,
  Color? okColor,
  Color? okBgColor,
  String? cancelBtn,
  Color? cancelColor,
  Color? cancelBgColor,
  bool asDialog = false,
}) {
  final content = Container(
    decoration: BoxDecoration(color: Co.white, borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  context.pop(false);
                },
                icon: const Icon(Icons.close, color: Co.purple),
              ),
            ],
          ),

          if (asDialog) const VerticalSpacing(20),
          Text(
            title,
            style: TStyle.robotBlackMedium().copyWith(fontWeight: TStyle.bold, color: Co.purple),
            textAlign: TextAlign.center,
          ),
          const VerticalSpacing(10),
          if (message != null) Text(message, style: TStyle.robotBlackMedium(), textAlign: TextAlign.center),

          // const VericalSpacing(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                if (cancelBtn != null)
                  Expanded(
                    child: MainBtn(
                      text: cancelBtn,
                      bgColor: Colors.transparent,

                      // bgColor: cancelBgColor ?? Co.greyText,
                      borderColor: Co.buttonGradient.withOpacityNew(.35),
                      textStyle: context.style14400.copyWith(color: Co.purple),
                      borderThickness: 2,
                      onPressed: () {
                        context.pop(false);
                      },
                    ),
                  ),
                const HorizontalSpacing(20),
                if (okBtn != null)
                  Expanded(
                    child: MainBtn(
                      text: L10n.tr().confirm,
                      bgColor: Colors.transparent,
                      borderThickness: 2,
                      borderColor: Co.buttonGradient.withOpacityNew(.35),
                      textStyle: context.style14400.copyWith(color: Co.purple),
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
  );

  if (asDialog) {
    return showDialog<bool>(
      context: context,

      builder: (context) => Dialog(insetPadding: const EdgeInsets.symmetric(horizontal: 16), child: content),
    );
  } else {
    return showModalBottomSheet<bool>(context: context, builder: (context) => content);
  }
}
