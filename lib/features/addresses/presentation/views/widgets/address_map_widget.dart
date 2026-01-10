import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/features/auth/common/widgets/select_location_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressMapWidget extends StatefulWidget {
  const AddressMapWidget({super.key, this.location, required this.onChangeLocation});
  final LatLng? location;
  final Function(LatLng) onChangeLocation;
  @override
  State<AddressMapWidget> createState() => _AddressMapWidgetState();
}

class _AddressMapWidgetState extends State<AddressMapWidget> {
  Completer<GoogleMapController> smallMapcont = Completer();
  final markers = <Marker>{};

  Future<void> moveCamera(LatLng newLoc) async {
    markers.clear();
    markers.add(Marker(markerId: const MarkerId('1'), position: newLoc));
    final GoogleMapController controller = await smallMapcont.future;
    try {
      await controller.moveCamera(CameraUpdate.newLatLng(newLoc));
    } catch (e) {
      //
    }
  }

  LatLng? selectedLocation;
  @override
  void initState() {
    if (widget.location != null) {
      selectedLocation = widget.location;
      markers.add(Marker(markerId: const MarkerId('1'), position: selectedLocation!));
    }
    super.initState();
  }

  @override
  void dispose() {
    smallMapcont.future.then((value) => value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await SelectLocationRoute((initLocation: selectedLocation, onSubmit: (ctx, latlng) => ctx.pop(latlng))).push<LatLng>(context);
        if (result != null) {
          widget.onChangeLocation(result);

          setState(() => selectedLocation = result);
          await moveCamera(result);
        }
      },
      child: Container(
        constraints: const BoxConstraints(maxHeight: 200, minHeight: 150),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: AppConst.defaultBorderRadius,
          image: selectedLocation != null
              ? null
              : const DecorationImage(
                  image: AssetImage(Assets.assetsPngMap),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black26, BlendMode.srcOver),
                ),
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: AppConst.defaultBorderRadius,
          border: Border.all(color: Colors.black45),
        ),
        child: selectedLocation == null
            ? Center(
                child: Text(L10n.tr().selectLocation, style: context.style16500.copyWith(fontWeight: TStyle.bold)),
              )
            : AbsorbPointer(
                child: GoogleMap(
                  onMapCreated: (controller) {
                    if (smallMapcont.isCompleted) return;
                    smallMapcont.complete(controller);
                  },
                  initialCameraPosition: CameraPosition(target: selectedLocation!, zoom: 13),
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  mapToolbarEnabled: false,
                  tiltGesturesEnabled: false,
                  zoomGesturesEnabled: false,
                  rotateGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  myLocationButtonEnabled: false,
                  markers: markers,
                ),
              ),
      ),
    );
  }
}
