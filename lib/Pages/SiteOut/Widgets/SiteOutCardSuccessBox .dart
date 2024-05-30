// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_string_interpolations, unused_import

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/SiteOutController/SiteOutController.dart';
import '../../../Constant/ConstantRoutes.dart';
import '../../../Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/OrderCheckListPost.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class SiteOutSuccessCard extends StatefulWidget {
  SiteOutSuccessCard({
    Key? key,
  }) : super(key: key);

  @override
  State<SiteOutSuccessCard> createState() => SiteOutSuccessCardState();
}

class SiteOutSuccessCardState extends State<SiteOutSuccessCard> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  //  String? mobileno;
  static String? mobileno;
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
      Get.offAllNamed(ConstantRoutes.dashboard);
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
          appBar: appbar("Site Check-Out", scaffoldKey, theme, context),
          drawer: drawer3(context),
          body: context.watch<SiteOutController>().isconvertload == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
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
                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: Screens.width(context) * 0.8,
                                    //   color: Colors.blue,
                                    child: Center(
                                        child: Text(
                                      "Site Checked-Out Successfully",
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.bodyText2
                                          ?.copyWith(color: theme.primaryColor),
                                    )),
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(),
                                      Container(
                                        width: Screens.width(context) * 0.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Create As Lead "),
                                            FlutterSwitch(
                                                showOnOff: true,
                                                width: 60,
                                                height: 25,
                                                activeText: "Yes",
                                                inactiveText: "No",
                                                activeColor: theme.primaryColor,
                                                value: context
                                                    .watch<SiteOutController>()
                                                    .valueLead,
                                                onToggle: (val) {
                                                  context
                                                      .read<SiteOutController>()
                                                      .checkboxselectLead(val,
                                                          mobileno.toString());
                                                  //  print(val);
                                                  // setState(() {
                                                  //   switched = val;
                                                  //   reqfinance = "Y";
                                                  // });
                                                })
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(),
                                      Container(
                                        width: Screens.width(context) * 0.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Create As Order "),
                                            FlutterSwitch(
                                                showOnOff: true,
                                                width: 60,
                                                height: 25,
                                                activeText: "Yes",
                                                inactiveText: "No",
                                                activeColor: theme.primaryColor,
                                                value: context
                                                    .watch<SiteOutController>()
                                                    .valueOrder,
                                                onToggle: (val) {
                                                  context
                                                      .read<SiteOutController>()
                                                      .checkboxselectOrder(val,
                                                          mobileno.toString());
                                                  //  print(val);
                                                  // setState(() {
                                                  //   switched = val;
                                                  //   reqfinance = "Y";
                                                  // });
                                                })
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(),
                                      Container(
                                        width: Screens.width(context) * 0.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Create As Collection "),
                                            FlutterSwitch(
                                                showOnOff: true,
                                                width: 60,
                                                height: 25,
                                                activeText: "Yes",
                                                inactiveText: "No",
                                                activeColor: theme.primaryColor,
                                                value: context
                                                    .watch<SiteOutController>()
                                                    .valuecollection,
                                                onToggle: (val) {
                                                  context
                                                      .read<SiteOutController>()
                                                      .checkboxselectCollection(val,
                                                          mobileno.toString());
                                                  //  print(val);
                                                  // setState(() {
                                                  //   switched = val;
                                                  //   reqfinance = "Y";
                                                  // });
                                                })
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.02,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     Container(),
                                  //     Container(
                                  //       width: Screens.width(context) * 0.5,
                                  //       child: Row(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceBetween,
                                  //         children: [
                                  //           Text("Create As Receipt"),
                                  //           FlutterSwitch(
                                  //               showOnOff: true,
                                  //               width: 60,
                                  //               height: 25,
                                  //               activeText: "Yes",
                                  //               inactiveText: "No",
                                  //               activeColor: theme.primaryColor,
                                  //               value: context
                                  //                   .watch<SiteOutController>()
                                  //                   .valueReceipt,
                                  //               onToggle: (val) {
                                  //                 context
                                  //                     .read<SiteOutController>()
                                  //                     .checkboxselectReceipt(
                                  //                         val);
                                  //                 //  print(val);
                                  //                 // setState(() {
                                  //                 //   switched = val;
                                  //                 //   reqfinance = "Y";
                                  //                 // });
                                  //               })
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // Container(
                                  //   width: Screens.width(context),
                                  //   alignment: Alignment.centerLeft,
                                  //   height: Screens.bodyheight(context) * 0.05,
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.center,
                                  //     children: [
                                  //       Container(
                                  //         width: Screens.width(context) * 0.05,
                                  //         // color: Colors.amber,
                                  //         child: Checkbox(
                                  //           value: context
                                  //               .read<SiteOutController>()
                                  //               .valueLead,
                                  //           onChanged: (value) {
                                  //             setState(() {
                                  //               context
                                  //                   .read<SiteOutController>()
                                  //                   .checkboxselectLead(value!);
                                  //               // context
                                  //               //     .read<SiteOutController>()
                                  //               //     .value = value;
                                  //             });
                                  //           },
                                  //         ),
                                  //       ),
                                  //       InkWell(
                                  //         onTap: () {
                                  //           context
                                  //               .read<SiteOutController>()
                                  //               .checkboxselectLead2();
                                  //         },
                                  //         child: Container(
                                  //           height:
                                  //               Screens.bodyheight(context) * 0.05,
                                  //           alignment: Alignment.centerLeft,
                                  //           child: Text(
                                  //             "  Create as Lead     ",
                                  //             style: TextStyle(
                                  //                 color: theme.primaryColor,
                                  //                 fontWeight: FontWeight.bold),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // Container(
                                  //   width: Screens.width(context),
                                  //   alignment: Alignment.centerLeft,
                                  //   height: Screens.bodyheight(context) * 0.05,
                                  //   child: Row(
                                  //     mainAxisAlignment: MainAxisAlignment.center,
                                  //     children: [
                                  //       Container(
                                  //         width: Screens.width(context) * 0.05,
                                  //         // color: Colors.amber,
                                  //         child: Checkbox(
                                  //           value: context
                                  //               .read<SiteOutController>()
                                  //               .valueReceipt,
                                  //           onChanged: (value) {
                                  //             setState(() {
                                  //               context
                                  //                   .read<SiteOutController>()
                                  //                   .checkboxselectReceipt(value!);
                                  //               // context
                                  //               //     .read<SiteOutController>()
                                  //               //     .value = value;
                                  //             });
                                  //           },
                                  //         ),
                                  //       ),
                                  //       InkWell(
                                  //         onTap: () {
                                  //           context
                                  //               .read<SiteOutController>()
                                  //               .checkboxselectReceipt2();
                                  //         },
                                  //         child: Container(
                                  //           height:
                                  //               Screens.bodyheight(context) * 0.05,
                                  //           alignment: Alignment.centerLeft,
                                  //           child: Text(
                                  //             "  Create as Receipt",
                                  //             style: TextStyle(
                                  //                 color: theme.primaryColor,
                                  //                 fontWeight: FontWeight.bold),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                              // SizedBox(
                              //   height: Screens.bodyheight(context) * 0.02,
                              // ),

                              // Container(
                              //   alignment: Alignment.center,
                              //   width: Screens.width(context) * 0.8,
                              //   //   color: Colors.blue,
                              //   child: Center(
                              //       child: Text(
                              //     "Site Check-Out #23212",
                              //     style: theme.textTheme.bodyText2,
                              //     textAlign: TextAlign.center,
                              //   )),
                              // ),
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
                              //     style: theme.textTheme.bodyText2,
                              //     textAlign: TextAlign.center,
                              //   )),
                              // ),
                              // SizedBox(
                              //   height: Screens.bodyheight(context) * 0.003,
                              // ),
                              // Container(
                              //   alignment: Alignment.center,
                              //   width: Screens.width(context) * 0.8,
                              //   //   color: Colors.blue,
                              //   child: Center(
                              //       child: Text(
                              //     "Card Amount Rs.${context.read<SettlementController>().totalCard()}",
                              //     style: theme.textTheme.bodyText2,
                              //     textAlign: TextAlign.center,
                              //   )),
                              // ),
                              // SizedBox(
                              //   height: Screens.bodyheight(context) * 0.003,
                              // ),
                              // Container(
                              //   alignment: Alignment.center,
                              //   width: Screens.width(context) * 0.8,
                              //   //   color: Colors.blue,
                              //   child: Center(
                              //       child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       InkWell(
                              //         onTap: () async {
                              //           // final pdfFile =
                              //           //     await PdfInvoiceApi.generate(context.read<NewCollectionContoller>().invoice!);

                              //           // PdfApi.openFile(
                              //           //     pdfFile);
                              //           //  File file = new File.fromUri(Uri.parse(pdfFile.toString()));

                              //           // PDFDocument doc =
                              //           //     await PDFDocument.fromFile(pdfFile);
                              //           // ShowPdfs.document = doc;
                              //           // context
                              //           //     .read<NewCollectionContoller>()
                              //           //     .pdfMethod();
                              //           reporttState.dasa=context.read<NewCollectionContoller>().invoice;
                              //           Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                   builder: (_) => reportt()));
                              //         },
                              //         child: Text(
                              //           "Print Receipt ",
                              //           style: theme.textTheme.bodyText2!.copyWith(
                              //               decoration: TextDecoration.underline),
                              //           textAlign: TextAlign.center,
                              //         ),
                              //       ),
                              //       // IconButton(
                              //       //     onPressed: () async {
                              //       //       // direc: /data/user/0/com.buson.crm/cache
                              //       //       // final tempDir =
                              //       //       //     await getTemporaryDirectory();
                              //       //       // print("direc: " +
                              //       //       //     tempDir.path.toString() +
                              //       //       //     '/$title-$docNO.pdf');
                              //       //       // paths.add(
                              //       //       //     '${tempDir.path}/$title-$docNO.pdf');
                              //       //       // await Share.shareFiles(paths);
                              //       //       // paths.clear();
                              //       //     },
                              //       //     icon: Icon(
                              //       //       Icons.share,
                              //       //       color: Colors.black,
                              //       //     ))
                              //     ],
                              //   )),
                              // ),

                              // SizedBox(
                              //   height: Screens.bodyheight(context) * 0.1,
                              // ),
                              //    Container(
                              //   alignment: Alignment.center,
                              //   width: Screens.width(context) * 0.8,
                              //    // color: Colors.blue,
                              //   child: Center(
                              //     child: Wrap(
                              //         spacing: 20.0, // width
                              //         runSpacing: 8.0, // height
                              //         children: listText(theme,
                              //          getsuccessRes!.documentdata!)),
                              //   )
                              // ),
                              // SizedBox(
                              //   height: Screens.bodyheight(context) * 0.03,
                              // ),
                              //  Container(
                              //   alignment: Alignment.center,
                              //   width: Screens.width(context) * 0.8,
                              //   //   color: Colors.blue,
                              //   child: Center(
                              //       child: Text(
                              //     "Delivery Date "+config.alignDate(getsuccessRes!.U_sk_NextFollowDt!).toString(),
                              //     style: theme.textTheme.bodyText2,
                              //     textAlign: TextAlign.center,
                              //   )),
                              // ),
                              // SizedBox(
                              //   height: Screens.bodyheight(context) * 0.01,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     Container(),
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
                              //   ],
                              // ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     Container(),
                              //     Container(
                              //       child: Row(
                              //         children: [
                              //           Text("Set Reminder: "),
                              //           FlutterSwitch(
                              //               showOnOff: true,
                              //               width: 60,
                              //               height: 25,
                              //               activeText: "On",
                              //               inactiveText: "Off",
                              //               activeColor: theme.primaryColor,
                              //               value: context
                              //                   .watch<SiteOutController>()
                              //                   .remswitch,
                              //               onToggle: (val) {
                              //                 context
                              //                     .read<SiteOutController>()
                              //                     .switchremainder(val,
                              //                         "Remainder for Lead Next followup on${config.alignDate(getsuccessRes!.leaddetail![0].U_sk_NextFollowDt!)} for ${getsuccessRes!.leaddetail![0].CardName}");
                              //                 //  print(val);
                              //                 // setState(() {
                              //                 //   switched = val;
                              //                 //   reqfinance = "Y";
                              //                 // });
                              //               })
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.05,
                              ),

                              Container(
                                width: Screens.width(context),
                                height: Screens.bodyheight(context) * 0.06,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.offAllNamed(ConstantRoutes.dashboard);
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
              textAlign: TextAlign.center, style: theme.textTheme.bodyText2)),
    );
  }
}
