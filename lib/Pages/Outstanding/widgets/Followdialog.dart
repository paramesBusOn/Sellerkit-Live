// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/OutStandingController/OutStandingController.dart';
import 'package:sellerkit/DBModel/outstandingDBmodel.dart';
import 'package:sellerkit/Pages/Outstanding/widgets/PDFViewer/PDFViewer/pdfOutStandHelper.dart';

import 'PDFViewer/PDFViewer/OutStandPdf.dart';

class Followdialog extends StatefulWidget {
  Followdialog({Key? key, required this.outstandingModel}) : super(key: key);
  outstandingDBModel outstandingModel;
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
      content: viewdetails(context, theme),
    );
  }

  Container viewdetails(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      // height: Screens.bodyheight(context),

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
                    )),
                  ),
                  child: Text("View Details"))),
          SizedBox(
            height: Screens.padingHeight(context) * 0.01,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.02),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                context.watch<Outstandingcontroller>().outstandingkpi!.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        width: Screens.width(context),
                        padding: EdgeInsets.symmetric(
                            horizontal: Screens.width(context) * 0.01,
                            vertical: Screens.bodyheight(context) * 0.008),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black26)),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: Screens.width(context) * 0.45,
                              // height:Screens.padingHeight(context)*0.2 ,
                              // color: Colors.amber,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height:
                                        Screens.padingHeight(context) * 0.03,
                                    child: Text("Customer Info"),
                                  ),
                                  Divider(
                                    color: Colors.black26,
                                  ),
                                  Container(
                                    child: Text(
                                      "Name ",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${context.watch<Outstandingcontroller>().ontapKpi2[0].CustomerName}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Phone ",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${context.watch<Outstandingcontroller>().ontapKpi2[0].CustomerCode}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "City/State ",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${context.watch<Outstandingcontroller>().ontapKpi2[0].Bil_City},${context.read<Outstandingcontroller>().ontapKpi2[0].Bil_State == null || context.read<Outstandingcontroller>().ontapKpi2[0].Bil_State == "null" ? "" : context.read<Outstandingcontroller>().ontapKpi2[0].Bil_State}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            VerticalDivider(
                                width: Screens.width(context) * 0.001,
                                color: Colors.red,
                                thickness: 10.0),
                            Container(
                              width: Screens.width(context) * 0.40,
                              // height:Screens.padingHeight(context)*0.2 ,
                              // color: Colors.red,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height:
                                        Screens.padingHeight(context) * 0.03,
                                    child: Text("Outstanding"),
                                  ),
                                  Divider(
                                    color: Colors.black26,
                                  ),
                                  Container(
                                    child: Text(
                                      "TotalOutStanding",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${context
                                                          .read<
                                                              Outstandingcontroller>()
                                                          .config.slpitCurrency22(context.watch<Outstandingcontroller>().totaloutstanding.toString())}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Overdue",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${context
                                                          .read<
                                                              Outstandingcontroller>()
                                                          .config.slpitCurrency22(context.watch<Outstandingcontroller>().overdue.toString())}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Upcoming",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${context
                                                          .read<
                                                              Outstandingcontroller>()
                                                          .config.slpitCurrency22(context.watch<Outstandingcontroller>().upcoming.toString())}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                // Container(
                //   width: Screens.width(context),
                //   padding: EdgeInsets.symmetric(
                //       horizontal: Screens.width(context) * 0.03,
                //       vertical: Screens.bodyheight(context) * 0.008),
                //   decoration: BoxDecoration(
                //       color: Colors.grey[200],
                //       borderRadius: BorderRadius.circular(8),
                //       border: Border.all(color: Colors.black26)),
                //   child: Column(
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Container(
                //             child: Text(
                //               "Customer Code",
                //               style: theme.textTheme.bodyText1!
                //                   .copyWith(color: Colors.grey),
                //             ),
                //           ),
                //           Container(
                //             child: Text(
                //               "Total Outstanding",
                //               style: theme.textTheme.bodyText1!
                //                   .copyWith(color: Colors.grey),
                //             ),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Container(
                //             child: Text(
                //               "${widget.outstandingModel.customerCode}",
                //               style: theme.textTheme.bodyText1!
                //                   .copyWith(color: theme.primaryColor),
                //             ),
                //           ),
                //           Container(
                //             child: Text(
                //               "${widget.outstandingModel.balanceToPay}",
                //               style: theme.textTheme.bodyText1!
                //                   .copyWith(color: theme.primaryColor),
                //             ),
                //           ),
                //         ],
                //       ),
                //       SizedBox(
                //         height: Screens.padingHeight(context) * 0.01,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Container(
                //             child: Text(
                //               "Customer Name",
                //               style: theme.textTheme.bodyText1!
                //                   .copyWith(color: Colors.grey),
                //             ),
                //           ),
                //           Container(
                //             child: Text(
                //               "",
                //               style: theme.textTheme.bodyText1!
                //                   .copyWith(color: theme.primaryColor),
                //             ),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Container(
                //             child: Text(
                //               "${widget.outstandingModel.customerName}",
                //               style: theme.textTheme.bodyText1!
                //                   .copyWith(color: theme.primaryColor),
                //             ),
                //           ),
                //         ],
                //       ),
                //       SizedBox(
                //         height: Screens.padingHeight(context) * 0.01,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Container(
                //             child: Text(
                //               "Trans Amount",
                //               style: theme.textTheme.bodyText1!
                //                   .copyWith(color: Colors.grey),
                //             ),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Container(
                //             child: Text(
                //               "${widget.outstandingModel.transAmount}",
                //               style: theme.textTheme.bodyText1!
                //                   .copyWith(color: theme.primaryColor),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),

                SizedBox(
                  height: Screens.padingHeight(context) * 0.002,
                ),
                Divider(
                  color: Colors.black26,
                ),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.002,
                ),
                Container(
                  height: Screens.padingHeight(context) * 0.45,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: context
                          .read<Outstandingcontroller>()
                          .outstandingkpi!
                          .length,
                      itemBuilder: (BuildContext context, int i) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Screens.width(context) * 0.01,
                              vertical: Screens.padingHeight(context) * 0.002),
                          child: Container(
                            width: Screens.width(context),
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.02,
                                vertical: Screens.padingHeight(context) * 0.01),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black26)),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "Trans Number",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Date",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "${context.read<Outstandingcontroller>().outstandingkpi[i].TransNum}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${context.read<Outstandingcontroller>().config.alignDate(context.read<Outstandingcontroller>().outstandingkpi[i].TransDate.toString())}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Screens.padingHeight(context) * 0.002,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "Trans Ref Number",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Age",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "${context.read<Outstandingcontroller>().outstandingkpi[i].TransRef1}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${context.read<Outstandingcontroller>().outstandingkpi[i].age!.toInt()}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Screens.padingHeight(context) * 0.002,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "Trans Total",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Balance to Pay",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "${context
                                                          .read<
                                                              Outstandingcontroller>()
                                                          .config.slpitCurrency22(context.read<Outstandingcontroller>().outstandingkpi[i].TransAmount!.toString())}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${context
                                                          .read<
                                                              Outstandingcontroller>()
                                                          .config.slpitCurrency22(context.read<Outstandingcontroller>().outstandingkpi[i].BalanceToPay!.toString())}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          // SizedBox(
          //   height: Screens.padingHeight(context)*0.049,
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: Screens.width(context) * 0.47,
                  height: Screens.bodyheight(context) * 0.06,
                  child: ElevatedButton(
                     onPressed: () async {
                        OutStandingPdfHelper.balanceTopay = 0;
                        await context
                            .read<Outstandingcontroller>()
                            .callcustomerapi();
                        OutStandingPdfHelper.frmAddressmodeldata = context
                            .read<Outstandingcontroller>()
                            .frmAddmodeldata;
                        await context
                            .read<Outstandingcontroller>()
                            .getCustomerDet(context
                                .read<Outstandingcontroller>()
                                .ontapKpi2[0]
                                .CustomerCode
                                .toString());
                        OutStandingPdfHelper.toCustomerAddDet =
                            context.read<Outstandingcontroller>().tocustomerDet;

                        await context
                            .read<Outstandingcontroller>()
                            .getpdfviewList(context
                                .read<Outstandingcontroller>()
                                .ontapKpi2[0]
                                .CustomerCode
                                .toString());
                        OutStandingPdfHelper.data2 = context
                            .read<Outstandingcontroller>()
                            .outStndPDFDetList;
                        OutStandingPdfHelper.balanceTopay =
                            context.read<Outstandingcontroller>().totalPayAmt;
                        await context
                            .read<Outstandingcontroller>()
                            .getpdfviewList2(context
                                .read<Outstandingcontroller>()
                                .ontapKpi2[0]
                                .CustomerCode
                                .toString());

                        OutStandingPdfHelper.timeCallData = context
                            .read<Outstandingcontroller>()
                            .timePeriodDet!;
                        // OutStandingPdfHelper.outstandCustDetils = context
                        //     .read<Outstandingcontroller>()
                        //     .valueDBmodel;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OutStandingPdf()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        textStyle: TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(0),
                        )),
                      ),
                      child: Text("Share Document"))),
              Container(
                  width: Screens.width(context) * 0.47,
                  height: Screens.bodyheight(context) * 0.06,
                  child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<Outstandingcontroller>()
                            .mapvaluestocollection(context
                                .read<Outstandingcontroller>()
                                .ontapKpi2[0]
                                .CustomerCode
                                .toString());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        textStyle: TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(10),
                        )),
                      ),
                      child: Text("Proceed Collection"))),
            ],
          )
        ],
      ),
    );
  }
}
