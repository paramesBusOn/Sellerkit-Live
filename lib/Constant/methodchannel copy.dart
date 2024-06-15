// mobile_network_info.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

class MobileNetworkInfo {
  static const platform = MethodChannel('your_channel_name');

  Future<String?> getMobileNetworkName() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      try {
        return await platform.invokeMethod('getMobileNetworkName');
      } on PlatformException {
        return null;
      }
    } else {
      return null;
    }
  }
}

class GetAppAvailabilityStatus {
  static MethodChannel _channel = MethodChannel('app_availability');

  static Future<bool> isAppInstalled(String packageName) async {
    try {
      final bool result =
          await _channel.invokeMethod('isAppInstalled', packageName);
      return result;
    } on PlatformException {
      return false;
    }
  }
  static Future<void> openAppInBackground() async {
    print('object11');
    try {
      await _channel.invokeMethod('openAppInBackground',{'packageName':'com.example.sellerkitcallerdashboard'});
    } on PlatformException catch (e) {
      print("Failed to open app in background: '${e.message}'.");
    }
  }

// static Future<void> isAppOpenBackground(String packageName) async {
  //   try {
  //     await _channel.invokeMethod('launchApp', {'packageName': packageName});
  //   } on PlatformException {
  //     print("Failed to launch app: ");
  //   }
  // }

  // static launchContacts() async {
  //   try {
  //     await _channel.invokeMethod('openCreateContact', {
  //       'name': 'parames',
  //       'phone': '1212121212',
  //     });
  //   } on PlatformException catch (e) {
  //     print("Failed to launch contacts: ${e.message}");
  //   }
  // }

  // if (call.method == "launchApp") {
  //     val packageName = call.argument<String>("packageName")
  //     if (packageName != null) {
  //         launchApp(packageName)
  //     } else {
  //         result.error("INVALID_ARGUMENT", "Package name is null", null)
  //     }
  // } else {
  //     result.notImplemented()
  // }
  // if (call.method == "openCreateContact") {
  //     val name = call.argument<String>("name")
  //     val phone = call.argument<String>("phone")
  //     openCreateContact(name!!, phone!!)
  //     result.success(true)
  // } else {
  //     result.notImplemented()
  // }
}
