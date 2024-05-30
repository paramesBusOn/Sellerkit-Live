// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, non_constant_identifier_names

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/GetAllLeadModel.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/LeadController/TabLeadController.dart';
import 'CustomRadioBtn.dart';
import 'package:timeline_tile/timeline_tile.dart';
//import 'package:timelines/timelines.dart';

class FollowDialog extends StatefulWidget {
  FollowDialog({Key? key, required this.index,required this.leadopenalldata}) : super(key: key);
  final int index;
 GetAllLeadData leadopenalldata;
  @override

  State<FollowDialog> createState() => _FollowDialogState();
}

class _FollowDialogState extends State<FollowDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (LeadTabController.comeFromEnq == -1 &&
          LeadTabController.isanyExcep == 0) {
        context.read<LeadTabController>().resetValuesIS1();
      }
      // else if((LeadTabController.comeFromEnq==-2)){
      // }
      // else{
      //   context.read<LeadTabController>().resetValuesISnot1();
      // }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // Provider.of<LeadTabController>(context).dispose();
    //  context.read<LeadTabController>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: //UpdateFollowup(context, theme),
          (context.watch<LeadTabController>().getupdateFollowUpDialog == false &&
                  context.watch<LeadTabController>().getleadForwarddialog ==
                      false &&
                  context.watch<LeadTabController>().getleadLoadingdialog ==
                      false &&
                  context.watch<LeadTabController>().getviewDetailsdialog ==
                      false &&
                  context.watch<LeadTabController>().getupdateConvertToQuatationUpdialog ==
                      false &&
                  context
                      .watch<LeadTabController>()
                      .getforwardSuccessMsg
                      .isEmpty &&
                  context.watch<LeadTabController>().getisSameBranch == true)
              ? CallDialog(context, theme)
              : (context.watch<LeadTabController>().getupdateFollowUpDialog == false &&
                      context.watch<LeadTabController>().getleadForwarddialog ==
                          false &&
                      context.watch<LeadTabController>().getleadLoadingdialog ==
                          false &&
                      context.watch<LeadTabController>().getviewDetailsdialog ==
                          false &&
                      context.watch<LeadTabController>().getupdateConvertToQuatationUpdialog ==
                          true &&
                      context
                          .watch<LeadTabController>()
                          .getforwardSuccessMsg
                          .isEmpty &&
                      context.watch<LeadTabController>().getisSameBranch ==
                          false)
                  ? ConvertToDialog(context, theme)
                  : (context.watch<LeadTabController>().getupdateFollowUpDialog == false &&
                          context.watch<LeadTabController>().getleadForwarddialog ==
                              false &&
                          context.watch<LeadTabController>().getleadLoadingdialog ==
                              false &&
                          context.watch<LeadTabController>().getviewDetailsdialog ==
                              true &&
                          context
                                  .watch<LeadTabController>()
                                  .getupdateConvertToQuatationUpdialog ==
                              false &&
                          context
                              .watch<LeadTabController>()
                              .getforwardSuccessMsg
                              .isEmpty &&
                          context.watch<LeadTabController>().getisSameBranch ==
                              true)
                      ? detailsDialog(context, theme)
                      :
                      //
                      (context.watch<LeadTabController>().getupdateFollowUpDialog == false &&
                              context.watch<LeadTabController>().getleadForwarddialog ==
                                  false &&
                              context.watch<LeadTabController>().getleadLoadingdialog ==
                                  false &&
                              context.watch<LeadTabController>().getviewDetailsdialog ==
                                  true &&
                              context
                                      .watch<LeadTabController>()
                                      .getupdateConvertToQuatationUpdialog ==
                                  false &&
                              context
                                  .watch<LeadTabController>()
                                  .getforwardSuccessMsg
                                  .isEmpty &&
                              context.watch<LeadTabController>().getisSameBranch ==
                                  false)
                          ? detailsDialogLead(context, theme)

                          //
                          : (context.watch<LeadTabController>().getupdateFollowUpDialog == false &&
                                  context.watch<LeadTabController>().getleadForwarddialog == true &&
                                  context.watch<LeadTabController>().getleadLoadingdialog == false &&
                                  context.watch<LeadTabController>().getviewDetailsdialog == false &&
                                  context.watch<LeadTabController>().getupdateConvertToQuatationUpdialog == false &&
                                  context.watch<LeadTabController>().getforwardSuccessMsg.isEmpty &&
                                  context.watch<LeadTabController>().getisSameBranch == true)
                              ? forwardDialog(context, theme)
                              : (context.watch<LeadTabController>().getupdateFollowUpDialog == false && context.watch<LeadTabController>().getleadForwarddialog == true && context.watch<LeadTabController>().getleadLoadingdialog == true && context.watch<LeadTabController>().getviewDetailsdialog == false && context.watch<LeadTabController>().getupdateConvertToQuatationUpdialog == false && context.watch<LeadTabController>().getforwardSuccessMsg.isEmpty && context.watch<LeadTabController>().getisSameBranch == true)
                                  ? loadingDialog(context)
                                  : (context.watch<LeadTabController>().getupdateFollowUpDialog == false && context.watch<LeadTabController>().getleadForwarddialog == true && context.watch<LeadTabController>().getleadLoadingdialog == false && context.watch<LeadTabController>().getviewDetailsdialog == false && context.watch<LeadTabController>().getupdateConvertToQuatationUpdialog == false && context.watch<LeadTabController>().getforwardSuccessMsg.isNotEmpty && context.watch<LeadTabController>().getisSameBranch == true)
                                      ? displayDialog(context, theme)
                                      : UpdateFollowup(context, theme),
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
          SizedBox(
            height: Screens.bodyheight(context) * 0.01,
          ),
          Container(
            child: Column(
              children: [
                Text(
                  context
                          .read<LeadTabController>()
                          .getforwardSuccessMsg
                          .toString()
                          .toLowerCase()
                          .contains("success")
                      ? "Success..!!"
                      : ' "Error..!!"',
                  style: context
                          .watch<LeadTabController>()
                          .getforwardSuccessMsg
                          .contains("Success")
                      ? theme.textTheme.headline6?.copyWith(color: Colors.green)
                      : theme.textTheme.headline6?.copyWith(color: Colors.red),
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                Text(
                  context.watch<LeadTabController>().getforwardSuccessMsg,
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
                        setState(() {
                          Navigator.pop(context);
                          //      context
                          // .read<LeadTabController>()
                          // .swipeRefreshIndiactor();
                        });
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

  Stack displayDialog2(BuildContext context, ThemeData theme) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          width: Screens.width(context),
          height: Screens.bodyheight(context) * 0.4,
          color: Colors.red,
        ),
        Positioned(
          top: Screens.bodyheight(context) * 0.1,
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.2,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  Container UpdateFollowup(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: Screens.width(context),
                //  height: Screens.bodyheight(context)*0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.only(
                  left: Screens.width(context) * 0.05,
                  right: Screens.width(context) * 0.05,
                  top: Screens.bodyheight(context) * 0.03,
                  //  bottom: Screens.bodyheight(context)*0.03,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          // 'How you made the follow up?',
                          context.watch<LeadTabController>().followup!,
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: context
                                    .watch<LeadTabController>()
                                    .getfollowup!
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
                      // CustomRadioBtn(
                      //   theme: theme,
                      //   onPressed1: () {
                      //     //  setState(() {
                      //     context
                      //         .read<LeadTabController>()
                      //         .selectFollowUp("Phone Call");
                      //     //});
                      //   },
                      //   onPressed2: () {
                      //     //   setState(() {
                      //     context
                      //         .read<LeadTabController>()
                      //         .selectFollowUp("Sms/WhatsApp");
                      //     //   });
                      //   },
                      //   text1: 'Phone Call',
                      //   text2: 'Sms/WhatsApp',
                      //   provi: context.read<LeadTabController>(),
                      // ),
                      // SizedBox(height: Screens.bodyheight(context) * 0.01),
                      // CustomRadioBtn(
                      //   theme: theme,
                      //   onPressed1: () {
                      //     //  setState(() {
                      //     context
                      //         .read<LeadTabController>()
                      //         .selectFollowUp("Store Visit");
                      //     //  });
                      //   },
                      //   onPressed2: () {
                      //     //  setState(() {
                      //     context
                      //         .read<LeadTabController>()
                      //         .selectFollowUp("Other");
                      //     //  });
                      //   },
                      //   text1: 'Store Visit',
                      //   text2: 'Other',
                      //   provi: context.read<LeadTabController>(),
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
                          //         primary: context
                          //                     .watch<LeadTabController>()
                          //                     .getcaseStatusSelected ==
                          //                 'Open'
                          //             ? Color(0xffFCF752)
                          //             : theme.primaryColor,
                          //         textStyle: TextStyle(
                          //             color: context
                          //                         .read<LeadTabController>()
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
                          //         context
                          //             .read<LeadTabController>()
                          //             .caseStatusSelectBtn("Open");
                          //         context
                          //             .read<LeadTabController>()
                          //             .validatebtnChanged();
                          //         //   });
                          //       },
                          //       child: Text(
                          //         "Open",
                          //         style: TextStyle(
                          //             color: context
                          //                         .watch<LeadTabController>()
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
                          //         primary: context
                          //                     .watch<LeadTabController>()
                          //                     .getcaseStatusSelected ==
                          //                 'Won'
                          //             ? Color(0xffFCF752)
                          //             : theme.primaryColor,
                          //         textStyle: TextStyle(
                          //             color: context
                          //                         .read<LeadTabController>()
                          //                         .getcaseStatusSelected ==
                          //                     'Won'
                          //                 ? Colors.black
                          //                 : Colors.white),
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(6))),
                          //       ),
                          //       onPressed: () {
                          //         setState(() {
                          //           context
                          //               .read<LeadTabController>()
                          //               .caseStatusSelectBtn("Won");
                          //           context
                          //               .read<LeadTabController>()
                          //               .validatebtnChanged();
                          //         });
                          //       },
                          //       child: Text(
                          //         "Won",
                          //         style: TextStyle(
                          //             color: context
                          //                         .watch<LeadTabController>()
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
                          //         primary: context
                          //                     .watch<LeadTabController>()
                          //                     .getcaseStatusSelected ==
                          //                 'Lost'
                          //             ? Color(0xffFCF752)
                          //             : theme.primaryColor,
                          //         textStyle: TextStyle(
                          //             color: context
                          //                         .read<LeadTabController>()
                          //                         .getcaseStatusSelected ==
                          //                     'Lost'
                          //                 ? Colors.black
                          //                 : Colors.white),
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius:
                          //                 BorderRadius.all(Radius.circular(6))),
                          //       ),
                          //       onPressed: () {
                          //         setState(() {
                          //           context
                          //               .read<LeadTabController>()
                          //               .caseStatusSelectBtn("Lost");
                          //           context
                          //               .read<LeadTabController>()
                          //               .validatebtnChanged();
                          //         });
                          //       },
                          //       child: Text(
                          //         "Lost",
                          //         style: TextStyle(
                          //             color: context
                          //                         .watch<LeadTabController>()
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
                        visible: context
                                    .watch<LeadTabController>()
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
                                  context
                                      .watch<LeadTabController>()
                                      .gethinttextforOpenLead!,
                                  style: theme.textTheme.bodyText2?.copyWith(
                                      color: context
                                              .watch<LeadTabController>()
                                              .gethinttextforOpenLead!
                                              .contains(" *")
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                value: context
                                    .read<LeadTabController>()
                                    .valueChosedStatus,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                  setState(() {
                                    context
                                        .read<LeadTabController>()
                                        .choosedStatus(val.toString());
                                  });
                                },
                                items: context
                                    .read<LeadTabController>()
                                    .leadStatusOpen
                                    .map((e) {
                                  return DropdownMenuItem(
                                      // ignore: unnecessary_brace_in_string_interps
                                      value: "${e.code}",
                                      child: Container(
                                          // height: Screens.bodyheight(context)*0.1,
                                          child: Text("${e.name}")));
                                }).toList(),
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
                                  "Plan of Purchase Date", // "Next Follow up",
                                  style: theme.textTheme.bodyText2?.copyWith(
                                    color: 
                                    // context
                                    //         .watch<LeadTabController>()
                                    //         .getorderBillDate!
                                    //         .contains(" *")
                                    //     ? Colors.red
                                    //     : 
                                        Colors.grey,
                                  ), // fontSize: 12
                                )),
                                InkWell(
                                  onTap: context
                                              .read<LeadTabController>()
                                              .getcaseStatusSelected ==
                                          'Open'
                                      ? () {
                                          context
                                              .read<LeadTabController>()
                                              .showpurchaseupateDate(context);
                                        }
                                      : null,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.015),
                                    width: Screens.width(context) * 0.4,
                                    height: Screens.bodyheight(context) * 0.05,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: Screens.width(context) * 0.25,
                                          // color: Colors.red,
                                          child: Text(
                                            context
                                                .watch<LeadTabController>()
                                                .nextpurchasedate,
                                            // context.read<LeadTabController>().getnextFD,
                                            style: theme.textTheme.bodyText2
                                                ?.copyWith(), //fontSize: 12
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: Screens.width(context) * 0.10,
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
                        
                          ],
                        ),
                      ),
                      Visibility(
                        visible: context
                                    .read<LeadTabController>()
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
                                  context
                                      .read<LeadTabController>()
                                      .gethinttextforWonLead!,
                                  style: theme.textTheme.bodyText2?.copyWith(
                                      color: context
                                              .read<LeadTabController>()
                                              .gethinttextforWonLead!
                                              .contains(" *")
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                value: context
                                    .read<LeadTabController>()
                                    .valueChosedStatusWon,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                  setState(() {
                                    context
                                        .read<LeadTabController>()
                                        .choosedStatusWon(val.toString());
                                  });
                                },
                                items: context
                                    .read<LeadTabController>()
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
                              controller: context
                                  .read<LeadTabController>()
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
                                  hintText: context
                                      .read<LeadTabController>()
                                      .getorderBillRefer!,
                                  hintStyle:
                                      theme.textTheme.bodyText2?.copyWith(
                                    color: context
                                            .read<LeadTabController>()
                                            .getorderBillRefer!
                                            .contains(" *")
                                        ? Colors.red
                                        : Colors.black,
                                    // fontSize: 14
                                  ),
                                  // TextStyle(
                                  //     color: context
                                  //             .read<LeadTabController>()
                                  //             .getorderBillRefer!
                                  //             .contains(" *")
                                  //         ? Colors.red
                                  //         : Colors.black),
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
                                  context
                                      .watch<LeadTabController>()
                                      .getorderBillDate!, // "Next Follow up",
                                  style: theme.textTheme.bodyText2?.copyWith(
                                    color: context
                                            .watch<LeadTabController>()
                                            .getorderBillDate!
                                            .contains(" *")
                                        ? Colors.red
                                        : Colors.grey,
                                  ), // fontSize: 12
                                )),
                                InkWell(
                                  onTap: context
                                              .read<LeadTabController>()
                                              .getcaseStatusSelected ==
                                          'Won'
                                      ? () {
                                          context
                                              .read<LeadTabController>()
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
                                            context
                                                .watch<LeadTabController>()
                                                .getnextWonFD,
                                            // context.read<LeadTabController>().getnextFD,
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
                        visible: context
                                    .read<LeadTabController>()
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
                                  context
                                      .read<LeadTabController>()
                                      .gethinttextforLostLead!,
                                  style: theme.textTheme.bodyText2?.copyWith(
                                      color: context
                                              .read<LeadTabController>()
                                              .gethinttextforLostLead!
                                              .contains(" *")
                                          ? Colors.red
                                          : Colors.black),
                                ),
                                value: context
                                    .read<LeadTabController>()
                                    .valueChosedReason,
                                //dropdownColor:Colors.green,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                                isExpanded: true,
                                onChanged: (val) {
                                  setState(() {
                                    context
                                        .read<LeadTabController>()
                                        .choosedReason(val.toString());
                                  });
                                },
                                items: context
                                    .read<LeadTabController>()
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
                          context
                              .watch<LeadTabController>()
                              .getfeedbackLead!, // "Feedback",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: context
                                    .watch<LeadTabController>()
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
                            context.read<LeadTabController>().mycontroller[1],
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
                      context.read<LeadTabController>().getcaseStatusSelected !=
                              'Open'
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    child: Text(
                                  context
                                      .watch<LeadTabController>()
                                      .getnextFollowupDate!, // "Next Follow up",
                                  style: theme.textTheme.bodyText2?.copyWith(
                                    color: context
                                            .watch<LeadTabController>()
                                            .getnextFollowupDate!
                                            .contains(" *")
                                        ? Colors.red
                                        : Colors.grey,
                                  ), // fontSize: 12
                                )),
                                InkWell(
                                  onTap: context
                                              .read<LeadTabController>()
                                              .getcaseStatusSelected ==
                                          'Open'
                                      ? () {
                                          context
                                              .read<LeadTabController>()
                                              .showFollowupDate(context);
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
                                                .watch<LeadTabController>()
                                                .getnextFD,
                                            // context.read<LeadTabController>().getnextFD,
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

                      context.read<LeadTabController>().getcaseStatusSelected !=
                              'Open'
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    child: Text(
                                  context
                                      .read<LeadTabController>()
                                      .nextVisitTime!, // "Next Follow up",
                                  style: theme.textTheme.bodyText2?.copyWith(
                                    color: context
                                            .read<LeadTabController>()
                                            .nextVisitTime!
                                            .contains(" *")
                                        ? Colors.red
                                        : Colors.grey,
                                  ), // fontSize: 12
                                )),
                                InkWell(
                                  onTap: context
                                              .read<LeadTabController>()
                                              .getcaseStatusSelected ==
                                          'Open'
                                      ? () {
                                          setState(() {
                                            context
                                                .read<LeadTabController>()
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
                                                .watch<LeadTabController>()
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
                                              .read<LeadTabController>()
                                              .getcaseStatusSelected !=
                                          'Open' ?Container():   context
                                                .read<LeadTabController>()
                                                .   iscorectime==false && context
                                                .read<LeadTabController>()
                                                . errorVisitTime ==''?Container(): Container(
                              alignment: Alignment.centerRight,
                              child: Text("${context
                                                .read<LeadTabController>()
                                                . errorVisitTime}*",style: theme.textTheme.bodyText1!.copyWith(
                                color: Colors.red,
                                fontSize: 13
                              ),),
                            )
                    ],
                  ),
                )),
            SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                  onPressed: () {
                    if (LeadTabController.comeFromEnq == -1) {
                      context.read<LeadTabController>().clickLeadSaveBtn(
                          widget
                              .leadopenalldata
                              .FollowupEntry
                              .toString(),
                          widget.leadopenalldata
                              .LeadDocEntry
                              .toString(),
                              widget.leadopenalldata
                              .purchasePlan.toString()
                              );
                    } else {
                      context.read<LeadTabController>().clickLeadSaveBtn(
                          context
                              .read<LeadTabController>()
                              .leadDeatilsLData[0]
                              .FollowupEntry
                              .toString(),
                          LeadTabController.comeFromEnq.toString(),'');
                    }
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

  Container ConvertToDialog(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.07,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
              ),
              child: Text(
                "Quatation Details",
                style: theme.textTheme.bodyText2!.copyWith(color: Colors.white),
              ),
            ),
            Container(
                width: Screens.width(context),
                //  height: Screens.bodyheight(context)*0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.only(
                  left: Screens.width(context) * 0.05,
                  right: Screens.width(context) * 0.05,
                  top: Screens.bodyheight(context) * 0.01,
                  //  bottom: Screens.bodyheight(context)*0.03,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   height: Screens.bodyheight(context) * 0.01,
                      // ),
                      Column(
                        children: [
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.01,
                          ),
                          TextFormField(
                            controller: context
                                .read<LeadTabController>()
                                .mycontroller[3],
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
                                hintText: "Quatation No",
                                hintStyle: theme.textTheme.bodyText2?.copyWith(
                                  color: context
                                          .read<LeadTabController>()
                                          .gettextquatationNo!
                                          .contains(" *")
                                      ? Colors.red
                                      : Colors.black,
                                  // fontSize: 14
                                ),
                                // TextStyle(
                                //     color: context
                                //             .read<LeadTabController>()
                                //             .getorderBillRefer!
                                //             .contains(" *")
                                //         ? Colors.red
                                //         : Colors.black),
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
                                context
                                    .watch<LeadTabController>()
                                    .gettextquatationDate!, // "Next Follow up",
                                style: theme.textTheme.bodyText2?.copyWith(
                                  color: context
                                          .watch<LeadTabController>()
                                          .gettextquatationDate!
                                          .contains(" *")
                                      ? Colors.red
                                      : Colors.grey,
                                ), // fontSize: 12
                              )),
                              InkWell(
                                onTap: () {
                                  context
                                      .read<LeadTabController>()
                                      .showQuatationDate(context);
                                },
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
                                              .watch<LeadTabController>()
                                              .getQuataDate,
                                          // context.read<LeadTabController>().getnextFD,
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
                        ],
                      ),

                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      TextFormField(
                        controller:
                            context.read<LeadTabController>().mycontroller[4],
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
                            hintText: "Quatation Value",
                            hintStyle: theme.textTheme.bodyText2?.copyWith(
                              color: context
                                      .read<LeadTabController>()
                                      .gettextquatationValue!
                                      .contains(" *")
                                  ? Colors.red
                                  : Colors.black,
                              // fontSize: 14
                            ),
                            // TextStyle(
                            //     color: context
                            //             .read<LeadTabController>()
                            //             .getorderBillRefer!
                            //             .contains(" *")
                            //         ? Colors.red
                            //         : Colors.black),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10)),
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
                    context.read<LeadTabController>().convertToQuatatioMethod();
                    // if (LeadTabController.comeFromEnq == -1) {
                    //   context.read<LeadTabController>().clickLeadSaveBtn(
                    //       context
                    //           .read<LeadTabController>()
                    //           .getAllLeadData[widget.index]
                    //           .FollowupEntry
                    //           .toString(),
                    //       context
                    //           .read<LeadTabController>()
                    //           .getAllLeadData[widget.index]
                    //           .LeadDocEntry
                    //           .toString());
                    // } else {
                    //   context.read<LeadTabController>().clickLeadSaveBtn(
                    //       context
                    //           .read<LeadTabController>()
                    //           .leadDeatilsLData[0]
                    //           .FollowupEntry
                    //           .toString(),
                    //       LeadTabController.comeFromEnq.toString());
                    // }
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
                  child: Text("Convert To Quatation")),
            ),
          ],
        ),
      ),
    );
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
                  context.read<LeadTabController>().makePhoneCall(widget.leadopenalldata
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
                // Container(
                //   // padding: EdgeInsets.symmetric(
                //   //   horizontal: Screens.bodyheight(context)*0.04
                //   // ),
                //   width: Screens.width(context),
                //   height: Screens.bodyheight(context) * 0.07,
                //   child: ElevatedButton(
                //       onPressed: () {
                //         // context.read<LeadTabController>().showMsgDialog();
                //         context.read<LeadTabController>().makePhoneCall(
                //             widget.provi.getAllLeadData[widget.index].Mobile!);
                //       },
                //       style: ElevatedButton.styleFrom(
                //         // shape: BeveledRectangleBorder(
                //         // borderRadius: BorderRadius.all(Radius.circular(5))),
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.all(Radius.circular(6))),
                //       ),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //         children: [
                //           Container(),
                //           Container(
                //             width: Screens.width(context) * 0.1,
                //             height: Screens.bodyheight(context) * 0.05,
                //             decoration: BoxDecoration(
                //                 shape: BoxShape.circle,
                //                 border: Border.all(color: Colors.white)),
                //             child: Icon(
                //               Icons.call,
                //               size: Screens.bodyheight(context) * 0.02,
                //             ),
                //           ),
                //           Container(child: Text("Click to Call")),
                //           Container(),
                //         ],
                //       )),
                // ),
                // SizedBox(
                //   height: Screens.bodyheight(context) * 0.03,
                // ),
                InkWell(
                  onTap: () {
                    setState(() {
                      context.read<LeadTabController>().changetoFolloweUp();
                    });
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
                            context
                                .read<LeadTabController>()
                                .caseStatusSelectBtn("Won", "02");
                            context
                                .read<LeadTabController>()
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
                            context
                                .read<LeadTabController>()
                                .caseStatusSelectBtn("Lost", "03");
                            context
                                .read<LeadTabController>()
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
                            setState(() {
                              context
                                  .read<LeadTabController>()
                                  .forwardClicked();
                            });
                          },
                          child: Text("Forward")),
                    )
                  ],
                ),
                
               
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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

                        context
                            .read<LeadTabController>()
                            .mapValuestoorder(widget.leadopenalldata);
                      },
                      child: Text("Convert to Order")),
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

                            context
                                .read<LeadTabController>()
                                .mapValuestoquotes(widget.leadopenalldata);
                          },
                          child: Text("Convert to Quotation")),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Container(
          //   width: Screens.width(context),
          //   height: Screens.bodyheight(context) * 0.06,
          //   decoration: BoxDecoration(
          //       border: Border.all(
          //     color: theme.primaryColor,
          //     width: 1.0,
          //     //  style : BorderStyle.,
          //   )),
          //   child: ElevatedButton(
          //       onPressed: () {
          //         // if (LeadTabController.comeFromEnq == -1) {
          //         //   context.read<LeadTabController>().callGetLeadDeatilsApi(
          //         context.read<LeadTabController>().converToQuatation();
          //         // } else {
          //         //   //   Navigator.pop(context);
          //         //   //       context.read<LeadTabController>().comeFromEnqApi(
          //         //   //  context,LeadTabController.comeFromEnq.toString());
          //         //   context.read<LeadTabController>().viweDetailsClicked();
          //         // }
          //       },
          //       style: ElevatedButton.styleFrom(
          //         shape: RoundedRectangleBorder(
          //           borderRadius:
          //               BorderRadius.zero, // Set to zero for square corners
          //         ),
          //       ),
          //       child: Text("Convert to Quatation")),
          // ),
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {
                  if (LeadTabController.comeFromEnq == -1) {
                    context.read<LeadTabController>().callGetLeadDeatilsApi(
                       widget. leadopenalldata
                            .LeadDocEntry
                            .toString());
                  } else {
                    //   Navigator.pop(context);
                    //       context.read<LeadTabController>().comeFromEnqApi(
                    //  context,LeadTabController.comeFromEnq.toString());
                    context.read<LeadTabController>().viweDetailsClicked();
                  }
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
            alignment: Alignment.topCenter,
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.77,
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${context.watch<LeadTabController>().getleadDeatilsQTHData![0].CardName}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      context
                                      .watch<LeadTabController>()
                                      .getleadDeatilsQTHData![0]
                                      .LeadCreatedDate ==
                                  null ||
                              context
                                      .watch<LeadTabController>()
                                      .getleadDeatilsQTHData![0]
                                      .LeadCreatedDate ==
                                  "null" ||
                              context
                                  .watch<LeadTabController>()
                                  .getleadDeatilsQTHData![0]
                                  .LeadCreatedDate!
                                  .isEmpty
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
                                          .read<LeadTabController>()
                                          .config
                                          .subtractDateTime2(
                                              // "2020-05-18T00:00:00"
                                              "${context.watch<LeadTabController>().getleadDeatilsQTHData![0].LeadCreatedDate}"),
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
                  context
                                      .watch<LeadTabController>()
                                      .getleadDeatilsQTHData![0]
                                      .Address1 ==
                                  null ||
                              context
                                      .watch<LeadTabController>()
                                      .getleadDeatilsQTHData![0]
                                      .Address1 ==
                                  "null" ||
                              context
                                  .watch<LeadTabController>()
                                  .getleadDeatilsQTHData![0]
                                  .Address1!
                                  .isEmpty
                          ? Container()
                          :      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${context.watch<LeadTabController>().getleadDeatilsQTHData![0].Address1}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.43,
                        child: Text(
                          "Worth of Rs." +
                              context
                                  .watch<LeadTabController>()
                                  .config
                                  .slpitCurrency22(
                                    "${context.watch<LeadTabController>().getleadDeatilsQTHData![0].DocTotal!.toString()}",
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
                   context
                                      .watch<LeadTabController>()
                                      .getleadDeatilsQTHData![0]
                                      .Address2 ==
                                  null ||
                              context
                                      .watch<LeadTabController>()
                                      .getleadDeatilsQTHData![0]
                                      .Address2 ==
                                  "null" ||
                              context
                                  .watch<LeadTabController>()
                                  .getleadDeatilsQTHData![0]
                                  .Address2!
                                  .isEmpty
                          ? Container()
                          :   Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${context.watch<LeadTabController>().getleadDeatilsQTHData![0].Address2}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "# ${context.watch<LeadTabController>().getleadDeatilsQTHData![0].LeadNum}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     context
                                      .watch<LeadTabController>()
                                      .getleadDeatilsQTHData![0]
                                      .City ==
                                  null ||
                              context
                                      .watch<LeadTabController>()
                                      .getleadDeatilsQTHData![0]
                                      .City ==
                                  "null" ||
                              context
                                  .watch<LeadTabController>()
                                  .getleadDeatilsQTHData![0]
                                  .City!
                                  .isEmpty
                          ? Container()
                          :   Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "${context.watch<LeadTabController>().getleadDeatilsQTHData![0].City}",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "Created on " +
                              context.watch<LeadTabController>().config.alignDate3(
                                  "${context.watch<LeadTabController>().getleadDeatilsQTHData![0].LeadCreatedDate}" //.LastFUPUpdate
                                  ),
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     context
                                      .watch<LeadTabController>()
                                      .getleadDeatilsQTHData![0]
                                      .CardCode ==
                                  null ||
                              context
                                      .watch<LeadTabController>()
                                      .getleadDeatilsQTHData![0]
                                      .CardCode ==
                                  "null" ||
                              context
                                  .watch<LeadTabController>()
                                  .getleadDeatilsQTHData![0]
                                  .CardCode!
                                  .isEmpty
                          ? Container()
                          :  InkWell(
                            onTap: () {
                  context.read<LeadTabController>().makePhoneCall(context
                      .read<LeadTabController>()
                      .getleadDeatilsQTHData![0].CardCode!);
                },
                            child: Container(
                                                  width: Screens.width(context) * 0.35,
                                                  child: Text(
                            "${context.watch<LeadTabController>().getleadDeatilsQTHData![0].CardCode}",
                            style: theme.textTheme.bodyText2?.copyWith(decoration:  TextDecoration.underline,color:Colors.blue),
                                                  ),
                                                ),
                          ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.50,
                        child: Text(
                          "Last Updated on " +
                              context.watch<LeadTabController>().config.alignDate3(
                                  "${context.watch<LeadTabController>().getleadDeatilsQTHData![0].LastFUPUpdate}" //.
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
                              child: context
                                          .watch<LeadTabController>()
                                          .getleadDeatilsQTHData![0]
                                          .nextFollowupDate!
                                          .isNotEmpty ||
                                      context
                                              .watch<LeadTabController>()
                                              .getleadDeatilsQTHData![0]
                                              .nextFollowupDate !=
                                          null ||
                                      context
                                              .watch<LeadTabController>()
                                              .getleadDeatilsQTHData![0]
                                              .nextFollowupDate !=
                                          "null"
                                  ? Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Next Follow up # ' +
                                            context
                                                .watch<LeadTabController>()
                                                .config
                                                .alignDate(
                                                    '${context.watch<LeadTabController>().getleadDeatilsQTHData![0].nextFollowupDate}'),
                                        textAlign: TextAlign.center,
                                        style:
                                            theme.textTheme.bodyText2?.copyWith(
                                          color: theme.primaryColor,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Next Follow up # ',
                                        // context
                                        //     .watch<LeadTabController>()
                                        //     .config
                                        //     .alignDate(
                                        //         '${context.watch<LeadTabController>().getleadDeatilsQTHData![0].nextFollowupDate}'),
                                        textAlign: TextAlign.center,
                                        style:
                                            theme.textTheme.bodyText2?.copyWith(
                                          color: theme.primaryColor,
                                        ),
                                      ),
                                    )),
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
                              'Last status # ${context.watch<LeadTabController>().getleadDeatilsLeadData[context.watch<LeadTabController>().getleadDeatilsLeadData.length - 1].Status}',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyText2?.copyWith(
                                color: theme.primaryColor,
                              ),
                            ),
                          )
                              // :Container(
                              //   alignment: Alignment.center,
                              //   child: Text(
                              //     'Last status # ',
                              //     // ${context.watch<LeadTabController>().getleadDeatilsLeadData[context.watch<LeadTabController>().getleadDeatilsLeadData.length - 1].Status}',
                              //     textAlign: TextAlign.center,
                              //     style: theme.textTheme.bodyText2?.copyWith(
                              //       color: theme.primaryColor,
                              //     ),
                              //   ),
                              // ),
                              )
                        ],
                      )),
                  // Container(
                  //     width: Screens.width(context),
                  //     // height: Screens.bodyheight(context) * 0.16,
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: Screens.width(context) * 0.03,
                  //         vertical: Screens.bodyheight(context) * 0.02),
                  //     decoration: BoxDecoration(
                  //         color: theme.primaryColor.withOpacity(0.05),
                  //         borderRadius: BorderRadius.circular(8),
                  //         border: Border.all(color: Colors.black26)),
                  //     child: Center(
                  //       child: Container(
                  //         alignment: Alignment.center,
                  //         child: Text(
                  //           'Last status # ${context.watch<LeadTabController>().getleadDeatilsQLData[context.watch<LeadTabController>().getleadDeatilsQLData.length - 1].Status}',
                  //           textAlign: TextAlign.center,
                  //           style: theme.textTheme.bodyText2?.copyWith(
                  //             color: theme.primaryColor,
                  //           ),
                  //         ),
                  //       ),
                  //     )),

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
                  Wrap(
                      spacing: 0.0, // width
                      runSpacing: 0.0, // height
                      children: listTimeLine(theme)),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),

                  //                 Timeline.tileBuilder(
                  //   builder: TimelineTileBuilder.fromStyle(
                  //     contentsAlign: ContentsAlign.alternating,
                  //     contentsBuilder: (context, index) => Padding(
                  //       padding: const EdgeInsets.all(24.0),
                  //       child: Text('Timeline Event $index'),
                  //     ),
                  //     itemCount: 10,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
                onPressed: () {
                  context.read<LeadTabController>().viweDetailsClicked();
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

  ///
  //view details enq

  Container detailsDialogLead(BuildContext context, ThemeData theme) {
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
                          "Customer",
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
                            "${context.watch<LeadTabController>().getleadDeatilsQTHData![0].CardName}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              // fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        width: Screens.width(context) * 0.4,
                        alignment: Alignment.centerRight,
                        child: Text("",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  context
                              .watch<LeadTabController>()
                              .getleadDeatilsQTHData![0]
                              .Address1!
                              .isNotEmpty ||
                          context
                              .watch<LeadTabController>()
                              .getleadDeatilsQTHData![0]
                              .Address1!
                              .isNotEmpty
                      ? Container(
                          width: Screens.width(context),
                          child: Text(
                            "${context.watch<LeadTabController>().getleadDeatilsQTHData![0].Address1}\n${context.watch<LeadTabController>().getleadDeatilsQTHData![0].Address2}",
                            //"31 west street \nkottucherry \nkaraikal 609-609 \npondicherry",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                            ), // color:  Colors.grey
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: context
                            .watch<LeadTabController>()
                            .getleadDeatilsQTHData![0]
                            .Address1!
                            .isEmpty
                        ? 0.0
                        : Screens.bodyheight(context) * 0.01,
                  ),
                  createTable(theme),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "Total Lead Value",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "20000.00",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "Next Follow up",
                          style: theme.textTheme.bodyText2?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                          "12-08-2022",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Wrap(
                      spacing: 0.0, // width
                      runSpacing: 0.0, // height
                      children: listTimeLine(theme)),
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
                  context.read<LeadTabController>().mapValuesToLead(context);
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
                child: Text("Create New Lead")),
          ),
        ],
      ),
    );
  }

  ///

  Widget createTable(ThemeData theme) {
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
        i < context.watch<LeadTabController>().getleadDeatilsQTLData.length;
        ++i) {
      rows.add(TableRow(children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<LeadTabController>().getleadDeatilsQTLData[i].ItemName!}',
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            context.watch<LeadTabController>().config.slpitCurrency(context
                .watch<LeadTabController>()
                .getleadDeatilsQTLData[i]
                .Price!
                .toStringAsFixed(0)),
            // '${context.watch<LeadTabController>().getleadDeatilsQTLData[i].Price!.toStringAsFixed(2)}',
            textAlign: TextAlign.left,
            style: theme.textTheme.bodyText1?.copyWith(
              color: theme.primaryColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            '${context.watch<LeadTabController>().getleadDeatilsQTLData[i].Quantity!.toStringAsFixed(0)}',
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

//
  List<Widget> listTimeLine(ThemeData theme) {
    return List.generate(
        context.read<LeadTabController>().getleadDeatilsLeadData.length,
        (index) {
      if (index == 0) {
        log("1");
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
                  iconData: context
                              .read<LeadTabController>()
                              .getleadDeatilsLeadData[index]
                              .FollowMode ==
                          'Phone Call'
                      ? Icons.call
                      : context
                                  .read<LeadTabController>()
                                  .getleadDeatilsLeadData[index]
                                  .FollowMode ==
                              'Sms/WhatsApp'
                          ? Icons.message
                          : context
                                      .read<LeadTabController>()
                                      .getleadDeatilsLeadData[index]
                                      .FollowMode ==
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
                        "${context.read<LeadTabController>().getleadDeatilsLeadData[index].Status} ",
                        style: theme.textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        // context.read<LeadTabController>().config.alignDate(
                        "By ${context.read<LeadTabController>().getleadDeatilsLeadData[index].UpdatedBy} through ${context.read<LeadTabController>().getleadDeatilsLeadData[index].FollowMode == null || context.read<LeadTabController>().getleadDeatilsLeadData[index].FollowMode == "null" || context.read<LeadTabController>().getleadDeatilsLeadData[index].FollowMode!.isEmpty ? "" : context.read<LeadTabController>().getleadDeatilsLeadData[index].FollowMode}", //),
                        style: theme.textTheme.bodyText2?.copyWith(
                            // color: theme.primaryColor,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.02,
                    ),
                    context
                            .watch<LeadTabController>()
                            .getleadDeatilsLeadData[index]
                            .Feedback!
                            .isEmpty
                        ? SizedBox()
                        : Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              // context.read<LeadTabController>().config.alignDate(
                              "# ${context.read<LeadTabController>().getleadDeatilsLeadData[index].Feedback}",
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
                        context.read<LeadTabController>().config.alignDate2(
                              "${context.read<LeadTabController>().getleadDeatilsLeadData[index].Followup_Date_Time}",
                            ),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText2,
                      ),
                    ],
                  )),
            ),
          ],
        );
      } else if (index ==
          context.read<LeadTabController>().getleadDeatilsLeadData.length - 1) {
        log("2");
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
                  iconData: context
                              .read<LeadTabController>()
                              .getleadDeatilsLeadData[index]
                              .FollowMode ==
                          'Phone Call'
                      ? Icons.call
                      : context
                                  .read<LeadTabController>()
                                  .getleadDeatilsLeadData[index]
                                  .FollowMode ==
                              'Sms/WhatsApp'
                          ? Icons.message
                          : context
                                      .read<LeadTabController>()
                                      .getleadDeatilsLeadData[index]
                                      .FollowMode ==
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
                        "${context.read<LeadTabController>().getleadDeatilsLeadData[index].Status} ",
                        style: theme.textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        // context.read<LeadTabController>().config.alignDate(
                        "By ${context.read<LeadTabController>().getleadDeatilsLeadData[index].UpdatedBy} through ${context.read<LeadTabController>().getleadDeatilsLeadData[index].FollowMode}", //),
                        style: theme.textTheme.bodyText2?.copyWith(
                            // color: theme.primaryColor,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    context
                            .watch<LeadTabController>()
                            .getleadDeatilsLeadData[index]
                            .Feedback!
                            .isEmpty
                        ? SizedBox()
                        : Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              // context.read<LeadTabController>().config.alignDate(
                              "# ${context.read<LeadTabController>().getleadDeatilsLeadData[index].Feedback}",
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
                        context.read<LeadTabController>().config.alignDate2(
                              "${context.read<LeadTabController>().getleadDeatilsLeadData[index].Followup_Date_Time}",
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
        log("3");
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
                  iconData: context
                              .read<LeadTabController>()
                              .getleadDeatilsLeadData[index]
                              .FollowMode ==
                          'Phone Call'
                      ? Icons.call
                      : context
                                  .read<LeadTabController>()
                                  .getleadDeatilsLeadData[index]
                                  .FollowMode ==
                              'Sms/WhatsApp'
                          ? Icons.message
                          : context
                                      .read<LeadTabController>()
                                      .getleadDeatilsLeadData[index]
                                      .FollowMode ==
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
                        "${context.read<LeadTabController>().getleadDeatilsLeadData[index].Status} ",
                        style: theme.textTheme.bodyText2,
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        // context.read<LeadTabController>().config.alignDate(
                        "By ${context.read<LeadTabController>().getleadDeatilsLeadData[index].UpdatedBy} through ${context.read<LeadTabController>().getleadDeatilsLeadData[index].FollowMode}", //),
                        style: theme.textTheme.bodyText2?.copyWith(
                            // color: theme.primaryColor,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    context
                            .watch<LeadTabController>()
                            .getleadDeatilsLeadData[index]
                            .Feedback!
                            .isEmpty
                        ? SizedBox()
                        : Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              // context.read<LeadTabController>().config.alignDate(
                              "# ${context.read<LeadTabController>().getleadDeatilsLeadData[index].Feedback}",
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
                        context.read<LeadTabController>().config.alignDate2(
                              "${context.read<LeadTabController>().getleadDeatilsLeadData[index].Followup_Date_Time}",
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
//phonecallApi

  List<Widget> listContainersCustomerTag(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<LeadTabController>().getleadphonedata.length,
      (index) => InkWell(
        onTap: () {
          // context.read<LeadNewController>(). isSelectedenquirytype = context.read<LeadNewController>()
          // .getenqReffList[index].Name.toString();
          context.read<LeadTabController>().selectFollowUp(
              context
                  .read<LeadTabController>()
                  .getleadphonedata[index]
                  .name
                  .toString(),
              context
                  .read<LeadTabController>()
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
              color:
                  context.watch<LeadTabController>().isSelectedFollowUpcode ==
                          context
                              .read<LeadTabController>()
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
                      .watch<LeadTabController>()
                      .getleadphonedata[index]
                      .name
                      .toString(),
                  maxLines: 8,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 13,
                    color: context
                                .watch<LeadTabController>()
                                .isSelectedFollowUpcode ==
                            context
                                .read<LeadTabController>()
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

  //openApi
  List<Widget> listContainersOpenTag(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<LeadTabController>().getleadopendata.length,
      (index) => InkWell(
        onTap: () {
          // context.read<LeadNewController>(). isSelectedenquirytype = context.read<LeadNewController>()
          // .getenqReffList[index].Name.toString();

          context.read<LeadTabController>().caseStatusSelectBtn(
              context
                  .read<LeadTabController>()
                  .getleadopendata[index]
                  .name
                  .toString(),
              context
                  .read<LeadTabController>()
                  .getleadopendata[index]
                  .code
                  .toString());
          context.read<LeadTabController>().validatebtnChanged();
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
              color: context.watch<LeadTabController>().getcaseStatusSelected ==
                      context
                          .read<LeadTabController>()
                          .getleadopendata[index]
                          .name
                          .toString()
                  ? Color(0xffFCF752) //theme.primaryColor.withOpacity(0.5)
                  : theme.primaryColor,
              border: Border.all(
                color: theme.primaryColor,
              ),
              borderRadius: BorderRadius.circular(4)),
          child: Text(
              context
                  .watch<LeadTabController>()
                  .getleadopendata[index]
                  .name
                  .toString(),
              maxLines: 8,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 13,
                color:
                    context.watch<LeadTabController>().getcaseStatusSelected ==
                            context
                                .read<LeadTabController>()
                                .getleadopendata[index]
                                .name
                                .toString()
                        ? Colors.black //,Colors.white
                        : Colors.white,
              )),

          // ElevatedButton(
          //                       style: ElevatedButton.styleFrom(
          //                         primary: context
          //                                     .watch<LeadTabController>()
          //                                     .getcaseStatusSelected ==
          //                                 'Open'
          //                             ? Color(0xffFCF752)
          //                             : theme.primaryColor,
          //                         textStyle: TextStyle(
          //                             color: context
          //                                         .read<LeadTabController>()
          //                                         .getcaseStatusSelected ==
          //                                     'Open'
          //                                 ? Colors.black
          //                                 : Colors.white),
          //                         shape: RoundedRectangleBorder(
          //                             borderRadius:
          //                                 BorderRadius.all(Radius.circular(6))),
          //                       ),
          //                       onPressed: () {
          //                         // setState(() {

          //                         //   });
          //                       },
          //                       child: Text(
          //                          context
          //                 .read<LeadTabController>()
          //                 .getleadopendata[index]
          //                 .name
          //                 .toString(),
          //                         style: TextStyle(
          //                             color: context
          //                                         .watch<LeadTabController>()
          //                                         .getcaseStatusSelected ==
          //                                     'Open'
          //                                 ? Colors.black
          //                                 : Colors.white),
          //                       )),
        ),
      ),
    );
  }
  //forwar dialog

  Container forwardDialog(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      //  height: Screens.bodyheight(context)*0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.only(
        left: Screens.width(context) * 0.05,
        right: Screens.width(context) * 0.05,
        top: Screens.bodyheight(context) * 0.03,
        bottom: Screens.bodyheight(context) * 0.03,
      ),
      //  height: Screens.bodyheight(context) * 0.4,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            //  Expanded(
            //        child: ListView.builder(
            //          itemCount: 1,
            //          itemBuilder: (BuildContext context, int index) {
            //            return
            //             Wrap(
            //           spacing: 10.0, // gap between adjacent chips
            //           runSpacing: 10.0, // gap between lines
            //           children:
            //               listContainersProduct(theme,
            //                ));
            //          },
            //        ),
            //  ),
            Container(
              height: Screens.bodyheight(context) * 0.05,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius:
                    BorderRadius.circular(Screens.width(context) * 0.01),
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
                  context.read<LeadTabController>().filterListAssignData(v);
                  context.read<LeadTabController>().setForwardDataList();

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
            SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
            Container(
              height: Screens.bodyheight(context) * 0.5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Wrap(
                        spacing: 5.0, // gap between adjacent chips
                        runSpacing: 5.0, // gap between lines
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
                  context
                      .watch<LeadTabController>()
                      .getforwardNextFollowDate!, // "Next Follow up",
                  style: theme.textTheme.bodyText2?.copyWith(
                    color: context
                            .watch<LeadTabController>()
                            .getforwardNextFollowDate!
                            .contains(" *")
                        ? Colors.red
                        : Colors.grey,
                  ), // fontSize: 12
                )),
                InkWell(
                  onTap: () {
                    context
                        .read<LeadTabController>()
                        .showForwardNextDate(context);
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
                            context
                                .watch<LeadTabController>()
                                .getforwardnextWonFD,
                            // context.read<LeadTabController>().getnextFD,
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
                      .read<LeadTabController>()
                      .assignVisitTime!, // "Next Follow up",
                  style: theme.textTheme.bodyText2?.copyWith(
                    color: context
                            .read<LeadTabController>()
                            .assignVisitTime!
                            .contains(" *")
                        ? Colors.red
                        : Colors.grey,
                  ), // fontSize: 12
                )),
                InkWell(
                  onTap: () {
                    setState(() {
                      context
                          .read<LeadTabController>()
                          .forwardVisitTime(context);
                    });
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
                            context.watch<LeadTabController>().forwaVisitTime,
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
                                                .read<LeadTabController>()
                                                .   iscorectime2==false &&context
                                                .read<LeadTabController>()
                                                .forwarderrorVisitTime=='' ?Container(): Container(
                              alignment: Alignment.centerRight,
                              child: Text("${context
                                                .read<LeadTabController>()
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
                        setState(() {
                          context.read<LeadTabController>().forwardClicked();
                        });
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
                                .read<LeadTabController>()
                                .selectedUserList
                                .isNotEmpty &&
                            context
                                .read<LeadTabController>()
                                .forwaVisitTime
                                .isNotEmpty &&
                            context
                                .read<LeadTabController>()
                                .forwardNextFollowDate!
                                .isNotEmpty) {
                          context.read<LeadTabController>().Allfollowupupdate(
                              "",
                              widget.leadopenalldata
                                  .LeadDocEntry
                                  .toString(),
                              "",
                              "",
                              "",
                              "",
                              context
                                  .read<LeadTabController>()
                                  .selectedUserList,
                            widget.  leadopenalldata
                                  .LastUpdateMessage
                                  .toString(),'');
                        } else {
                          setState(() {
                            if(context
                                .read<LeadTabController>()
                                .selectedUserList
                                .isEmpty){
                                context.read<LeadTabController>().  showtoastforall();
                                }
                            if( context
                                .read<LeadTabController>()
                                .forwaVisitTime
                                .isEmpty 
                           ){
context.read<LeadTabController>().assignVisitTime =
                                "Followup Time: *";
                            
                                }if( context
                                .read<LeadTabController>()
                                .getforwardnextWonFD!
                                .isEmpty){
context
                                .read<LeadTabController>()
                                .forwardNextFollowDate = "Next Followup: *";
                                }
                            
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

  List<Widget> listContainersProduct(ThemeData theme) {
    return List.generate(
      context.watch<LeadTabController>().filteruserLtData.length,
      (ind) => GestureDetector(
        onTap: () {
          context.read<LeadTabController>().getSelectedUserSalesEmpId(ind);
        },
        child: Container(
          width: Screens.width(context) * 0.4,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: context
                          .watch<LeadTabController>()
                          .filteruserLtData[ind]
                          .color ==
                      1
                  ? theme.primaryColor
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: Text(
              context
                  .watch<LeadTabController>()
                  .filteruserLtData[ind]
                  .UserName!,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: context
                            .watch<LeadTabController>()
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
}
