import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'select_location_screen.g.dart';

@TypedGoRoute<SelectLocationRoute>(path: SelectLocationScreen.route)
@immutable
class SelectLocationRoute extends GoRouteData with _$SelectLocationRoute {
  const SelectLocationRoute(this.$extra);

  final ({LatLng? initLocation, Function(BuildContext context, LatLng) onSubmit}) $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SelectLocationScreen(extra: $extra);
  }
}

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key, required this.extra});
  static const route = '/select-location';
  final ({LatLng? initLocation, Function(BuildContext context, LatLng) onSubmit}) extra;
  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  GoogleMapController? mapController;
  late ValueNotifier<LatLng?> initLocation;
  ValueNotifier<bool> isgetttingCurrent = ValueNotifier<bool>(false);
  Future<bool> enableService() async {
    LocationPermission permission;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Alerts.locationDisabled();
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (!(permission == LocationPermission.whileInUse || permission == LocationPermission.always)) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
      if (permission == LocationPermission.deniedForever) return false;
    }
    return true;
  }

  Future<LatLng?> getCurrentPosition(bool getuserLocation) async {
    if (!getuserLocation && widget.extra.initLocation != null) {
      return widget.extra.initLocation!;
    }
    LatLng? defaultLocation;
    final isEnabled = await enableService();
    if (isEnabled) {
      final location = await Geolocator.getCurrentPosition();
      defaultLocation = LatLng(location.latitude, location.longitude);
    }
    return defaultLocation;
  }

  @override
  void initState() {
    super.initState();
    initLocation = ValueNotifier(widget.extra.initLocation);
    // di<FirebaseAnalyticServices>()
    //     .setScreen(name: 'MapScreen', className: Constants.userRelatedClass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<LatLng?>(
        future: getCurrentPosition(false),
        builder: (context, location) {
          return Stack(
            alignment: Alignment.center,
            children: [
              if (location.connectionState == ConnectionState.waiting) ...[
                const Align(
                  alignment: AlignmentDirectional.topStart,
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
                      child: BackButton(),
                    ),
                  ),
                ),
                const Center(child: AdaptiveProgressIndicator()),
              ] else ...[
                DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Co.purple.withAlpha(120), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.0, 0.2],
                    ),
                  ),
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      mapController = controller;
                      initLocation.value = location.data ?? const LatLng(30.0444, 31.2357);
                    },
                    initialCameraPosition: CameraPosition(
                      target: location.data ?? const LatLng(30.0444, 31.2357),
                      zoom: 13,
                    ),
                    zoomControlsEnabled: false,
                    myLocationEnabled: false,
                    compassEnabled: false,
                    trafficEnabled: false,
                    indoorViewEnabled: false,
                    myLocationButtonEnabled: false,
                    fortyFiveDegreeImageryEnabled: false,
                    mapToolbarEnabled: false,
                    mapType: MapType.normal,
                    onCameraMove: (position) => initLocation.value = position.target,
                    onTap: (latlng) {},
                  ),
                ),
                const SafeArea(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 60),
                      child: Icon(
                        Icons.location_pin,
                        size: 60,
                        color: Co.purple,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BackButton(),
                          InkWell(
                            onTap: () async {
                              isgetttingCurrent.value = true;
                              final location = await getCurrentPosition(true);
                              if (location != null) {
                                mapController?.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(target: location, zoom: 17),
                                  ),
                                );
                              }
                              isgetttingCurrent.value = false;
                            },
                            child: ValueListenableBuilder<bool>(
                              valueListenable: isgetttingCurrent,
                              builder: (context, value, child) => CircleAvatar(
                                backgroundColor: Colors.blueGrey,
                                radius: 25,
                                child: value == true
                                    ? const AdaptiveProgressIndicator()
                                    : const Icon(
                                        Icons.my_location_rounded,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              Positioned(
                bottom: 103,
                right: 0,
                left: 0,
                child: SafeArea(
                  child: Hero(
                    tag: Tags.btn,
                    child: OptionBtn(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      bgColor: Co.purple.withAlpha(20),
                      height: 60,
                      width: MediaQuery.sizeOf(context).width / 3,
                      onPressed: () {
                        widget.extra.onSubmit(context, initLocation.value!);
                      },
                      child: GradientText(
                        text: L10n.tr().setYourLocation,
                        style: TStyle.blackSemi(16),
                        gradient: Grad().textGradient,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
