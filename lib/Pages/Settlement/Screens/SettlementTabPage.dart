// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Controller/SettlementController/SettlementController.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/NEFTTab.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/UPITab.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/finalshowdata.dart';
import 'package:sellerkit/Widgets/Navi3.dart';

import '../Widgets/CardTab.dart';
import '../Widgets/CashTab.dart';
import '../Widgets/ChequeTab.dart';

class SettlementTabPage extends StatefulWidget {
  SettlementTabPage({Key? key}) : super(key: key);

  @override
  State<SettlementTabPage> createState() => _EnquiryPageState();
}

class _EnquiryPageState extends State<SettlementTabPage>
    with TickerProviderStateMixin  {
      //  TabController? controller;
      
  static const List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Cash',
    ),
    Tab(text: 'Card'),
    Tab(text: 'Cheque'),
    Tab(text: 'UPI'),
    Tab(text: 'NEFT'),
  ];
  TabController? controller;
  @override
  void initState() {
    super.initState();
    // controller = TabController(vsync: this, length: 5,);
      // controller!.addListener(onfocus);
     
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
    await context.read<SettlementController>().init(context); 
    
    // if(mounted){
 _updateTabController(context.read<SettlementController>().dupdatalist.isEmpty?5:  context.read<SettlementController>().dupdatalist.length);
     
    //  }
     
        // count =context.read<SettlementController>().dupdatalist.isEmpty?5:context.read<SettlementController>().dupdatalist.length;
  
    });
//  controller = new TabController(vsync: this, length:context.read<SettlementController>().dupdatalist.isNotEmpty?context.read<SettlementController>().dupdatalist.length: 5, initialIndex: 0);
  
  }
//   onfocus(){
//    if(context.watch<SettlementController>().dupdatalist!.isEmpty){
//  setState(() {
//    controller = TabController(vsync: this, length: 5,);
//  });
    
//    } else{
//     setState(() {
//    controller = TabController(vsync: this, length: context.watch<SettlementController>().dupdatalist.length,);
 
//  });
//       }
//   }
int count=5;
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // final settlementController = Provider.of<SettlementController>(context);
  if(controller == null || controller!.length != context.watch<SettlementController>().dupdatalist.length){
   _updateTabController(context.watch<SettlementController>().dupdatalist.isEmpty?5:context.read<SettlementController>().dupdatalist.length);

  }
   // count =context.read<SettlementController>().dupdatalist.isEmpty?5:context.read<SettlementController>().dupdatalist.length;
  
  }
  void _updateTabController(int length) {
  //    final tabCount = context.read<SettlementController>().dupdatalist.isEmpty ? 5 : context.read<SettlementController>().dupdatalist.length;
  //  count = tabCount;
    if (controller != null) {
      controller!.dispose();
    }
    // else{
    //   setState(() {
      
      
      
    // });
    // }
   controller = TabController(vsync: this, length: length,);
  }
  @override
  void dispose() {
    // TODO: implement dispose
     controller?.dispose();
    super.dispose();
  }
    getModes() {
    if(context.read<SettlementController>().dupdatalist.isEmpty){
      return 5;
    }
    return context.read<SettlementController>().dupdatalist.length;
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
      child: 
           Scaffold(       
            drawerEnableOpenDragGesture: false,
          
            appBar: AppBar(
              backgroundColor: theme.primaryColor,
              bottom:controller !=null? TabBar(
                isScrollable: true,
                // key: RIKeys.riKey2,
                controller: controller,
                 
                tabs:context.watch<SettlementController>().dupdatalist.isNotEmpty?context.read<SettlementController>().dupdatalist.map((tab) => Tab(text: tab.Name)).toList(): myTabs,
              ):null,
              title: Text('Settlement'),
            ),
            drawer: drawer3(context),
            body: TabBarView(
              controller: controller,
              // physics:NeverScrollableScrollPhysics(),
                //  key: RIKeys.riKey1,
                // physics: const NeverScrollableScrollPhysics(),
                children:context.read<SettlementController>().dupdatalist.isNotEmpty? context.read<SettlementController>().dupdatalist.map((data) {
              return finalshown(theme: theme,name:  data.Name!);
            }).toList():
                 [
                  CashTabPage(theme: theme),
                  CardTabPage(theme: theme),
                  ChequeTabPage(theme: theme),
                  UPITabPage(theme: theme),
                  NEFTTabPage(theme: theme),
                ]
                
                ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     if (MenuAuthDetail.Enquiries == "Y") {
            //       context.read<NewEnqController>().clearAllData();
            //       Get.toNamed(ConstantRoutes.newEnq)!.then((value) {
            //         context.read<EnquiryMangerContoller>().resetAll(context);
            //       });
            //     } else {
            //       showDialog(
            //           context: context,
            //           barrierDismissible: true,
            //           builder: (BuildContext context) {
            //             return AlertDialog(
            //                 shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.all(Radius.circular(4))),
            //                 contentPadding: EdgeInsets.all(0),
            //                 insetPadding:
            //                     EdgeInsets.all(Screens.bodyheight(context) * 0.02),
            //                 content: settings(context));
            //           });
            //     }
            //   },
            //   child: Icon(Icons.add),
            // ),
          )
       
    );
  }
}
