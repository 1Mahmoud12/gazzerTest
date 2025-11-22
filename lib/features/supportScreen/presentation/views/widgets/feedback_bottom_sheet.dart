import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

/// Shows a feedback bottom sheet for rating satisfaction
void showFeedbackBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => const FeedbackBottomSheet(),
  );
}

/// Bottom sheet widget for collecting user feedback with rating
class FeedbackBottomSheet extends StatefulWidget {
  const FeedbackBottomSheet({super.key});

  @override
  State<FeedbackBottomSheet> createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
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
