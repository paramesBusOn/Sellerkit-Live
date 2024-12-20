// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Constant/constant_routes.dart';
import '../../../Controller/SettlementController/settlement_controller.dart';
import '../../../Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/OrderCheckListPost.dart';
import '../../../Models/SettlementModel/SettlementPostModel.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';
import 'SettlementPdf.dart';
import 'SettlementPdfHelper.dart';

class SettlementSuccessUPI extends StatefulWidget {
  SettlementSuccessUPI({super.key, required this.settlemaster});
  // final String? paymode;
  // final double? amount;
  SettlementPostData? settlemaster;
  @override
  State<SettlementSuccessUPI> createState() => SettlementSuccessUPIState();
}

class SettlementSuccessUPIState extends State<SettlementSuccessUPI> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   print("data doccc: "+ context.read<LeadNewController>().getsuccessRes.DocNo.toString());
    });
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("object");
      Get.offAllNamed(ConstantRoutes.newcustomerReg);
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
          // backgroundColor: Colors.grey[200],
          /// resizeToAvoidBottomInset: true,
          key: scaffoldKey,
          appBar: appbar("New Settlement", scaffoldKey, theme, context),
          drawer: drawer3(context),
          body: Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("Assets/newleadsucess.png"),
                    fit: BoxFit.cover)),
            child: Stack(
              children: [
                Positioned(
                  top: Screens.bodyheight(context) * 0.3,
                  child: Container(
                    alignment: Alignment.center,
                    width: Screens.width(context),
                    height: Screens.bodyheight(context) * 0.6,
                    //color: Colors.red,
                    padding: EdgeInsets.only(
                      left: Screens.width(context) * 0.1,
                      right: Screens.width(context) * 0.1,
                      // top: Screens.bodyheight(context)*0.02,
                      // bottom: Screens.bodyheight(context)*0.02
                    ),

                    // margin: EdgeInsets.symmetric(
                    //   horizontal:  Screens.width(context)*0.1,
                    //   // left: Screens.width(context)*0.1,
                    //   // right: Screens.width(context)*0.1,
                    //     ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: Screens.width(context) * 0.8,
                          //   color: Colors.blue,
                          child: Center(
                              child: Text(
                            "Settlement Created Successfully",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                          )),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.02,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: Screens.width(context) * 0.8,
                          //   color: Colors.blue,
                          child: Center(
                              child: Text(
                            "Settlement Receipt #${widget.settlemaster!.DocNum}",
                            style: theme.textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          )),
                        ),
                        // SizedBox(
                        //   height: Screens.bodyheight(context) * 0.003,
                        // ),
                        // Container(
                        //   alignment: Alignment.center,
                        //   width: Screens.width(context) * 0.8,
                        //   //   color: Colors.blue,
                        //   child: Center(
                        //       child: Text(
                        //     "${context.read<NewCollectionContoller>().mycontroller[1].text.toString()}",
                        //     style: theme.textTheme.bodyMedium,
                        //     textAlign: TextAlign.center,
                        //   )),
                        // ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.003,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: Screens.width(context) * 0.8,
                          //   color: Colors.blue,
                          child: Center(
                              child: Text(
                            "UPI Amount Rs.${widget.settlemaster!.Amount.toStringAsFixed(2)}",
                            style: theme.textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          )),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.003,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(),
                            // Container(
                            //   child: Row(
                            //     children: [
                            //       Text("Set Remainder For Delivery: "),
                            //        FlutterSwitch(
                            //         showOnOff: true,
                            //         width: 60,
                            //         height: 25,
                            //         activeText: "On",
                            //         inactiveText: "Off",
                            //         activeColor: theme.primaryColor,
                            //         value: context.watch<LeadNewController>().remswitch,
                            //         onToggle: (val) {
                            //           context.read<LeadNewController>().switchremainder(val);
                            //           //  print(val);
                            //           // setState(() {
                            //           //   switched = val;
                            //           //   reqfinance = "Y";
                            //           // });
                            //         })
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                          SizedBox(
                          height: Screens.bodyheight(context) * 0.05,
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              SettlementPdfHelper.setDocfNum =
                                 widget.settlemaster!.DocNum.toString();

                              SettlementPdfHelper.frmAddressmodeldata = context
                                  .read<SettlementController>()
                                  .frmAddmodeldata;

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SettlementPdf()));
                            },
                            child: Text(
                              "Convert as Pdf",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                      
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.05,
                        ),

                        Container(
                          width: Screens.width(context),
                          height: Screens.bodyheight(context) * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.offAllNamed(ConstantRoutes.settlement);
                            },
                            child: Text("Done"),
                            // style: Elev,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  List<Widget> listText(ThemeData theme, List<DocumentLines> data) {
    return List.generate(
      data.length,
      (index) => Container(
          width: Screens.width(context),
          child: Text(data[index].ItemDescription.toString(),
              textAlign: TextAlign.center, style: theme.textTheme.bodyMedium)),
    );
  }
}
