import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/orders/views/track_order_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

/// Widget to display delivery tracking map with route between user and delivery man
class DeliveryTrackingMapWidget extends StatefulWidget {
  const DeliveryTrackingMapWidget({
    super.key,
    this.orderId,
    this.deliveryTimeMinutes,
    this.userLocation,
    this.deliveryLocation,
    this.roadDistance,
    this.deliveryManName,
  });

  final int? orderId;
  final int? deliveryTimeMinutes;
  final LatLng? userLocation;
  final LatLng? deliveryLocation;
  final double? roadDistance; // in kilometers
  final String? deliveryManName;

  @override
  State<DeliveryTrackingMapWidget> createState() => _DeliveryTrackingMapWidgetState();
}

class _DeliveryTrackingMapWidgetState extends State<DeliveryTrackingMapWidget> {
  final Completer<GoogleMapController> _mapController = Completer();
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  // Static default coordinates (Cairo, Egypt area)
  static const LatLng _defaultUserLocation = LatLng(30.0444, 31.2357); // Cairo Downtown
  static const LatLng _defaultDeliveryLocation = LatLng(30.0811, 31.2487); // Abd al Moniem Riad Square area

  // Static data
  static const int _defaultEstimatedTime = 8; // minutes
  static const double _defaultRoadDistance = 1.5; // km

  late LatLng _userLocation;
  late LatLng _deliveryLocation;
  late int _estimatedTime;
  late double _roadDistance;

  @override
  void initState() {
    super.initState();
    _userLocation = widget.userLocation ?? _defaultUserLocation;
    _deliveryLocation = widget.deliveryLocation ?? _defaultDeliveryLocation;
    _estimatedTime = widget.deliveryTimeMinutes ?? _defaultEstimatedTime;
    _roadDistance = widget.roadDistance ?? _defaultRoadDistance;

    _setupMarkersAndPolyline();
  }

  void _setupMarkersAndPolyline() {
    // Add user location marker (purple)
    _markers.add(
      Marker(
        markerId: const MarkerId('user'),
        position: _userLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        infoWindow: const InfoWindow(title: 'Your Location'),
      ),
    );

    // Add delivery man location marker (orange)
    _markers.add(
      Marker(
        markerId: const MarkerId('delivery'),
        position: _deliveryLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(title: L10n.tr().deliveryMan),
      ),
    );

    // Create polyline between the two points
    _polylines.add(
      Polyline(
        polylineId: const PolylineId('route'),
        points: [_userLocation, _deliveryLocation],
        color: Co.purple,
        width: 4,
        patterns: [PatternItem.dot, PatternItem.gap(10)],
      ),
    );
  }

  Future<void> _animateToFitMarkers() async {
    final controller = await _mapController.future;

    // Calculate bounds to fit both markers
    final bounds = LatLngBounds(
      southwest: LatLng(
        _userLocation.latitude < _deliveryLocation.latitude ? _userLocation.latitude : _deliveryLocation.latitude,
        _userLocation.longitude < _deliveryLocation.longitude ? _userLocation.longitude : _deliveryLocation.longitude,
      ),
      northeast: LatLng(
        _userLocation.latitude > _deliveryLocation.latitude ? _userLocation.latitude : _deliveryLocation.latitude,
        _userLocation.longitude > _deliveryLocation.longitude ? _userLocation.longitude : _deliveryLocation.longitude,
      ),
    );

    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  String _formatArrivalTime() {
    if (_estimatedTime == 0) return '--';
    final arrivalDateTime = DateTime.now().add(Duration(minutes: _estimatedTime));
    return DateFormat('hh:mm a', L10n.isAr(context) ? 'ar' : 'en').format(arrivalDateTime);
  }

  @override
  void dispose() {
    _mapController.future.then((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Map snippet on the left
        Image.asset(Assets.trackMapIc),
        const HorizontalSpacing(16),
        // Text information on the right
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // View Delivery man on Map link
              InkWell(
                onTap: () {
                  if (widget.orderId != null && widget.orderId! > 0) {
                    // Navigate to full-screen track order screen
                    context.push(
                      TrackOrderScreen.route,
                      extra: {
                        'orderId': widget.orderId!,
                        'deliveryTimeMinutes': _estimatedTime,
                        'userLocation': _userLocation,
                        'deliveryLocation': _deliveryLocation,
                        'roadDistance': _roadDistance,
                        'deliveryManName': widget.deliveryManName,
                      },
                    );
                  }
                },
                child: Text(
                  L10n.tr().view_delivery_man_on_map,
                  style: context.style16400.copyWith(color: Co.purple, decoration: TextDecoration.underline, decorationColor: Co.purple),
                ),
              ),
              const VerticalSpacing(8),
              // Delivery arrival time
              Text('${L10n.tr().delivery_arrival_time} : ${_formatArrivalTime()}', style: context.style16400),
            ],
          ),
        ),
      ],
    );
  }
}
