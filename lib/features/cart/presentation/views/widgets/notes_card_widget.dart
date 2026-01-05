import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_cubit.dart';

class NotesCartWidget extends StatelessWidget {
  const NotesCartWidget({super.key, required TextEditingController notesController}) : _notesController = notesController;

  final TextEditingController _notesController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order notes
          Text(L10n.tr().order_notes, style: TStyle.robotBlackRegular().copyWith(fontWeight: TStyle.bold)),
          Container(
            decoration: BoxDecoration(color: Co.bg, borderRadius: AppConst.defaultBorderRadius),
            padding: const EdgeInsets.symmetric(vertical: 8),

            child: MainTextField(
              controller: _notesController,
              maxLines: 4,
              hintText: L10n.tr().add_your_notes,
              bgColor: Co.w900,
              onChange: (p0) {
                context.read<CheckoutCubit>().setOrderNotes(p0);
              },
            ),
          ),
        ],
      ),
    );
  }
}
