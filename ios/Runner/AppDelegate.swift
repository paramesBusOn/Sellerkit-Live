import UIKit
import Flutter
import FirebaseCore
import GoogleMaps
import CoreTelephony
// import flutter_background_service_ios

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // SwiftFlutterBackgroundServicePlugin.taskIdentifier = "your.custom.task.identifier"
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyAdvVumVzr7teF3UDRchglwonf_vjvXtZo")

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "your_channel_name", binaryMessenger: controller.binaryMessenger)

    channel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "getSwiftVariable" {
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.subscriberCellularProvider

        // Get carrier name
          let carrierName = carrier?.carrierName
        let swiftVariable = carrierName
        result(swiftVariable)
      } else {
        result(FlutterMethodNotImplemented)
      }
    })


    GeneratedPluginRegistrant.register(with: self)
    if #available(iOS 10.0, *) {
  UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
}
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
