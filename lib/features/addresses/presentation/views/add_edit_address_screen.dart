import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
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
import 'package:gazzer/features/auth/common/widgets/select_location_screen.dart';
import 'package:gazzer/features/profile/presentation/model/address_model.dart';
import 'package:geocoding/geocoding.dart';
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
  late Color backgroundFormField;
  ({String name, int id})? selectedProvince;
  ({String name, int id})? selectedZone;
  LatLng? latlng;
  String? locationAddress;

  late final AddEditAddressCubit cubit;
  @override
  void initState() {
    backgroundFormField = context.isDarkMode
        ? Co.darkModeLayer
        : Colors.transparent;
    cubit = context.read<AddEditAddressCubit>();
    if (Session().tmpLocation != null) {
      latlng = LatLng(
        Session().tmpLocation!.latitude,
        Session().tmpLocation!.longitude,
      );
      locationAddress =
          '234 Main street'; // Placeholder - in real app, get from geocoding
    } else if (cubit.oldAddress != null) {
      final add = cubit.oldAddress;
      nameController.text =
          AddressLabel.fromString(add!.label).label ?? add.label;
      buildingController.text = add.building;
      floorController.text = add.floor;
      apartmentController.text = add.apartment;
      landMarkControler.text = add.landmark ?? '';
      latlng = LatLng(add.lat, add.lng);
      selectedProvince = (name: add.provinceName, id: add.provinceId);
      selectedZone = (name: add.zoneName, id: add.zoneId);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        locationAddress = await _getAddressFromCoordinates(
          add.lat,
          add.lng,
        ); // Use landmark or placeholder
        setState(() {});
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      cubit.getProvinces();
      if (cubit.oldAddress != null) {
        cubit.getZones(selectedProvince!.id);
        // Get address from coordinates for existing address
        if (latlng != null && locationAddress == null) {
          final address = await _getAddressFromCoordinates(
            latlng!.latitude,
            latlng!.longitude,
          );

          if (mounted) {
            setState(() {
              locationAddress = address;
            });
          }
        }
      } else if (Session().tmpLocation != null && latlng != null) {
        // Get address from coordinates for new address from session
        final address = await _getAddressFromCoordinates(
          latlng!.latitude,
          latlng!.longitude,
        );
        if (mounted) {
          setState(() {
            locationAddress = address;
          });
        }
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
    super.dispose();
  }

  /// Get address string from coordinates using reverse geocoding
  Future<String> _getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        // Build address string from placemark components
        final addressParts = <String>[];
        if (place.street != null && place.street!.isNotEmpty) {
          addressParts.add(place.street!);
        }
        if (place.subThoroughfare != null &&
            place.subThoroughfare!.isNotEmpty) {
          addressParts.add(place.subThoroughfare!);
        }
        if (place.thoroughfare != null && place.thoroughfare!.isNotEmpty) {
          addressParts.add(place.thoroughfare!);
        }
        if (place.locality != null && place.locality!.isNotEmpty) {
          addressParts.add(place.locality!);
        }
        if (place.subAdministrativeArea != null &&
            place.subAdministrativeArea!.isNotEmpty) {
          addressParts.add(place.subAdministrativeArea!);
        }
        if (place.administrativeArea != null &&
            place.administrativeArea!.isNotEmpty) {
          addressParts.add(place.administrativeArea!);
        }
        if (place.country != null && place.country!.isNotEmpty) {
          addressParts.add(place.country!);
        }

        if (addressParts.isNotEmpty) {
          return addressParts.join(', ');
        }
      }
      // Fallback: return coordinates if geocoding fails
      return '$latitude, $longitude';
    } catch (e) {
      // Fallback: return coordinates if geocoding fails
      return '$latitude, $longitude';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: cubit.oldAddress == null
            ? L10n.tr().addAddress
            : L10n.tr().editAddress,
      ),
      body: SingleChildScrollView(
        padding: AppConst.defaultPadding,
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpacing(36),
              _AddressNameField(
                backgroundFormField: backgroundFormField,
                controller: nameController,
                onSelectHome: () {
                  nameController.text = L10n.tr().homeAddress;
                },
                onSelectWork: () {
                  nameController.text = L10n.tr().work;
                },
              ),

              const VerticalSpacing(16),

              Text(L10n.tr().location, style: context.style16400),

              const VerticalSpacing(8),
              GestureDetector(
                onTap: () async {
                  final result = await SelectLocationRoute((
                    initLocation: latlng,
                    onSubmit: (ctx, loc) => ctx.pop(loc),
                  )).push<LatLng>(context);
                  if (result != null) {
                    // Get address from coordinates using reverse geocoding
                    final address = await _getAddressFromCoordinates(
                      result.latitude,
                      result.longitude,
                    );
                    setState(() {
                      latlng = result;
                      locationAddress = address;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),

                  decoration: BoxDecoration(
                    color: backgroundFormField,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: context.isDarkMode
                          ? Co.darkModeLayer
                          : Co.borderColor,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        Assets.locationIc,
                        height: 20,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                          context.isDarkMode ? Co.secondary : Co.darkGrey,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            // Open map selection
                            final result = await SelectLocationRoute((
                              initLocation: latlng,
                              onSubmit: (ctx, loc) => ctx.pop(loc),
                            )).push<LatLng>(context);
                            if (result != null) {
                              // Get address from coordinates using reverse geocoding
                              final address = await _getAddressFromCoordinates(
                                result.latitude,
                                result.longitude,
                              );
                              setState(() {
                                latlng = result;
                                locationAddress = address;
                              });
                            }
                          },
                          child: Text(
                            locationAddress ?? '',
                            style: context.style14400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: () async {
                          final result = await SelectLocationRoute((
                            initLocation: latlng,
                            onSubmit: (ctx, loc) => ctx.pop(loc),
                          )).push<LatLng>(context);
                          if (result != null) {
                            // Get address from coordinates using reverse geocoding
                            final address = await _getAddressFromCoordinates(
                              result.latitude,
                              result.longitude,
                            );
                            setState(() {
                              latlng = result;
                              locationAddress = address;
                            });
                          }
                        },
                        child: SvgPicture.asset(
                          Assets.assetsSvgEdit,
                          colorFilter: const ColorFilter.mode(
                            Co.secondary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const VerticalSpacing(16),
              Text(L10n.tr().governorate, style: context.style16400),
              const VerticalSpacing(8),
              BlocBuilder<AddEditAddressCubit, AddEditAddressStates>(
                buildWhen: (previous, current) => current is GetProvincesStates,
                builder: (context, state) {
                  final items = state is GetProvincesStates
                      ? state.provinces
                      : <({int id, String name})>[];
                  if (cubit.oldAddress != null &&
                      state is GetProvincesSuccess) {
                    selectedProvince =
                        state.provinces.firstWhereOrNull(
                          (e) => e.id == selectedProvince?.id,
                        ) ??
                        selectedProvince;
                  }
                  return SelectSearchMenu<({String name, int id})>(
                    hintText: L10n.tr().selectGovernorate,
                    fillColor: backgroundFormField,
                    isLoading: state is GetProvincesLoading,
                    showBorder: !context.isDarkMode,

                    borderRadius: 24,
                    items: items,
                    initValue: () =>
                        selectedProvince != null ? {selectedProvince!} : {},
                    primaryColor: Co.secondary,
                    validator: Validators.notEmpty,
                    onSubmit: (set) {
                      if (set.first.id == selectedProvince?.id) return;
                      selectedZone = null;
                      selectedProvince = (
                        name: set.first.title,
                        id: set.first.id,
                      );
                      if (selectedProvince != null) {
                        cubit.getZones(selectedProvince!.id);
                      }
                    },
                    mapper: (item) => OptionItem(id: item.id, title: item.name),
                  );
                },
              ),
              const VerticalSpacing(16),
              Text(L10n.tr().area, style: context.style16400),
              const VerticalSpacing(8),
              BlocBuilder<AddEditAddressCubit, AddEditAddressStates>(
                buildWhen: (previous, current) => current is GetZonesStates,
                builder: (context, state) {
                  final items = state is GetZonesStates
                      ? state.zones
                      : <({int id, String name})>[];
                  if (cubit.oldAddress != null && state is GetZonesSuccess) {
                    selectedZone =
                        state.zones.firstWhereOrNull(
                          (e) => e.id == selectedZone?.id,
                        ) ??
                        selectedZone;
                  }
                  return SelectSearchMenu<({String name, int id})>(
                    hintText: L10n.tr().selectArea,
                    isLoading: state is GetZonesLoading,
                    showBorder: !context.isDarkMode,
                    fillColor: backgroundFormField,
                    borderRadius: 24,
                    items: items,
                    initValue: () =>
                        selectedZone != null ? {selectedZone!} : {},
                    primaryColor: Co.secondary,
                    validator: Validators.notEmpty,
                    onSubmit: (p0) {
                      selectedZone = (name: p0.first.title, id: p0.first.id);
                    },
                    mapper: (item) => OptionItem(id: item.id, title: item.name),
                  );
                },
              ),
              const VerticalSpacing(16),
              Text(L10n.tr().building, style: context.style16400),
              const VerticalSpacing(8),
              MainTextField(
                controller: buildingController,
                showBorder: !context.isDarkMode,
                borderColor: context.isDarkMode
                    ? Co.darkModeLayer
                    : Co.borderColor,
                borderRadius: 24,
                bgColor: backgroundFormField,

                hintText: L10n.tr().buildingNameNumber,
                validator: Validators.notEmpty,
              ),
              const VerticalSpacing(16),
              Row(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      spacing: 6,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(L10n.tr().floor, style: context.style16400),
                        MainTextField(
                          bgColor: backgroundFormField,
                          controller: floorController,
                          showBorder: !context.isDarkMode,
                          borderColor: context.isDarkMode
                              ? Co.darkModeLayer
                              : Co.borderColor,

                          borderRadius: 24,
                          hintText: L10n.tr().floor,
                          max: 3,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
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
                        Text(L10n.tr().apartment, style: context.style16400),
                        MainTextField(
                          controller: apartmentController,
                          showBorder: !context.isDarkMode,
                          bgColor: backgroundFormField,
                          borderColor: context.isDarkMode
                              ? Co.darkModeLayer
                              : Co.borderColor,

                          borderRadius: 24,
                          hintText: L10n.tr().apartmentNumber,
                          max: 3,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: Validators.notEmpty,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(L10n.tr().landmark, style: context.style16400),
              const VerticalSpacing(8),
              MainTextField(
                controller: landMarkControler,

                showBorder: !context.isDarkMode,
                bgColor: backgroundFormField,
                borderColor: context.isDarkMode
                    ? Co.darkModeLayer
                    : Co.borderColor,

                borderRadius: 24,
                hintText: L10n.tr().nearbyLandmark,
                validator: (v) {
                  return Validators.notEmpty(v) ??
                      Validators.valueAtLeastNum(v, L10n.tr().landmark, 6);
                },
              ),

              const SizedBox(height: 40),
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
                      return Alerts.showToast(
                        L10n.tr().pleaseSelectYourLocation,
                      );
                    }
                    // Determine label from text input
                    final nameText = nameController.text.toLowerCase();

                    final req = AddressRequest(
                      label: AddressLabel.other,
                      lat: latlng!.latitude,
                      long: latlng!.longitude,
                      provinceId: selectedProvince!.id,
                      provinceZoneId: selectedZone!.id,
                      name: nameText,
                      building: buildingController.text.trim(),
                      floor: floorController.text.trim(),
                      apartment: apartmentController.text.trim(),
                      landmark: landMarkControler.text.trim(),
                      isDefault: cubit.oldAddress?.isDefault ?? false,
                    );
                    cubit.saveAddress(req);
                  },
                  bgColor: Co.purple,
                  isLoading: state is SaveAddressLoading,
                  child: Text(
                    L10n.tr().saveAddress,
                    style: context.style14400.copyWith(color: Co.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddressNameField extends StatelessWidget {
  const _AddressNameField({
    required this.controller,
    required this.onSelectHome,
    required this.onSelectWork,
    required this.backgroundFormField,
  });

  final Color backgroundFormField;
  final TextEditingController controller;
  final VoidCallback onSelectHome;
  final VoidCallback onSelectWork;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(L10n.tr().addressName, style: context.style16400),
        const VerticalSpacing(8),
        MainTextField(
          bgColor: backgroundFormField,
          controller: controller,
          borderColor: context.isDarkMode ? Co.darkModeLayer : Co.borderColor,

          showBorder: !context.isDarkMode,
          borderRadius: 24,
          max: 50,
          hintText: 'home,work,..',
          validator: Validators.notEmpty,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _QuickSelectButton(
                label: L10n.tr().homeAddress,
                backgroundFormField: backgroundFormField,
                borderColor: context.isDarkMode
                    ? Co.darkModeLayer
                    : Co.borderColor,
                onTap: onSelectHome,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _QuickSelectButton(
                backgroundFormField: backgroundFormField,
                label: L10n.tr().work,
                borderColor: context.isDarkMode
                    ? Co.darkModeLayer
                    : Co.borderColor,
                onTap: onSelectWork,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickSelectButton extends StatelessWidget {
  const _QuickSelectButton({
    required this.label,
    required this.onTap,
    required this.backgroundFormField,
    required this.borderColor,
  });

  final String label;
  final VoidCallback onTap;
  final Color backgroundFormField;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundFormField,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: borderColor),
        ),
        child: Center(child: Text(label, style: context.style16400)),
      ),
    );
  }
}
