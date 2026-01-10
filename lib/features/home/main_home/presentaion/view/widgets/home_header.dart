part of '../home_screen.dart';

class _HomeHeader extends StatefulWidget {
  const _HomeHeader();

  @override
  State<_HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<_HomeHeader> {
  bool _hasCheckedLocation = false;

  @override
  void initState() {
    super.initState();
    // Check for cached location after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowLocationSheet();
    });
  }

  void _checkAndShowLocationSheet() {
    if (_hasCheckedLocation) return;
    _hasCheckedLocation = true;

    // Check if there's no cached location
    if (!HomeHeaderLogic.hasCachedLocation()) {
      // No location found, show bottom sheet
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          _showAddressesSheet(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = HomeUtils.headerWidth(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const VerticalSpacing(kToolbarHeight),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  context.push(NotificationsView.route);
                },
                child: const Padding(padding: EdgeInsets.all(6), child: VectorGraphicsWidget(Assets.assetsSvgNotification)),
              ),
              VectorGraphicsWidget(Assets.assetsSvgCharacter, width: width * 0.1, height: width * 0.1),
              InkWell(
                onTap: () {
                  context.go('/cart');
                },
                child: const VectorGraphicsWidget(Assets.cartIc),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: InkWell(
            onTap: () async {
              await _showAddressesSheet(context);
            },
            borderRadius: AppConst.defaultBorderRadius,
            child: Row(
              children: [
                SvgPicture.asset(Assets.assetsSvgLocation, height: 32, width: 32).withHotspot(order: 4, title: '', text: L10n.tr().setYourLocation),
                const HorizontalSpacing(8),
                StreamBuilder(
                  stream: di<AddressesBus>().getStream<AddressesEvents>(),
                  builder: (context, snapshot) {
                    final address = Session().defaultAddress;
                    final tmpLocation = Session().tmpLocation;
                    final tmpLocationDescription = Session().tmpLocationDescription;

                    return Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            if (address != null) ...[
                              TextSpan(text: L10n.tr().deliverTo, style: context.style16400),
                              TextSpan(text: ' ${address.label} ', style: context.style16400),
                              const WidgetSpan(
                                child: Icon(Icons.keyboard_arrow_down, color: Co.black),
                                alignment: PlaceholderAlignment.middle,
                              ),
                              TextSpan(text: '\n${address.zoneName}, ${address.provinceName}', style: context.style14400),
                            ] else if (tmpLocation != null && tmpLocationDescription != null) ...[
                              TextSpan(text: L10n.tr().deliverTo, style: context.style16400),
                              const WidgetSpan(
                                child: Icon(Icons.keyboard_arrow_down, color: Co.black),
                                alignment: PlaceholderAlignment.middle,
                              ),
                              TextSpan(text: '\n$tmpLocationDescription', style: context.style14400),
                            ] else
                              TextSpan(text: L10n.tr().noAddressesSelected, style: context.style14400),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: context.style14400.copyWith(color: Co.white, fontWeight: TStyle.medium),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showAddressesSheet(BuildContext context) async {
    final addresses = Session().addresses;
    final bus = di<AddressesBus>();
    LatLng? selectedLocation;

    await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSheetHeader(context, selectedLocation),
                  const VerticalSpacing(16),
                  if (addresses.isNotEmpty) _buildSavedAddressesSection(context, addresses, bus),
                  _buildCurrentLocationOption(context),
                  const VerticalSpacing(12),
                  _buildMapLocationOption(context),
                  const VerticalSpacing(120),
                ],
              ),
            );
          },
        );
      },
    );

    // Refresh the header after sheet closes to show updated location
    if (mounted) {
      setState(() {});
    }
  }
}

Widget _buildSheetHeader(BuildContext context, LatLng? selectedLocation) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(L10n.tr().chooseDeliveryLocation, style: context.style16500.copyWith(color: Co.purple)),
      IconButton(icon: const Icon(Icons.close), onPressed: () => _handleSheetClose(context, selectedLocation)),
    ],
  );
}

Widget _buildSavedAddressesSection(BuildContext context, List<AddressEntity> addresses, AddressesBus bus) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(L10n.tr().savedAddresses, style: context.style16500.copyWith(color: Co.purple)),
      const VerticalSpacing(12),
      Flexible(
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: addresses.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) => _buildAddressItem(context, addresses[index], bus),
        ),
      ),
      const VerticalSpacing(16),
    ],
  );
}

Widget _buildAddressItem(BuildContext context, AddressEntity address, AddressesBus bus) {
  return InkWell(
    onTap: () => _handleAddressSelection(context, address, bus),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: Co.purple, size: 24),
          const HorizontalSpacing(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address.label, style: context.style14400.copyWith(color: Co.purple)),
                const VerticalSpacing(4),
                Text('${address.zoneName}, ${address.provinceName}', style: context.style12400.copyWith(color: Co.darkGrey)),
              ],
            ),
          ),
          if (address.isDefault)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Co.purple.withOpacityNew(0.1), borderRadius: BorderRadius.circular(8)),
              child: Text(L10n.tr().defaultt, style: context.style14400.copyWith(color: Co.secondary)),
            ),
        ],
      ),
    ),
  );
}

Widget _buildCurrentLocationOption(BuildContext context) {
  return InkWell(
    onTap: () => _handleCurrentLocationSelection(context),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Co.lightPurple),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.navigation, color: Co.purple, size: 24),
          const HorizontalSpacing(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(L10n.tr().deliverToCurrentLocation, style: context.style14400.copyWith(color: Co.purple)),
                const VerticalSpacing(4),
                Text(L10n.tr().outsideDeliveryZone, style: context.style12400.copyWith(color: Co.darkGrey)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Co.grey),
        ],
      ),
    ),
  );
}

Widget _buildMapLocationOption(BuildContext context) {
  return InkWell(
    onTap: () => _handleMapLocationSelection(context),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Co.lightPurple),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Co.purple, size: 24),
          const HorizontalSpacing(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(L10n.tr().deliverToDifferentLocation, style: context.style14400.copyWith(color: Co.purple)),
                const VerticalSpacing(4),
                Text(L10n.tr().chooseLocationOnMap, style: context.style12400.copyWith(color: Co.darkGrey)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Co.grey),
        ],
      ),
    ),
  );
}

// UI handlers - delegate to business logic
Future<void> _handleSheetClose(BuildContext context, LatLng? selectedLocation) async {
  await HomeHeaderLogic.handleSheetClose(context, selectedLocation);
  if (context.mounted) {
    Navigator.of(context).pop();
  }
}

Future<void> _handleAddressSelection(BuildContext context, AddressEntity address, AddressesBus bus) async {
  final success = await HomeHeaderLogic.handleAddressSelection(context, address, bus);
  if (success && context.mounted) {
    Navigator.of(context).pop();
  }
}

Future<void> _handleCurrentLocationSelection(BuildContext context) async {
  final success = await HomeHeaderLogic.handleCurrentLocationSelection(context);
  if (success && context.mounted) {
    Navigator.of(context).pop();
  }
}

Future<void> _handleMapLocationSelection(BuildContext context) async {
  final success = await LocationUtils.handleMapLocationSelection(context);
  if (success && context.mounted) {
    Navigator.of(context).pop();
  }
}
