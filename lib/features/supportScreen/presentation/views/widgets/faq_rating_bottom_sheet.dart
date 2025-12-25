import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/supportScreen/data/requests/faq_rating_request.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/faq_rating_cubit.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/faq_rating_states.dart';
import 'package:go_router/go_router.dart';

/// Shows a rating bottom sheet for FAQ questions
Future<void> showFaqRatingBottomSheet(BuildContext context, {int? faqQuestionId, int? faqCategoryId, int? orderId}) async {
  await showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => BlocProvider(
      create: (context) => di<FaqRatingCubit>(),
      child: FaqRatingBottomSheet(faqQuestionId: faqQuestionId, faqCategoryId: faqCategoryId),
    ),
  );
}

/// Bottom sheet widget for rating FAQ questions
class FaqRatingBottomSheet extends StatefulWidget {
  const FaqRatingBottomSheet({super.key, this.faqQuestionId, this.faqCategoryId});

  final int? faqQuestionId;
  final int? faqCategoryId;

  @override
  State<FaqRatingBottomSheet> createState() => _FaqRatingBottomSheetState();
}

class _FaqRatingBottomSheetState extends State<FaqRatingBottomSheet> {
  double _rating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submitRating() {
    if (_rating == 0) {
      Alerts.showToast(L10n.tr().needToAddReviewFirst);
      return;
    }

    final request = FaqRatingRequest(
      rating: _rating.toInt(),
      faqQuestionId: widget.faqQuestionId,
      faqCategoryId: widget.faqCategoryId,
      feedback: _feedbackController.text.trim().isEmpty ? null : _feedbackController.text.trim(),
    );

    context.read<FaqRatingCubit>().submitRating(request);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FaqRatingCubit, FaqRatingStates>(
      listener: (context, state) {
        if (state is FaqRatingSuccessState) {
          Alerts.showToast(state.message, error: false);
          Navigator.of(context).pop();
          context.go('/');
          context.push('/support-screen');
        } else if (state is FaqRatingErrorState) {
          Alerts.showToast(state.error);
        }
      },
      builder: (context, state) {
        final isLoading = state is FaqRatingLoadingState;

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
                decoration: BoxDecoration(color: Co.white.withOpacityNew(0.3), borderRadius: BorderRadius.circular(2)),
              ),
              Text(L10n.tr().wasThisHelpful, textAlign: TextAlign.center, style: TStyle.robotBlackMedium().copyWith(fontSize: 18)),
              const VerticalSpacing(24),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                itemSize: 32,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                itemBuilder: (context, index) {
                  final isRated = index < _rating;
                  return SvgPicture.asset(isRated ? Assets.starRateIc : Assets.starNotRateIc);
                },
                unratedColor: Co.secondary,
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              const VerticalSpacing(24),
              MainTextField(controller: _feedbackController, hintText: L10n.tr().optionalFeedback, maxLines: 3, borderRadius: 12),
              const VerticalSpacing(24),
              MainBtn(onPressed: isLoading ? () {} : _submitRating, text: isLoading ? '${L10n.tr().submit}...' : L10n.tr().submit, radius: 30),
              VerticalSpacing(MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        );
      },
    );
  }
}
