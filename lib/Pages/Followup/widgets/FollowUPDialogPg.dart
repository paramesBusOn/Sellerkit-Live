// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../Controller/FollowupController/FollowUPController.dart';
import '../../../Models/PostQueryModel/FollowUPModel.dart/FollowUPModel.dart';
import 'CustomRadioBtnFollowup.dart';

class FollowUPDialogPG extends StatefulWidget {
  FollowUPDialogPG(
      {Key? key, required this.index, required this.followUPListData})
      : super(key: key);
  int index;
  FollowUPListData followUPListData;
  @override
  State<FollowUPDialogPG> createState() => _FollowUPDialogPGState();
}

class _FollowUPDialogPGState extends State<FollowUPDialogPG> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider<FollowupController>(
        create: (context) => FollowupController(),
        builder: (context, child) {
          return Consumer<FollowupController>(
              builder: (BuildContext context, fUPCon, Widget? child) {
            return AlertDialog(
                insetPadding: EdgeInsets.all(10),
                contentPadding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                content: (fUPCon.getisLodingDialog == true &&
                        fUPCon.getforwardSuccessMsg == '' &&
                        fUPCon.getviewDetailsClicked == false &&
                        fUPCon.getforwardDialogClicked == false &&
                        fUPCon.getupdateFrowardDialog == false)
                    ? loadingDialog(context)
                    : (fUPCon.getisLodingDialog == false &&
                            fUPCon.getforwardSuccessMsg != '' &&
                            fUPCon.getviewDetailsClicked == false &&
                            fUPCon.getforwardDialogClicked == false &&
                            fUPCon.getupdateFrowardDialog == false)
                        ? displayDialog(context, theme, fUPCon)
                        : (fUPCon.getisLodingDialog == false &&
                                fUPCon.getforwardSuccessMsg == '' &&
                                fUPCon.getviewDetailsClicked == true &&
                                fUPCon.getforwardDialogClicked == false &&
                                fUPCon.getupdateFrowardDialog == false)
                            ? detailsDialog(context, theme, fUPCon)
                            : (fUPCon.getisLodingDialog == false &&
                                    fUPCon.getforwardSuccessMsg == '' &&
                                    fUPCon.getviewDetailsClicked == false &&
                                    fUPCon.getforwardDialogClicked == true &&
                                    fUPCon.getupdateFrowardDialog == false)
                                ? forwardDialog(context, theme, fUPCon)
                                : (fUPCon.getisLodingDialog == false &&
                                        fUPCon.getforwardSuccessMsg == '' &&
                                        fUPCon.getviewDetailsClicked == false &&
                                        fUPCon.getforwardDialogClicked ==
                                            false &&
                                        fUPCon.getupdateFrowardDialog == true)
                                    ? UpdateFollowup(context, theme, fUPCon)
                                    : CallDialog(context, theme, fUPCon));
          });
        });
  }

  Container CallDialog(
      BuildContext context, ThemeData theme, FollowupController fUPCon) {
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
                onPressed: () {
                   fUPCon.makePhoneCall(widget.followUPListData.Phone!);
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
                    Container(
                      width: Screens.width(context) * 0.1,
                      height: Screens.bodyheight(context) * 0.05,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white)),
                      child: Icon(
                        Icons.call,
                        size: Screens.bodyheight(context) * 0.02,
                      ),
                    ),
                    Container(child: Text("Click to Call")),
                    Container(),
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
                  onTap: () {
                    fUPCon.changetoFolloweUp();
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "Update Followup FeedBack",
                            style: theme.textTheme.bodyText1?.copyWith(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Click Here",
                            style: theme.textTheme.bodyText2
                                ?.copyWith(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Screens.width(context) * 0.26,
                      height: Screens.bodyheight(context) * 0.06,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                          ),
                          onPressed: () {
                            fUPCon.caseStatusSelectBtn("Won","02");
                            fUPCon.changetoFolloweUp();
                          },
                          child: Text("Won")),
                    ),
                    Container(
                      width: Screens.width(context) * 0.26,
                      height: Screens.bodyheight(context) * 0.06,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                          ),
                          onPressed: () {
                            fUPCon.caseStatusSelectBtn("Lost","03");
                            fUPCon.changetoFolloweUp();
                          },
                          child: Text("Lost")),
                    ),
                    Container(
                      width: Screens.width(context) * 0.26,
                      height: Screens.bodyheight(context) * 0.06,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                          ),
                          onPressed: () {
                            fUPCon.forwardClicked();
                          },
                          child: Text("Forward")),
                    )
                  ],
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.03,
                ),
                Container(
                  //  width: Screens.width(context) * 0.4,
                  height: Screens.bodyheight(context) * 0.06,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                      ),
                      onPressed: () {
                        // Navigator.pop(context);

                        fUPCon.mapValuestoorder2(
                         widget. followUPListData
                            // widget.followUPListData.Phone,
                            // // fUPCon
                            // //     .fupODueListData[widget.index]
                            // //     .Phone!,
                            // widget.followUPListData.LeadDocEntry.toString()
                            //     fUPCon
                            // .fupODueListData[widget.index]
                            // .LeadDocEntry
                            // .toString()
                            );
                      },
                      child: Text("Convert to Order")),
                ),
              ],
            ),
          ),
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {
                  fUPCon.callGetLeadDeatilsApi(
                      widget.followUPListData.LeadDocEntry.toString());
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

  Container displayDialog(
      BuildContext context, ThemeData theme, FollowupController fUPCon) {
    return Container(
      alignment: Alignment.center,
      width: Screens.width(context),
      height: Screens.bodyheight(context) * 0.3,
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              fUPCon.getforwardSuccessMsg.toString().toLowerCase().contains("success")
                  ? "Success..!!"
                  : ' "Error..!!"',
              style: fUPCon.getforwardSuccessMsg.contains("Success")
                  ? theme.textTheme.headline6?.copyWith(color: Colors.green)
                  : theme.textTheme.headline6?.copyWith(color: Colors.red),
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.02,
            ),
            Text(
              fUPCon.getforwardSuccessMsg,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyText1,
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
                  },
                  child: Text(
                    "Ok",
                  )),
            ),
          ],
        ),
      ),
    );
  }

  //view details

  Container detailsDialog(
      BuildContext context, ThemeData theme, FollowupController fUPCon) {
    return Container(
      width: Screens.width(context),
      height: Screens.bodyheight(context),
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
                    child: Text("Lead Details",
                        style: theme.textTheme.bodyText1
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
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.87,
            padding: EdgeInsets.only(
              top: Screens.bodyheight(context) * 0.01,
              bottom: Screens.bodyheight(context) * 0.01,
              left: Screens.width(context) * 0.03,
              right: Screens.width(context) * 0.03,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    fUPCon.getleadDeatilsQTHData![0].CardName==null||
                    fUPCon.getleadDeatilsQTHData![0].CardName =="null"||
                    fUPCon.getleadDeatilsQTHData![0].CardName!.isEmpty?Container():
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${fUPCon.getleadDeatilsQTHData![0].CardName}",
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
                            "Open since " + fUPCon.config.subtractDateTime2(
                                // "2020-05-18T00:00:00"
                                "${fUPCon.getleadDeatilsQTHData![0].LeadCreatedDate}"),
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
                    fUPCon.getleadDeatilsQTHData![0].Address1==null||
                    fUPCon.getleadDeatilsQTHData![0].Address1 =="null"||
                    fUPCon.getleadDeatilsQTHData![0].Address1!.isEmpty?Container():  Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${fUPCon.getleadDeatilsQTHData![0].Address1}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.43,
                        child: Text(
                          "Worth of Rs." +
                              fUPCon.config.slpitCurrency22(
                                "${fUPCon.getleadDeatilsQTHData![0].DocTotal!.toString()}",
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
                    fUPCon.getleadDeatilsQTHData![0].Address2==null||
                    fUPCon.getleadDeatilsQTHData![0].Address2 =="null"||
                    fUPCon.getleadDeatilsQTHData![0].Address2!.isEmpty?Container():  Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${fUPCon.getleadDeatilsQTHData![0].Address2}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "# ${fUPCon.getleadDeatilsQTHData![0].LeadNum}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     fUPCon.getleadDeatilsQTHData![0].City==null||
                    fUPCon.getleadDeatilsQTHData![0].City =="null"||
                    fUPCon.getleadDeatilsQTHData![0].City!.isEmpty?Container(): Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${fUPCon.getleadDeatilsQTHData![0].City}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "Created on " +
                              fUPCon.config.alignDate3(
                                  "${fUPCon.getleadDeatilsQTHData![0].LeadCreatedDate}" //.LastFUPUpdate
                                  ),
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     fUPCon.getleadDeatilsQTHData![0].CardCode==null||
                    fUPCon.getleadDeatilsQTHData![0].CardCode =="null"||
                    fUPCon.getleadDeatilsQTHData![0].CardCode!.isEmpty?Container(): InkWell(
                       onTap: () {
                  // context.read<LeadTabController>().makePhoneCall(context
                  //     .read<LeadTabController>()
                  //     .getleadDeatilsQTHData![0].CardCode!);
                },
                      child: Container(
                          width: Screens.width(context) * 0.4,
                          child: Text(
                            "${fUPCon.getleadDeatilsQTHData![0].CardCode}",
                            style: theme.textTheme.bodyText2?.copyWith(decoration:  TextDecoration.underline,color:Colors.blue),
                          ),
                        ),
                    ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.48,
                        child: Text(
                          "Last Update on " +
                              fUPCon.config.alignDate3(
                                  "${fUPCon.getleadDeatilsQTHData![0].LastFUPUpdate}" //.
                                  ),
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                    ],
                  ),

                  // createTable(theme),

                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Container(
                      width: Screens.width(context),
                      padding: EdgeInsets.symmetric(
                          // horizontal: Screens.width(context) * 0.03,
                          vertical: Screens.bodyheight(context) * 0.02),
                      decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black26)),
                      child: Column(
                        children: [
                          Center(
                            child:fUPCon.getleadDeatilsQTHData[0].nextFollowupDate!.isNotEmpty||fUPCon.getleadDeatilsQTHData[0].nextFollowupDate !=null||fUPCon.getleadDeatilsQTHData[0].nextFollowupDate !="null"? Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Next Follow up # ' +
                                    fUPCon.config.alignDate(
                                        '${fUPCon.getleadDeatilsQTHData[0].nextFollowupDate}'),
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyText2?.copyWith(
                                  color: theme.primaryColor,
                                ),
                              ),
                            ):Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Next Follow up # ' ,
                                    // fUPCon.config.alignDate(
                                    //     '${fUPCon.getleadDeatilsQTHData[0].nextFollowupDate}'),
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyText2?.copyWith(
                                  color: theme.primaryColor,
                                ),
                              ),
                            )
                          ),
                          Container(
                              width: Screens.width(context),
                              margin: EdgeInsets.only(
                                // left: Screens.width(context) * 0.03,
                                top: Screens.bodyheight(context) * 0.01,
                                bottom: Screens.bodyheight(context) * 0.01,
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.black26)))),
                          Center(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Last status # ${fUPCon.getleadDeatilsLeadData[fUPCon.getleadDeatilsLeadData.length - 1].Status}',
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyText2?.copyWith(
                                  color: theme.primaryColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.015,
                  ),
                  createTable(theme, fUPCon),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  //
                  Wrap(
                      spacing: 0.0, // width
                      runSpacing: 0.0, // height
                      children: listTimeLine(theme, fUPCon)),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
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
                  fUPCon.followUPClicked();
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
                child: Text("Followup")),
          ),
        ],
      ),
    );
  }

  Widget createTable(ThemeData theme, FollowupController fUPCon) {
    List<TableRow> rows = [];
    rows.add(TableRow(children: [
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Product",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Price",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        color: theme.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          "Qty",
          style: theme.textTheme.bodyText1
              ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          textAlign: TextAlign.left,
        ),
      ),
    ]));
    for (int i = 0; i < fUPCon.getleadDeatilsQTLData.length; ++i) {
      rows.add(TableRow(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${fUPCon.getleadDeatilsQTLData[i].ItemName!}',
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            fUPCon.config.slpitCurrency(
                fUPCon.getleadDeatilsQTLData[i].Price!.toStringAsFixed(0)),
            // '${fUPCon.getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${fUPCon.getleadDeatilsQTLData[i].Quantity!.toStringAsFixed(0)}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
      ]));
    }
    return Table(columnWidths: {
      0: FlexColumnWidth(4),
      1: FlexColumnWidth(2.2),
      2: FlexColumnWidth(0.8),
    }, children: rows);
  }

  List<Widget> listTimeLine(ThemeData theme, FollowupController fUPCon) {
    return List.generate(fUPCon.getleadDeatilsLeadData.length, (index) {
      if (index == 0) {
        //  log("1");
        return Column(
          children: [
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.2,
              isFirst: true,
              indicatorStyle: IndicatorStyle(
                width: 30,
                color: theme.primaryColor,
                indicatorXY: 0.2,
                padding: EdgeInsets.only(
                  top: 4,
                  left: 4,
                  right: 4,
                ),
                iconStyle: IconStyle(
                  color: Colors.white,
                  iconData: fUPCon.getleadDeatilsLeadData[index].FollowMode ==
                          'Phone Call'
                      ? Icons.call
                      : fUPCon.getleadDeatilsLeadData[index].FollowMode ==
                              'Sms/WhatsApp'
                          ? Icons.message
                          : fUPCon.getleadDeatilsLeadData[index].FollowMode ==
                                  'Store Visit'
                              ? Icons.store
                              : Icons.chat,
                ),
              ),
              beforeLineStyle: const LineStyle(
                color: Colors.grey,
                thickness: 3,
              ),
              afterLineStyle: const LineStyle(
                color: Colors.grey,
                thickness: 3,
              ),
              endChild: Container(
                alignment: Alignment.centerLeft,
                width: Screens.width(context) * 0.6,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${fUPCon.getleadDeatilsLeadData[index].Status} ",
                        style: theme.textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        // fUPCon.config.alignDate(
                        "By ${fUPCon.getleadDeatilsLeadData[index].UpdatedBy} through ${fUPCon.getleadDeatilsLeadData[index].FollowMode ==null||fUPCon.getleadDeatilsLeadData[index].FollowMode =="null"||fUPCon.getleadDeatilsLeadData[index].FollowMode!.isEmpty?"": fUPCon.getleadDeatilsLeadData[index].FollowMode}", //),
                        style: theme.textTheme.bodyText2?.copyWith(
                            // color: theme.primaryColor,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.02,
                    ),
                    fUPCon.getleadDeatilsLeadData[index].Feedback!.isEmpty
                        ? SizedBox()
                        : Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              // fUPCon.config.alignDate(
                              "# ${fUPCon.getleadDeatilsLeadData[index].Feedback}",
                              style: theme.textTheme.bodyText2?.copyWith(
                                  // color: theme.primaryColor,
                                  ),
                            ),
                          ),
                    Divider(
                      thickness: 1,
                    ),
                    //       SizedBox(
                    //   height: Screens.bodyheight(context) * 0.01,
                    // ),
                  ],
                ),
              ),
              startChild: Container(
                  padding: EdgeInsets.only(
                      left: Screens.width(context) * 0.02,
                      right: Screens.width(context) * 0.02),
                  // alignment:Alignment.centerRight,
                  // color: Colors.blue,
                  width: Screens.width(context) * 0.25,
                  child: Column(
                    children: [
                      Text(
                        fUPCon.config.alignDate2(
                          "${fUPCon.getleadDeatilsLeadData[index].Followup_Date_Time}",
                        ),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText2,
                      ),
                    ],
                  )),
            ),
          ],
        );
      } else if (index == fUPCon.getleadDeatilsLeadData.length - 1) {
        //log("2");
        return Column(
          children: [
            TimelineTile(
              isLast: true,
              lineXY: 0.2,
              alignment: TimelineAlign.manual,
              indicatorStyle: IndicatorStyle(
                width: 30,
                color: theme.primaryColor,
                // indicatorXY: 0.7,
                padding: EdgeInsets.all(4),
                iconStyle: IconStyle(
                  color: Colors.white,
                  iconData: fUPCon.getleadDeatilsLeadData[index].FollowMode ==
                          'Phone Call'
                      ? Icons.call
                      : fUPCon.getleadDeatilsLeadData[index].FollowMode ==
                              'Sms/WhatsApp'
                          ? Icons.message
                          : fUPCon.getleadDeatilsLeadData[index].FollowMode ==
                                  'Store Visit'
                              ? Icons.store
                              : Icons.chat,
                ),
              ),
              beforeLineStyle: const LineStyle(
                color: Colors.grey,
                thickness: 3,
              ),
              afterLineStyle: const LineStyle(
                color: Colors.grey,
                thickness: 3,
              ),
              endChild: Container(
                alignment: Alignment.centerLeft,
                width: Screens.width(context) * 0.6,
                padding: EdgeInsets.only(
                    left: Screens.width(context) * 0.02,
                    right: Screens.width(context) * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${fUPCon.getleadDeatilsLeadData[index].Status} ",
                        style: theme.textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        // fUPCon.config.alignDate(
                        "By ${fUPCon.getleadDeatilsLeadData[index].UpdatedBy} through ${fUPCon.getleadDeatilsLeadData[index].FollowMode}", //),
                        style: theme.textTheme.bodyText2?.copyWith(
                            // color: theme.primaryColor,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    fUPCon.getleadDeatilsLeadData[index].Feedback!.isEmpty
                        ? SizedBox()
                        : Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              // fUPCon.config.alignDate(
                              "# ${fUPCon.getleadDeatilsLeadData[index].Feedback}",
                              style: theme.textTheme.bodyText2?.copyWith(
                                  // color: theme.primaryColor,
                                  ),
                            ),
                          ),
                  ],
                ),
              ),
              startChild: Container(
                  padding: EdgeInsets.only(
                      left: Screens.width(context) * 0.02,
                      right: Screens.width(context) * 0.02),
                  width: Screens.width(context) * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      Text(
                        fUPCon.config.alignDate2(
                          "${fUPCon.getleadDeatilsLeadData[index].Followup_Date_Time}",
                        ),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText2,
                      ),
                    ],
                  )),
            ),
          ],
        );
      } else {
        // log("3");
        return Column(
          children: [
            TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.2,
              indicatorStyle: IndicatorStyle(
                width: 30,
                color: theme.primaryColor,
                //   indicatorXY:  0.7,
                padding: EdgeInsets.all(4),
                iconStyle: IconStyle(
                  color: Colors.white,
                  iconData: fUPCon.getleadDeatilsLeadData[index].FollowMode ==
                          'Phone Call'
                      ? Icons.call
                      : fUPCon.getleadDeatilsLeadData[index].FollowMode ==
                              'Sms/WhatsApp'
                          ? Icons.message
                          : fUPCon.getleadDeatilsLeadData[index].FollowMode ==
                                  'Store Visit'
                              ? Icons.store
                              : Icons.chat,
                ),
              ),
              beforeLineStyle: const LineStyle(
                color: Colors.grey,
                thickness: 3,
              ),
              afterLineStyle: const LineStyle(
                color: Colors.grey,
                thickness: 3,
              ),
              endChild: Container(
                // color: Colors.red,
                width: Screens.width(context) * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${fUPCon.getleadDeatilsLeadData[index].Status} ",
                        style: theme.textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        // fUPCon.config.alignDate(
                        "By ${fUPCon.getleadDeatilsLeadData[index].UpdatedBy} through ${fUPCon.getleadDeatilsLeadData[index].FollowMode}", //),
                        style: theme.textTheme.bodyText2?.copyWith(
                            // color: theme.primaryColor,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    fUPCon.getleadDeatilsLeadData[index].Feedback!.isEmpty
                        ? SizedBox()
                        : Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              // fUPCon.config.alignDate(
                              "# ${fUPCon.getleadDeatilsLeadData[index].Feedback}",
                              style: theme.textTheme.bodyText2?.copyWith(
                                  // color: theme.primaryColor,
                                  ),
                            ),
                          ),
                    Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
              startChild: Container(
                  //  color: Colors.red,
                  padding: EdgeInsets.only(
                      left: Screens.width(context) * 0.02,
                      right: Screens.width(context) * 0.02),
                  width: Screens.width(context) * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        fUPCon.config.alignDate2(
                          "${fUPCon.getleadDeatilsLeadData[index].Followup_Date_Time}",
                        ),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText2,
                      ),
                    ],
                  )),
            ),
          ],
        );
      }
    });
  }

//forwad dialog
  Container forwardDialog(
      BuildContext context, ThemeData theme, FollowupController fUPCon) {
    return Container(
      width: Screens.width(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.only(
        left: Screens.width(context) * 0.05,
        right: Screens.width(context) * 0.05,
        top: Screens.bodyheight(context) * 0.03,
        bottom: Screens.bodyheight(context) * 0.03,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                                height: Screens.bodyheight(context) * 0.05,
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(
                                        Screens.width(context) * 0.01),
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
                                      fUPCon.filterListAssignData(v);
                                     fUPCon.setForwardDataList();
        
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
                              SizedBox(height: Screens.bodyheight(context)*0.01,),
      
            Container(
                height: Screens.bodyheight(context)*0.5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Wrap(
                        spacing: 5.0, // gap between adjacent chips
                        runSpacing: 5.0, // gap between lines
                        children: listContainersProduct(theme, fUPCon)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text(
                  fUPCon.getforwardNextFollowDate!, // "Next Follow up",
                  style: theme.textTheme.bodyText2?.copyWith(
                    color: fUPCon.getforwardNextFollowDate!.contains(" *")
                        ? Colors.red
                        : Colors.grey,
                  ), // fontSize: 12
                )),
                InkWell(
                  onTap: () {
                    fUPCon.showForwardNextDate(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Screens.width(context) * 0.015),
                    width: Screens.width(context) * 0.5,
                    height: Screens.bodyheight(context) * 0.05,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Screens.width(context) * 0.3,
                          // color: Colors.red,
                          child: Text(
                            fUPCon.getforwardnextWonFD,
                            // fUPCon.getnextFD,
                            style: theme.textTheme.bodyText2
                                ?.copyWith(), //fontSize: 12
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          width: Screens.width(context) * 0.15,
                          // color: Colors.red,
                          child: Icon(
                            Icons.calendar_month,
                            // size: Screens.,
                            color: theme.primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
      
             Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: Text(
                                     fUPCon
                                            .assignVisitTime!, // "Next Follow up",
                                    style: theme.textTheme.bodyText2?.copyWith(
                                      color:  fUPCon
                                            .assignVisitTime!.contains(" *")
                                          ? Colors.red
                                          : Colors.grey,
                                    ), // fontSize: 12
                                  )),
                                  InkWell(
                                    onTap:   () {
                                            setState(() {
                                               fUPCon
                                            .forwardVisitTime(context);
                                            });
                                          }
                                        ,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              Screens.width(context) * 0.015),
                                      width: Screens.width(context) * 0.5,
                                      height: Screens.bodyheight(context) * 0.05,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(4)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: Screens.width(context) * 0.3,
                                            // color: Colors.red,
                                            child: Text(
                                               fUPCon
                                            .forwaVisitTime,
                                              //fUPCon.getnextFD,
                                              style: theme.textTheme.bodyText2
                                                  ?.copyWith(), //fontSize: 12
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerRight,
                                            width: Screens.width(context) * 0.15,
                                            // color: Colors.red,
                                            child: Icon(
                                              Icons.timer,
                                              // size: Screens.,
                                              color: theme.primaryColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              fUPCon.iscorectime2==false && fUPCon.forwarderrorVisitTime ==''?Container(): Container(
                              alignment: Alignment.centerRight,
                              child: Text("${fUPCon.forwarderrorVisitTime}",style: theme.textTheme.bodyText1!.copyWith(
                                color: Colors.red,
                                fontSize: 13
                              ),),
                            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Screens.width(context) * 0.26,
                  height: Screens.bodyheight(context) * 0.06,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                      ),
                      onPressed: () {
                        fUPCon.forwardClicked();
                      },
                      child: Text("Back")),
                ),
                Container(
                  width: Screens.width(context) * 0.26,
                  height: Screens.bodyheight(context) * 0.06,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                      ),
                      onPressed: () {
      
                         if (fUPCon
                            .selectedUserList
                            .isNotEmpty &&fUPCon
                            . forwaVisitTime.isNotEmpty &&fUPCon
                            .forwardNextFollowDate!.isNotEmpty) {
                          fUPCon.Allfollowupupdate(
                             "", widget.followUPListData
                                  .LeadDocEntry
                                  .toString(),"","","","",
                              fUPCon
                                  .selectedUserList,widget.followUPListData
                                  .LastFollowupStatus
                                  .toString());
                        }else{
                          setState(() {

                            if(fUPCon
                            .selectedUserList
                            .isEmpty){
                           fUPCon.showtoastforall();   
                            }
                            if(fUPCon
                            . forwaVisitTime.isEmpty ){
   fUPCon
                                  . assignVisitTime="Followup Time: *";
                                   
                                 
                            }
                            if(fUPCon
                            .getforwardnextWonFD!.isEmpty){
 fUPCon.forwardNextFollowDate="Next Followup: *"; 
                            }
                         
                          });
                        
                        }
                        // if (fUPCon.selectedUserList.isNotEmpty) {
                        //   fUPCon.forwardApi(
                        //       widget.followUPListData.FollowupEntry.toString(),
                        //       int.parse(fUPCon.selectedUserList));
                        // }
                      },
                      child: Text("Forward")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  List<Widget> listContainersProduct(
      ThemeData theme, FollowupController fUPCon) {
    return List.generate(
      fUPCon.filteruserLtData.length,
      (ind) => GestureDetector(
        onTap: () {
          fUPCon.getSelectedUserSalesEmpId(ind);
        },
        child: Container(
          width: Screens.width(context) * 0.4,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: fUPCon.filteruserLtData[ind].color == 1
                  ? theme.primaryColor
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: Text(fUPCon.filteruserLtData[ind].UserName!,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: fUPCon.filteruserLtData[ind].color == 1
                    ? Colors.white
                    : theme.primaryColor,
              )),
        ),
      ),
    );
  }

//open close won update dialog

  Container UpdateFollowup(
      BuildContext context, ThemeData theme, FollowupController fUPCon) {
    return Container(
      width: Screens.width(context),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: Screens.width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.only(
                  left: Screens.width(context) * 0.05,
                  right: Screens.width(context) * 0.05,
                  top: Screens.bodyheight(context) * 0.03,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          fUPCon.followup!,
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: fUPCon.getfollowup!.contains(" *")
                                ? Colors.red
                                : theme.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),

                        Center(
                            child: Wrap(
                                spacing: 5.0, // width
                                runSpacing: 10.0, // height
                                children: listContainersCustomerTag(
                                  theme,fUPCon
                                )),
                          ),
                      // CustomRadioBtnFUP(
                      //   theme: theme,
                      //   onPressed1: () {
                      //     //  setState(() {
                      //     fUPCon.selectFollowUp("Phone Call");
                      //     //});
                      //   },
                      //   onPressed2: () {
                      //     //   setState(() {
                      //     fUPCon.selectFollowUp("Sms/WhatsApp");
                      //     //   });
                      //   },
                      //   text1: 'Phone Call',
                      //   text2: 'Sms/WhatsApp',
                      //   fUPCon: fUPCon,
                      // ),
                      // SizedBox(height: Screens.bodyheight(context) * 0.01),
                      // CustomRadioBtnFUP(
                      //   theme: theme,
                      //   onPressed1: () {
                      //     //  setState(() {
                      //     fUPCon.selectFollowUp("Store Visit");
                      //     //  });
                      //   },
                      //   onPressed2: () {
                      //     //  setState(() {
                      //     fUPCon.selectFollowUp("Other");
                      //     //  });
                      //   },
                      //   text1: 'Store Visit',
                      //   text2: 'Other',
                      //   fUPCon: fUPCon,
                      // ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      Container(
                        child: Text(
                          "What is the case status now?",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: theme.primaryColor),
                        ),
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Center(
                            child: Wrap(
                                spacing: 7.0, // width
                                runSpacing: 10.0, // height
                                children: listContainersOpenTag(
                                  theme,fUPCon
                                )),
                          ),
                          // Container(
                          //   width: Screens.width(context) * 0.26,
                          //   height: Screens.bodyheight(context) * 0.06,
                          //   child: ElevatedButton(
                          //       style: ElevatedButton.styleFrom(
                          //         primary:
                          //             fUPCon.getcaseStatusSelected == 'Open'
                          //                 ? Color(0xffFCF752)
                          //                 : theme.primaryColor,
                          //         textStyle: TextStyle(
                          //             color:
                          //                 fUPCon.getcaseStatusSelected == 'Open'
                          //                     ? Colors.black
                          //                     : Colors.white),
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(6))),
                          //       ),
                          //       onPressed: () {
                          //         // setState(() {
                          //         fUPCon.caseStatusSelectBtn("Open");
                          //         fUPCon.validatebtnChanged();
                          //         //   });
                          //       },
                          //       child: Text(
                          //         "Open",
                          //         style: TextStyle(
                          //             color:
                          //                 fUPCon.getcaseStatusSelected == 'Open'
                          //                     ? Colors.black
                          //                     : Colors.white),
                          //       )),
                          // ),
                          // Container(
                          //   width: Screens.width(context) * 0.26,
                          //   height: Screens.bodyheight(context) * 0.06,
                          //   child: ElevatedButton(
                          //       style: ElevatedButton.styleFrom(
                          //         primary: fUPCon.getcaseStatusSelected == 'Won'
                          //             ? Color(0xffFCF752)
                          //             : theme.primaryColor,
                          //         textStyle: TextStyle(
                          //             color:
                          //                 fUPCon.getcaseStatusSelected == 'Won'
                          //                     ? Colors.black
                          //                     : Colors.white),
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(6))),
                          //       ),
                          //       onPressed: () {
                          //         fUPCon.caseStatusSelectBtn("Won");
                          //         fUPCon.validatebtnChanged();
                          //       },
                          //       child: Text(
                          //         "Won",
                          //         style: TextStyle(
                          //             color:
                          //                 fUPCon.getcaseStatusSelected == 'Won'
                          //                     ? Colors.black
                          //                     : Colors.white),
                          //       )),
                          // ),
                          // Container(
                          //   width: Screens.width(context) * 0.26,
                          //   height: Screens.bodyheight(context) * 0.06,
                          //   child: ElevatedButton(
                          //       style: ElevatedButton.styleFrom(
                          //         primary:
                          //             fUPCon.getcaseStatusSelected == 'Lost'
                          //                 ? Color(0xffFCF752)
                          //                 : theme.primaryColor,
                          //         textStyle: TextStyle(
                          //             color:
                          //                 fUPCon.getcaseStatusSelected == 'Lost'
                          //                     ? Colors.black
                          //                     : Colors.white),
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(6))),
                          //       ),
                          //       onPressed: () {
                          //         fUPCon.caseStatusSelectBtn("Lost");
                          //         fUPCon.validatebtnChanged();
                          //       },
                          //       child: Text(
                          //         "Lost",
                          //         style: TextStyle(
                          //             color:
                          //                 fUPCon.getcaseStatusSelected == 'Lost'
                          //                     ? Colors.black
                          //                     : Colors.white),
                          //       )),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      Visibility(
                        visible: fUPCon.getcaseStatusSelected == 'Open'
                            ? true
                            : false,
                        child: Column(
                          children: [
                            Container(
                              width: Screens.width(context),
                              // height: Screens.,
                              padding:
                                  EdgeInsets.only(top: 1, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8)),
                              child: DropdownButton(
                                hint: Text(
                                  fUPCon.gethinttextforOpenLead!,
                                  style: theme.textTheme.bodyText2?.copyWith(
                                      color: fUPCon.gethinttextforOpenLead!
                                              .contains(" *")
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                value: fUPCon.valueChosedStatus,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                  fUPCon.choosedStatus(val.toString());
                                },
                                items: fUPCon.leadStatusOpen.map((e) {
                                  return DropdownMenuItem(
                                      // ignore: unnecessary_brace_in_string_interps
                                      value: "${e.code}",
                                      child: Container(
                                          // height: Screens.bodyheight(context)*0.1,
                                          child: Text(e.name.toString())));
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.01,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: fUPCon.getcaseStatusSelected == 'Won'
                            ? true
                            : false,
                        child: Column(
                          children: [
                            Container(
                              width: Screens.width(context),
                              padding:
                                  EdgeInsets.only(top: 1, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8)),
                              child: DropdownButton(
                                hint: Text(
                                  fUPCon.gethinttextforWonLead!,
                                  style: theme.textTheme.bodyText2?.copyWith(
                                      color: fUPCon.gethinttextforWonLead!
                                              .contains(" *")
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                value: fUPCon.valueChosedStatusWon,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                  fUPCon.choosedStatusWon(val.toString());
                                },
                                items: fUPCon.leadStatusWon.map((e) {
                                  return DropdownMenuItem(
                                      // ignore: unnecessary_brace_in_string_interps
                                      value: "${e.code}",
                                      child: Text(e.name.toString()));
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.01,
                            ),
                            TextFormField(
                              controller: fUPCon.mycontroller[0],
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[400]!),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[400]!, width: 2.0),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  hintText: fUPCon.getorderBillRefer!,
                                  hintStyle:
                                      theme.textTheme.bodyText2?.copyWith(
                                    color:
                                        fUPCon.getorderBillRefer!.contains(" *")
                                            ? Colors.red
                                            : Colors.black,
                                    // fontSize: 14
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10)),
                            ),
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    child: Text(
                                  fUPCon.getorderBillDate!, // "Next Follow up",
                                  style: theme.textTheme.bodyText2?.copyWith(
                                    color:
                                        fUPCon.getorderBillDate!.contains(" *")
                                            ? Colors.red
                                            : Colors.grey,
                                  ), // fontSize: 12
                                )),
                                InkWell(
                                  onTap: fUPCon.getcaseStatusSelected == 'Won'
                                      ? () {
                                          fUPCon.showFollowupWonDate(context);
                                        }
                                      : null,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.015),
                                    width: Screens.width(context) * 0.5,
                                    height: Screens.bodyheight(context) * 0.05,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: Screens.width(context) * 0.3,
                                          // color: Colors.red,
                                          child: Text(
                                            fUPCon.getnextWonFD,
                                            //fUPCon.getnextFD,
                                            style: theme.textTheme.bodyText2
                                                ?.copyWith(), //fontSize: 12
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: Screens.width(context) * 0.15,
                                          // color: Colors.red,
                                          child: Icon(
                                            Icons.calendar_month,
                                            // size: Screens.,
                                            color: theme.primaryColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.01,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: fUPCon.getcaseStatusSelected == 'Lost'
                            ? true
                            : false,
                        child: Column(
                          children: [
                            Container(
                              width: Screens.width(context),
                              padding:
                                  EdgeInsets.only(top: 1, left: 10, right: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8)),
                              child: DropdownButton(
                                hint: Text(
                                  fUPCon.gethinttextforLostLead!,
                                  style: theme.textTheme.bodyText2?.copyWith(
                                      color: fUPCon.gethinttextforLostLead!
                                              .contains(" *")
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                value: fUPCon.valueChosedReason,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                  setState(() {
                                    fUPCon.choosedReason(val.toString());
                                  });
                                },
                                items: fUPCon.leadStatusLost.map((e) {
                                  return DropdownMenuItem(
                                      // ignore: unnecessary_brace_in_string_interps
                                      value: "${e.code}",
                                      child: Text(e.name.toString()));
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.01,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Text(
                          fUPCon.getfeedbackLead!, // "Feedback",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: fUPCon.getfeedbackLead!.contains(" *")
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      TextFormField(
                        controller: fUPCon.mycontroller[1],
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]!),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey[400]!, width: 2.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      fUPCon.getcaseStatusSelected != 'Open'
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    child: Text(
                                  fUPCon
                                      .getnextFollowupDate!, // "Next Follow up",
                                  style: theme.textTheme.bodyText2?.copyWith(
                                    color: fUPCon.getnextFollowupDate!
                                            .contains(" *")
                                        ? Colors.red
                                        : Colors.grey,
                                  ), // fontSize: 12
                                )),
                                InkWell(
                                  onTap: fUPCon.getcaseStatusSelected == 'Open'
                                      ? () {
                                          fUPCon.showFollowupDate(context);
                                        }
                                      : null,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.015),
                                    width: Screens.width(context) * 0.5,
                                    height: Screens.bodyheight(context) * 0.05,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: Screens.width(context) * 0.3,
                                          // color: Colors.red,
                                          child: Text(
                                            fUPCon.getnextFD,
                                            //fUPCon.getnextFD,
                                            style: theme.textTheme.bodyText2
                                                ?.copyWith(), //fontSize: 12
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: Screens.width(context) * 0.15,
                                          // color: Colors.red,
                                          child: Icon(
                                            Icons.calendar_month,
                                            // size: Screens.,
                                            color: theme.primaryColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),

                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      fUPCon.getcaseStatusSelected != 'Open'
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    child: Text(
                                  fUPCon
                                      .getnextFollowupTime!, // "Next Follow up",
                                  style: theme.textTheme.bodyText2?.copyWith(
                                    color: fUPCon.getnextFollowupTime!
                                            .contains(" *")
                                        ? Colors.red
                                        : Colors.grey,
                                  ), // fontSize: 12
                                )),
                                InkWell(
                                  onTap: fUPCon.getcaseStatusSelected == 'Open'
                                      ? () {
                                          setState(() {
                                            fUPCon.selectTime(context);
                                          });
                                        }
                                      : null,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.015),
                                    width: Screens.width(context) * 0.5,
                                    height: Screens.bodyheight(context) * 0.05,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: Screens.width(context) * 0.3,
                                          // color: Colors.red,
                                          child: Text(
                                            fUPCon.getnextFDTime,
                                            //fUPCon.getnextFD,
                                            style: theme.textTheme.bodyText2
                                                ?.copyWith(), //fontSize: 12
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: Screens.width(context) * 0.15,
                                          // color: Colors.red,
                                          child: Icon(
                                            Icons.timer,
                                            // size: Screens.,
                                            color: theme.primaryColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                             fUPCon.getcaseStatusSelected != 'Open'
                          ? Container()
                          :fUPCon.errorTime.isEmpty?Container():  Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("${fUPCon.errorTime}",style: theme.textTheme.bodyText2!.copyWith(
                                color: Colors.red
                              ) ,),
                            ],
                          ),
                      // SizedBox(
                      //   height: Screens.bodyheight(context) * 0.02,
                      // ),
                      fUPCon.getcaseStatusSelected != 'Open'
                          ? Container()
                          : Container(
                              // width: Screens.width(context),
                              // alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Required Site Visit',
                                 style:  theme.textTheme.bodyText2?.copyWith(
                                    color:  Colors.grey,
                                  ), // fontSize: 12
                                ),
                                  Checkbox(
                                      value: fUPCon.getsitevisitreq,
                                      onChanged: ((value) {
                                        fUPCon.checksitevisit(value!);
                                      })),
                                ],
                              ),
                            ),
                            
                      // SizedBox(
                      //   height: Screens.bodyheight(context) * 0.01,
                      // ),
                      fUPCon.getsitevisitreq==false?Container():
                      fUPCon.getcaseStatusSelected != 'Open'
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    child: Text(
                                  fUPCon.getnextVisitDate!, // "Next Follow up",
                                  style: theme.textTheme.bodyText2?.copyWith(
                                    color:
                                        fUPCon.getnextVisitDate!.contains(" *")
                                            ? Colors.red
                                            : Colors.grey,
                                  ), // fontSize: 12
                                )),
                                InkWell(
                                  onTap: fUPCon.getcaseStatusSelected == 'Open'
                                      ? () {
                                          fUPCon.showVisitDate(context);
                                        }
                                      : null,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.015),
                                    width: Screens.width(context) * 0.5,
                                    height: Screens.bodyheight(context) * 0.05,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: Screens.width(context) * 0.3,
                                          // color: Colors.red,
                                          child: Text(
                                            fUPCon.visitDt,
                                            //fUPCon.getnextFD,
                                            style: theme.textTheme.bodyText2
                                                ?.copyWith(), //fontSize: 12
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: Screens.width(context) * 0.15,
                                          // color: Colors.red,
                                          child: Icon(
                                            Icons.calendar_month,
                                            // size: Screens.,
                                            color: theme.primaryColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),

                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                     fUPCon.getsitevisitreq==false?Container(): fUPCon.getcaseStatusSelected != 'Open'
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    child: Text(
                                  fUPCon.nextVisitTime!, // "Next Follow up",
                                  style: theme.textTheme.bodyText2?.copyWith(
                                    color: fUPCon.nextVisitTime!.contains(" *")
                                        ? Colors.red
                                        : Colors.grey,
                                  ), // fontSize: 12
                                )),
                                InkWell(
                                  onTap: fUPCon.getcaseStatusSelected == 'Open'
                                      ? () {
                                          setState(() {
                                            fUPCon.selectVisitTime(context);
                                          });
                                        }
                                      : null,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.015),
                                    width: Screens.width(context) * 0.5,
                                    height: Screens.bodyheight(context) * 0.05,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: Screens.width(context) * 0.3,
                                          // color: Colors.red,
                                          child: Text(
                                            fUPCon.VisitTime,
                                            //fUPCon.getnextFD,
                                            style: theme.textTheme.bodyText2
                                                ?.copyWith(), //fontSize: 12
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: Screens.width(context) * 0.15,
                                          // color: Colors.red,
                                          child: Icon(
                                            Icons.timer,
                                            // size: Screens.,
                                            color: theme.primaryColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //
                            fUPCon.getsitevisitreq==false?Container():  
                            fUPCon.getcaseStatusSelected != 'Open'
                          ? Container()
                          :fUPCon.errorVisitTime.isEmpty?Text(''):  Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("${fUPCon.errorVisitTime}",style: theme.textTheme.bodyText2!.copyWith(
                                color: Colors.red
                              ) ,),
                            ],
                          ),
                          //
                    fUPCon.getsitevisitreq==false?Container():  fUPCon.getcaseStatusSelected != 'Open'
                          ? Container()
                          : SizedBox(
                              height: Screens.bodyheight(context) * 0.01,
                            ),
                      // Row(
                      //   children: [
                      //     Checkbox(
                      //       value:context.watch<FollowupController>().getrequireVisitBool!,
                      //     onChanged:(value) {

                      //     }),
                      //   ],
                      // )
                    ],
                  ),
                )),
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                  onPressed: () {
                    fUPCon.clickLeadSaveBtn(
                        widget.followUPListData.FollowupEntry.toString(),
                        widget.followUPListData.LeadDocEntry.toString());
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
                  child: Text("Save")),
            ),
          ],
        ),
      ),
    );
  }
  List<Widget> listContainersCustomerTag(
    ThemeData theme,FollowupController fUPCon
  ) {
    return List.generate(
      fUPCon.getleadphonedata.length,
      (index) => InkWell(
        onTap: () {
          // context.read<LeadNewController>(). isSelectedenquirytype = context.read<LeadNewController>()
          // .getenqReffList[index].Name.toString();
          fUPCon.selectFollowUp(fUPCon.getleadphonedata[index]
              .name
              .toString(),fUPCon
              .getleadphonedata[index]
              .code
              .toString());
          // log(context.read<LeadNewController>().getisSelectedCsTag.toString());
          // log(context
          //     .read<LeadNewController>()
          //     .getCusTagList[index]
          //     .Name
          //     .toString());
        },
        child: Container(
          width: Screens.width(context) * 0.4,
          height: Screens.bodyheight(context) * 0.05,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: fUPCon.isSelectedFollowUpcode ==
                     fUPCon
                          .getleadphonedata[index]
                          .code
                          .toString()
                  ? theme.primaryColor //theme.primaryColor.withOpacity(0.5)
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(4)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  fUPCon
                      .getleadphonedata[index]
                      .name
                      .toString(),
                  maxLines: 8,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 13,
                    color:
                       fUPCon.isSelectedFollowUpcode ==
                               fUPCon
                                    .getleadphonedata[index]
                                    .code
                                    .toString()
                            ? Colors.white //,Colors.white
                            : theme.primaryColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
  List<Widget> listContainersOpenTag(
    ThemeData theme,FollowupController fUPCon
  ) {
    return List.generate(
      fUPCon.getleadopendata.length,
      (index) => InkWell(
        onTap: () {
          // context.read<LeadNewController>(). isSelectedenquirytype = context.read<LeadNewController>()
          // .getenqReffList[index].Name.toString();


           fUPCon
                                      .caseStatusSelectBtn( fUPCon
                          .getleadopendata[index]
                          .name
                          .toString(), fUPCon
                          .getleadopendata[index]
                          .code
                          .toString());
                                  fUPCon
                                      .validatebtnChanged();
        
        },
        child: Container(
         width: Screens.width(context) * 0.26,
                            height: Screens.bodyheight(context) * 0.06,
           padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: fUPCon.getcaseStatusSelected ==
                     fUPCon
                          .getleadopendata[index]
                          .name
                          .toString()
                  ?Color(0xffFCF752)//theme.primaryColor.withOpacity(0.5)
                  : theme.primaryColor,
              border: Border.all(color: theme.primaryColor, ),
              borderRadius: BorderRadius.circular(4)),
          child: Text(
              fUPCon
                  .getleadopendata[index]
                  .name
                  .toString(),
              maxLines: 8,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 13,
                color:
                    fUPCon.getcaseStatusSelected ==
                            fUPCon
                                .getleadopendata[index]
                                .name
                                .toString()
                        ? Colors.black //,Colors.white
                        : Colors.white,
              )),
          
          
        ),
      ),
    );
  }
}
