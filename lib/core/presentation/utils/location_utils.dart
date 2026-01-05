import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/features/auth/common/widgets/select_location_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Utility class for location-related operations
class LocationUtils {
  /// Get address string from coordinates using reverse geocoding
  /// Returns a formatted address string or coordinates as fallback
  static Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        // Build address string from placemark components
        final addressParts = <String>[];
        // if (place.street != null && place.street!.isNotEmpty) {
        //   addressParts.add(place.street!);
        // }
        if (place.subThoroughfare != null && place.subThoroughfare!.isNotEmpty) {
          addressParts.add(place.subThoroughfare!);
        }
        if (place.thoroughfare != null && place.thoroughfare!.isNotEmpty) {
          addressParts.add(place.thoroughfare!);
        }
        if (place.locality != null && place.locality!.isNotEmpty) {
          addressParts.add(place.locality!);
        }
        if (place.subAdministrativeArea != null && place.subAdministrativeArea!.isNotEmpty) {
          addressParts.add(place.subAdministrativeArea!);
        }
        if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
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

  /// Get current location with permission handling
  /// Returns LatLng if successful, null otherwise
  static Future<LatLng?> getCurrentLocation() async {
    try {
      if (!await checkLocationServiceEnabled()) {
        return null;
      }

      final permission = await requestLocationPermission();
      if (permission == null) {
        return null;
      }

      return await fetchCurrentPosition();
    } catch (e) {
      Alerts.showToast('${L10n.tr().errorGettingCurrentLocation}: $e');
      return null;
    }
  }

  /// Check if location services are enabled
  /// Shows toast if disabled
  static Future<bool> checkLocationServiceEnabled() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Alerts.showToast(L10n.tr().locationServicesDisabled);
    }
    return serviceEnabled;
  }

  /// Request location permission
  /// Returns LocationPermission if granted, null otherwise
  static Future<LocationPermission?> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      animationDialogLoading();
      permission = await Geolocator.requestPermission();
      closeDialog();

      if (permission == LocationPermission.denied) {
        Alerts.showToast(L10n.tr().locationPermissionsDenied);
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Alerts.showToast(L10n.tr().locationPermissionsPermanentlyDenied);
      return null;
    }

    return permission;
  }

  /// Fetch current position
  /// Returns LatLng if successful, throws exception otherwise
  static Future<LatLng?> fetchCurrentPosition() async {
    animationDialogLoading();
    try {
      final Position position = await Geolocator.getCurrentPosition();
      closeDialog();
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      closeDialog();
      rethrow;
    }
  }

  /// Show map location picker screen
  /// Returns selected LatLng or null if cancelled
  static Future<LatLng?> showMapLocationPicker(BuildContext context) async {
    // Use the existing SelectLocationScreen
    // NOTE: To add validation on map move, modify SelectLocationScreen's onCameraMove callback
    // to call the validation API. Example:
    // onCameraMove: (position) {
    //   initLocation.value = position.target;
    //   // Call validation API here:
    //   // final apiClient = di<ApiClient>();
    //   // apiClient.post(
    //   //   endpoint: '/location/validate',
    //   //   requestBody: {'lat': position.target.latitude, 'lng': position.target.longitude},
    //   // );
    // }

    final result = await SelectLocationRoute((
      initLocation: Session().tmpLocation,
      onSubmit: (ctx, latlng) {
        ctx.pop(latlng);
      },
    )).push<LatLng>(context);

    return result;
  }

  /// Save location and its description to cache (SharedPreferences and Session)
  static Future<void> saveLocationToCache(LatLng location, String addressDescription) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('selected_lat', location.latitude);
      await prefs.setDouble('selected_lng', location.longitude);
      await prefs.setString('selected_location_description', addressDescription);
      // Also save to Session
      Session().tmpLocation = location;
      Session().tmpLocationDescription = addressDescription;
    } catch (e) {
      log('Error saving location to cache: $e');
    }
  }

  /// GET location and its description to cache (SharedPreferences and Session)
  static Future<void> getLocationToCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      LatLng? location = const LatLng(0, 0);
      final double? lat = prefs.getDouble('selected_lat');
      final double? long = prefs.getDouble('selected_lng');
      if (lat == null || long == null) {
        return;
      }
      location = LatLng(lat, long);
      final addressDescription = await LocationUtils.getAddressFromCoordinates(location.latitude, location.longitude);
      await prefs.setString('selected_location_description', addressDescription);
      // Also save to Session
      Session().tmpLocation = location;
      Session().tmpLocationDescription = addressDescription;
    } catch (e) {
      log('Error saving location to cache: $e');
    }
  }

  /// Handle map location selection
  /// Returns true if successful, false otherwise
  static Future<bool> handleMapLocationSelection(BuildContext context) async {
    try {
      final result = await LocationUtils.showMapLocationPicker(context);
      if (result != null) {
        // Get address description from coordinates
        final addressDescription = await getAddressFromCoordinates(result.latitude, result.longitude);
        await saveLocationToCache(result, addressDescription);
        await saveLocationAndCallAPI(result);
        return true;
      }
      return false;
    } catch (e) {
      log('Error handling map location selection: $e');
      return false;
    }
  }

  /// Call API to update user location
  /// TODO: Replace with actual API endpoint
  static Future<void> saveLocationAndCallAPI(LatLng location) async {
    try {
      // TODO: Replace with actual API endpoint
      // This is called when dialog closes with a selected location
      // final apiClient = di<ApiClient>();
      // await apiClient.post(
      //   endpoint: '/location/update', // Replace with actual endpoint
      //   requestBody: {
      //     'lat': location.latitude,
      //     'lng': location.longitude,
      //   },
      // );

      // Placeholder for API call
      log('Calling API with lat: ${location.latitude}, lng: ${location.longitude}');
    } catch (e) {
      log('Error calling location API: $e');
    }
  }
}
