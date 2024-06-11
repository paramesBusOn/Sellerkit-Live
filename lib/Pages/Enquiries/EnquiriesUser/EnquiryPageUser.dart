// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
// import 'package:sellerkit/Controller/EnquiryController/EnquiryMngController.dart';
import 'package:sellerkit/Pages/Enquiries/EnquiriesUser/Widgets/ClosedEnq.dart';
import 'package:sellerkit/Pages/Enquiries/EnquiriesUser/Widgets/LostEnqUser.dart';
import 'package:sellerkit/Pages/Enquiries/EnquiriesUser/Widgets/OpenEnqPage.dart';
import 'package:sellerkit/Pages/Enquiries/EnquiriesUser/Widgets/navdrawerenq.dart';
import '../../../Constant/MenuAuth.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/EnquiryController/EnquiryUserContoller.dart';
import '../../../Controller/EnquiryController/NewEnqController.dart';
import '../../../Widgets/Navi3.dart';
import '../NewEnquiry.dart';
import 'Widgets/GlobalKeys.dart';

class EnquiryUserPage extends StatefulWidget {
  EnquiryUserPage({Key? key}) : super(key: key);

  @override
  State<EnquiryUserPage> createState() => EnquiryUserPageState();
}

class EnquiryUserPageState extends State<EnquiryUserPage>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Open'),
    Tab(text: 'Closed'),
    Tab(text: 'Lost'),
  ];
  TabController? controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3, initialIndex: 0);
    controller!.addListener(_handleTabChange);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (EnquiryUserContoller.enqDataprev == 0) {
        context.read<EnquiryUserContoller>().initcall();
        // context.read<EnquiryUserContoller>().callUserListApi();
        // context.read<EnquiryUserContoller>().callResonApi();
      } else {
        context.read<EnquiryUserContoller>().resetAll(context);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EnquiryUserContoller.enqDataprev = 0;
  }

  void _handleTabChange() {
    setState(() {
      context.read<EnquiryUserContoller>().mycontroller[5].text = '';
      context.read<EnquiryUserContoller>().setListData();
    });
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
      child: Scaffold(
        key: scaffoldKey1,
        drawerEnableOpenDragGesture: false,
        appBar: context.watch<EnquiryUserContoller>().getdatagotByApi == true &&
                context.watch<EnquiryUserContoller>().getException == false
            ? AppBar(
                backgroundColor: theme.primaryColor,
                actions: [
                  IconButton(
                      color: Colors.transparent,
                      onPressed: () {},
                      icon: Icon(Icons.filter_alt))
                ],
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(80),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Screens.bodyheight(context) * 0.02),
                    child: Column(
                      children: [
                        Container(
                          height: Screens.bodyheight(context) * 0.06,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  Screens.width(context) * 0.01),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.7),
                                  spreadRadius: 3,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ]),
                          child: TextField(
                            controller: context
                                .read<EnquiryUserContoller>()
                                .mycontroller[5],
                            onTap: () {
                              // Get.toNamed(ConstantRoutes.screenshot);
                            },
                            autocorrect: false,
                            onChanged: (v) {
                              if (controller!.index.toString() == "0") {
                                context
                                    .read<EnquiryUserContoller>()
                                    .SearchFilterOpenTab(v);
                              } else if (controller!.index.toString() == "1") {
                                context
                                    .read<EnquiryUserContoller>()
                                    .SearchFilterWonTab(v);
                              } else {
                                context
                                    .read<EnquiryUserContoller>()
                                    .SearchFilterLostTab(v);
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              hintText: 'Search',
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              suffixIcon: Icon(
                                Icons.search,
                                color: theme.primaryColor,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 5,
                              ),
                            ),
                          ),
                        ),
                        TabBar(
                          // key: RIKeys.riKey2,
                          controller: controller,
                          tabs: myTabs,
                        ),
                      ],
                    ),
                  ),
                ),
                title: Text('Enquiries'),
              )
            : AppBar(
                backgroundColor: theme.primaryColor,
                title: Text('Enquiries'),
                actions: [
                  IconButton(
                      color: Colors.transparent,
                      onPressed: () {},
                      icon: Icon(Icons.filter_alt))
                ],
              ),
        drawer: drawer3(context),
        endDrawer: navDrawerEnq(),
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
          child: context.watch<EnquiryUserContoller>().getdatagotByApi == false
              ? Center(child: CircularProgressIndicator())
              : context.watch<EnquiryUserContoller>().getdatagotByApi == true &&
                      (context
                              .watch<EnquiryUserContoller>()
                              .getopenEnqData
                              .isNotEmpty ||
                          context
                              .watch<EnquiryUserContoller>()
                              .getclosedEnqdata
                              .isNotEmpty ||
                          context
                              .watch<EnquiryUserContoller>()
                              .getlostEnqUserdata
                              .isNotEmpty) &&
                      context.watch<EnquiryUserContoller>().getException ==
                          false
                  ? TickerMode(
                      enabled: true,
                      child: TabBarView(
                          controller: controller,

                          //  key: RIKeys.riKey1,
                          // physics: const NeverScrollableScrollPhysics(),
                          children: [
                            OpenEnqPage(theme: theme),
                            ClosedEnqPage(theme: theme),
                            LostEnqUserPage(theme: theme),
                          ]),
                    )
                  : context.watch<EnquiryUserContoller>().getdatagotByApi ==
                              true &&
                          context.watch<EnquiryUserContoller>().getException ==
                              true &&
                          context
                              .watch<EnquiryUserContoller>()
                              .getErrorMsg
                              .isNotEmpty
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            context
                                    .watch<EnquiryUserContoller>()
                                    .lottie!
                                    .isEmpty
                                ? Container()
                                : context
                                            .watch<EnquiryUserContoller>()
                                            .lottie!
                                            .isNotEmpty &&
                                        context
                                            .watch<EnquiryUserContoller>()
                                            .lottie!
                                            .contains(".png")
                                    ? InkWell(
                                        onTap: () {
                                          // HelperFunctions.clearCheckedOnBoardSharedPref();
                                          // HelperFunctions.clearUserLoggedInSharedPref();
                                        },
                                        child: Image.asset(
                                            '${context.watch<EnquiryUserContoller>().lottie}',
                                            //               opacity: AnimationController(
                                            //     vsync: this,
                                            //     value: 1
                                            // ),
                                            // color:Colors.transparent,
                                            // animate: true,
                                            // repeat: true,

                                            height:
                                                Screens.padingHeight(context) *
                                                    0.2,
                                            width:
                                                Screens.width(context) * 0.5),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          // HelperFunctions.clearCheckedOnBoardSharedPref();
                                          // HelperFunctions.clearUserLoggedInSharedPref();
                                        },
                                        child: Lottie.asset(
                                            '${context.watch<EnquiryUserContoller>().lottie}',
                                            animate: true,
                                            repeat: true,
                                            // height: Screens.padingHeight(context) * 0.3,
                                            width:
                                                Screens.width(context) * 0.4),
                                      ),
                            Text(
                              context.watch<EnquiryUserContoller>().getErrorMsg,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ))
                      :
                      // context.watch<EnquiryUserContoller>().getdatagotByApi == true &&
                      //     (context
                      //             .watch<EnquiryUserContoller>()
                      //             .getopenEnqData
                      //             .isEmpty ||
                      //         context
                      //             .watch<EnquiryUserContoller>()
                      //             .getclosedEnqdata
                      //             .isEmpty ||
                      //         context
                      //             .watch<EnquiryUserContoller>()
                      //             .getlostEnqUserdata
                      //             .isEmpty) &&
                      //     context.watch<EnquiryUserContoller>().getException == false?
                      Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                // HelperFunctions.clearCheckedOnBoardSharedPref();
                                // HelperFunctions.clearUserLoggedInSharedPref();
                              },
                              child: Image.asset('Assets/no-data.png',
                                  //               opacity: AnimationController(
                                  //     vsync: this,
                                  //     value: 1
                                  // ),
                                  // color:Colors.transparent,
                                  // animate: true,
                                  // repeat: true,

                                  height: Screens.padingHeight(context) * 0.2,
                                  width: Screens.width(context) * 0.5),
                            ),
                            Text("No Data..!!", textAlign: TextAlign.center),
                          ],
                        )),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'bt1',
              onPressed: () {
                context.read<EnquiryUserContoller>().clearfilterval();
                context.read<EnquiryUserContoller>().getdbmodel();
                scaffoldKey1.currentState?.openEndDrawer();
              },
              child: Icon(Icons.filter_alt),
            ),
            SizedBox(
              height: Screens.padingHeight(context) * 0.01,
            ),
            FloatingActionButton(
              heroTag: 'bt2',
              onPressed: () {
                // if (MenuAuthDetail.Enquiries == "Y") {
                context.read<NewEnqController>().clearAllData();
                Get.toNamed(ConstantRoutes.newEnq)!.then((value) {
                  context.read<EnquiryUserContoller>().resetAll(context);
                });
                // } else {
                //   showDialog(
                //       context: context,
                //       barrierDismissible: true,
                //       builder: (BuildContext context) {
                //         return AlertDialog(
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.all(Radius.circular(4))),
                //             contentPadding: EdgeInsets.all(0),
                //             insetPadding:
                //                 EdgeInsets.all(Screens.bodyheight(context) * 0.02),
                //             content: settings(context));
                //       });
                // }
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
