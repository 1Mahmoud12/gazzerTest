import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';

class AddSpecialNote extends StatelessWidget {
  const AddSpecialNote({super.key, required this.onNoteChange, this.note});
  final Function(String) onNoteChange;
  final String? note;
  @override
  Widget build(BuildContext context) {
    return _NotesSection(note: note, onNoteChange: onNoteChange);
  }
}

// Notes Section
class _NotesSection extends StatelessWidget {
  const _NotesSection({required this.note, required this.onNoteChange});

  final String? note;
  final Function(String) onNoteChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(L10n.tr().notes, style: TStyle.robotBlackRegular().copyWith(fontWeight: TStyle.bold)),
        const SizedBox(height: 12),
        MainTextField(
          controller: TextEditingController(text: note),
          maxLines: 3,
          hintText: L10n.tr().addYourNotes,
          onChange: onNoteChange,
        ),
      ],
    );
  }
}
