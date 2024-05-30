// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, implementation_imports, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Constant/padings.dart';
import 'package:sellerkit/Controller/CollectionController/CollectionController.dart';
import 'package:sellerkit/Widgets/Navi3.dart';
import 'package:sellerkit/main.dart';

class Collections extends StatefulWidget {
  const Collections({Key? key}) : super(key: key);

  @override
  State<Collections> createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections>
    with TickerProviderStateMixin {
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();

  @override
  void initState() {
    // TODO: implement initState
    controller = new TabController(vsync: this, length: 2, initialIndex: 0);
    controller!.addListener(_handleTabChange);
// callKpiApi();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ColletionContoller>().init();
    });
  }

  void _handleTabChange() {
    setState(() {
     context.read<ColletionContoller>(). mycontroller[0].text ='';
    });
  }

  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Unsettled'),
    Tab(text: 'Settled'),
    // Tab(text: 'Lost'),
  ];
  TabController? controller;

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
          drawerEnableOpenDragGesture: false,
          // key: scaffoldKey,
          drawer: drawer3(context),
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
                          borderRadius: BorderRadius.circular(
                              Screens.width(context) * 0.01),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 3,
                              blurRadius: 4,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ]),
                      child: TextField(
                        controller:
                            context.read<ColletionContoller>().mycontroller[0],
                        onTap: () {
                          // Get.toNamed(ConstantRoutes.screenshot);
                        },
                        autocorrect: false,
                        onChanged: (v) {
                          if (controller!.index.toString() == "0") {
                            context
                                .read<ColletionContoller>()
                                .SearchFilterOpenTab(v);
                          } else if (controller!.index.toString() == "1") {
                            context
                                .read<ColletionContoller>()
                                .SearchFilterCloseTab(v);
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
            title: GestureDetector(onTap: () {}, child: Text('Collection')),
          ),
          // :AppBar(
          //    backgroundColor: theme.primaryColor,
          //   title: Text('Leads'),),
          // drawer: drawer3(context),
          body: GestureDetector(
            onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.dashboard);
                      });
                    }
                  },
            child: TabBarView(
              controller: controller,
              children: [
                (context.watch<ColletionContoller>().preogress == false &&
                        context
                            .watch<ColletionContoller>()
                            .collectionGetList
                            .isNotEmpty &&
                        context.watch<ColletionContoller>().errormsg == '')
                    ? Un_Settled(context, theme,controller!.index.toString())
                    : (context.watch<ColletionContoller>().preogress == false &&
                            context
                                .watch<ColletionContoller>()
                                .collectionGetList
                                .isEmpty &&
                            context.watch<ColletionContoller>().errormsg != '')
                        ? Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                     
                              children: [
                                 context.watch<ColletionContoller>().lottie!.isEmpty?Container():
                                context.watch<ColletionContoller>().lottie!.isNotEmpty && context.watch<ColletionContoller>().lottie!.contains(".png")?     InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('${context.watch<ColletionContoller>().lottie}',
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
                    child: Lottie.asset('${context.watch<ColletionContoller>().lottie}',
                        animate: true,
                        repeat: true,
                        // height: Screens.padingHeight(context) * 0.3,
                        width: Screens.width(context) * 0.4),
                  ),
                                Text(
                                    '${context.watch<ColletionContoller>().errormsg}',textAlign: TextAlign.center,),
                              ],
                            ),
                          )
                        : Center(child: CircularProgressIndicator()),
                //tapbar2
                (context.watch<ColletionContoller>().preogress == false &&
                        context
                            .watch<ColletionContoller>()
                            .collectionGetList
                            .isNotEmpty &&
                        context.watch<ColletionContoller>().errormsg == '')
                    ? settled(context, theme,controller!.index.toString())
                    : (context.watch<ColletionContoller>().preogress == false &&
                            context
                                .watch<ColletionContoller>()
                                .collectionGetList
                                .isEmpty &&
                            context.watch<ColletionContoller>().errormsg != '')
                        ? Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                     
                              children: [
                                 context.watch<ColletionContoller>().lottie!.isEmpty?Container():
                                context.watch<ColletionContoller>().lottie!.isNotEmpty && context.watch<ColletionContoller>().lottie!.contains(".png")?     InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('${context.watch<ColletionContoller>().lottie}',
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
                    child: Lottie.asset('${context.watch<ColletionContoller>().lottie}',
                        animate: true,
                        repeat: true,
                        // height: Screens.padingHeight(context) * 0.3,
                        width: Screens.width(context) * 0.4),
                  ),
                                Text(
                                    '${context.watch<ColletionContoller>().errormsg}',textAlign: TextAlign.center,),
                              ],
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.toNamed(ConstantRoutes.newcollection);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => NewCollectionEntry()),
              // );
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )),
    );
  }
Container settled(BuildContext context, ThemeData theme,String tabvalue) {
    return Container(
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: paddings.padding2(context),
      child: Column(
        children: [
          SizedBox(
            height: Screens.bodyheight(context) * 0.005,
          ),
          Expanded(
            child: context
                    .read<ColletionContoller>()
                    .filetercollectionGetListClose
                    .isEmpty
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
                        width: Screens.width(context)*0.5
                        ),
                  ),
                        Text("No Data..",textAlign: TextAlign.center),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: context
                        .watch<ColletionContoller>()
                        .filetercollectionGetListClose
                        .length,
                    //  prdACC
                    //     .getAccountsDataFilter
                    //     .length,
                    // prdACC.getAccountsData.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        width: Screens.width(context),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.02,
                                  vertical:
                                      Screens.bodyheight(context) * 0.006),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              context
                                  .read<ColletionContoller>()
                                  .showDialogColllection(
                                      context,
                                      i,
                                      context
                                          .read<ColletionContoller>()
                                          .filetercollectionGetListClose[i],tabvalue);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                Screens.bodyheight(context) * 0.005),
                           decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(color: Colors.black26)
                                        // border: Border(bottom: BorderSide(color: Colors.black38))
                                        ),
                            child: Column(
                              children: [
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.002),
                                              alignment: Alignment.topLeft,
                                              // color:
                                              //     Colors.amber,
                                
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "Customer",
                                                // "${AccountsData[i].cardname}",
                                                // "${prdACC.getAccountsDataFilter[i].cardname}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.005),
                                              // color:
                                              //     Colors.amber,
                                              alignment: Alignment.topLeft,
                                
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "${context.watch<ColletionContoller>().filetercollectionGetListClose[i].customerName}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(color: theme.primaryColor),
                                                // "${AccountsData[i].street}",
                                                // "${prdACC.getAccountsDataFilter[i].cardcode}",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.002),
                                              alignment: Alignment.topRight,
                                              // color:
                                              //     Colors.amber,
                                
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "Doc Num",
                                                // "${AccountsData[i].cardname}",
                                                // "${prdACC.getAccountsDataFilter[i].cardname}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.005),
                                              // color:
                                              //     Colors.amber,
                                              alignment: Alignment.topRight,
                                
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "${context.watch<ColletionContoller>().filetercollectionGetListClose[i].docNum}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(color: theme.primaryColor),
                                                // "${AccountsData[i].street}",
                                                // "${prdACC.getAccountsDataFilter[i].cardcode}",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.002),
                                              alignment: Alignment.topLeft,
                                              // color:
                                              //     Colors.amber,
                                
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "Payment Mode",
                                                // "${AccountsData[i].cardname}",
                                                // "${prdACC.getAccountsDataFilter[i].cardname}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.005),
                                              // color:
                                              //     Colors.amber,
                                              alignment: Alignment.topLeft,
                                
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "${context.watch<ColletionContoller>().getPaymentMode(context.watch<ColletionContoller>().filetercollectionGetListClose[i])}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(color: theme.primaryColor),
                                                // "${AccountsData[i].street}",
                                                // "${prdACC.getAccountsDataFilter[i].cardcode}",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.002),
                                              alignment: Alignment.topRight,
                                              // color:
                                              //     Colors.amber,
                                
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "Doc Date",
                                                // "${AccountsData[i].cardname}",
                                                // "${prdACC.getAccountsDataFilter[i].cardname}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.005),
                                              // color:
                                              //     Colors.amber,
                                              alignment: Alignment.topRight,
                                
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "${config.alignDate(context.watch<ColletionContoller>().filetercollectionGetListClose[i].docDate!)}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(color: theme.primaryColor),
                                                // "${AccountsData[i].street}",
                                                // "${prdACC.getAccountsDataFilter[i].cardcode}",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.002),
                                              alignment: Alignment.topLeft,
                                              // color:
                                              //     Colors.amber,
                                
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "Address",
                                                // "${AccountsData[i].cardname}",
                                                // "${prdACC.getAccountsDataFilter[i].cardname}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.005),
                                              // color:
                                              //     Colors.amber,
                                              alignment: Alignment.topLeft,
                                
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "${context.watch<ColletionContoller>().filetercollectionGetListClose[i].bil_Address1}, ${context.watch<ColletionContoller>().filetercollectionGetListClose[i].bil_City}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(color: theme.primaryColor),
                                                // "${AccountsData[i].street}",
                                                // "${prdACC.getAccountsDataFilter[i].cardcode}",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.002),
                                              alignment: Alignment.topRight,
                                              // color:
                                              //     Colors.amber,
                                
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "Paid Amount",
                                                // "${AccountsData[i].cardname}",
                                                // "${prdACC.getAccountsDataFilter[i].cardname}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.005),
                                              // color:
                                              //     Colors.amber,
                                              alignment: Alignment.topRight,
                                
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                "${context
                                                          .read<
                                                              ColletionContoller>()
                                                          .config.slpitCurrency22(context.watch<ColletionContoller>().filetercollectionGetListClose[i].amountpaid!.toString())}",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(color: theme.primaryColor),
                                                // "${AccountsData[i].street}",
                                                // "${prdACC.getAccountsDataFilter[i].cardcode}",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
  // Container settled(BuildContext context, ThemeData theme) {
  //   return Container(
  //     width: Screens.width(context),
  //     height: Screens.bodyheight(context),
  //     padding: paddings.padding2(context),
  //     child: Column(
  //       children: [
  //         SizedBox(
  //           height: Screens.bodyheight(context) * 0.005,
  //         ),
  //         Expanded(
  //           child: context
  //                   .read<ColletionContoller>()
  //                   .filetercollectionGetListClose
  //                   .isEmpty
  //               ? Center(
  //                   child: Text("No Data.."),
  //                 )
  //               : ListView.builder(
  //                   itemCount: context
  //                       .watch<ColletionContoller>()
  //                       .filetercollectionGetListClose
  //                       .length,
  //                   //  prdACC
  //                   //     .getAccountsDataFilter
  //                   //     .length,
  //                   // prdACC.getAccountsData.length,
  //                   itemBuilder: (BuildContext context, int i) {
  //                     return Card(
  //                       elevation: 4,
  //                       shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(8)),
  //                       child: GestureDetector(
  //                         onTap: () {
  //                           // setState(() {
  //                           //   context
  //                           //       .read<ColletionContoller>()
  //                           //       .showDialogColllection(
  //                           //           context,
  //                           //           i,
  //                           //           context
  //                           //               .read<ColletionContoller>()
  //                           //               .filetercollectionGetListOpen[i]);
  //                           // });
  //                         },
  //                         child: Container(
  //                           padding: EdgeInsets.all(
  //                               Screens.bodyheight(context) * 0.005),
  //                           decoration: BoxDecoration(
  //                             color: Colors.grey[200],
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                           child: Column(
  //                             children: [
  //                               Row(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Container(
  //                                         padding: EdgeInsets.all(
  //                                             Screens.bodyheight(context) *
  //                                                 0.002),
  //                                         alignment: Alignment.topLeft,
  //                                         // color:
  //                                         //     Colors.amber,

  //                                         width: Screens.width(context) * 0.4,
  //                                         child: Text(
  //                                           "${context.watch<ColletionContoller>().filetercollectionGetListClose[i].customerName}",
  //                                           // "${AccountsData[i].cardname}",
  //                                           // "${prdACC.getAccountsDataFilter[i].cardname}",
  //                                           style: theme.textTheme.bodyText1
  //                                               ?.copyWith(),
  //                                         ),
  //                                       ),
  //                                       Container(
  //                                         padding: EdgeInsets.all(
  //                                             Screens.bodyheight(context) *
  //                                                 0.005),
  //                                         // color:
  //                                         //     Colors.amber,
  //                                         alignment: Alignment.centerLeft,

  //                                         width: Screens.width(context) * 0.4,
  //                                         child: Text(
  //                                           "${context.watch<ColletionContoller>().getPaymentMode(context.read<ColletionContoller>().filetercollectionGetListClose[i])}",
  //                                           // "${AccountsData[i].street}",
  //                                           // "${prdACC.getAccountsDataFilter[i].cardcode}",
  //                                           textAlign: TextAlign.left,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                   Container(
  //                                     // color: Colors.blueGrey,
  //                                     width: Screens.width(context) * 0.45,
  //                                     child: Column(
  //                                       mainAxisAlignment:
  //                                           MainAxisAlignment.end,
  //                                       children: [
  //                                         Container(
  //                                           padding: EdgeInsets.all(
  //                                               Screens.bodyheight(context) *
  //                                                   0.002),
  //                                           alignment: Alignment.centerRight,
  //                                           child: Text(
  //                                             "${context.read<ColletionContoller>().filetercollectionGetListClose[i].docNum}",
  //                                             style: theme.textTheme.bodyText1
  //                                                 ?.copyWith(),
  //                                           ),
  //                                         ),
  //                                         Container(
  //                                           padding: EdgeInsets.all(
  //                                               Screens.bodyheight(context) *
  //                                                   0.005),
  //                                           alignment: Alignment.centerRight,
  //                                           child: Text(
  //                                             "${config.alignDate(context.watch<ColletionContoller>().filetercollectionGetListClose[i].docDate!)}",
  //                                             style: theme.textTheme.bodyText1
  //                                                 ?.copyWith(),
  //                                           ),
  //                                         )
  //                                       ],
  //                                     ),
  //                                   )
  //                                 ],
  //                               ),

  //                               // SizedBox(
  //                               //   height:
  //                               //       Screens.bodyheight(context) * 0.01,
  //                               // ),

  //                               IntrinsicHeight(
  //                                 child: Row(
  //                                   mainAxisAlignment:
  //                                       MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Container(
  //                                       alignment: Alignment.topLeft,
  //                                       padding: EdgeInsets.all(
  //                                           Screens.bodyheight(context) *
  //                                               0.005),
  //                                       width: Screens.width(context) * 0.4,
  //                                       child: Text(
  //                                         "${context.watch<ColletionContoller>().filetercollectionGetListClose[i].bil_Address1} ${context.watch<ColletionContoller>().filetercollectionGetListClose[i].bil_City}",
  //                                         style: theme.textTheme.bodyText1
  //                                             ?.copyWith(),
  //                                       ),
  //                                     ),
  //                                     Container(
  //                                       padding: EdgeInsets.all(
  //                                           Screens.bodyheight(context) *
  //                                               0.005),

  //                                       alignment: Alignment.bottomRight,
  //                                       // width: Screens.width(context),
  //                                       child: Text(
  //                                           '${context.watch<ColletionContoller>().filetercollectionGetListClose[i].amountpaid!}',
  //                                           // "23-Jun-2023 10:40 PM",
  //                                           style: theme.textTheme.bodyText1),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Container Un_Settled(BuildContext context, ThemeData theme,String tabvalue) {
    return Container(
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: paddings.padding2(context),
      child: Column(
        children: [
          SizedBox(
            height: Screens.bodyheight(context) * 0.005,
          ),
          Expanded(
            child: context
                    .read<ColletionContoller>()
                    .filetercollectionGetListOpen
                    .isEmpty
                ? Center(
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                      children: [ InkWell(
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
                        Text("No Data..",textAlign: TextAlign.center),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: context
                        .watch<ColletionContoller>()
                        .filetercollectionGetListOpen
                        .length,
                    //  prdACC
                    //     .getAccountsDataFilter
                    //     .length,
                    // prdACC.getAccountsData.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        width: Screens.width(context),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.02,
                                  vertical:
                                      Screens.bodyheight(context) * 0.006),
                      
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              context
                                  .read<ColletionContoller>()
                                  .showDialogColllection(
                                      context,
                                      i,
                                      context
                                          .read<ColletionContoller>()
                                          .filetercollectionGetListOpen[i],tabvalue);
                            });
                          },
                          onDoubleTap: (){
                             setState(() {
                              context
                                  .read<ColletionContoller>()
                                  .showDialogColllection(
                                      context,
                                      i,
                                      context
                                          .read<ColletionContoller>()
                                          .filetercollectionGetListOpen[i],tabvalue);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(
                                Screens.bodyheight(context) * 0.005),
                             decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(color: Colors.black26)
                                        // border: Border(bottom: BorderSide(color: Colors.black38))
                                        ),
                            child: Column(
                              children: [
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.002),
                                              alignment: Alignment.topLeft,
                                              // color:
                                              //     Colors.amber,

                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "Customer",
                                                // "${AccountsData[i].cardname}",
                                                // "${prdACC.getAccountsDataFilter[i].cardname}",
                                                style: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.005),
                                              // color:
                                              //     Colors.amber,
                                              alignment: Alignment.topLeft,

                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "${context.watch<ColletionContoller>().filetercollectionGetListOpen[i].customerName}",
                                                style: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color:
                                                            theme.primaryColor),
                                                // "${AccountsData[i].street}",
                                                // "${prdACC.getAccountsDataFilter[i].cardcode}",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.002),
                                              alignment: Alignment.topRight,
                                              // color:
                                              //     Colors.amber,

                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "Doc Num",
                                                // "${AccountsData[i].cardname}",
                                                // "${prdACC.getAccountsDataFilter[i].cardname}",
                                                style: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.005),
                                              // color:
                                              //     Colors.amber,
                                              alignment: Alignment.topRight,

                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "${context.watch<ColletionContoller>().filetercollectionGetListOpen[i].docNum}",
                                                style: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color:
                                                            theme.primaryColor),
                                                // "${AccountsData[i].street}",
                                                // "${prdACC.getAccountsDataFilter[i].cardcode}",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.002),
                                              alignment: Alignment.topLeft,
                                              // color:
                                              //     Colors.amber,

                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "Payment Mode",
                                                // "${AccountsData[i].cardname}",
                                                // "${prdACC.getAccountsDataFilter[i].cardname}",
                                                style: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.005),
                                              // color:
                                              //     Colors.amber,
                                              alignment: Alignment.topLeft,

                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "${context.watch<ColletionContoller>().getPaymentMode(context.watch<ColletionContoller>().filetercollectionGetListOpen[i])}",
                                                style: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color:
                                                            theme.primaryColor),
                                                // "${AccountsData[i].street}",
                                                // "${prdACC.getAccountsDataFilter[i].cardcode}",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.002),
                                              alignment: Alignment.topRight,
                                              // color:
                                              //     Colors.amber,

                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "Doc Date",
                                                // "${AccountsData[i].cardname}",
                                                // "${prdACC.getAccountsDataFilter[i].cardname}",
                                                style: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.005),
                                              // color:
                                              //     Colors.amber,
                                              alignment: Alignment.topRight,

                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                context
                                                            .watch<
                                                                ColletionContoller>()
                                                            .filetercollectionGetListOpen[
                                                                i]
                                                            .docDate ==
                                                        null||    context
                                                            .watch<
                                                                ColletionContoller>()
                                                            .filetercollectionGetListOpen[
                                                                i]
                                                            .docDate!.isEmpty||    context
                                                            .watch<
                                                                ColletionContoller>()
                                                            .filetercollectionGetListOpen[
                                                                i]
                                                            .docDate=='null'
                                                    ? ''
                                                    : "${config.alignDate(context.read<ColletionContoller>().filetercollectionGetListOpen[i].docDate!)}",
                                                style: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color:
                                                            theme.primaryColor),
                                                // "${AccountsData[i].street}",
                                                // "${prdACC.getAccountsDataFilter[i].cardcode}",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.002),
                                              alignment: Alignment.topLeft,
                                              // color:
                                              //     Colors.amber,

                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "Address",
                                                // "${AccountsData[i].cardname}",
                                                // "${prdACC.getAccountsDataFilter[i].cardname}",
                                                style: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.005),
                                              // color:
                                              //     Colors.amber,
                                              alignment: Alignment.topLeft,

                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "${context.watch<ColletionContoller>().filetercollectionGetListOpen[i].bil_Address1}, ${context.watch<ColletionContoller>().filetercollectionGetListOpen[i].bil_City}",
                                                style: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color:
                                                            theme.primaryColor),
                                                // "${AccountsData[i].street}",
                                                // "${prdACC.getAccountsDataFilter[i].cardcode}",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.002),
                                              alignment: Alignment.topRight,
                                              // color:
                                              //     Colors.amber,

                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "Paid Amount",
                                                // "${AccountsData[i].cardname}",
                                                // "${prdACC.getAccountsDataFilter[i].cardname}",
                                                style: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.005),
                                              // color:
                                              //     Colors.amber,
                                              alignment: Alignment.topRight,

                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "${context
                                                          .read<
                                                              ColletionContoller>()
                                                          .config.slpitCurrency22(context.watch<ColletionContoller>().filetercollectionGetListOpen[i].amountpaid!.toString())}",
                                                style: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                        color:
                                                            theme.primaryColor),
                                                // "${AccountsData[i].street}",
                                                // "${prdACC.getAccountsDataFilter[i].cardcode}",
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
