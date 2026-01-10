import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_bus.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_events.dart';
import 'package:gazzer/features/addresses/presentation/views/add_edit_address_screen.dart';
import 'package:gazzer/features/cart/presentation/views/widgets/select_address_card.dart';
import 'package:go_router/go_router.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({super.key, this.selected});
  static const route = '/select-address';
  final AddressEntity? selected;
  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  AddressEntity? selected;

  @override
  void initState() {
    selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: MainAppBar(title: L10n.tr().selectAddress),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: di<AddressesBus>().getStream<FetchAddressesEvents>(),
              builder: (context, snapshot) {
                final addresses = Session().addresses;
                if (addresses.isEmpty) {
                  return Center(
                    child: Text(L10n.tr().youHaveNoAddressesYet, style: context.style16400.copyWith(color: Co.purple)),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: Session().addresses.length,
                  separatorBuilder: (context, index) => const VerticalSpacing(24),
                  itemBuilder: (context, index) {
                    final address = Session().addresses[index];
                    return SelectAddressCard(
                      address: address,
                      onSelect: (address) {
                        context.pop(address);
                      },
                    );
                    // return AddressCard(
                    //   address: AddressModel.fromEntity(address),
                    //   onSelect: (address) {
                    //     context.pop(address);
                    //   },
                    // );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: MainBtn(
              onPressed: () {
                const AddEditAddressRoute($extra: null).push(context).then((_) {
                  setState(() {});
                });
              },
              text: L10n.tr().addNewAddress,
            ),
          ),
          const VerticalSpacing(16),
        ],
      ),
    );
  }
}
