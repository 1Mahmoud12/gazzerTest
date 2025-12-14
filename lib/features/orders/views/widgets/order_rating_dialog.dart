import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/orders/domain/entities/order_vendor_entity.dart';
import 'package:gazzer/features/orders/domain/orders_repo.dart';
import 'package:gazzer/features/orders/presentation/cubit/order_review_cubit.dart';
import 'package:gazzer/features/orders/presentation/cubit/order_review_state.dart';
import 'package:go_router/go_router.dart';

class OrderRatingDialog extends StatefulWidget {
  const OrderRatingDialog({super.key, required this.orderId, required this.vendors});

  final int orderId;
  final List<OrderVendorEntity> vendors;

  @override
  State<OrderRatingDialog> createState() => _OrderRatingDialogState();
}

class _OrderRatingDialogState extends State<OrderRatingDialog> {
  final Map<int, double> _vendorRatings = {};
  double _deliveryManRating = 0.0;

  bool get _canSubmit {
    // Check if all vendors are rated and delivery man is rated
    if (_deliveryManRating == 0.0) return false;
    for (var vendor in widget.vendors) {
      if (_vendorRatings[vendor.id] == null || _vendorRatings[vendor.id] == 0.0) {
        return false;
      }
    }
    return true;
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
            Alerts.showToast(state.message, error: true);
          }
        },
        builder: (context, state) {
          final isLoading = state is OrderReviewLoading;

          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 600),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(L10n.tr().rateYourOrder, style: TStyle.robotBlackMedium()),
                  const VerticalSpacing(16),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Vendor ratings
                          for (var vendor in widget.vendors) ...[
                            _VendorRatingItem(
                              vendor: vendor,
                              rating: _vendorRatings[vendor.id] ?? 0.0,
                              onRatingChanged: (rating) {
                                setState(() {
                                  _vendorRatings[vendor.id] = rating;
                                });
                              },
                            ),
                            const VerticalSpacing(16),
                          ],
                          // Delivery man rating
                          _DeliveryManRatingItem(
                            rating: _deliveryManRating,
                            onRatingChanged: (rating) {
                              setState(() {
                                _deliveryManRating = rating;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VerticalSpacing(20),
                  Row(
                    children: [
                      Expanded(
                        child: MainBtn(
                          text: L10n.tr().submit,
                          bgColor: _canSubmit && !isLoading ? Co.purple : Co.purple100,
                          textStyle: _canSubmit && !isLoading
                              ? TStyle.robotBlackRegular().copyWith(color: Co.white)
                              : TStyle.robotBlackMedium().copyWith(color: Co.black),
                          onPressed: _canSubmit && !isLoading
                              ? () {
                                  final storeReviews = widget.vendors
                                      .map((vendor) => StoreReview(orderStoreId: vendor.id, rating: _vendorRatings[vendor.id] ?? 0.0))
                                      .toList();

                                  final deliveryManReview = DeliveryManReview(rating: _deliveryManRating);

                                  context.read<OrderReviewCubit>().submitReview(
                                    orderId: widget.orderId,
                                    storeReviews: storeReviews,
                                    deliveryManReview: deliveryManReview,
                                  );
                                }
                              : () {},
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
  const _VendorRatingItem({required this.vendor, required this.rating, required this.onRatingChanged});

  final OrderVendorEntity vendor;
  final double rating;
  final ValueChanged<double> onRatingChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(child: CustomNetworkImage(vendor.image ?? '', width: 50, height: 50)),
        const HorizontalSpacing(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(vendor.name, style: TStyle.robotBlackRegular()),
            const VerticalSpacing(8),
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
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
      ],
    );
  }
}

class _DeliveryManRatingItem extends StatelessWidget {
  const _DeliveryManRatingItem({required this.rating, required this.onRatingChanged});

  final double rating;
  final ValueChanged<double> onRatingChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ClipOval(child: VectorGraphicsWidget(Assets.assetsDeliveryLogo, width: 60, height: 60)),
        const HorizontalSpacing(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(L10n.tr().deliveryMan, style: TStyle.robotBlackRegular()),
            const VerticalSpacing(8),
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
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
      ],
    );
  }
}
