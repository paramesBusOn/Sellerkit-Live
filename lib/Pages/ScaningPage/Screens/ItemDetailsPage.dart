// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({Key? key}) : super(key: key);

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(        drawerEnableOpenDragGesture: false,

         appBar: appbar("Scanning Details", scaffoldKey, theme, context),
        drawer: drawer3(context),
      body: Container(
        // child: WebView(
        //                         initialUrl: "https://www.codeseasy.com/",
        //                         javascriptMode: JavascriptMode.unrestricted,
        //                         // initialMediaPlaybackPolicy:
        //                         //     AutoMediaPlaybackPolicy
        //                         //         .require_user_action_for_all_media_types,
        //                         // onWebViewCreated: (controllerGloba) {
        //                         //   widget.pvdDSBD.controllerGlobal =
        //                         //       controllerGloba;
        //                         // },
        //                       ),
        
      ));
  }
}