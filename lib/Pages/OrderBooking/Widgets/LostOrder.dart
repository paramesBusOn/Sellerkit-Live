// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, unnecessary_new

import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../Constant/Configuration.dart';
import '../../../Controller/OrderController/TabOrderController.dart';
import '../../../Models/PostQueryModel/OrdersCheckListModel/GetAllOrderModel.dart';
import '../../../Models/PostQueryModel/OrdersCheckListModel/GetOrderSummary.dart';
import '../../Enquiries/EnquiriesUser/Widgets/GlobalKeys.dart';
import 'FollowDialog.dart';

class LostOrderPage extends StatefulWidget {
  const LostOrderPage(
      {Key? key,
      required this.theme,
      required this.leadLostAllData,
      required this.leadSummaryLost,
      required this.provi
      })
      : super(key: key);

  final ThemeData theme;

  final List<GetAllOrderData> leadLostAllData;

  final List<SummaryOrderData> leadSummaryLost;

  final OrderTabController provi;

  @override
  State<LostOrderPage> createState() => _LostOrderPageState();
}

class _LostOrderPageState extends State<LostOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.03,
          vertical: Screens.bodyheight(context) * 0.02),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Screens.width(context) * 0.02,
            ),
            width: Screens.width(context),
            //height: Screens.bodyheight(context) * 0.16,
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
              mainAxisSize:MainAxisSize.min,
              children: [
                Container(
                  child: Text(
                    "${widget.leadSummaryLost[0].Caption}",
                    style: widget.theme.textTheme.bodyText1
                        ?.copyWith(color: widget.theme.primaryColor),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "₹ " +
                              Config.k_m_b_generator(
                                  widget.leadSummaryLost[0].Value!.toStringAsFixed(0)),
                          //NumberFormatter.formatter(leadSummaryLost[0].Value!.toStringAsFixed(0))
                          //  context.read<OrderTabController>().config.
                          //"₹ ${leadSummaryLost[0].Value}"),
                          style: widget.theme.textTheme.headline6,
                        )),
                    Container(
                      alignment: Alignment.centerRight,
                      width: Screens.width(context) * 0.4,
                      child: Text(
                          widget.leadSummaryLost[0].column!.toStringAsFixed(0) +
                              " Leads"),
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: Screens.width(context),
                  child: Text(
                    "Target ₹ " +
                        Config.k_m_b_generator(
                            widget.leadSummaryLost[0].Target!.toString()),
                    //     style: theme.textTheme.bodyText1?.copyWith(
                    //   //color: Colors.grey
                    //   fontWeight: FontWeight.w400
                    // ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: Screens.bodyheight(context) * 0.008,
          ),
          Expanded(
            child:
              RefreshIndicator(
            //  key: new GlobalKey<RefreshIndicatorState>(),
             //     key: RIKeys.riKey4,
                onRefresh: (){
                   return context.read<OrderTabController>().swipeRefreshIndiactor();
                  },
              child: ListView.builder(
                itemCount: widget.leadLostAllData.length,
                itemBuilder: (BuildContext context, int i) {
                  return InkWell(
                 
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
                                          "${widget.leadLostAllData[i].CustomerName}", //  "${context.watch<EnquiryUserContoller>().getopenEnqData[i].CardName}",
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
                                          // leadLostAllData[i].DocDate!.isEmpty?'':
                                          //  context.read<OrderTabController>().config.alignDate(
                                          "#${widget.leadLostAllData[i].OrderNum}",
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
                                    Container(
                                      width: Screens.width(context),
                                      // color: Colors.red,
                                      child: Text("${widget.leadLostAllData[i].Product}",
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
                                          "Next Follow up", //  "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[i].Lookingfor}",
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
                                          "Order Value", //  "₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
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
                                      // child: Text(
                                      //     leadLostAllData[i].NextFollowup!.isEmpty
                                      //         ? ''
                                      //         : context
                                      //             .read<OrderTabController>()
                                      //             .config
                                      //             .alignDate(
                                      //                 "${leadLostAllData[i].NextFollowup}"), //  "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[i].Lookingfor}",
                                      //     style:
                                      //         theme.textTheme.bodyText2?.copyWith(
                                      //             //color:theme.primaryColor,
                                      //             //fontWeight: FontWeight.bold
                                      //             )),
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
                                            widget.leadLostAllData[i].Value == -1
                                                ? ""
                                                : context
                                                    .read<OrderTabController>()
                                                    .config
                                                    .slpitCurrency(widget.leadLostAllData[
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
                                            color: Colors.red[200],
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Text(
                                            widget.leadLostAllData[i]
                                                    .LastUpdateTime!
                                                    .isEmpty
                                                ? ''
                                                : "${widget.leadLostAllData[i].LastUpdateMessage}",
                                            style: widget.theme.textTheme.bodyText2
                                                ?.copyWith(
                                              //color:theme.primaryColor,
                                              color: Colors.red[700],
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
                                        widget.leadLostAllData[i].LastUpdateTime!.isEmpty
                                            ? ''
                                            : "Last Updated: " +
                                                context
                                                    .watch<OrderTabController>()
                                                    .config
                                                    .subtractDateTime(
                                                        "${widget.leadLostAllData[i].LastUpdateTime}"), //     "${context.watch<EnquiryUserContoller>().getopenEnqData[i].Status}",
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
    );
  }
}
