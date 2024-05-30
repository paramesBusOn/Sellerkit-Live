

// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';

import 'package:intl/intl.dart';
import 'package:sellerkit/Controller/QuotationController/newquotecontroller.dart';

class openleaddialog extends StatefulWidget {
  const openleaddialog({Key? key}) : super(key: key);

  @override
  State<openleaddialog> createState() => _openleaddialogState();
}

class _openleaddialogState extends State<openleaddialog> {
  @override
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.offAllNamed(ConstantRoutes.quotespage);
      return Future.value(true);
    }
    return Future.value(true);
  }
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: AlertDialog(
     insetPadding: EdgeInsets.all(10),
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: openleadpage(theme),
      ),
    );
  }
 Container openleadpage(ThemeData theme,){
  return Container(
      // color: Colors.red,
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: EdgeInsets.only(
        // top:Screens.bodyheight(context) * 0.0 ,
        // left: Screens.width(context) * 0.03,
        // right: Screens.width(context) * 0.02,
        // bottom: 0

          // horizontal: Screens.width(context) * 0.03,
          // vertical: Screens.bodyheight(context) * 0.02
          ),
      
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
width: Screens.width(context),
 height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(onPressed: null,
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                    // fontSize: 12,
                    ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )), //Radius.circular(6)
              ),
              child: Text("Open Lead Details",style: theme.textTheme.bodyText1!.copyWith(color: Colors.white),)),
            ),
           
            Expanded(
              child: context.read<NewquoteController>().filterleadOpenAllData.isEmpty
                  ? Center(child: Column(
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
                      Text('No data..!!',textAlign: TextAlign.center,),
                    ],
                  ))
                  : Column(
                    children: [
                       Padding(
                         padding:  EdgeInsets.only(
                          top: Screens.padingHeight(context)*0.01,
                          left: Screens.width(context)*0.01,
                          right: Screens.width(context)*0.01
                         ),
                         child: Container(
                                     height: Screens.bodyheight(context) * 0.05,
                                     decoration: BoxDecoration(
                                       color: Colors.grey[200],
                                       borderRadius:
                                           BorderRadius.circular(Screens.width(context) * 0.01),
                                       // boxShadow: [
                                       //   BoxShadow(
                                       //     color: Colors.grey.withOpacity(0.7),
                                       //     spreadRadius: 3,
                                       //     blurRadius: 4,
                                       //     offset: Offset(
                                       //         0, 3), // changes position of shadow
                                       //   ),
                                       // ]
                                     ),
                                     child: TextField(
                                       // controller:context.read<NewEnqController>().mycontroller[5] ,
                                       onTap: () {
                                         // Get.toNamed(ConstantRoutes.screenshot);
                                       },
                                       autocorrect: false,
                                       onChanged: (v) {
                                         context.read<NewquoteController>().SearchFilterOpenTab(v);
                                        
                       
                                         // context.read<EnquiryUserContoller>().filterListAssignData(v);
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
                       ),
            SizedBox(height: Screens.padingHeight(context)*0.01,),
                      Expanded(
                        child: ListView.builder(
                         shrinkWrap: true,

                            itemCount: context.read<NewquoteController>().filterleadOpenAllData.length,
                            itemBuilder: (BuildContext context, int i) {
                              return InkWell(
                                onTap: () {
                                setState(() {
                                  Navigator.pop(context);
                                 context.read<NewquoteController>(). onindexselect(context.read<NewquoteController>().filterleadOpenAllData[i]);
                                  // if(context.read<NewquoteController>().filterleadOpenAllData[i].isselected==1){
                                  // log("Anbu22");
                                  //   context.read<NewquoteController>().filterleadOpenAllData[i].isselected==0;
                                  // }else{
                                  //   log("Anbu11");
                                  //    context.read<NewquoteController>().filterleadOpenAllData[i].isselected==1;
                                  // }
                                });
                                  // print("lead entry: "+widget.filterleadOpenAllData[i].LeadDocEntry.toString());
                                  //    print("lead entry: "+widget.leadOpenAllData[i].Mobile .toString());
                                },
                               
                               
                                child: Container(
                                  // color: context.read<NewquoteController>().filterleadOpenAllData[i].isselected==1? Colors.blue:Colors.white,
                                  width: Screens.width(context),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Screens.width(context) * 0.02,
                                      vertical:
                                          Screens.bodyheight(context) * 0.006),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                Screens.width(context) * 0.02,
                                            vertical: Screens.bodyheight(context) *
                                                0.006),
                                        decoration: BoxDecoration(
                                            color:  Colors.grey[200],
                                            borderRadius: BorderRadius.circular(8),
                                            border:
                                                Border.all(color: Colors.black26)
                                            // border: Border(bottom: BorderSide(color: Colors.black38))
                                            ),
                                        width: Screens.width(context),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width:
                                                      Screens.width(context) * 0.4,
                                                  child: Text(
                                                    "Customer",
                                                    style: theme.textTheme.bodyText2
                                                        ?.copyWith(
                                                            color: Colors.grey),
                                                  ),
                                                ),
                                                Container(
                                                  width:
                                                      Screens.width(context) * 0.4,
                                                  child: Text(
                                                    "",
                                                    style: theme.textTheme.bodyText2
                                                        ?.copyWith(
                                                            color: Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width:
                                                      Screens.width(context) * 0.4,
                                                  child: Text(
                                                      "${context.read<NewquoteController>().filterleadOpenAllData[i].CustomerName}", //  "${context.watch<EnquiryUserContoller>().getopenEnqData[i].CardName}",
                                                      style: 
                                                          theme.textTheme.bodyText2
                                                          ?.copyWith(
                                                        color: theme.primaryColor,
                                                        // fontWeight: FontWeight.bold
                                                      )),
                                                ),
                                                Container(
                                                  width:
                                                      Screens.width(context) * 0.4,
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                      //context
                                                      // leadOpenAllData[i].DocDate!.isEmpty?'':
                                                      //  context.read<NewquoteController>().config.alignDate(
                                                      "#${context.read<NewquoteController>().filterleadOpenAllData[i].LeadNum}",
                                                      //),//         // .watch<EnquiryUserContoller>()
                                                      // .config
                                                      // .alignDate(
                                                      //     "${context.watch<EnquiryUserContoller>().getopenEnqData[i].EnqDate}"),
                                                      style:theme.textTheme.bodyText2
                                                          ?.copyWith(
                                                        color: theme.primaryColor,
                                                        //fontWeight: FontWeight.bold
                                                      )),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Screens.bodyheight(context) *
                                                  0.01,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: Screens.width(context),
                                                  child: Text(
                                                    "Product",
                                                    style: theme.textTheme.bodyText2
                                                        ?.copyWith(
                                                            color: Colors.grey),
                                                  ),
                                                ),
                                                Container(
                                                  width: Screens.width(context),
                                                  // color: Colors.red,
                                                  child: Text(
                                                      "${context.read<NewquoteController>().filterleadOpenAllData[i].Product}",
                                                      style: theme.textTheme.bodyText2
                                                      //?.copyWith(color: Colors.grey),
                                                      ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Screens.bodyheight(context) *
                                                  0.01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width:
                                                      Screens.width(context) * 0.4,
                                                  // color: Colors.red,
                                                  child: Text(
                                                      "Next Follow up", //  "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[i].Lookingfor}",
                                                      style: theme.textTheme.bodyText2
                                                          ?.copyWith(
                                                              //color:theme.primaryColor,
                                                              //fontWeight: FontWeight.bold
                                                              color: Colors.grey)),
                                                ),
                                                Container(
                                                  width:
                                                      Screens.width(context) * 0.4,
                                                  //color: Colors.red,
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                      "Order Value", //  "₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                                      style: theme.textTheme.bodyText2
                                                          ?.copyWith(
                                                              //color:theme.primaryColor,
                                                              //fontWeight: FontWeight.bold
                                                              color: Colors.grey)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width:
                                                      Screens.width(context) * 0.4,
                                                  child: Text(
                                                      context.read<NewquoteController>().filterleadOpenAllData[i]
                                                              .NextFollowup!.isEmpty
                                                          ? ''
                                                          : context
                                                              .read<
                                                                  NewquoteController>()
                                                              .config
                                                              .alignDate(
                                                                  "${context.read<NewquoteController>().filterleadOpenAllData[i].NextFollowup}"), //  "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[i].Lookingfor}",
                                                      style: theme.textTheme.bodyText2
                                                          ?.copyWith(
                                                              //color:theme.primaryColor,
                                                              //fontWeight: FontWeight.bold
                                                              )),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    var format =
                                                        NumberFormat.currency(
                                                      name: "INR",
                                                      locale: 'en_IN',
                                                      decimalDigits:
                                                          0, // change it to get decimal places
                                                      symbol: '₹ ',
                                                    );
                                                    String formattedCurrency =
                                                        format.format(30000);
                                                    print(formattedCurrency);
                                                  },
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    width: Screens.width(context) *
                                                        0.4,
                                                    child: Text(
                                                        context.read<NewquoteController>().filterleadOpenAllData[i]
                                                                    .Value ==
                                                                -1
                                                            ? ""
                                                            : context
                                                                .read<
                                                                    NewquoteController>()
                                                                .config
                                                                .slpitCurrency(context.read<NewquoteController>().filterleadOpenAllData[
                                                                        i]
                                                                    .Value!
                                                                    .toStringAsFixed(
                                                                        0)), //  "₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                                        style: theme
                                                            .textTheme.bodyText2
                                                            ?.copyWith(
                                                                //color:theme.primaryColor,
                                                                //fontWeight: FontWeight.bold
                                                                )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Screens.bodyheight(context) *
                                                  0.01,
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              width: Screens.width(context),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      left: Screens.width(context) *
                                                          0.02,
                                                      right:
                                                          Screens.width(context) *
                                                              0.02,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: Colors.green[200],
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                4)),
                                                    child: Text(
                                                        context.read<NewquoteController>().filterleadOpenAllData[i]
                                                                .LastUpdateTime!
                                                                .isEmpty
                                                            ? ''
                                                            : "${context.read<NewquoteController>().filterleadOpenAllData[i].LastUpdateMessage}",
                                                        style: theme
                                                            .textTheme.bodyText2
                                                            ?.copyWith(
                                                          //color:theme.primaryColor,
                                                          color: Colors.green[700],
                                                          // fontWeight: FontWeight.bold
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: Screens.bodyheight(context) *
                                                  0.01,
                                            ),
                      
                                            Container(
                                              // color: Colors.green[200],
                                              alignment: Alignment.centerLeft,
                                              width: Screens.width(context),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(4)),
                                                child: Text(
                                                    context.read<NewquoteController>().filterleadOpenAllData[i]
                                                            .createdDate!.isEmpty
                                                        ? ''
                                                        : "Created Date: " +
                                                            context
                                                                .watch<
                                                                    NewquoteController>()
                                                                .config
                                                                .alignDate(
                                                                    "${context.read<NewquoteController>().filterleadOpenAllData[i].createdDate}"), //     "${context.watch<EnquiryUserContoller>().getopenEnqData[i].Status}",
                                                    style: theme.textTheme.bodyText2
                                                        ?.copyWith(
                                                      color: Colors.grey,
                                                      // color: Colors.green[700],
                                                      // fontWeight: FontWeight.bold
                                                    )),
                                              ),
                                            )
                      
                                            // Container(
                                            //     padding: EdgeInsets.symmetric(
                                            //         horizontal: Screens.width(context) * 0.1),
                                            //     child: Divider(
                                            //       thickness: 1,
                                            //     ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                      ),
                    ],
                  ),
            ),
            // Container(
            //   width: Screens.width(context),
            //   height: Screens.bodyheight(context)*0.06,
            //   child: ElevatedButton(child: Text("ok"),onPressed: (){},
            //   style: ElevatedButton.styleFrom(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.only(
            //         bottomLeft: Radius.circular(10),
            //         bottomRight: Radius.circular(10)
            //       )
            //     ),
            //   ),
            //   ))
          ],
        ),
      );
    

  }
}