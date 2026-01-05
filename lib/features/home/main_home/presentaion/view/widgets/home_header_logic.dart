import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/utils/location_utils.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_bus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Business logic handler for home header location selection
class HomeHeaderLogic {
  /// Get cached location information
  /// Returns true if there's a default address or temporary location available
  static bool hasCachedLocation() {
    final hasDefaultAddress = Session().defaultAddress != null;
    final hasTmpLocation = Session().tmpLocation != null;
    return hasDefaultAddress || hasTmpLocation;
  }

  /// Handle address selection from saved addresses
  /// Returns true if successful, false otherwise
  static Future<bool> handleAddressSelection(BuildContext context, AddressEntity address, AddressesBus bus) async {
    try {
      final location = LatLng(address.lat, address.lng);
      // Get address description from coordinates
      final addressDescription = await LocationUtils.getAddressFromCoordinates(address.lat, address.lng);
      await LocationUtils.saveLocationToCache(location, addressDescription);
      await LocationUtils.saveLocationAndCallAPI(location);
      bus.setDefault(address.id);
      return true;
    } catch (e) {
      log('Error handling address selection: $e');
      return false;
    }
  }

  /// Handle current location selection
  /// Returns true if successful, false otherwise
  static Future<bool> handleCurrentLocationSelection(BuildContext context) async {
    try {
      final location = await LocationUtils.getCurrentLocation();
      if (location != null) {
        // Get address description from coordinates
        final addressDescription = await LocationUtils.getAddressFromCoordinates(location.latitude, location.longitude);
        await LocationUtils.saveLocationToCache(location, addressDescription);
        await LocationUtils.saveLocationAndCallAPI(location);
        return true;
      }
      return false;
    } catch (e) {
      log('Error handling current location selection: $e');
      return false;
    }
  }

  /// Handle sheet close - save location if one was selected
  /// Returns true if location was saved, false otherwise
  static Future<bool> handleSheetClose(BuildContext context, LatLng? selectedLocation) async {
    if (selectedLocation != null) {
      try {
        // Get address description if not already cached
        if (Session().tmpLocationDescription == null) {
          final addressDescription = await LocationUtils.getAddressFromCoordinates(selectedLocation.latitude, selectedLocation.longitude);
          await LocationUtils.saveLocationToCache(selectedLocation, addressDescription);
        }
        await LocationUtils.saveLocationAndCallAPI(selectedLocation);
        return true;
      } catch (e) {
        log('Error handling sheet close: $e');
        return false;
      }
    }
    return false;
  }
}
