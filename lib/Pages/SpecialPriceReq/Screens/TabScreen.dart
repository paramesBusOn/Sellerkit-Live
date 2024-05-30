import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/specialpricecontroller/tabcontroller.dart';
import 'package:sellerkit/Pages/SpecialPriceReq/widgets/approvedpricepage.dart';
import 'package:sellerkit/Pages/SpecialPriceReq/widgets/openpricepage.dart';
import 'package:sellerkit/Pages/SpecialPriceReq/widgets/rejectpage.dart';
import 'package:sellerkit/Widgets/Navi3.dart';

class SpecialPriceReq extends StatefulWidget {
  const SpecialPriceReq({Key? key}) : super(key: key);

  @override
  State<SpecialPriceReq> createState() => _SpecialPriceReqState();
}

class _SpecialPriceReqState extends State<SpecialPriceReq>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Open'),
    Tab(text: 'Approved'),
    Tab(text: 'Rejected'),
  ];
  TabController? controller;
  void _handleTabChange() {
    setState(() {
      context.read<tabpriceController>().mycontroller[5].text = '';
      context.read<tabpriceController>().setListData();
    });
  }

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3, initialIndex: 0);
    controller!.addListener(_handleTabChange);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<tabpriceController>().init();
      });
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
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
        
        key: scaffoldKey1,
        drawerEnableOpenDragGesture: false,
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
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
                        borderRadius:
                            BorderRadius.circular(Screens.width(context) * 0.01),
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
                          context.read<tabpriceController>().mycontroller[5],
                      onTap: () {
                        // Get.toNamed(ConstantRoutes.screenshot);
                      },
                      autocorrect: false,
                      onChanged: (v) {
                        if (controller!.index.toString() == "0") {
                          setState(() {
                            context
                                .read<tabpriceController>()
                                .SearchFilterOpenTab(v);
                          });
                        } else if (controller!.index.toString() == "1") {
                          setState(() {
                            context
                                .read<tabpriceController>()
                                .SearchFilterWonTab(v);
                          });
                        } else {
                          setState(() {
                            context
                                .read<tabpriceController>()
                                .SearchFilterLostTab(v);
                          });
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
          title: const Text('Special Price Request'),
        ),
        drawer: drawer3(context),
        body: context.watch<tabpriceController>().datagotByApi == true &&
                context.watch<tabpriceController>().leadCheckDataExcep!.isEmpty &&
                (context
                        .watch<tabpriceController>()
                        .filteropenSPdata
                        .isNotEmpty ||
                    context
                        .watch<tabpriceController>()
                        .filterApprovedSpdata
                        .isNotEmpty ||
                    context
                        .watch<tabpriceController>()
                        .filterRejectSpdata
                        .isNotEmpty)
            ? TabBarView(controller: controller, children: [
                openpriccepage(
                    theme: theme,
                    filtertabdata:
                        context.read<tabpriceController>().filteropenSPdata,
                        provi: context.watch<tabpriceController>(),
                        ),
                Approvedpage(
                    theme: theme,
                    filtertabdata:
                        context.read<tabpriceController>().filterApprovedSpdata,
                        provi: context.watch<tabpriceController>(),
                        ),
                Rejectpage(
                    theme: theme,
                    filtertabdata:
                        context.read<tabpriceController>().filterRejectSpdata,
                        provi: context.watch<tabpriceController>(),),
              ])
            : context.watch<tabpriceController>().datagotByApi == true &&
                    context
                        .watch<tabpriceController>()
                        .leadCheckDataExcep!
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
                            .watch<tabpriceController>()
                            .filteropenSPdata
                            .isEmpty &&
                        context
                            .watch<tabpriceController>()
                            .filterApprovedSpdata
                            .isEmpty &&
                        context
                            .watch<tabpriceController>()
                            .filterRejectSpdata
                            .isEmpty)
                ? Center(
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
                      Text(
                        "No data..!!",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ))
                : context.watch<tabpriceController>().datagotByApi == false &&
                        context
                            .watch<tabpriceController>()
                            .leadCheckDataExcep!
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
                                .watch<tabpriceController>()
                                .filteropenSPdata
                                .isEmpty &&
                            context
                                .watch<tabpriceController>()
                                .filterApprovedSpdata
                                .isEmpty &&
                            context
                                .watch<tabpriceController>()
                                .filterRejectSpdata
                                .isEmpty)
                    ? Center(child: CircularProgressIndicator())
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            context.watch<tabpriceController>().lottie!.isEmpty
                                ? Container()
                                : context
                                            .watch<tabpriceController>()
                                            .lottie!
                                            .isNotEmpty &&
                                        context
                                            .watch<tabpriceController>()
                                            .lottie!
                                            .contains(".png")
                                    ? InkWell(
                                        onTap: () {
                                          // HelperFunctions.clearCheckedOnBoardSharedPref();
                                          // HelperFunctions.clearUserLoggedInSharedPref();
                                        },
                                        child: Image.asset(
                                            '${context.watch<tabpriceController>().lottie}',
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
                                            width: Screens.width(context) * 0.5),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          // HelperFunctions.clearCheckedOnBoardSharedPref();
                                          // HelperFunctions.clearUserLoggedInSharedPref();
                                        },
                                        child: Lottie.asset(
                                            '${context.watch<tabpriceController>().lottie}',
                                            animate: true,
                                            repeat: true,
                                            // height: Screens.padingHeight(context) * 0.3,
                                            width: Screens.width(context) * 0.4),
                                      ),
                            Text(
                              context
                                  .watch<tabpriceController>()
                                  .leadCheckDataExcep!,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(ConstantRoutes.newpriceReq);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
