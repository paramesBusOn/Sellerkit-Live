// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import '../../../Constant/MenuAuth.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/EnquiryController/EnquiryMngController.dart';
import '../../../Controller/EnquiryController/NewEnqController.dart';
import '../../../Widgets/Navi3.dart';
import 'Widgets/AssignedEnq.dart';
import 'Widgets/LostEnq.dart';
import 'Widgets/UnassignedEnq.dart';

class EnquiryManagerPage extends StatefulWidget {
  EnquiryManagerPage({Key? key}) : super(key: key);

  @override
  State<EnquiryManagerPage> createState() => _EnquiryPageState();
}

class  _EnquiryPageState extends State<EnquiryManagerPage>
    with TickerProviderStateMixin {
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Assigned'),
    Tab(text: 'Unassigned'),
    Tab(text: 'Lost'),
  ];
  TabController? controller;
  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3, initialIndex: 0);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        log("enq data prev : "+EnquiryMangerContoller.enqDataprev.toString());
        if(EnquiryMangerContoller.enqDataprev == 0){
      context.read<EnquiryMangerContoller>().callApi();
      context.read<EnquiryMangerContoller>().callUserListApi();
      context.read<EnquiryMangerContoller>().callResonApi();
        }else{
           context.read<EnquiryMangerContoller>().resetAll(context);
        }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
     EnquiryMangerContoller.enqDataprev = 0;
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
    return 
    WillPopScope(
      onWillPop:onbackpress ,
      child: Scaffold(
        appBar:
        context.watch<EnquiryMangerContoller>().getdatagotByApi == true
         &&  context.watch<EnquiryMangerContoller>().getException==false?
         AppBar(
          backgroundColor: theme.primaryColor,
          bottom: TabBar(
          // key: RIKeys.riKey2,
            controller: controller,
            tabs: myTabs,
          ),
          title: Text('Enquiries'),
        ):AppBar(
           backgroundColor: theme.primaryColor,
          title: Text('Enquiries'),),
        drawer: drawer3(context),
        body: context.watch<EnquiryMangerContoller>().getdatagotByApi == true
        &&
          (context.watch<EnquiryMangerContoller>().getassignedEnqData.isNotEmpty || 
          context.watch<EnquiryMangerContoller>().getunassignedEnqdata.isNotEmpty ||
          context.watch<EnquiryMangerContoller>().getlostEnqdata.isNotEmpty
           )
         &&  context.watch<EnquiryMangerContoller>().getException==false?
        TabBarView(controller: controller,
      //  key: RIKeys.riKey1,
            // physics: const NeverScrollableScrollPhysics(),
            children: [
              AssignedPage(theme: theme),
              UnAssignedPage(theme: theme),
              LostEnqPage(theme: theme),
            ]):
             context.watch<EnquiryMangerContoller>().getdatagotByApi == false&&
          (   context.watch<EnquiryMangerContoller>().getassignedEnqData.isEmpty ||
          context.watch<EnquiryMangerContoller>().getunassignedEnqdata.isEmpty ||
          context.watch<EnquiryMangerContoller>().getlostEnqdata.isEmpty
           ) &&  context.watch<EnquiryMangerContoller>().getException==true?
         Center(child: Text(context.watch<EnquiryMangerContoller>().getErrorMsg))
         :
            Center(child: CircularProgressIndicator()),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (MenuAuthDetail.Enquiries == "Y") {
               context.read<NewEnqController>().clearAllData();
          Get.toNamed(ConstantRoutes.newEnq)!.then((value) {
         context.read<EnquiryMangerContoller>().resetAll(context);
          });
            } else {
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        contentPadding: EdgeInsets.all(0),
                        insetPadding:
                            EdgeInsets.all(Screens.bodyheight(context) * 0.02),
                        content: settings(context));
                  });
            }       
        },
        child: Icon(Icons.add),
      ),
      ),
    );
  }
}


