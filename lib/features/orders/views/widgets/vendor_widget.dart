import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/orders/domain/entities/order_vendor_entity.dart';

class VendorWidget extends StatelessWidget {
  const VendorWidget({super.key, required this.vendors, this.onVendorChanged, this.selectedVendorId, required this.orderId});

  final List<OrderVendorEntity> vendors;
  final Function(OrderVendorEntity)? onVendorChanged;
  final int? selectedVendorId;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    if (vendors.length == 1) {
      return _SingleVendorView(vendor: vendors.first, orderId: orderId);
    }

    return _VendorDropdown(
      vendors: vendors,
      orderId: orderId,
      selectedVendorId: selectedVendorId ?? vendors.first.id,
      onVendorChanged: onVendorChanged,
    );
  }
}

class _SingleVendorView extends StatelessWidget {
  const _SingleVendorView({required this.vendor, required this.orderId});

  final OrderVendorEntity vendor;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (vendor.logo != null)
          SizedBox(width: 56, height: 56, child: CustomNetworkImage(vendor.logo!))
        else
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: Co.secondary, borderRadius: BorderRadius.circular(8)),
          ),
        const HorizontalSpacing(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(vendor.name, style: context.style14400.copyWith(fontWeight: TStyle.bold)),
              Text('${L10n.tr().orderId}: #$orderId', style: context.style12400),
            ],
          ),
        ),
      ],
    );
  }
}

class _VendorDropdown extends StatefulWidget {
  const _VendorDropdown({required this.vendors, required this.selectedVendorId, this.onVendorChanged, required this.orderId});

  final List<OrderVendorEntity> vendors;
  final int selectedVendorId;
  final String orderId;
  final Function(OrderVendorEntity)? onVendorChanged;

  @override
  State<_VendorDropdown> createState() => _VendorDropdownState();
}

class _VendorDropdownState extends State<_VendorDropdown> {
  late OrderVendorEntity selectedVendor;

  @override
  void initState() {
    super.initState();
    selectedVendor = widget.vendors.firstWhere((v) => v.id == widget.selectedVendorId, orElse: () => widget.vendors.first);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<OrderVendorEntity>(
      initialValue: selectedVendor,
      onSelected: (vendor) {
        setState(() {
          selectedVendor = vendor;
        });
        widget.onVendorChanged?.call(vendor);
      },
      itemBuilder: (context) {
        return widget.vendors.map((vendor) {
          return PopupMenuItem<OrderVendorEntity>(
            value: vendor,
            child: _VendorTile(vendor: vendor, orderId: widget.orderId),
          );
        }).toList();
      },
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Co.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(L10n.tr().vendors, style: context.style16500),
              const Icon(Icons.keyboard_arrow_down, color: Co.black),
            ],
          ),
          Text('${L10n.tr().orderId}: #${widget.orderId}', style: context.style16400.copyWith(fontSize: 14)),
        ],
      ),
    );
  }
}

class _VendorTile extends StatelessWidget {
  const _VendorTile({required this.vendor, required this.orderId});

  final OrderVendorEntity vendor;
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          if (vendor.logo != null)
            SizedBox(width: 56, height: 56, child: CustomNetworkImage(vendor.logo!))
          else
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(color: Co.secondary, shape: BoxShape.circle),
            ),
          const HorizontalSpacing(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(vendor.name, style: context.style14400.copyWith(fontWeight: TStyle.bold))],
          ),
        ],
      ),
    );
  }
}
