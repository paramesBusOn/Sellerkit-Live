// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/GetAllLeadModel.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../../Controller/OpenLeadController/OpenLeadController.dart';
import '../../../Models/OpenLeadModel.dart/OpenLeadModel.dart';
import 'CustomRBOPFP.dart';

class OpenLeadFDP extends StatefulWidget {
   OpenLeadFDP({Key? key,required this.index, required this.followUPListData}) :super(key: key) ;
  int index;
  GetAllLeadData followUPListData;
  @override
  State<OpenLeadFDP> createState() => _OpenLeadFDPState();
}

class _OpenLeadFDPState extends State<OpenLeadFDP> {
  @override
  Widget build(BuildContext context) {
   final theme = Theme.of(context);
    // return 
    // ChangeNotifierProvider<OpenLeadController>(
    //         create: (context) => OpenLeadController(),
    //         builder: (context, child) {
    //           return Consumer<OpenLeadController>(
    //               builder: (BuildContext context, fUPCon, Widget? child) {
            return AlertDialog(
              insetPadding: EdgeInsets.all(10),
              contentPadding: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              content:
              (context.watch<OpenLeadController>().getisLodingDialog == true &&
              context.watch<OpenLeadController>().getforwardSuccessMsg == '' && 
              context.watch<OpenLeadController>().getviewDetailsClicked == false && 
              context.watch<OpenLeadController>().getforwardDialogClicked == false  && 
              context.watch<OpenLeadController>().getupdateFrowardDialog == false)?
              loadingDialog(context):
              (context.watch<OpenLeadController>().getisLodingDialog == false &&
              context.watch<OpenLeadController>().getforwardSuccessMsg != '' && 
              context.watch<OpenLeadController>().getviewDetailsClicked == false && 
              context.watch<OpenLeadController>().getforwardDialogClicked == false  && 
              context.watch<OpenLeadController>().getupdateFrowardDialog == false)?
              displayDialog(context ,theme,):
              (context.watch<OpenLeadController>().getisLodingDialog == false &&
              context.watch<OpenLeadController>().getforwardSuccessMsg == '' && 
              context.watch<OpenLeadController>().getviewDetailsClicked == true && 
              context.watch<OpenLeadController>().getforwardDialogClicked == false  && 
              context.watch<OpenLeadController>().getupdateFrowardDialog == false)?
              detailsDialog(context ,theme,):
                  (context.watch<OpenLeadController>().getisLodingDialog == false &&
              context.watch<OpenLeadController>().getforwardSuccessMsg == '' && 
              context.watch<OpenLeadController>().getviewDetailsClicked == false && 
              context.watch<OpenLeadController>().getforwardDialogClicked == true && 
              context.watch<OpenLeadController>().getupdateFrowardDialog == false)?
             forwardDialog(context ,theme,) :
             (context.watch<OpenLeadController>().getisLodingDialog == false &&
              context.watch<OpenLeadController>().getforwardSuccessMsg == '' && 
              context.watch<OpenLeadController>().getviewDetailsClicked == false && 
              context.watch<OpenLeadController>().getforwardDialogClicked == false && 
              context.watch<OpenLeadController>().getupdateFrowardDialog == true)?
             UpdateFollowup(context ,theme,):
             CallDialog(context ,theme,)
            );
    //       }
    //     );
    //   }
    // );
  }

    Container CallDialog(BuildContext context, ThemeData theme,) {
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
                context.read<OpenLeadController>().makePhoneCall(widget.followUPListData
                      .Mobile!);
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
                  context.read<OpenLeadController>().changetoFolloweUp();
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
                          context.read<OpenLeadController>()
                                .caseStatusSelectBtn("Won","02");
                           context.read<OpenLeadController>()
                                .changetoFolloweUp();
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
                           context.read<OpenLeadController>()
                                .caseStatusSelectBtn("Lost","03");
                            context.read<OpenLeadController>()
                                .changetoFolloweUp();
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
                           context.read<OpenLeadController>().forwardClicked();
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

                        context.read<OpenLeadController>().mapValuestoorder2(
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
                // SizedBox(
                //   height: Screens.bodyheight(context) * 0.02,
                // ),
            
            
              ],
            ),
          ),
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {
               context.read<OpenLeadController>().callGetLeadDeatilsApi(
                        widget.followUPListData
                            .LeadDocEntry
                            .toString());
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

  Container displayDialog(BuildContext context, ThemeData theme,) {
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
             context.read<OpenLeadController>().getforwardSuccessMsg.toString().toLowerCase()
                      .contains("success")
                  ? "Success..!!"
                  : ' "Error..!!"',
              style: context.read<OpenLeadController>().getforwardSuccessMsg
                      .contains("Success")
                  ? theme.textTheme.headline6?.copyWith(color: Colors.green)
                  : theme.textTheme.headline6?.copyWith(color: Colors.red),
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.02,
            ),
            Text(
              context.watch<OpenLeadController>().getforwardSuccessMsg,
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

  Container detailsDialog(BuildContext context, ThemeData theme,) {
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
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${context.watch<OpenLeadController>().getleadDeatilsQTHData![0].CardName}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                 width: Screens.width(context)*0.4,
                 alignment: Alignment.centerRight,
                   padding: EdgeInsets.symmetric(horizontal: 4,
                   vertical: 3
                   ),
                   decoration: BoxDecoration(
                     borderRadius:BorderRadius.circular(3),
                   color:  Color(0xffC6AC5F),
                   ),
                   child: Center(
                     child: Text("Open since "+
                                context.read<OpenLeadController>().config
                                    .subtractDateTime2(
                                      // "2020-05-18T00:00:00"
                                        "${context.read<OpenLeadController>()
                                        .getleadDeatilsQTHData![0].LeadCreatedDate}"
                                        ),
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
                          "${context.watch<OpenLeadController>().getleadDeatilsQTHData![0].Address1}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.43,
                        child: Text(
                          "Worth of Rs." +
                              context.read<OpenLeadController>().config
                                  .slpitCurrency22(
                                    "${context.read<OpenLeadController>().getleadDeatilsQTHData![0].DocTotal!.toString()}",
                                  ) +'/-',

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
                          "${context.watch<OpenLeadController>().getleadDeatilsQTHData![0].Address2}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "# ${context.watch<OpenLeadController>().getleadDeatilsQTHData![0].LeadNum}",
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
                          "${context.watch<OpenLeadController>().getleadDeatilsQTHData![0].City}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "Created on " +
                              context.read<OpenLeadController>().config.alignDate3(
                                  "${context.read<OpenLeadController>().getleadDeatilsQTHData![0].LeadCreatedDate}" //.LastFUPUpdate
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
                          "${context.watch<OpenLeadController>().getleadDeatilsQTHData![0].Pincode}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.43,
                        child: Text(
                          "Last Update on " +
                              context.read<OpenLeadController>().config.alignDate3(
                                  "${context.read<OpenLeadController>().getleadDeatilsQTHData![0].LastFUPUpdate}" //.
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
                            child:context.watch<OpenLeadController>().getleadDeatilsQTHData![0].nextFollowupDate!.isNotEmpty||context.watch<OpenLeadController>().getleadDeatilsQTHData![0].nextFollowupDate !=null||context.watch<OpenLeadController>().getleadDeatilsQTHData![0].nextFollowupDate !="null"? Container(
                              alignment: Alignment.center,
   child: Text(
                                'Next Follow up # ' +
                                    context
                                        .watch<OpenLeadController>()
                                        .config
                                        .alignDate(
                                            '${context.watch<OpenLeadController>().getleadDeatilsQTHData![0].nextFollowupDate}'),
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyText2?.copyWith(
                                  color: theme.primaryColor,
                                ),
                              ),
                            ):Container(
                              alignment: Alignment.center,
   child: Text(
                                'Next Follow up # ' ,
                                    // context
                                    //     .watch<LeadTabController>()
                                    //     .config
                                    //     .alignDate(
                                    //         '${context.watch<LeadTabController>().getleadDeatilsQTHData![0].nextFollowupDate}'),
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
                          decoration:BoxDecoration(
                            border:Border(
                              bottom: BorderSide(color: Colors.black26)
                            )
                          )
                        ),
                           Center(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Last status # ${context.watch<OpenLeadController>().getleadDeatilsQTHData![0].status}',
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
                  createTable(theme,),
                  Divider(thickness: 1,),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  //
                  Wrap(
                      spacing: 0.0, // width
                      runSpacing: 0.0, // height
                      children: listTimeLine(theme,)),
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
                  context.read<OpenLeadController>().followUPClicked();
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


    Widget createTable(ThemeData theme,) {
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
    for (int i = 0;
        i < context.watch<OpenLeadController>().getleadDeatilsQTLData.length;
        ++i) {
      rows.add(TableRow(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<OpenLeadController>().getleadDeatilsQTLData[i].ItemName!}',
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            context.read<OpenLeadController>().config.slpitCurrency(context.read<OpenLeadController>()
                .getleadDeatilsQTLData[i]
                .Price!
                .toStringAsFixed(0)),
            // '${fUPCon.getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<OpenLeadController>().getleadDeatilsQTLData[i].Quantity!.toStringAsFixed(0)}',
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

    List<Widget> listTimeLine(ThemeData theme,) {
    return List.generate(
        context.watch<OpenLeadController>().getleadDeatilsLeadData.length, (index) {
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
            iconData:
            context.read<OpenLeadController>().getleadDeatilsLeadData[index].FollowMode=='Phone Call'?
            Icons.call
            :context.read<OpenLeadController>().getleadDeatilsLeadData[index].FollowMode=='Sms/WhatsApp'?
            Icons.message
            :context.read<OpenLeadController>().getleadDeatilsLeadData[index].FollowMode=='Store Visit'?
             Icons.store:Icons.chat,
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
                        "${context.watch<OpenLeadController>().getleadDeatilsLeadData[index].Status} ",
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
                        "By${context.read<OpenLeadController>().getleadDeatilsLeadData[index].UpdatedBy} through ${context.read<OpenLeadController>().getleadDeatilsLeadData[index].FollowMode ==null||context.read<OpenLeadController>().getleadDeatilsLeadData[index].FollowMode =="null"||context.read<OpenLeadController>().getleadDeatilsLeadData[index].FollowMode!.isEmpty?"":  context.read<OpenLeadController>().getleadDeatilsLeadData[index].FollowMode}", //),
                        style: theme.textTheme.bodyText2?.copyWith(
                            // color: theme.primaryColor,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.02,
                    ),
                   context.read<OpenLeadController>()
                            .getleadDeatilsLeadData[index]
                            .Feedback!
                            .isEmpty
                        ? SizedBox()
                        : Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              // fUPCon.config.alignDate(
                              "# ${context.watch<OpenLeadController>().getleadDeatilsLeadData[index].Feedback}",
                              style: theme.textTheme.bodyText2?.copyWith(
                                  // color: theme.primaryColor,
                                  ),
                            ),
                          ),
                          Divider(thickness: 1,),
                    //       SizedBox(
                    //   height: Screens.bodyheight(context) * 0.01,
                    // ),
                  ],
                ),
              ),
               startChild: 
                Container(
                    padding:EdgeInsets.only
                (
                  left: Screens.width(context)*0.02,
                  right: Screens.width(context)*0.02
                ),
                 // alignment:Alignment.centerRight,
                       // color: Colors.blue,
                        width: Screens.width(context) * 0.25,
                        child: Column(
                          children: [
                            Text(
                              context.read<OpenLeadController>().config.alignDate2(
                                    "${context.read<OpenLeadController>().getleadDeatilsLeadData[index].Followup_Date_Time}",
                                  ),
                                  textAlign:TextAlign.center,
                              style: theme.textTheme.bodyText2,
                            ),
                          ],
                        )),
            ),
          ],
        );
      } else if (index ==
          context.read<OpenLeadController>().getleadDeatilsLeadData.length - 1) {
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
            iconData:
            context.read<OpenLeadController>().getleadDeatilsLeadData[index].FollowMode=='Phone Call'?
            Icons.call
            :context.read<OpenLeadController>().getleadDeatilsLeadData[index].FollowMode=='Sms/WhatsApp'?
            Icons.message
            :context.read<OpenLeadController>().getleadDeatilsLeadData[index].FollowMode=='Store Visit'?
             Icons.store:Icons.chat,
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
                 padding:EdgeInsets.only
              (
                left: Screens.width(context)*0.02,
                right: Screens.width(context)*0.02
              ),
                child: Column(
                       crossAxisAlignment:CrossAxisAlignment.center,
                          mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                     SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                   Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${context.watch<OpenLeadController>().getleadDeatilsLeadData[index].Status} ",
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
                        "By ${context.watch<OpenLeadController>().getleadDeatilsLeadData[index].UpdatedBy} through ${context.watch<OpenLeadController>().getleadDeatilsLeadData[index].FollowMode}", //),
                        style: theme.textTheme.bodyText2?.copyWith(
                            // color: theme.primaryColor,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    context.read<OpenLeadController>().getleadDeatilsLeadData[index]
                            .Feedback!
                            .isEmpty
                        ? SizedBox()
                        : Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              // fUPCon.config.alignDate(
                              "# ${context.watch<OpenLeadController>().getleadDeatilsLeadData[index].Feedback}",
                              style:
                                  theme.textTheme.bodyText2?.copyWith(
                                      // color: theme.primaryColor,
                                      ),
                            ),
                          ),],
                ),
              ),
              startChild: 
                Container(
                    padding:EdgeInsets.only
                (
                  left: Screens.width(context)*0.02,
                  right: Screens.width(context)*0.02
                ),
                        width: Screens.width(context) * 0.25,
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.center,
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                        SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                            Text(
                              context.read<OpenLeadController>().config.alignDate2(
                                    "${context.read<OpenLeadController>().getleadDeatilsLeadData[index].Followup_Date_Time}",
                                  ),
                                  textAlign:TextAlign.center,
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
            iconData:
            context.read<OpenLeadController>().getleadDeatilsLeadData[index].FollowMode=='Phone Call'?
            Icons.call
            :context.read<OpenLeadController>().getleadDeatilsLeadData[index].FollowMode=='Sms/WhatsApp'?
            Icons.message
            :context.read<OpenLeadController>().getleadDeatilsLeadData[index].FollowMode=='Store Visit'?
             Icons.store:Icons.chat,
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
            
              endChild: 
              Container(
               // color: Colors.red,
                width: Screens.width(context) * 0.6,
                child: Column(
                       crossAxisAlignment:CrossAxisAlignment.center,
                          mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                   Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${context.watch<OpenLeadController>().getleadDeatilsLeadData[index].Status} ",
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
                        "By ${context.watch<OpenLeadController>().getleadDeatilsLeadData[index].UpdatedBy} through ${context.watch<OpenLeadController>().getleadDeatilsLeadData[index].FollowMode}", //),
                        style: theme.textTheme.bodyText2?.copyWith(
                            // color: theme.primaryColor,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                   context.read<OpenLeadController>().getleadDeatilsLeadData[index]
                            .Feedback!
                            .isEmpty
                        ? SizedBox()
                        : Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              // fUPCon.config.alignDate(
                              "# ${context.watch<OpenLeadController>().getleadDeatilsLeadData[index].Feedback}",
                              style:
                                  theme.textTheme.bodyText2?.copyWith(
                                      // color: theme.primaryColor,
                                      ),
                            ),
                          ),
                          Divider(thickness: 1,),
                  ],
                ),
              ),
              startChild: 
                Container(
              //  color: Colors.red,
                    padding:EdgeInsets.only
                (
                  left: Screens.width(context)*0.02,
                  right: Screens.width(context)*0.02
                ),
                        width: Screens.width(context) * 0.25,
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.center,
                          mainAxisAlignment:MainAxisAlignment.center,
                          children: [
                              
                            Text(
                              context.read<OpenLeadController>().config.alignDate2(
                                    "${context.read<OpenLeadController>().getleadDeatilsLeadData[index].Followup_Date_Time}",
                                  ),
                                  textAlign:TextAlign.center,
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
    Container forwardDialog(BuildContext context, ThemeData theme,) {
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
                                    context.read<OpenLeadController>().filterListAssignData(v);
                                   context.read<OpenLeadController>().setForwardDataList();
      
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
              height: Screens.bodyheight(context)*0.4,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Wrap(
                        spacing: 10.0, // gap between adjacent chips
                        runSpacing: 10.0, // gap between lines
                        children: listContainersProduct(
                          theme,
                        )),
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
                  context.read<OpenLeadController>()
                      .getforwardNextFollowDate!, // "Next Follow up",
                  style: theme.textTheme.bodyText2?.copyWith(
                    color: context.read<OpenLeadController>()
                            .getforwardNextFollowDate!
                            .contains(" *")
                        ? Colors.red
                        : Colors.grey,
                  ), // fontSize: 12
                )),
                InkWell(
                  onTap: () {
                 context.read<OpenLeadController>().showForwardNextDate(context);
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
                             context.watch<OpenLeadController>()
                                .getforwardnextWonFD,
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
                                     context
                                            .read<OpenLeadController>()
                                            .assignVisitTime!, // "Next Follow up",
                                    style: theme.textTheme.bodyText2?.copyWith(
                                      color:  context
                                            .read<OpenLeadController>()
                                            .assignVisitTime!.contains(" *")
                                          ? Colors.red
                                          : Colors.grey,
                                    ), // fontSize: 12
                                  )),
                                  InkWell(
                                    onTap:   () {
                                            setState(() {
                                               context
                                            .read<OpenLeadController>()
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
                                               context
                                            .watch<OpenLeadController>()
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
                              context
                                                .read<OpenLeadController>()
                                                .forwarderrorVisitTime=='' ?Container(): Container(
                              alignment: Alignment.centerRight,
                              child: Text("${context
                                                .read<OpenLeadController>()
                                                .forwarderrorVisitTime}",style: theme.textTheme.bodyText1!.copyWith(
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
                       context.read<OpenLeadController>().forwardClicked();
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
                        if (context
                            .read<OpenLeadController>()
                            .selectedUserList
                            .isNotEmpty &&context
                            .read<OpenLeadController>()
                            . forwaVisitTime.isNotEmpty &&context
                            .read<OpenLeadController>()
                            .forwardNextFollowDate!.isNotEmpty) {
                          context.read<OpenLeadController>().Allfollowupupdate(
                             "", context
                                  .read<OpenLeadController>()
                                  .leadOpenAllData[widget.index]
                                  .LeadDocEntry
                                  .toString(),"","","","",
                              context
                                  .read<OpenLeadController>()
                                  .selectedUserList,context
                                  .read<OpenLeadController>()
                                  .leadOpenAllData[widget.index]
                                  .LastUpdateMessage
                                  .toString());
                        }else{
                          setState(() {
                              if(context
                                  .read<OpenLeadController>()
                                  .selectedUserList
                            .isEmpty){
                           context
                                  .read<OpenLeadController>()
                                  ..showtoastforall();   
                            }
                            if(context
                                  .read<OpenLeadController>()
                                  . forwaVisitTime.isEmpty ){
   context
                                  .read<OpenLeadController>()
                                  . assignVisitTime="Followup Time: *";
                                   
                                 
                            }
                            if(context
                                  .read<OpenLeadController>()
                                  .getforwardnextWonFD!.isEmpty){
 context
                                  .read<OpenLeadController>()
                                  .forwardNextFollowDate="Next Followup: *"; 
                            }
                            // context
                            //       .read<OpenLeadController>()
                            //       . assignVisitTime="Followup Time:*";
                            //        context
                            //       .read<OpenLeadController>()
                            //       .forwardNextFollowDate="Next Follow Up:*"; 
                          });
                        
                        }
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

  List<Widget> listContainersProduct(ThemeData theme,) {
    return List.generate(
      context.watch<OpenLeadController>().filteruserLtData.length,
      (ind) => GestureDetector(
        onTap: () {
          context.read<OpenLeadController>().getSelectedUserSalesEmpId(ind);
        },
        child: Container(
          width: Screens.width(context) * 0.4,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color:
                  context.watch<OpenLeadController>().filteruserLtData[ind].color ==
                          1
                      ? theme.primaryColor
                      : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: Text(
              context.watch<OpenLeadController>().filteruserLtData[ind].UserName!,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: context.watch<OpenLeadController>()
                            .filteruserLtData[ind]
                            .color ==
                        1
                    ? Colors.white
                    : theme.primaryColor,
              )),
        ),
      ),
    );
  }

//
List<Widget> listContainersCustomerTag(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<OpenLeadController>().getleadphonedata.length,
      (index) => InkWell(
        onTap: () {
          // context.read<LeadNewController>(). isSelectedenquirytype = context.read<LeadNewController>()
          // .getenqReffList[index].Name.toString();
          context.read<OpenLeadController>().selectFollowUp(context
              .read<OpenLeadController>()
              .getleadphonedata[index]
              .name
              .toString(),context
              .read<OpenLeadController>()
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
              color: context.watch<OpenLeadController>().isSelectedFollowUpcode ==
                      context
                          .read<OpenLeadController>()
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
                  context
                      .watch<OpenLeadController>()
                      .getleadphonedata[index]
                      .name
                      .toString(),
                  maxLines: 8,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 13,
                    color:
                        context.watch<OpenLeadController>().isSelectedFollowUpcode ==
                                context
                                    .read<OpenLeadController>()
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
//
 List<Widget> listContainersOpenTag(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<OpenLeadController>().getleadopendata.length,
      (index) => InkWell(
        onTap: () {
          // context.read<LeadNewController>(). isSelectedenquirytype = context.read<LeadNewController>()
          // .getenqReffList[index].Name.toString();


           context
                                      .read<OpenLeadController>()
                                      .caseStatusSelectBtn( context
                          .read<OpenLeadController>()
                          .getleadopendata[index]
                          .name
                          .toString(), context
                          .read<OpenLeadController>()
                          .getleadopendata[index]
                          .code
                          .toString());
                                  context
                                      .read<OpenLeadController>()
                                      .validatebtnChanged();
          // context.read<LeadTabController>().selectFollowUp(context
          //     .read<LeadTabController>()
          //     .getleadopendata[index]
          //     .name
          //     .toString(),context
          //     .read<LeadTabController>()
          //     .getleadopendata[index]
          //     .code
          //     .toString());
          // log(context.read<LeadNewController>().getisSelectedCsTag.toString());
          // log(context
          //     .read<LeadNewController>()
          //     .getCusTagList[index]
          //     .Name
          //     .toString());
        },
        child: Container(
         width: Screens.width(context) * 0.26,
                            height: Screens.bodyheight(context) * 0.06,
           padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context.watch<OpenLeadController>().getcaseStatusSelected ==
                      context
                          .read<OpenLeadController>()
                          .getleadopendata[index]
                          .name
                          .toString()
                  ?Color(0xffFCF752)//theme.primaryColor.withOpacity(0.5)
                  : theme.primaryColor,
              border: Border.all(color: theme.primaryColor, ),
              borderRadius: BorderRadius.circular(4)),
          child: Text(
              context
                  .watch<OpenLeadController>()
                  .getleadopendata[index]
                  .name
                  .toString(),
              maxLines: 8,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 13,
                color:
                    context.watch<OpenLeadController>().getcaseStatusSelected ==
                            context
                                .read<OpenLeadController>()
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
//open close won update dialog

  Container UpdateFollowup(BuildContext context, ThemeData theme,) {
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
                         context.watch<OpenLeadController>().followup!,
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: context.read<OpenLeadController>().getfollowup!
                                    .contains(" *")
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
                                  theme,
                                )),
                          ),



                      // CustomRadioBtnOPLFUP(
                      //   theme: theme,
                      //   onPressed1: () {
                      //     //  setState(() {
                      //    context.read<OpenLeadController>().selectFollowUp("Phone Call");
                      //     //});
                      //   },
                      //   onPressed2: () {
                      //     //   setState(() {
                      //   context.read<OpenLeadController>().selectFollowUp("Sms/WhatsApp");
                      //     //   });
                      //   },
                      //   text1: 'Phone Call',
                      //   text2: 'Sms/WhatsApp',
                        
                      // ),
                      // SizedBox(height: Screens.bodyheight(context) * 0.01),
                      // CustomRadioBtnOPLFUP(
                      //   theme: theme,
                      //   onPressed1: () {
                      //     //  setState(() {
                      //   context.read<OpenLeadController>()
                      //         .selectFollowUp("Store Visit");
                      //     //  });
                      //   },
                      //   onPressed2: () {
                      //     //  setState(() {
                      //    context.read<OpenLeadController>()
                      //         .selectFollowUp("Other");
                      //     //  });
                      //   },
                      //   text1: 'Store Visit',
                      //   text2: 'Other',
                       
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
                                  theme,
                                )),
                          ),
                          // Container(
                          //   width: Screens.width(context) * 0.26,
                          //   height: Screens.bodyheight(context) * 0.06,
                          //   child: ElevatedButton(
                          //       style: ElevatedButton.styleFrom(
                          //         primary:context.read<OpenLeadController>()
                          //                     .getcaseStatusSelected ==
                          //                 'Open'
                          //             ? Color(0xffFCF752)
                          //             : theme.primaryColor,
                          //         textStyle: TextStyle(
                          //             color:context.read<OpenLeadController>()
                          //                         .getcaseStatusSelected ==
                          //                     'Open'
                          //                 ? Colors.black
                          //                 : Colors.white),
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(6))),
                          //       ),
                          //       onPressed: () {
                          //         // setState(() {
                          //        context.read<OpenLeadController>()
                          //             .caseStatusSelectBtn("Open");
                          //        context.read<OpenLeadController>()
                          //             .validatebtnChanged();
                          //         //   });
                          //       },
                          //       child: Text(
                          //         "Open",
                          //         style: TextStyle(
                          //             color:context.read<OpenLeadController>()
                          //                         .getcaseStatusSelected ==
                          //                     'Open'
                          //                 ? Colors.black
                          //                 : Colors.white),
                          //       )),
                          // ),
                          // Container(
                          //   width: Screens.width(context) * 0.26,
                          //   height: Screens.bodyheight(context) * 0.06,
                          //   child: ElevatedButton(
                          //       style: ElevatedButton.styleFrom(
                          //         primary:context.read<OpenLeadController>()
                          //                     .getcaseStatusSelected ==
                          //                 'Won'
                          //             ? Color(0xffFCF752)
                          //             : theme.primaryColor,
                          //         textStyle: TextStyle(
                          //             color:context.read<OpenLeadController>()
                          //                         .getcaseStatusSelected ==
                          //                     'Won'
                          //                 ? Colors.black
                          //                 : Colors.white),
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(6))),
                          //       ),
                          //       onPressed: () {
                          //        context.read<OpenLeadController>().caseStatusSelectBtn("Won");
                          //        context.read<OpenLeadController>().validatebtnChanged();
                          //       },
                          //       child: Text(
                          //         "Won",
                          //         style: TextStyle(
                          //             color: context.read<OpenLeadController>()
                          //                         .getcaseStatusSelected ==
                          //                     'Won'
                          //                 ? Colors.black
                          //                 : Colors.white),
                          //       )),
                          // ),
                          // Container(
                          //   width: Screens.width(context) * 0.26,
                          //   height: Screens.bodyheight(context) * 0.06,
                          //   child: ElevatedButton(
                          //       style: ElevatedButton.styleFrom(
                          //         primary: context.read<OpenLeadController>()
                          //                     .getcaseStatusSelected ==
                          //                 'Lost'
                          //             ? Color(0xffFCF752)
                          //             : theme.primaryColor,
                          //         textStyle: TextStyle(
                          //             color: context.read<OpenLeadController>()
                          //                         .getcaseStatusSelected ==
                          //                     'Lost'
                          //                 ? Colors.black
                          //                 : Colors.white),
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(6))),
                          //       ),
                          //       onPressed: () {
                          //         context.read<OpenLeadController>()
                          //               .caseStatusSelectBtn("Lost");
                          //         context.read<OpenLeadController>()
                          //               .validatebtnChanged();
                          //       },
                          //       child: Text(
                          //         "Lost",
                          //         style: TextStyle(
                          //             color:context.read<OpenLeadController>()
                          //                         .getcaseStatusSelected ==
                          //                     'Lost'
                          //                 ? Colors.black
                          //                 : Colors.white),
                          //       )),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      Visibility(
                        visible: context.read<OpenLeadController>()
                                    .getcaseStatusSelected ==
                                'Open'
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
                                  context.watch<OpenLeadController>()
                                      .gethinttextforOpenLead!,
                                  style: theme.textTheme.bodyText2?.copyWith(
                                      color: context.read<OpenLeadController>()
                                              .gethinttextforOpenLead!
                                              .contains(" *")
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                value: context.read<OpenLeadController>()
                                    .valueChosedStatus,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                   context.read<OpenLeadController>()
                                        .choosedStatus(val.toString());
                                },
                                items: context.read<OpenLeadController>()
                                    .leadStatusOpen
                                    .map((e) {
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
                        visible:context.read<OpenLeadController>()
                                    .getcaseStatusSelected ==
                                'Won'
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
                                 context.read<OpenLeadController>()
                                      .gethinttextforWonLead!,
                                  style: theme.textTheme.bodyText2?.copyWith(
                                      color: context.read<OpenLeadController>()
                                              .gethinttextforWonLead!
                                              .contains(" *")
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                value:context.read<OpenLeadController>()
                                    .valueChosedStatusWon,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                   context.read<OpenLeadController>().choosedStatusWon(val.toString());
                                },
                                items:context.read<OpenLeadController>()
                                    .leadStatusWon
                                    .map((e) {
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
                              controller: context.read<OpenLeadController>()
                                  .mycontroller[0],
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
                                  hintText: context.read<OpenLeadController>()
                                      .getorderBillRefer!,
                                  hintStyle:
                                      theme.textTheme.bodyText2?.copyWith(
                                    color:context.read<OpenLeadController>()
                                            .getorderBillRefer!
                                            .contains(" *")
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
                                context.read<OpenLeadController>()
                                      .getorderBillDate!, // "Next Follow up",
                                  style: theme.textTheme.bodyText2?.copyWith(
                                    color: context.read<OpenLeadController>()
                                            .getorderBillDate!
                                            .contains(" *")
                                        ? Colors.red
                                        : Colors.grey,
                                  ), // fontSize: 12
                                )),
                                InkWell(
                                  onTap:context.read<OpenLeadController>()
                                              .getcaseStatusSelected ==
                                          'Won'
                                      ? () {
                                         context.read<OpenLeadController>()
                                              .showFollowupWonDate(context);
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
                                           context.watch<OpenLeadController>()
                                                .getnextWonFD,
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
                        visible:context.read<OpenLeadController>()
                                    .getcaseStatusSelected ==
                                'Lost'
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
                                 context.read<OpenLeadController>()
                                      .gethinttextforLostLead!,
                                  style: theme.textTheme.bodyText2?.copyWith(
                                      color: context.read<OpenLeadController>()
                                              .gethinttextforLostLead!
                                              .contains(" *")
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                value: context.read<OpenLeadController>()
                                    .valueChosedReason,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                  setState(() {
                                   context.read<OpenLeadController>()
                                        .choosedReason(val.toString());
                                  });
                                },
                                items:context.read<OpenLeadController>()
                                    .leadStatusLost
                                    .map((e) {
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
                        context.read<OpenLeadController>()
                              .getfeedbackLead!, // "Feedback",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: context.read<OpenLeadController>()
                                    .getfeedbackLead!
                                    .contains(" *")
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      TextFormField(
                        controller:
                           context.read<OpenLeadController>().mycontroller[1],
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]!),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                   context.read<OpenLeadController>()
                                        .getcaseStatusSelected !=
                                    'Open' ?Container():  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Text(
                            context.read<OpenLeadController>()
                                .getnextFollowupDate!, // "Next Follow up",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: context.read<OpenLeadController>()
                                      .getnextFollowupDate!
                                      .contains(" *")
                                  ? Colors.red
                                  : Colors.grey,
                            ), // fontSize: 12
                          )),
                          InkWell(
                            onTap: context.read<OpenLeadController>()
                                        .getcaseStatusSelected ==
                                    'Open'
                                ? () {
                                   context.read<OpenLeadController>()
                                        .showFollowupDate(context);
                                  }
                                : null,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.015),
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
                                     context.watch<OpenLeadController>()
                                          .getnextFD,
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

                     context
                                          .read<OpenLeadController>()
                                          .getcaseStatusSelected != 'Open'?Container(): Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    child: Text(
                                   context
                                          .read<OpenLeadController>()
                                          .nextVisitTime!, // "Next Follow up",
                                  style: theme.textTheme.bodyText2?.copyWith(
                                    color:  context
                                          .read<OpenLeadController>()
                                          .nextVisitTime!.contains(" *")
                                        ? Colors.red
                                        : Colors.grey,
                                  ), // fontSize: 12
                                )),
                                InkWell(
                                  onTap:  context
                                          .read<OpenLeadController>()
                                          .getcaseStatusSelected == 'Open'
                                      ? () {
                                          setState(() {
                                             context
                                          .read<OpenLeadController>()
                                          .selectVisitTime(context);
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
                                             context
                                          .watch<OpenLeadController>()
                                          .VisitTime,
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
               context
                                                .read<OpenLeadController>()
                                                .errorVisitTime=='' ?Container(): Container(
                              alignment: Alignment.centerRight,
                              child: Text("${context
                                                .read<OpenLeadController>()
                                                .errorVisitTime}",style: theme.textTheme.bodyText1!.copyWith(
                                color: Colors.red,
                                fontSize: 13
                              ),),
                            ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
               
               
                    ],
                  ),
                )),
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                  onPressed: () {
                     context.read<OpenLeadController>().clickLeadSaveBtn(
                          widget.followUPListData
                              .FollowupEntry
                              .toString(),
                         widget.followUPListData
                              .LeadDocEntry
                              .toString());
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


}