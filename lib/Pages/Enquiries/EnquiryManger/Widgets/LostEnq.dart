// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../../Controller/EnquiryController/EnquiryMngController.dart';



class LostEnqPage extends StatelessWidget {
  const LostEnqPage({
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
                return  context.read<EnquiryMangerContoller>().swipeRefreshIndicator();
              } ,
              child: ListView.builder(
                itemCount: context.watch<EnquiryMangerContoller>().getlostEnqdata.length,
                itemBuilder: (BuildContext context, int i) {
                  return InkWell(
                    child: Container(
                      width: Screens.width(context),
                      // height: Screens.bodyheight(context)*0.2,
                      padding: EdgeInsets.symmetric(
                          horizontal: Screens.width(context) * 0.02,
                          vertical: Screens.bodyheight(context) * 0.01),
                      child: Container(
                        color: Colors.grey[200],
                          padding: EdgeInsets.symmetric(
                          horizontal: Screens.width(context) * 0.02,
                          vertical: Screens.bodyheight(context) * 0.01),
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
                                  child: Text("${context.watch<EnquiryMangerContoller>().getlostEnqdata[i].CardName}",
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
                                  context.watch<EnquiryMangerContoller>().config.alignDate("${context.watch<EnquiryMangerContoller>().getlostEnqdata[i].EnqDate}") ,
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
                                  child: Text("Looking for ${context.watch<EnquiryMangerContoller>().getlostEnqdata[i].Lookingfor}",
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
                                     context.watch<EnquiryMangerContoller>().config.slpitCurrency(
                                      context.watch<EnquiryMangerContoller>().getlostEnqdata[i].PotentialValue!.toStringAsFixed(0)
                                     ),
                                  //  "₹ ${context.watch<EnquiryMangerContoller>().getlostEnqdata[i].PotentialValue}",
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
                                  child: Text("Call assigned to ${context.watch<EnquiryMangerContoller>().getlostEnqdata[i].AssignedTo_UserName}",
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
                                    child: Text("${context.watch<EnquiryMangerContoller>().getlostEnqdata[i].Status}",
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
        ],
      ),
    );
  }
}