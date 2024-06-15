// import 'dart:ui';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter_overlay_window/flutter_overlay_window.dart';
// import 'package:system_alert_window/system_alert_window.dart';

// class AlertDialogUtils {
//   static Future<void> showDialog() async {
//     await SystemAlertWindow.sendMessageToOverlay('show system window');
//     FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
//     Size size = view.physicalSize;
//     double width = size.width;
//     // double height = size.height;

//     // await FlutterOverlayWindow.showOverlay(overlayTitle: "");
//     await SystemAlertWindow.showSystemWindow(
//         height: 400,
//         width: width.toInt(),
//         gravity: SystemWindowGravity.BOTTOM,
//         prefMode: SystemWindowPrefMode.OVERLAY,
//         // isDisableClicks: true,
//         );
//   }

//   static Future<void> closeAlertDialog() async {
//     await SystemAlertWindow.closeSystemWindow();
//     // await FlutterOverlayWindow.closeOverlay();
//   }

//   static getOverlayPermission() async {
//     bool status = await FlutterOverlayWindow.isPermissionGranted();
//     if (!status) {
//       await FlutterOverlayWindow.requestPermission();
//     }
//   }
// }
