import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/orders/domain/entities/order_vendor_entity.dart';
import 'package:gazzer/features/orders/domain/orders_repo.dart';
import 'package:gazzer/features/orders/presentation/cubit/order_review_cubit.dart';
import 'package:gazzer/features/orders/presentation/cubit/order_review_state.dart';
import 'package:go_router/go_router.dart';

class OrderRatingDialog extends StatefulWidget {
  const OrderRatingDialog({super.key, required this.orderId, required this.vendors, required this.deliveryManId});

  final int orderId;
  final List<OrderVendorEntity> vendors;
  final int deliveryManId;

  @override
  State<OrderRatingDialog> createState() => _OrderRatingDialogState();
}

class _OrderRatingDialogState extends State<OrderRatingDialog> {
  int _currentStep = 0; // 0 = vendors, 1 = delivery man
  final Map<int, double> _vendorRatings = {};
  final Set<int> _vendorShowNotes = {};
  double _deliveryManRating = 0.0;
  bool _deliveryManShowNotes = false;
  final Map<int, TextEditingController> _vendorCommentControllers = {};
  final TextEditingController _deliveryManCommentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize comment controllers for vendors
    for (final vendor in widget.vendors) {
      _vendorCommentControllers[vendor.id] = TextEditingController();
    }
  }

  @override
  void dispose() {
    // Dispose comment controllers
    for (final controller in _vendorCommentControllers.values) {
      controller.dispose();
    }
    _deliveryManCommentController.dispose();
    super.dispose();
  }

  bool get _canProceedToNextStep {
    if (_currentStep == 0) {
      // Check if all vendors are rated
      for (final vendor in widget.vendors) {
        if (_vendorRatings[vendor.id] == null || _vendorRatings[vendor.id] == 0.0) {
          return false;
        }
      }
      return true;
    }
    // Step 1: Check if delivery man is rated
    return _deliveryManRating > 0.0;
  }

  bool get _canSubmit {
    // Can only submit from step 1 if delivery man is rated
    return _currentStep == 1 && _deliveryManRating > 0.0;
  }

  void _goToNextStep() {
    if (_canProceedToNextStep) {
      setState(() {
        _currentStep = 1;
      });
    }
  }

  void _goToPreviousStep() {
    setState(() {
      _currentStep = 0;
    });
  }

  void _submitReview(OrderReviewCubit cubit) {
    if (!_canSubmit) return;

    final storeReviews = widget.vendors.map((vendor) {
      final commentController = _vendorCommentControllers[vendor.id];
      return StoreReview(orderStoreId: vendor.id, rating: _vendorRatings[vendor.id] ?? 0.0, comment: commentController?.text ?? '');
    }).toList();

    final deliveryManReviews = [
      DeliveryManReview(deliveryManId: widget.deliveryManId, rating: _deliveryManRating, comment: _deliveryManCommentController.text),
    ];

    cubit.submitReview(orderId: widget.orderId, storeReviews: storeReviews, deliveryManReviews: deliveryManReviews);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderReviewCubit(di.get()),
      child: BlocConsumer<OrderReviewCubit, OrderReviewState>(
        listener: (context, state) {
          if (state is OrderReviewSuccess) {
            Alerts.showToast(state.message, error: false);
            if (context.mounted) {
              context.pop(true); // Return true to indicate success
            }
          } else if (state is OrderReviewError) {
            Alerts.showToast(state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is OrderReviewLoading;
          final cubit = context.read<OrderReviewCubit>();

          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(L10n.tr().rateYourOrder, style: TStyle.robotBlackMedium()),
                  const VerticalSpacing(16),
                  Flexible(
                    child: SingleChildScrollView(
                      child: _currentStep == 0
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Vendor ratings
                                for (final vendor in widget.vendors) ...[
                                  _VendorRatingItem(
                                    vendor: vendor,
                                    rating: _vendorRatings[vendor.id] ?? 0.0,
                                    comment: _vendorCommentControllers[vendor.id]?.text ?? '',
                                    showNotes: _vendorShowNotes.contains(vendor.id),
                                    onRatingChanged: (rating) {
                                      setState(() {
                                        _vendorRatings[vendor.id] = rating;
                                      });
                                    },
                                    onToggleNotes: () {
                                      setState(() {
                                        if (_vendorShowNotes.contains(vendor.id)) {
                                          _vendorShowNotes.remove(vendor.id);
                                        } else {
                                          _vendorShowNotes.add(vendor.id);
                                        }
                                      });
                                    },
                                    onCommentChanged: (comment) {
                                      // Comment is handled by the controller
                                    },
                                    commentController: _vendorCommentControllers[vendor.id],
                                  ),
                                  const VerticalSpacing(16),
                                ],
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Delivery man rating
                                _DeliveryManRatingItem(
                                  rating: _deliveryManRating,
                                  comment: _deliveryManCommentController.text,
                                  showNotes: _deliveryManShowNotes,
                                  onRatingChanged: (rating) {
                                    setState(() {
                                      _deliveryManRating = rating;
                                    });
                                  },
                                  onToggleNotes: () {
                                    setState(() {
                                      _deliveryManShowNotes = !_deliveryManShowNotes;
                                    });
                                  },
                                  onCommentChanged: (comment) {
                                    // Comment is handled by the controller
                                  },
                                  commentController: _deliveryManCommentController,
                                ),
                              ],
                            ),
                    ),
                  ),
                  const VerticalSpacing(20),
                  Row(
                    children: [
                      if (_currentStep == 1) ...[
                        Expanded(
                          child: MainBtn(
                            text: 'Back',
                            bgColor: Co.purple100,
                            textStyle: TStyle.robotBlackMedium().copyWith(color: Co.black),
                            onPressed: isLoading ? () {} : _goToPreviousStep,
                          ),
                        ),
                        const HorizontalSpacing(12),
                      ],
                      Expanded(
                        child: MainBtn(
                          text: _currentStep == 0 ? L10n.tr().next : L10n.tr().submit,
                          bgColor: _canProceedToNextStep && !isLoading && _currentStep == 0
                              ? Co.purple
                              : _canSubmit && !isLoading && _currentStep == 1
                              ? Co.purple
                              : Co.purple100,
                          textStyle: (_canProceedToNextStep && !isLoading && _currentStep == 0) || (_canSubmit && !isLoading && _currentStep == 1)
                              ? TStyle.robotBlackRegular().copyWith(color: Co.white)
                              : TStyle.robotBlackMedium().copyWith(color: Co.black),
                          onPressed: _currentStep == 0
                              ? (_canProceedToNextStep && !isLoading ? _goToNextStep : () {})
                              : (_canSubmit && !isLoading ? () => _submitReview(cubit) : () {}),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _VendorRatingItem extends StatelessWidget {
  const _VendorRatingItem({
    required this.vendor,
    required this.rating,
    required this.comment,
    required this.showNotes,
    required this.onRatingChanged,
    required this.onToggleNotes,
    required this.onCommentChanged,
    required this.commentController,
  });

  final OrderVendorEntity vendor;
  final double rating;
  final String comment;
  final bool showNotes;
  final ValueChanged<double> onRatingChanged;
  final VoidCallback onToggleNotes;
  final ValueChanged<String> onCommentChanged;
  final TextEditingController? commentController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(child: CustomNetworkImage(vendor.image ?? '', width: 50, height: 50)),
            const HorizontalSpacing(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(vendor.name, style: TStyle.robotBlackRegular(), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      GestureDetector(
                        onTap: onToggleNotes,
                        child: Text(L10n.tr().addNotes, style: TStyle.robotBlackRegular().copyWith(color: Co.purple)),
                      ),
                    ],
                  ),
                  const VerticalSpacing(8),
                  RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    itemSize: 24,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                    itemBuilder: (context, index) {
                      final isRated = index < rating;
                      return SvgPicture.asset(isRated ? Assets.starRateIc : Assets.starNotRateIc);
                    },
                    unratedColor: Co.secondary,
                    onRatingUpdate: onRatingChanged,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (showNotes && commentController != null) ...[
          const VerticalSpacing(12),
          MainTextField(controller: commentController ?? TextEditingController(), hintText: L10n.tr().typeYourMessage, maxLines: 1),
        ],
      ],
    );
  }
}

class _DeliveryManRatingItem extends StatelessWidget {
  const _DeliveryManRatingItem({
    required this.rating,
    required this.comment,
    required this.showNotes,
    required this.onRatingChanged,
    required this.onToggleNotes,
    required this.onCommentChanged,
    required this.commentController,
  });

  final double rating;
  final String comment;
  final bool showNotes;
  final ValueChanged<double> onRatingChanged;
  final VoidCallback onToggleNotes;
  final ValueChanged<String> onCommentChanged;
  final TextEditingController commentController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(child: Image.asset(Assets.assetsDeliveryLogo, width: 60, height: 60)),
            const HorizontalSpacing(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(L10n.tr().deliveryMan, style: TStyle.robotBlackRegular())),
                      GestureDetector(
                        onTap: onToggleNotes,
                        child: Text(L10n.tr().addNotes, style: TStyle.robotBlackRegular().copyWith(color: Co.purple)),
                      ),
                    ],
                  ),
                  const VerticalSpacing(8),
                  RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    itemSize: 24,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                    itemBuilder: (context, index) {
                      final isRated = index < rating;
                      return SvgPicture.asset(isRated ? Assets.starRateIc : Assets.starNotRateIc);
                    },
                    unratedColor: Co.secondary,
                    onRatingUpdate: onRatingChanged,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (showNotes) ...[const VerticalSpacing(12), MainTextField(controller: commentController, hintText: L10n.tr().typeYourMessage, maxLines: 1)],
      ],
    );
  }
}
