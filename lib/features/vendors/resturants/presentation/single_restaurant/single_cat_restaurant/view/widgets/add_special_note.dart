import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/decorations.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:go_router/go_router.dart';

class AddSpecialNote extends StatelessWidget {
  const AddSpecialNote({super.key, required this.onNoteChange, this.note});
  final Function(String) onNoteChange;
  final String? note;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          useSafeArea: true,
          builder: (context) {
            return _NoteSheet(note: note);
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF4E2CB),
        shape: RoundedRectangleBorder(
          borderRadius: AppConst.defaultInnerBorderRadius,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: GradientTextWzShadow(
        text: L10n.tr().addSpecialNote,
        style: TStyle.blackBold(14),
        shadow: AppDec.blackTextShadow.first,
      ),
    );
  }
}

class _NoteSheet extends StatefulWidget {
  const _NoteSheet({this.note});
  final String? note;

  @override
  State<_NoteSheet> createState() => _NoteSheetState();
}

class _NoteSheetState extends State<_NoteSheet> {
  final TextEditingController controller = TextEditingController();

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
          DecoratedBox(
            decoration: BoxDecoration(
              color: Co.secText,
              borderRadius: AppConst.defaultBorderRadius,
            ),
            child: SafeArea(
              child: Padding(
                padding: AppConst.defaultPadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 12,
                  children: [
                    Text(
                      L10n.tr().addSpecialNote,
                      style: TStyle.primaryBold(16),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: MainTextField(
                        controller: controller,
                        hintText: L10n.tr().yourFullName,
                        bgColor: Colors.transparent,
                        maxLines: 5,
                        showBorder: true,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 150,
                          child: OptionBtn(
                            onPressed: () {
                              final note = controller.text.trim();
                              context.pop<String>(note);
                            },
                            text: L10n.tr().send,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
