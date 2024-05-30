// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/SiteInController/SiteInController.dart';
import 'package:timeline_tile/timeline_tile.dart';

// import '../Controller/FollowupController/FollowUPController.dart';
// import '../Models/PostQueryModel/FollowUPModel.dart/FollowUPModel.dart';

class SuccessDialogPG extends StatefulWidget {
  SuccessDialogPG({
    Key? key,
    required this.heading,
        required this.msg,

  }) : super(key: key);

  String? heading;
  String? msg;

  @override
  State<SuccessDialogPG> createState() => _FollowUPDialogPGState();
}

class _FollowUPDialogPGState extends State<SuccessDialogPG> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider<SiteInController>(
        create: (context) => SiteInController(),
        builder: (context, child) {
          return Consumer<SiteInController>(
              builder: (BuildContext context, fUPCon, Widget? child) {
            return AlertDialog(
                insetPadding: EdgeInsets.all(10),
                contentPadding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                content: CallDialog(context, theme, fUPCon));
          });
        });
  }

  Container CallDialog(
      BuildContext context, ThemeData theme, SiteInController fUPCon) {
    return Container(
      width: Screens.width(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      // fontSize: 12,
                      ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )), //Radius.circular(6)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Container(),
                    // Container(
                    //   width: Screens.width(context) * 0.1,
                    //   height: Screens.bodyheight(context) * 0.05,
                    //   decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       border: Border.all(color: Colors.white)),
                    //   child: Icon(
                    //     Icons.call,
                    //     size: Screens.bodyheight(context) * 0.02,
                    //   ),
                    // ),
                    Container(child: Text("${widget.heading}")),
                    // Container(),
                  ],
                )),
          ),
          Container(
            width: Screens.width(context),
            padding: EdgeInsets.only(
              left: Screens.width(context) * 0.05,
              right: Screens.width(context) * 0.05,
              top: Screens.bodyheight(context) * 0.03,
              bottom: Screens.bodyheight(context) * 0.03,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "${widget.msg}",
                            style: theme.textTheme.bodyText1?.copyWith(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        // Container(
                        //   child: Text(
                        //     "Click Here",
                        //     style: theme.textTheme.bodyText2
                        //         ?.copyWith(color: Colors.grey),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
           Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                onPressed: () {
                   Navigator.pop(context);

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (_) => SettlementSuccessCard()));
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(
                      // fontSize: 12,
                      ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )), //Radius.circular(6)
                ),
                child: Text(
                  "Close",
                ),
              ),
            ),
        ],
      ),
    );
  }

  Container loadingDialog(BuildContext context) {
    return Container(
        width: Screens.width(context),
        height: Screens.bodyheight(context) * 0.4,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ));
  }

  // Container displayDialog(
  //     BuildContext context, ThemeData theme, FollowupController fUPCon) {
  //   return Container(
  //     alignment: Alignment.center,
  //     width: Screens.width(context),
  //     height: Screens.bodyheight(context) * 0.3,
  //     padding: EdgeInsets.all(20),
  //     child: Center(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             fUPCon.getforwardSuccessMsg.contains("Success")
  //                 ? "Success..!!"
  //                 : ' "Something wrong..!!"',
  //             style: fUPCon.getforwardSuccessMsg.contains("Success")
  //                 ? theme.textTheme.headline6?.copyWith(color: Colors.green)
  //                 : theme.textTheme.headline6?.copyWith(color: Colors.red),
  //           ),
  //           SizedBox(
  //             height: Screens.bodyheight(context) * 0.02,
  //           ),
  //           Text(
  //             fUPCon.getforwardSuccessMsg,
  //             textAlign: TextAlign.center,
  //             style: theme.textTheme.bodyText1,
  //           ),
  //           SizedBox(
  //             height: Screens.bodyheight(context) * 0.02,
  //           ),
  //           Container(
  //             width: Screens.width(context) * 0.26,
  //             height: Screens.bodyheight(context) * 0.06,
  //             child: ElevatedButton(
  //                 style: ElevatedButton.styleFrom(
  //                   primary: theme.primaryColor,
  //                   shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(6))),
  //                 ),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text(
  //                   "Ok",
  //                 )),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  //view details

  // Container detailsDialog(
  //     BuildContext context, ThemeData theme, FollowupController fUPCon) {
  //   return Container(
  //     width: Screens.width(context),
  //     height: Screens.bodyheight(context),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Container(
  //           width: Screens.width(context),
  //           height: Screens.bodyheight(context) * 0.06,
  //           child: ElevatedButton(
  //             onPressed: () {},
  //             style: ElevatedButton.styleFrom(
  //               textStyle: TextStyle(
  //                   // fontSize: 12,
  //                   ),
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(10),
  //                 topRight: Radius.circular(10),
  //               )), //Radius.circular(6)
  //             ),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Container(
  //                   alignment: Alignment.centerLeft,
  //                   child: Text(""),
  //                 ),
  //                 Container(
  //                   alignment: Alignment.center,
  //                   child: Text("Lead Details",
  //                       style: theme.textTheme.bodyText1
  //                           ?.copyWith(color: Colors.white)),
  //                 ),
  //                 InkWell(
  //                   onTap: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: Container(
  //                       alignment: Alignment.centerRight,
  //                       child: Icon(
  //                         Icons.close,
  //                         color: Colors.white,
  //                       )),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Container(
  //           width: Screens.width(context),
  //           height: Screens.bodyheight(context) * 0.87,
  //           padding: EdgeInsets.only(
  //             top: Screens.bodyheight(context) * 0.01,
  //             bottom: Screens.bodyheight(context) * 0.01,
  //             left: Screens.width(context) * 0.03,
  //             right: Screens.width(context) * 0.03,
  //           ),
  //           child: SingleChildScrollView(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Container(
  //                       width: Screens.width(context) * 0.4,
  //                       child: Text(
  //                         "${fUPCon.getleadDeatilsQTHData!.CardName}",
  //                         style: theme.textTheme.bodyText2?.copyWith(),
  //                       ),
  //                     ),
  //                     Container(
  //                       width: Screens.width(context) * 0.4,
  //                       alignment: Alignment.centerRight,
  //                       padding:
  //                           EdgeInsets.symmetric(horizontal: 4, vertical: 3),
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(3),
  //                         color: Color(0xffC6AC5F),
  //                       ),
  //                       child: Center(
  //                         child: Text(
  //                           "Open since " + fUPCon.config.subtractDateTime2(
  //                               // "2020-05-18T00:00:00"
  //                               "${fUPCon.getleadDeatilsQTHData!.OrderCreatedDate}"),
  //                           textAlign: TextAlign.center,
  //                           style: theme.textTheme.bodyText2?.copyWith(),
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Container(
  //                       width: Screens.width(context) * 0.4,
  //                       child: Text(
  //                         "${fUPCon.getleadDeatilsQTHData!.Address1}",
  //                         style: theme.textTheme.bodyText2?.copyWith(),
  //                       ),
  //                     ),
  //                     Container(
  //                       alignment: Alignment.centerRight,
  //                       width: Screens.width(context) * 0.43,
  //                       child: Text(
  //                         "Worth of Rs." +
  //                             fUPCon.config.slpitCurrency2(
  //                               "${fUPCon.getleadDeatilsQTHData!.DocTotal!.toStringAsFixed(0)}",
  //                             ) +
  //                             '/-',
  //                         style: theme.textTheme.bodyText2?.copyWith(
  //                           color: theme.primaryColor,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Container(
  //                       width: Screens.width(context) * 0.4,
  //                       child: Text(
  //                         "${fUPCon.getleadDeatilsQTHData!.Address2}",
  //                         style: theme.textTheme.bodyText2?.copyWith(),
  //                       ),
  //                     ),
  //                     Container(
  //                       alignment: Alignment.centerRight,
  //                       width: Screens.width(context) * 0.4,
  //                       child: Text(
  //                         "# ${fUPCon.getleadDeatilsQTHData!.OrderNum}",
  //                         style: theme.textTheme.bodyText2?.copyWith(),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Container(
  //                       width: Screens.width(context) * 0.4,
  //                       child: Text(
  //                         "${fUPCon.getleadDeatilsQTHData!.City}",
  //                         style: theme.textTheme.bodyText2?.copyWith(),
  //                       ),
  //                     ),
  //                     Container(
  //                       alignment: Alignment.centerRight,
  //                       width: Screens.width(context) * 0.4,
  //                       child: Text(
  //                         "Created on " +
  //                             fUPCon.config.alignDate3(
  //                                 "${fUPCon.getleadDeatilsQTHData!.OrderCreatedDate}" //.LastFUPUpdate
  //                                 ),
  //                         style: theme.textTheme.bodyText2?.copyWith(),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Container(
  //                       width: Screens.width(context) * 0.4,
  //                       child: Text(
  //                         "${fUPCon.getleadDeatilsQTHData!.Pincode}",
  //                         style: theme.textTheme.bodyText2?.copyWith(),
  //                       ),
  //                     ),
  //                     Container(
  //                       alignment: Alignment.centerRight,
  //                       width: Screens.width(context) * 0.43,
  //                       child: Text(
  //                         "Last Update on " +
  //                             fUPCon.config.alignDate3(
  //                                 "${fUPCon.getleadDeatilsQTHData!.LastFUPUpdate}" //.
  //                                 ),
  //                         style: theme.textTheme.bodyText2?.copyWith(),
  //                       ),
  //                     ),
  //                   ],
  //                 ),

  //                 // createTable(theme),

  //                 SizedBox(
  //                   height: Screens.bodyheight(context) * 0.01,
  //                 ),
  //                 Container(
  //                     width: Screens.width(context),
  //                     padding: EdgeInsets.symmetric(
  //                         // horizontal: Screens.width(context) * 0.03,
  //                         vertical: Screens.bodyheight(context) * 0.02),
  //                     decoration: BoxDecoration(
  //                         color: theme.primaryColor.withOpacity(0.05),
  //                         borderRadius: BorderRadius.circular(8),
  //                         border: Border.all(color: Colors.black26)),
  //                     child: Column(
  //                       children: [
  //                         Center(
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             child: Text(
  //                               'Next Follow up # ' +
  //                                   fUPCon.config.alignDate(
  //                                       '${fUPCon.getleadDeatilsLeadData[fUPCon.getleadDeatilsLeadData.length - 1].NextFollowup_Date}'),
  //                               textAlign: TextAlign.center,
  //                               style: theme.textTheme.bodyText2?.copyWith(
  //                                 color: theme.primaryColor,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Container(
  //                             width: Screens.width(context),
  //                             margin: EdgeInsets.only(
  //                               // left: Screens.width(context) * 0.03,
  //                               top: Screens.bodyheight(context) * 0.01,
  //                               bottom: Screens.bodyheight(context) * 0.01,
  //                             ),
  //                             decoration: BoxDecoration(
  //                                 border: Border(
  //                                     bottom:
  //                                         BorderSide(color: Colors.black26)))),
  //                         Center(
  //                           child: Container(
  //                             alignment: Alignment.center,
  //                             child: Text(
  //                               'Last status # ${fUPCon.getleadDeatilsLeadData[fUPCon.getleadDeatilsLeadData.length - 1].Status}',
  //                               textAlign: TextAlign.center,
  //                               style: theme.textTheme.bodyText2?.copyWith(
  //                                 color: theme.primaryColor,
  //                               ),
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     )),
  //                 SizedBox(
  //                   height: Screens.bodyheight(context) * 0.015,
  //                 ),
  //                 createTable(theme, fUPCon),
  //                 Divider(
  //                   thickness: 1,
  //                 ),
  //                 SizedBox(
  //                   height: Screens.bodyheight(context) * 0.01,
  //                 ),
  //                 //
  //                 Wrap(
  //                     spacing: 0.0, // width
  //                     runSpacing: 0.0, // height
  //                     children: listTimeLine(theme, fUPCon)),
  //                 SizedBox(
  //                   height: Screens.bodyheight(context) * 0.01,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Container(
  //           width: Screens.width(context),
  //           height: Screens.bodyheight(context) * 0.06,
  //           child: ElevatedButton(
  //               onPressed: () {
  //                 fUPCon.followUPClicked();
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 textStyle: TextStyle(
  //                     // fontSize: 12,
  //                     ),
  //                 shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.only(
  //                   bottomLeft: Radius.circular(10),
  //                   bottomRight: Radius.circular(10),
  //                 )), //Radius.circular(6)
  //               ),
  //               child: Text("Followup")),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget createTable(ThemeData theme, SiteInController fUPCon) {
  //   List<TableRow> rows = [];
  //   rows.add(TableRow(children: [
  //     Container(
  //       color: theme.primaryColor,
  //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //       child: Text(
  //         "Product",
  //         style: theme.textTheme.bodyText1
  //             ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
  //         textAlign: TextAlign.left,
  //       ),
  //     ),
  //     Container(
  //       color: theme.primaryColor,
  //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //       child: Text(
  //         "Price",
  //         style: theme.textTheme.bodyText1
  //             ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
  //         textAlign: TextAlign.left,
  //       ),
  //     ),
  //     Container(
  //       color: theme.primaryColor,
  //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //       child: Text(
  //         "Qty",
  //         style: theme.textTheme.bodyText1
  //             ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
  //         textAlign: TextAlign.left,
  //       ),
  //     ),
  //   ]));
  //   for (int i = 0; i < fUPCon.getleadDeatilsQTLData.length; ++i) {
  //     rows.add(TableRow(children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //         child: Text(
  //           '${fUPCon.getleadDeatilsQTLData[i].ItemName!}',
  //           textAlign: TextAlign.left,
  //           style: theme.textTheme.bodyText1?.copyWith(
  //             color: theme.primaryColor,
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //         child: Text(
  //           fUPCon.config.slpitCurrency(
  //               fUPCon.getleadDeatilsQTLData[i].Price!.toStringAsFixed(0)),
  //           // '${fUPCon.getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
  //           textAlign: TextAlign.center,
  //           style: theme.textTheme.bodyText1?.copyWith(
  //             color: theme.primaryColor,
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //         child: Text(
  //           '${fUPCon.getleadDeatilsQTLData[i].Quantity!.toStringAsFixed(0)}',
  //           textAlign: TextAlign.center,
  //           style: theme.textTheme.bodyText1?.copyWith(
  //             color: theme.primaryColor,
  //           ),
  //         ),
  //       ),
  //     ]));
  //   }
  //   return Table(columnWidths: {
  //     0: FlexColumnWidth(4),
  //     1: FlexColumnWidth(2.2),
  //     2: FlexColumnWidth(0.8),
  //   }, children: rows);
  // }

  // List<Widget> listTimeLine(ThemeData theme, FollowupController fUPCon) {
  //   return List.generate(fUPCon.getleadDeatilsLeadData.length, (index) {
  //     if (index == 0) {
  //       //  log("1");
  //       return Column(
  //         children: [
  //           TimelineTile(
  //             alignment: TimelineAlign.manual,
  //             lineXY: 0.2,
  //             isFirst: true,
  //             indicatorStyle: IndicatorStyle(
  //               width: 30,
  //               color: theme.primaryColor,
  //               indicatorXY: 0.2,
  //               padding: EdgeInsets.only(
  //                 top: 4,
  //                 left: 4,
  //                 right: 4,
  //               ),
  //               iconStyle: IconStyle(
  //                 color: Colors.white,
  //                 iconData: fUPCon.getleadDeatilsLeadData[index].FollowMode ==
  //                         'Phone Call'
  //                     ? Icons.call
  //                     : fUPCon.getleadDeatilsLeadData[index].FollowMode ==
  //                             'Sms/WhatsApp'
  //                         ? Icons.abc
  //                         : fUPCon.getleadDeatilsLeadData[index].FollowMode ==
  //                                 'Store Visit'
  //                             ? Icons.store
  //                             : Icons.chat,
  //               ),
  //             ),
  //             beforeLineStyle: const LineStyle(
  //               color: Colors.grey,
  //               thickness: 3,
  //             ),
  //             afterLineStyle: const LineStyle(
  //               color: Colors.grey,
  //               thickness: 3,
  //             ),
  //             endChild: Container(
  //               alignment: Alignment.centerLeft,
  //               width: Screens.width(context) * 0.6,
  //               child: Column(
  //                 children: [
  //                   Container(
  //                     alignment: Alignment.centerLeft,
  //                     child: Text(
  //                       "${fUPCon.getleadDeatilsLeadData[index].Status} ",
  //                       style: theme.textTheme.bodyText2,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: Screens.bodyheight(context) * 0.01,
  //                   ),
  //                   Container(
  //                     alignment: Alignment.centerLeft,
  //                     child: Text(
  //                       // fUPCon.config.alignDate(
  //                       "By ${fUPCon.getleadDeatilsLeadData[index].UpdatedBy} through ${fUPCon.getleadDeatilsLeadData[index].FollowMode}", //),
  //                       style: theme.textTheme.bodyText2?.copyWith(
  //                           // color: theme.primaryColor,
  //                           ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: Screens.bodyheight(context) * 0.02,
  //                   ),
  //                   fUPCon.getleadDeatilsLeadData[index].Feedback!.isEmpty
  //                       ? SizedBox()
  //                       : Container(
  //                           alignment: Alignment.centerLeft,
  //                           child: Text(
  //                             // fUPCon.config.alignDate(
  //                             "# ${fUPCon.getleadDeatilsLeadData[index].Feedback}",
  //                             style: theme.textTheme.bodyText2?.copyWith(
  //                                 // color: theme.primaryColor,
  //                                 ),
  //                           ),
  //                         ),
  //                   Divider(
  //                     thickness: 1,
  //                   ),
  //                   //       SizedBox(
  //                   //   height: Screens.bodyheight(context) * 0.01,
  //                   // ),
  //                 ],
  //               ),
  //             ),
  //             startChild: Container(
  //                 padding: EdgeInsets.only(
  //                     left: Screens.width(context) * 0.02,
  //                     right: Screens.width(context) * 0.02),
  //                 // alignment:Alignment.centerRight,
  //                 // color: Colors.blue,
  //                 width: Screens.width(context) * 0.25,
  //                 child: Column(
  //                   children: [
  //                     Text(
  //                       fUPCon.config.alignDate2(
  //                         "${fUPCon.getleadDeatilsLeadData[index].Followup_Date_Time}",
  //                       ),
  //                       textAlign: TextAlign.center,
  //                       style: theme.textTheme.bodyText2,
  //                     ),
  //                   ],
  //                 )),
  //           ),
  //         ],
  //       );
  //     } else if (index == fUPCon.getleadDeatilsLeadData.length - 1) {
  //       //log("2");
  //       return Column(
  //         children: [
  //           TimelineTile(
  //             isLast: true,
  //             lineXY: 0.2,
  //             alignment: TimelineAlign.manual,
  //             indicatorStyle: IndicatorStyle(
  //               width: 30,
  //               color: theme.primaryColor,
  //               // indicatorXY: 0.7,
  //               padding: EdgeInsets.all(4),
  //               iconStyle: IconStyle(
  //                 color: Colors.white,
  //                 iconData: fUPCon.getleadDeatilsLeadData[index].FollowMode ==
  //                         'Phone Call'
  //                     ? Icons.call
  //                     : fUPCon.getleadDeatilsLeadData[index].FollowMode ==
  //                             'Sms/WhatsApp'
  //                         ? Icons.abc
  //                         : fUPCon.getleadDeatilsLeadData[index].FollowMode ==
  //                                 'Store Visit'
  //                             ? Icons.store
  //                             : Icons.chat,
  //               ),
  //             ),
  //             beforeLineStyle: const LineStyle(
  //               color: Colors.grey,
  //               thickness: 3,
  //             ),
  //             afterLineStyle: const LineStyle(
  //               color: Colors.grey,
  //               thickness: 3,
  //             ),
  //             endChild: Container(
  //               alignment: Alignment.centerLeft,
  //               width: Screens.width(context) * 0.6,
  //               padding: EdgeInsets.only(
  //                   left: Screens.width(context) * 0.02,
  //                   right: Screens.width(context) * 0.02),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   SizedBox(
  //                     height: Screens.bodyheight(context) * 0.01,
  //                   ),
  //                   Container(
  //                     alignment: Alignment.centerLeft,
  //                     child: Text(
  //                       "${fUPCon.getleadDeatilsLeadData[index].Status} ",
  //                       style: theme.textTheme.bodyText2,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: Screens.bodyheight(context) * 0.01,
  //                   ),
  //                   Container(
  //                     alignment: Alignment.centerLeft,
  //                     child: Text(
  //                       // fUPCon.config.alignDate(
  //                       "By ${fUPCon.getleadDeatilsLeadData[index].UpdatedBy} through ${fUPCon.getleadDeatilsLeadData[index].FollowMode}", //),
  //                       style: theme.textTheme.bodyText2?.copyWith(
  //                           // color: theme.primaryColor,
  //                           ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: Screens.bodyheight(context) * 0.01,
  //                   ),
  //                   fUPCon.getleadDeatilsLeadData[index].Feedback!.isEmpty
  //                       ? SizedBox()
  //                       : Container(
  //                           alignment: Alignment.centerLeft,
  //                           child: Text(
  //                             // fUPCon.config.alignDate(
  //                             "# ${fUPCon.getleadDeatilsLeadData[index].Feedback}",
  //                             style: theme.textTheme.bodyText2?.copyWith(
  //                                 // color: theme.primaryColor,
  //                                 ),
  //                           ),
  //                         ),
  //                 ],
  //               ),
  //             ),
  //             startChild: Container(
  //                 padding: EdgeInsets.only(
  //                     left: Screens.width(context) * 0.02,
  //                     right: Screens.width(context) * 0.02),
  //                 width: Screens.width(context) * 0.25,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     SizedBox(
  //                       height: Screens.bodyheight(context) * 0.01,
  //                     ),
  //                     Text(
  //                       fUPCon.config.alignDate2(
  //                         "${fUPCon.getleadDeatilsLeadData[index].Followup_Date_Time}",
  //                       ),
  //                       textAlign: TextAlign.center,
  //                       style: theme.textTheme.bodyText2,
  //                     ),
  //                   ],
  //                 )),
  //           ),
  //         ],
  //       );
  //     } else {
  //       // log("3");
  //       return Column(
  //         children: [
  //           TimelineTile(
  //             alignment: TimelineAlign.manual,
  //             lineXY: 0.2,
  //             indicatorStyle: IndicatorStyle(
  //               width: 30,
  //               color: theme.primaryColor,
  //               //   indicatorXY:  0.7,
  //               padding: EdgeInsets.all(4),
  //               iconStyle: IconStyle(
  //                 color: Colors.white,
  //                 iconData: fUPCon.getleadDeatilsLeadData[index].FollowMode ==
  //                         'Phone Call'
  //                     ? Icons.call
  //                     : fUPCon.getleadDeatilsLeadData[index].FollowMode ==
  //                             'Sms/WhatsApp'
  //                         ? Icons.abc
  //                         : fUPCon.getleadDeatilsLeadData[index].FollowMode ==
  //                                 'Store Visit'
  //                             ? Icons.store
  //                             : Icons.chat,
  //               ),
  //             ),
  //             beforeLineStyle: const LineStyle(
  //               color: Colors.grey,
  //               thickness: 3,
  //             ),
  //             afterLineStyle: const LineStyle(
  //               color: Colors.grey,
  //               thickness: 3,
  //             ),
  //             endChild: Container(
  //               // color: Colors.red,
  //               width: Screens.width(context) * 0.6,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Container(
  //                     alignment: Alignment.centerLeft,
  //                     child: Text(
  //                       "${fUPCon.getleadDeatilsLeadData[index].Status} ",
  //                       style: theme.textTheme.bodyText2,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: Screens.bodyheight(context) * 0.01,
  //                   ),
  //                   Container(
  //                     alignment: Alignment.centerLeft,
  //                     child: Text(
  //                       // fUPCon.config.alignDate(
  //                       "By ${fUPCon.getleadDeatilsLeadData[index].UpdatedBy} through ${fUPCon.getleadDeatilsLeadData[index].FollowMode}", //),
  //                       style: theme.textTheme.bodyText2?.copyWith(
  //                           // color: theme.primaryColor,
  //                           ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: Screens.bodyheight(context) * 0.01,
  //                   ),
  //                   fUPCon.getleadDeatilsLeadData[index].Feedback!.isEmpty
  //                       ? SizedBox()
  //                       : Container(
  //                           alignment: Alignment.centerLeft,
  //                           child: Text(
  //                             // fUPCon.config.alignDate(
  //                             "# ${fUPCon.getleadDeatilsLeadData[index].Feedback}",
  //                             style: theme.textTheme.bodyText2?.copyWith(
  //                                 // color: theme.primaryColor,
  //                                 ),
  //                           ),
  //                         ),
  //                   Divider(
  //                     thickness: 1,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             startChild: Container(
  //                 //  color: Colors.red,
  //                 padding: EdgeInsets.only(
  //                     left: Screens.width(context) * 0.02,
  //                     right: Screens.width(context) * 0.02),
  //                 width: Screens.width(context) * 0.25,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       fUPCon.config.alignDate2(
  //                         "${fUPCon.getleadDeatilsLeadData[index].Followup_Date_Time}",
  //                       ),
  //                       textAlign: TextAlign.center,
  //                       style: theme.textTheme.bodyText2,
  //                     ),
  //                   ],
  //                 )),
  //           ),
  //         ],
  //       );
  //     }
  //   });
  // }

//forwad dialog
  // Container forwardDialog(
  //     BuildContext context, ThemeData theme, FollowupController fUPCon) {
  //   return Container(
  //     width: Screens.width(context),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     padding: EdgeInsets.only(
  //       left: Screens.width(context) * 0.05,
  //       right: Screens.width(context) * 0.05,
  //       top: Screens.bodyheight(context) * 0.03,
  //       bottom: Screens.bodyheight(context) * 0.03,
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Wrap(
  //             spacing: 10.0, // gap between adjacent chips
  //             runSpacing: 10.0, // gap between lines
  //             children: listContainersProduct(theme, fUPCon)),
  //         SizedBox(
  //           height: Screens.bodyheight(context) * 0.01,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Container(
  //                 child: Text(
  //               fUPCon.getforwardNextFollowDate!, // "Next Follow up",
  //               style: theme.textTheme.bodyText2?.copyWith(
  //                 color: fUPCon.getforwardNextFollowDate!.contains("*")
  //                     ? Colors.red
  //                     : Colors.grey,
  //               ), // fontSize: 12
  //             )),
  //             InkWell(
  //               onTap: () {
  //                 fUPCon.showForwardNextDate(context);
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(
  //                     horizontal: Screens.width(context) * 0.015),
  //                 width: Screens.width(context) * 0.5,
  //                 height: Screens.bodyheight(context) * 0.05,
  //                 decoration: BoxDecoration(
  //                     border: Border.all(color: Colors.grey),
  //                     borderRadius: BorderRadius.circular(4)),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Container(
  //                       width: Screens.width(context) * 0.3,
  //                       // color: Colors.red,
  //                       child: Text(
  //                         fUPCon.getforwardnextWonFD,
  //                         // fUPCon.getnextFD,
  //                         style: theme.textTheme.bodyText2
  //                             ?.copyWith(), //fontSize: 12
  //                       ),
  //                     ),
  //                     Container(
  //                       alignment: Alignment.centerRight,
  //                       width: Screens.width(context) * 0.15,
  //                       // color: Colors.red,
  //                       child: Icon(
  //                         Icons.calendar_month,
  //                         // size: Screens.,
  //                         color: theme.primaryColor,
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //         SizedBox(
  //           height: Screens.bodyheight(context) * 0.01,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Container(
  //               width: Screens.width(context) * 0.26,
  //               height: Screens.bodyheight(context) * 0.06,
  //               child: ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(6))),
  //                   ),
  //                   onPressed: () {
  //                     fUPCon.forwardClicked();
  //                   },
  //                   child: Text("Back")),
  //             ),
  //             Container(
  //               width: Screens.width(context) * 0.26,
  //               height: Screens.bodyheight(context) * 0.06,
  //               child: ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(6))),
  //                   ),
  //                   onPressed: () {},
  //                   child: Text("Forward")),
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

  // List<Widget> listContainersProduct(
  //     ThemeData theme, FollowupController fUPCon) {
  //   return List.generate(
  //     fUPCon.getuserLtData.length,
  //     (ind) => GestureDetector(
  //       onTap: () {
  //         fUPCon.getSelectedUserSalesEmpId(ind);
  //       },
  //       child: Container(
  //         width: Screens.width(context) * 0.4,
  //         padding: EdgeInsets.all(5),
  //         decoration: BoxDecoration(
  //             color: fUPCon.getuserLtData[ind].color == 1
  //                 ? theme.primaryColor
  //                 : Colors.white,
  //             border: Border.all(color: theme.primaryColor, width: 1),
  //             borderRadius: BorderRadius.circular(5)),
  //         child: Text(fUPCon.getuserLtData[ind].UserName!,
  //             textAlign: TextAlign.center,
  //             style: theme.textTheme.bodyText1?.copyWith(
  //               fontWeight: FontWeight.normal,
  //               fontSize: 16,
  //               color: fUPCon.getuserLtData[ind].color == 1
  //                   ? Colors.white
  //                   : theme.primaryColor,
  //             )),
  //       ),
  //     ),
  //   );
  // }

//open close won update dialog
}
