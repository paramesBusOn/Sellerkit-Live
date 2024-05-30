// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Pages/Enquiries/EnquiriesUser/Widgets/LostandClosedDialog.dart';
import 'package:sellerkit/Pages/VisitPlans/widgets/followdialog.dart';

import '../../../../Constant/Screen.dart';
import '../../../Constant/Configuration.dart';
import '../../../Controller/VisitplanController/VisitPlanController.dart';
// import 'GlobalKeys.dart';
// import '../../../../Controller/EnquiryController/EnquiryMngController.dart';


class MissiedUserPage extends StatelessWidget {
  const MissiedUserPage({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    Config config=Config();
    return Container(
      //color: Colors.red,
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.03,
          vertical: Screens.bodyheight(context) * 0.02),
      child: Column(
        children: [
          Expanded(
            child:context.read<VisitplanController>().missedVisitUserdata.isEmpty?Center(child: Column(
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
                Text('No data..!!',textAlign: TextAlign.center,),
              ],
            ),) : ListView.builder(
              itemCount:
                  context.watch<VisitplanController>().missedVisitUserdata.length,
              itemBuilder: (BuildContext context, int i) {
                return InkWell(
                  onDoubleTap: () {
showDialog<dynamic>(
                              context: context,
                              builder: (_) {
                                // widget.provi.updateFollowUpDialog = false;
                               // context.read<OrderTabController>().resetValues();
                                return FollowDialog( index: i,openVisitData:context.watch<VisitplanController>().missedVisitUserdata[i]);
                              }).then((value) {
                               context.read<VisitplanController>(). swipeRefreshIndiactor();
                              });
                    },
                    onLongPress: () {
showDialog<dynamic>(
                              context: context,
                              builder: (_) {
                                // widget.provi.updateFollowUpDialog = false;
                               // context.read<OrderTabController>().resetValues();
                                return FollowDialog( index: i,openVisitData:context.watch<VisitplanController>().missedVisitUserdata[i]);
                              }).then((value) {
                               context.read<VisitplanController>(). swipeRefreshIndiactor();
                              });
                    },
                  child: Container(
                    width: Screens.width(context),
                    padding: EdgeInsets.symmetric(
                        horizontal: Screens.width(context) * 0.02,
                        vertical: Screens.bodyheight(context) * 0.01),
                    child: Container(
                     
                      padding: EdgeInsets.symmetric(
                          horizontal: Screens.width(context) * 0.02,
                          vertical: Screens.bodyheight(context) * 0.01),
                          decoration: BoxDecoration(
                             color: Colors.grey[200],
                             borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black26)
                          ),
                      width: Screens.width(context),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Screens.width(context) * 0.4,
                                child: Text(
                                  "Customer",
                                  style: theme.textTheme.bodyText2
                                      ?.copyWith(color: Colors.grey),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: Screens.width(context) * 0.4,
                                child: Text(
                                  "Date & Time",
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
                                width: Screens.width(context) * 0.4,
                                child: Text(
                                    "${context.watch<VisitplanController>().missedVisitUserdata[i].customername}",
                                    style: theme.textTheme.bodyText2?.copyWith(
                                      color: theme.primaryColor,
                                      // fontWeight: FontWeight.bold
                                    )),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: Screens.width(context) * 0.4,
                                child: Text(//
                                    "${config.alignmeetingdate("${context.watch<VisitplanController>().missedVisitUserdata[i].meetingtime}")}",
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
                                width: Screens.width(context) * 0.4,
                                child: Text(
                                  "Purpose",
                                  style: theme.textTheme.bodyText2
                                      ?.copyWith(color: Colors.grey),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                width: Screens.width(context) * 0.4,
                                child: Text(
                                  "Area",
                                  style: theme.textTheme.bodyText2
                                      ?.copyWith(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                                                    // color:Colors.red,

                                  alignment: Alignment.topLeft,
                                  width: Screens.width(context) * 0.4,
                                  child: Text(
                                      "${context.watch<VisitplanController>().missedVisitUserdata[i].purposeofvisit}",
                                      style: theme.textTheme.bodyText2?.copyWith(
                                        color: theme.primaryColor,
                                        //fontWeight: FontWeight.bold
                                      )),
                                ),
                                Container(
                                  // color:Colors.red,
                                  alignment: Alignment.topRight,
                                  width: Screens.width(context) * 0.4,
                                  child: Text(
                                      "${context.watch<VisitplanController>().missedVisitUserdata[i].area}",
                                      textAlign: TextAlign.right,
                                      //"₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                      style: theme.textTheme.bodyText2?.copyWith(
                                        color: theme.primaryColor,
                                        //fontWeight: FontWeight.bold
                                      )),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    //color: Colors.red,
                                    width: Screens.width(context) * 0.54,
                                    child: Text(
                                        "Product",
                                        style:
                                            theme.textTheme.bodyText2?.copyWith(
                                          color: Colors.grey,
                                          // fontWeight: FontWeight.bold
                                        )),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    alignment: Alignment.centerLeft,
                                    width: Screens.width(context) * 0.54,
                                    child: Text(
                                        "${context.watch<VisitplanController>().missedVisitUserdata[i].LookingFor!}",
                                        //"₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                        style:
                                            theme.textTheme.bodyText2?.copyWith(
                                          color: theme.primaryColor,
                                          //fontWeight: FontWeight.bold
                                        )),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                // color: Colors.green[200],
                                width: Screens.width(context) * 0.3,
                                child: Container(
                                  // padding: EdgeInsets.only(
                                  //   left: Screens.width(context) * 0.02,
                                  //   right: Screens.width(context) * 0.02,
                                  // ),
                                  decoration: BoxDecoration(
                                      color: Colors.green[200],
                                      borderRadius: BorderRadius.circular(4)),
                                  // width: Screens.width(context) * 0.1,
                                  child: Padding(
                                    padding:  EdgeInsets.all(Screens.width(context) * 0.01),
                                    child: Text(
                                        "${context.watch<VisitplanController>().missedVisitUserdata[i].visitstatus}",
                                        style: theme.textTheme.bodyText2
                                            ?.copyWith(
                                                color: Colors.green[700],
                                                fontSize: 12
                                                // fontWeight: FontWeight.bold
                                                )),
                                  ),
                                ),
                              )
                            ],
                          ),
                          // Container(
                          //     padding: EdgeInsets.symmetric(
                          //         horizontal: Screens.width(context) * 0.1),
                          //     child: Divider(
                          //       thickness: 1,
                          //     ))
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}