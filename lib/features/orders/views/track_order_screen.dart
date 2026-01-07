import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/features/supportScreen/presentation/views/order_issue_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/presentation/extensions/color.dart';

/// Full screen for tracking order delivery with Google Map
class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({
    super.key,
    required this.orderId,
    this.deliveryTimeMinutes,
    this.userLocation,
    this.deliveryLocation,
    this.roadDistance,
    this.deliveryManName,
  });

  final int orderId;
  final int? deliveryTimeMinutes;
  final LatLng? userLocation;
  final LatLng? deliveryLocation;
  final double? roadDistance; // in kilometers
  final String? deliveryManName;

  static const route = '/track-order';

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  // Static default coordinates (Cairo, Egypt area)
  static const LatLng _defaultUserLocation = LatLng(30.0444, 31.2357); // Cairo Downtown
  static const LatLng _defaultDeliveryLocation = LatLng(30.0811, 31.21007); // Abd al Moniem Riad Square area

  // Static data
  static const int _defaultEstimatedTime = 8; // minutes
  static const double _defaultRoadDistance = 1.5; // km
  static const String _defaultDeliveryManName = 'Ahmed Ali';

  late LatLng _userLocation;
  late LatLng _deliveryLocation;
  late int _estimatedTime;
  late double _roadDistance;
  late String _deliveryManName;

  @override
  void initState() {
    super.initState();
    _userLocation = widget.userLocation ?? _defaultUserLocation;
    _deliveryLocation = widget.deliveryLocation ?? _defaultDeliveryLocation;
    _estimatedTime = widget.deliveryTimeMinutes ?? _defaultEstimatedTime;
    _roadDistance = widget.roadDistance ?? _defaultRoadDistance;
    _deliveryManName = widget.deliveryManName ?? _defaultDeliveryManName;

    // Setup markers asynchronously
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupMarkersAndPolyline().then((_) {
        if (mounted) {
          setState(() {}); // Update UI after markers are created
        }
      });
    });
  }

  Future<void> _setupMarkersAndPolyline() async {
    // Create custom markers - simplified approach using asset images
    BitmapDescriptor? userPinIcon;
    BitmapDescriptor? deliveryPinIcon;

    try {
      // Try to load custom marker icons from assets
      // Note: For SVG assets, you may need to convert them to PNG first
      userPinIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(100, 100)),
        Assets.userPinIc, // Try PNG version
      );
    } catch (e) {
      debugPrint('Could not load user pin icon: $e');
      userPinIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet);
    }

    try {
      deliveryPinIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(100, 100)),
        Assets.deliveryPinIc, // Try PNG version
      );
    } catch (e) {
      debugPrint('Could not load delivery pin icon: $e');
      deliveryPinIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    }

    // Add user location marker with custom pin
    _markers.add(
      Marker(
        markerId: const MarkerId('user'),
        position: _userLocation,
        icon: userPinIcon,
        infoWindow: const InfoWindow(title: 'Your Location'),
      ),
    );

    // Add delivery man location marker with custom pin
    _markers.add(
      Marker(
        markerId: const MarkerId('delivery'),
        position: _deliveryLocation,
        icon: deliveryPinIcon,
        infoWindow: InfoWindow(title: L10n.tr().deliveryMan),
      ),
    );

    // Fetch route from Google Directions API to follow roads
    final routePoints = await _getRoutePoints(_userLocation, _deliveryLocation);

    // Create polyline with route points (follows roads)
    _polylines.add(
      Polyline(
        polylineId: const PolylineId('route'),
        points: routePoints,
        color: Co.purple,
        width: 5,
        geodesic: true,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
      ),
    );
  }

  /// Fetch route points from Google Directions API
  Future<List<LatLng>> _getRoutePoints(LatLng origin, LatLng destination) async {
    try {
      // TODO: Replace with your Google Maps API key
      const apiKey = 'AIzaSyCaCSJ0BZItSyXqBv8vpD1N4WBffJeKhLQ';

      final url =
          'https://maps.googleapis.com/maps/api/directions/json?'
          'origin=${origin.latitude},${origin.longitude}'
          '&destination=${destination.latitude},${destination.longitude}'
          '&key=$apiKey';

      // For now, return a straight line as fallback
      // You'll need to add http package and implement the actual API call
      debugPrint('TODO: Implement Google Directions API call to: $url');

      // Temporary: Create a curved line by adding intermediate points
      return _createCurvedRoute(origin, destination);
    } catch (e) {
      debugPrint('Error fetching route: $e');
      return [origin, destination]; // Fallback to straight line
    }
  }

  /// Creates a simple curved route with intermediate points
  /// This is a temporary solution until Google Directions API is integrated
  List<LatLng> _createCurvedRoute(LatLng start, LatLng end) {
    final points = <LatLng>[];
    const steps = 20; // Number of intermediate points

    for (int i = 0; i <= steps; i++) {
      final t = i / steps;

      // Linear interpolation for lat/lng
      final lat = start.latitude + (end.latitude - start.latitude) * t;
      final lng = start.longitude + (end.longitude - start.longitude) * t;

      // Add slight curve offset (perpendicular to the line)
      const curveFactor = 0.002; // Adjust for more/less curve
      final offset = curveFactor * (4 * t * (1 - t)); // Parabolic curve

      final latOffset = -(end.longitude - start.longitude) * offset;
      final lngOffset = (end.latitude - start.latitude) * offset;

      points.add(LatLng(lat + latOffset, lng + lngOffset));
    }

    return points;
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

    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
  }

  String _formatTimeRange() {
    if (_estimatedTime < 5) {
      return '5 - 10 ${L10n.tr().min}';
    }
    final minTime = _estimatedTime;
    final maxTime = _estimatedTime + 10;
    return '$minTime - $maxTime ${L10n.tr().min}';
  }

  @override
  void dispose() {
    _mapController.future.then((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Co.bg,
      appBar: MainAppBar(title: L10n.tr().trackOrder),
      body: Column(
        children: [
          // Map section - takes most of the screen
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    if (_mapController.isCompleted) return;
                    _mapController.complete(controller);
                    // Animate to fit markers after a short delay
                    Future.delayed(const Duration(milliseconds: 500), () {
                      _animateToFitMarkers();
                    });
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      (_userLocation.latitude + _deliveryLocation.latitude) / 2,
                      (_userLocation.longitude + _deliveryLocation.longitude) / 2,
                    ),
                    zoom: 13,
                  ),
                  markers: _markers,
                  polylines: _polylines,
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  mapToolbarEnabled: false,
                  myLocationButtonEnabled: false,
                  tiltGesturesEnabled: false,
                ),
                // Bottom info card with distance coordinates
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: Colors.lightBlue.withOpacityNew(0.9), borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      '${_userLocation.latitude.toStringAsFixed(2)} × ${_userLocation.longitude.toStringAsFixed(2)}',
                      style: TStyle.robotBlackThin().copyWith(color: Co.white, fontWeight: TStyle.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom information section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Co.bg,
              boxShadow: [BoxShadow(color: Colors.black.withOpacityNew(0.1), blurRadius: 4, offset: const Offset(0, -2))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Estimated Time and Road Distance
                Wrap(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${L10n.tr().estimated_delivery_time}: ${_formatTimeRange()}', style: TStyle.robotBlackRegular()),
                    Text('${L10n.tr().road_distance}: ${_roadDistance.toStringAsFixed(2)} Km', style: TStyle.robotBlackRegular()),
                  ],
                ),
                const VerticalSpacing(16),
                // Delivery Man Information
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Co.lightPurple),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(L10n.tr().your_delivery_man, style: TStyle.robotBlackRegular().copyWith(color: Co.darkGrey)),
                            const VerticalSpacing(4),
                            Text(_deliveryManName, style: TStyle.robotBlackMedium()),
                          ],
                        ),
                      ),
                      // Chat button (yellow)
                      // Container(
                      //   width: 40,
                      //   height: 40,
                      //   decoration: const BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
                      //   child: IconButton(
                      //     icon: const VectorGraphicsWidget(Assets.assetsSvgMessage),
                      //     onPressed: () {
                      //       // TODO: Implement chat functionality
                      //       Alerts.showToast('Chat with delivery man', error: false);
                      //     },
                      //     padding: EdgeInsets.zero,
                      //   ),
                      // ),
                      // const HorizontalSpacing(12),
                      // Phone button (purple)
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(color: Co.purple, shape: BoxShape.circle),
                        child: IconButton(
                          icon: const VectorGraphicsWidget(Assets.phoneIc, colorFilter: ColorFilter.mode(Co.white, BlendMode.srcIn)),
                          onPressed: () {
                            // TODO: Implement call functionality
                            Alerts.showToast('Call delivery man', error: false);
                          },
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalSpacing(16),
                // Get Help button
                MainBtn(
                  onPressed: () {
                    context.navigateToPage(OrderIssueScreen(orderId: widget.orderId));
                  },
                  width: double.infinity,
                  bgColor: Co.purple,
                  radius: 30,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const VectorGraphicsWidget(Assets.customerSupportIc),
                      const HorizontalSpacing(10),
                      Text(L10n.tr().getHelp, style: TStyle.robotBlackMedium().copyWith(color: Co.white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
