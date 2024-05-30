// ignore_for_file: unused_import, implementation_imports, unnecessary_string_interpolations, prefer_const_constructors, use_key_in_widget_constructors, must_call_super

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import '../../../Controller/DayStartEndController/DayStartEndController.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../Constant/ConstantRoutes.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Widgets/SucessDialagBox.dart';

class DayEndPage extends StatefulWidget {
  const DayEndPage({Key? key});

  @override
  State<DayEndPage> createState() => DayEndPageState();
}

class DayEndPageState extends State<DayEndPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  static double? lati1;
  static double? lang2;
   late Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<DayStartEndController>().clearAll();
        context.read<DayStartEndController>().determinePosition(context);
       _timer = Timer.periodic(Duration(seconds: 1),
            (Timer t) => context.read<DayStartEndController>().getTime());
        // context.watch<DayStartEndController>().config.currenttime();
      });
    });
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(lati1!, lang2!),
    zoom: 19.95,
  );

  static final _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(lati1!, lang2!),
      tilt: 59.440717697143555,
      zoom: 16.151926040649414);
  @override
  void dispose() {
    // Ensure you cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.toNamed(ConstantRoutes.dashboard);
      return Future.value(true);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(        drawerEnableOpenDragGesture: false,

        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        drawer: drawer3(context),
        appBar: appbar("Day End", scaffoldKey,theme, context),
        body: SingleChildScrollView(
          child: GestureDetector(onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.dashboard);
                      });
                    }
                  },
            child: Column(
              children: [
                Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: theme.primaryColor.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(8)),
                          width: Screens.width(context),
                          height: Screens.bodyheight(context) * 0.62,
                          padding: EdgeInsets.symmetric(
                              horizontal: Screens.width(context) * 0.015,
                              vertical: Screens.bodyheight(context) * 0.005),
                          child: lati1 == null&&lang2==null
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : GoogleMap(
                                  mapType: MapType.normal,
                                  myLocationEnabled : true,
                                  initialCameraPosition:_kGooglePlex,
                                  onMapCreated: (GoogleMapController controller) {
                                   _controller.complete(controller);
                                  },
                                ),
                        ),
                       
                       
                      ],
                    )),
                Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: theme.primaryColor.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(8)),
                        width: Screens.width(context),
                        // height: Screens.bodyheight(context) * 0.17,
                        padding: EdgeInsets.symmetric(
                            horizontal: Screens.width(context) * 0.015,
                            vertical: Screens.bodyheight(context) * 0.005),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Screens.width(context) * 0.45,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.2,
                                        child: Text(
                                          "Latitude ",
                                          style:
                                              theme.textTheme.bodyText1?.copyWith(),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: Screens.width(context) * 0.25,
                                        child: Text(
                                          "${context.watch<DayStartEndController>().latitude}",
                                          style:
                                              theme.textTheme.bodyText1?.copyWith(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: Screens.width(context) * 0.45,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: Screens.width(context) * 0.2,
                                            child: Text(
                                              "Longitude",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(),
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            width: Screens.width(context) * 0.25,
                                            child: Text(
                                              "${context.watch<DayStartEndController>().langitude}",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Container(
                              width: Screens.width(context) * 0.95,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text(
                                    "Address",
                                    style: theme.textTheme.labelLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  )),
                                  Container(
                                      width: Screens.width(context) * 0.9,
                                      child: context
                                                  .watch<DayStartEndController>()
                                                  .adrress ==
                                              null
                                          ? Text("")
                                          : Text(
                                              "${context.watch<DayStartEndController>().adrress}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 5,
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(),
                                            )),
                                  // Container(
                                  //     child: Text(
                                  //   "Coimbatore",
                                  //   style: theme.textTheme.bodyText1?.copyWith(),
                                  // )),
                                  // Container(
                                  //     child: Text(
                                  //   "620006",
                                  //   style: theme.textTheme.bodyText1?.copyWith(),
                                  // )),
                                ],
                              ),
                            )
                          ],
                        ))),
                Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: theme.primaryColor.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(8)),
                        width: Screens.width(context),
                        height: Screens.bodyheight(context) * 0.08,
                        padding: EdgeInsets.symmetric(
                            horizontal: Screens.width(context) * 0.015,
                            vertical: Screens.bodyheight(context) * 0.005),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Screens.width(context) * 0.4,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${context.watch<DayStartEndController>().config.alignDate(context.watch<DayStartEndController>().config.currentDate())}",
                                    style: theme.textTheme.titleLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // Container(
                                //   width: Screens.width(context) * 0.2,
                                //   child: Text(
                                //     "Time",
                                //     style: theme.textTheme.titleLarge
                                //         ?.copyWith(
                                //             fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: Screens.width(context) * 0.45,
                                  child: Text(
                                    // currentTimeInSeconds
                                    context
                                        .watch<DayStartEndController>()
                                        .timeString
                                        .toString(),
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ))),
                Container(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context) * 0.077,
                  padding: EdgeInsets.symmetric(
                      horizontal: Screens.width(context) * 0.015,
                      vertical: Screens.bodyheight(context) * 0.005),
                  child: ElevatedButton(
                      onPressed: () {
                          Get.toNamed(ConstantRoutes.cameraPage);
                       
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Day End')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
