import 'dart:async';

import 'package:flutter/material.dart';

class CustomKeyboardHandler {
  CustomKeyboardHandler._();

  static final StreamController<CustomKeyboardHandlerData> _streamController =
      StreamController<CustomKeyboardHandlerData>.broadcast();

  static Stream<CustomKeyboardHandlerData> get customKeyboardStream =>
      _streamController.stream;

  static void onFocusChangeHandler(
      CustomKeyboardHandlerData customKeyboardHandlerData) {
    _streamController.add(customKeyboardHandlerData);
  }
}

class CustomKeyboardHandlerData {
  bool isKeyboardShowing;
  TextEditingController controller;

  CustomKeyboardHandlerData({
    required this.isKeyboardShowing,
    required this.controller,
  });
}
