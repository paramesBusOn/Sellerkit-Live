// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/CollectionController/CollectionController.dart';
import 'package:sellerkit/Models/CollectionModel/CollectionModel.dart';
import 'package:sellerkit/Pages/Collection/widgets/CollectionPDF/CollectionPdfHelper.dart';
import 'package:sellerkit/Pages/Collection/widgets/CollectionPDF/CollectionsPdf.dart';
//import 'package:timelines/timelines.dart';

class CollectionFollowDialog extends StatefulWidget {
  CollectionFollowDialog({
    Key? key,
    required this.index,
    required this.lineDetails,
    required this.masterDetails,
    required this.tabvalue
  }) : super(key: key);
  final int index;
  List<CollectionDataIpayDocLine>? lineDetails;
  CollectionDataIpayMaster? masterDetails;
  String? tabvalue;

  @override
  State<CollectionFollowDialog> createState() => _FollowDialogState();
}

class _FollowDialogState extends State<CollectionFollowDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // if (ColletionContoller.comeFromEnq == -1 &&
      //     ColletionContoller.isanyExcep == 0) {
      //   context.read<ColletionContoller>().resetValuesIS1();
      //   context.read<ColletionContoller>().opendialogbool = false;
      // }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // Provider.of<ColletionContoller>(context).dispose();
    //  context.read<ColletionContoller>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: //UpdateFollowup(context, theme),
            (context.read<ColletionContoller>().calldialog == true &&
                    context.read<ColletionContoller>().canceldialogbool ==
                        false &&
                    context.read<ColletionContoller>().detailsDialog == false)
                ? CallDialog(context, theme)
                : (context.read<ColletionContoller>().calldialog == false &&
                        context.read<ColletionContoller>().canceldialogbool ==
                            true &&
                        context.read<ColletionContoller>().detailsDialog ==
                            false)
                    ? CancelDialog(context, theme)
                    : (context.read<ColletionContoller>().calldialog == false &&
                            context
                                    .read<ColletionContoller>()
                                    .canceldialogbool ==
                                false &&
                            context.read<ColletionContoller>().detailsDialog ==
                                true)
                        ? detailsDialog(context, theme)
                        : null);
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

  Container CallDialog(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      //  height: Screens.bodyheight(context)*0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      // padding: EdgeInsets.only(
      //   left: Screens.width(context) * 0.05,
      //   right: Screens.width(context) * 0.05,
      //   top: Screens.bodyheight(context) * 0.03,
      //   bottom: Screens.bodyheight(context) * 0.03,
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {
                  // context.read<ColletionContoller>().makePhoneCall(context
                  //     .read<ColletionContoller>()
                  //     .getAllLeadData[widget.index]
                  //     .Mobile!);
                },
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(),
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
                    Container(child: Text("Message")),
                    Container(),
                  ],
                )),
          ),
          Container(
            width: Screens.width(context),
            padding: EdgeInsets.only(
              left: Screens.width(context) * 0.03,
              right: Screens.width(context) * 0.03,
              top: Screens.bodyheight(context) * 0.01,
              bottom: Screens.bodyheight(context) * 0.01,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),

                    //secode Row
                    Row(
                      mainAxisAlignment:widget.tabvalue =='1'?MainAxisAlignment.center: MainAxisAlignment.spaceAround,
                      
                     
                      children: [
                        Container(
                          alignment: Alignment.center,
                          // width: Screens.width(context) * 0.35,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                ),
                              onPressed: () async {


                                CollectionReceiptPdfHelper.totalSumOfAp = 0;
                                CollectionReceiptPdfHelper.lineDetails =
                                    widget.lineDetails;
                                await context
                                    .read<ColletionContoller>()
                                    .callcustCompnyapi();

                                CollectionReceiptPdfHelper.frmAddressmodeldata =
                                    context
                                        .read<ColletionContoller>()
                                        .frmAddmodeldata;
                                CollectionReceiptPdfHelper.toCustomerAddDet =
                                    widget.masterDetails;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CollectionReceiptPdf()));
                              },
                              child: Text(
                                'Share Document',
                                style: theme.textTheme.bodyText1!
                                    .copyWith(color: Colors.white),
                              )),
                        ),

                        //invoice
                     widget.tabvalue =='1'?Container():    Container(
                          width: Screens.width(context) * 0.35,
                          child: ElevatedButton(
                            
                              onPressed: () {
                                setState(() {
                                  context
                                      .read<ColletionContoller>()
                                      .canceldialogbool = true;
                                  context
                                      .read<ColletionContoller>()
                                      .detailsDialog = false;
                                  context
                                      .read<ColletionContoller>()
                                      .calldialog = false;
                                });
                                
                                // context.read<ColletionContoller>().cancelApi(
                                //     context,
                                //     widget.masterDetails!.docentry.toString());
                              },
                              child: Text('Cancel',)),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
              ],
            ),
          ),
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    context.read<ColletionContoller>().calldialog = false;
                    context.read<ColletionContoller>().canceldialogbool = false;
                    context.read<ColletionContoller>().detailsDialog = true;
                  });
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
                child: Text("View Details")),
          ),
        ],
      ),
    );
  }

  Container CancelDialog(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      //  height: Screens.bodyheight(context)*0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      // padding: EdgeInsets.only(
      //   left: Screens.width(context) * 0.05,
      //   right: Screens.width(context) * 0.05,
      //   top: Screens.bodyheight(context) * 0.03,
      //   bottom: Screens.bodyheight(context) * 0.03,
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {
                  // context.read<ColletionContoller>().makePhoneCall(context
                  //     .read<ColletionContoller>()
                  //     .getAllLeadData[widget.index]
                  //     .Mobile!);
                },
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(),
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
                    Container(child: Text("Message")),
                    Container(),
                  ],
                )),
          ),
          Container(
            width: Screens.width(context),
            padding: EdgeInsets.only(
              left: Screens.width(context) * 0.03,
              right: Screens.width(context) * 0.03,
              top: Screens.bodyheight(context) * 0.01,
              bottom: Screens.bodyheight(context) * 0.01,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                Form(
                  key: context.read<ColletionContoller>().formkey[0],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller:
                            context.read<ColletionContoller>().mycontroller[1],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Required field..';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          // counterText: '',
                          labelText: 'Remarks',
                          labelStyle: theme.textTheme.bodyText1!
                              .copyWith(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            //  when the TextFormField in unfocused
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            //  when the TextFormField in focused
                          ),
                          border: UnderlineInputBorder(),
                          // enabledBorder: UnderlineInputBorder(),
                          // focusedBorder: UnderlineInputBorder(),
                          errorBorder: UnderlineInputBorder(),
                          focusedErrorBorder: UnderlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.01,
                      ),
                      //secode Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //invoice
                          Container(
                            width: Screens.width(context) * 0.35,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    context
                                        .read<ColletionContoller>()
                                        .cancelApi(
                                            context,
                                            widget.masterDetails!.docentry
                                                .toString(),
                                            context
                                                .read<ColletionContoller>()
                                                .mycontroller[1]
                                                .text
                                                .toString());
                                  });
                                },
                                child: Text('Cancel')),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
              ],
            ),
          ),
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                  //   context.read<ColletionContoller>().calldialog = false;
                  //   context.read<ColletionContoller>().canceldialogbool = false;
                  //   context.read<ColletionContoller>().detailsDialog = false;
                  //   context.read<ColletionContoller>().refreshindicator();
                    Navigator.pop(context);
                  });
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
                child: Text("Close")),
          ),
        ],
      ),
    );
  }

  //view details

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
                    child: Text("Collection Details",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white)),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context); 
                      });
                     
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
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.77,
            padding: EdgeInsets.only(
              top: Screens.bodyheight(context) * 0.01,
              bottom: Screens.bodyheight(context) * 0.01,
              left: Screens.width(context) * 0.03,
              right: Screens.width(context) * 0.01,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${widget.masterDetails!.customerName}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        width: Screens.width(context) * 0.4,
                        alignment: Alignment.centerRight,
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Color(0xffC6AC5F),
                        ),
                        child: Center(
                          child: Text(
                            "Open since " +
                                context
                                    .read<ColletionContoller>()
                                    .config
                                    .subtractDateTime4(
                                        // "2020-05-18T00:00:00"
                                        "${context.read<ColletionContoller>().config.alignDateT(widget.masterDetails!.docDate!)}"),
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyText2?.copyWith(),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${widget.masterDetails!.bil_Address1}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.43,
                        child: Text(
                          "Worth of Rs." +
                              context
                                  .watch<ColletionContoller>()
                                  .config
                                  .slpitCurrency22(
                                    "${widget.masterDetails!.amountpaid!.toString()}",
                                  ) +
                              '/-',
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${widget.masterDetails!.bil_Address2}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "# ${widget.masterDetails!.docNum}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${widget.masterDetails!.bil_City}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "Created on " +
                              context.watch<ColletionContoller>().config.alignDate3(
                                  "${widget.masterDetails!.docDate}" //.LastFUPUpdate
                                  ),
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${widget.masterDetails!.bil_Pincode}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   width: Screens.width(context) * 0.43,
                      //   child: Text(
                      //     "Last Update on " +
                      //         context.watch<ColletionContoller>().config.alignDate3(
                      //             "${context.watch<ColletionContoller>().getleadDeatilsQTHData!.LastFUPUpdate}" //.
                      //             ),
                      //     style: theme.textTheme.bodyText2?.copyWith(),
                      //   ),
                      // ),
                    ],
                  ),

                  // createTable(theme),

                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),

                  SizedBox(
                    height: Screens.bodyheight(context) * 0.015,
                  ),
                  createTable(theme),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  //

                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              //  color: Colors.red,
                              width: Screens.width(context) * 0.55,

                              // height: Screens.padingHeight(context),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "Total Amount",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${context
                                  .watch<ColletionContoller>()
                                  .config
                                  .slpitCurrency22(widget.masterDetails!.amountpaid.toString())}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {
                setState(() {
                        Navigator.pop(context); 
                      });
                  // context.read<ColletionContoller>().viweDetailsClicked();
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
                child: Text("Close")),
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
          "Transref",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Trans Num",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        alignment: Alignment.centerRight,
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Sum",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
    ]));
    for (int i = 0; i < widget.lineDetails!.length; ++i) {
      rows.add(TableRow(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${widget.lineDetails![i].transRef1}',
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${widget.lineDetails![i].transnum}',
            // '${context.watch<ColletionContoller>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context
                                  .watch<ColletionContoller>()
                                  .config
                                  .slpitCurrency22(widget.lineDetails![i].sumApplied.toString())}',
            textAlign: TextAlign.right,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
      ]));
    }
    return Table(columnWidths: {
      0: FlexColumnWidth(2),
      1: FlexColumnWidth(2),
      2: FlexColumnWidth(2),
    }, children: rows);
  }

//

  // List<Widget> listContainersProduct(ThemeData theme) {
  //   return List.generate(
  //     context.watch<ColletionContoller>().collectionGetLine.length,
  //     (ind) => GestureDetector(
  //       onTap: () {
  //         // context.read<ColletionContoller>().getSelectedUserSalesEmpId(ind);
  //       },
  //       child: Container(
  //         width: Screens.width(context) * 0.4,
  //         padding: EdgeInsets.all(5),
  //         decoration: BoxDecoration(
  //             color: context
  //                         .watch<ColletionContoller>()
  //                         .collectionGetLine[ind]
  //                         .color ==
  //                     1
  //                 ? theme.primaryColor
  //                 : Colors.white,
  //             border: Border.all(color: theme.primaryColor, width: 1),
  //             borderRadius: BorderRadius.circular(5)),
  //         child: Text(
  //             context.watch<ColletionContoller>().getuserLtData[ind].UserName!,
  //             textAlign: TextAlign.center,
  //             style: theme.textTheme.bodyText1?.copyWith(
  //               fontWeight: FontWeight.normal,
  //               fontSize: 12,
  //               color: context
  //                           .watch<ColletionContoller>()
  //                           .getuserLtData[ind]
  //                           .color ==
  //                       1
  //                   ? Colors.white
  //                   : theme.primaryColor,
  //             )),
  //       ),
  //     ),
  //   );
  // }
}
