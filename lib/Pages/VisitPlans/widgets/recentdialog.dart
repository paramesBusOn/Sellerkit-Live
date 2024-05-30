// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Constant/Screen.dart';
import '../../../Controller/VisitplanController/NewVisitController.dart';

import 'package:intl/intl.dart';

class recentactivites extends StatefulWidget {
  recentactivites({Key? key}) : super(key: key);
  @override
  State<recentactivites> createState() => ShowSearchDialogState();
}

class ShowSearchDialogState extends State<recentactivites> {
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
      height: Screens.bodyheight(context),
      child: Column(
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
                  child: Text("Recent Activities"))),
          SizedBox(
            height: Screens.padingHeight(context) * 0.01,
          ),
          Expanded(
            child: context.read<NewVisitplanController>().purposecode != '05' 
            &&
                    context.read<NewVisitplanController>().purposecode != '06'
                ? Center(
                    child: Container(
                      child: Text('No Data..!!'),
                    ),
                  )
                :
                context.read<NewVisitplanController>().purposecode == '05'
                // &&context.read<NewVisitplanController>().enquirydetails!.length>0
                 ?
                ListView.builder(
                  itemCount:  context.read<NewVisitplanController>().enquirydetails!.length,
                 shrinkWrap: true,
                  itemBuilder: (context,index){
                    
                  return  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    context.read<NewVisitplanController>() . callenquirydetails( context.read<NewVisitplanController>().enquirydetails![index],context);
                    },
                    child: Container(
                      width: Screens.width(context),
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
                                    // "AAA",
                                      "${context.watch<NewVisitplanController>().customerdetails![0].customerName}",
                                      style: theme.textTheme.bodyText2?.copyWith(
                                        color: theme.primaryColor,
                                        // fontWeight: FontWeight.bold
                                      )),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: Screens.width(context) * 0.4,
                                  child: Text(
                                    // "Anb",
                                      context
                                          .watch<NewVisitplanController>()
                                          .config
                                          .alignDate(
                                              "${context.watch<NewVisitplanController>().enquirydetails![index].DocDate}"
                                      ),
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
                                    // "Looking for ",
                                     " ${context.watch<NewVisitplanController>().enquirydetails![index].Store}",
                                      // ",
                                      style: theme.textTheme.bodyText2?.copyWith(
                                        color: theme.primaryColor,
                                        //fontWeight: FontWeight.bold
                                      )),
                                ),
                                Container(
                                  //color:Colors.red,
                                  alignment: Alignment.centerRight,
                                  width: Screens.width(context) * 0.3,
                                  child: Text(
                                    // "777",
                                      // context.watch<NewVisitplanController>().config.slpitCurrency(
                                      //   context.watch<NewVisitplanController>().getopenEnqData[i].PotentialValue!.toStringAsFixed(0)
                                      // ),
                                      "₹ ${context.watch<NewVisitplanController>().enquirydetails![index].BusinessValue}",
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
                                  //color: Colors.red,
                                  width: Screens.width(context) * 0.54,
                                  child: Text(
                                    // "ANb",
                                  
                                      "Call assigned to ${context.watch<NewVisitplanController>().enquirydetails![index].AssignedTo}",
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
                                        borderRadius: BorderRadius.circular(4)),
                                    // width: Screens.width(context) * 0.1,
                                    child: Text(
                                      // "uuuu",
                                        "${context.watch<NewVisitplanController>().enquirydetails![index].CurrentStatus}",
                                        style: theme.textTheme.bodyText2?.copyWith(
                                            color: Colors.green[700], fontSize: 12
                                            // fontWeight: FontWeight.bold
                                            )),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.01,
                            ),
                                  
                            //new Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    left: Screens.width(context) * 0.02,
                                    right: Screens.width(context) * 0.02,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.orange[100],
                                      borderRadius: BorderRadius.circular(4)),
                                  // width: Screens.width(context) * 0.1,
                                  child: Text(
                                    // "aaaaa",
                                      "${context.watch<NewVisitplanController>().customerdetails![index].customerGroup}",
                                      style: theme.textTheme.bodyText2?.copyWith(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                ),
                                //  context.watch<NewVisitplanController>().enquirydetails![index].isVisitRequired !="Y"?Container():
                                // Container(
                                //   // color: Colors.amber,
                                //   alignment: Alignment.centerRight,
                                //   width: Screens.width(context) * 0.5,
                                //   child: Text(
                                //     // "Aaaaa",
                                //       "Site Visit on\t${context
                                //         .watch<NewVisitplanController>()
                                //         .config
                                //         .alignDate(context.watch<NewVisitplanController>().enquirydetails![index].visitTime.toString())}",
                                //       style: theme.textTheme.bodyText2?.copyWith(
                                //           fontSize: 12,
                                //           color: Colors.grey,
                                //           fontStyle: FontStyle.italic
                                  
                                //           // fontWeight: FontWeight.bold
                                //           )),
                                // )
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
                }):
                
                ListView.builder(
                        itemCount: context.read<NewVisitplanController>().leaddetails!.length,
                        itemBuilder: (BuildContext context, int i) {
                          return InkWell(
                            onTap: () {

                               Navigator.pop(context);
                    context.read<NewVisitplanController>() . callleaddetails( context.read<NewVisitplanController>().leaddetails![i],context);
                   
                                },
                           
                            child: Container(
                              width: Screens.width(context),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.02,
                                  vertical:
                                      Screens.bodyheight(context) * 0.006),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.02,
                                        vertical: Screens.bodyheight(context) *
                                            0.006),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(color: Colors.black26)
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
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "Customer",
                                                style:
                                                    theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                  "${context.read<NewVisitplanController>().customerdetails![0].customerName}", //  "${context.watch<EnquiryUserContoller>().getopenEnqData[i].CardName}",
                                                  style: theme.textTheme.bodyText2
                                                      ?.copyWith(
                                                    color:theme.primaryColor,
                                                    // fontWeight: FontWeight.bold
                                                  )),
                                            ),
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  //context
                                                  // leadOpenAllData[i].DocDate!.isEmpty?'':
                                                  //  context.read<NewVisitplanController>().config.alignDate(
                                                  "#${context.read<NewVisitplanController>().leaddetails![i].DocNum}",
                                                  //),//         // .watch<EnquiryUserContoller>()
                                                  // .config
                                                  // .alignDate(
                                                  //     "${context.watch<EnquiryUserContoller>().getopenEnqData[i].EnqDate}"),
                                                  style: theme.textTheme.bodyText2
                                                      ?.copyWith(
                                                    color: theme.primaryColor,
                                                    //fontWeight: FontWeight.bold
                                                  )),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Screens.bodyheight(context) *
                                              0.01,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: Screens.width(context),
                                              child: Text(
                                                "Product",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              width: Screens.width(context),
                                              // color: Colors.red,
                                              child: Text(
                                                  "${context.read<NewVisitplanController>().leaddetails![i].Store}",
                                                  style: theme.textTheme.bodyText2
                                                  //?.copyWith(color: Colors.grey),
                                                  ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Screens.bodyheight(context) *
                                              0.01,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              // color: Colors.red,
                                              child: Text(
                                                  "Next Follow up", //  "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[i].Lookingfor}",
                                                  style: theme.textTheme.bodyText2
                                                      ?.copyWith(
                                                          //color:theme.primaryColor,
                                                          //fontWeight: FontWeight.bold
                                                          color: Colors.grey)),
                                            ),
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              //color: Colors.red,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  "Order Value", //  "₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                                  style: theme.textTheme.bodyText2
                                                      ?.copyWith(
                                                          //color:theme.primaryColor,
                                                          //fontWeight: FontWeight.bold
                                                          color: Colors.grey)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                  context.watch<NewVisitplanController>().leaddetails![i].DocDate!.isEmpty
                                                      ? ''
                                                      : context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .config
                                                          .alignDate(
                                                              "${context.watch<NewVisitplanController>().leaddetails![i].DocDate}"), //  "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[i].Lookingfor}",
                                                  style: theme.textTheme.bodyText2
                                                      ?.copyWith(
                                                          //color:theme.primaryColor,
                                                          //fontWeight: FontWeight.bold
                                                          )),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                var format =
                                                    NumberFormat.currency(
                                                  name: "INR",
                                                  locale: 'en_IN',
                                                  decimalDigits:
                                                      0, // change it to get decimal places
                                                  symbol: '₹ ',
                                                );
                                                String formattedCurrency =
                                                    format.format(30000);
                                                print(formattedCurrency);
                                              },
                                              child: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: Text(
                                                    context.watch<NewVisitplanController>().leaddetails![i]
                                                                .BusinessValue ==
                                                            -1
                                                        ? ""
                                                        : context
                                                            .read<
                                                                NewVisitplanController>()
                                                            .config
                                                            .slpitCurrency(context.watch<NewVisitplanController>().leaddetails![i].BusinessValue!
                                                                .toStringAsFixed(
                                                                    0)), //  "₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                                    style: theme
                                                        .textTheme.bodyText2
                                                        ?.copyWith(
                                                            //color:theme.primaryColor,
                                                            //fontWeight: FontWeight.bold
                                                            )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Screens.bodyheight(context) *
                                              0.01,
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: Screens.width(context),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: Screens.width(context) *
                                                      0.02,
                                                  right:
                                                      Screens.width(context) *
                                                          0.02,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.green[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Text(
                                                    context.watch<NewVisitplanController>().leaddetails![i].CurrentStatus!
                                                            .isEmpty
                                                        ? ''
                                                        : "${context.watch<NewVisitplanController>().leaddetails![i].CurrentStatus}",
                                                    style: theme
                                                        .textTheme.bodyText2
                                                        ?.copyWith(
                                                      //color:theme.primaryColor,
                                                      color: Colors.green[700],
                                                      // fontWeight: FontWeight.bold
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: Screens.bodyheight(context) *
                                              0.01,
                                        ),

                                        Container(
                                          // color: Colors.green[200],
                                          alignment: Alignment.centerLeft,
                                          width: Screens.width(context),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Text(
                                              context.watch<NewVisitplanController>().leaddetails![i].DocDate!.isEmpty
                                                    ? ''
                                                    : "Last Updated: " +
                                                        context
                                                            .watch<
                                                                NewVisitplanController>()
                                                            .config
                                                            .subtractDateTime(
                                                                "${context.watch<NewVisitplanController>().leaddetails![i].DocDate!}"), //     "${context.watch<EnquiryUserContoller>().getopenEnqData[i].Status}",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                  color: Colors.grey,
                                                  // color: Colors.green[700],
                                                  // fontWeight: FontWeight.bold
                                                )),
                                          ),
                                        )

                                        // Container(
                                        //     padding: EdgeInsets.symmetric(
                                        //         horizontal: Screens.width(context) * 0.1),
                                        //     child: Divider(
                                        //       thickness: 1,
                                        //     ))
                                      ],
                                    ),
                                  ),
                                ],
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
