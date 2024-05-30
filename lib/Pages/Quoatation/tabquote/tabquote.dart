// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/QuotationController/tabquotescontroller.dart';
import 'package:sellerkit/Pages/Quoatation/tabquote/widgets/closequote.dart';
import 'package:sellerkit/Pages/Quoatation/tabquote/widgets/navdrawerQuotes.dart';
import 'package:sellerkit/Pages/Quoatation/tabquote/widgets/openquote.dart';
import 'package:sellerkit/Widgets/Navi3.dart';

class quotepage extends StatefulWidget {
  const quotepage({Key? key}) : super(key: key);

  @override
  State<quotepage> createState() => _quotepageState();
}

class _quotepageState extends State<quotepage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();
 
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Open'),
    Tab(text: 'Closed'),
  ];
  @override
  void initState() {
    super.initState();
     context.read<QuotestabController>(). controller = new TabController(vsync: this, length: 2, initialIndex: 0);
     context.read<QuotestabController>(). controller!.addListener(_handleTabChange);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<QuotestabController>().clearAllListData();
      context.read<QuotestabController>().callgetAllApi(context);
    });
  }

  @override
  DateTime? currentBackPressTime;
  void _handleTabChange() {
    setState(() {
      context.read<QuotestabController>().mycontroller[5].clear();
      context.read<QuotestabController>().setListData();
    });
  }

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

  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
         key: scaffoldKey1,     
        appBar: AppBar(
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ]),
                    child: TextField(
                      controller:
                          context.read<QuotestabController>().mycontroller[5],
                      onTap: () {
                        // Get.toNamed(ConstantRoutes.screenshot);
                      },
                      autocorrect: false,
                      onChanged: (v) {
                        if (  context.read<QuotestabController>().controller!.index.toString() == "0") {
                          context
                              .read<QuotestabController>()
                              .SearchFilterOpenTab(v);
                        } else if (  context.read<QuotestabController>().controller!.index.toString() == "1") {
                          context
                              .read<QuotestabController>()
                              .SearchFilterlostTab(v);
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
                    controller:  context.read<QuotestabController>(). controller,
                    tabs: myTabs,
                  ),
                ],
              ),
            ),
          ),
          title: Text('Quotes'),
        ),
        drawer: drawer3(context),
         endDrawer: navDrawerQuotes(),
        body: TickerMode(
          enabled: true,
          // ignore: prefer_const_literals_to_create_immutables
          child: context
                      .watch<QuotestabController>()
                      .getLeadCheckDataExcep
                      .isEmpty &&
                  (context
                          .watch<QuotestabController>()
                          .filterQuotesOpenAllData
                          .isNotEmpty ||
                      context
                          .watch<QuotestabController>()
                          .filterQuotesClosedAllData
                          .isNotEmpty)
              ? TabBarView(controller:  context.read<QuotestabController>(). controller, children: [
                  openquote(
                    theme: theme,
                    leadOpenAllData: context
                        .watch<QuotestabController>()
                        .filterQuotesOpenAllData,
                    provi: context.watch<QuotestabController>(),
                  ),
                  closequote(
                    theme: theme,
                    leadWonAllData: context
                        .watch<QuotestabController>()
                        .filterQuotesClosedAllData,
                    provi: context.watch<QuotestabController>(),
                  ),
                ])
              : context
                          .watch<QuotestabController>()
                          .getLeadCheckDataExcep
                          .isEmpty &&
                      // (   context
                      //         .watch<OrderTabController>()
                      //         .getleadSummaryOpen
                      //         .isEmpty &&
                      //     context
                      //         .watch<OrderTabController>()
                      //         .getleadSummaryWon
                      //         .isEmpty) &&
                  (context
                              .watch<QuotestabController>()
                              .filterQuotesOpenAllData
                              .isEmpty &&
                          context
                              .watch<QuotestabController>()
                              .filterQuotesClosedAllData
                              .isEmpty &&context
                          .watch<QuotestabController>()
                          .datagotByApi ==true)?Center(child:Column(
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
                              Text("No Data..!!",textAlign: TextAlign.center,),
                            ],
                          )) :    (context
                              .watch<QuotestabController>()
                              .filterQuotesOpenAllData
                              .isEmpty &&
                          context
                              .watch<QuotestabController>()
                              .filterQuotesClosedAllData
                              .isEmpty &&context
                          .watch<QuotestabController>()
                          .datagotByApi ==false &&context
                          .watch<QuotestabController>()
                          .getLeadCheckDataExcep
                          .isEmpty 
                          )
                  ? Center(child: CircularProgressIndicator())
                  : Center(
                      child: Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           context.watch<QuotestabController>().lottie!.isEmpty?Container():
                                context.watch<QuotestabController>().lottie!.isNotEmpty && context.watch<QuotestabController>().lottie!.contains(".png")?     InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('${context.watch<QuotestabController>().lottie}',
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
                    child: Lottie.asset('${context.watch<QuotestabController>().lottie}',
                        animate: true,
                        repeat: true,
                        // height: Screens.padingHeight(context) * 0.3,
                        width: Screens.width(context) * 0.4),
                  ),
                          Text(context
                              .watch<QuotestabController>()
                              .getLeadCheckDataExcep,textAlign: TextAlign.center,),
                        ],
                      ),
                    ),
        ),
        floatingActionButton: Column(
         mainAxisAlignment: MainAxisAlignment.end,
          children: [
             FloatingActionButton(
              heroTag :'bt1',
              onPressed: () {
               context.read<QuotestabController>().  clearfilterval();
                context.read<QuotestabController>().getQuotDataDb();
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
                // context.read<NewEnqController>().clearAllData();
                Get.toNamed(ConstantRoutes.quotesnew);
                // .then((value) {
                //   // context.read<EnquiryUserContoller>().resetAll(context);
                // });
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
