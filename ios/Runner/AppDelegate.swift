import Flutter
import UIKit
import GoogleMaps
import CoreTelephony

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let CHANNEL = "com.gazzer/device_state"
  
  override func application(_ application: UIApplication,
  didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyCaCSJ0BZItSyXqBv8vpD1N4WBffJeKhLQ")
    GeneratedPluginRegistrant.register(with: self)

      guard let controller = window ?.rootViewController as ?FlutterViewController else {
          return super.application(application, didFinishLaunchingWithOptions: launchOptions)
      }
    let deviceStateChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)

    deviceStateChannel.setMethodCallHandler {
      [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
      switch call.method {
      case "isAirplaneModeOn":
        // iOS doesn’t allow checking airplane mode directly
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

  private func hasSimCard() -> Bool {
    // Example implementation – you can customize as needed
    // iOS doesn’t expose direct API to check for SIM card presence,
    // but you can check carrier info:
      if let carrier = CTTelephonyNetworkInfo().serviceSubscriberCellularProviders ?.first ?.value {
      return carrier.mobileNetworkCode != nil && carrier.mobileNetworkCode != ""
    }
    return false
  }
}
