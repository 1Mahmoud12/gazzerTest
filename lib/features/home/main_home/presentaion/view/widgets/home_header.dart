part of '../home_screen.dart';

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();
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
                  print('Notifications tapped');
                  context.push(NotificationsView.route);
                },
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: VectorGraphicsWidget(Assets.assetsSvgNotification),
                ),
              ),
              VectorGraphicsWidget(
                Assets.assetsSvgCharacter,
                width: width * 0.1,
                height: width * 0.1,
              ),
              const VectorGraphicsWidget(Assets.cartIc),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: InkWell(
            onTap: () => _showAddressesSheet(context),
            borderRadius: AppConst.defaultBorderRadius,
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.assetsSvgLocation,
                  height: 32,
                  width: 32,
                ).withHotspot(
                  order: 4,
                  title: '',
                  text: L10n.tr().setYourLocation,
                ),
                const HorizontalSpacing(8),
                StreamBuilder(
                  stream: di<AddressesBus>().getStream<AddressesEvents>(),
                  builder: (context, snapshot) {
                    final address = Session().defaultAddress;

                    return Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            if (address != null) ...[
                              TextSpan(
                                text: L10n.tr().deliverTo,
                                style: TStyle.robotBlackRegular(),
                              ),
                              TextSpan(
                                text: ' ${address.label} ',
                                style: TStyle.robotBlackRegular(),
                              ),
                              const WidgetSpan(
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Co.black,
                                ),
                                alignment: PlaceholderAlignment.middle,
                              ),
                              TextSpan(
                                text:
                                    '\n${address.zoneName}, ${address.provinceName}',
                                style: TStyle.robotBlackSmall(),
                              ),
                            ] else
                              TextSpan(
                                text: L10n.tr().noAddressesSelected,
                                style: TStyle.robotBlackSmall(),
                              ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TStyle.whiteSemi(14),
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
}

Future<void> _showAddressesSheet(BuildContext context) async {
  final addresses = Session().addresses;
  final bus = di<AddressesBus>();

  await showModalBottomSheet(
    context: context,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      if (addresses.isEmpty) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Text(
              L10n.tr().noAddressesSelected,
              style: TStyle.mainwSemi(14),
            ),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Choose delivery location', style: TStyle.primarySemi(18)),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const VerticalSpacing(12),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: addresses.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.location_on_outlined,
                      color: Co.purple,
                    ),
                    title: Text(address.label, style: TStyle.primarySemi(14)),
                    subtitle: Text(
                      '${address.zoneName}, ${address.provinceName}',
                      style: TStyle.greyRegular(12),
                    ),
                    trailing: address.isDefault
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Co.purple.withOpacityNew(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              L10n.tr().defaultt,
                              style: TStyle.secondarySemi(12),
                            ),
                          )
                        : null,
                    onTap: () {
                      Navigator.of(context).pop();
                      bus.setDefault(address.id);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
