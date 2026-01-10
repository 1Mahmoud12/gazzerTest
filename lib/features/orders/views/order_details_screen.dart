import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_entity.dart';
import 'package:gazzer/features/orders/presentation/cubit/order_detail_cubit.dart';
import 'package:gazzer/features/orders/presentation/cubit/order_detail_state.dart';
import 'package:gazzer/features/orders/views/widgets/orderDetailsWidgets/order_details_address_widget.dart';
import 'package:gazzer/features/orders/views/widgets/orderDetailsWidgets/order_details_constants.dart';
import 'package:gazzer/features/orders/views/widgets/orderDetailsWidgets/order_details_header_widget.dart';
import 'package:gazzer/features/orders/views/widgets/orderDetailsWidgets/order_details_summary_widget.dart';
import 'package:gazzer/features/orders/views/widgets/orderDetailsWidgets/order_details_vendor_section_widget.dart';
import 'package:gazzer/features/supportScreen/presentation/views/order_issue_screen.dart';
import 'package:intl/intl.dart';

/// Screen displaying detailed information about a specific order
class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.orderId});

  final int orderId;

  static const route = '/order-details';

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final Map<int, bool> _expandedVendors = {};

  @override
  void initState() {
    super.initState();
  }

  void _toggleVendor(int index) {
    setState(() {
      _expandedVendors[index] = !(_expandedVendors[index] ?? false);
    });
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.day == now.day && date.month == now.month && date.year == now.year;
  }

  String _formatOrderDate(DateTime date) {
    final dateFormat = DateFormat(OrderDetailsConstants.dateFormat);
    return _isToday(date) ? '${L10n.tr().today} ${dateFormat.format(date)}' : dateFormat.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderDetailCubit(di.get(), widget.orderId)..loadOrderDetail(),
      child: BlocBuilder<OrderDetailCubit, OrderDetailState>(
        builder: (context, state) {
          if (state is OrderDetailLoading && state.orderDetail == null) {
            return Scaffold(
              backgroundColor: Co.bg,
              appBar: MainAppBar(title: L10n.tr().orderDetails),
              body: const Center(child: LoadingWidget()),
            );
          }

          final orderDetail = state is OrderDetailLoaded
              ? state.orderDetail
              : state is OrderDetailLoading
              ? state.orderDetail
              : state is OrderDetailError
              ? state.orderDetail
              : null;

          if (state is OrderDetailError) {
            return Scaffold(
              backgroundColor: Co.bg,
              appBar: MainAppBar(title: L10n.tr().orderDetails),
              body: FailureComponent(
                message: state.message,
                onRetry: () {
                  context.read<OrderDetailCubit>().loadOrderDetail();
                },
              ),
            );
          }
          if (orderDetail == null) {
            return Scaffold(
              backgroundColor: Co.bg,
              appBar: MainAppBar(title: L10n.tr().orderDetails),
              body: Center(
                child: Text(L10n.tr().noData, style: context.style16400.copyWith(color: Co.purple)),
              ),
            );
          }

          return Scaffold(
            backgroundColor: Co.bg,
            appBar: MainAppBar(title: L10n.tr().orderDetails),
            body: RefreshIndicator(
              onRefresh: () async {
                await context.read<OrderDetailCubit>().loadOrderDetail(refresh: true);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderDetailsHeaderSection(
                      orderId: orderDetail.orderId,
                      orderDate: orderDetail.orderDate,
                      status: orderDetail.status,
                      deliveryTimeMinutes: orderDetail.deliveryTimeMinutes,
                      onFormatDate: _formatOrderDate,
                    ),
                    const SizedBox(height: OrderDetailsConstants.defaultSpacing),
                    RichText(
                      text: TextSpan(
                        text: L10n.tr().estimated_delivery_time,
                        style: context.style16500,
                        children: [
                          TextSpan(
                            text: ': ',
                            style: context.style16500.copyWith(color: Co.purple),
                          ),
                          TextSpan(
                            text: '20-30',
                            style: context.style16500.copyWith(color: Co.purple),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: OrderDetailsConstants.defaultSpacing),
                    DeliveryAddressCard(address: orderDetail.deliveryAddress),
                    const SizedBox(height: OrderDetailsConstants.defaultSpacing),
                    ..._buildVendorSections(orderDetail),
                    const SizedBox(height: OrderDetailsConstants.defaultSpacing),
                    OrderSummarySection(orderDetail: orderDetail),
                    const SizedBox(height: OrderDetailsConstants.defaultSpacing),
                    if (state is OrderDetailLoaded && orderDetail.loyaltyPointsEarned > 0) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(color: Co.earnedMoney, borderRadius: BorderRadius.circular(40)),
                        alignment: AlignmentDirectional.center,
                        child: Text(L10n.tr().youHaveEarnedPoints(orderDetail.loyaltyPointsEarned), style: context.style16500),
                      ),
                    ],
                    const SizedBox(height: OrderDetailsConstants.defaultSpacing),
                    MainBtn(
                      onPressed: () {
                        context.navigateToPage(OrderIssueScreen(orderId: orderDetail.orderId));
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(Assets.customerSupportIc),
                          const HorizontalSpacing(10),
                          Text(L10n.tr().getHelp, style: context.style16500.copyWith(color: Co.white)),
                        ],
                      ),
                    ),
                    const SizedBox(height: OrderDetailsConstants.defaultSpacing),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildVendorSections(OrderDetailEntity orderDetail) {
    return orderDetail.vendors.asMap().entries.map((entry) {
      final index = entry.key;
      final vendorDetail = entry.value;
      final isExpanded = _expandedVendors[index] ?? false;

      return Padding(
        padding: const EdgeInsets.only(bottom: OrderDetailsConstants.mediumSpacing),
        child: VendorSection(vendorDetail: vendorDetail, isExpanded: isExpanded, onToggle: () => _toggleVendor(index)),
      );
    }).toList();
  }
}
