// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, unused_local_variable

import 'dart:io';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/configuration.dart';
import 'package:sellerkit/Constant/constant_routes.dart';
import 'package:sellerkit/Constant/app_constant.dart';
import 'package:sellerkit/Constant/constant_sapvalues.dart';
import 'package:sellerkit/Constant/location_track.dart';
import 'package:sellerkit/Constant/location_trackIos.dart';
import 'package:sellerkit/Constant/method_channel.dart';
import 'package:sellerkit/Controller/SiteOutController/siteout_controller.dart';
import 'package:sellerkit/Services/DayStartEndApi/DaycheckAPi.dart';
import 'package:sellerkit/Widgets/IconContainer.dart';
import 'package:sellerkit/Widgets/IconContainer2.dart';
// import 'package:sellerkit/Widgets/IconContainer.dart';
// import 'package:sellerkit/Widgets/IconContainer2.dart';
import '../Constant/menu_auth.dart';
import '../Constant/Screen.dart';
import '../Controller/DashBoardController/dashboard_controller.dart';
// import 'IconContainer.dart';

SizedBox drawer3(BuildContext context) {
  // final height = MediaQuery.of(context).size.height;
  // final width = MediaQuery.of(context).size.width;
  final theme = Theme.of(context);
  checkLocation2();
  return SizedBox(
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
                      print("MenuAuthDetail.Dashboard ${MenuAuthDetail.Dashboard}");
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

                              alignment: Alignment.centerRight,
                              child: Icon(Icons.home),
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
                                  if (MenuAuthDetail.quotes == "Y") {
                                    Get.offAllNamed(ConstantRoutes.quotespage);
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
                                  if (MenuAuthDetail.Orders == "Y") {
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
                                          style: theme.textTheme.bodyMedium
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
                                                    if (MenuAuthDetail
                                                            .openlead ==
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
                                            style: theme.textTheme.bodyMedium
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
                                //                     style: theme.textTheme.bodyMedium?.copyWith(
                                //                        color: theme.primaryColor,

                                //                        //color:Colors.red,//Colors.white,//
                                //                         fontWeight: FontWeight.w400),
                                //                   ),
                                //                 ),
                                //       ],
                                //     ),
                                //   ),
                                // ),

                                InkWell(
                                  onTap: () {
                                    if (MenuAuthDetail.specialprice == "Y") {
                                      //ch ! replace =
                                      Navigator.pop(context);
                                      Get.offAllNamed(
                                          ConstantRoutes.specialpricereq);
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
                                                  width:
                                                      Screens.width(context) *
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
                                                    "Assets/save-money2.png",
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
                                            "Special Price Request",
                                            textAlign: TextAlign.center,
                                            style: theme.textTheme.bodyMedium
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
                                //     if (MenuAuthDetail.specialprice == "Y") {
                                //     //ch ! replace =
                                //     Navigator.pop(context);
                                //     Get.offAllNamed(ConstantRoutes.specialpricereq);
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
                                //   icon: Icons.receipt,
                                //   iconColor:
                                //       theme.primaryColor, //Colors.orange,
                                //   title: 'Special Price Request',
                                // ),
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
                                  if (MenuAuthDetail.outstanding == "Y") {
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
                                  if (MenuAuthDetail.Collection == "Y") {
                                    Navigator.pop(context);
                                    Get.offAllNamed(
                                        ConstantRoutes.collectionlist);
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
                                  // Get.toNamed(ConstantRoutes.settlement);
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
                              IconContainer2(
                                theme: theme,
                                callback: () async {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => MapSample(),
                                  //     ));

                                  if (MenuAuthDetail.DayStartEnd == "Y") {
//                                    await checkLocation2();
//                                    print("ConstantValues.attlatitude::"+ConstantValues.attlatitude.toString());
//                                    print("ConstantValues.attlangtitude::"+ConstantValues.attlangtitude.toString());
//                              bool verifibool = false;
//                                double totaldis = calculateDistance2(
//                   double.parse("11.0142725"),
//                   double.parse("76.9624857"),
//                   double.parse(ConstantValues.latitude.toString()),
//                   double.parse(ConstantValues.langtitude.toString()));
//               print("Total Dis:" + totaldis.toString());
//               int apiDis = int.parse("25".toString());
//                                  if (totaldis < apiDis.toDouble()) {
//               verifibool = true;
     
     
//               }
//               if(verifibool==false){
// showDialog(
//                                                 context: context,
//                                                 barrierDismissible: true,
//                                                 builder:
//                                                     (BuildContext context) {
//                                                   return AlertDialog(
//                                                       shape: RoundedRectangleBorder(
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                                   Radius
//                                                                       .circular(
//                                                                           10))),
//                                                       contentPadding:
//                                                           EdgeInsets.all(0),
//                                                       insetPadding:
//                                                           EdgeInsets.all(Screens
//                                                                   .bodyheight(
//                                                                       context) *
//                                                               0.02),
//                                                       content: settingsDaystart(
//                                                           context,
//                                                           "You are in Restricted zone ..!!"));
//                                                 });

              // }else{

             
                  //                 double totaldis = calculateDistance2(
                  // double.parse(locatoindetals[0]),
                  // double.parse(locatoindetals[1]),
                  // double.parse(ConstantValues.attlatitude.toString()),
                  // double.parse(ConstantValues.langtitude.toString()));
                                 
                                    // if (ConstantValues.attlatitude == '11.0142725' &&
                                    //     ConstantValues.attlangtitude == '76.9624889') {
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
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      insetPadding:
                                                          EdgeInsets.all(Screens
                                                                  .bodyheight(
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
                                                                    10))),
                                                    contentPadding:
                                                        EdgeInsets.all(0),
                                                    insetPadding: EdgeInsets
                                                        .all(Screens.bodyheight(
                                                                context) *
                                                            0.02),
                                                    content: settingsDaystart(
                                                        context,
                                                        "${value.rescode}..!!${value.resdesc}..!!"));
                                              });
                                        } else {
                                          if (value.exception!.contains(
                                              "Network is unreachable")) {
                                            showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      insetPadding:
                                                          EdgeInsets.all(Screens
                                                                  .bodyheight(
                                                                      context) *
                                                              0.02),
                                                      content: settingsDaystart(
                                                          context,
                                                          "Network Issue Try Again Later..!!"));
                                                });
                                          } else {
                                            showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      insetPadding:
                                                          EdgeInsets.all(Screens
                                                                  .bodyheight(
                                                                      context) *
                                                              0.02),
                                                      content: settingsDaystart(
                                                          context,
                                                          "Something went wrong..!!\nTry again Later..!!"));
                                                });
                                          }
                                        }
                                      });
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
                                    //             content: settingsDaystart(
                                    //                 context,
                                    //                 "You are out of Whitelisted zone..!!"));
                                    //       });
                                    // }
                                //  }
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
                                  // if (MenuAuthDetail.ScoreCard == "Y") {
                                  //   Navigator.pop(context);
                                  Get.toNamed(
                                      ConstantRoutes.scoreCardScreenOne);
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
                                          style: theme.textTheme.bodyMedium
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
                                title: 'Lead Analysis',
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
                                          style: theme.textTheme.bodyMedium
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
                                          style: theme.textTheme.bodyMedium
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
                              style: theme.textTheme.bodyMedium
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
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.grey),
                              ), //\n 8752sdseaw3j99awe931
                            ),
                            // Container(
                            //   //  color: Colors.red,
                            //   width: Screens.width(context) * 0.6,
                            //   alignment: Alignment.bottomRight,
                            //   child: Text("",
                            //       style: theme.textTheme.bodyMedium?.copyWith(
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
                    width: Screens.width(context) * 0.5,
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Alert",
                      style: theme.textTheme.bodyMedium
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

checkLocation2() async {
  print("Before await LocationTrack.determinePosition()");
  if (Platform.isAndroid) {
    await LocationTrack.determinePosition();
  } else {
    await LocationTrack2.determinePosition();
  }
  // await LocationTrack.determinePosition();
  // await LocationTrack. checkcamlocation();
  print("After await LocationTrack.determinePosition()");
  // await Future.delayed(Duration(seconds: 3));
  Connectivity()
      .onConnectivityChanged
      .listen((ConnectivityResult result) async {
    // print("LocationTrack.Lat::" + LocationTrack.Lat.toString());
    // print("LocationTrack.Long::" + LocationTrack.Long.toString());
    // print("ConstantValues.lat::" + ConstantValues.latitude.toString());
    // print("ConstantValues.lang::" + ConstantValues.langtitude.toString());
    ConstantValues.attlatitude = LocationTrack.Lat.isEmpty
        ? "${ConstantValues.attlatitude}"
        : '${LocationTrack.Lat}';
    ConstantValues.attlangtitude = LocationTrack.Long.isEmpty
        ? "${ConstantValues.attlangtitude}"
        : '${LocationTrack.Long}';
        print("ConstantValues.attlatitude::initial"+ConstantValues.attlatitude.toString());
    //
    if (ConstantValues.attlangtitude!.isEmpty || ConstantValues.attlangtitude == '') {
      ConstantValues.attlangtitude = '0.000';
    }
    if (ConstantValues.attlatitude!.isEmpty || ConstantValues.attlatitude == '') {
      ConstantValues.attlatitude = '0.000';
    }

    // log("Encryped Location Header:::" + encryValue.toString());
    // ConstantValues.EncryptedSetup = encryValue;
    // log("ConstantValues.EncryptedSetup::" +
    //     ConstantValues.EncryptedSetup.toString());
    //  await config.getSetup();
  });
  // await LocationTrack.checkcamlocation();
}

double calculateDistance2(lat1, lon1, lat2, lon2) {
  print('process lat' + lat1.toString());
  print('process long' + lon1.toString());

  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  return 12742000 * asin(sqrt(a));
}
settingsDaystart(BuildContext context, String? text) {
  final theme = Theme.of(context);
  return StatefulBuilder(builder: (context, st) {
    return Container(
      // padding: EdgeInsets.only(
      //     top: Screens.padingHeight(context) * 0.01,
      //     left: Screens.width(context) * 0.03,
      //     right: Screens.width(context) * 0.03,
      //     bottom: Screens.padingHeight(context) * 0.01),
      width: Screens.width(context) * 1.1,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.padingHeight(context) * 0.05,
              
              decoration: BoxDecoration(
                color: theme.primaryColor,
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Screens.padingHeight(context) * 0.02,
                        right: Screens.padingHeight(context) * 0.02),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )
                    ),
                    // color: Colors.red,
                    // width: Screens.width(context) * 0.7,
                    alignment: Alignment.center,
                    child: Text(
                      "Alert",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(5),
                  //   ),
                  //   child: IconButton(
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     },
                  //     icon: Icon(
                  //       Icons.close,
                  //       size: Screens.padingHeight(context) * 0.025,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.02,
            ),
            text!.contains("Network Issue")
                ? Container(
                    height: Screens.padingHeight(context) * 0.2,
                    width: Screens.width(context) * 0.4,
                    child: Image.asset("Assets/network-signal.png"),
                  )
                : Container(),
            SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
            text!.contains("Network Issue")
                ? Text(
                    "NO INTERNET CONNECTION",
                    style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold, color: theme.primaryColor),
                  )
                : Container(),
            text!.contains("Network Issue")
                ? Text(
                    "You are not connected to internet. Please connect to the internet and try again.",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium!.copyWith(),
                  )
                : Container(),
            text!.contains("Network Issue")
                ? Container()
                : Container(
                    alignment: Alignment.center,
                    width: Screens.width(context),
                    child: Text('$text')),
            SizedBox(
              height: Screens.bodyheight(context) * 0.02,
            ),
            SizedBox(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (_) => SettlementSuccessCard()));
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      // fontSize: 12,
                      ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )), //Radius.circular(6)
                ),
                child: Text(
                  "Close",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  });
}
