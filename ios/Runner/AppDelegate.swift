import Flutter
import UIKit
import GoogleMaps
import CoreTelephony

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let CHANNEL = "com.gazzer/device_state"
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyCaCSJ0BZItSyXqBv8vpD1N4WBffJeKhLQ")
    GeneratedPluginRegistrant.register(with: self)

    // Setup platform channel for device state checks
    let controller = window ?.rootViewController as !FlutterViewController
    let deviceStateChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)

    deviceStateChannel.setMethodCallHandler {
      [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
      switch call.method {
      case "isAirplaneModeOn":
        // iOS doesn't provide a direct API to check airplane mode
        // Return false as a fallback since connectivity_plus handles this
        result(false)
      case "hasSimCard":
        let hasSim = self ?.hasSimCard() ?? true
        result(hasSim)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  /// Check if device has a SIM card (iOS)

  private func hasSimCard() -> Bool {
    let networkInfo = CTTelephonyNetworkInfo()

    // For iOS 12+
    if #available (iOS 12.0, *) {
      guard let carriers = networkInfo.serviceSubscriberCellularProviders else {
        return false
      }
      // If there's at least one carrier, there's a SIM card
      return !carriers.isEmpty
    } else {
      // For older iOS versions
      if let carrier = networkInfo.subscriberCellularProvider {
        // Check if carrier has a mobile network code (which means SIM is present)
        return carrier.mobileNetworkCode != nil
      }
      return false
    }
  }
}
