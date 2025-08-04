import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/addresses/presentation/views/widgets/label_item.dart';
import 'package:gazzer/features/profile/presentation/model/address_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'add_edit_address_screen.g.dart';

@TypedGoRoute<AddEditAddressRoute>(path: AddEditAddressScreen.routeWzExtra)
@immutable
class AddEditAddressRoute extends GoRouteData with _$AddEditAddressRoute {
  const AddEditAddressRoute({required this.$extra});
  final AddressEntity? $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AddEditAddressScreen(address: $extra);
  }
}

class AddEditAddressScreen extends StatefulWidget {
  const AddEditAddressScreen({super.key, this.address});
  static const routeWzExtra = '/address';
  final AddressEntity? address;
  @override
  State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final buildingController = TextEditingController();
  final floorController = TextEditingController();
  final apartmentController = TextEditingController();
  final landMarkControler = TextEditingController();
  LatLng? latlng;
  final label = ValueNotifier<AddressLabel>(AddressLabel.home);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: widget.address == null ? L10n.tr().addAddress : L10n.tr().editAddress,
        titleStyle: TStyle.primaryBold(20),
      ),
      body: SingleChildScrollView(
        padding: AppConst.defaultPadding,
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(L10n.tr().addressName, style: TStyle.primaryBold(14)),
              const SizedBox.shrink(),
              ValueListenableBuilder(
                valueListenable: label,
                builder: (context, value, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Wrap(
                      spacing: 24,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runAlignment: WrapAlignment.spaceBetween,
                      children: List.generate(
                        AddressLabel.values.length,
                        (index) {
                          return LabelItem(
                            isSelected: value == AddressLabel.values[index],
                            title: AddressLabel.values[index].label ?? L10n.tr().other,
                            onSelect: () => label.value = AddressLabel.values[index],
                          );
                        },
                      ),
                    ),
                    MainTextField(
                      controller: nameController,
                      showBorder: false,
                      enabled: value == AddressLabel.other,
                      borderRadius: 10,
                      hintText: L10n.tr().addressLabel,
                      validator: (text) {
                        if (value == AddressLabel.other) return Validators.notEmpty(text);
                        return null;
                      },
                    ),
                    const SizedBox.shrink(),
                    Text(L10n.tr().building, style: TStyle.primaryBold(14)),
                    MainTextField(
                      controller: buildingController,
                      showBorder: false,
                      borderRadius: 10,
                      hintText: L10n.tr().buildingNumber,
                      validator: Validators.notEmpty,
                    ),
                    const SizedBox.shrink(),
                    Row(
                      spacing: 16,
                      children: [
                        Expanded(
                          child: Column(
                            spacing: 6,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(L10n.tr().floor, style: TStyle.primaryBold(14)),
                              MainTextField(
                                controller: floorController,
                                showBorder: false,
                                borderRadius: 10,
                                hintText: L10n.tr().floor,
                                inputFormatters: FilteringTextInputFormatter.digitsOnly,
                                validator: Validators.notEmpty,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            spacing: 6,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(L10n.tr().apartment, style: TStyle.primaryBold(14)),
                              MainTextField(
                                controller: apartmentController,
                                showBorder: false,
                                borderRadius: 10,
                                hintText: L10n.tr().apartmentNumber,
                                inputFormatters: FilteringTextInputFormatter.digitsOnly,
                                validator: Validators.notEmpty,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox.shrink(),
                    Text(L10n.tr().landmark, style: TStyle.primaryBold(14)),
                    MainTextField(
                      controller: landMarkControler,
                      showBorder: false,
                      borderRadius: 10,
                      hintText: L10n.tr().nearbyLandmark,
                      inputFormatters: FilteringTextInputFormatter.digitsOnly,
                      validator: Validators.notEmpty,
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
