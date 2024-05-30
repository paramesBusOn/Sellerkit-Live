// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Pages/LeaveApprove/Screens/widgets/aprovedpage.dart';
import 'package:sellerkit/Pages/LeaveApprove/Screens/widgets/openpage.dart';
import 'package:sellerkit/Pages/LeaveApprove/Screens/widgets/rejectpage.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/LeaveApproveController/LeaveApproveController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class LeaveAppList extends StatefulWidget {
  const LeaveAppList({Key? key}) : super(key: key);

  @override
  State<LeaveAppList> createState() => _LeaveAppListState();
}

class _LeaveAppListState extends State<LeaveAppList> with TickerProviderStateMixin {
   static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Open'),
    Tab(text: 'Approved'),
    Tab(text: 'Reject'),
  ];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
 TabController? controller;
  @override
  void initState() {
    // TODO: implement initState

// callKpiApi();
    super.initState();
     controller = new TabController(vsync: this, length: 3, initialIndex: 0);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<LeaveApproveContoller>().init(context);
    });
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
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
      child: Scaffold(       drawerEnableOpenDragGesture: false,

        key: scaffoldKey,
        drawer: drawer3(context),
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
           bottom: 
                PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                            horizontal: Screens.bodyheight(context) * 0.02),
                    child: Column(
                      children: [
                      
                        TabBar(
                          // key: RIKeys.riKey2,
                          controller: controller,
                          tabs: myTabs,
                        ),
                      ],
                    ),
                  ),
                ),
                title: Text('Leave Approval'),
                ),
        body:  context.watch<LeaveApproveContoller>().isapiloading == false &&
                  (context
                          .watch<LeaveApproveContoller>()
                          .leaveopendetails
                          .isNotEmpty ||
                      context
                          .watch<LeaveApproveContoller>()
                          .leaveapprovedetails
                          .isNotEmpty ||
                      context
                          .watch<LeaveApproveContoller>()
                          .leaveRejectsdetails
                          .isNotEmpty) &&
                  context.watch<LeaveApproveContoller>().Errormsg!.isEmpty
              ? TickerMode(
                  enabled: true,
        
                child: TabBarView(controller: controller,
                
                    //  key: RIKeys.riKey1,
                    // physics: const NeverScrollableScrollPhysics(),
                    children: [
                        openpage(theme: theme),
                        approvepage(theme: theme),
                        rejectpage(theme: theme),
                      ]),
              )
              : context.watch<LeaveApproveContoller>().isapiloading == false &&
                  
                  context.watch<LeaveApproveContoller>().Errormsg!.isNotEmpty
                  ? Center(
                      child:
                          Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               context.watch<LeaveApproveContoller>().lottie!.isEmpty?Container():
                                context.watch<LeaveApproveContoller>().lottie!.isNotEmpty && context.watch<LeaveApproveContoller>().lottie!.contains(".png")?     InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('${context.watch<LeaveApproveContoller>().lottie}',
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
                  ):              InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Lottie.asset('${context.watch<LeaveApproveContoller>().lottie}',
                        animate: true,
                        repeat: true,
                        // height: Screens.padingHeight(context) * 0.3,
                        width: Screens.width(context) * 0.4),
                  ),
                              Text("${context.watch<LeaveApproveContoller>().Errormsg}",textAlign: TextAlign.center,),
                            ],
                          ))
                  : Center(child: CircularProgressIndicator()),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Get.toNamed(ConstantRoutes.newcollection);
        //   },
        //   child: Icon(
        //     Icons.add,
        //     color: Colors.white,
        //   ),
        // )
      ),
    );
  }
}
