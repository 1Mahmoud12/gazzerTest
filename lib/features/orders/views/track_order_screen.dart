import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/features/supportScreen/presentation/views/order_issue_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  static const LatLng _defaultDeliveryLocation = LatLng(30.0811, 31.2487); // Abd al Moniem Riad Square area

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
    // Create custom markers from SVG assets
    final userPinIcon = await _createCustomMarker(Assets.userPinIc);
    final deliveryPinIcon = await _createCustomMarker(Assets.deliveryPinIc);

    // Add user location marker with custom pin
    _markers.add(
      Marker(
        markerId: const MarkerId('user'),
        position: _userLocation,
        icon: userPinIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        infoWindow: const InfoWindow(title: 'Your Location'),
      ),
    );

    // Add delivery man location marker with custom pin
    _markers.add(
      Marker(
        markerId: const MarkerId('delivery'),
        position: _deliveryLocation,
        icon: deliveryPinIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
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

  /// Helper function to convert SVG asset to BitmapDescriptor for custom marker
  Future<BitmapDescriptor?> _createCustomMarker(String assetPath) async {
    try {
      // Create a widget to render
      final widget = VectorGraphicsWidget(assetPath, width: 48, height: 48);

      // Use a GlobalKey to capture the rendered widget
      final key = GlobalKey();
      final repaintBoundary = RepaintBoundary(key: key, child: widget);

      // Create an offscreen widget tree
      final offscreenWidget = Directionality(textDirection: TextDirection.ltr, child: repaintBoundary);

      // Build the widget tree
      final buildOwner = BuildOwner();
      final pipelineOwner = PipelineOwner();
      final rootElement = offscreenWidget.createElement();
      rootElement.mount(null, null);
      buildOwner.buildScope(rootElement);
      pipelineOwner.rootNode = rootElement.renderObject as RenderObject;
      pipelineOwner.flushLayout();
      pipelineOwner.flushCompositingBits();
      pipelineOwner.flushPaint();

      // Wait a bit for rendering to complete
      await Future.delayed(const Duration(milliseconds: 50));

      // Get the render object and convert to image
      final renderObject = key.currentContext?.findRenderObject();
      if (renderObject is RenderRepaintBoundary) {
        final image = await renderObject.toImage(pixelRatio: 2.0);
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

        rootElement.unmount();
        image.dispose();

        if (byteData != null) {
          return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
        }
      }

      rootElement.unmount();
      return null;
    } catch (e) {
      debugPrint('Error creating custom marker: $e');
      return null;
    }
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
                      style: TStyle.whiteBold(12),
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Co.purple100),
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
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
                        child: IconButton(
                          icon: const VectorGraphicsWidget(Assets.assetsSvgMessage),
                          onPressed: () {
                            // TODO: Implement chat functionality
                            Alerts.showToast('Chat with delivery man', error: false);
                          },
                          padding: EdgeInsets.zero,
                        ),
                      ),
                      const HorizontalSpacing(12),
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
                      Text(L10n.tr().getHelp, style: TStyle.whiteBold(16)),
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
