part of 'package:gazzer/features/profile/presentation/views/profile_screen.dart';

class _ProfileAddressesComponent extends StatelessWidget {
  const _ProfileAddressesComponent();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          L10n.tr().addresses,
          style: TStyle.primaryBold(16),
        ),
        Divider(height: 15, thickness: 1, color: Co.purple.withAlpha(90)),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300),
          child: Scrollbar(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              itemCount: Fakers().addresses.length,
              separatorBuilder: (context, index) => const VerticalSpacing(16),
              itemBuilder: (context, index) {
                return AddressCard(address: AddressModel.fromEntity(Fakers().addresses[index]));
              },
            ),
          ),
        ),
        MainBtn(
          onPressed: () {},
          bgColor: Co.secondary,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Row(
            spacing: 16,
            children: [
              SvgPicture.asset(
                Assets.assetsSvgEditSquare,
                height: 20,
                width: 20,
                colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn),
              ),
              Expanded(
                child: Text(
                  L10n.tr().editAccountInformation,
                  style: TStyle.primaryBold(14, font: FFamily.inter),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
