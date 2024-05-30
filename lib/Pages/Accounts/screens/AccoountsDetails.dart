// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/AccountsController/AccountsController.dart';
import 'package:sellerkit/Controller/LeadController/LeadNewController.dart';
import '../../../Constant/ConstantRoutes.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

import 'package:intl/intl.dart';

class AccountsDetails extends StatefulWidget {
  AccountsDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<AccountsDetails> createState() => AccountsDetailsState();
}

class AccountsDetailsState extends State<AccountsDetails> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  static int? i;
  // int i=0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: scaffoldKey,
      // backgroundColor: ,
      drawer: drawer3(context),
      appBar: appbar("Account Details", scaffoldKey, theme, context),
      body:
          // ChangeNotifierProvider<AccountsContoller>(
          //     create: (context) => AccountsContoller(),
          //     builder: (context, child) {
          //       return Consumer<AccountsContoller>(
          //           builder: (BuildContext context, ACCCon, Widget? child) {
          Container(
        alignment: Alignment.topCenter,
        width: Screens.width(context),
        height: Screens.bodyheight(context),
        padding: EdgeInsets.only(
          top:Screens.padingHeight(context)*0.001,
          bottom: Screens.padingHeight(context)*0.001),
        // padding: paddings.padding2(context),
        child: context.watch<AccountsContoller>(). outloading==true?Center(child: CircularProgressIndicator(),):
    SingleChildScrollView(
      child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(children: [
      Container(
                width: Screens.width(context) * 0.94,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  // borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: const Offset(
                        1.0,
                        1.0,
                      ),
                      blurRadius: 3.0,
                      spreadRadius: 1.0,
                    ), //BoxShadow
                    //BoxShadow
                  ],
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        width: Screens.width(context) * 0.65,
                        //
                        padding: EdgeInsets.only(
                            left: Screens.bodyheight(context) * 0.01),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          // borderRadius: BorderRadius.only(
                          //     topLeft: Radius.circular(10),
                          //     bottomLeft: Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.01,
                            ),
                            Column(
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
                                  alignment: Alignment.centerLeft,
                                  width: Screens.width(context) * 0.4,
                                  child: Text(
                                      '${context.watch<AccountsContoller>().getAccountsDataFilter[i!].CustomerName}',
                                      style: theme.textTheme.bodyText2
                                          ?.copyWith(
                                        color: theme.primaryColor,
                                        //fontWeight: FontWeight.bold
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.001,
                            ),
                            Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Screens.width(context) * 0.4,
                                  child: Text(
                                    "Mobile",
                                    style: theme.textTheme.bodyText2
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<AccountsContoller>()
                                        .makePhoneCall(context
                                            .watch<AccountsContoller>()
                                            .getAccountsDataFilter[i!]
                                            .CustomerCode
                                            .toString());
                                  },
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    width: Screens.width(context) * 0.4,
                                    child: Text(
                                        '${context.watch<AccountsContoller>().getAccountsDataFilter[i!].CustomerCode}',
                                        style: theme.textTheme.bodyText2
                                            ?.copyWith(
                                                color: Colors.blue,
                                                decoration: TextDecoration
                                                    .underline
                                                //fontWeight: FontWeight.bold
                                                )),
                                  ),
                                ),
                            Container(
                                    alignment: Alignment.centerLeft,
                                    width: Screens.width(context) * 0.4,
                                    child: Text(
                                        'Account Balance',
                                        style: theme.textTheme.bodyText2
                                            ?.copyWith(
                                                color: Colors.grey,
                                                // decoration: TextDecoration
                                                //     .underline
                                                //fontWeight: FontWeight.bold
                                                )),
                                  ),
                            Container(
                                    alignment: Alignment.centerLeft,
                                    width: Screens.width(context) * 0.4,
                                    child: Text(
                                        '${context.watch<AccountsContoller>().AccoundBalance!.toStringAsFixed(2)}',
                                        style: theme.textTheme.bodyText2
                                            ?.copyWith(
                                                color: theme.primaryColor,
                                                // decoration: TextDecoration
                                                //     .underline
                                                //fontWeight: FontWeight.bold
                                                )),
                                  ),
                              ],
                            ),
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.001,
                            ),
                             Container(
                                    alignment: Alignment.centerLeft,
                                    width: Screens.width(context) * 0.5,
                                    child: Text(
                                        'GSTIN:${context.watch<AccountsContoller>().getAccountsDataFilter[i!].GSTNo==null?"":context.watch<AccountsContoller>().getAccountsDataFilter[i!].GSTNo}',
                                        style: theme.textTheme.bodyText2
                                            ?.copyWith(
                                                color: Colors.grey,
                                                // decoration: TextDecoration
                                                //     .underline
                                                //fontWeight: FontWeight.bold
                                                )),
                                  ),
                            // Column(
                            //   mainAxisAlignment:
                            //       MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Container(
                            //       width: Screens.width(context) * 0.4,
                            //       child: Text(
                            //         "City",
                            //         style: theme.textTheme.bodyText2
                            //             ?.copyWith(color: Colors.grey),
                            //       ),
                            //     ),
                            //     Container(
                            //       alignment: Alignment.centerLeft,
                            //       width: Screens.width(context) * 0.4,
                            //       child: Text(
                            //           '${context.watch<AccountsContoller>().getAccountsDataFilter[i!].Bil_City}',
                            //           style: theme.textTheme.bodyText2
                            //               ?.copyWith(
                            //             color: theme.primaryColor,
                            //             //fontWeight: FontWeight.bold
                            //           )),
                            //     ),
                            //   ],
                            // ),
    
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.01,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: Screens.width(context) * 0.28,
                        // height:
                        //     Screens.bodyheight(context) * 0.085,
                        color: theme.primaryColor,
    
                        child: InkWell(
                          onTap: () {
                            log("ACCCon.getdetaildataEnq.length::" +
                                context
                                    .watch<AccountsContoller>()
                                    .detaildataEnq
                                    .length
                                    .toString());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: Screens.width(context) * 0.28,
                            height: Screens.bodyheight(context) * 0.085,
                            // color: Colors.black,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: const Offset(
                                      2.0,
                                      2.0,
                                    ),
                                    blurRadius: 5.0,
                                    spreadRadius: 1.0,
                                  ), //BoxShadow
                                  //BoxShadow
                                ],
                                shape: BoxShape.circle),
                            child: Text(
                              "${context.watch<AccountsContoller>().getAccountsDataFilter[i!].CustomerName![0].toString().toUpperCase()}${context.watch<AccountsContoller>().getAccountsDataFilter[i!].CustomerName![1].toString().toUpperCase()}",
                              style: theme.textTheme.titleLarge,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // margin: EdgeInsets.only(top:0),
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.01,
              ),
              Container(
                width: Screens.width(context) * 0.94,
                padding: EdgeInsets.symmetric(
                  horizontal: Screens.width(context)*0.02,
                  vertical: Screens.padingHeight(context)*0.01
                ),
                decoration: BoxDecoration(
                       color: Colors.grey[200],
                       boxShadow: [BoxShadow(
                         color: Colors.grey,
                      offset: const Offset(
                        1.0,
                        1.0,
                      ),
                      blurRadius: 3.0,
                      spreadRadius: 1.0,
                    ),
                       ]
                    ),
                // decoration: BoxDecoration(
                //     color: theme.primaryColor.withOpacity(0.04),
                //     borderRadius: BorderRadius.circular(8),
                //     border: Border.all(color: Colors.black26)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Billing Address",
                      style: theme.textTheme.bodyText2!
                          .copyWith(color: Colors.grey),
                    ),
                 context.watch<AccountsContoller>().getAccountsDataFilter[i!].Bil_Address1!.isEmpty?Text(""):   Text(
                        '${context.watch<AccountsContoller>().getAccountsDataFilter[i!].Bil_Address1},${context.watch<AccountsContoller>().getAccountsDataFilter[i!].Bil_Address2}, ${context.watch<AccountsContoller>().getAccountsDataFilter[i!].Bil_City}, ${context.watch<AccountsContoller>().getAccountsDataFilter[i!].Bil_State}-${context.watch<AccountsContoller>().getAccountsDataFilter[i!].Bil_Pincode}'
                        ,style: theme.textTheme.bodyText2!.copyWith(
                                  color: theme.primaryColor
                                )
                        )
                  ],
                ),
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.01,
              ),
              // Center(
              //   child: Container(
              //      padding: EdgeInsets.symmetric(
              //     horizontal: Screens.width(context)*0.02,
              //     vertical: Screens.padingHeight(context)*0.01
              //   ),
              //       width: Screens.width(context) * 0.94,
              //       decoration: BoxDecoration(
              //         //  color: Colors.grey[200],
              //       //    boxShadow: [BoxShadow(
              //       //      color: Colors.grey,
              //       //   offset: const Offset(
              //       //     1.0,
              //       //     1.0,
              //       //   ),
              //       //   blurRadius: 3.0,
              //       //   spreadRadius: 1.0,
              //       // ),
              //       //    ]
              //       ),
              //     child: Wrap(
              //         spacing: 5.0, // width
              //         runSpacing: 10.0, // height
              //         children: listContainersCustomertags(
              //           theme,
              //         )),
              //   ),
              // ),
             
             Container(
                child: Column(children: [
    Container(
                alignment: Alignment.topLeft,
                // color: Colors.amber,
                padding: EdgeInsets.only(
                  left: Screens.width(context) * 0.03,
                  right: Screens.width(context) * 0.01,
                  top: Screens.bodyheight(context) * 0.01,
                  bottom: Screens.bodyheight(context) * 0.001,
                ),
                width: Screens.width(context),
                child: Text(
                  "Recent Orders",
                  style: theme.textTheme.headline6
                      ?.copyWith(color: theme.primaryColor),
                ),
              ),
              // SizedBox(
              //   height: Screens.bodyheight(context) * 0.001,
              // ),
               Container(
                // color: Colors.amber,
                // alignment: Alignment.center,
    
                child: Column(
                  children: [
                    (context.watch<AccountsContoller>().isLoading == true &&
                            context
                                .watch<AccountsContoller>()
                                .getdetaildataEnq
                                .isEmpty)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        :(context.watch<AccountsContoller>().isLoading == false &&
                            context
                                .watch<AccountsContoller>()
                                .getdetaildataEnq
                                .isEmpty)?Center(child:Container(
                                  // color:Colors.amber,
                                  alignment: Alignment.center,
                                   height: Screens.padingHeight(context) * 0.30,
                                  child: Text("No Recent Orders..!!"))): 
                                Container(
                            width: Screens.width(context),
                            height: Screens.padingHeight(context) * 0.33,
                            child: ListView.builder(
                                shrinkWrap: true,
                                // physics: const BouncingScrollPhysics(
                                //     parent:
                                //         AlwaysScrollableScrollPhysics()),
                                itemCount: context
                                    .watch<AccountsContoller>()
                                    .getdetaildataEnq
                                    .length,
                                itemBuilder: (context, int i) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Get.toNamed(ConstantRoutes.receipt);
                                    },
                                    child: Container(
                                      width: Screens.width(context),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              Screens.width(context) * 0.02,
                                          vertical:
                                              Screens.bodyheight(context) *
                                                  0.006),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    Screens.width(context) *
                                                        0.02,
                                                vertical: Screens.bodyheight(
                                                        context) *
                                                    0.006),
                                            decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Colors.black26)
                                                // border: Border(bottom: BorderSide(color: Colors.black38))
                                                ),
                                            width: Screens.width(context),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: Screens.width(
                                                              context) *
                                                          0.4,
                                                      child: Text(
                                                        "Customer",
                                                        style: theme
                                                            .textTheme.bodyText2
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .grey),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: Screens.width(
                                                              context) *
                                                          0.4,
                                                      child: Text(
                                                        "",
                                                        style: theme
                                                            .textTheme.bodyText2
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .grey),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: Screens.width(
                                                              context) *
                                                          0.4,
                                                      child: Text(
                                                          "${context.read<AccountsContoller>().customerdetails![0].customerName}", //  "${context.watch<EnquiryUserContoller>().getopenEnqData[i].CardName}",
                                                          style: theme.textTheme
                                                              .bodyText2
                                                              ?.copyWith(
                                                            color: theme
                                                                .primaryColor,
                                                            // fontWeight: FontWeight.bold
                                                          )),
                                                    ),
                                                    Container(
                                                      width: Screens.width(
                                                              context) *
                                                          0.4,
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                          //context
                                                          // leadOpenAllData[i].DocDate!.isEmpty?'':
                                                          //  context.read<AccountsContoller>().config.alignDate(
                                                          "#${context.read<AccountsContoller>().getdetaildataEnq![i].DocNum}",
                                                          //),//         // .watch<EnquiryUserContoller>()
                                                          // .config
                                                          // .alignDate(
                                                          //     "${context.watch<EnquiryUserContoller>().getopenEnqData[i].EnqDate}"),
                                                          style: theme.textTheme
                                                              .bodyText2
                                                              ?.copyWith(
                                                            color: theme
                                                                .primaryColor,
                                                            //fontWeight: FontWeight.bold
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: Screens.bodyheight(
                                                          context) *
                                                      0.003,
                                                ),
                                                
                                                        Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                   Container(
                                                      width: Screens.width(
                                                          context)*0.4,
                                                      child: Text(
                                                        "Store",
                                                        style: theme
                                                            .textTheme.bodyText2
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .grey),
                                                      ),
                                                    ),
                                                     Container(
                                                      width: Screens.width(
                                                          context)*0.4,
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: Screens.width(
                                                                  context) *
                                                              0.02,
                                                          right: Screens.width(
                                                                  context) *
                                                              0.02,
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .green[200],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                        child: Text(
                                                            context
                                                                    .watch<
                                                                        AccountsContoller>()
                                                                    .getdetaildataEnq![
                                                                        i]
                                                                    .CurrentStatus!
                                                                    .isEmpty
                                                                ? ''
                                                                : "${context.watch<AccountsContoller>().getdetaildataEnq![i].CurrentStatus}",
                                                            style: theme
                                                                .textTheme
                                                                .bodyText2
                                                                ?.copyWith(
                                                              //color:theme.primaryColor,
                                                              color: Colors
                                                                  .green[700],
                                                              // fontWeight: FontWeight.bold
                                                            )),
                                                      ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: Screens.width(
                                                              context)*0.5 ,
                                                      child: Text(
                                                          "${context.read<AccountsContoller>().getdetaildataEnq![i].Store}", //  "${context.watch<EnquiryUserContoller>().getopenEnqData[i].CardName}",
                                                          style: theme.textTheme
                                                              .bodyText2
                                                              ?.copyWith(
                                                            color: theme
                                                                .primaryColor,
                                                            // fontWeight: FontWeight.bold
                                                          )),
                                                    ),
                                                    
                                                  ],
                                                ),
                                               
                                                // Column(
                                                //   crossAxisAlignment:
                                                //       CrossAxisAlignment.start,
                                                //   mainAxisAlignment:
                                                //       MainAxisAlignment
                                                //           .spaceBetween,
                                                //   children: [
                                                    
                                                //     Container(
                                                //       width: Screens.width(
                                                //           context),
                                                //       // color: Colors.red,
                                                //       child: Text(
                                                //           "${context.read<AccountsContoller>().getdetaildataEnq![i].Store}",
                                                //           style: theme.textTheme
                                                //               .bodyText2
                                                //           //?.copyWith(color: Colors.grey),
                                                //           ),
                                                //     ),
                                                //   ],
                                                // ),
                                                SizedBox(
                                                  height: Screens.bodyheight(
                                                          context) *
                                                      0.003,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: Screens.width(
                                                              context) *
                                                          0.4,
                                                      // color: Colors.red,
                                                      child: Text(
                                                          "Next Follow up", //  "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[i].Lookingfor}",
                                                          style: theme.textTheme
                                                              .bodyText2
                                                              ?.copyWith(
                                                                  //color:theme.primaryColor,
                                                                  //fontWeight: FontWeight.bold
                                                                  color: Colors
                                                                      .grey)),
                                                    ),
                                                    Container(
                                                      width: Screens.width(
                                                              context) *
                                                          0.4,
                                                      //color: Colors.red,
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                          "Order Value", //  "₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                                          style: theme.textTheme
                                                              .bodyText2
                                                              ?.copyWith(
                                                                  //color:theme.primaryColor,
                                                                  //fontWeight: FontWeight.bold
                                                                  color: Colors
                                                                      .grey)),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: Screens.width(
                                                              context) *
                                                          0.4,
                                                      child: Text(
                                                          context
                                                                  .watch<
                                                                      AccountsContoller>()
                                                                  .getdetaildataEnq![
                                                                      i]
                                                                  .DocDate!
                                                                  .isEmpty
                                                              ? ''
                                                              : context
                                                                  .read<
                                                                      AccountsContoller>()
                                                                  .config
                                                                  .alignDate(
                                                                      "${context.watch<AccountsContoller>().getdetaildataEnq![i].DocDate}"), //  "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[i].Lookingfor}",
                                                          style: theme.textTheme
                                                              .bodyText2
                                                              ?.copyWith(
                                                                  //color:theme.primaryColor,
                                                                  //fontWeight: FontWeight.bold
                                                                  )),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        var format =
                                                            NumberFormat
                                                                .currency(
                                                          name: "INR",
                                                          locale: 'en_IN',
                                                          decimalDigits:
                                                              0, // change it to get decimal places
                                                          symbol: '₹ ',
                                                        );
                                                        String
                                                            formattedCurrency =
                                                            format
                                                                .format(30000);
                                                        print(
                                                            formattedCurrency);
                                                      },
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        width: Screens.width(
                                                                context) *
                                                            0.4,
                                                        child: Text(
                                                            context
                                                                        .watch<
                                                                            AccountsContoller>()
                                                                        .getdetaildataEnq![
                                                                            i]
                                                                        .BusinessValue ==
                                                                    -1
                                                                ? ""
                                                                : context
                                                                    .read<
                                                                        AccountsContoller>()
                                                                    .config
                                                                    .slpitCurrency(context
                                                                        .watch<
                                                                            AccountsContoller>()
                                                                        .getdetaildataEnq![
                                                                            i]
                                                                        .BusinessValue!
                                                                        .toStringAsFixed(
                                                                            0)), //  "₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                                            style: theme
                                                                .textTheme
                                                                .bodyText2
                                                                ?.copyWith(
                                                                    //color:theme.primaryColor,
                                                                    //fontWeight: FontWeight.bold
                                                                    )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // SizedBox(
                                                //   height: Screens.bodyheight(
                                                //           context) *
                                                //       0.01,
                                                // ),
                                                // Container(
                                                //   alignment:
                                                //       Alignment.centerLeft,
                                                //   width: Screens.width(context),
                                                //   child: Column(
                                                //     crossAxisAlignment:
                                                //         CrossAxisAlignment
                                                //             .start,
                                                //     children: [
                                                     
                                                //     ],
                                                //   ),
                                                // ),
                                                
    
                                              
    
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
                                }),
                          ),
                  ],
                ),
              ),
             
                ]),
              ),
             
                ],),
              ),
                
              // Container(
              //   width: Screens.width(context) * 0.94,
              //   // height: Screens.bodyheight(context) * 0.3,
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(10),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey,
              //         offset: const Offset(
              //           2.0,
              //           2.0,
              //         ),
              //         blurRadius: 5.0,
              //         spreadRadius: 1.0,
              //       ), //BoxShadow
              //       //BoxShadow
              //     ],
              //   ),
              //   child: Wrap(
              //       direction: Axis.horizontal,
              //       children: List.generate(
              //           context
              //               .watch<AccountsContoller>()
              //               .getitems
              //               .length, (intex) {
              //         return Container(
              //           margin: EdgeInsets.only(
              //             left: Screens.width(context) * 0.012,
              //             right: Screens.width(context) * 0.012,
              //             top: Screens.bodyheight(context) * 0.005,
              //             bottom: Screens.bodyheight(context) * 0.005,
              //           ),
              //           alignment: Alignment.center,
              //           // height: Screens.bodyheight(context) * 0.04,
              //           decoration: BoxDecoration(
              //               color: Colors.green.withOpacity(0.5),
              //               borderRadius: BorderRadius.circular(3)),
              //           padding: EdgeInsets.only(
              //             left: Screens.width(context) * 0.011,
              //             right: Screens.width(context) * 0.011,
              //             top: Screens.bodyheight(context) * 0.004,
              //             bottom: Screens.bodyheight(context) * 0.004,
              //           ),
              //           width: Screens.width(context) * 0.2,
              //           child: Text(
              //             "${context.watch<AccountsContoller>().getitems[intex]}",
              //             style: theme.textTheme.bodySmall
              //                 ?.copyWith(fontSize: 10),
              //           ),
              //         );
              //       })),
              //   // child: context.read<AccountsContoller>().wrapContainer(
              //   //     context.watch<AccountsContoller>().getitems,
              //   //     context,
              //   //     theme)
              // ),
    
               
            
              Container(
                // color:Colors.amber,
                // padding: EdgeInsets.symmetric(
                //   vertical:  Screens.bodyheight(context) * 0.01
                // ),
                margin: EdgeInsets.only(
                    top: Screens.bodyheight(context) * 0.01,
                    bottom: Screens.bodyheight(context) * 0.01
                    ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          // height: Screens.bodyheight(context) * 0.060,
                          width: Screens.width(context) * 0.45,
                          child: ElevatedButton(
                              onPressed: () {
                                //  log("CAREEE"+context.watch<AccountsContoller>().getAccountsDataFilter[i!].cardcode.toString());
    
                                context
                                    .read<AccountsContoller>()
                                    .createLead(i!);
                              },
                              child: Text("Create Lead")),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          // color: theme.primaryColor,
                          width: Screens.width(context) * 0.45,
                          // height: Screens.bodyheight(context) * 0.060,
                          child: ElevatedButton(
                              onPressed: () {
                                context.read<AccountsContoller>().createEnq(i!);
                              },
                              child: Text("Create Enquiry")),
                        )
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(
                    top: Screens.bodyheight(context) * 0.001,
                    bottom: Screens.bodyheight(context) * 0.003
                    ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            // height: Screens.bodyheight(context) * 0.060,
                            width: Screens.width(context) * 0.45,
                            child: ElevatedButton(
                                onPressed: () {
                                  //  log("CAREEE"+context.watch<AccountsContoller>().getAccountsDataFilter[i!].cardcode.toString());
                    
                                  context
                                      .read<AccountsContoller>()
                                      .createOrder(i!);
                                },
                                child: Text("Create Order")),
                          ),
                       Container(
                            decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            // height: Screens.bodyheight(context) * 0.060,
                            width: Screens.width(context) * 0.45,
                            child: ElevatedButton(
                                onPressed: () {
                                  //  log("CAREEE"+context.watch<AccountsContoller>().getAccountsDataFilter[i!].cardcode.toString());
                    
                                  context
                                      .read<AccountsContoller>()
                                      .Mapvaluestomodify(i!);
                                },
                                child: Text("Customer Edit")),
                          ),    
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          // height: Screens.bodyheight(context) * 0.060,
                          width: Screens.width(context) * 0.45,
                          child: ElevatedButton(
                              onPressed: () {
                                //  log("CAREEE"+context.watch<AccountsContoller>().getAccountsDataFilter[i!].cardcode.toString());
    
                                context
                                    .read<AccountsContoller>()
                                    .createVisitplan(i!);
                              },
                              child: Text("Create Visitplan")),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          // height: Screens.bodyheight(context) * 0.060,
                          width: Screens.width(context) * 0.45,
                          child: ElevatedButton(
                              onPressed: () {
                                //  log("CAREEE"+context.watch<AccountsContoller>().getAccountsDataFilter[i!].cardcode.toString());
    
                                context
                                    .read<AccountsContoller>()
                                    .createCollection(i!);
                              },
                              child: Text("Create Collection")),
                        ),
                      ],
                    ),
                     Container(
                      margin: EdgeInsets.only(
                          top: Screens.bodyheight(context) * 0.001,
                          bottom: Screens.bodyheight(context) * 0.001
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                         
    
                          
                          Container(
                            decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            // height: Screens.bodyheight(context) * 0.060,
                            width: Screens.width(context) * 0.45,
                            child: ElevatedButton(
                                onPressed: () {
                                  //  log("CAREEE"+context.watch<AccountsContoller>().getAccountsDataFilter[i!].cardcode.toString());
    
                                  context
                                      .read<AccountsContoller>()
                                      .createOutstanding(i!);
                                },
                                child: Text("View Outstanding")),
                          ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     color: theme.primaryColor,
                          //     borderRadius: BorderRadius.circular(6),
                          //   ),
                          //   // height: Screens.bodyheight(context) * 0.060,
                          //   width: Screens.width(context) * 0.45,
                          //   child: ElevatedButton(
                          //       onPressed: () {
                          //         //  log("CAREEE"+context.watch<AccountsContoller>().getAccountsDataFilter[i!].cardcode.toString());
    
                          //         context
                          //             .read<AccountsContoller>()
                          //             .createCollection(i!);
                          //       },
                          //       child: Text("Create Collection")),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    ),
      ),
      //   });
      // }
      // )
    );
  }

  List<Widget> listContainersCustomertags(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<AccountsContoller>().customerTagTypeData.length,
      (index) => InkWell(
        onTap: () {
          // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
          // .getenqReffList[index].Name.toString();
          // context.read<AccountsContoller>().selectCustomerTag(
          //     context
          //         .read<AccountsContoller>()
          //         .customerTagTypeData[index]
          //         .Name
          //         .toString(),
          //     context
          //         .read<AccountsContoller>()
          //         .customerTagTypeData[index]
          //         .Name!,
          //     context
          //         .read<AccountsContoller>()
          //         .customerTagTypeData[index]
          //         .Code!);
        },
        child: Container(
          width: Screens.width(context) * 0.2,
          height: Screens.bodyheight(context) * 0.05,
          alignment: Alignment.center,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context.watch<AccountsContoller>().isSelectedCusTagcode ==
                      context
                          .read<AccountsContoller>()
                          .customerTagTypeData[index]
                          .Code
                          .toString()
                  ? Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
              context
                  .watch<AccountsContoller>()
                  .customerTagTypeData[index]
                  .Name
                  .toString(),
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10,
                color:
                    context.watch<AccountsContoller>().isSelectedCusTagcode ==
                            context
                                .read<AccountsContoller>()
                                .customerTagTypeData[index]
                                .Code
                                .toString()
                        ? theme.primaryColor //,Colors.white
                        : theme.primaryColor,
              )),
        ),
      ),
    );
  }
}
