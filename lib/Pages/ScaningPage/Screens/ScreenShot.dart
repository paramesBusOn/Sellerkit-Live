// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import '../../../Constant/Screen.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';
import 'ItemDetailsPage.dart';
import 'QrScanPage.dart';

class ScanningPage extends StatefulWidget {
  ScanningPage({
    Key? key,
  }) : super(key: key);

  @override
  ScanningPageState createState() => ScanningPageState();
}

class ScanningPageState extends State<ScanningPage> {
  static String scannedData = '';

  @override
  void initState() {
    scannedData = '';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> onbackpress() {
    if (scannedData.isNotEmpty) {
      scannedData = '';
      setState(() {});
    } else {
      return Future.value(true);
    }
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        key: scaffoldKey,
        appBar: appbar("Scanning Page", scaffoldKey, theme, context),
        drawer: drawer3(context),
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            // Check if the user is swiping from left to right
            print(details.primaryDelta);
            if (details.primaryDelta! > ConstantValues.slidevalue!) {
              setState(() {
                Get.offAllNamed(ConstantRoutes.dashboard);
              });
            }
          },
          child: scannedData.isEmpty
              ? Center(
                  child: Center(
                  child: InkWell(
                    onTap: () {
                      Get.to(() => QRCamera())!.then((value) {
                        setState(() {
                          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDetailsPage()));
                        });
                      });
                    },
                    child: Container(
                      width: Screens.width(context) * 0.8,
                      height: Screens.bodyheight(context) * 0.7,
                      decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: theme.primaryColor.withOpacity(0.8),
                              width: 3),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 5)
                          ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              width: Screens.width(context),
                              height: Screens.bodyheight(context) * 0.1,
                              child: Text("Scan to view details",
                                  style: theme.textTheme.titleLarge!.copyWith(
                                    color: Colors.white,
                                  ))),
                          InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              width: Screens.width(context),
                              height: Screens.bodyheight(context) * 0.4,
                              //  color: Colors.red,
                              child: Center(
                                child: Icon(
                                  Icons.qr_code,
                                  size: Screens.bodyheight(context) * 0.35, //8
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: Screens.width(context),
                            height: Screens.bodyheight(context) * 0.07,
                            //  color: Colors.red,
                            child: Text(
                              "Click the icon to scan",
                              style: theme.textTheme.titleLarge!.copyWith(
                                color: Colors.white,
                                // fontSize: 30
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
              : Container(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context),
                  padding: EdgeInsets.symmetric(
                      horizontal: Screens.width(context) * 0.03,
                      vertical: Screens.bodyheight(context) * 0.02),
                  child: Column(
                    children: [Text(scannedData)],
                  ),
                ),
        ),
      ),
    );
  }
}
