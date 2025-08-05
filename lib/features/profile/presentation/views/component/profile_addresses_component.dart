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
        StreamBuilder(
          stream: di<AddressesBus>().getStream<FetchAddressesEvents>(),
          builder: (context, snapshot) {
            final addresses = Session().addresses;
            return ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: Skeletonizer(
                enabled: snapshot.data is FetchAddressesLoading,
                child: addresses.isEmpty
                    ? SizedBox(
                        height: 60,
                        child: Center(
                          child: Text(
                            L10n.tr().youHaveNoAddressesYet,
                            style: TStyle.primarySemi(14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : Scrollbar(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          itemCount: addresses.length,
                          separatorBuilder: (context, index) => const VerticalSpacing(16),
                          itemBuilder: (context, index) {
                            return AddressCard(address: AddressModel.fromEntity(addresses[index]));
                          },
                        ),
                      ),
              ),
            );
          },
        ),
        MainBtn(
          onPressed: () {
            const AddEditAddressRoute($extra: null).push(context);
          },
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
                  L10n.tr().addNewAddress,
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
