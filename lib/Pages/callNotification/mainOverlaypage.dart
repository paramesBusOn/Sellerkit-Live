// import 'dart:isolate';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:system_alert_window/system_alert_window.dart';

// class mainoverlayApp extends StatefulWidget {
//   @override
//   _mainoverlayAppState createState() => _mainoverlayAppState();
// }

// class _mainoverlayAppState extends State<mainoverlayApp> {
//   String _platformVersion = 'Unknown';
//   bool _isShowingWindow = false;
//   bool _isUpdatedWindow = false;
//   SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;
//   static const String _mainAppPort = 'MainApp';
//   final _receivePort = ReceivePort();
//   SendPort? homePort;
//   String? latestMessageFromOverlay;

//   @override
//   void initState() {
//     super.initState();
//     _initPlatformState();
//     _requestPermissions();
//     if (homePort != null) return;
//     IsolateNameServer.registerPortWithName(
//       _receivePort.sendPort,
//       _mainAppPort,
//     );
//     _receivePort.listen((message) {});
//     _showOverlayWindow();
//   }

//   @override
//   void dispose() {
//     SystemAlertWindow.removeOnClickListener();
//     super.dispose();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> _initPlatformState() async {
//     await SystemAlertWindow.enableLogs(true);
//     String? platformVersion;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       platformVersion = await SystemAlertWindow.platformVersion;
//     } on PlatformException {
//       platformVersion = 'Failed to get platform version.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//     if (platformVersion != null)
//       setState(() {
//         _platformVersion = platformVersion!;
//       });
//   }

//   Future<void> _requestPermissions() async {
//     await SystemAlertWindow.requestPermissions(prefMode: prefMode);
//   }

//   void _showOverlayWindow() async {
//     // if (!_isShowingWindow) {
//     await SystemAlertWindow.sendMessageToOverlay('show system window');
//     SystemAlertWindow.showSystemWindow(
//       height: 400,
//       width: 400,
//       gravity: SystemWindowGravity.BOTTOM,
//       prefMode: prefMode,
//     );
//     setState(() {
//       _isShowingWindow = true;
//     });
//     // } else if (!_isUpdatedWindow) {
//     //   await SystemAlertWindow.sendMessageToOverlay('update system window');
//     //   SystemAlertWindow.updateSystemWindow(
//     //       height: 400,
//     //       width: MediaQuery.of(context).size.width.floor(),
//     //       gravity: SystemWindowGravity.BOTTOM,
//     //       prefMode: prefMode,
//     //       isDisableClicks: true);
//     //   setState(() {
//     //     _isUpdatedWindow = true;
//     //     SystemAlertWindow.sendMessageToOverlay(_isUpdatedWindow);
//     //   });
//     // } else {
//     //   setState(() {
//     //     _isShowingWindow = false;
//     //     _isUpdatedWindow = false;
//     //     SystemAlertWindow.sendMessageToOverlay(_isUpdatedWindow);
//     //   });
//     //   SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(
//         body: SizedBox(
//           height: double.infinity,
//           width: double.infinity,
//           child: Center(
//             child: CircularProgressIndicator(),
//           ),
//         ),
//       ),
//     );
//   }
// }
