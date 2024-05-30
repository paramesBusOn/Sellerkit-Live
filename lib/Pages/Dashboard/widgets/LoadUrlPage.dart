// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class LoadURLPage extends StatefulWidget {
//    LoadURLPage({Key? key, required this.urlls});
//     String urlls;
//   @override
//   State<LoadURLPage> createState() => _LoadURLPageState();
// }

// class _LoadURLPageState extends State<LoadURLPage> {
//   WebViewController? controllerGlobal;
//   @override
//   void initState() {
//   super.initState(); 
//  }
//   @override
//   Widget build(BuildContext context) {
//      final theme  = Theme.of(context);
//     return WillPopScope(
//       onWillPop: exitApp,
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           title:Center(child: Text("PurchaseOrder",
//           style:theme.textTheme.headline5?.copyWith(color: Colors.white) ,
//           ),)

//         ),
//          resizeToAvoidBottomInset: false,
//         body: SafeArea(
//           child: 
//           WebView(
//             allowsInlineMediaPlayback: true,
//            zoomEnabled: false,
//            initialUrl: widget.urlls,
//             javascriptMode: JavascriptMode.unrestricted,
//              onWebViewCreated: (controllerGloba) {
//                         controllerGlobal = controllerGloba;
//                       },
//          ),
//         )),
//     );
//   }

//     Future<bool> exitApp() async {
//   if (await controllerGlobal!.canGoBack()) {
//     print("onwill goback");
//     controllerGlobal!.goBack();
//     return Future.value(false);
//   } else {
//     print("onwill goback22222222");
//     return Future.value(true);
//   }
// }
// }