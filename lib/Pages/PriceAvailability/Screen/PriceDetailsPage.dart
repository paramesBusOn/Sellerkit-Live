// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Pages/PriceAvailability/Screen/showdialogst.dart';
import 'package:sellerkit/Widgets/qrpage.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/PriceListController/PriceListController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class ListPriceAvailability extends StatefulWidget {
  const ListPriceAvailability({Key? key}) : super(key: key);

  @override
  State<ListPriceAvailability> createState() => PriceAvailability2State();
}

class PriceAvailability2State extends State<ListPriceAvailability> {
  @override
  void initState() {
    // TODO: implement initState
    log("AAA"+context
                              .read<PriceListController>()
                              .getlistPriceAvail
                              .length.toString());
                              context
                              .read<PriceListController>()
                              .       mycontroller[0].clear();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //context.read<PriceListController>().getDataFromDB();
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
      Get.offAllNamed(ConstantRoutes.priceList);
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
          appBar: appbar("Price Availability", scaffoldKey, theme, context),
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
                          Get.offAllNamed(ConstantRoutes.priceList);
                        });
                      }
                    },
              child: Column(
                children: [
                  SizedBox(height: Screens.bodyheight(context)*0.01,),
                 // SearchWidget(themes: theme),
                 Container(
                  //  width: Screens.width(context)*0.80,
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
                     context.read<PriceListController>().filterList(v);
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
                    //             .watch<PriceListController>()
                    //             .getisLoadingListView ==
                    //         true
                    //     ? SkeletonListView(
                    //         itemCount: 10,
                    //         scrollable: true,
                    //       )
                    //     :
                    context
                                .watch<PriceListController>()
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
                              ):     ListView.builder(
                            itemCount: context
                                .watch<PriceListController>()
                                .getlistPriceAvail
                                .length,
                            itemBuilder: (BuildContext context, int i) {
                              return InkWell(
                                onDoubleTap: (){
                                  context
                                      .read<PriceListController>()
                                      .   viewstockdet(context
                                .read<PriceListController>()
                                .getlistPriceAvail[i].itemCode.toString());
                                showDialog<dynamic>(
                                  context: context,
                                  builder: (_) {
                                  
                                    // widget.provi.updateFollowUpDialog = false;
                                    // context.read<LeadTabController>().resetValues();
                                    return showdialogst(
                                      // index: i,
                                      getalldata: context
                                .read<PriceListController>()
                                .getlistPriceAvail[i],
                                      // leadopenalldata: widget.leadOpenAllData[i],
                                    );
                                  });
                                },
                                onTap: () {
                                   context
                                      .read<PriceListController>()
                                      .  onvisiblefeature(i);
                                  // log("ANBU"+context.read<PriceListController>().getlistPriceAvail[i].IMId.toString());
                                  // context
                                  //     .read<PriceListController>()
                                  //     .callItemMasterPriceUpdateNew(
                                  //         context
                                  //             .read<PriceListController>()
                                  //             .getlistPriceAvail[i]
                                  //             .itemCode!,
                                  //         context
                                  //             .read<PriceListController>()
                                  //             .getlistPriceAvail[i]
                                  //             .id!,
                                  //         i);
                                },
                                child: Card(
                                  elevation: 5,
                                  child:
                                  //  context.watch<PriceListController>().getlistPriceAvail[i].isselected==1?
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
                                                  "Item code: ${context.watch<PriceListController>().getlistPriceAvail[i].itemCode}",
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
                                                   Text("Store code: ${context.watch<PriceListController>().getlistPriceAvail[i].storeCode}",
                                                    style: theme.textTheme.bodyText1
                                                        ?.copyWith( color:
                                                              theme.primaryColor),),
                                                  Text(
                                                    context.watch<PriceListController>().subtractDateTime(context.watch<PriceListController>().getlistPriceAvail[i].refreshedRecordDate!),
                                            // "Store code: ${context.watch<PriceListController>().getlistPriceAvail[i].storeCode}",
                                                   
                                             //   " ${context.watch<PriceListController>().getlistPriceAvail[i].refreshedRecordDate}",
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
                                                  "${context.watch<PriceListController>().getlistPriceAvail[i].itemName}",
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
                                              ConstantValues.sapUserType.toLowerCase()=='manager'?
                                              "${context.watch<PriceListController>().getlistPriceAvail[i].mgrPrice}"
                                           :'', 
                                             style: theme.textTheme.bodyText1
                                                  ?.copyWith(
                                              color:
                                                  theme.primaryColor),
                                            ),
                                            ),
            
                                               Container(
                                               alignment: Alignment.centerRight,
                                               child: Text(
                                                 "${context.watch<PriceListController>().config.slpitCurrency22(context.watch<PriceListController>().getlistPriceAvail[i].sp.toString())}",
                                                 style: theme.textTheme.bodyText1
                                                     ?.copyWith(
                                                 color:
                                                     theme.primaryColor),
                                               ),
                                            ),
                                        
                                          ],
                                        ),
                                    
                                    context.watch<PriceListController>().getlistPriceAvail[i].isselected==0?Container():     Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  Screens.width(context) * 0.05),
                                          child: Divider(
                                            color: Colors.grey[400],
                                          ),
                                        ),
                           context.watch<PriceListController>().getlistPriceAvail[i].isselected==0?Container():      Container(
                                          width: Screens.width(context) ,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                            Text("Features",style:  theme.textTheme.bodyText1
                                                  ?.copyWith(color: theme.primaryColor),),
                                        Row(children: [
                                          
                                       context.watch<PriceListController>().getlistPriceAvail[i].brandCode!.isEmpty?Container():   Container(
                                             width: Screens.width(context) * 0.7,
                                            child: Text("* ${context.watch<PriceListController>().getlistPriceAvail[i].brandCode}", style: theme.textTheme.bodyText1
                                                      ?.copyWith(
                                                          //color: theme.primaryColor
                                                          ),),
                                          ),
                                        ],),
                                         Row(children: [
                                          
                                    context.watch<PriceListController>().getlistPriceAvail[i].itemDescription!.isEmpty?Container():      Container(
                                             width: Screens.width(context) * 0.7,
                                            child: Text("* ${context.watch<PriceListController>().getlistPriceAvail[i].itemDescription}", style: theme.textTheme.bodyText1
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
                                    context.watch<PriceListController>().getlistPriceAvail[i].specification!.isEmpty?Container():      Container(
                                             width: Screens.width(context) * 0.7,
                                            child: Text("* ${context.watch<PriceListController>().getlistPriceAvail[i].specification}", style: theme.textTheme.bodyText1
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
                                  context.watch<PriceListController>().getlistPriceAvail[i].clasification!.isEmpty?Container():        Container(
                                             width: Screens.width(context) * 0.7,
                                            child: Text("* ${context.watch<PriceListController>().getlistPriceAvail[i].clasification}", style: theme.textTheme.bodyText1
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
                                   context.watch<PriceListController>().getlistPriceAvail[i].color!.isEmpty?Container():       Container(
                                            width: Screens.width(context) * 0.7,
                                            child: Text("* ${context.watch<PriceListController>().getlistPriceAvail[i].color}", style: theme.textTheme.bodyText1
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
