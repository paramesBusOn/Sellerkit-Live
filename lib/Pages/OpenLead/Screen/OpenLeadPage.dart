// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Pages/OpenLead/Screen/FilterOpenLeadPage.dart';
import 'package:sellerkit/Pages/OpenLead/Screen/OpLViewAll.dart';
import 'package:sellerkit/Pages/OpenLead/Widegts/navdraweropenlead.dart';
import '../../../Controller/OpenLeadController/OpenLeadController.dart';
import '../../../Widgets/Navi3.dart';
import '../Widegts/OpenLeadFDP.dart';
import 'OpenLeadFPFilt.dart';

class OpenLeadPageFoll extends StatefulWidget {
  OpenLeadPageFoll({Key? key}) : super(key: key);

  @override
  State<OpenLeadPageFoll> createState() => OpenLeadPageFollState();
}

class OpenLeadPageFollState extends State<OpenLeadPageFoll> {
    final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OpenLeadController>().callGetAllApi();
      context.read<OpenLeadController>().getDataOnLoad();
    context.read<OpenLeadController>().  callinitApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // return
    // ChangeNotifierProvider<OpenLeadController>(
    //                   create: (context) => OpenLeadController(),
    //                   builder: (context, child) {
    //                     return Consumer<OpenLeadController>(
    //                         builder: (BuildContext context, prdFUP, Widget? child) {
    return WillPopScope(
      onWillPop: context.read<OpenLeadController>().onbackpress,
      child: Scaffold(
        key: scaffoldKey1,
          drawerEnableOpenDragGesture: false,
          appBar: AppBar(
            backgroundColor: theme.primaryColor,
            title: Text('Open Lead'),
             actions: [
            IconButton(
              color:Colors.transparent,
              onPressed: (){}, icon: Icon(Icons.filter_alt))
          ],
            
          ),
          
          drawer: drawer3(context),
            endDrawer: navDraweropenlead(),
          body:
              //  ChangeNotifierProvider<OpenLeadController>(
              //     create: (context) => OpenLeadController(),
              //     builder: (context, child) {
              //       return Consumer<OpenLeadController>(
              //           builder: (BuildContext context, prdFUP, Widget? child) {
              GestureDetector(onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.dashboard);
                      });
                    }
                  },
                child: 
                (context.watch<OpenLeadController>().errorMsg == '' &&
                        context
                            .watch<OpenLeadController>()
                            .leadOpenAllData
                            .isEmpty)&&  context
                            .watch<OpenLeadController>()
                            . isloading==true
                    ? Center(child: CircularProgressIndicator()):
                     (context.watch<OpenLeadController>().errorMsg == '' &&
                        context
                            .watch<OpenLeadController>()
                            .leadOpenAllData
                            .isEmpty)&&  context
                            .watch<OpenLeadController>()
                            . isloading==false? Center(child: Column(
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
                         Text("No Data..!!",textAlign: TextAlign.center),
                       ],
                     ))
                    : (context.watch<OpenLeadController>().errorMsg != '' &&
                            context
                                .watch<OpenLeadController>()
                                .leadOpenAllData
                                .isEmpty)
                        ? Center(
                            child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                                       
                              children: [
                                 context.watch<OpenLeadController>().lottie!.isEmpty?Container():
                                context.watch<OpenLeadController>().lottie!.isNotEmpty && context.watch<OpenLeadController>().lottie!.contains(".png")?     InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('${context.watch<OpenLeadController>().lottie}',
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
                    child: Lottie.asset('${context.watch<OpenLeadController>().lottie}',
                        animate: true,
                        repeat: true,
                        // height: Screens.padingHeight(context) * 0.3,
                        width: Screens.width(context) * 0.4),
                  ),
                                Text(
                                    context.watch<OpenLeadController>().geterrorMsg,textAlign: TextAlign.center,),
                              ],
                            ))
                        : 
                        PageView(
                            physics: new NeverScrollableScrollPhysics(),
                            controller: context
                                .watch<OpenLeadController>()
                                .pageController,
                            onPageChanged: (index) {
                              setState(() {
                                context.read<OpenLeadController>().pageChanged =
                                    index;
                              });
                              print(
                                  context.read<OpenLeadController>().pageChanged);
                            },
                            children: [
                              ListViewOpenLead(
                                theme: theme,
                              ),
                              FilterOpenLeadPage(),
                              OPLViewALL()
                            ],
                          )
              ),
              floatingActionButton: Column(
         mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag :'bt1',
              onPressed: () {
                 context.read<OpenLeadController> (). clearfilterval();
                 context.read<OpenLeadController> ().  getdbmodel();
               scaffoldKey1.currentState?.openEndDrawer();
              },
              child: Icon(Icons.filter_alt),
            ),
            SizedBox(
              height: Screens.padingHeight(context)*0.01,
            ),
          // FloatingActionButton(
          //    heroTag :'bt2',
          //   onPressed: () {
          //     Get.toNamed(ConstantRoutes.leads)!.then((value) {
          //     });
          //   },
          //   child: Icon(Icons.add),
          // ),
        ],
      ),
              ),
    );
    
    //       }
    //     );
    //   }
    // );
  }
}
