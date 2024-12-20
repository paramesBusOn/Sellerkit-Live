import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Constant/menu_auth.dart';
import 'package:sellerkit/Controller/specialpricecontroller/tab_controller.dart';
import 'package:sellerkit/Models/specialpriceModel/GetAllSPModel.dart';

class Followdialog extends StatefulWidget {
  Followdialog({
    Key? key,
    required this.getalldata,
  }) : super(key: key);
  GetAllSPData getalldata;
  @override
  State<Followdialog> createState() => _FollowdialogState();
}

class _FollowdialogState extends State<Followdialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: (context.watch<tabpriceController>().isviewdetail == false &&
              context.watch<tabpriceController>().isloadingstart == true &&context.watch<tabpriceController>().isapprovedpage == false)
          ? loadingDialog(context)
          : (context.watch<tabpriceController>().isviewdetail == false&&context.watch<tabpriceController>().isapprovedpage == false &&
                  context.watch<tabpriceController>().isloadingstart == false &&
                  context
                      .watch<tabpriceController>()
                      .forwardSuccessMsg
                      .isNotEmpty)
              ? displayDialog(context, theme)
              : (context.watch<tabpriceController>().isloadingstart == false &&
                      context
                          .watch<tabpriceController>()
                          .forwardSuccessMsg
                          .isEmpty &&
                      context.watch<tabpriceController>().isviewdetail == true&&context.watch<tabpriceController>().isapprovedpage == false)
                  ? detailsDialog(context, theme)
                  :(context.watch<tabpriceController>().isloadingstart == false &&
                      context
                          .watch<tabpriceController>()
                          .forwardSuccessMsg
                          .isEmpty &&
                      context.watch<tabpriceController>().isviewdetail == false&&context.watch<tabpriceController>().isapprovedpage == true)?

                  approvedialog(theme)
                  : initialdialog(theme),
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

  Container displayDialog(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      // height: Screens.bodyheight(context) * 0.6,
      // padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(""),
                  Container(
                    alignment: Alignment.center,
                    child: Text("Alert",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: Screens.bodyheight(context) * 0.01,
          ),
          Container(
            child: Column(
              children: [
                Text(
                  context
                          .read<tabpriceController>()
                          .forwardSuccessMsg
                          .contains("Success")
                      ? "Success..!!"
                      : ' "Error..!!"',
                  style: context
                          .watch<tabpriceController>()
                          .forwardSuccessMsg
                          .contains("Success")
                      ? theme.textTheme.titleLarge?.copyWith(color: Colors.green)
                      : theme.textTheme.titleLarge?.copyWith(color: Colors.red),
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Text(
                  context.watch<tabpriceController>().forwardSuccessMsg,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                Container(
                  width: Screens.width(context) * 0.26,
                  height: Screens.bodyheight(context) * 0.06,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        context
                                        .read<tabpriceController>()
                                        .refershAfterClosedialog();
                      },
                      child: Text(
                        "Ok",
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Screens.bodyheight(context) * 0.01,
          ),
        ],
      ),
    );
  }

  Container detailsDialog(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      // height: Screens.bodyheight(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(""),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text("Special Price Details",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            width: Screens.width(context),
            // height: Screens.bodyheight(context) * 0.8,
            // color:Colors.amber,
            padding: EdgeInsets.only(
              top: Screens.bodyheight(context) * 0.01,
              bottom: Screens.bodyheight(context) * 0.01,
              left: Screens.width(context) * 0.03,
              right: Screens.width(context) * 0.03,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.4,
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${widget.getalldata.CustomerName}",
                          style: theme.textTheme.bodyMedium?.copyWith(),
                        ),
                      ),
                      widget.getalldata.CreatedOn == null ||
                              widget.getalldata.CreatedOn == "null" ||
                              widget.getalldata.CreatedOn!.isEmpty
                          ? Container()
                          : Container(
                              width: Screens.width(context) * 0.4,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Color(0xffC6AC5F),
                              ),
                              child: Center(
                                child: Text(
                                  "Open since " +
                                      context
                                          .read<tabpriceController>()
                                          .config
                                          .subtractDateTime2(
                                              // "2020-05-18T00:00:00"
                                              "${widget.getalldata.CreatedOn}"),
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodyMedium?.copyWith(),
                                ),
                              ),
                            )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // context
                      //                     .watch<LeadTabController>()
                      //                     .getleadDeatilsQTHData![0]
                      //                     .Address1 ==
                      //                 null ||
                      //             context
                      //                     .watch<LeadTabController>()
                      //                     .getleadDeatilsQTHData![0]
                      //                     .Address1 ==
                      //                 "null" ||
                      //             context
                      //                 .watch<LeadTabController>()
                      //                 .getleadDeatilsQTHData![0]
                      //                 .Address1!
                      //                 .isEmpty
                      //         ? Container()
                      //         :
                      InkWell(
                        onTap: () {
                          context.read<tabpriceController>().makePhoneCall(
                              widget.getalldata.CustomerCode.toString());
                        },
                        child: Container(
                          width: Screens.width(context) * 0.35,
                          child: Text(
                            "${widget.getalldata.CustomerCode}",
                            style: theme.textTheme.bodyMedium?.copyWith(
                                decoration: TextDecoration.underline,
                                color: Colors.blue),
                          ),
                        ),
                      ),
                       
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "# ${widget.getalldata.DocEntry}",
                          style: theme.textTheme.bodyMedium?.copyWith(),
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   width: Screens.width(context) * 0.43,
                      //   child: Text(
                      //     "Worth of " +
                      //         context
                      //             .watch<tabpriceController>()
                      //             .config
                      //             .slpitCurrency22(
                      //               "${widget.getalldata.SP}",
                      //             ) +
                      //         '/-',
                      //     style: theme.textTheme.bodyMedium?.copyWith(
                      //       color: theme.primaryColor,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     //  context
                  //     //                     .watch<LeadTabController>()
                  //     //                     .getleadDeatilsQTHData![0]
                  //     //                     .Address2 ==
                  //     //                 null ||
                  //     //             context
                  //     //                     .watch<LeadTabController>()
                  //     //                     .getleadDeatilsQTHData![0]
                  //     //                     .Address2 ==
                  //     //                 "null" ||
                  //     //             context
                  //     //                 .watch<LeadTabController>()
                  //     //                 .getleadDeatilsQTHData![0]
                  //     //                 .Address2!
                  //     //                 .isEmpty
                  //     //         ? Container()
                  //     //         :
                  //     Container(
                  //       width: Screens.width(context) * 0.4,
                  //       child: Text(
                  //         "",
                  //         style: theme.textTheme.bodyMedium?.copyWith(),
                  //       ),
                  //     ),
                  //     Container(
                  //       alignment: Alignment.centerRight,
                  //       width: Screens.width(context) * 0.4,
                  //       child: Text(
                  //         "# ${widget.getalldata.DocEntry}",
                  //         style: theme.textTheme.bodyMedium?.copyWith(),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //  context
                      //                   .watch<LeadTabController>()
                      //                   .getleadDeatilsQTHData![0]
                      //                   .City ==
                      //               null ||
                      //           context
                      //                   .watch<LeadTabController>()
                      //                   .getleadDeatilsQTHData![0]
                      //                   .City ==
                      //               "null" ||
                      //           context
                      //               .watch<LeadTabController>()
                      //               .getleadDeatilsQTHData![0]
                      //               .City!
                      //               .isEmpty
                      //       ? Container()
                      //       :
                      Container(
                        // width: Screens.width(context) * 0.4,
                        child: Text(
                          "Requested Date: ${context
                                                      .read<tabpriceController>()
                                                      .config.alignDate(widget.getalldata.RequestDate.toString())}",
                          style: theme.textTheme.bodyMedium?.copyWith(),
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   width: Screens.width(context) * 0.4,
                      //   child: Text(
                      //     "Created on " +
                      //         context.watch<tabpriceController>().config.alignDate3(
                      //             "${widget.getalldata.CreatedOn}" //.LastFUPUpdate
                      //             ),
                      //     style: theme.textTheme.bodyMedium?.copyWith(),
                      //   ),
                      // ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //  context
                      //                   .watch<LeadTabController>()
                      //                   .getleadDeatilsQTHData![0]
                      //                   .CardCode ==
                      //               null ||
                      //           context
                      //                   .watch<LeadTabController>()
                      //                   .getleadDeatilsQTHData![0]
                      //                   .CardCode ==
                      //               "null" ||
                      //           context
                      //               .watch<LeadTabController>()
                      //               .getleadDeatilsQTHData![0]
                      //               .CardCode!
                      //               .isEmpty
                      //       ? Container()
                      //       :
                      // Container(
                      //   //  width: Screens.width(context) * 0.35,
                      //   child: Text(
                      //     "Required Price : ${context.read<tabpriceController>().config.slpitCurrency22(widget.getalldata.RP.toString())}",
                      //     style: theme.textTheme.bodyMedium?.copyWith(),
                      //   ),
                      // ),


                       Container(
                        //  width: Screens.width(context) * 0.35,
                        child: Text(
                          "User Type : ${widget.getalldata.UserType.toString()}",
                          style: theme.textTheme.bodyMedium?.copyWith(),
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   width: Screens.width(context) * 0.50,
                      //   child: Text(
                      //     "Last Updated on "
                      //     // +
                      //         // context.watch<LeadTabController>().config.alignDate3(
                      //         //     "${context.watch<LeadTabController>().getleadDeatilsQTHData![0].LastFUPUpdate}" //.
                      //         //     ),
                      //     style: theme.textTheme.bodyMedium?.copyWith(),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.03,
                  ),
                  createTable(theme),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.03,
                  ),
                  createTable2(theme),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.03,
                  ),
                  // createTable3(theme),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.03,
                  ),
                  //  Align(
                        //  width: Screens.width(context) * 0.35,
                        // alignment: Alignment.bottomLeft,
                        // child: 
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Created Date :${context
                                                        .read<tabpriceController>()
                                                        .config.alignDate(widget.getalldata.CreatedOn.toString())} ${context
                                                        .read<tabpriceController>()
                                                        .config.alignTimenew(widget.getalldata.CreatedOn.toString())} ",
                            //  ${context.watch<tabpriceController>().config.alignDate3(
                            //         "${widget.getalldata.CreatedOn}"
                            //         // )
                            //         }
                                    // ",
                            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                          ),
                        ),
                      // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createTable(ThemeData theme) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Product",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      // Container(
      //   color: theme.primaryColor,
      //   padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      //   child: Text(
      //     "Price",
      //     style: theme.textTheme.bodyMedium
      //         ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
      //     textAlign: TextAlign.left,
      //   ),
      // ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Qty",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    ]));
    for (int i = 0; i < 1; ++i) {
      rows.add(TableRow(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${widget.getalldata.ItemName}',
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        //   child: Text(
        //     "${context.read<tabpriceController>().config.slpitCurrency22(widget.getalldata.SP!.toString())}",
        //     // '${context.watch<LeadTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
        //     textAlign: TextAlign.left,
        //     style: theme.textTheme.bodyMedium?.copyWith(
        //       color: theme.primaryColor,
        //     ),
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${widget.getalldata.Quantity}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
      ]));
    }
    return Table(columnWidths: {
      0: FlexColumnWidth(4),
      // 1: FlexColumnWidth(2.2),
      2: FlexColumnWidth(0.8),
    }, children: rows);
  }




  Widget createTable2(ThemeData theme) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "SP",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Requested Price",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Dis %",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
    ]));
    for (int i = 0; i < 1; ++i) {
      rows.add(TableRow(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            "${context.read<tabpriceController>().config.slpitCurrency22(widget.getalldata.SP!.toString())}",
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text("${
                                          context
                                                      .read<tabpriceController>()
                                                      .config.slpitCurrency22(widget.getalldata.RP.toString())
                                          }",
            
            // '${context.watch<LeadTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            "${context
                            .read<tabpriceController>().Discountcalculation(widget.getalldata.RP, widget.getalldata.SP)}" ,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
      ]));
    }
    return Table(columnWidths: {
      0: FlexColumnWidth(2),
      1: FlexColumnWidth(2.0),
      2: FlexColumnWidth(0.8),
    }, children: rows);
  }

  Widget createTable3(ThemeData theme) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Slab",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "APM",
          style: theme.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      // Container(
      //   color: theme.primaryColor,
      //   padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      //   child: Text(
      //     "Qty",
      //     style: theme.textTheme.bodyMedium
      //         ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
      //     textAlign: TextAlign.left,
      //   ),
      // ),
    ]));
    for (int i = 0; i < 1; ++i) {
      rows.add(TableRow(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${widget.getalldata.UserType}',
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            "${context.read<tabpriceController>().config.slpitCurrency22(widget.getalldata.SP!.toString())}",
            // '${context.watch<LeadTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        //   child: Text(
        //     '${widget.getalldata.Quantity}',
        //     textAlign: TextAlign.center,
        //     style: theme.textTheme.bodyMedium?.copyWith(
        //       color: theme.primaryColor,
        //     ),
        //   ),
        // ),
      ]));
    }
    return Table(columnWidths: {
      0: FlexColumnWidth(3),
      // 1: FlexColumnWidth(2.2),
      2: FlexColumnWidth(2),
    }, children: rows);
  }
approvedialog( ThemeData theme) {
    return Container(
      width: Screens.width(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context),
            height: Screens.padingHeight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ))),
                child: Container(
                  alignment: Alignment.center,
                //  width: Screens.width(context)*0.6,
                  child: Text("Special Price Details"))),
          ),
          SizedBox(
            height: Screens.padingHeight(context) * 0.01,
          ),
          Padding(
            padding: EdgeInsets.all(Screens.padingHeight(context) * 0.02),
            child:
         Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                SizedBox(
                    // width: Screens.width(context) * 0.35,
                    child: ElevatedButton(
                        onPressed: () {
                           if( MenuAuthDetail.Orders == "Y"){
                             setState(() {
                          context.read<tabpriceController>().   covertToorder(widget.getalldata);
                           
                          });

                           }else{
                             showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4))),
                                              contentPadding: EdgeInsets.all(0),
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content: settings(context));
                                        });
                           }
                         
                        },
                        child: const Text("Convert to order"))),
               
              ],
            )
          ),
          // Container(
          //   width: Screens.width(context),
          //   height: Screens.padingHeight(context) * 0.06,
          //   child: ElevatedButton(
          //       onPressed: () {
          //         setState(() {
          //           context.read<tabpriceController>().ontapview();
          //         });
          //       },
          //       style: ElevatedButton.styleFrom(
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.only(
          //         bottomLeft: Radius.circular(10),
          //         bottomRight: Radius.circular(10),
          //       ))),
          //       child: Text("View Details")),
          // ),
        ],
      ),
    );
  }
  initialdialog( ThemeData theme) {
    return Container(
      width: Screens.width(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context),
            height: Screens.padingHeight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                     width: Screens.width(context)*0.6,
                      child: Text("Special Price Details")),
                   GestureDetector(
                          onTap: (){
                          context.read<tabpriceController>().     callitemdetails(widget.getalldata.ItemCode.toString(),context);
                          },
                           child: Container(
                            child: Icon(Icons.more_horiz,color: Colors.white,),
                           ),
                         ),
                  ],
                )),
          ),
          SizedBox(
            height: Screens.padingHeight(context) * 0.01,
          ),
          Padding(
            padding: EdgeInsets.all(Screens.padingHeight(context) * 0.02),
            child:
      widget.getalldata.UserType =="Owner" ?     Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


                SizedBox(
                    width: Screens.width(context) * 0.35,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                          context.read<tabpriceController>().   modifymethod(widget.getalldata);
                            // context.read<tabpriceController>().statusupdate(
                            //     widget.getalldata.DocEntry.toString(), "A");
                          });
                        },
                        child: const Text("Modify"))),
                SizedBox(
                    width: Screens.width(context) * 0.35,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                           context.read<tabpriceController>(). cancelmethod(widget.getalldata.DocEntry.toString());
                            // context.read<tabpriceController>().statusupdate(
                            //     widget.getalldata.DocEntry.toString(), "R");
                          });
                        },
                        child: const Text("Cancel")))
              ],
            ):
            
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [


                SizedBox(
                    width: Screens.width(context) * 0.35,
                    child: ElevatedButton(
                        onPressed:widget.getalldata.UserType =="Viewer"?(){}: () {
                          setState(() {
                            context.read<tabpriceController>().statusupdate(
                                widget.getalldata.DocEntry.toString(), "A");
                          });
                        },
                         style:  widget.getalldata.UserType =="Viewer" ?  
                                 ElevatedButton.styleFrom(
                                    backgroundColor:
                                        //  theme.primaryColor
                                        Colors.grey[200])
                                : ElevatedButton.styleFrom(
                                    backgroundColor:theme.primaryColor
                                    // Colors.grey[200]
                                    ),
                        child:  Text("Approve",style: TextStyle(
                          color:  widget.getalldata.UserType =="Viewer" ? 
                          theme.primaryColor: Colors.white
                        ),)
                        )
                        ),
                SizedBox(
                    width: Screens.width(context) * 0.35,
                    child: ElevatedButton(
                        onPressed:  widget.getalldata.UserType =="Viewer"?(){}:() {
                          setState(() {
                            context.read<tabpriceController>().statusupdate(
                                widget.getalldata.DocEntry.toString(), "R");
                          });
                        },
                         style:  widget.getalldata.UserType =="Viewer" ?  
                                 ElevatedButton.styleFrom(
                                    backgroundColor:
                                        //  theme.primaryColor
                                        Colors.grey[200])
                                : ElevatedButton.styleFrom(
                                    backgroundColor:theme.primaryColor
                                    // Colors.grey[200]
                                    ),
                        child:  Text("Reject",style: TextStyle(
                          color:  widget.getalldata.UserType =="Viewer" ? 
                          theme.primaryColor: Colors.white
                        ),))
                        )
                        
              ],
            ),
          ),
          Container(
            width: Screens.width(context),
            height: Screens.padingHeight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    context.read<tabpriceController>().ontapview();
                  });
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ))),
                child: Text("View Details")),
          ),
        ],
      ),
    );
  }

  settings(BuildContext context) {
  final theme = Theme.of(context);
  return StatefulBuilder(builder: (context, st) {
    return Container(
      padding: EdgeInsets.only(
          top: Screens.padingHeight(context) * 0.01,
          left: Screens.width(context) * 0.03,
          right: Screens.width(context) * 0.03,
          bottom: Screens.padingHeight(context) * 0.01),
      width: Screens.width(context) * 1.1,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.padingHeight(context) * 0.05,
              color: theme.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Screens.padingHeight(context) * 0.02,
                        right: Screens.padingHeight(context) * 0.02),
                    // color: Colors.red,
                    width: Screens.width(context) * 0.5,
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Alert",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: Screens.padingHeight(context) * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.02,
            ),
            Container(
                alignment: Alignment.center,
                width: Screens.width(context),
                child: Text('You are not authorised..!!')),
            SizedBox(
              height: Screens.bodyheight(context) * 0.02,
            ),
          ],
        ),
      ),
    );
  });
}
}
