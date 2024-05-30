// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Pages/Enquiries/EnquiryManger/Widgets/AssignedtoDilaog.dart';

import '../../../../Constant/Screen.dart';
import '../../../../Controller/EnquiryController/EnquiryMngController.dart';
import '../../../Controller/SettlementController/SettlementController.dart';
import 'CashSavePop.dart';
import 'SettlementPdfHelper.dart';

class CashTabPage extends StatefulWidget {
  const CashTabPage({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  State<CashTabPage> createState() => _CashTabPageState();
}

class _CashTabPageState extends State<CashTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.03,
          vertical: Screens.bodyheight(context) * 0.02),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
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
              child: (context.read<SettlementController>().progress == true &&
                      context
                          .read<SettlementController>()
                          .settelGetListCash
                          .isEmpty &&
                      context.read<SettlementController>().errormsg == '')
                  ? Center(child: CircularProgressIndicator())
                  : (context.read<SettlementController>().progress == false &&
                          context
                              .read<SettlementController>()
                              .settelGetListCash
                              .isEmpty &&
                          context.read<SettlementController>().errormsg != '')
                      ? Center(
                          child: Column(
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
                        width: Screens.width(context)*0.5
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
                              Text(
                                  '${context.watch<SettlementController>().errormsg}',textAlign: TextAlign.center,),
                            ],
                          ))
                      : (context.read<SettlementController>().progress ==
                                  false &&
                              context
                                  .read<SettlementController>()
                                  .settelGetListCash
                                  .isEmpty &&
                              context.read<SettlementController>().errormsg ==
                                  '')
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
                          )
                          )
                          : ListView.builder(
                              itemCount: context
                                  .read<SettlementController>()
                                  .settelGetListCash
                                  .length,
                              itemBuilder: (BuildContext context, int i) {
                                return InkWell(
                                  onTap: () {
                                     SettlementPdfHelper.settlePayMode = context
                                      .read<SettlementController>()
                                      .settelGetListCash[i]
                                      .Mode;
                                    context
                                        .read<SettlementController>()
                                        .iselectMethodCash(
                                          i,
                                        );
                                  },
                                  child: Container(
                                    width: Screens.width(context),
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.02,
                                        vertical:
                                            Screens.bodyheight(context) * 0.01),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: context
                                                      .watch<
                                                          SettlementController>()
                                                      .settelGetListCash[i]
                                                      .isselect ==
                                                  true
                                              ? Colors.green[100]
                                              : Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(5)),

                                      // color: Colors.grey[200],
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              Screens.width(context) * 0.02,
                                          vertical:
                                              Screens.bodyheight(context) *
                                                  0.01),
                                      width: Screens.width(context),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: Text(
                                                  "Customer",
                                                  style: widget
                                                      .theme.textTheme.bodyText2
                                                      ?.copyWith(
                                                          color: Colors.grey),
                                                ),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: Text(
                                                  "# ${context.watch<SettlementController>().settelGetListCash[i].DocNum}",
                                                  style: widget
                                                      .theme.textTheme.bodyText2
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
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: Text(
                                                    "${context.watch<SettlementController>().settelGetListCash[i].CustomerName}",
                                                    style: widget.theme
                                                        .textTheme.bodyText2
                                                        ?.copyWith(
                                                      color: widget
                                                          .theme.primaryColor,
                                                      // fontWeight: FontWeight.bold
                                                    )),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: Text(
                                                    '${context.watch<SettlementController>().config.alignDateT(context.watch<SettlementController>().settelGetListCash[i].DocDate.toString())}',
                                                    style: widget.theme
                                                        .textTheme.bodyText2
                                                        ?.copyWith(
                                                      color: widget
                                                          .theme.primaryColor,
                                                      //fontWeight: FontWeight.bold
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.01,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: Text(
                                                  "Total Amount",
                                                  style: widget
                                                      .theme.textTheme.bodyText2
                                                      ?.copyWith(
                                                          color: Colors.grey),
                                                ),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: Text(
                                                  "${context.watch<SettlementController>().settelGetListCash[i].Mode}",
                                                  style: widget
                                                      .theme.textTheme.bodyText2
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
                                                width: Screens.width(context) *
                                                    0.5,
                                                child: Text(
                                                    "${context
                                                          .read<
                                                              SettlementController>()
                                                          .config.slpitCurrency22(context.watch<SettlementController>().settelGetListCash[i].totalAmount!.toString())}",
                                                    style: widget.theme
                                                        .textTheme.bodyText2
                                                        ?.copyWith(
                                                      color: widget
                                                          .theme.primaryColor,
                                                      //fontWeight: FontWeight.bold
                                                    )),
                                              ),
                                              Container(
                                                //color:Colors.red,
                                                alignment:
                                                    Alignment.centerRight,
                                                width: Screens.width(context) *
                                                    0.3,
                                                child: Text(
                                                    '${context
                                                          .read<
                                                              SettlementController>()
                                                          .config.slpitCurrency22(context.watch<SettlementController>().settelGetListCash[i].Amount.toString())}',
                                                    //"₹ ${context.watch<EnquiryMangerContoller>().getopenEnqData[i].PotentialValue}",
                                                    style: widget.theme
                                                        .textTheme.bodyText2
                                                        ?.copyWith(
                                                      color: widget
                                                          .theme.primaryColor,
                                                      //fontWeight: FontWeight.bold
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.01,
                                          ),
                                        context.watch<SettlementController>().settelGetListCash[i].ref!.isEmpty?Container():  Row(
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
                                                                .settelGetListCash[
                                                                    i]
                                                                .isselect ==
                                                            true
                                                        ? Colors.grey[100]
                                                        : Colors.green
                                                            .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                    '${context.watch<SettlementController>().settelGetListCash[i].ref}',
                                                    //"₹ ${context.watch<EnquiryMangerContoller>().getopenEnqData[i].PotentialValue}",
                                                    style: widget.theme
                                                        .textTheme.bodyText2
                                                        ?.copyWith(
                                                      color: widget
                                                          .theme.primaryColor,
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
                      color: Color(
                          0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                      ,
                      border: Border.all(
                          color: widget.theme.primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "Cash Total Rs.${context.watch<SettlementController>().totalcash()}",
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          style: widget.theme.textTheme.bodyText1?.copyWith(
                            color: widget.theme.primaryColor,
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
                            .validateMethod(context);
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
                        backgroundColor: widget.theme.primaryColor,
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
      ),
    );
  }
}
