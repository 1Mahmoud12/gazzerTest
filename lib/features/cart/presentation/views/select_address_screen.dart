import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
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
      appBar: const ClassicAppBar(),
      body: SafeArea(
        child: Padding(
          padding: AppConst.defaultPadding,
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: di<AddressesBus>().getStream<FetchAddressesEvents>(),
                  builder: (context, snapshot) {
                    final addresses = Session().addresses;
                    if (addresses.isEmpty) {
                      return Center(
                        child: Text(
                          L10n.tr().youHaveNoAddressesYet,
                          style: TStyle.primaryBold(16),
                        ),
                      );
                    }
                    return ListView.separated(
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
                      },
                    );
                  },
                ),
              ),
              MainBtn(
                onPressed: () {
                  const AddEditAddressRoute($extra: null).push(context).then((_) {
                    setState(() {});
                  });
                },
                bgColor: Co.secondary,
                radius: 12,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Row(
                  spacing: 16,
                  children: [
                    const Icon(Icons.add, size: 20, color: Co.purple),
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
          ),
        ),
      ),
    );
  }
}
