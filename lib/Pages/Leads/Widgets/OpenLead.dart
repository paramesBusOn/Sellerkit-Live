// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, unnecessary_new, avoid_print

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import '../../../../Constant/Screen.dart';
import '../../../Constant/Configuration.dart';
import '../../../Controller/LeadController/TabLeadController.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/GetAllLeadModel.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/GetLeadSummary.dart';
import '../../Enquiries/EnquiriesUser/Widgets/GlobalKeys.dart';
import 'FollowDialog.dart';

class OpenLeadPage extends StatefulWidget {
  const OpenLeadPage(
      {Key? key,
      required this.theme,
      required this.leadOpenAllData,
      required this.leadSummaryOpen,
      required this.provi})
      : super(key: key);

  final ThemeData theme;

  final List<GetAllLeadData> leadOpenAllData;

  final List<SummaryLeadData> leadSummaryOpen;

  final LeadTabController provi;

  @override
  State<OpenLeadPage> createState() => _OpenLeadPageState();
}

class _OpenLeadPageState extends State<OpenLeadPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.03,
          vertical: Screens.bodyheight(context) * 0.02),
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
        child:widget.leadOpenAllData.isEmpty?Center(child:Column(
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
            Text('No data..!!',),
          ],
        ))
        
        : Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.02,
              ),
              width: Screens.width(context),
              // height: Screens.bodyheight(context) * 0.16,
              padding: EdgeInsets.symmetric(
                  horizontal: Screens.width(context) * 0.03,
                  vertical: Screens.bodyheight(context) * 0.02),
              decoration: BoxDecoration(
                  color: widget.theme.primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black26)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "${widget.leadSummaryOpen[0].Caption}",
                          style: widget.theme.textTheme.bodyText1
                              ?.copyWith(color: widget.theme.primaryColor),
                        ),
                      ),
                        Container(
                    alignment: Alignment.centerRight,
                    // width: Screens.width(context),
                    child: Text(
                      "Target ₹ "
                       +widget
                              .leadSummaryOpen[0].Target!.toString(),
                          // Config.k_m_b_generator(widget
                          //     .leadSummaryOpen[0].Target!
                          //     .toStringAsFixed(0)),
                     
                    ),
                  )
                   
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: Screens.width(context) * 0.3,
                          child: Text(
                            "₹ " 
                            +
                                Config.k_m_b_generator(widget
                                    .leadSummaryOpen[0].Value!
                                    .toStringAsFixed(0)),
                           
                            style: widget.theme.textTheme.headline6,
                          )
                          ),
                     Container(
                    alignment: Alignment.centerRight,
                    // width: Screens.width(context),
                    child: Text(
                      "Balance to go ₹ "
                       +widget
                              .leadSummaryOpen[0].btg!.toString(),
                          // Config.k_m_b_generator(widget
                          //     .leadSummaryOpen[0].btg!
                          //     .toStringAsFixed(0)),
                      style: widget.theme.textTheme.bodyText1,
                    ),
                  )

                    ],
                  ),
                 Container(
                        alignment: Alignment.centerLeft,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          widget.leadSummaryOpen[0].column!
                                .toStringAsFixed(0) +
                            " Leads"),
                      )
                ],
              ),
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.008,
            ),
            Expanded(
              child: RefreshIndicator(
                // key: new GlobalKey<RefreshIndicatorState>(),
                //  key: RIKeys.riKey6,
                onRefresh: () {
                  return context
                      .read<LeadTabController>()
                      .swipeRefreshIndiactor();
                },
                child: widget.leadOpenAllData.isEmpty
                    ? Center(child: Text('No data..!!'))
                    : ListView.builder(
                        itemCount: widget.leadOpenAllData.length,
                        itemBuilder: (BuildContext context, int i) {
                          return InkWell(
                            onTap: () {
                              // print("lead entry: "+widget.filterleadOpenAllData[i].LeadDocEntry.toString());
                              //    print("lead entry: "+widget.leadOpenAllData[i].Mobile .toString());
                            },
                            onDoubleTap: () {
                              showDialog<dynamic>(
                                  context: context,
                                  builder: (_) {
                                    widget.provi.updateFollowUpDialog = false;
                                    // context.read<LeadTabController>().resetValues();
                                    return FollowDialog(
                                      index: i,
                                      leadopenalldata: widget.leadOpenAllData[i],
                                    );
                                  }).then((value) {
                                setState(() {
                                context
                      .read<LeadTabController>()
                      .swipeRefreshIndiactor();
                                  //  widget.provi.callSummaryApi();
                                });
                              });
                            },
                            onLongPress: () {
                              showDialog<dynamic>(
                                  context: context,
                                  builder: (_) {
                                    widget.provi.updateFollowUpDialog = false;
                                    // context.read<LeadTabController>().resetValues();
                                    return FollowDialog(
                                      index: i,
                                      leadopenalldata: widget.leadOpenAllData[i],
                                    );
                                  }).then((value) {
                                setState(() {
                                  context
                      .read<LeadTabController>()
                      .swipeRefreshIndiactor();
                                  // widget.provi.refershAfterClosedialog();
                                  // widget.provi.callGetAllApi();
                                  //  widget.provi.callSummaryApi();
                                });
                              });
                            },
                            child: Container(
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
                                        color: Colors.grey[200],
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
                                                style: widget
                                                    .theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "",
                                                style: widget
                                                    .theme.textTheme.bodyText2
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
                                                  "${widget.leadOpenAllData[i].CustomerName}", //  "${context.watch<EnquiryUserContoller>().getopenEnqData[i].CardName}",
                                                  style: widget
                                                      .theme.textTheme.bodyText2
                                                      ?.copyWith(
                                                    color: widget
                                                        .theme.primaryColor,
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
                                                  //  context.read<LeadTabController>().config.alignDate(
                                                  "#${widget.leadOpenAllData[i].LeadNum}",
                                                  //),//         // .watch<EnquiryUserContoller>()
                                                  // .config
                                                  // .alignDate(
                                                  //     "${context.watch<EnquiryUserContoller>().getopenEnqData[i].EnqDate}"),
                                                  style: widget
                                                      .theme.textTheme.bodyText2
                                                      ?.copyWith(
                                                    color: widget
                                                        .theme.primaryColor,
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
                                                style: widget
                                                    .theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              width: Screens.width(context),
                                              // color: Colors.red,
                                              child: Text(
                                                  "${widget.leadOpenAllData[i].Product}",
                                                  style: widget
                                                      .theme.textTheme.bodyText2
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
                                                  style: widget
                                                      .theme.textTheme.bodyText2
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
                                                  style: widget
                                                      .theme.textTheme.bodyText2
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
                                                  widget.leadOpenAllData[i]
                                                          .NextFollowup!.isEmpty
                                                      ? ''
                                                      : context
                                                          .read<
                                                              LeadTabController>()
                                                          .config
                                                          .alignDate(
                                                              "${widget.leadOpenAllData[i].NextFollowup}"), //  "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[i].Lookingfor}",
                                                  style: widget
                                                      .theme.textTheme.bodyText2
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
                                                    widget.leadOpenAllData[i]
                                                                .Value ==
                                                            -1
                                                        ? ""
                                                        : context
                                                            .read<
                                                                LeadTabController>()
                                                            .config
                                                            .slpitCurrency(widget
                                                                .leadOpenAllData[
                                                                    i]
                                                                .Value!
                                                                .toStringAsFixed(
                                                                    0)), //  "₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                                    style: widget.theme
                                                        .textTheme.bodyText2
                                                        ?.copyWith(
                                                            //color:theme.primaryColor,
                                                            //fontWeight: FontWeight.bold
                                                            )),
                                              ),
                                            ),
                                          ],
                                        ),
                              //           Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //   //  Container(
                              //   //       padding: EdgeInsets.only(
                              //   //         left: Screens.width(context) * 0.02,
                              //   //         right: Screens.width(context) * 0.02,
                              //   //       ),
                              //   //       // decoration: BoxDecoration(
                              //   //       //   color: Colors.orange[100],
                              //   //       //   borderRadius: BorderRadius.circular(4)
                              //   //       // ),
                              //   //    // width: Screens.width(context) * 0.1,
                              //   //       child: Text(
                              //   //           "",
                              //   //           style: widget.theme.textTheme.bodyText2?.copyWith(
                              //   //               color: Colors.grey,
                              //   //               fontSize: 12,
      
                              //   //              fontWeight: FontWeight.w500
                              //   //               )),
                              //   //     ),
                       
                              //   ],
                              // ),
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
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                        widget
                                                                .leadOpenAllData[i]
                                                                .LastUpdateTime!
                                                                .isEmpty
                                                            ? ''
                                                            : "${widget.leadOpenAllData[i].LastUpdateMessage}",
                                                        style: widget.theme
                                                            .textTheme.bodyText2
                                                            ?.copyWith(
                                                          //color:theme.primaryColor,
                                                          color: Colors.green[700],
                                                          // fontWeight: FontWeight.bold
                                                        )),
                                                  ),
                                                 widget.leadOpenAllData[i].InterestLevel ==null|| widget.leadOpenAllData[i].InterestLevel!.isEmpty?Container():       Container(
                                    // color: Colors.amber,
                                  alignment: Alignment.centerRight,
                                  //  width: Screens.width(context) * 0.5,
                                    padding: EdgeInsets.only(
                                        left: Screens.width(context) * 0.02,
                                        right: Screens.width(context) * 0.02,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.orange[100],
                                        borderRadius: BorderRadius.circular(4)
                                      ),
                                    child:
                                         Text(
                                            "${widget.leadOpenAllData[i].InterestLevel.toString()}", style: widget.theme.textTheme.bodyText2?.copyWith(
                                               fontSize: 12,
                                                color:Colors.grey,
                                                fontStyle: FontStyle.italic
                                               
                                               // fontWeight: FontWeight.bold
                                                )),
                                       
                                     
                                  )
                                                ],
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
                                                widget.leadOpenAllData[i]
                                                        .createdDate!.isEmpty
                                                    ? ''
                                                    : "Created Date: " +
                                                    context
                                                          .read<
                                                              LeadTabController>()
                                                          .config
                                                          .alignDate(
                                                              "${widget.leadOpenAllData[i].createdDate}"),
                                                        // context
                                                        //     .watch<
                                                        //         LeadTabController>()
                                                        //     .config
                                                        //     .subtractDTWith2(
                                                        //         "${widget.leadOpenAllData[i].updatedDate}"), //     "${context.watch<EnquiryUserContoller>().getopenEnqData[i].Status}",
                                                style: widget
                                                    .theme.textTheme.bodyText2
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
            )
          ],
        ),
      ),
    );
  }
}
