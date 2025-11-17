import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

class FaqQAArgs {
  const FaqQAArgs({required this.title, required this.answer});

  final String title;
  final String answer;
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
              child: Text('Was this helpful?', style: TStyle.blackBold(14).copyWith(color: Co.purple)),
            ),
            const VerticalSpacing(12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _showFeedbackBottomSheet(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Co.purple),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Yes'),
                  ),
                ),
                const HorizontalSpacing(12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _showFeedbackBottomSheet(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Co.purple),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('No'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFeedbackBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => const _FeedbackBottomSheet(),
    );
  }
}

class _FeedbackBottomSheet extends StatefulWidget {
  const _FeedbackBottomSheet();

  @override
  State<_FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<_FeedbackBottomSheet> {
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Co.purple100,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Co.white.withOpacityNew(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(
            L10n.tr().faqSatisfactionQuestion,
            textAlign: TextAlign.center,
            style: TStyle.robotBlackRegular(),
          ),
          const VerticalSpacing(24),
          RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 40,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4),
            itemBuilder: (context, index) {
              final isRated = index < _rating;
              return Icon(
                isRated ? Icons.star : Icons.star_border,
                color: Co.secondary,
              );
            },
            unratedColor: Co.secondary.withOpacityNew(0.5),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          const VerticalSpacing(24),
          MainBtn(
            onPressed: () {
              // Close after rating with a slight delay
              if (_rating > 0) {
                Future.delayed(const Duration(milliseconds: 300), () {
                  if (mounted) {
                    Navigator.of(context).pop();
                    // You can show a success toast here if needed
                  }
                });
              } else {
                Alerts.showToast(L10n.tr().needToAddReviewFirst);
              }
            },
            text: L10n.tr().submit,
          ),
        ],
      ),
    );
  }
}
