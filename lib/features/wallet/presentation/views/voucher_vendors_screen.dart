import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

class VoucherVendorsScreen extends StatelessWidget {
  final String title;
  final int id;

  const VoucherVendorsScreen({super.key, required this.title, required this.id});

  static const route = '/voucher-vendors';

  @override
  Widget build(BuildContext context) {
    final dummyVendors = List.generate(
      10,
      (index) => const _Vendor(
        name: 'Restaurant Name',
        cuisine: 'Fried chicken',
        eta: '20 - 40 min',
        imageUrl: 'https://firebasestorage.googleapis.com/v0/b/nabd-4xxx.appspot.com/o/app%2Fheart-attack.png?alt=media',
      ),
    );

    return Scaffold(
      appBar: MainAppBar(
        title: title,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
          final vendor = dummyVendors[index];
          return _VendorTile(vendor: vendor);
        },
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemCount: dummyVendors.length,
      ),
    );
  }
}

class _Vendor {
  const _Vendor({
    required this.name,
    required this.cuisine,
    required this.eta,
    required this.imageUrl,
  });

  final String name;
  final String cuisine;
  final String eta;
  final String imageUrl;
}

class _VendorTile extends StatelessWidget {
  const _VendorTile({required this.vendor});

  final _Vendor vendor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomNetworkImage(
          vendor.imageUrl,
          height: 60,
          width: 60,
          borderRaduis: 16,
          fit: BoxFit.cover,
          errorWidget: const Icon(
            Icons.broken_image,
            color: Co.grey,
            size: 60,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vendor.name,
                style: TStyle.robotBlackMedium(),
              ),
              const SizedBox(height: 4),
              Text(
                vendor.cuisine,
                style: textTheme.bodySmall?.copyWith(color: Co.darkGrey),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Co.grey),
                  const SizedBox(width: 4),
                  Text(
                    vendor.eta,
                    style: textTheme.bodySmall?.copyWith(color: Co.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
