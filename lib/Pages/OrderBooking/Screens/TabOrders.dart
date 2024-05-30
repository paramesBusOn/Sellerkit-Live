// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Pages/OrderBooking/Widgets/Inprocesspage.dart';
import 'package:sellerkit/Pages/OrderBooking/Widgets/Pdf.dart';
import 'package:sellerkit/Pages/OrderBooking/Widgets/navdrawerOrder.dart';
import '../../../Controller/OrderController/TabOrderController.dart';
import '../../../Widgets/Navi3.dart';
import '../../Enquiries/EnquiriesUser/Widgets/GlobalKeys.dart';
import '../Widgets/WonOrderPage.dart';
import '../Widgets/LostOrder.dart';
import '../Widgets/OpenOrder.dart';

class OrdersTabPage extends StatefulWidget {
  OrdersTabPage({Key? key}) : super(key: key);

  @override
  State<OrdersTabPage> createState() => LeadsTabState();
}

class LeadsTabState extends State<OrdersTabPage> with TickerProviderStateMixin {
     final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();
 
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Open'),
    Tab(text: 'In-Process'),
    Tab(text: 'Closed'),
    // Tab(text: 'Lost'),
  ];
  TabController? controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3, initialIndex: 0);
            controller!.addListener(_handleTabChange);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      log("comeFromEnq: " + OrderTabController.comeFromEnq.toString());
      if (OrderTabController.comeFromEnq == -1) {
        log("comeFromEnq: 11");
        context.read<OrderTabController>().clearAllListData();
        context.read<OrderTabController>().callGetAllApi();
        // context.read<OrderTabController>().callSummaryApi();
        context.read<OrderTabController>().getLeadStatus();
      } else if (OrderTabController.comeFromEnq != -1) {
        log("comeFromEnq: 22");
        log("OrderTabController.isSameBranch: ${OrderTabController.isSameBranch}");

        if (OrderTabController.isSameBranch == true) {
          context.read<OrderTabController>().clearAllListData();
          context.read<OrderTabController>().callGetAllApi();
          // context.read<OrderTabController>().callSummaryApi();
          context.read<OrderTabController>().getLeadStatus();
          context.read<OrderTabController>().comeFromEnqApi(
              context, OrderTabController.comeFromEnq.toString());
        } else {
          context.read<OrderTabController>().clearAllListData();
          
          context.read<OrderTabController>().callGetAllApi();
          // context.read<OrderTabController>().callSummaryApi();
          context.read<OrderTabController>().getLeadStatus();
          context.read<OrderTabController>().comeFromEnqApi(
              context, OrderTabController.comeFromEnq.toString());
        }
      }
    });
  }

   void _handleTabChange() {
 setState(() {
       context.read<OrderTabController>().mycontroller[10].clear();
       context.read<OrderTabController>().setListData();
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
      child: Scaffold(  
         key: scaffoldKey1,     
       drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
           actions: [
            IconButton(
              color:Colors.transparent,
              onPressed: (){}, icon: Icon(Icons.filter_alt))
          ],
          bottom:PreferredSize(
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
                              controller:context.read<OrderTabController>().mycontroller[10] ,
                              onTap: () {

                                // Get.toNamed(ConstantRoutes.screenshot);
                              },
                              autocorrect: false,
                              onChanged: (v) {
                                if(controller!.index.toString()=="0"){
                                  
                                context.read<OrderTabController>().SearchFilterOpenTab(v);

                              }else if(controller!.index.toString()=="1"){
                             context.read<OrderTabController>().SearchFilterWonTab(v);

                                }
                                else if(controller!.index.toString()=="2"){
                             context.read<OrderTabController>().SearchFilterlostTab(v);

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
                            controller: controller,
                            tabs: myTabs,
                          ),
                        ],
                      ),
                    ),
                  ),
          title: GestureDetector(
            onTap: (){
  //              Navigator.push(
  //   context,
  //   // MaterialPageRoute(builder: (context) => const pdf()),
  // );
            },
            child: Text('Orders')),
        ),
        // :AppBar(
        //    backgroundColor: theme.primaryColor,
        //   title: Text('Leads'),),
        drawer: drawer3(context),
         endDrawer: navDrawerOrder(),
        body:
            //  ChangeNotifierProvider<OrderTabController>(
            //         create: (context) => OrderTabController(),
            //         builder: (context, child) {
            //           return Consumer<OrderTabController>(
            //               builder: (BuildContext context, provi, Widget? child) {
            //     return

            GestureDetector(
              onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.dashboard);
                      });
                    }
                  },
              child: 
          context.watch<OrderTabController>().    datagotByApi==true&&
              context.watch<OrderTabController>().getLeadCheckDataExcep.isEmpty &&
                      (   context
                              .watch<OrderTabController>()
                              .getleadSummaryOpen
                              .isNotEmpty ||
                          context
                              .watch<OrderTabController>()
                              .getleadSummaryWon
                              .isNotEmpty) &&
                      (context
                              .watch<OrderTabController>()
                              .filterleadOpenAllData
                              .isNotEmpty ||
                          context
                              .watch<OrderTabController>()
                              .filterleadinProcessAllData
                              .isNotEmpty||context
                                  .watch<OrderTabController>()
                                  .filterleadClosedAllData
                                  .isNotEmpty)
                  ? TabBarView(controller: controller, children: [
                      OpenOrderPage(
                        theme: theme,
                        leadOpenAllData:
                            context.read<OrderTabController>().filterleadOpenAllData,
                        leadSummaryOpen:
                            context.read<OrderTabController>().getleadSummaryOpen,
                        provi: context.watch<OrderTabController>(),
                      ),
                      InProcessPage(
                        theme: theme,
                        InProcessAllData: context
                            .read<OrderTabController>()
                            .filterleadinProcessAllData,
                        leadSummaryinprocess:
                            context.read<OrderTabController>().getleadSummaryinprocess,
                        provi: context.read<OrderTabController>(),
                      ),
                      WonOrderPage(
                        theme: theme,
                        leadWonAllData: context
                            .read<OrderTabController>()
                            .filterleadClosedAllData,
                        leadSummaryWon:
                            context.read<OrderTabController>().getleadSummaryWon,
                        provi: context.read<OrderTabController>(),
                      ),
                    ])
                  :context.watch<OrderTabController>().    datagotByApi==true&& 

                   context
                              .watch<OrderTabController>()
                              .getLeadCheckDataExcep
                              .isEmpty 
                              &&
                          // (   context
                          //         .watch<OrderTabController>()
                          //         .getleadSummaryOpen
                          //         .isEmpty &&
                          //     context
                          //         .watch<OrderTabController>()
                          //         .getleadSummaryWon
                          //         .isEmpty) &&
                          (context
                                  .watch<OrderTabController>()
                                  .filterleadOpenAllData
                                  .isEmpty &&
                              context
                                  .watch<OrderTabController>()
                                  .filterleadinProcessAllData
                                  .isEmpty&&context
                                  .watch<OrderTabController>()
                                  .filterleadClosedAllData
                                  .isEmpty)?Center(child:Column(
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
                                      Text("No data..!!",textAlign: TextAlign.center,),
                                    ],
                                  )):
                  context.watch<OrderTabController>().    datagotByApi==false&&
                  context
                              .watch<OrderTabController>()
                              .getLeadCheckDataExcep
                              .isEmpty 
                              &&
                          // (   context
                          //         .watch<OrderTabController>()
                          //         .getleadSummaryOpen
                          //         .isEmpty &&
                          //     context
                          //         .watch<OrderTabController>()
                          //         .getleadSummaryWon
                          //         .isEmpty) &&
                          (context
                                  .watch<OrderTabController>()
                                  .filterleadOpenAllData
                                  .isEmpty &&
                              context
                                  .watch<OrderTabController>()
                                  .filterleadinProcessAllData
                                  .isEmpty&&context
                                  .watch<OrderTabController>()
                                  .filterleadClosedAllData
                                  .isEmpty)
                      ? Center(child: CircularProgressIndicator())
                      : 
                      Center(
                          child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                 context.watch<OrderTabController>().lottie!.isEmpty?Container():
                                context.watch<OrderTabController>().lottie!.isNotEmpty && context.watch<OrderTabController>().lottie!.contains(".png")?     InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('${context.watch<OrderTabController>().lottie}',
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
                    child: Lottie.asset('${context.watch<OrderTabController>().lottie}',
                        animate: true,
                        repeat: true,
                        // height: Screens.padingHeight(context) * 0.3,
                        width: Screens.width(context) * 0.4),
                  ),
                     
                              Text(context
                                  .watch<OrderTabController>()
                                  .getLeadCheckDataExcep,textAlign: TextAlign.center,),
                            ],
                          ),
                        ),
            ),
        //      }
        //     );
        //   }
        // ),
        floatingActionButton: Column(
         mainAxisAlignment: MainAxisAlignment.end,
          children: [
             FloatingActionButton(
              heroTag :'bt1',
              onPressed: () {
                 context.read<OrderTabController> (). clearfilterval();
                 context.read<OrderTabController> ().  getdbmodel();
                scaffoldKey1.currentState?.openEndDrawer();
              },
              child: Icon(Icons.filter_alt),
            ),
            SizedBox(
              height: Screens.padingHeight(context)*0.01,
            ),
            FloatingActionButton(
              heroTag :'bt2',
              onPressed: () {
                Get.toNamed(ConstantRoutes.ordernew)!.then((value) {});
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
