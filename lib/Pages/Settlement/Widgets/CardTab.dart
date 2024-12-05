// ignore_for_file: prefer_const_constructors, unnecessary_new, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../Constant/Screen.dart';
import '../../../Controller/SettlementController/settlement_controller.dart';
import 'SettlementPdfHelper.dart';

class CardTabPage extends StatelessWidget {
  const CardTabPage({
    super.key,
    required this.theme,
  }) ;

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
            child: (context.read<SettlementController>().progress == true &&
                    context
                        .read<SettlementController>()
                        .settelGetListCard
                        .isEmpty &&
                    context.read<SettlementController>().errormsg == '')
                ? Center(child: CircularProgressIndicator())
                : (context.read<SettlementController>().progress == false &&
                        context
                            .read<SettlementController>()
                            .settelGetListCard
                            .isEmpty &&
                        context.read<SettlementController>().errormsg != '')
                    ? Center(
                        child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                                        
                            children: [
                               context.watch<SettlementController>().lottie!.isEmpty?Container():
                                context.watch<SettlementController>().lottie!.isNotEmpty && context.watch<SettlementController>().lottie!.contains(".png")?     InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Image.asset('${context.watch<SettlementController>().lottie}',
        //               opacity: AnimationController(
        //     vsync: this,
        //     value: 1
        // ),
        // color:Colors.transparent,
                        // animate: true,
                        // repeat: true,
                        
                        height: Screens.padingHeight(context) * 0.2,
                        width: Screens.width(context)*0.4
                        ),
                  ):              InkWell(
                    onTap: () {
                      // HelperFunctions.clearCheckedOnBoardSharedPref();
                      // HelperFunctions.clearUserLoggedInSharedPref();
                    },
                    child: Lottie.asset('${context.watch<SettlementController>().lottie}',
                        animate: true,
                        repeat: true,
                        // height: Screens.padingHeight(context) * 0.3,
                        width: Screens.width(context) * 0.4),
                  ),
                   context.watch<SettlementController>().errormsg!
                                                      .contains("Network Issue")
                                                  ? Text(
                                                      "NO INTERNET CONNECTION",
                                                      style: theme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: theme
                                                                  .primaryColor),
                                                    )
                                                  : Container(),
                                              context.watch<SettlementController>().errormsg!
                                                      .contains("Network Issue")
                                                  ? Text(
                                                      "You are not connected to internet. Please connect to the internet and try again.",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: theme
                                                          .textTheme.bodyMedium!
                                                          .copyWith(),
                                                    )
                                                  : Container(),
                                              context.watch<SettlementController>().errormsg!
                                                      .contains("Network Issue")
                                                  ? Container():
                              Text(
                                  '${context.watch<SettlementController>().errormsg}',textAlign: TextAlign.center,),
                            ],
                          ))
                    : (context.read<SettlementController>().progress == false &&
                            context
                                .read<SettlementController>()
                                .settelGetListCard
                                .isEmpty &&
                            context.read<SettlementController>().errormsg == '')
                        ? Center(child: Column(
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
                              Text('No Data',textAlign: TextAlign.center,),
                            ],
                          ))
                        : ListView.builder(
                            itemCount: context
                                .read<SettlementController>()
                                .settelGetListCard
                                .length,
                            itemBuilder: (BuildContext context, int i) {
                              return InkWell(
                                onTap: () {
                                  SettlementPdfHelper.settlePayMode = context
                                      .read<SettlementController>()
                                      .settelGetListCard[i]
                                      .Mode;

                                  context
                                      .read<SettlementController>()
                                      .iselectMethodCard(
                                        i,
                                      );
                                },
                                child: Container(
                                  width: Screens.width(context),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Screens.width(context) * 0.02,
                                      vertical:
                                          Screens.bodyheight(context) * 0.01),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: context
                                                    .watch<
                                                        SettlementController>()
                                                    .settelGetListCard[i]
                                                    .isselect ==
                                                true
                                            ? Colors.green[100]
                                            : Colors.grey[300],
                                        borderRadius: BorderRadius.circular(5)),

                                    // color: Colors.grey[200],
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.02,
                                        vertical:
                                            Screens.bodyheight(context) * 0.01),
                                    width: Screens.width(context),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "Customer",
                                                style: theme.textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "# ${context.watch<SettlementController>().settelGetListCard[i].DocNum}",
                                                style: theme.textTheme.bodyMedium
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
                                            SizedBox(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                  "${context.watch<SettlementController>().settelGetListCard[i].CustomerName}",
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                    color: theme.primaryColor,
                                                    // fontWeight: FontWeight.bold
                                                  )),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                  '${context.watch<SettlementController>().config.alignDateT(context.watch<SettlementController>().settelGetListCard[i].DocDate.toString())}',
                                                  style: theme
                                                      .textTheme.bodyMedium
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
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "Total Amount",
                                                style: theme.textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "${context.watch<SettlementController>().settelGetListCard[i].Mode}",
                                                style: theme.textTheme.bodyMedium
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
                                            SizedBox(
                                              width:
                                                  Screens.width(context) * 0.5,
                                              child: Text(
                                                  "${context.read<SettlementController>().config.slpitCurrency22(context.watch<SettlementController>().settelGetListCard[i].totalAmount!.toString())}",
                                                  style: theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                    color: theme.primaryColor,
                                                    //fontWeight: FontWeight.bold
                                                  )),
                                            ),
                                            Container(
                                              //color:Colors.red,
                                              alignment: Alignment.centerRight,
                                              width:
                                                  Screens.width(context) * 0.3,
                                              child: Text(
                                                  '${context.read<SettlementController>().config.slpitCurrency22(context.watch<SettlementController>().settelGetListCard[i].Amount!.toString())}',
                                                  //"₹ ${context.watch<EnquiryMangerContoller>().getopenEnqData[i].PotentialValue}",
                                                  style: theme
                                                      .textTheme.bodyMedium
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
                                        context
                                                .watch<SettlementController>()
                                                .settelGetListCard[i]
                                                .ref!
                                                .isEmpty
                                            ? Container()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    padding: EdgeInsets.all(
                                                        Screens.bodyheight(
                                                                context) *
                                                            0.005),
                                                    // width: Screens.width(context) * 0.08,
                                                    // height: Screens.bodyheight(context)*0.04,
                                                    decoration: BoxDecoration(
                                                        color: context
                                                                    .watch<
                                                                        SettlementController>()
                                                                    .settelGetListCard[
                                                                        i]
                                                                    .isselect ==
                                                                true
                                                            ? Colors.grey[100]
                                                            : Colors.green
                                                                .withOpacity(
                                                                    0.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                        '${context.watch<SettlementController>().settelGetListCard[i].ref}',
                                                        //"₹ ${context.watch<EnquiryMangerContoller>().getopenEnqData[i].PotentialValue}",
                                                        style: theme
                                                            .textTheme.bodyMedium
                                                            ?.copyWith(
                                                          color: theme
                                                              .primaryColor,
                                                          //fontWeight: FontWeight.bold
                                                        )),
                                                  ),
                                                ],
                                              ),
                                        // SizedBox(
                                        //   height: Screens.bodyheight(context) * 0.01,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
          ),
          Column(
            children: [
              Container(
                width: Screens.width(context),
                height: Screens.bodyheight(context) * 0.06,
                //  padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color:
                        Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                    ,
                    border: Border.all(color: theme.primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Card Total Rs.${context.watch<SettlementController>().totalCard()}",
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.primaryColor,
                        ))
                  ],
                ),
              ),
              Container(
                width: Screens.width(context),
                height: Screens.bodyheight(context) * 0.077,
                padding: EdgeInsets.symmetric(
                    // horizontal: Screens.width(context) * 0.01,
                    vertical: Screens.bodyheight(context) * 0.005),
                child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<SettlementController>()
                          .validateMethodcard(context);
                      //  showDialog<dynamic>(
                      //     context: context,
                      //     builder: (_) {
                      //          // context.read<EnquiryUserContoller>(). showSpecificDialog();
                      //        //   context.read<EnquiryUserContoller>().showSuccessDia();
                      //       return CashAlertBox(indx: 1,);
                      //     });
                      // Get.toNamed(ConstantRoutes.cameraPage);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Submit Settlement')),
              ),
            ],
          )
        ],
      ),
    );
  }
}
