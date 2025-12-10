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
                onTap: () {},
                child: Padding(padding: const EdgeInsets.all(6), child: SvgPicture.asset(Assets.assetsSvgNotification)),
              ),
              SvgPicture.asset(Assets.assetsSvgCharacter, width: width * 0.1, height: width * 0.1),
              SvgPicture.asset(Assets.cartIc),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            children: [
              SvgPicture.asset(Assets.assetsSvgLocation, height: 32, width: 32).withHotspot(order: 4, title: '', text: L10n.tr().setYourLocation),
              const HorizontalSpacing(8),
              StreamBuilder(
                stream: di<AddressesBus>().getStream<AddressesEvents>(),
                builder: (context, snapshot) {
                  final address = Session().defaultAddress;

                  return Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: L10n.tr().deliverTo, style: TStyle.robotBlackRegular()),

                          if (address != null) ...[
                            TextSpan(text: ' ${address.label}\n', style: TStyle.robotBlackRegular()),
                            TextSpan(text: '${address.zoneName}, ${address.provinceName}', style: TStyle.robotBlackSmall()),
                          ] else
                            TextSpan(
                              text: L10n.tr().noAddressesSelected,
                              style: TStyle.mainwSemi(13).copyWith(color: Co.purple.withAlpha(180)),
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
      ],
    );
  }
}
