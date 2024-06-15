import 'package:flutter/services.dart';

class KeyboardHelper {
  static const platform = MethodChannel('app_showkeyboard');

  static Future<void> showKeyboard() async {
    try {
      await platform.invokeMethod('showKeyboard');
    }  
    catch (e) {
      print("Failed to show keyboard: '${e.toString()}'.");
    }
  }
}