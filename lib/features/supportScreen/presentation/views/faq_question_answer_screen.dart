import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

import 'widgets/faq_rating_bottom_sheet.dart';

class FaqQAArgs {
  const FaqQAArgs({
    required this.title,
    required this.answer,
    required this.faqQuestionId,
    this.faqCategoryId,
  });

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
      appBar: AppBar(
        title: Text(args.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(args.title, style: TStyle.robotBlackSubTitle()),
            const VerticalSpacing(12),
            Text(
              args.answer,
              style: TStyle.blackRegular(14),
            ),
            const VerticalSpacing(16),
            Center(
              child: Text(
                L10n.tr().wasThisHelpful,
                style: TStyle.blackBold(14).copyWith(color: Co.purple),
              ),
            ),
            const VerticalSpacing(12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => showFaqRatingBottomSheet(
                      context,
                      faqQuestionId: args.faqQuestionId,
                      faqCategoryId: args.faqCategoryId,
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Co.purple),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(L10n.tr().yes),
                  ),
                ),
                const HorizontalSpacing(12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => showFaqRatingBottomSheet(
                      context,
                      faqQuestionId: args.faqQuestionId,
                      faqCategoryId: args.faqCategoryId,
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Co.purple),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
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
