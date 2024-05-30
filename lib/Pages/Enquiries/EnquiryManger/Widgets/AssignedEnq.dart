// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Pages/Enquiries/EnquiryManger/Widgets/AssignedtoDilaog.dart';

import '../../../../Constant/Screen.dart';
import '../../../../Controller/EnquiryController/EnquiryMngController.dart';



class AssignedPage extends StatelessWidget {
  const AssignedPage({
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
            child: RefreshIndicator(
              onRefresh:(){
                return  context.read<EnquiryMangerContoller>().swipeRefreshIndicator();
              } ,
              child: ListView.builder(
                itemCount:
                    context.watch<EnquiryMangerContoller>().getassignedEnqData.length,
                itemBuilder: (BuildContext context, int i) {
                  return InkWell(
                    onDoubleTap: () {
                     showDialog<dynamic>(
                          context: context,
                          builder: (_) {
                             context.read<EnquiryMangerContoller>().assignto = false;
                               context.read<EnquiryMangerContoller>().resetUserSelection(); 
                            return AssignedToDialogManager(indx: i,);
                          }).then((value) {
                            if( context.read<EnquiryMangerContoller>().getassignedToApiActResp!='' ||
                            context.read<EnquiryMangerContoller>().statusUpdateApiResp !=''
                            ){
                            context.read<EnquiryMangerContoller>().resetAll(context);
                            }
                          });
                    },
                    onLongPress: () {
                     showDialog<dynamic>(
                          context: context,
                          builder: (_) {
                             context.read<EnquiryMangerContoller>().assignto = false;
                               context.read<EnquiryMangerContoller>().resetUserSelection(); 
                            return AssignedToDialogManager(indx: i,);
                          }).then((value) {
                            if( context.read<EnquiryMangerContoller>().getassignedToApiActResp!='' ||
                            context.read<EnquiryMangerContoller>().statusUpdateApiResp !=''
                            ){
                            context.read<EnquiryMangerContoller>().resetAll(context);
                            }
                          });
                    },
                    child: Container(
                      width: Screens.width(context),
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
                                  width: Screens.width(context) * 0.4,
                                  child: Text(
                                      "${context.watch<EnquiryMangerContoller>().getassignedEnqData[i].CardName}",
                                      style: theme.textTheme.bodyText2?.copyWith(
                                          color: theme.primaryColor,
                                         // fontWeight: FontWeight.bold
                                          )),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: Screens.width(context) * 0.4,
                                  child: Text(
                                      context
                                          .watch<EnquiryMangerContoller>()
                                          .config
                                          .alignDate(
                                              "${context.watch<EnquiryMangerContoller>().getassignedEnqData[i].EnqDate}"),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Screens.width(context) * 0.5,
                                  child: Text(
                                      "Looking for ${context.watch<EnquiryMangerContoller>().getassignedEnqData[i].Lookingfor}",
                                      style: theme.textTheme.bodyText2?.copyWith(
                                          color:theme.primaryColor,
                                          //fontWeight: FontWeight.bold
                                          )),
                                ),
                                Container(
                                  //color:Colors.red,
                                  alignment: Alignment.centerRight,
                                  width: Screens.width(context) * 0.3,
                                  child: Text(
                                    context.watch<EnquiryMangerContoller>().config.slpitCurrency(
                                      context.watch<EnquiryMangerContoller>().getassignedEnqData[i].PotentialValue!.toStringAsFixed(0)
                                    ),
                                      //"₹ ${context.watch<EnquiryMangerContoller>().getopenEnqData[i].PotentialValue}",
                                      style: theme.textTheme.bodyText2?.copyWith(
                                          color:theme.primaryColor,
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
                                  //color: Colors.red,
                                  width: Screens.width(context) * 0.54,
                                  child: Text(
                                      "Call assigned to ${context.watch<EnquiryMangerContoller>().getassignedEnqData[i].AssignedTo_UserName}",
                                      style: theme.textTheme.bodyText2?.copyWith(
                                          color: Colors.grey,
                                         // fontWeight: FontWeight.bold
                                          )),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  // color: Colors.green[200],
                                  width: Screens.width(context) * 0.3,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: Screens.width(context) * 0.02,
                                      right: Screens.width(context) * 0.02,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green[200],
                                      borderRadius: BorderRadius.circular(4)
                                    ),
                                 // width: Screens.width(context) * 0.1,
                                    child: Text(
                                        "${context.watch<EnquiryMangerContoller>().getassignedEnqData [i].Status}",
                                        style: theme.textTheme.bodyText2?.copyWith(
                                            color: Colors.green[700],
                                            fontSize: 12
                                           // fontWeight: FontWeight.bold
                                            )),
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
            ),
          )
        ],
      ),
    );
  }
}
