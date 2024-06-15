import 'package:flutter/services.dart';

class CallLogService {
  static const MethodChannel _channel = MethodChannel('call_log_channel');

  static Future<dynamic> getCallLog() async {
    try {
      final dynamic result = await _channel.invokeMethod('getCallLog');

      if (result is List<dynamic>) {
        // Return the list if the result is of the correct type
        return result;
      } else {
        // Return an empty list or handle the error case appropriately
        return [];
      }
    } on PlatformException catch (e) {
      // Handle platform exception
      return [];
    }
  }
}

class YourPluginName {
  static const MethodChannel _channel = const MethodChannel('your_plugin_name');

  static Future<List<dynamic>> getCallLogDetails() async {
    try {
      final List<dynamic> result =
          await _channel.invokeMethod('getCallLogDetails');
      return result;
    } on PlatformException catch (e) {
      return [];
    }
  }
}
