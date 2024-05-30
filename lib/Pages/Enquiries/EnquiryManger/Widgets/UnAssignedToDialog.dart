// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/EnquiryController/EnquiryMngController.dart';


class UnAssignedToDialogManager extends StatefulWidget {
  UnAssignedToDialogManager({Key? key, required this.i}) : super(key: key);
  final int i;
  @override
  State<UnAssignedToDialogManager> createState() => UnAssignedToDialogUserState();
}

class UnAssignedToDialogUserState extends State<UnAssignedToDialogManager> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: context.read<EnquiryMangerContoller>().getassignto == false &&
              context.read<EnquiryMangerContoller>().getassigntoApiCall ==
                  false &&
              context.read<EnquiryMangerContoller>().getassignedToApiActResp ==
                  '' &&
              context.read<EnquiryMangerContoller>().getstatusUpdate == false &&
              context.read<EnquiryMangerContoller>().getstatusUpdateLoading ==
                  false &&
              context.read<EnquiryMangerContoller>().getstatusUpdateApiResp ==
                  '' &&
              context.read<EnquiryMangerContoller>().getisAnotherBranchEnq ==
                  false

          ///
          ? enqDetailsPage(context, theme)
          : context.read<EnquiryMangerContoller>().getassignto == false &&
                  context.read<EnquiryMangerContoller>().getassigntoApiCall ==
                      false &&
                  context.read<EnquiryMangerContoller>().getassignedToApiActResp ==
                      '' &&
                  context.read<EnquiryMangerContoller>().getstatusUpdate ==
                      false &&
                  context.read<EnquiryMangerContoller>().getstatusUpdateLoading ==
                      false &&
                  context.read<EnquiryMangerContoller>().getstatusUpdateApiResp ==
                      '' &&
                  context.read<EnquiryMangerContoller>().getisAnotherBranchEnq ==
                      true

              ///
              ? enqDetailsToOtherBranch(context, theme)
              : context.read<EnquiryMangerContoller>().getassignto == true &&
                      context.read<EnquiryMangerContoller>().getassigntoApiCall ==
                          false &&
                      context.read<EnquiryMangerContoller>().getassignedToApiActResp ==
                          '' &&
                      context.read<EnquiryMangerContoller>().getstatusUpdate ==
                          false &&
                      context.read<EnquiryMangerContoller>().getstatusUpdateLoading ==
                          false &&
                      context.read<EnquiryMangerContoller>().getstatusUpdateApiResp ==
                          '' &&
                      context.read<EnquiryMangerContoller>().getisAnotherBranchEnq ==
                          false
                  ? assignedTOPage(context, theme)
                  : context.read<EnquiryMangerContoller>().getassignto == true &&
                          context.read<EnquiryMangerContoller>().getassigntoApiCall ==
                              true &&
                          context.read<EnquiryMangerContoller>().getassignedToApiActResp ==
                              '' &&
                          context.read<EnquiryMangerContoller>().getstatusUpdate ==
                              false &&
                          context.read<EnquiryMangerContoller>().getstatusUpdateLoading ==
                              false &&
                          context.read<EnquiryMangerContoller>().getstatusUpdateApiResp ==
                              '' &&
                          context.read<EnquiryMangerContoller>().getisAnotherBranchEnq ==
                              false
                      ? LoadingPage(context)
                      : context.read<EnquiryMangerContoller>().getassignto == true &&
                              context.read<EnquiryMangerContoller>().getassigntoApiCall ==
                                  false &&
                              context.read<EnquiryMangerContoller>().getassignedToApiActResp != '' &&
                              context.read<EnquiryMangerContoller>().getstatusUpdate == false &&
                              context.read<EnquiryMangerContoller>().getstatusUpdateLoading == false &&
                              context.read<EnquiryMangerContoller>().getstatusUpdateApiResp == '' &&
                              context.read<EnquiryMangerContoller>().getisAnotherBranchEnq == false
                          ? assignedToApiRespPage(context, theme)
                          : context.read<EnquiryMangerContoller>().getassignto == false && context.read<EnquiryMangerContoller>().getassigntoApiCall == false && context.read<EnquiryMangerContoller>().getassignedToApiActResp == '' && context.read<EnquiryMangerContoller>().getstatusUpdate == true && context.read<EnquiryMangerContoller>().getstatusUpdateLoading == false && context.read<EnquiryMangerContoller>().getstatusUpdateApiResp == '' && context.read<EnquiryMangerContoller>().getisAnotherBranchEnq == false
                              ? statusRespPage(context, theme)
                              : //

                              context.read<EnquiryMangerContoller>().getassignto == false && 
                              context.read<EnquiryMangerContoller>().getassigntoApiCall == false 
                              && context.read<EnquiryMangerContoller>().getassignedToApiActResp == ''
                              && context.read<EnquiryMangerContoller>().getstatusUpdate == true && 
                              context.read<EnquiryMangerContoller>().getstatusUpdateLoading == false 
                              && context.read<EnquiryMangerContoller>().getstatusUpdateApiResp != '' 
                              && context.read<EnquiryMangerContoller>().getisAnotherBranchEnq == false
                                  ? statusUpdateApiRespPage(context, theme)
                                  : LoadingPage(context),
    );
  }

  Row assignedToPageBtn(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              if (context.read<EnquiryMangerContoller>().assignto == false) {
                context.read<EnquiryMangerContoller>().assignto = true;
              } else {
                context.read<EnquiryMangerContoller>().assignto = false;
              }
            });
          },
          child: Text(
            "Back",
            style: theme.textTheme.bodyText1?.copyWith(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(theme.primaryColor)),
        ),
        TextButton(
          onPressed: context.watch<EnquiryMangerContoller>().getUserKey == null
              ? null
              : () {
                  if (context.read<EnquiryMangerContoller>().getUserKey == null) {
                  } else {
                    context.read<EnquiryMangerContoller>().callAsignedToApi(
                        // "1000","1000",context
                        context
                            .read<EnquiryMangerContoller>()
                            .getunassignedEnqdata[widget.i] 
                            ,
                        context
                            .read<EnquiryMangerContoller>()
                            .getuserLtData[context
                                .read<EnquiryMangerContoller>()
                                .selectedIdxFUser!]
                          .SalesEmpID//  .UserKey
                            .toString(),'open',
                        context);

                    print(context
                        .read<EnquiryMangerContoller>()
                        .getunassignedEnqdata[widget.i]
                        .EnqID
                        .toString());
                    print(context
                        .read<EnquiryMangerContoller>()
                        .getuserLtData[context
                            .read<EnquiryMangerContoller>()
                            .selectedIdxFUser!]
                      .SalesEmpID//  .UserKey
                        .toString());
                  }
                },
          child: Text(
            "Forward to",
            style: theme.textTheme.bodyText1?.copyWith(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(theme.primaryColor)),
        )
      ],
    );
  }

  Container statusUpdateApiRespPage(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                    // fontSize: 12,
                    ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )), //Radius.circular(6)
              ),
              child: Text(
                "Alert",
                style: theme.textTheme.bodyText1?.copyWith(color: Colors.white),
              ),
            ),
          ),
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.2,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context
                        .watch<EnquiryMangerContoller>()
                        .getstatusUpdateApiResp,
                    style: context
                            .watch<EnquiryMangerContoller>()
                            .getstatusUpdateApiResp
                            .contains("Success")
                        ? theme.textTheme.headline6
                            ?.copyWith(color: Colors.green)
                        : theme.textTheme.headline6
                            ?.copyWith(color: Colors.red),
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.02,
                  ),
                  Text(
                    context
                        .watch<EnquiryMangerContoller>()
                        .getstatusUpdateApiRespMsg,
                    style: theme.textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Ok",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              theme.primaryColor)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container statusRespPage(BuildContext context, ThemeData theme) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
              onPressed: () {
                // context.read<LeadTabController>().viweDetailsClicked();
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                    // fontSize: 12,
                    ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )), //Radius.circular(6)
              ),
              child: Text(
                "Status Update",
              ),
            ),
          ),
          Container(
            width: Screens.width(context),
            // height: Screens.bodyheight(context) * 0.4,
            padding: EdgeInsets.only(
              left: Screens.width(context) * 0.02,
              right: Screens.width(context) * 0.02,
              top: Screens.bodyheight(context) * 0.03,
              bottom: Screens.bodyheight(context) * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text(
                //   "Status Update",
                //   style: theme.textTheme.bodyText1,
                // ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Wrap(
                    spacing: 5.0, // gap between adjacent chips
                    runSpacing: 5.0, // gap between lines
                    children: listContainersReson(
                      theme,
                    )),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (context
                                  .read<EnquiryMangerContoller>()
                                  .statusUpdate ==
                              false) {
                            context.read<EnquiryMangerContoller>().statusUpdate =
                                true;
                          } else {
                            context.read<EnquiryMangerContoller>().statusUpdate =
                                false;
                          }
                        });
                      },
                      child: Text(
                        "Back",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              theme.primaryColor)),
                    ),
                    TextButton(
                      onPressed: () {
                        if (context
                                    .read<EnquiryMangerContoller>()
                                    .valueChosedReason !=
                                null
                            // context.read<EnquiryMangerContoller>().mycontroller[0].text.isNotEmpty
                            ) {
                          // context.read<EnquiryMangerContoller>().callUpdateEnqApi(
                          //     context,
                          //     context
                          //         .read<EnquiryMangerContoller>()
                          //         .getunassignedEnqdata[widget.i]
                          //        );
                        } else {
                          print("reason value: " +
                              context
                                  .read<EnquiryMangerContoller>()
                                  .valueChosedReason
                                  .toString());
                        }
                      },
                      child: Text(
                        "Update",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              theme.primaryColor)),
                    )
                  ],
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
                context.read<EnquiryMangerContoller>().mapValuesToLead(widget.i);
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
                "Convert to lead",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container assignedToApiRespPage(BuildContext context, ThemeData theme) {
    return Container(
      width: Screens.width(context) * 0.9,
      height: Screens.bodyheight(context) * 0.3,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.watch<EnquiryMangerContoller>().getassignedToApiActResp,
              style: context
                      .watch<EnquiryMangerContoller>()
                      .getassignedToApiActResp
                      .contains("Success")
                  ? theme.textTheme.headline6?.copyWith(color: Colors.green)
                  : theme.textTheme.headline6?.copyWith(color: Colors.red),
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.02,
            ),
            Text(
              context.watch<EnquiryMangerContoller>().getassignedToApiActRespMsg,
              style: theme.textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }

  Container LoadingPage(BuildContext context) {
    return Container(
        width: Screens.width(context) * 0.9,
        height: Screens.bodyheight(context) * 0.3,
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

  Container assignedTOPage(BuildContext context, ThemeData theme) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.06,
            child: ElevatedButton(
              onPressed: () {
                // context.read<LeadTabController>().viweDetailsClicked();
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                    // fontSize: 12,
                    ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                )), //Radius.circular(6)
              ),
              child: Text(
                "Forward to",
              ),
            ),
          ),
          Container(
            width: Screens.width(context),
            //height: Screens.bodyheight(context) * 0.4,
            padding: EdgeInsets.only(
              left: Screens.width(context) * 0.05,
              right: Screens.width(context) * 0.05,
              top: Screens.bodyheight(context) * 0.03,
              bottom: Screens.bodyheight(context) * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                //  Text(
                //           "Forward to",
                //           style: theme.textTheme.bodyText1,
                //         ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Wrap(
                    spacing: 5.0, // gap between adjacent chips
                    runSpacing: 5.0, // gap between lines
                    children: listContainersProduct(
                      theme,
                    )),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (context.read<EnquiryMangerContoller>().assignto ==
                              false) {
                            context.read<EnquiryMangerContoller>().assignto =
                                true;
                          } else {
                            context.read<EnquiryMangerContoller>().assignto =
                                false;
                          }
                        });
                      },
                      child: Text(
                        "Back",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              theme.primaryColor)),
                    ),
                    TextButton(
                      onPressed: context
                                  .watch<EnquiryMangerContoller>()
                                  .getUserKey ==
                              null
                          ? null
                          : () {
                              if (context
                                      .read<EnquiryMangerContoller>()
                                      .getUserKey ==
                                  null) {
                              } else {
                                context
                                    .read<EnquiryMangerContoller>()
                                    .callAsignedToApi(
                                        context
                                            .read<EnquiryMangerContoller>()
                                            .getunassignedEnqdata[widget.i]
                                            ,
                                        context
                                            .read<EnquiryMangerContoller>()
                                            .getuserLtData[context
                                                .read<EnquiryMangerContoller>()
                                                .selectedIdxFUser!]
                                          .slpcode//  .UserKey
                                            .toString(),"open",
                                        context);

                                print(context
                                    .read<EnquiryMangerContoller>()
                                    .getunassignedEnqdata[widget.i]
                                    .EnqID
                                    .toString());
                                print(context
                                    .read<EnquiryMangerContoller>()
                                    .getuserLtData[context
                                        .read<EnquiryMangerContoller>()
                                        .selectedIdxFUser!]
                                   .SalesEmpID//   .UserKey
                                    .toString());
                              }
                            },
                      child: Text(
                        "Forward to",
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              theme.primaryColor)),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container enqDetailsPage(BuildContext context, ThemeData theme) {
    return Container(
      //  color: Colors.black12,
      // height: Screens.bodyheight(context) * 0.4,
      width: Screens.width(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                  onPressed: () {
                    // context.read<LeadTabController>().viweDetailsClicked();
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                        // fontSize: 12,
                        ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )), //Radius.circular(6)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Call assigned to ${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].AssignedTo_UserName}",
                      ),
                      Text(
                        "${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].Status}",
                      ),
                    ],
                  )),
            ),
            Container(
              padding: EdgeInsets.only(
                left: Screens.width(context) * 0.05,
                right: Screens.width(context) * 0.05,
                top: Screens.bodyheight(context) * 0.03,
                bottom: Screens.bodyheight(context) * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,

                        //     width: Screens.width(context) * 0.4,
                        child: Text(
                          "Customer",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        //    width: Screens.width(context) * 0.4,
                        child: Text(
                          "Date",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,

                        //    width: Screens.width(context) * 0.4,
                        child: Text(
                            "${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].CardName}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //  fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        //    width: Screens.width(context) * 0.4,
                        child: Text(
                            context.read<EnquiryMangerContoller>().config.alignDate(
                                "${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].EnqDate}"),
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //fontWeight: FontWeight.bold
                            )),
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
                        alignment: Alignment.centerLeft,

                        // width: Screens.width(context) * 0.4,
                        child: Text(
                          "Product",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        //   width: Screens.width(context) * 0.4,
                        child: Text(
                          "Potential Value",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                            "Looking for ${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].Lookingfor}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //  fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.2,
                        child: Text(
                            "₹ ${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].PotentialValue}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              // fontWeight: FontWeight.bold
                            )),
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
                        alignment: Alignment.centerLeft,

                        //color: Colors.red,
                        width: Screens.width(context) * 0.35,
                        child: Text("Follow Up Date",
                            //textAlign: TextAlign.center,
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: Colors.grey,
                              // fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        //color: Colors.red,
                        width: Screens.width(context) * 0.45,
                        child: Text("Enq type",
                            textAlign: TextAlign.right,
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: Colors.grey,
                              //   fontWeight: FontWeight.bold
                            )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        //color: Colors.red,
                        alignment: Alignment.centerLeft,
                        width: Screens.width(context) * 0.35,
                        child: Text(
                            context.read<EnquiryMangerContoller>().config.alignDate(
                                "${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].Followup}"),
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        //color: Colors.red,
                        width: Screens.width(context) * 0.45,
                        child: Text(
                            "${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].EnqType}",
                            textAlign: TextAlign.right,
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //  fontWeight: FontWeight.bold
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Column(children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.red,
                      child: Text("Address",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: Colors.grey,
                            //fontWeight: FontWeight.bold
                          )),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.red,
                      child: Text(
                          "${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].Address_Line_1}",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                            //  fontWeight: FontWeight.bold
                          )),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.red,
                      child: Text(
                          "${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].Address_Line_2}",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                            // fontWeight: FontWeight.bold
                          )),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.red,
                      child: Text(
                          "${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].City} - ${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].Pincode}",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                            //fontWeight: FontWeight.bold
                          )),
                    ),
                  ]),

                  //
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.02,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Screens.width(context) * 0.32,
                        height: Screens.bodyheight(context) * 0.06,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              textStyle: TextStyle(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                            ),
                            onPressed: () {
                              setState(() {
                                if (context
                                        .read<EnquiryMangerContoller>()
                                        .statusUpdate ==
                                    false) {
                                  context
                                      .read<EnquiryMangerContoller>()
                                      .statusUpdate = true;
                                } else {
                                  context
                                      .read<EnquiryMangerContoller>()
                                      .statusUpdate = false;
                                }
                              });
                            },
                            child: Text(
                              "Status Update",
                              style: theme.textTheme.bodyText2
                                  ?.copyWith(color: Colors.white),
                            )),
                      ),
                      Container(
                        width: Screens.width(context) * 0.15,
                        height: Screens.bodyheight(context) * 0.06,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              textStyle: TextStyle(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                            ),
                            onPressed: () {
                              context
                                  .read<EnquiryMangerContoller>()
                                  .makePhoneCall(context
                                      .read<EnquiryMangerContoller>()
                                      .getunassignedEnqdata[widget.i]
                                      .CardCode!);
                            },
                            child: Icon(Icons.call,
                                color: Colors.white,
                                size: Screens.bodyheight(context) * 0.03)),
                      ),
                      Container(
                        width: Screens.width(context) * 0.32,
                        height: Screens.bodyheight(context) * 0.06,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              textStyle: TextStyle(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                            ),
                            onPressed: () {
                              setState(() {
                                if (context
                                        .read<EnquiryMangerContoller>()
                                        .assignto ==
                                    false) {
                                  context
                                      .read<EnquiryMangerContoller>()
                                      .assignto = true;
                                } else {
                                  context
                                      .read<EnquiryMangerContoller>()
                                      .assignto = false;
                                }
                              });
                            },
                            child: Text(
                              "Forward",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
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
                  context.read<EnquiryMangerContoller>().mapValuesToLead(widget.i);
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
                  "Convert to lead",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container enqDetailsToOtherBranch(BuildContext context, ThemeData theme) {
    return Container(
      //  color: Colors.black12,
      // height: Screens.bodyheight(context) * 0.4,
      width: Screens.width(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                  onPressed: () {
                    // context.read<LeadTabController>().viweDetailsClicked();
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                        // fontSize: 12,
                        ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )), //Radius.circular(6)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Call assigned to ${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].AssignedTo_UserName}",
                      ),
                      Text(
                        "${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].Status}",
                      ),
                    ],
                  )),
            ),
            Container(
              padding: EdgeInsets.only(
                left: Screens.width(context) * 0.05,
                right: Screens.width(context) * 0.05,
                top: Screens.bodyheight(context) * 0.03,
                bottom: Screens.bodyheight(context) * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,

                        //     width: Screens.width(context) * 0.4,
                        child: Text(
                          "Customer",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        //    width: Screens.width(context) * 0.4,
                        child: Text(
                          "Date",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,

                        //    width: Screens.width(context) * 0.4,
                        child: Text(
                            "${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].CardName}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //  fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        //    width: Screens.width(context) * 0.4,
                        child: Text(
                            context.read<EnquiryMangerContoller>().config.alignDate(
                                "${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].EnqDate}"),
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //fontWeight: FontWeight.bold
                            )),
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
                        alignment: Alignment.centerLeft,

                        // width: Screens.width(context) * 0.4,
                        child: Text(
                          "Product",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,

                        //   width: Screens.width(context) * 0.4,
                        child: Text(
                          "Potential Value",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        width: Screens.width(context) * 0.4,
                        child: Text(
                            "Looking for ${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].Lookingfor}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //  fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Screens.width(context) * 0.2,
                        child: Text(
                            "₹ ${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].PotentialValue}",
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              // fontWeight: FontWeight.bold
                            )),
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
                        alignment: Alignment.centerLeft,

                        //color: Colors.red,
                        width: Screens.width(context) * 0.35,
                        child: Text("Follow Up Date",
                            //textAlign: TextAlign.center,
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: Colors.grey,
                              // fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        //color: Colors.red,
                        width: Screens.width(context) * 0.45,
                        child: Text("Enq type",
                            textAlign: TextAlign.right,
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: Colors.grey,
                              //   fontWeight: FontWeight.bold
                            )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        //color: Colors.red,
                        alignment: Alignment.centerLeft,
                        width: Screens.width(context) * 0.35,
                        child: Text(
                            context.read<EnquiryMangerContoller>().config.alignDate(
                                "${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].Followup}"),
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //fontWeight: FontWeight.bold
                            )),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        //color: Colors.red,
                        width: Screens.width(context) * 0.45,
                        child: Text(
                            "${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].EnqType}",
                            textAlign: TextAlign.right,
                            style: theme.textTheme.bodyText2?.copyWith(
                              color: theme.primaryColor,
                              //  fontWeight: FontWeight.bold
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Column(children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.red,
                      child: Text("Address",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: Colors.grey,
                            //fontWeight: FontWeight.bold
                          )),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.red,
                      child: Text(
                          "${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].Address_Line_1}",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                            //  fontWeight: FontWeight.bold
                          )),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.red,
                      child: Text(
                          "${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].Address_Line_2}",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                            // fontWeight: FontWeight.bold
                          )),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      //color: Colors.red,
                      child: Text(
                          "${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].City} - ${context.watch<EnquiryMangerContoller>().getunassignedEnqdata[widget.i].Pincode}",
                          style: theme.textTheme.bodyText2?.copyWith(
                            color: theme.primaryColor,
                            //fontWeight: FontWeight.bold
                          )),
                    ),
                  ]),
                ],
              ),
            ),
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  //Provider.of<EnquiryMangerContoller>(context, listen: false);
                  Navigator.pop(context);
                  context.read<EnquiryMangerContoller>().mapValuesToEnq();
                },
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
                ),
                child: Text(
                  "Create New Enquiry",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> listContainersProduct(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<EnquiryMangerContoller>().getuserLtData.length,
      (ind) => GestureDetector(
        onTap: () {
          context.read<EnquiryMangerContoller>().selectedIdxFUser = ind;
          context.read<EnquiryMangerContoller>().selectUser(ind);
        },
        child: Container(
          // alignment: Alignment.center,
          // width: Screens.width(context) * 0.2,
          // height: Screens.bodyheight(context) * 0.06,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: context
                          .watch<EnquiryMangerContoller>()
                          .getuserLtData[ind]
                          .color ==
                      1
                  ? theme.primaryColor
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: Text(
              context
                  .watch<EnquiryMangerContoller>()
                  .getuserLtData[ind]
                  .UserName!,
              // maxLines: 1,
              //overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: context
                            .watch<EnquiryMangerContoller>()
                            .getuserLtData[ind]
                            .color ==
                        1
                    //content[index].isselected == 1
                    ? Colors.white
                    : theme.primaryColor,
              )),
        ),
      ),
    );
  }

  List<Widget> listContainersReson(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<EnquiryMangerContoller>().getresonData.length,
      (ind) => GestureDetector(
        onTap: () {
          context.read<EnquiryMangerContoller>().selectedIdxFUser = ind;
          context.read<EnquiryMangerContoller>().selectReason( context.watch<EnquiryMangerContoller>().getresonData[ind]);
        },
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color:
                  context.watch<EnquiryMangerContoller>().getresonData[ind].color == 1
                      ? theme.primaryColor
                      : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: Text(context.watch<EnquiryMangerContoller>().getresonData[ind].CODE!,
              // maxLines: 1,
              //overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyText2?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color:
                    context.watch<EnquiryMangerContoller>().getresonData[ind].color ==
                            1
                        //content[index].isselected == 1
                        ? Colors.white
                        : theme.primaryColor,
              )),
        ),
      ),
    );
  }
}
