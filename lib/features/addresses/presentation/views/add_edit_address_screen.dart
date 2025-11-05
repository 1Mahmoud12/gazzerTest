import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/components/select_search_menu.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/addresses/data/address_request.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_bus.dart';
import 'package:gazzer/features/addresses/presentation/cubit/add_edit_address_cubit.dart';
import 'package:gazzer/features/addresses/presentation/cubit/add_edit_address_states.dart';
import 'package:gazzer/features/addresses/presentation/views/widgets/address_map_widget.dart';
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
    return BlocProvider(
      create: (context) => di<AddEditAddressCubit>(param1: $extra),
      child: const AddEditAddressScreen(),
    );
  }
}

class AddEditAddressScreen extends StatefulWidget {
  const AddEditAddressScreen({super.key});
  static const routeWzExtra = '/address';
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
  ({String name, int id})? selectedProvince;
  ({String name, int id})? selectedZone;
  LatLng? latlng;
  final label = ValueNotifier<AddressLabel>(AddressLabel.home);

  late final AddEditAddressCubit cubit;
  @override
  void initState() {
    cubit = context.read<AddEditAddressCubit>();
    if (Session().tmpLocation != null) {
      latlng = LatLng(Session().tmpLocation!.latitude, Session().tmpLocation!.longitude);
    } else if (cubit.oldAddress != null) {
      final add = cubit.oldAddress;
      nameController.text = AddressLabel.fromString(add!.label).label ?? add.label;
      buildingController.text = add.building;
      floorController.text = add.floor;
      apartmentController.text = add.apartment;
      landMarkControler.text = add.landmark ?? '';
      latlng = LatLng(add.lat, add.lng);
      selectedProvince = (name: add.provinceName, id: add.provinceId);
      selectedZone = (name: add.zoneName, id: add.zoneId);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.getProvinces();
      if (cubit.oldAddress != null) {
        label.value = AddressLabel.fromString(cubit.oldAddress!.label);
        cubit.getZones(selectedProvince!.id);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    buildingController.dispose();
    floorController.dispose();
    apartmentController.dispose();
    landMarkControler.dispose();
    label.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: cubit.oldAddress == null ? L10n.tr().addAddress : L10n.tr().editAddress,
        titleStyle: TStyle.primaryBold(20),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                        spacing: 8,
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        runAlignment: WrapAlignment.spaceBetween,
                        children: List.generate(
                          AddressLabel.values.length,
                          (index) {
                            return LabelItem(
                              isSelected: value == AddressLabel.values[index],
                              title: AddressLabel.values[index].label ?? L10n.tr().other,
                              onSelect: () {
                                if (AddressLabel.values[index] != AddressLabel.other) {
                                  nameController.clear();
                                }
                                label.value = AddressLabel.values[index];
                              },
                            );
                          },
                        ),
                      ),
                      AnimatedSize(
                        duration: Durations.medium1,

                        child: SizedBox(
                          height: value == AddressLabel.other ? null : 0,
                          child: MainTextField(
                            controller: nameController,
                            showBorder: false,
                            enabled: value == AddressLabel.other,
                            borderRadius: 10,
                            max: 50,
                            hintText: L10n.tr().addressLabel,
                            validator: (text) {
                              if (value == AddressLabel.other) return Validators.notEmpty(text);
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox.shrink(),
                Text(L10n.tr().location, style: TStyle.primaryBold(14)),
                AddressMapWidget(
                  location: cubit.oldAddress?.location,
                  onChangeLocation: (loc) => latlng = loc,
                ),

                const SizedBox.shrink(),
                Text(L10n.tr().governorate, style: TStyle.primaryBold(14)),
                BlocBuilder<AddEditAddressCubit, AddEditAddressStates>(
                  buildWhen: (previous, current) => current is GetProvincesStates,
                  builder: (context, state) {
                    final items = state is GetProvincesStates ? state.provinces : <({int id, String name})>[];
                    if (cubit.oldAddress != null && state is GetProvincesSuccess) {
                      selectedProvince = state.provinces.firstWhereOrNull((e) => e.id == selectedProvince?.id) ?? selectedProvince;
                    }
                    return SelectSearchMenu<({String name, int id})>(
                      hintText: L10n.tr().selectGovernorate,
                      isLoading: state is GetProvincesLoading,
                      showBorder: false,
                      borderRadius: 10,
                      items: items,
                      initValue: () => selectedProvince != null ? {selectedProvince!} : {},
                      primaryColor: Co.secondary,
                      validator: Validators.notEmpty,
                      onSubmit: (set) {
                        if (set.first.id == selectedProvince?.id) return;
                        selectedZone = null;
                        selectedProvince = (name: set.first.title, id: set.first.id);
                        if (selectedProvince != null) cubit.getZones(selectedProvince!.id);
                      },
                      mapper: (item) => OptionItem(id: item.id, title: item.name),
                    );
                  },
                ),
                const SizedBox.shrink(),
                Text(L10n.tr().area, style: TStyle.primaryBold(14)),
                BlocBuilder<AddEditAddressCubit, AddEditAddressStates>(
                  buildWhen: (previous, current) => current is GetZonesStates,
                  builder: (context, state) {
                    final items = state is GetZonesStates ? state.zones : <({int id, String name})>[];
                    if (cubit.oldAddress != null && state is GetZonesSuccess) {
                      selectedZone = state.zones.firstWhereOrNull((e) => e.id == selectedZone?.id) ?? selectedZone;
                    }
                    return SelectSearchMenu<({String name, int id})>(
                      hintText: L10n.tr().selectArea,
                      isLoading: state is GetZonesLoading,
                      showBorder: false,
                      borderRadius: 10,
                      items: items,
                      initValue: () => selectedZone != null ? {selectedZone!} : {},
                      primaryColor: Co.secondary,
                      validator: Validators.notEmpty,
                      onSubmit: (p0) {
                        selectedZone = (name: p0.first.title, id: p0.first.id);
                      },
                      mapper: (item) => OptionItem(id: item.id, title: item.name),
                    );
                  },
                ),
                const SizedBox.shrink(),
                Text(L10n.tr().building, style: TStyle.primaryBold(14)),
                MainTextField(
                  controller: buildingController,
                  showBorder: false,
                  borderRadius: 10,
                  hintText: L10n.tr().buildingNameNumber,
                  validator: Validators.notEmpty,
                ),
                const SizedBox.shrink(),
                Row(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            max: 3,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                            max: 3,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            validator: Validators.notEmpty,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox.shrink(),
                Text(L10n.tr().landmark, style: TStyle.primaryBold(14)),
                MainTextField(
                  controller: landMarkControler,
                  showBorder: false,
                  borderRadius: 10,
                  hintText: L10n.tr().nearbyLandmark,
                  validator: (v) {
                    return Validators.notEmpty(v) ?? Validators.valueAtLeastNum(v, L10n.tr().landmark, 6);
                  },
                ),

                const SizedBox.shrink(),
                const SizedBox.shrink(),
                BlocConsumer<AddEditAddressCubit, AddEditAddressStates>(
                  listener: (context, state) {
                    if (state is SaveAddressSuccess) {
                      di<AddressesBus>().refreshAddresses();
                      Alerts.showToast(state.message, error: false);
                      context.pop(true); // indacates success operation
                    } else if (state is SaveAddressError) {
                      Alerts.showToast(state.error);
                    } else if (state is GetProvincesError) {
                    } else if (state is GetZonesError) {
                      Alerts.showToast(state.error);
                    }
                  },
                  buildWhen: (previous, current) => current is SaveAddressStates,
                  builder: (context, state) => MainBtn(
                    onPressed: () {
                      if (_formKey.currentState?.validate() != true) return;
                      if (latlng == null) {
                        return Alerts.showToast(L10n.tr().pleaseSelectYourLocation);
                      }
                      final req = AddressRequest(
                        label: label.value,
                        lat: latlng!.latitude,
                        long: latlng!.longitude,
                        provinceId: selectedProvince!.id,
                        provinceZoneId: selectedZone!.id,
                        name: nameController.text.trim(),
                        building: buildingController.text.trim(),
                        floor: floorController.text.trim(),
                        apartment: apartmentController.text.trim(),
                        landmark: landMarkControler.text.trim(),
                        isDefault: cubit.oldAddress?.isDefault ?? false,
                      );
                      cubit.saveAddress(req);
                    },
                    bgColor: Co.secondary,
                    isLoading: state is SaveAddressLoading,
                    radius: 12,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.add, size: 24, color: Co.purple),
                          const Spacer(),
                          Text(L10n.tr().saveAddress, style: TStyle.primaryBold(14)),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
