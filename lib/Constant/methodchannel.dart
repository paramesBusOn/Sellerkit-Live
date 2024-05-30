// mobile_network_info.dart
import 'package:flutter/services.dart';

class MobileNetworkInfo {
  static const platform = MethodChannel('your_channel_name');
  static const MethodChannel _channel =
      const MethodChannel('mobile_signal_strength');

  Future<String?> getMobileNetworkName() async {
    try {
      return await platform.invokeMethod('getMobileNetworkName');
    } on PlatformException catch (e) {
      print("Failed to get mobile network name: ${e.message}");
      return null;
    }
  }

  Future<String?> getMobileNetworkStrength() async {
    try {
      return await _channel.invokeMethod('getSignalStrength');
    } on PlatformException catch (e) {
      print("Failed to get mobile network name: ${e.message}");
      return null;
    }
  }
}
