import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/di.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceUUid {
  Future<String> getUniqueDeviceId() async {
    String uniqueDeviceId = '';

    const uuid = Uuid();
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfo.iosInfo;
      uniqueDeviceId = '${iosDeviceInfo.name}:${iosDeviceInfo.identifierForVendor}'; // unique ID on iOS
    } else if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      uniqueDeviceId = '${androidDeviceInfo.model}:${androidDeviceInfo.id}'; // unique ID on Android
    }

    if (uniqueDeviceId.isEmpty) {
      // Try to get from SharedPreferences
      final prefs = di<SharedPreferences>();
      uniqueDeviceId = prefs.getString(StorageKeys.deviceId) ?? '';

      if (uniqueDeviceId.isEmpty) {
        // Generate new UUID and save it
        uniqueDeviceId = uuid.v4();
        await prefs.setString(StorageKeys.deviceId, uniqueDeviceId);
      }
    } else {
      // Save the device ID to SharedPreferences for future use
      final prefs = di<SharedPreferences>();
      await prefs.setString(StorageKeys.deviceId, uniqueDeviceId);
    }

    return uniqueDeviceId;
  }
}
