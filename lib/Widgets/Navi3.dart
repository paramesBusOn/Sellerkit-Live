// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, unused_local_variable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Controller/SiteOutController/SiteOutController.dart';
import 'package:sellerkit/Services/DayStartEndApi/DaycheckAPi.dart';
import 'package:sellerkit/Widgets/IconContainer.dart';
import 'package:sellerkit/Widgets/IconContainer2.dart';
// import 'package:sellerkit/Widgets/IconContainer.dart';
// import 'package:sellerkit/Widgets/IconContainer2.dart';
import '../Constant/AppConstant.dart';
import '../Constant/ConstantSapValues.dart';
import '../Constant/MenuAuth.dart';
import '../Constant/Screen.dart';
import '../Controller/DashBoardController/DashBoardController.dart';
// import 'IconContainer.dart';

Container drawer3(BuildContext context) {
  // final height = MediaQuery.of(context).size.height;
  // final width = MediaQuery.of(context).size.width;
  final theme = Theme.of(context);
  return Container(
    width: Screens.width(context),
    child: Drawer(
        child: ListView(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              vertical: Screens.fullHeight(context) * 0.02,
              horizontal: Screens.width(context) * 0.02),
          width: Screens.width(context),
          height: Screens.fullHeight(context),
          // color: theme.primaryColor,
          color: Colors.grey[200],
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: Screens.fullHeight(context) * 0.01,
                  ),

                  InkWell(
                    onTap: () {
                      log("MenuAuthDetail.Dashboard ${MenuAuthDetail.Dashboard}");
                      // if (MenuAuthDetail.Dashboard == "Y") {
                      // Navigator.pop(context);
                      DashBoardController.isLogout = false;
                      Get.offAllNamed(ConstantRoutes.dashboard);
                      // } else {
                      //   showDialog(
                      //       context: context,
                      //       barrierDismissible: true,
                      //       builder: (BuildContext context) {
                      //         return AlertDialog(
                      //             shape: RoundedRectangleBorder(
                      //                 borderRadius:
                      //                     BorderRadius.all(Radius.circular(4))),
                      //             contentPadding: EdgeInsets.all(0),
                      //             insetPadding: EdgeInsets.all(
                      //                 Screens.bodyheight(context) * 0.02),
                      //             content: settings(context));
                      //       });
                      // }
                    },
                    child: Container(
                      width: Screens.width(context),
                      // height: Screens.fullHeight(context)*0.3,
                      //Colors.white,//Colors.amber,
                      padding: EdgeInsets.symmetric(
                          vertical: Screens.fullHeight(context) * 0.02,
                          horizontal: Screens.width(context) * 0.04),
                      decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.center,
                      child: Center(
                        child: Row(
                          children: [
                            Container(
                              width: Screens.width(context) * 0.4,
                              child: Icon(Icons.home),
                              alignment: Alignment.centerRight,
                              // height: Screens.fullHeight(context)*0.3,
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.004,
                            ),
                            Container(
                              width: Screens.width(context) * 0.4,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Dashboard",
                                style: theme.textTheme.bodyLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: Screens.fullHeight(context) * 0.01,
                  ),

                  //Pre Sales
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      width: Screens.width(context),
                      // height: Screens.fullHeight(context)*0.3,
                      //Colors.amber,
                      padding: EdgeInsets.symmetric(
                          vertical: Screens.fullHeight(context) * 0.02,
                          horizontal: Screens.width(context) * 0.04),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Pre Sales",
                              style: theme.textTheme.headline6
                                  ?.copyWith(color: theme.primaryColor),
                            ),
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  if (MenuAuthDetail.Enquiries == "Y") {
                                    Navigator.pop(context);

                                    // if (ConstantValues.sapUserType.toLowerCase() == 'manager') {
                                    // Get.toNamed(ConstantRoutes.enquiriesManager);
                                    // log(ConstantValues.sapUserType);
                                    // Get.offAllNamed(
                                    //     ConstantRoutes.enquiriesManager);
                                    //   } else {
                                    Get.offAllNamed(
                                        ConstantRoutes.enquiriesUser);
                                    //     // Get.toNamed(ConstantRoutes.enquiriesUser);
                                    //   }
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.perm_phone_msg,
                                iconColor: theme.primaryColor, // Colors.green,
                                title: 'Enquiries',
                              ),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  print("Lead Menu::" +
                                      MenuAuthDetail.Leads.toString());
                                  if (MenuAuthDetail.Leads == "Y") {
                                    //ch
                                    Navigator.pop(context);
                                    Get.offAllNamed(ConstantRoutes.leadstab);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.checklist,
                                iconColor: theme.primaryColor, //Colors.orange,
                                title: 'Leads',
                              ),
                              IconContainer(
                                theme: theme,
                                callback:
                                    // (){},
                                    () {
                                  Get.offAllNamed(ConstantRoutes.quotespage);
                                  //Navigator.push(context, MaterialPageRoute(builder:(_)=>NewLeadFrom()));
                                },
                                icon: Icons.assignment,
                                iconColor: theme.primaryColor, //.pink,
                                title: 'Quotes',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  if (MenuAuthDetail.Leads == "Y") {
                                    //ch
                                    Navigator.pop(context);
                                    Get.offAllNamed(ConstantRoutes.ordertab);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }

                                  //Navigator.push(context, MaterialPageRoute(builder:(_)=>NewLeadFrom()));
                                },
                                icon: Icons.handshake,
                                iconColor: theme.primaryColor, //.pink,
                                title: 'Orders',
                              ),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  //
                                  if (MenuAuthDetail.Followup == "Y") {
                                    Navigator.pop(context);
                                    Get.toNamed(ConstantRoutes.followupTab);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.hourglass_empty,
                                iconColor: theme.primaryColor, //Colors.amber,
                                title: 'Follow up',
                              ),

                              InkWell(
                                onTap: () {
                                  if (MenuAuthDetail.Walkins == "Y") {
                                    Navigator.pop(context);
                                    Get.toNamed(ConstantRoutes.walkins);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  width: Screens.width(context) * 0.25,
                                  height: Screens.fullHeight(context) * 0.11,
                                  decoration: BoxDecoration(
                                      //   color: Colors.red[200],
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.26,
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: Screens.width(context) *
                                                  0.108,
                                              // padding: EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: theme.primaryColor
                                                      .withOpacity(
                                                          0.2), //,Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: IconButton(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                onPressed: () {
                                                  if (MenuAuthDetail.Walkins ==
                                                      "Y") {
                                                    Navigator.pop(context);
                                                    Get.toNamed(
                                                        ConstantRoutes.walkins);
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        barrierDismissible:
                                                            true,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              4))),
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(0),
                                                              insetPadding:
                                                                  EdgeInsets.all(
                                                                      Screens.bodyheight(
                                                                              context) *
                                                                          0.02),
                                                              content: settings(
                                                                  context));
                                                        });
                                                  }
                                                },
                                                icon: FaIcon(FontAwesomeIcons
                                                    .users), // Icons.home,
                                                color: theme
                                                    .primaryColor, //Colors.red,//Colors.white,
                                                iconSize: Screens.padingHeight(
                                                        context) *
                                                    0.03,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.26,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Walkins",
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                                  color: theme.primaryColor,

                                                  //color:Colors.red,//Colors.white,//
                                                  fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // IconContainer(
                              //   theme: theme,
                              //   callback: () {
                              //     if (MenuAuthDetail.Walkins == "Y") {
                              //       Navigator.pop(context);
                              //       Get.toNamed(ConstantRoutes.walkins);
                              //     } else {
                              //       showDialog(
                              //           context: context,
                              //           barrierDismissible: true,
                              //           builder: (BuildContext context) {
                              //             return AlertDialog(
                              //                 shape: RoundedRectangleBorder(
                              //                     borderRadius:
                              //                         BorderRadius.all(
                              //                             Radius.circular(4))),
                              //                 contentPadding: EdgeInsets.all(0),
                              //                 insetPadding: EdgeInsets.all(
                              //                     Screens.bodyheight(context) *
                              //                         0.02),
                              //                 content: settings(context));
                              //           });
                              //     }
                              //   },
                              //   icon: Icons.wysiwyg,
                              //   iconColor: theme.primaryColor, //Colors.blue,
                              //   title: 'Walkins',
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: Screens.width(context) * 0.02,
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (MenuAuthDetail.Leads == "Y") {
                                      Navigator.pop(context);
                                      Get.toNamed(ConstantRoutes.openLeadPage);
                                    } else {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4))),
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                insetPadding: EdgeInsets.all(
                                                    Screens.bodyheight(
                                                            context) *
                                                        0.02),
                                                content: settings(context));
                                          });
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    width: Screens.width(context) * 0.25,
                                    height: Screens.fullHeight(context) * 0.11,
                                    decoration: BoxDecoration(
                                        //   color: Colors.red[200],
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          width: Screens.width(context) * 0.26,
                                          alignment: Alignment.center,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: Screens.width(context) *
                                                    0.108,
                                                // padding: EdgeInsets.all(5),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: theme.primaryColor
                                                        .withOpacity(
                                                            0.2), //,Colors.amber,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: IconButton(
                                                  alignment: Alignment.center,
                                                  onPressed: () {
                                                    if (MenuAuthDetail.Leads ==
                                                        "Y") {
                                                      Navigator.pop(context);
                                                      Get.toNamed(ConstantRoutes
                                                          .openLeadPage);
                                                    } else {
                                                      showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              true,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(
                                                                            4))),
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                                insetPadding:
                                                                    EdgeInsets.all(
                                                                        Screens.bodyheight(context) *
                                                                            0.02),
                                                                content: settings(
                                                                    context));
                                                          });
                                                    }
                                                  },
                                                  icon: FaIcon(FontAwesomeIcons
                                                      .funnelDollar), // Icons.home,
                                                  color: theme
                                                      .primaryColor, //Colors.red,//Colors.white,
                                                  iconSize:
                                                      Screens.padingHeight(
                                                              context) *
                                                          0.03,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: Screens.width(context) * 0.26,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Open Lead",
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.bodyText1
                                                ?.copyWith(
                                                    color: theme.primaryColor,

                                                    //color:Colors.red,//Colors.white,//
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // IconContainer(
                                //   theme: theme,
                                //   callback: () {
                                //     if (MenuAuthDetail.Leads == "Y") {
                                //       Navigator.pop(context);
                                //       Get.toNamed(ConstantRoutes.openLeadPage);
                                //     } else {
                                //       showDialog(
                                //           context: context,
                                //           barrierDismissible: true,
                                //           builder: (BuildContext context) {
                                //             return AlertDialog(
                                //                 shape: RoundedRectangleBorder(
                                //                     borderRadius:
                                //                         BorderRadius.all(
                                //                             Radius.circular(
                                //                                 4))),
                                //                 contentPadding:
                                //                     EdgeInsets.all(0),
                                //                 insetPadding: EdgeInsets.all(
                                //                     Screens.bodyheight(
                                //                             context) *
                                //                         0.02),
                                //                 content: settings(context));
                                //           });
                                //     }
                                //   },
                                //   icon: Icons.open_in_browser_sharp,
                                //   iconColor:
                                //       theme.primaryColor, // Colors.green,
                                //   title: 'Open Lead',
                                // ),
                                SizedBox(
                                  width: Screens.width(context) * 0.02,
                                ),
                                IconContainer(
                                  theme: theme,
                                  callback: () {
                                    // if (MenuAuthDetail.Accounts == "Y") {
                                    //   Navigator.pop(context);
                                    //   Get.toNamed(ConstantRoutes.scanQrcode);
                                    // } else {
                                    //   showDialog(
                                    //       context: context,
                                    //       barrierDismissible: true,
                                    //       builder: (BuildContext context) {
                                    //         return AlertDialog(
                                    //             shape: RoundedRectangleBorder(
                                    //                 borderRadius:
                                    //                     BorderRadius.all(
                                    //                         Radius.circular(
                                    //                             4))),
                                    //             contentPadding:
                                    //                 EdgeInsets.all(0),
                                    //             insetPadding: EdgeInsets.all(
                                    //                 Screens.bodyheight(
                                    //                         context) *
                                    //                     0.02),
                                    //             content: settings(context));
                                    //       });
                                    // }
                                  },
                                  icon: Icons.qr_code_2_outlined,
                                  iconColor: Colors.grey,
                                  title: 'Scan QrCode',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: Screens.fullHeight(context) * 0.01,
                  ),
                  //Resource
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      width: Screens.width(context),
                      // height: Screens.fullHeight(context)*0.3,

                      padding: EdgeInsets.symmetric(
                          vertical: Screens.fullHeight(context) * 0.02,
                          horizontal: Screens.width(context) * 0.04),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Resource",
                              style: theme.textTheme.headline6
                                  ?.copyWith(color: theme.primaryColor),
                            ),
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconContainer(
                                  theme: theme,
                                  callback: () {
                                    if (MenuAuthDetail.Stocks == "Y") {
                                      //ch
                                      Navigator.pop(context);
                                      Get.toNamed(ConstantRoutes.stock);
                                    } else {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                4))),
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                insetPadding: EdgeInsets.all(
                                                    Screens.bodyheight(
                                                            context) *
                                                        0.02),
                                                content: settings(context));
                                          });
                                    }
                                  },
                                  icon: Icons.warehouse,
                                  iconColor:
                                      theme.primaryColor, // Colors.green,
                                  title: 'Stocks'),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  if (MenuAuthDetail.PriceList == "Y") {
                                    Navigator.pop(context);
                                    Get.toNamed(ConstantRoutes.priceList);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.currency_rupee,
                                iconColor: theme.primaryColor, //Colors.blue,
                                title: 'Price List',
                              ),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  if (MenuAuthDetail.OfferZone == "Y") {
                                    //ch ! replace =
                                    Navigator.pop(context);
                                    Get.toNamed(ConstantRoutes.offerZone);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.redeem_rounded,
                                iconColor: theme.primaryColor, //Colors.orange,
                                title: 'Offer Zone',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: Screens.width(context) * 0.02),
                            child: Row(
                              children: [
                                //                          InkWell(
                                //   onTap: () {
                                //                                 // if (MenuAuthDetail.OfferZone == "Y") {
                                //                                   //ch ! replace =
                                //                                   Navigator.pop(context);
                                //                                   Get.toNamed(ConstantRoutes.specialpricereq);
                                //                                 // } else {
                                //                                 //   showDialog(
                                //                                 //       context: context,
                                //                                 //       barrierDismissible: true,
                                //                                 //       builder: (BuildContext context) {
                                //                                 //         return AlertDialog(
                                //                                 //             shape: RoundedRectangleBorder(
                                //                                 //                 borderRadius:
                                //                                 //                     BorderRadius.all(
                                //                                 //                         Radius.circular(4))),
                                //                                 //             contentPadding: EdgeInsets.all(0),
                                //                                 //             insetPadding: EdgeInsets.all(
                                //                                 //                 Screens.bodyheight(context) *
                                //                                 //                     0.02),
                                //                                 //             content: settings(context));
                                //                                 //       });
                                //                                 // }
                                //                               },
                                //   child: Container(
                                //     alignment: Alignment.bottomCenter,
                                //     width: Screens.width(context)*0.25,
                                //     height: Screens.fullHeight(context)*0.11,
                                //     decoration: BoxDecoration(
                                //                  //   color: Colors.red[200],
                                //       borderRadius: BorderRadius.circular(8)
                                //     ),
                                //     child: Column(
                                //       mainAxisAlignment:   MainAxisAlignment.spaceAround,
                                //       children: [
                                //         Container(
                                //           width: Screens.width(context) * 0.26,
                                //           alignment: Alignment.center,

                                //           child: Column(
                                //             children: [
                                //               Container(
                                //                   width: Screens.width(context) * 0.108,
                                //                   // padding: EdgeInsets.all(5),
                                //                   alignment: Alignment.center,
                                //                   decoration: BoxDecoration(
                                //                     color: theme.primaryColor.withOpacity(0.2),//,Colors.amber,
                                //                     borderRadius: BorderRadius.circular(10)
                                //                   ),
                                //                 child: IconButton(
                                //                   alignment: Alignment.bottomCenter,
                                //                   onPressed: () {
                                //                                 // if (MenuAuthDetail.OfferZone == "Y") {
                                //                                   //ch ! replace =
                                //                                   Navigator.pop(context);
                                //                                   Get.toNamed(ConstantRoutes.specialpricereq);
                                //                                 // } else {
                                //                                 //   showDialog(
                                //                                 //       context: context,
                                //                                 //       barrierDismissible: true,
                                //                                 //       builder: (BuildContext context) {
                                //                                 //         return AlertDialog(
                                //                                 //             shape: RoundedRectangleBorder(
                                //                                 //                 borderRadius:
                                //                                 //                     BorderRadius.all(
                                //                                 //                         Radius.circular(4))),
                                //                                 //             contentPadding: EdgeInsets.all(0),
                                //                                 //             insetPadding: EdgeInsets.all(
                                //                                 //                 Screens.bodyheight(context) *
                                //                                 //                     0.02),
                                //                                 //             content: settings(context));
                                //                                 //       });
                                //                                 // }
                                //                               },
                                //                  icon: FaIcon(FontAwesomeIcons.user),// Icons.home,
                                //                   color: theme.primaryColor,//Colors.red,//Colors.white,
                                //                   iconSize: Screens.padingHeight(context) * 0.03,
                                //                 ),
                                //               ),

                                //             ],
                                //           ),
                                //         ),
                                //                Container(
                                //                     width: Screens.width(context) * 0.26,
                                //                     alignment: Alignment.center,
                                //                   child: Text(
                                //                     "Special Price Request",textAlign: TextAlign.center,
                                //                     style: theme.textTheme.bodyText1?.copyWith(
                                //                        color: theme.primaryColor,

                                //                        //color:Colors.red,//Colors.white,//
                                //                         fontWeight: FontWeight.w400),
                                //                   ),
                                //                 ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                IconContainer(
                                  theme: theme,
                                  callback: () {
                                    // if (MenuAuthDetail.OfferZone == "Y") {
                                    //ch ! replace =
                                    Navigator.pop(context);
                                    Get.offAllNamed(ConstantRoutes.specialpricereq);
                                    // } else {
                                    //   showDialog(
                                    //       context: context,
                                    //       barrierDismissible: true,
                                    //       builder: (BuildContext context) {
                                    //         return AlertDialog(
                                    //             shape: RoundedRectangleBorder(
                                    //                 borderRadius:
                                    //                     BorderRadius.all(
                                    //                         Radius.circular(4))),
                                    //             contentPadding: EdgeInsets.all(0),
                                    //             insetPadding: EdgeInsets.all(
                                    //                 Screens.bodyheight(context) *
                                    //                     0.02),
                                    //             content: settings(context));
                                    //       });
                                    // }
                                  },
                                  icon: Icons.receipt,
                                  iconColor:
                                      theme.primaryColor, //Colors.orange,
                                  title: 'Special Price Request',
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Screens.fullHeight(context) * 0.01,
                  ),
                  //Accounts
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      width: Screens.width(context),
                      padding: EdgeInsets.symmetric(
                          vertical: Screens.fullHeight(context) * 0.01,
                          horizontal: Screens.width(context) * 0.04),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "  Accounts",
                              style: theme.textTheme.headline6
                                  ?.copyWith(color: theme.primaryColor),
                            ),
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  if (MenuAuthDetail.Accounts == "Y") {
                                    //ch
                                    Navigator.pop(context);
                                    Get.offAllNamed(ConstantRoutes.accounts);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.contact_page,
                                iconColor: theme.primaryColor,
                                title: 'Accounts',
                              ),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  if (MenuAuthDetail.Accounts == "Y") {
                                    // ch
                                    Navigator.pop(context);
                                    Get.offAllNamed(ConstantRoutes.outstanding);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.pending_actions_outlined,
                                iconColor: theme.primaryColor,
                                title: 'Outstanding',
                              ),
                              IconContainer2(
                                theme: theme,
                                callback: () {
                                  // Get.toNamed(ConstantRoutes.collectionlist);
                                  // if (MenuAuthDetail.Collection == "Y") {
                                  Navigator.pop(context);
                                  Get.offAllNamed(
                                      ConstantRoutes.collectionlist);
                                  // } else {
                                  //   showDialog(
                                  //       context: context,
                                  //       barrierDismissible: true,
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //             shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.all(
                                  //                         Radius.circular(4))),
                                  //             contentPadding: EdgeInsets.all(0),
                                  //             insetPadding: EdgeInsets.all(
                                  //                 Screens.bodyheight(context) *
                                  //                     0.02),
                                  //             content: settings(context));
                                  //       });
                                  // }
                                },
                                icon: Icons.attach_money,
                                iconColor: theme.primaryColor, //Colors.amber,
                                title: 'Collection',
                                textalign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconContainer2(
                                theme: theme,
                                callback: () {
                                  Get.toNamed(ConstantRoutes.settlement);
                                  if (MenuAuthDetail.Settlement == "Y") {
                                    Navigator.pop(context);
                                    Get.offAllNamed(ConstantRoutes.settlement);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.beenhere,
                                iconColor: theme.primaryColor,
                                title: 'Settlement',
                                textalign: TextAlign.center,
                              ),
                              IconContainer2(
                                theme: theme,
                                callback: () {},
                                icon: Icons.home,
                                iconColor: null,
                                title: '',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: Screens.fullHeight(context) * 0.01,
                  ),

                  ///Activies
                  // MenuAuthDetail.Activities != "Y"
                  //     ? Container()
                  //     :
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      width: Screens.width(context),
                      // height: Screens.fullHeight(context)*0.3,
                      //Colors.amber,
                      padding: EdgeInsets.symmetric(
                          vertical: Screens.fullHeight(context) * 0.01,
                          horizontal: Screens.width(context) * 0.02),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "  Activities",
                              style: theme.textTheme.headline6
                                  ?.copyWith(color: theme.primaryColor),
                            ),
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconContainer2(
                                theme: theme,
                                callback: () async {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => MapSample(),
                                  //     ));

                                  if (MenuAuthDetail.DayStartEnd == "Y") {
                                    await DaystartApi.getData().then((value) {
                                      if (value.stcode! >= 200 &&
                                          value.stcode! <= 210) {
                                        if (value.data == 1) {
                                          Get.toNamed(
                                              ConstantRoutes.dayEndPage);
                                        } else if (value.data == 0) {
                                          Get.toNamed(
                                              ConstantRoutes.daystartend);
                                        } else {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4))),
                                                    contentPadding:
                                                        EdgeInsets.all(0),
                                                    insetPadding: EdgeInsets
                                                        .all(Screens.bodyheight(
                                                                context) *
                                                            0.02),
                                                    content: settingsDaystart(
                                                        context,
                                                        "Day Activity Already Closed..!!"));
                                              });
                                        }
                                      } else if (value.stcode! >= 400 &&
                                          value.stcode! <= 410) {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4))),
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  insetPadding: EdgeInsets.all(
                                                      Screens.bodyheight(
                                                              context) *
                                                          0.02),
                                                  content: settingsDaystart(
                                                      context,
                                                      "${value.rescode}..!!${value.resdesc}..!!"));
                                            });
                                      } else if (value.stcode == 500) {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4))),
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  insetPadding: EdgeInsets.all(
                                                      Screens.bodyheight(
                                                              context) *
                                                          0.02),
                                                  content: settingsDaystart(
                                                      context,
                                                      "Network Issue Try Again Later..!!"));
                                            });
                                      }
                                    });
                                    // String? dayType =
                                    //     await SharedPref.getDayStart();
                                    // log("DayType::" + dayType.toString());
                                    // if (dayType == "DayStart") {
                                    //   Get.toNamed(
                                    //       ConstantRoutes.dayEndPage);
                                    // } else if (dayType == "DayEnd" ||
                                    //     dayType == null) {
                                    //   log("dayType");
                                    //   Get.toNamed(
                                    //       ConstantRoutes.daystartend);
                                    // }
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.update,
                                iconColor: theme.primaryColor, // Colors.green,
                                title: 'Day Start/End',
                                textalign: TextAlign.center,
                              ),
                              IconContainer2(
                                theme: theme,
                                callback: () {
                                  if (MenuAuthDetail.Visitplane == "Y") {
                                    Navigator.pop(context);
                                    Get.offAllNamed(ConstantRoutes.visitplan);
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => visitplanPage(),
                                    //     ));
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.hail,
                                iconColor: theme.primaryColor, //Colors.blue,
                                title: 'Visit Plan',
                              ),
                              IconContainer2(
                                theme: theme,
                                callback: () {
                                  if (MenuAuthDetail.SiteIn == "Y") {
                                    Navigator.pop(context);
                                    // context
                                    //     .read<SiteInController>()
                                    //     .gesiteindata(context);

                                    Get.offAllNamed(ConstantRoutes.sitein);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.login,
                                iconColor: theme.primaryColor, //Colors.orange,
                                title: 'Site In',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconContainer2(
                                theme: theme,
                                callback: () {
                                  if (MenuAuthDetail.SiteOut == "Y") {
                                    Get.toNamed(ConstantRoutes.siteOut);
                                    // Navigator.pop(context);
                                    context
                                        .read<SiteOutController>()
                                        .getallvisitdata(context);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.logout,
                                iconColor: theme.primaryColor, //.pink,
                                title: 'Site Out',
                                textalign: TextAlign.center,
                              ),
                              IconContainer2(
                                theme: theme,
                                callback: () {
                                  if (MenuAuthDetail.LeaveRequest == "Y") {
                                    Navigator.pop(context);
                                    Get.offAllNamed(ConstantRoutes.leaveReqtab);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.send_time_extension,
                                iconColor: theme.primaryColor, //Colors.amber,
                                title: 'Leave Request',
                                textalign: TextAlign.center,
                              ),
                              IconContainer2(
                                theme: theme,
                                callback: () {
                                  if (MenuAuthDetail.LeaveApproval == "Y") {
                                    Navigator.pop(context);
                                    Get.offAllNamed(
                                        ConstantRoutes.leaveApprList);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.beenhere,
                                iconColor: theme.primaryColor,
                                title: 'Leave Approval',
                                textalign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Screens.fullHeight(context) * 0.01,
                  ),

                  ///Performance
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      width: Screens.width(context),
                      // height: Screens.fullHeight(context)*0.3,
                      //Colors.amber,
                      padding: EdgeInsets.symmetric(
                          vertical: Screens.fullHeight(context) * 0.02,
                          horizontal: Screens.width(context) * 0.04),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Performance",
                              style: theme.textTheme.headline6
                                  ?.copyWith(color: theme.primaryColor),
                            ),
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  // if (MenuAuthDetail.ScoreCard == "Y") {
                                  //   Navigator.pop(context);
                                  //   Get.toNamed(
                                  //       ConstantRoutes.scoreCardScreenOne);
                                  // } else {
                                  //   showDialog(
                                  //       context: context,
                                  //       barrierDismissible: true,
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //             shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.all(
                                  //                         Radius.circular(4))),
                                  //             contentPadding: EdgeInsets.all(0),
                                  //             insetPadding: EdgeInsets.all(
                                  //                 Screens.bodyheight(context) *
                                  //                     0.02),
                                  //             content: settings(context));
                                  //       });
                                  // }
                                },
                                icon: Icons.score_outlined,
                                iconColor: Colors.grey, // Colors.green,
                                title: 'Score Card',
                              ),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  if (MenuAuthDetail.Earnings == "Y") {
                                    //ch
                                    Navigator.pop(context);
                                    Get.offAllNamed(ConstantRoutes.earnings);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                icon: Icons.account_balance_wallet,
                                iconColor: theme.primaryColor, //Colors.blue,
                                title: 'Earnings',
                              ),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  // if (MenuAuthDetail.Performance == "Y") {
                                  //   //ch
                                  //   Navigator.pop(context);
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => MyPerformance(),
                                  //       ));
                                  // } else {
                                  //   showDialog(
                                  //       context: context,
                                  //       barrierDismissible: true,
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //             shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.all(
                                  //                         Radius.circular(4))),
                                  //             contentPadding: EdgeInsets.all(0),
                                  //             insetPadding: EdgeInsets.all(
                                  //                 Screens.bodyheight(context) *
                                  //                     0.02),
                                  //             content: settings(context));
                                  //       });
                                  // }
                                },
                                icon: Icons.equalizer,
                                iconColor: Colors.grey, //Colors.orange,
                                title: 'Performance',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (MenuAuthDetail.Target == "Y") {
                                    //ch
                                    Navigator.pop(context);
                                    Get.offAllNamed(ConstantRoutes.targets);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  width: Screens.width(context) * 0.25,
                                  height: Screens.fullHeight(context) * 0.11,
                                  decoration: BoxDecoration(
                                      //   color: Colors.red[200],
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.26,
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Container(
                                                width: Screens.width(context) *
                                                    0.108,
                                                padding: EdgeInsets.all(5),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: theme.primaryColor
                                                        .withOpacity(
                                                            0.2), //,Colors.amber,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Image.asset(
                                                  "Assets/archery2.png",
                                                  fit: BoxFit.contain,
                                                  color: theme.primaryColor,
                                                )
                                                // IconButton(
                                                //   alignment: Alignment.bottomCenter,
                                                //   onPressed:  () {
                                                //               if (MenuAuthDetail.Walkins == "Y") {
                                                //                 Navigator.pop(context);
                                                //                 Get.toNamed(ConstantRoutes.walkins);
                                                //               } else {
                                                //                 showDialog(
                                                //                     context: context,
                                                //                     barrierDismissible: true,
                                                //                     builder: (BuildContext context) {
                                                //                       return AlertDialog(
                                                //                           shape: RoundedRectangleBorder(
                                                //                               borderRadius:
                                                //                                   BorderRadius.all(
                                                //                                       Radius.circular(4))),
                                                //                           contentPadding: EdgeInsets.all(0),
                                                //                           insetPadding: EdgeInsets.all(
                                                //                               Screens.bodyheight(context) *
                                                //                                   0.02),
                                                //                           content: settings(context));
                                                //                     });
                                                //               }
                                                //             },
                                                //  icon: FaIcon(FontAwesomeIcons.users),// Icons.home,
                                                //   color: theme.primaryColor,//Colors.red,//Colors.white,
                                                //   iconSize: Screens.padingHeight(context) * 0.03,
                                                // ),
                                                ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.26,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Targets",
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                                  color: theme.primaryColor,

                                                  //color:Colors.red,//Colors.white,//
                                                  fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // IconContainer(
                              //   theme: theme,
                              //   callback: () {
                              //     if (MenuAuthDetail.Target == "Y") {
                              //       //ch
                              //       Navigator.pop(context);
                              //       Get.offAllNamed(ConstantRoutes.targets);
                              //     } else {
                              //       showDialog(
                              //           context: context,
                              //           barrierDismissible: true,
                              //           builder: (BuildContext context) {
                              //             return AlertDialog(
                              //                 shape: RoundedRectangleBorder(
                              //                     borderRadius:
                              //                         BorderRadius.all(
                              //                             Radius.circular(4))),
                              //                 contentPadding: EdgeInsets.all(0),
                              //                 insetPadding: EdgeInsets.all(
                              //                     Screens.bodyheight(context) *
                              //                         0.02),
                              //                 content: settings(context));
                              //           });
                              //     }
                              //   },
                              //   icon: Icons.assessment,
                              //  iconColor: theme.primaryColor,//.pink,
                              //   title: 'Targets',
                              // ),
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  // if (MenuAuthDetail.Challenges == "Y") {
                                  //   //ch
                                  //   Navigator.pop(context);
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => Challenges(),
                                  //       ));
                                  // } else {
                                  //   showDialog(
                                  //       context: context,
                                  //       barrierDismissible: true,
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //             shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.all(
                                  //                         Radius.circular(4))),
                                  //             contentPadding: EdgeInsets.all(0),
                                  //             insetPadding: EdgeInsets.all(
                                  //                 Screens.bodyheight(context) *
                                  //                     0.02),
                                  //             content: settings(context));
                                  //       });
                                  // }
                                },
                                icon: Icons.folder_shared_outlined,
                                iconColor: Colors.grey, //Colors.amber,
                                title: 'Challenges',
                              ),
                              IconContainer(
                                theme: theme,
                                callback: () {},
                                icon: Icons.home,
                                iconColor: null,
                                title: '',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
SizedBox(
                    height: Screens.fullHeight(context) * 0.01,
                  ),
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      width: Screens.width(context),
                      // height: Screens.fullHeight(context)*0.3,
                      //Colors.amber,
                      padding: EdgeInsets.symmetric(
                          vertical: Screens.fullHeight(context) * 0.02,
                          horizontal: Screens.width(context) * 0.04),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Reports",
                              style: theme.textTheme.titleLarge
                                  ?.copyWith(color: theme.primaryColor),
                            ),
                          ),
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconContainer(
                                theme: theme,
                                callback: () {
                                  Navigator.pop(context);
                                  Get.offAllNamed(ConstantRoutes.reports);
                                },
                                icon: Icons.settings,
                                iconColor: theme.primaryColor, //Colors.blue,
                                title: 'LeadAnalysis',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Screens.fullHeight(context) * 0.01,
                  ),
                  Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                      width: Screens.width(context),
                      // height: Screens.fullHeight(context)*0.3,
                      //Colors.amber,
                      padding: EdgeInsets.symmetric(
                          vertical: Screens.fullHeight(context) * 0.02,
                          horizontal: Screens.width(context) * 0.04),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Others",
                              style: theme.textTheme.headline6
                                  ?.copyWith(color: theme.primaryColor),
                            ),
                          ),
                          
                          SizedBox(
                            height: Screens.fullHeight(context) * 0.01,
                          ),




                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  // if (MenuAuthDetail.Profile == "Y") {
                                  Navigator.pop(context);
                                  Get.toNamed(ConstantRoutes.newprofile);
                                  // } else {
                                  //   showDialog(
                                  //       context: context,
                                  //       barrierDismissible: true,
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //             shape: RoundedRectangleBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.all(
                                  //                         Radius.circular(
                                  //                             4))),
                                  //             contentPadding:
                                  //                 EdgeInsets.all(0),
                                  //             insetPadding: EdgeInsets.all(
                                  //                 Screens.bodyheight(
                                  //                         context) *
                                  //                     0.02),
                                  //             content: settings(context));
                                  //       });
                                  // }
                                },
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  width: Screens.width(context) * 0.25,
                                  height: Screens.fullHeight(context) * 0.11,
                                  decoration: BoxDecoration(
                                      //   color: Colors.red[200],
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.26,
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: Screens.width(context) *
                                                  0.108,
                                              // padding: EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: theme.primaryColor
                                                      .withOpacity(
                                                          0.2), //,Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: IconButton(
                                                alignment: Alignment.center,
                                                onPressed: () {
                                                  // if (MenuAuthDetail.Profile == "Y") {
                                                  Navigator.pop(context);
                                                  Get.toNamed(ConstantRoutes
                                                      .newprofile);
                                                  // } else {
                                                  //   showDialog(
                                                  //       context: context,
                                                  //       barrierDismissible: true,
                                                  //       builder: (BuildContext context) {
                                                  //         return AlertDialog(
                                                  //             shape: RoundedRectangleBorder(
                                                  //                 borderRadius:
                                                  //                     BorderRadius.all(
                                                  //                         Radius.circular(
                                                  //                             4))),
                                                  //             contentPadding:
                                                  //                 EdgeInsets.all(0),
                                                  //             insetPadding: EdgeInsets.all(
                                                  //                 Screens.bodyheight(
                                                  //                         context) *
                                                  //                     0.02),
                                                  //             content: settings(context));
                                                  //       });
                                                  // }
                                                },
                                                icon: FaIcon(FontAwesomeIcons
                                                    .user), // Icons.home,
                                                color: theme
                                                    .primaryColor, //Colors.red,//Colors.white,
                                                iconSize: Screens.padingHeight(
                                                        context) *
                                                    0.03,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.26,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Profile",
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                                  color: theme.primaryColor,

                                                  //color:Colors.red,//Colors.white,//
                                                  fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // IconContainer(
                              //     theme: theme,
                              //     callback: () {
                              //       // if (MenuAuthDetail.Profile == "Y") {
                              //       Navigator.pop(context);
                              //       Get.toNamed(ConstantRoutes.newprofile);
                              //       // } else {
                              //       //   showDialog(
                              //       //       context: context,
                              //       //       barrierDismissible: true,
                              //       //       builder: (BuildContext context) {
                              //       //         return AlertDialog(
                              //       //             shape: RoundedRectangleBorder(
                              //       //                 borderRadius:
                              //       //                     BorderRadius.all(
                              //       //                         Radius.circular(
                              //       //                             4))),
                              //       //             contentPadding:
                              //       //                 EdgeInsets.all(0),
                              //       //             insetPadding: EdgeInsets.all(
                              //       //                 Screens.bodyheight(
                              //       //                         context) *
                              //       //                     0.02),
                              //       //             content: settings(context));
                              //       //       });
                              //       // }
                              //     },
                              //     icon: Icons.photo_camera_front_outlined,
                              //     iconColor:
                              //         theme.primaryColor, // Colors.green,
                              //     title: 'Profile'),
                              // IconContainer(
                              //   theme: theme,
                              //   callback: () {
                              //     Navigator.pop(context);
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) => Settings(),
                              //         ));
                              //   },
                              //   icon: Icons.settings,
                              //   iconColor: theme.primaryColor, //Colors.blue,
                              //   title: 'Setting',
                              // ),
                              // IconContainer(
                              //   theme: theme,
                              //   callback: () {

                              //     Get.offAllNamed(ConstantRoutes.dashboard);
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) => Settings(),
                              //         ));
                              //   },
                              //   icon: Icons.settings,
                              //   iconColor: theme.primaryColor, //Colors.blue,
                              //   title: 'Setting',
                              // ),
                              //  IconContainer(
                              //     theme: theme,
                              //     callback: () {
                              //       // if (MenuAuthDetail.Profile == "Y") {
                              //       // Navigator.pop(context);
                              //       // Get.toNamed(ConstantRoutes.newprofile);
                              //       // } else {
                              //       //   showDialog(
                              //       //       context: context,
                              //       //       barrierDismissible: true,
                              //       //       builder: (BuildContext context) {
                              //       //         return AlertDialog(
                              //       //             shape: RoundedRectangleBorder(
                              //       //                 borderRadius:
                              //       //                     BorderRadius.all(
                              //       //                         Radius.circular(
                              //       //                             4))),
                              //       //             contentPadding:
                              //       //                 EdgeInsets.all(0),
                              //       //             insetPadding: EdgeInsets.all(
                              //       //                 Screens.bodyheight(
                              //       //                         context) *
                              //       //                     0.02),
                              //       //             content: settings(context));
                              //       //       });
                              //       // }
                              //     },
                              //     icon: Icons.password,
                              //     iconColor:
                              //         theme.primaryColor, // Colors.green,
                              //     title: ' Change\npassword'),

                              InkWell(
                                onTap: () async {
                                  // Navigator.pop(context);
                                  // DashBoardController.isLogout = true;
                                  await DashBoardController.logOutMethod();
                                },
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  width: Screens.width(context) * 0.25,
                                  height: Screens.fullHeight(context) * 0.11,
                                  decoration: BoxDecoration(
                                      //   color: Colors.red[200],
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.26,
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: Screens.width(context) *
                                                  0.108,
                                              // padding: EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: theme.primaryColor
                                                      .withOpacity(
                                                          0.2), //,Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: IconButton(
                                                alignment: Alignment.center,
                                                onPressed: () async {
                                                  // Navigator.pop(context);
                                                  // DashBoardController.isLogout = true;
                                                  await DashBoardController
                                                      .logOutMethod();
                                                },
                                                icon: FaIcon(FontAwesomeIcons
                                                    .powerOff), // Icons.home,
                                                color: theme
                                                    .primaryColor, //Colors.red,//Colors.white,
                                                iconSize: Screens.padingHeight(
                                                        context) *
                                                    0.03,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.26,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Logout",
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                                  color: theme.primaryColor,

                                                  //color:Colors.red,//Colors.white,//
                                                  fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // IconContainer(
                              //   theme: theme,
                              //   callback: () async {

                              //     // Navigator.pop(context);
                              //     // DashBoardController.isLogout = true;
                              //     await DashBoardController
                              //         .logOutMethod();

                              //   },
                              //   icon: Icons.logout_outlined,
                              //   iconColor: theme.primaryColor, //Colors.orange,
                              //   title: 'Logout',
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Screens.fullHeight(context) * 0.01,
                  ),

                  Container(
                    width: Screens.width(context),
                    //   color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          width: Screens.width(context) * 0.35,
                          child: Text("Copyright@2023",
                              style: theme.textTheme.bodyText1
                                  ?.copyWith(color: Colors.grey)),
                        ),
                        Column(
                          children: [
                            Container(
                              //  color: Colors.red,
                              width: Screens.width(context) * 0.6,
                              alignment: Alignment.bottomRight,
                              child: Text(
                                ConstantValues.appversion.isEmpty
                                    ? "${AppConstant.version}"
                                    : "${ConstantValues.appversion}",
                                style: theme.textTheme.bodyText1
                                    ?.copyWith(color: Colors.grey),
                              ), //\n 8752sdseaw3j99awe931
                            ),
                            // Container(
                            //   //  color: Colors.red,
                            //   width: Screens.width(context) * 0.6,
                            //   alignment: Alignment.bottomRight,
                            //   child: Text("",
                            //       style: theme.textTheme.bodyText1?.copyWith(
                            //           color: Colors
                            //               .grey)), //\n 8752sdseaw3j99awe931
                            // ),
                          ],
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.01,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: Screens.fullHeight(context) * 0.02,
                  ),
                ]),
          ),
        ),
      ],
    )),
  );
}

settings(BuildContext context) {
  final theme = Theme.of(context);
  return StatefulBuilder(builder: (context, st) {
    return Container(
      padding: EdgeInsets.only(
          top: Screens.padingHeight(context) * 0.01,
          left: Screens.width(context) * 0.03,
          right: Screens.width(context) * 0.03,
          bottom: Screens.padingHeight(context) * 0.01),
      width: Screens.width(context) * 1.1,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.padingHeight(context) * 0.05,
              color: theme.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Screens.padingHeight(context) * 0.02,
                        right: Screens.padingHeight(context) * 0.02),
                    // color: Colors.red,
                    width: Screens.width(context) * 0.7,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Alert",
                      style: theme.textTheme.bodyText2
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: Screens.padingHeight(context) * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.02,
            ),
            Container(
                alignment: Alignment.center,
                width: Screens.width(context),
                child: Text('You are not authorised..!!')),
            SizedBox(
              height: Screens.bodyheight(context) * 0.02,
            ),
          ],
        ),
      ),
    );
  });
}

settingsDaystart(BuildContext context, String? text) {
  final theme = Theme.of(context);
  return StatefulBuilder(builder: (context, st) {
    return Container(
      padding: EdgeInsets.only(
          top: Screens.padingHeight(context) * 0.01,
          left: Screens.width(context) * 0.03,
          right: Screens.width(context) * 0.03,
          bottom: Screens.padingHeight(context) * 0.01),
      width: Screens.width(context) * 1.1,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.padingHeight(context) * 0.05,
              color: theme.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Screens.padingHeight(context) * 0.02,
                        right: Screens.padingHeight(context) * 0.02),
                    // color: Colors.red,
                    width: Screens.width(context) * 0.7,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Alert",
                      style: theme.textTheme.bodyText2
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: Screens.padingHeight(context) * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.02,
            ),
            Container(
                alignment: Alignment.center,
                width: Screens.width(context),
                child: Text('$text')),
            SizedBox(
              height: Screens.bodyheight(context) * 0.02,
            ),
          ],
        ),
      ),
    );
  });
}
