// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import '../../../Controller/FollowupController/FollowUPController.dart';
import '../../../Widgets/Navi3.dart';
import '../widgets/FollowUPCommingPage.dart';
import '../widgets/FollowUPODue.dart';

class FollowUpTab extends StatefulWidget {
  FollowUpTab({Key? key}) : super(key: key);

  @override
  State<FollowUpTab> createState() => _FollowUpTabState();
}

class _FollowUpTabState extends State<FollowUpTab>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Overdue'),
    Tab(text: 'Upcoming'),
  ];
  TabController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new TabController(vsync: this, length: 2, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          bottom: TabBar(
            controller: controller,
            tabs: myTabs,
          ),
          title: Text('Followup'),
        ),
        drawer: drawer3(context),
        body: GestureDetector(onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.dashboard);
                      });
                    }
                  },
          child: ChangeNotifierProvider<FollowupController>(
              create: (context) => FollowupController(),
              builder: (context, child) {
                return Consumer<FollowupController>(
                    builder: (BuildContext context, prdFUP, Widget? child) {
                  return (prdFUP.getisLoading == true &&
                          prdFUP.getexcepMsg.isEmpty)
                      ? Center(child: CircularProgressIndicator())
                      : (prdFUP.getisLoading == false &&
                              prdFUP.getexcepMsg.isNotEmpty)
                          ? Center(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                prdFUP.getlottie!.isEmpty?Container():
                                prdFUP.getlottie!.isNotEmpty && prdFUP.getlottie!.contains(".png")?     InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('${prdFUP.getlottie}',
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
                    child: Lottie.asset('${prdFUP.getlottie}',
                        animate: true,
                        repeat: true,
                        // height: Screens.padingHeight(context) * 0.3,
                        width: Screens.width(context) * 0.4),
                  ),
                              Text(prdFUP.getexcepMsg,textAlign: TextAlign.center,),
                            ],
                          ))
                          : TabBarView(controller: controller, children: [
                              FollowUPODue(prdFUP: prdFUP),
                              FollowUPComming(prdFUP: prdFUP)
                            ]);
                });
              }),
        ));
  }
}
