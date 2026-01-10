part of 'package:gazzer/features/profile/presentation/views/profile_screen.dart';

class _ProfileAddressesComponent extends StatelessWidget {
  const _ProfileAddressesComponent();

  @override
  Widget build(BuildContext context) {
    return ExpandableWidget(
      title: L10n.tr().addresses,
      icon: Assets.addressIc,
      body: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder(
            stream: di<AddressesBus>().getStream<FetchAddressesEvents>(),
            builder: (context, snapshot) {
              final addresses = Session().addresses;
              return Skeletonizer(
                enabled: snapshot.data is FetchAddressesLoading,
                child: addresses.isEmpty
                    ? SizedBox(
                        height: 60,
                        child: Center(
                          child: Text(
                            L10n.tr().youHaveNoAddressesYet,
                            style: context.style14400.copyWith(color: Co.purple),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : Scrollbar(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          itemCount: addresses.length,
                          separatorBuilder: (context, index) => const VerticalSpacing(16),
                          itemBuilder: (context, index) {
                            return AddressCard(address: AddressModel.fromEntity(addresses[index]));
                          },
                        ),
                      ),
              );
            },
          ),
          MainBtn(
            onPressed: () {
              const AddEditAddressRoute($extra: null).push(context);
            },
            child: Text(
              L10n.tr().addNewAddress,
              style: context.style20500.copyWith(color: Co.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
