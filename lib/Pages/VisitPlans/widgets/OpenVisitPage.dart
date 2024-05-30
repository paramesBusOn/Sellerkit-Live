// ignore_for_file: prefer_const_constructors, unnecessary_new, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Pages/VisitPlans/widgets/followdialog.dart';

import '../../../../Constant/Screen.dart';
// import '../../../../Controller/EnquiryController/EnquiryMngController.dart';
// import '../../../../Controller/EnquiryController/EnquiryUserContoller.dart';
import '../../../Controller/VisitplanController/VisitPlanController.dart';

class OpenVisitPage extends StatefulWidget {
  const OpenVisitPage({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  State<OpenVisitPage> createState() => _OpenVisitPageState();
}

class _OpenVisitPageState extends State<OpenVisitPage> {
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
      child: GestureDetector(onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.dashboard);
                      });
                    }
                  },
        child: Column(
          children: [
            Expanded(
              child: context.read<VisitplanController>().openVisitData.isEmpty?Center(child: Column(
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
              ),) :ListView.builder(
                itemCount:
                    context.watch<VisitplanController>().openVisitData.length,
                itemBuilder: (BuildContext context, int i) {
                  return InkWell(
                    onDoubleTap: () {
showDialog<dynamic>(
                              context: context,
                              builder: (_) {
                                // widget.provi.updateFollowUpDialog = false;
                               // context.read<OrderTabController>().resetValues();
                                return FollowDialog( index: i,openVisitData:context.watch<VisitplanController>().openVisitData[i]);
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
                                return FollowDialog( index: i,openVisitData:context.watch<VisitplanController>().openVisitData[i]);
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
                                    style: widget.theme.textTheme.bodyText2
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: Screens.width(context) * 0.4,
                                  child: Text(
                                    "Date & Time",
                                    style: widget.theme.textTheme.bodyText2
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
                                      "${context.watch<VisitplanController>().openVisitData[i].customername}",
                                      style: widget.theme.textTheme.bodyText2?.copyWith(
                                        color: widget.theme.primaryColor,
                                        // fontWeight: FontWeight.bold
                                      )),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: Screens.width(context) * 0.42,
                                  child: Text(
                                      "${config.alignmeetingdate(context.watch<VisitplanController>().openVisitData[i].meetingtime.toString())}",
                                      style: widget.theme.textTheme.bodyText2?.copyWith(
                                        color: widget.theme.primaryColor,
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
                                    style: widget.theme.textTheme.bodyText2
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: Screens.width(context) * 0.4,
                                  child: Text(
                                    "Area",
                                    style: widget.theme.textTheme.bodyText2
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
                                    child: context.watch<VisitplanController>().openVisitData[i].purposeofvisit==null||
                                    context.watch<VisitplanController>().openVisitData[i].purposeofvisit=='null'||context.watch<VisitplanController>().openVisitData[i].purposeofvisit!.isEmpty?Text(''):
                                    Text(
                                        "${context.watch<VisitplanController>().openVisitData[i].purposeofvisit}",
                                        style: widget.theme.textTheme.bodyText2?.copyWith(
                                          color: widget.theme.primaryColor,
                                          //fontWeight: FontWeight.bold
                                        )),
                                  ),
                                  Container(
                                    // color:Colors.red,
                                    alignment: Alignment.topRight,
                                    width: Screens.width(context) * 0.4,
                                    child: Text(
                                        "${context.watch<VisitplanController>().openVisitData[i].area!} ",
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        //"₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                        style: widget.theme.textTheme.bodyText2?.copyWith(
                                          color: widget.theme.primaryColor,
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
                                              widget.theme.textTheme.bodyText2?.copyWith(
                                            color: Colors.grey,
                                            // fontWeight: FontWeight.bold
                                          )),
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      alignment: Alignment.centerLeft,
                                      width: Screens.width(context) * 0.54,
                                      child: Text(
                                          "${context.watch<VisitplanController>().openVisitData[i].LookingFor!}",
                                          //"₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                          style:
                                              widget.theme.textTheme.bodyText2?.copyWith(
                                            color: widget.theme.primaryColor,
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
                                          "${context.watch<VisitplanController>().openVisitData[i].visitstatus}",
                                          style: widget.theme.textTheme.bodyText2
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
      ),
    );
  }
}
