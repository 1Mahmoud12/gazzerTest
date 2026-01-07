import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

import 'widgets/faq_rating_bottom_sheet.dart';

class FaqQAArgs {
  const FaqQAArgs({required this.title, required this.answer, required this.faqQuestionId, this.faqCategoryId});

  final String title;
  final String answer;
  final int faqQuestionId;
  final int? faqCategoryId;
}

class FaqQuestionAnswerScreen extends StatelessWidget {
  const FaqQuestionAnswerScreen({super.key, required this.args});

  static const route = '/faq-question-answer';

  final FaqQAArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: args.title),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(args.title, style: TStyle.robotBlackSubTitle()),
            const VerticalSpacing(12),
            Text(args.answer, style: TStyle.robotBlackRegular()),
            const VerticalSpacing(16),
            Center(
              child: Text(
                L10n.tr().wasThisHelpful,
                style: context.style14400.copyWith(fontWeight: TStyle.bold, color: Co.purple),
              ),
            ),
            const VerticalSpacing(12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      // Yes - show rating
                      await showFaqRatingBottomSheet(context, faqQuestionId: args.faqQuestionId, faqCategoryId: args.faqCategoryId);
                      // Return true to indicate "yes" was selected
                      //   Navigator.of(context).pop(true);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Co.purple),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(L10n.tr().yes),
                  ),
                ),
                const HorizontalSpacing(12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      await showFaqRatingBottomSheet(context, faqQuestionId: args.faqQuestionId, faqCategoryId: args.faqCategoryId);
                      // No - return false to open chat
                      // Navigator.of(context).pop(false);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Co.purple),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(L10n.tr().no),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
