// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:phone_state/phone_state.dart';
// import 'package:sellerkit/Constant/Helper.dart';
// import 'package:sellerkit/Constant/Utils.dart';
// import 'package:sellerkit/Pages/callNotification/custom_overlay.dart';
// import 'package:sellerkit/Pages/callNotification/widgets/alert_dialog_service.dart';
// import 'package:sellerkit/Pages/callerNotification/custom_overlayNew.dart';
// const String STOP_MONITORING_SERVICE_KEY = "stop";
// const String SET_APPS_NAME_FOR_MONITORING_KEY = "setAppsNames";
// const String APP_NAMES_LIST_KEY = "appNames";

// // Entry Point for Monitoring Isolate
// @pragma('vm:entry-point')
// onMonitoringServiceStart(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Map<String, ApplicationData> monitoredApplicationSet = {};
// //
//   // Stop this background service
//   // _registerListener(service);
//   // Timer.periodic(const Duration(seconds: 1), (timer) async {
//   // isolatemethod();
//   // });
//   // Map<String, UsageInfo> previousUsageSession =
//   //     await getCurrentUsageStats(monitoredApplicationSet);
//   _startTimer();
// }

// PhoneState status = PhoneState.nothing();

// Future<void> _startTimer() async {
//   int count = 0;
//   // Timer.periodic(const Duration(seconds: 1), (timer) async {
//   //   timer.cancel();

//   PhoneState.stream.listen((event) async {
//     // if (event != null) {
//     status = event;
//     if (status.status == PhoneStateStatus.CALL_ENDED) {
//       await Future.delayed(const Duration(seconds: 2));
//       String? getUrl = await HelperFunctions.getHostDSP();
//       Utils.queryApi = 'http://${getUrl.toString()}/api/';
//       String? token = await HelperFunctions.getTokenSharedPreference();
//       Utils.token=token;
//       CustomOverlayNewState.getUrl = Utils.queryApi;
//       CustomOverlayNewState.token = Utils.token!;
//       AlertDialogService.createAlertDialog().then((value) => count++);
//       CustomOverlayState.callented = true;
//       event.status = PhoneStateStatus.NOTHING;
//     } else {
//       count = 0;
//     }
//     // }
//   });

//   // _startTimer();
//   // });
// }

// // _setMonitoringApplicationsSet(
// //     Map<String, ApplicationData> monitoredApplicationSet) {
// //   monitoredApplicationSet.clear();
// // }

// _registerListener(ServiceInstance service) {
//   // Platform messages are asynchronous, so we initialize in an async method.

//   service.on(STOP_MONITORING_SERVICE_KEY).listen((event) {
//     service.stopSelf();
//   });
// }
