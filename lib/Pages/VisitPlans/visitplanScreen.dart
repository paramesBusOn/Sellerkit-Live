// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, camel_case_types, unused_import, unnecessary_string_interpolations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/constant_routes.dart';
import 'package:sellerkit/Constant/constant_sapvalues.dart';

import 'package:sellerkit/Pages/VisitPlans/widgets/ClosedVisit.dart';
import 'package:sellerkit/Pages/VisitPlans/widgets/MissedVisitUser.dart';
import 'package:sellerkit/Pages/VisitPlans/widgets/OpenVisitPage.dart';
import 'package:sellerkit/Pages/VisitPlans/widgets/navedarawerend.dart';
import '../../Constant/menu_auth.dart';
import '../../../Constant/Screen.dart';
// import '../../../Controller/EnquiryController/EnquiryUserContoller.dart';
// import '../../../Controller/EnquiryController/NewEnqController.dart';
import '../../../Widgets/Navi3.dart';
import '../../Controller/VisitplanController/visitplan_controller.dart';

class visitplanPage extends StatefulWidget {
  visitplanPage({super.key});

  @override
  State<visitplanPage> createState() => visitplanPageState();
}

class visitplanPageState extends State<visitplanPage>
    with TickerProviderStateMixin {
      final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Open'),
    // Tab(text: 'Closed'),
    Tab(text: 'Missed'),
  ];
  TabController? controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2, initialIndex: 0);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<VisitplanController>().init();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // EnquiryUserContoller.enqDataprev = 0;
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

        appBar: AppBar(
           actions: [
            IconButton(
              color:Colors.transparent,
              onPressed: (){}, icon: Icon(Icons.filter_alt))
          ],
          backgroundColor: theme.primaryColor,
          bottom: TabBar(
            // key: RIKeys.riKey2,
            controller: controller,
            tabs: myTabs,
          ),
          title: Text('Visit Plan'),
        ),
        drawer: drawer3(context),
         endDrawer: navDrawervisit(),
        body: GestureDetector(onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.dashboard);
                      });
                    }
                  },
          child:context.watch<VisitplanController>().visitdetailsdata.isEmpty &&
          context.watch<VisitplanController>().isloading == false &&
          context
                          .watch<VisitplanController>()
                          .errortabMsg
                          .isEmpty
          ?

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
                        width: Screens.width(context)*0.5
                        ),
                  ),
                          Text(
                              "No Data..!!",textAlign: TextAlign.center,),
                        ],
                      ),
                    ):
               ((context.watch<VisitplanController>().openVisitData.isEmpty &&
                      
                      context
                          .watch<VisitplanController>()
                          .missedVisitUserdata
                          .isEmpty )&&
                      context
                          .watch<VisitplanController>()
                          .errortabMsg
                          .isNotEmpty &&
                      context.watch<VisitplanController>().isloading == false)
                  ? Center(
                      child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           context.watch<VisitplanController>().lottie!.isEmpty?Container():
                                context.watch<VisitplanController>().lottie!.isNotEmpty && context.watch<VisitplanController>().lottie!.contains(".png")?     InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('${context.watch<VisitplanController>().lottie}',
        //               opacity: AnimationController(
        //     vsync: this,
        //     value: 1
        // ),
        // color:Colors.transparent,
                        // animate: true,
                        // repeat: true,
                        
                        height: Screens.padingHeight(context) * 0.2,
                        width: Screens.width(context)*0.4
                        ),
                  ):              InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Lottie.asset('${context.watch<VisitplanController>().lottie}',
                        animate: true,
                        repeat: true,
                        // height: Screens.padingHeight(context) * 0.3,
                        width: Screens.width(context) * 0.4),
                  ),
                   context.watch<VisitplanController>().errortabMsg
                                                      .contains("Network Issue")
                                                  ? Text(
                                                      "NO INTERNET CONNECTION",
                                                      style: theme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: theme
                                                                  .primaryColor),
                                                    )
                                                  : Container(),
                                              context.watch<VisitplanController>().errortabMsg
                                                      .contains("Network Issue")
                                                  ? Text(
                                                      "You are not connected to internet. Please connect to the internet and try again.",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: theme
                                                          .textTheme.bodyMedium!
                                                          .copyWith(),
                                                    )
                                                  : Container(),
                                              context.watch<VisitplanController>().errortabMsg
                                                      .contains("Network Issue")
                                                  ? Container():
                          Text(
                              "${context.watch<VisitplanController>().errortabMsg}",textAlign: TextAlign.center,),
                        ],
                      ),
                    )
                  : ((context.watch<VisitplanController>().openVisitData.isNotEmpty ||
                 
                  context
                      .watch<VisitplanController>()
                      .missedVisitUserdata
                      .isNotEmpty) &&
                  context.watch<VisitplanController>().errortabMsg.isEmpty &&
                  context.watch<VisitplanController>().isloading == false)? TabBarView(
                      controller: controller,
                      //  key: RIKeys.riKey1,
                      // physics: const NeverScrollableScrollPhysics(),
                      children: [
                          OpenVisitPage(theme: theme),
                          // ClosedVisitPage(theme: theme),
                          MissiedUserPage(theme: theme),
                        ]):  Center(
                  child: CircularProgressIndicator(),
                )
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
             FloatingActionButton(
              heroTag :'bt1',
              onPressed: () {
                 context.read<VisitplanController> (). clearfilterval();
                 context.read<VisitplanController> ().  getdbmodel();
                scaffoldKey1.currentState?.openEndDrawer();
              },
              child: Icon(Icons.filter_alt),
            ),
            SizedBox(
              height: Screens.padingHeight(context)*0.01,
            ),
            FloatingActionButton(
              onPressed: () {
                Get.toNamed(ConstantRoutes.newvisitplan);
                // if (MenuAuthDetail.Enquiries == "Y") {
                //   context.read<NewEnqController>().clearAllData();
                //   Get.toNamed(ConstantRoutes.newEnq)!.then((value) {
                //     context.read<EnquiryUserContoller>().resetAll(context);
                //   });
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
