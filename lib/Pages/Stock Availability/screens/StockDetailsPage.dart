// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Pages/Stock%20Availability/screens/showdialogst.dart';
import 'package:sellerkit/Widgets/qrpage.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/StockAvailabilityController/StockListController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class ListStockAvailability extends StatefulWidget {
  const ListStockAvailability({Key? key}) : super(key: key);

  @override
  State<ListStockAvailability> createState() => ListStockAvailabilityState();
}

class ListStockAvailabilityState extends State<ListStockAvailability> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log("aaaa"+context
                              .read<StockListController>()
                              .getlistPriceAvail.length.toString());
                       context
                              .read<StockListController>()
                              .       mycontroller[0].clear();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //context.read<StockListController>().getDataFromDB();
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.offAllNamed(ConstantRoutes.stock);
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
      child: Scaffold(        drawerEnableOpenDragGesture: false,
    
          key: scaffoldKey,
          appBar: appbar("Stock Availability", scaffoldKey, theme, context),
          drawer: drawer3(context),
          body: Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context),
            padding: paddings.padding2(context),
            child: GestureDetector(onHorizontalDragUpdate: (details) {
                      // Check if the user is swiping from left to right
                      print(details.primaryDelta);
                      if (details.primaryDelta! > ConstantValues.slidevalue!) {
                        setState(() {
                          Get.offAllNamed(ConstantRoutes.stock);
                        });
                      }
                    },
              child: Column(
                children: [
                  SizedBox(height: Screens.bodyheight(context)*0.01,),
                 // SearchWidget(themes: theme),
                 Container(
                    // width: Screens.width(context)*0.80,
                  
                   height: Screens.bodyheight(context) * 0.06,
                   decoration: BoxDecoration(
                     color: theme.primaryColor
                         .withOpacity(0.1), //Colors.grey[200],
                     borderRadius: BorderRadius.circular(
                         Screens.width(context) * 0.02),
                   ),
                   child: TextField(
                     autocorrect: false,
                     onChanged: (v) {
                     context.read<StockListController>().filterList(v);
                     },
                     decoration: InputDecoration(
                       filled: false,
                       hintText: 'Search Here!!..',
                       enabledBorder: InputBorder.none,
                       focusedBorder: InputBorder.none,
                       prefixIcon: IconButton(
                         icon: const Icon(Icons.search),
                         onPressed: () {
                           FocusScopeNode focus = FocusScope.of(context);
                           if (!focus.hasPrimaryFocus) {
                             focus.unfocus();
                           }
                         }, //
                         color: theme.primaryColor,
                       ),
                       contentPadding: const EdgeInsets.symmetric(
                         vertical: 12,
                         horizontal: 5,
                       ),
                     ),
                   ),
                 ),
                   SizedBox(height: Screens.bodyheight(context)*0.005,),
                  Expanded(
                    child: 
                    // context
                    //             .watch<StockListController>()
                    //             .getisLoadingListView ==
                    //         true
                    //     ? SkeletonListView(
                    //         itemCount: 10,
                    //         scrollable: true,
                    //       )
                    //     :
                   context
                                .watch<StockListController>()
                                .getlistPriceAvail.isEmpty?Center(child: Column(
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
                              Text("No data..!!",textAlign: TextAlign.center,style: TextStyle(fontSize: 15)),
                            ],
                          )
                              //   CircularProgressIndicator(
                              //   color: themes.primaryColor,
                              // )
                              ) :       ListView.builder(
                            itemCount: context
                                .watch<StockListController>()
                                .getlistPriceAvail
                                .length,
                            itemBuilder: (BuildContext context, int i) {
                              return  InkWell(
                                onDoubleTap: (){
                                   context
                                      .read<StockListController>()
                                      .   viewstockdet(context
                                .read<StockListController>()
                                .getlistPriceAvail[i].itemCode.toString());
                                showDialog<dynamic>(
                                  context: context,
                                  builder: (_) {
                                  
                                    // widget.provi.updateFollowUpDialog = false;
                                    // context.read<LeadTabController>().resetValues();
                                    return showdialogst(
                                      // index: i,
                                      // leadopenalldata: widget.leadOpenAllData[i],
                                    );
                                  });
                                },
                                onTap: () {
                                 
                                context
                                      .read<StockListController>()
                                      .  onvisiblefeature(i);
                                  //  log("IDDD"+context.read<StockListController>().getlistPriceAvail[i].id.toString());
                                  // context
                                  //     .read<StockListController>()
                                  //     .callItemMasterPriceUpdateNew(
                                  //         context
                                  //             .read<StockListController>()
                                  //             .getlistPriceAvail[i]
                                  //             .itemCode!,
                                  //         context
                                  //             .read<StockListController>()
                                  //             .getlistPriceAvail[i]
                                  //             .id!,
                                  //         i);
                                },
                                
                                child: Card(
                                  elevation: 5,
                                  child: 
                                  // context.watch<StockListController>().getlistPriceAvail[i].isselected==1?
                                  // Container(
                                  //   width: Screens.width(context),
                                  //    padding: EdgeInsets.symmetric(
                                  //       vertical:
                                  //           Screens.bodyheight(context) * 0.05,
                                  //       horizontal: Screens.width(context) * 0.02),
                                  // child: Center(
                                  //   child: CircularProgressIndicator(strokeWidth: 2,),
                                  // ),
                                  // )
                                  // :
                                  Container(
                                    width: Screens.width(context),
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            Screens.bodyheight(context) * 0.01,
                                        horizontal: Screens.width(context) * 0.02),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: Screens.width(context) * 0.4,
                                              child: Text(
                                                  "Item code: ${context.watch<StockListController>().getlistPriceAvail[i].itemCode}",
                                                  style: theme.textTheme.bodyText1
                                                      ?.copyWith(
                                                          color:
                                                              theme.primaryColor)),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              width: Screens.width(context) * 0.4,
                                              child: Column(
                                                children: [
                                                  Text("Store code: ${context.watch<StockListController>().getlistPriceAvail[i].storeCode}",
                                                    style: theme.textTheme.bodyText1
                                                        ?.copyWith( color:
                                                              theme.primaryColor),),
                                                  Text(
                                                    context.watch<StockListController>().subtractDateTime(context.watch<StockListController>().getlistPriceAvail[i].refreshedRecordDate!),
                                                    style: theme.textTheme.bodyText1
                                                        ?.copyWith(color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  Screens.width(context) * 0.05),
                                          child: Divider(
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: Screens.width(context) * 0.4,
                                          child: Text("Product",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(color: Colors.grey)),
                                        ),
                                        SizedBox(
                                          height:
                                              Screens.bodyheight(context) * 0.01,
                                        ),
                                           Container(
                                            //  color: Colors.red,
                                              width: Screens.width(context) ,
                                              child: Text(
                                                  "${context.watch<StockListController>().getlistPriceAvail[i].itemName}",
                                                  style: theme.textTheme.bodyText1
                                                      ?.copyWith(
                                                          //color: theme.primaryColor
                                                          )),
                                            ),
                                             SizedBox(
                                          height:
                                              Screens.bodyheight(context) * 0.01,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                             // ConstantValues.sapUser=='Manager'?
                                              "Whse Stock: ${context.watch<StockListController>().getlistPriceAvail[i].whsStock!.toStringAsFixed(0)}",
                                          // :'', 
                                             style: theme.textTheme.bodyText1
                                                  ?.copyWith(
                                              color:
                                                  theme.primaryColor),
                                            ),
                                            ),
            
                                               Container(
                                               alignment: Alignment.centerRight,
                                               child: Text(
                                                 "Store Stock: ${context.watch<StockListController>().getlistPriceAvail[i].storeStock!.toStringAsFixed(0)}",
                                                 style: theme.textTheme.bodyText1
                                                     ?.copyWith(
                                                 color:
                                                     theme.primaryColor),
                                               ),
                                            ),
                                        
                                          ],
                                        ),
                                    
                                  context.watch<StockListController>().getlistPriceAvail[i].isselected==0?Container():     Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  Screens.width(context) * 0.05),
                                          child: Divider(
                                            color: Colors.grey[400],
                                          ),
                                        ),
                           context.watch<StockListController>().getlistPriceAvail[i].isselected==0?Container():      Container(
                                          width: Screens.width(context) ,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                            Text("Features",style:  theme.textTheme.bodyText1
                                                  ?.copyWith(color: theme.primaryColor),),
                                        Row(children: [
                                          // Container(
                                          //   // color:Colors.amber,
                                          //   width: Screens.width(context) * 0.3,
                                          //   child: Text("BrandCode",style: theme.textTheme.bodyText1
                                          //         ?.copyWith(color: Colors.grey)),
                                          // ),
                                   context.watch<StockListController>().getlistPriceAvail[i].brandCode!.isEmpty?Container():       Container(
                                             width: Screens.width(context) * 0.7,
                                            child: Text("* ${context.watch<StockListController>().getlistPriceAvail[i].brandCode}", style: theme.textTheme.bodyText1
                                                      ?.copyWith(
                                                          //color: theme.primaryColor
                                                          ),),
                                          ),
                                        ],),
                                         Row(children: [
                                          // Container(
                                          //    width: Screens.width(context) * 0.3,
                                          //   child: Text("ItemDescription",style: theme.textTheme.bodyText1
                                          //         ?.copyWith(color: Colors.grey)),
                                          // ),
                                  context.watch<StockListController>().getlistPriceAvail[i].itemDescription!.isEmpty?Container():        Container(
                                             width: Screens.width(context) * 0.7,
                                            child: Text("* ${context.watch<StockListController>().getlistPriceAvail[i].itemDescription}", style: theme.textTheme.bodyText1
                                                      ?.copyWith(
                                                          //color: theme.primaryColor
                                                          )),
                                          ),
                                        ],),
                                        Row(children: [
                                          // Container(
                                          //    width: Screens.width(context) * 0.3,
                                          //   child: Text("Specification",style: theme.textTheme.bodyText1
                                          //         ?.copyWith(color: Colors.grey)),
                                          // ),
                                      context.watch<StockListController>().getlistPriceAvail[i].specification!.isEmpty?Container():    Container(
                                             width: Screens.width(context) * 0.7,
                                            child: Text("* ${context.watch<StockListController>().getlistPriceAvail[i].specification}", style: theme.textTheme.bodyText1
                                                      ?.copyWith(
                                                          //color: theme.primaryColor
                                                          )),
                                          ),
                                        ],),
                                        Row(children: [
                                          // Container(
                                          //   width: Screens.width(context) * 0.3,
                                          //   child: Text("Clasification",style: theme.textTheme.bodyText1
                                          //         ?.copyWith(color: Colors.grey)),
                                          // ),
                                 context.watch<StockListController>().getlistPriceAvail[i].clasification!.isEmpty?Container():         Container(
                                             width: Screens.width(context) * 0.7,
                                            child: Text("* ${context.watch<StockListController>().getlistPriceAvail[i].clasification}", style: theme.textTheme.bodyText1
                                                      ?.copyWith(
                                                          //color: theme.primaryColor
                                                          )),
                                          ),
                                        ],),
                                         Row(children: [
                                          // Container(
                                          //    width: Screens.width(context) * 0.3,
                                          //   child: Text("Color",style: theme.textTheme.bodyText1
                                          //         ?.copyWith(color: Colors.grey)),
                                          // ),
                                         context.watch<StockListController>().getlistPriceAvail[i].color!.isEmpty?Container(): Container(
                                            width: Screens.width(context) * 0.7,
                                            child: Text("* ${context.watch<StockListController>().getlistPriceAvail[i].color}", style: theme.textTheme.bodyText1
                                                      ?.copyWith(
                                                          //color: theme.primaryColor
                                                          )),
                                          ),
                                        ],)
                                          ]
                                          ,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              //)));
                            },
                          ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
