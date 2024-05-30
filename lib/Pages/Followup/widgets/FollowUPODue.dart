// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/FollowupController/FollowUPController.dart';
import 'FollowUPDialogPg.dart';

class FollowUPODue extends StatefulWidget {
  FollowUPODue({Key? key, required this.prdFUP}) : super(key: key);
  FollowupController prdFUP;

  @override
  State<FollowUPODue> createState() => _FollowUPODueState();
}

class _FollowUPODueState extends State<FollowUPODue> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: EdgeInsets.only(
        left: Screens.width(context) * 0.03,
        right: Screens.width(context) * 0.03,
        top: Screens.bodyheight(context) * 0.02,
        bottom: Screens.bodyheight(context) * 0.01,
      ),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          // Check if the user is swiping from left to right
          print(details.primaryDelta);
          if (details.primaryDelta! > ConstantValues.slidevalue!) {
            setState(() {
              Get.offAllNamed(ConstantRoutes.dashboard);
            });
          }
        },
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.02,
              ),
              width: Screens.width(context),
              // height: Screens.bodyheight(context) * 0.25,
              padding: EdgeInsets.symmetric(
                  horizontal: Screens.width(context) * 0.03,
                  vertical: Screens.bodyheight(context) * 0.02),
              decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black26)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Container(
                  //   child:
                  //   Column(
                  //     children: [
                  Container(
                    width: Screens.width(context),
                    child: Text(
                      // "#0 Leads are over due for followup",
                      "${widget.prdFUP.getfollowUPKPIOverDue[0].OverdueKPI_Line_1}",
                        textAlign: TextAlign.center,
                      style: theme.textTheme.bodyText1?.copyWith(fontSize: 15),
                    ),
                  ),
                  
                  // Container(
                  //   width: Screens.width(context),
                  //   child: Text(
                  //     "1",
                  //     // ${prdFUP.getfollowUPKPIOverDue[0].OverdueKPI_Line_1}",
                  //     style: theme.textTheme.bodyText2?.copyWith(fontSize: 14),
                  //   ),
                  // ),

                  // Container(
                  //   width: Screens.width(context),
                  //   child: Text(
                  //     "1",
                  //     // ${prdFUP.getfollowUPKPIOverDue[0].OverdueKPI_Line_2}",
                  //     style: theme.textTheme.bodyText2?.copyWith(fontSize: 14),
                  //   ),
                  // ),
                 
                  //   ],
                  // ),
                  // ),
                  Divider(),
                  Container(
                    width: Screens.width(context),
                    child: Text(
                      // "About 0.00% of your sales target can be acheived by following",
                       "${widget.prdFUP.getfollowUPKPIOverDue[0].OverdueKPI_Line_2}",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyText2?.copyWith(fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.008,
            ),
            Expanded(
              child: widget.prdFUP.fupODueListData.isEmpty
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
                      Text("No data..!!",textAlign: TextAlign.center,),
                    ],
                  ))
                  : ListView.builder(
                      itemCount: widget.prdFUP.fupODueListData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onDoubleTap: () {
                            showDialog<dynamic>(
                                context: context,
                                builder: (_) {
                                  return FollowUPDialogPG(
                                      index: index,
                                      followUPListData:
                                          widget.prdFUP.fupODueListData[index]);
                                }).then((value) => widget.prdFUP.swipeRefreshIndiactor());
                          },
                          onLongPress: () {
                            showDialog<dynamic>(
                                context: context,
                                builder: (_) {
                                  return FollowUPDialogPG(
                                      index: index,
                                      followUPListData:
                                          widget.prdFUP.fupODueListData[index]);
                                }).then((value) => widget.prdFUP.swipeRefreshIndiactor());
                          },
                          child: Container(
                            width: Screens.width(context),
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.02,
                                vertical: Screens.bodyheight(context) * 0.006),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Screens.width(context) * 0.02,
                                      vertical:
                                          Screens.bodyheight(context) * 0.006),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(8),
                                      border:
                                          Border.all(color: Colors.black26)),
                                  width: Screens.width(context),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: Screens.width(context) * 0.4,
                                            child: Text(
                                              "Customer",
                                              style: theme.textTheme.bodyText2
                                                  ?.copyWith(
                                                      color: Colors.grey),
                                            ),
                                          ),
                                          Container(
                                            width: Screens.width(context) * 0.4,
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
                                            width: Screens.width(context) * 0.4,
                                            child: Text(
                                                "${widget.prdFUP.fupODueListData[index].Customer}",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                  color: theme.primaryColor,
                                                )),
                                          ),
                                          Container(
                                            width: Screens.width(context) * 0.4,
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                                "#${widget.prdFUP.fupODueListData[index].LeadDocNum}",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                  color: theme.primaryColor,
                                                )),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
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
                                            child: Text(
                                                "${widget.prdFUP.fupODueListData[index].Product}",
                                                style:
                                                    theme.textTheme.bodyText2),
                                          ),
                                        ],
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
                                            width: Screens.width(context) * 0.4,
                                            child: Text("Next Follow up",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                        color: Colors.grey)),
                                          ),
                                            Container(
                                                width: Screens.width(context) *
                                                    0.3,
                                                // color: Colors.red,
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text("Order Value",
                                                    style: theme
                                                        .textTheme.bodyText2
                                                        ?.copyWith(
                                                            color:
                                                                Colors.grey)),
                                              ),
                                          // Container(
                                          //   width: Screens.width(context) * 0.3,
                                          //   //color: Colors.red,
                                          //   alignment: Alignment.centerRight,
                                          //   child: Text("Followup Time",
                                          //       style: theme.textTheme.bodyText2
                                          //           ?.copyWith(
                                          //               color: Colors.grey)),
                                          // ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: Screens.width(context) * 0.4,
                                            child: Text(
                                                widget.prdFUP.config.alignDate(
                                                    "${widget.prdFUP.fupODueListData[index].FollowupDate}"),
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith()),
                                          ),
                                          InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  width:
                                                      Screens.width(context) *
                                                          0.3,
                                                  child: Text(
                                                      widget.prdFUP.config
                                                          .slpitCurrency(
                                                              "${widget.prdFUP.fupODueListData[index].DocTotal!.toStringAsFixed(0)}"),
                                                      style: theme
                                                          .textTheme.bodyText2
                                                          ?.copyWith()),
                                                ),
                                              ),
                                          // InkWell(
                                          //   onTap: () {},
                                          //   child: widget.prdFUP.config
                                          //               .alignDateFollowTime(
                                          //                   "${widget.prdFUP.fupODueListData[index].FollowupDate}") ==
                                          //           "00:00:00"
                                          //       ? Container()
                                          //       : Container(
                                          //           alignment:
                                          //               Alignment.centerRight,
                                          //           width:
                                          //               Screens.width(context) *
                                          //                   0.4,
                                          //           child: Text(
                                          //               widget.prdFUP.config
                                          //                   .alignDateFollowTime(
                                          //                       "${widget.prdFUP.fupODueListData[index].FollowupDate}"),
                                          //               style: theme
                                          //                   .textTheme.bodyText2
                                          //                   ?.copyWith()),
                                          //         ),
                                          // ),
                                        ],
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
                                            // width:Screens.width(context)*0.4,
                                            // color: Colors.amber,
                                            alignment: Alignment.centerLeft,
                                            width: Screens.width(context) * 0.5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    left:
                                                        Screens.width(context) *
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
                                                      "${widget.prdFUP.fupODueListData[index].LastFollowupStatus}",
                                                      style: theme
                                                          .textTheme.bodyText2
                                                          ?.copyWith(
                                                        color:
                                                            Colors.green[700],
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                            
                                              //     SizedBox(
                                              //   height: Screens.bodyheight(context) * 0.01,
                                              // ),
                                              
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: Screens.width(context),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                              widget
                                                          .prdFUP
                                                          .fupODueListData[
                                                              index]
                                                          .CretedDate !=
                                                      ''
                                                  ? "Created Date:"+
                                                  widget.prdFUP.config
                                                          .alignDate(
                                                              "${widget.prdFUP.fupODueListData[index].CretedDate}")
                                                  // widget.prdFUP.config
                                                  //     .subtractDateTime3(
                                                  //         "${widget.prdFUP.fupODueListData[index].LastFollowupDate}")
                                                  : '',
                                              style: theme.textTheme.bodyText2
                                                  ?.copyWith(
                                                color: Colors.grey,
                                              )),
                                        ),
                                      )
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
    );
  }
}
