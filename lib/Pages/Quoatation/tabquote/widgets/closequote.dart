
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/QuotationController/tabquotescontroller.dart';
import 'package:sellerkit/Models/QuoteModel/quotesgetallModel.dart';
import 'package:intl/intl.dart';

class closequote extends StatefulWidget {
  const closequote(
      {Key? key,
      required this.theme,
      required this.leadWonAllData,
      required this.provi
      })
      : super(key: key);

  final ThemeData theme;

  final List<GetAllQuotesData> leadWonAllData;


  final QuotestabController provi;

  @override
  State<closequote> createState() => _closequoteState();
}

class _closequoteState extends State<closequote> {
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
          //         child: Text("0",
          //           // "${leadSummaryWon[0].Caption}",
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
          //                 // +
          //                 //     Config.k_m_b_generator(
          //                 //         leadSummaryWon[0].Value!.toStringAsFixed(0)),
          //                 //NumberFormatter.formatter(leadSummaryWon[0].Value!.toStringAsFixed(0))
          //                 //  context.read<OrderTabController>().config.
          //                 //"₹ ${leadSummaryWon[0].Value}"),
          //                 style: widget.theme.textTheme.headline6,
          //               )),
          //           Container(
          //             alignment: Alignment.centerRight,
          //             width: Screens.width(context) * 0.4,
          //             child: Text(
          //                 // leadSummaryWon[0].column!.toStringAsFixed(0) +
          //                     " Orders"),
          //           )
          //         ],
          //       ),
          //       Container(
          //         alignment: Alignment.centerRight,
          //         width: Screens.width(context),
          //         child: Text(
          //           "Target ₹ " ,
          //           // +
          //           //     Config.k_m_b_generator(
          //           //         leadSummaryWon[0].Target!.toStringAsFixed(0)),
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
            child:  RefreshIndicator(
          //  key: RIKeys.riKey5,
             // key: new GlobalKey<RefreshIndicatorState>(),

                onRefresh: (){
                   return context.read<QuotestabController>().swipeRefreshIndiactor(context);
                  },
              child:widget.leadWonAllData.isEmpty?Center(child: Column(
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
                itemCount: widget.leadWonAllData.length,
                itemBuilder: (BuildContext context, int i) {
                  return InkWell(
                  onDoubleTap: () {
                        //  showDialog<dynamic>(
                        //       context: context,
                        //       builder: (_) {
                        //        widget.provi.updateFollowUpDialog = false;
                        //        log("leadOpenAllData:widget.InProcessAllData[i]::"+widget.leadWonAllData[i].isInvoiced.toString());
                        //        // context.read<OrderTabController>().resetValues();
                        //         return FollowDialog( index: i,leadOpenAllData:widget.leadWonAllData[i]);
                        //       }).then((value) {
                        //         setState(() {
                        //           widget.provi.refershAfterClosedialog();
                        //         widget.provi.callGetAllApi();
                        //         //  widget.provi.callSummaryApi();
                        //         });
                        //       });
                      },
                      onLongPress: (){
                        //  showDialog<dynamic>(
                        //       context: context,
                        //       builder: (_) {
                        //        widget.provi.updateFollowUpDialog = false;
                        //        // context.read<OrderTabController>().resetValues();
                        //         return FollowDialog( index: i,leadOpenAllData:widget.leadWonAllData[i]);
                        //       }).then((value) {
                        //         setState(() {
                        //         widget.provi.refershAfterClosedialog();
                        //         widget.provi.callGetAllApi();
                        //         //  widget.provi.callSummaryApi();
                        //         });
                             
                        //       });
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
                                          "${widget.leadWonAllData[i].CustomerName}", //  "${context.watch<EnquiryUserContoller>().getopenEnqData[i].CardName}",
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
                                          // leadWonAllData[i].DocDate!.isEmpty?'':
                                          //  context.read<OrderTabController>().config.alignDate(
                                          "#${widget.leadWonAllData[i].OrderNum}",
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
                                      child: Text("${widget.leadWonAllData[i].Product}",
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
                                          widget.leadWonAllData[i].createdon!.isEmpty
                                              ? ''
                                              : context
                                                  .read<QuotestabController>()
                                                  .config
                                                  .alignDate(
                                                      "${widget.leadWonAllData[i].createdon}"), //  "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[i].Lookingfor}",
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
                                            widget.leadWonAllData[i].Value == -1
                                                ? ""
                                                : context
                                                    .read<QuotestabController>()
                                                    .config
                                                    .slpitCurrency(widget.leadWonAllData[
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
                                            color: Colors.yellow[200],
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Text(
                                            widget.leadWonAllData[i]
                                                    .Status!
                                                    .isEmpty
                                                ? ''
                                                : "${widget.leadWonAllData[i].Status}",
                                            style: widget.theme.textTheme.bodyText2
                                                ?.copyWith(
                                              //color:theme.primaryColor,
                                              color: Colors.yellow[900],
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
                                        widget.leadWonAllData[i].createdon!.isEmpty
                                            ? ''
                                            : "Created Date: " +
                                                context
                                                    .watch<QuotestabController>()
                                                    .config
                                                    .alignDate(
                                                        "${widget.leadWonAllData[i].createdon}"), //     "${context.watch<EnquiryUserContoller>().getopenEnqData[i].Status}",
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