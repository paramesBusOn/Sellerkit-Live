// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/OfferZoneController/OfferZoneController.dart';

import '../../Constant/Configuration.dart';
import '../../Models/OfferZone/OfferZoneModel.dart';

class DiviceDialogBox extends StatelessWidget {
  DiviceDialogBox(
      {Key? key,
      required this.pardata, 
      required this.theme,
      //  required this.i, 
      // required this.popvalues,
      // required this.popvalues2
      })
      : super(key: key);
  final ThemeData theme;
  OfferZoneData pardata;
  // List<offerproductlist> popvalues = [];
  // List<OfferZoneData> popvalues2 = [];
  // int i;
  @override
  
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
 Config config2 =  Config();
    return AlertDialog(
        insetPadding: EdgeInsets.all(10),
        // insetPadding: EdgeInsets.all(6),
        contentPadding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: theme.primaryColor)),
        content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
         Container(
                  height:pardata.offerproductlistdetails!.length >1? Screens.bodyheight(context)*0.4:Screens.bodyheight(context)*0.2,
                  width: Screens.width(context),
                  padding: EdgeInsets.only(
                    top: Screens.bodyheight(context) * 0.02,
                    left: Screens.bodyheight(context) * 0.02,
                    right: Screens.bodyheight(context) * 0.02,
                  ),
                  child: ListView.builder(
                    shrinkWrap: false,
                    itemCount:pardata.offerproductlistdetails!.length ,
                    itemBuilder: (context,ind) {
                      return 
                          pardata.offerproductlistdetails! [ind].offerid==pardata.offerId?
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //          Text(
                            //           "Offer id",
                            //           style: theme.textTheme.bodyText1
                            //               ?.copyWith(color: theme.primaryColor),
                            //         ),
                            //         Text(
                            //           "${pardata.offerName}",
                            //           style: theme.textTheme.bodySmall
                            //       ?.copyWith(color: Colors.grey),
                            //         ),
                            //       ],
                            //     ),
                            //  Column(children: [
                            //    Text(
                            //   "offer",
                            //   style: theme.textTheme.bodyText1
                            //       ?.copyWith(color:theme.primaryColor),
                            // ),
                            //    Text(
                            //   "${pardata.offerproductlistdetails![ind].offer}",
                            //   style: theme.textTheme.bodySmall
                            //       ?.copyWith(color: Colors.grey),
                            // ),
                            //  ],)
                             
                            //   ],
                            // ),
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.01,
                            ),
                              Text(
                              "Offer Products",
                              style:theme.textTheme.bodyText1
                                  ?.copyWith(color:theme.primaryColor),
                            ),
                             Text(
                              "${pardata.offerproductlistdetails![ind].itemName}",
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(color: Colors.grey),
                            ),
                            // SizedBox(
                            //   height: Screens.bodyheight(context) * 0.02,
                            // ),
                          
                            // SizedBox(
                            //   height: Screens.bodyheight(context) * 0.03,
                            // ),
                            // Text(
                            //   "${popvalues[i].}",
                            //   style: theme.textTheme.bodyText1?.copyWith(),
                            // ),
                            pardata.offerproductlistdetails!.length >1?     Divider(
                                                  color: theme.primaryColor,
                                                  thickness: 1,
                                                ):Container()
                          ]):Container();
                    }
                  )),
              SizedBox(
                height: Screens.bodyheight(context) * 0.02,
              ),
              Container(
                  height: Screens.bodyheight(context) * 0.05,
                  padding: EdgeInsets.all(6),
                  alignment: Alignment.center,
                  width: Screens.width(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    color: theme.primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Screens.width(context) * 0.02),
                        width: Screens.width(context) * 0.55,
                        child: Text(
                          "Offer valid till ${config2.alignDate("${pardata.validTill}")}",
                          style: theme.textTheme.bodyText1
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: Screens.width(context) * 0.02),
                      //   width: Screens.width(context) * 0.2,
                      //   //color: Colors.green,
                      //   child: 
                      //   Text(
                      //     "${popvalues2[i].incentive}",
                      //     style: theme.textTheme.bodyText1
                      //         ?.copyWith(color: Colors.white),
                      //   ),
                      // ),
                    ],
                  )),
            ]));
  }
}
