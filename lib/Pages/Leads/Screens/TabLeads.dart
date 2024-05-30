// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Pages/Leads/Widgets/navdrawerlead.dart';
import '../../../Controller/LeadController/TabLeadController.dart';
import '../../../Widgets/Navi3.dart';
import '../../Enquiries/EnquiriesUser/Widgets/GlobalKeys.dart';
import '../Widgets/WonLeadPage.dart';
import '../Widgets/LostLead.dart';
import '../Widgets/OpenLead.dart';

class LeadsTabPage extends StatefulWidget {
  LeadsTabPage({Key? key}) : super(key: key);

  @override
  State<LeadsTabPage> createState() =>LeadsTabState();
}

class LeadsTabState extends State<LeadsTabPage>
    with TickerProviderStateMixin {
        final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();
 
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Open'),
    Tab(text: 'Won'),
    Tab(text: 'Lost'),
  ];
  TabController? controller;
  @override
  void initState() {
    
    super.initState();
    controller = new TabController(vsync: this, length: 3, initialIndex: 0);
        controller!.addListener(_handleTabChange);

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       print("Tab Name::"+controller!.index. toString());
               setState(() {
                 log("comeFromEnq: "+LeadTabController.comeFromEnq.toString());
        if(LeadTabController.comeFromEnq==-1){
           log("comeFromEnq: 11");
             context.read<LeadTabController>().clearAllListData();
           context.read<LeadTabController>().getLeadStatus();
      //  context.read<LeadTabController>().   callinitApi();
          
            context.read<LeadTabController>().callGetAllApi();
        
            
        }else if(LeadTabController.comeFromEnq!=-1){
           log("comeFromEnq: 22");
           log("LeadTabController.isSameBranch: ${LeadTabController.isSameBranch}");
                          
           if( LeadTabController.isSameBranch == true){
            context.read<LeadTabController>().   callinitApi();
             context.read<LeadTabController>().clearAllListData();
            context.read<LeadTabController>().callGetAllApi();
            // context.read<LeadTabController>().callSummaryApi();
            context.read<LeadTabController>().getLeadStatus();
             context.read<LeadTabController>().comeFromEnqApi( context,LeadTabController.comeFromEnq.toString());
           }
           else{
            context.read<LeadTabController>().   callinitApi();
              context.read<LeadTabController>().clearAllListData();
            context.read<LeadTabController>().callGetAllApi();
            // context.read<LeadTabController>().callSummaryApi();
            context.read<LeadTabController>().getLeadStatus();
            context.read<LeadTabController>().comeFromEnqApi( context,LeadTabController.comeFromEnq.toString());
           }       
        }
               });
        
    });
  }

   void _handleTabChange() {
  setState(() {
    context.read<LeadTabController>().mycontroller[5].text='';  
   context.read<LeadTabController>().setListData();
   });     
 }


   DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
  
      if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        print("object");
        Get.offAllNamed(ConstantRoutes.dashboard);
        return Future.value(true);
      } else {
        return Future.value(true);
      }
    }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return 
    WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
         key: scaffoldKey1,
        drawerEnableOpenDragGesture: false,
        appBar:
         AppBar(
          backgroundColor: theme.primaryColor,
            actions: [
            IconButton(
              color:Colors.transparent,
              onPressed: (){}, icon: Icon(Icons.filter_alt))
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
                              controller:context.read<LeadTabController>().mycontroller[5] ,
                              onTap: () {

                                // Get.toNamed(ConstantRoutes.screenshot);
                              },
                              autocorrect: false,
                              onChanged: (v) {
                                if(controller!.index.toString()=="0"){
                                  
                                context.read<LeadTabController>().SearchFilterOpenTab(v);

                              }else if(controller!.index.toString()=="1"){
                                                                  context.read<LeadTabController>().SearchFilterWonTab(v);

                                }else{
                                context.read<LeadTabController>().SearchFilterLostTab(v);

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
          title: Text('Leads'),
        ),
        // :AppBar(
        //    backgroundColor: theme.primaryColor,
        //   title: Text('Leads'),),
        drawer: drawer3(context),
         endDrawer: navDrawerlead(),
        body: 
      //  ChangeNotifierProvider<LeadTabController>(
      //         create: (context) => LeadTabController(),
      //         builder: (context, child) {
      //           return Consumer<LeadTabController>(
      //               builder: (BuildContext context, provi, Widget? child) {
           //     return 
                  
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
context.watch<LeadTabController>().datagotByApi==false?
                          Center(child: CircularProgressIndicator()):
                        //  context.watch<LeadTabController>().isbool==true?
                        //  Center(child: CircularProgressIndicator(),):
                        context.watch<LeadTabController>().datagotByApi==true &&
                          context.watch<LeadTabController>().getLeadCheckDataExcep.isEmpty&&
                                      (
                                        context.watch<LeadTabController>().getleadSummaryLost.isNotEmpty||
                                        context.watch<LeadTabController>().getleadSummaryOpen.isNotEmpty||
                                        context.watch<LeadTabController>().getleadSummaryWon.isNotEmpty
                                      ) &&
                                       ( context.watch<LeadTabController>().filterleadOpenAllData.isNotEmpty ||
                                        context.watch<LeadTabController>().filterleadLostAllData.isNotEmpty||
                                        context.watch<LeadTabController>().filterleadClosedAllData.isNotEmpty
                                       )?
                                       TabBarView(
                                           controller: controller,
                                           children: [
                                             OpenLeadPage(theme: theme, leadOpenAllData: context.read<LeadTabController>().filterleadOpenAllData, 
                                             leadSummaryOpen: context.read<LeadTabController>().getleadSummaryOpen, 
                                             provi: context.watch<LeadTabController>(),),
                                             WonLeadPage(theme: theme, leadWonAllData: 
                                             context.read<LeadTabController>().filterleadClosedAllData, 
                                             leadSummaryWon: context.read<LeadTabController>().getleadSummaryWon,
                         provi: context.read<LeadTabController>(),),
                                             LostLeadPage(theme: theme, leadLostAllData: context.read<LeadTabController>().filterleadLostAllData, 
                                             leadSummaryLost: context.read<LeadTabController>().getleadSummaryLost, 
                                             provi: context.read<LeadTabController>(),),
                                           ])
                                          :
                                    context.watch<LeadTabController>().datagotByApi==true &&
                                      context.watch<LeadTabController>().getLeadCheckDataExcep.isNotEmpty
                                       
                                       ?
                                       Center(child: Column(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                             context.watch<LeadTabController>().lottie!.isEmpty?Container():
                                context.watch<LeadTabController>().lottie!.isNotEmpty && context.watch<LeadTabController>().lottie!.contains(".png")?     InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('${context.watch<LeadTabController>().lottie}',
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
                    child: Lottie.asset('${context.watch<LeadTabController>().lottie}',
                        animate: true,
                        repeat: true,
                        // height: Screens.padingHeight(context) * 0.3,
                        width: Screens.width(context) * 0.4),
                  ),
                                           Text(context.watch<LeadTabController>().getLeadCheckDataExcep,textAlign: TextAlign.center,),
                                         ],
                                       )
                                         )  
                                          :
                                      //     context.watch<LeadTabController>().datagotByApi==true
                                      //      &&
                                      // context.watch<LeadTabController>().getLeadCheckDataExcep.isEmpty
                                      //  &&
                                      //      (
                                      //   context.watch<LeadTabController>().getleadSummaryLost.isEmpty&&
                                      //   context.watch<LeadTabController>().getleadSummaryOpen.isEmpty&&
                                      //   context.watch<LeadTabController>().getleadSummaryWon.isEmpty
                                      // ) ||
                                      //   ( context.watch<LeadTabController>().filterleadOpenAllData.isEmpty ||
                                      //   context.watch<LeadTabController>().filterleadLostAllData.isEmpty||
                                      //   context.watch<LeadTabController>().filterleadClosedAllData.isEmpty
                                      //  )? 
                                       Center(child:Column(
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
                                       ))
                                       
                                      
                                      
                                       
                                        ,
                                           
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
                 context.read<LeadTabController> (). clearfilterval();
                 context.read<LeadTabController> ().  getdbmodel();
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
              Get.toNamed(ConstantRoutes.leads)!.then((value) {
              });
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      ),
    );
  }
}


