import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:go_router/go_router.dart';

class CartEditNote extends StatefulWidget {
  const CartEditNote({super.key, required this.item});
  final CartItemEntity item;

  @override
  State<CartEditNote> createState() => _CartEditNoteState();
}

class _CartEditNoteState extends State<CartEditNote> {
  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.item.notes ?? '';
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(color: Colors.transparent),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(color: Co.secText, borderRadius: AppConst.defaultBorderRadius),
            child: Padding(
              padding: const EdgeInsetsGeometry.symmetric(vertical: 32, horizontal: 24),
              child: Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(L10n.tr().editNote, style: TStyle.primaryBold(16)),
                  const VerticalSpacing(0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Text(widget.item.prod.name, style: TStyle.blackRegular(16))),
                      DecoratedBox(
                        position: DecorationPosition.foreground,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Co.purple),
                        ),
                        child: CustomNetworkImage(widget.item.prod.image, width: 55, height: 55, borderReduis: 100),
                      ),
                    ],
                  ),
                  MainTextField(
                    controller: controller,
                    bgColor: Colors.transparent,
                    maxLines: 3,
                    hintText: L10n.tr().editNote,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OptionBtn(
                        onPressed: () {
                          final text = controller.text.trim();
                          context.pop(text);
                        },
                        text: L10n.tr().saveChanges,
                        width: 220,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
