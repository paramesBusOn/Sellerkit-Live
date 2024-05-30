// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Pages/Enquiries/EnquiriesUser/Widgets/LostandClosedDialog.dart';

import '../../../../Constant/Screen.dart';
import '../../../../Controller/EnquiryController/EnquiryUserContoller.dart';
import 'GlobalKeys.dart';
// import '../../../../Controller/EnquiryController/EnquiryMngController.dart';


class LostEnqUserPage extends StatelessWidget {
  const LostEnqUserPage({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
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
            child:RefreshIndicator(
              // key: new GlobalKey<RefreshIndicatorState>(),
             // key: RIKeys.riKey3, 
              onRefresh:(){
                return  context.read<EnquiryUserContoller>().swipeRefreshIndicator();
              } ,
              child:context.watch<EnquiryUserContoller>().filterlostEnqUserdata.isEmpty?Center(child: Column(
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
                  Text("No data..!!",),
                ],
              )):  ListView.builder(
                itemCount: context.watch<EnquiryUserContoller>().filterlostEnqUserdata.length,
                itemBuilder: (BuildContext context, int i) {
                  return InkWell(
                    child: Container(
                      width: Screens.width(context),
                      // height: Screens.bodyheight(context)*0.2,
                      padding: EdgeInsets.symmetric(
                          horizontal: Screens.width(context) * 0.02,
                          vertical: Screens.bodyheight(context) * 0.01),
                      child: Container(
                        // color: Colors.grey[200],
                          padding: EdgeInsets.symmetric(
                          horizontal: Screens.width(context) * 0.02,
                          vertical: Screens.bodyheight(context) * 0.01),
                          decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black26)
                                  // border: Border(bottom: BorderSide(color: Colors.black38))
                                  ),
                        width: Screens.width(context),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
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
                                    "Date",
                                    style: theme.textTheme.bodyText2
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Screens.width(context) * 0.4,
                                  child: Text("${context.watch<EnquiryUserContoller>().filterlostEnqUserdata[i].CardName}",
                                      style: theme.textTheme.bodyText2
                                          ?.copyWith(
                                              color: theme.primaryColor,
                                              // fontWeight:
                                              //     FontWeight.bold
                                                  )),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: Screens.width(context) * 0.4,
                                  child: Text(
                                  context.watch<EnquiryUserContoller>().config.alignDate("${context.watch<EnquiryUserContoller>().filterlostEnqUserdata[i].EnqDate}") ,
                                      style: theme.textTheme.bodyText2
                                          ?.copyWith(
                                              color: theme.primaryColor,
                                              // fontWeight:
                                              //     FontWeight.bold
                                                  )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.01,
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Screens.width(context) * 0.4,
                                  child: Text(
                                    "Product",
                                    style: theme.textTheme.bodyText2
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: Screens.width(context) * 0.4,
                                  child: Text(
                                    "Potential Value",
                                    style: theme.textTheme.bodyText2
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Screens.width(context) * 0.4,
                                  child: Text("Looking for ${context.watch<EnquiryUserContoller>().filterlostEnqUserdata[i].Lookingfor}",
                                      style: theme.textTheme.bodyText2
                                          ?.copyWith(
                                              color:theme.primaryColor,
                                              // fontWeight:
                                              //     FontWeight.bold
                                                  )),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: Screens.width(context) * 0.4,
                                  child: Text(
                                     context.watch<EnquiryUserContoller>().config.slpitCurrency(
                                      context.watch<EnquiryUserContoller>().filterlostEnqUserdata[i].PotentialValue!.toStringAsFixed(0)
                                     ),
                                  //  "₹ ${context.watch<EnquiryUserContoller>().filterlostEnqUserdata[i].PotentialValue}",
                                      style: theme.textTheme.bodyText2
                                          ?.copyWith(
                                              color:theme.primaryColor,
                                              // fontWeight:
                                              //     FontWeight.bold
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
                                  //color: Colors.red,
                                  width: Screens.width(context) * 0.54,
                                  child: Text("Call assigned to ${context.watch<EnquiryUserContoller>().filterlostEnqUserdata[i].AssignedTo_UserName}",
                                      style: theme.textTheme.bodyText2
                                          ?.copyWith(
                                              color: Colors.grey,
                                             // fontWeight: FontWeight.bold
                                              )),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  //color: Colors.red,
                                  width: Screens.width(context) * 0.3,
                                  child: Container(
                                     padding: EdgeInsets.only(
                                      left: Screens.width(context) * 0.02,
                                      right: Screens.width(context) * 0.02,
                                    ),
                                      decoration: BoxDecoration(
                                      color: Colors.red[200],
                                      borderRadius: BorderRadius.circular(4)
                                    ),
                                    child: Text("${context.watch<EnquiryUserContoller>().filterlostEnqUserdata[i].Status}",
                                        style: theme.textTheme.bodyText2
                                            ?.copyWith(
                                                color: Colors.red,
                                                fontSize: 12
                                                //fontWeight: FontWeight.bold
                                                )),
                                  ),
                                )
                              ],
                            ),
                            // Container(
                            //     padding: EdgeInsets.symmetric(
                            //         horizontal:
                            //             Screens.width(context) * 0.1),
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
            ),
          )
      , Container(
        alignment: Alignment.bottomLeft,
        child: Text("This page shows only last 20 days records",
        style: TextStyle(fontSize: 10),
        ),
       ),
        ],
      ),
    );
  }
}