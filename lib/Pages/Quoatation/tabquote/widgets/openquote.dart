
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/OrderController/TabOrderController.dart';
import 'package:sellerkit/Controller/QuotationController/tabquotescontroller.dart';
import 'package:sellerkit/Models/QuoteModel/quotesgetallModel.dart';
import 'package:sellerkit/Pages/Quoatation/tabquote/widgets/followdialog.dart';

class openquote extends StatefulWidget {
  const openquote({Key? key,
      required this.theme,
      required this.leadOpenAllData,
      
      required this.provi
      })
      : super(key: key);

  final ThemeData theme;

  final List<GetAllQuotesData> leadOpenAllData;

  

  final QuotestabController provi;

  @override
  State<openquote> createState() => _openquoteState();
}

class _openquoteState extends State<openquote> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.03,
          vertical: Screens.bodyheight(context) * 0.02),
      child: GestureDetector(onHorizontalDragUpdate: (details) {
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
            // Container(
            //   margin: EdgeInsets.symmetric(
            //     horizontal: Screens.width(context) * 0.02,
            //   ),
            //   width: Screens.width(context),
            //  // height: Screens.bodyheight(context) * 0.16,
            //   padding: EdgeInsets.symmetric(
            //       horizontal: Screens.width(context) * 0.03,
            //       vertical: Screens.bodyheight(context) * 0.02),
            //   decoration: BoxDecoration(
            //       color: widget.theme.primaryColor.withOpacity(0.05),
            //       borderRadius: BorderRadius.circular(8),
            //       border: Border.all(color: Colors.black26)),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     mainAxisSize:MainAxisSize.min,
            //     children: [
            //       Container(
            //         child: Text("Open Orders",
            //           // "${widget.leadSummaryOpen[0].Caption}",
            //           style: widget.theme.textTheme.bodyText1
            //               ?.copyWith(color: widget.theme.primaryColor),
            //         ),
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Container(
            //               width: Screens.width(context) * 0.4,
            //               child: Text(
            //                 "₹ " ,
            //                     // Config.k_m_b_generator(
            //                     //     widget.leadSummaryOpen[0].Value!.toStringAsFixed(0)),
                            
            //                 style: widget.theme.textTheme.headline6,
            //               )),
            //           Container(
            //             alignment: Alignment.centerRight,
            //             width: Screens.width(context) * 0.4,
            //             child: Text(
            //                 // widget.leadSummaryOpen[0].column!.toStringAsFixed(0) +
            //                     " Orders"),
            //           )
            //         ],
            //       ),
            //       Container(
            //         alignment: Alignment.centerRight,
            //         width: Screens.width(context),
            //         child: Text(
            //           "Target ₹ " ,
            //               // Config.k_m_b_generator(
            //               //     widget.leadSummaryOpen[0].Target!.toStringAsFixed(0)),
            //           //     style: theme.textTheme.bodyText1?.copyWith(
            //           //   //color: Colors.grey
            //           //   fontWeight: FontWeight.w400
            //           // ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.008,
            ),
            Expanded(
              child: RefreshIndicator(
                // key: new GlobalKey<RefreshIndicatorState>(),
                  //  key: RIKeys.riKey6,
                  onRefresh: (){
                     return context.read<OrderTabController>().swipeRefreshIndiactor();
                    },
                child:widget.leadOpenAllData.isEmpty?Center(child: Column(
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
                ),): ListView.builder(
                  itemCount: widget.leadOpenAllData.length,
                  itemBuilder: (BuildContext context, int i) {
                    return InkWell(
                      onTap: (){
                        // print("lead entry: "+widget.leadOpenAllData[i].LeadDocEntry.toString());
                        //    print("lead entry: "+widget.leadOpenAllData[i].Mobile .toString());
                      },
                      onDoubleTap: () {
                         showDialog<dynamic>(
                              context: context,
                              builder: (_) {
                                widget.provi.updateFollowUpDialog = false;
                               // context.read<OrderTabController>().resetValues();
                                return FollowDialog( index: i,leadOpenAllData:widget.leadOpenAllData [i]);
                              }).then((value) {
                                setState(() {
                                  widget.provi.refershAfterClosedialog(context);
                                // widget.provi.callGetAllApi();
                                //  widget.provi.callSummaryApi();
                                });
                              });
                      },
                      onLongPress: (){
                         showDialog<dynamic>(
                              context: context,
                              builder: (_) {
                                widget.provi.updateFollowUpDialog = false;
                               // context.read<OrderTabController>().resetValues();
                                return FollowDialog( index: i,leadOpenAllData:widget.leadOpenAllData[i]);
                              }).then((value) {
                                setState(() {
                                 widget.provi.refershAfterClosedialog(context);
                                //  widget.provi.callGetAllApi();
                                //  widget.provi.callSummaryApi();
                                });
                             
                              });
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
                                  vertical: Screens.bodyheight(context) * 0.006),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black26)
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
                                        width: Screens.width(context) * 0.4,
                                        child: Text(
                                          "Customer",
                                          style: widget.theme.textTheme.bodyText2
                                              ?.copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Text(
                                          "",
                                          style: widget.theme.textTheme.bodyText2
                                              ?.copyWith(color: Colors.grey),
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
                                            "${widget.leadOpenAllData[i].CustomerName}", //  "${context.watch<EnquiryUserContoller>().getopenEnqData[i].CardName}",
                                            style:
                                                widget.theme.textTheme.bodyText2?.copyWith(
                                              color: widget.theme.primaryColor,
                                              // fontWeight: FontWeight.bold
                                            )),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                            //context
                                            // leadOpenAllData[i].DocDate!.isEmpty?'':
                                            //  context.read<OrderTabController>().config.alignDate(
                                            "#${widget.leadOpenAllData[i].OrderNum}",
                                            //),//         // .watch<EnquiryUserContoller>()
                                            // .config
                                            // .alignDate(
                                            //     "${context.watch<EnquiryUserContoller>().getopenEnqData[i].EnqDate}"),
                                            style:
                                                widget.theme.textTheme.bodyText2?.copyWith(
                                              color: widget.theme.primaryColor,
                                              //fontWeight: FontWeight.bold
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.01,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: Screens.width(context),
                                        child: Text(
                                          "Product",
                                          style: widget.theme.textTheme.bodyText2
                                              ?.copyWith(color: Colors.grey),
                                        ),
                                      ),
                                widget.leadOpenAllData[i].Product==null||widget.leadOpenAllData[i].Product=="null"||widget.leadOpenAllData[i].Product!.isEmpty?Container():      Container(
                                        width: Screens.width(context),
                                        // color: Colors.red,
                                        child: Text(
                                        "${widget.leadOpenAllData[i].Product}",
                                            style: widget.theme.textTheme.bodyText2
                                            //?.copyWith(color: Colors.grey),
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        // color: Colors.red,
                                        child: Text(
                                            "Quotes Date", //  "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[i].Lookingfor}",
                                            style:
                                                widget.theme.textTheme.bodyText2?.copyWith(
                                                    //color:theme.primaryColor,
                                                    //fontWeight: FontWeight.bold
                                                    color: Colors.grey)),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        //color: Colors.red,
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                            "Quotes Value", //  "₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                            style:
                                                widget.theme.textTheme.bodyText2?.copyWith(
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
                                        width: Screens.width(context) * 0.4,
                                        child: Text(
                                            widget.leadOpenAllData[i].createdon!.isEmpty
                                                ? ''
                                                : context
                                                    .read<OrderTabController>()
                                                    .config
                                                    .alignDate(
                                                        "${widget.leadOpenAllData[i].createdon}"), //  "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[i].Lookingfor}",
                                            style:
                                                widget.theme.textTheme.bodyText2?.copyWith(
                                                    //color:theme.primaryColor,
                                                    //fontWeight: FontWeight.bold
                                                    )),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          var format = NumberFormat.currency(
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
                                          alignment: Alignment.centerRight,
                                          width: Screens.width(context) * 0.4,
                                          child: Text(
                                              widget.leadOpenAllData[i].Value == -1
                                                  ? ""
                                                  : context
                                                      .read<OrderTabController>()
                                                      .config
                                                      .slpitCurrency(widget.leadOpenAllData[
                                                              i]
                                                          .Value!
                                                          .toStringAsFixed(
                                                              0)), //  "₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                              style: widget.theme.textTheme.bodyText2
                                                  ?.copyWith(
                                                      //color:theme.primaryColor,
                                                      //fontWeight: FontWeight.bold
                                                      )),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.01,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: Screens.width(context),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                            left: Screens.width(context) * 0.02,
                                            right: Screens.width(context) * 0.02,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.green[200],
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                              widget.leadOpenAllData[i]
                                                      .OrderStatus!
                                                      .isEmpty
                                                  ? ''
                                                  : "${widget.leadOpenAllData[i].OrderStatus}",
                                              style: widget.theme.textTheme.bodyText2
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
                                    height: Screens.bodyheight(context) * 0.01,
                                  ),
      
                                  Container(
                                    // color: Colors.green[200],
                                    alignment: Alignment.centerLeft,
                                    width: Screens.width(context),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4)),
                                      child: Text(
                                          widget.leadOpenAllData[i].createdon!.isEmpty
                                              ? ''
                                              : "Created Date: " +
                                                  context
                                                      .watch<OrderTabController>()
                                                      .config
                                                      .alignDate(
                                                          "${widget.leadOpenAllData[i].createdon}"), //     "${context.watch<EnquiryUserContoller>().getopenEnqData[i].Status}",
                                          style:
                                              widget.theme.textTheme.bodyText2?.copyWith(
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
