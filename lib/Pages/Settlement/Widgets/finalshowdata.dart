

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/SettlementController/SettlementController.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/SettlementPdfHelper.dart';

class finalshown extends StatefulWidget {
  const finalshown({ Key? key, required this.theme,required this.name}) : super(key: key);
 final ThemeData theme;
 final String name;
  @override
  State<finalshown> createState() => _finalshownState();
}

class _finalshownState extends State<finalshown> {
  @override
  Widget build(BuildContext context) {
     var filteredList = context
        .watch<SettlementController>()
        .settelGetList
        .where((doc) => doc.Mode == widget.name)
        .toList();
    return Container(
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
              child: ListView.builder(
                              itemCount: filteredList
                                  .length,
                              itemBuilder: (BuildContext context, int i) {
                                return    InkWell(
                                  onTap: () {
                                     SettlementPdfHelper.settlePayMode = filteredList[i]
                                      .Mode;
                                    context
                                        .read<SettlementController>()
                                        .iselectMethodfinal(
                                          filteredList[i],
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
                                          color: filteredList[i]
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
                                                  "# ${filteredList[i].DocNum}",
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
                                                    "${filteredList[i].CustomerName}",
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
                                                    '${context.watch<SettlementController>().config.alignDateT(filteredList[i].DocDate.toString())}',
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
                                                  "${filteredList[i].Mode}",
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
                                                          .config.slpitCurrency22(filteredList[i].totalAmount!.toString())}",
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
                                                          .config.slpitCurrency22(filteredList[i].Amount.toString())}',
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
                                        filteredList[i].ref!.isEmpty?Container():  Row(
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
                                                    color: filteredList[
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
                                                    '${filteredList[i].ref}',
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
              )
        
       ,  Column(
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
                          "${widget.name} Total Rs.${context.watch<SettlementController>().totalfinal(widget.name)}",
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
                            .validatepopup(widget.name,context);
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