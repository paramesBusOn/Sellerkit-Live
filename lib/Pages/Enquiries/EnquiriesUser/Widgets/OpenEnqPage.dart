// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';

import '../../../../Constant/Screen.dart';
// import '../../../../Controller/EnquiryController/EnquiryMngController.dart';
import '../../../../Controller/EnquiryController/EnquiryUserContoller.dart';
import 'GlobalKeys.dart';
import 'OpenUserDialog.dart';


class OpenEnqPage extends StatefulWidget {
  const OpenEnqPage({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  State<OpenEnqPage> createState() => _OpenEnqPageState();
}

class _OpenEnqPageState extends State<OpenEnqPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
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
              child: RefreshIndicator(
                // key: new GlobalKey<RefreshIndicatorState>(),
                // key: RIKeys.riKey1,
                onRefresh:(){
                  return  context.read<EnquiryUserContoller>().swipeRefreshIndicator();
                } ,
                child:context.watch<EnquiryUserContoller>().filteropenEnqData.isEmpty?Center(
                  child: Column(
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
                  ),
                ) :  ListView.builder(
                  itemCount:
                      context.watch<EnquiryUserContoller>().filteropenEnqData.length,
                  itemBuilder: (BuildContext context, int i) {
                    return InkWell(
                      onDoubleTap: () {
                       showDialog<dynamic>(
                            context: context,
                            builder: (_) {
                               context.read<EnquiryUserContoller>().assignto = false;
                                 context.read<EnquiryUserContoller>().resetUserSelection(); 
                                 // context.read<EnquiryUserContoller>(). showSpecificDialog();
                               //   context.read<EnquiryUserContoller>().showSuccessDia();
                              return AssignedToDialogUser(indx: i,openenqdata:context.watch<EnquiryUserContoller>().filteropenEnqData[i]);
                            }).then((value) {
                              if( context.read<EnquiryUserContoller>().getassignedToApiActResp!='' ||
                              context.read<EnquiryUserContoller>().statusUpdateApiResp !=''
                              ){
                              context.read<EnquiryUserContoller>().swipeRefreshIndicator();
                              }
                            });
                      },
                      onLongPress: () {
                       showDialog<dynamic>(
                            context: context,
                            builder: (_) {
                               context.read<EnquiryUserContoller>().assignto = false;
                                 context.read<EnquiryUserContoller>().resetUserSelection(); 
                              return AssignedToDialogUser(indx: i,openenqdata:context.watch<EnquiryUserContoller>().filteropenEnqData[i]);
                            }).then((value) {
                              if( context.read<EnquiryUserContoller>().getassignedToApiActResp!='' ||
                              context.read<EnquiryUserContoller>().statusUpdateApiResp !=''
                              ){
                              context.read<EnquiryUserContoller>().swipeRefreshIndicator();
                              }
                            });
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
                                      style: widget.theme.textTheme.bodyText2
                                          ?.copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    width: Screens.width(context) * 0.4,
                                    child: Text(
                                      "Date",
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
                                        "${context.watch<EnquiryUserContoller>().filteropenEnqData[i].CardName}",
                                        style: widget.theme.textTheme.bodyText2?.copyWith(
                                            color: widget.theme.primaryColor,
                                           // fontWeight: FontWeight.bold
                                            )),
                                  ),
                                  
                                  Container(
                                    alignment: Alignment.centerRight,
                                    width: Screens.width(context) * 0.4,
                                    child: Text(
                                        context
                                            .watch<EnquiryUserContoller>()
                                            .config
                                            .alignDate(
                                                "${context.watch<EnquiryUserContoller>().filteropenEnqData[i].EnqDate}"),
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
                                        "",
                                        style: widget.theme.textTheme.bodyText2?.copyWith(
                                            color: widget.theme.primaryColor,
                                           // fontWeight: FontWeight.bold
                                            )),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    width: Screens.width(context) * 0.4,
                                    child: Text(
                                        "#${context.watch<EnquiryUserContoller>().filteropenEnqData[i].EnqID}",
                                        style: widget.theme.textTheme.bodyText2?.copyWith(
                                            color: Colors.grey,
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
                                      style: widget.theme.textTheme.bodyText2
                                          ?.copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    width: Screens.width(context) * 0.4,
                                    child: Text(
                                      "Potential Value",
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
                                    width: Screens.width(context) * 0.5,
                                    child: Text(
                                        "Looking for ${context.watch<EnquiryUserContoller>().filteropenEnqData[i].Lookingfor}",
                                        style: widget.theme.textTheme.bodyText2?.copyWith(
                                            color:widget.theme.primaryColor,
                                            //fontWeight: FontWeight.bold
                                            )),
                                  ),
                                  Container(
                                    //color:Colors.red,
                                    alignment: Alignment.centerRight,
                                    width: Screens.width(context) * 0.3,
                                    child: Text(
                                      context.watch<EnquiryUserContoller>().config.slpitCurrency(
                                        context.watch<EnquiryUserContoller>().filteropenEnqData[i].PotentialValue!.toStringAsFixed(0)
                                      ),
                                        //"₹ ${context.watch<EnquiryUserContoller>().filteropenEnqData[i].PotentialValue}",
                                        style: widget.theme.textTheme.bodyText2?.copyWith(
                                            color:widget.theme.primaryColor,
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
                                        "Call assigned to ${context.watch<EnquiryUserContoller>().filteropenEnqData[i].AssignedTo_UserName}",
                                        style: widget.theme.textTheme.bodyText2?.copyWith(
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
                                          "${context.watch<EnquiryUserContoller>().filteropenEnqData[i].Status}",
                                          style: widget.theme.textTheme.bodyText2?.copyWith(
                                              color: Colors.green[700],
                                              fontSize: 12
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
                                        borderRadius: BorderRadius.circular(4)
                                      ),
                                   // width: Screens.width(context) * 0.1,
                                      child: Text(
                                          "${context.watch<EnquiryUserContoller>().filteropenEnqData[i].customerGroup}",
                                          style: widget.theme.textTheme.bodyText2?.copyWith(
                                              color: Colors.grey,
                                              fontSize: 12,
      
                                             fontWeight: FontWeight.w500
                                              )),
                                    ),
                              context.watch<EnquiryUserContoller>().filteropenEnqData[i].InterestLevel ==null|| context.watch<EnquiryUserContoller>().filteropenEnqData[i].InterestLevel!.isEmpty?Container():       Container(
                                    // color: Colors.amber,
                                  alignment: Alignment.centerRight,
                                  //  width: Screens.width(context) * 0.5,
                                    padding: EdgeInsets.only(
                                        left: Screens.width(context) * 0.02,
                                        right: Screens.width(context) * 0.02,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.orange[100],
                                        borderRadius: BorderRadius.circular(4)
                                      ),
                                    child:
                                         Text(
                                            "${context.watch<EnquiryUserContoller>().filteropenEnqData[i].InterestLevel.toString()}", style: widget.theme.textTheme.bodyText2?.copyWith(
                                               fontSize: 12,
                                                color:Colors.grey,
                                                fontStyle: FontStyle.italic
                                               
                                               // fontWeight: FontWeight.bold
                                                )),
                                       
                                     
                                  )
                                ],
                              ),

                               Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                //  Container(
                                //       padding: EdgeInsets.only(
                                //         left: Screens.width(context) * 0.02,
                                //         right: Screens.width(context) * 0.02,
                                //       ),
                                //       // decoration: BoxDecoration(
                                //       //   color: Colors.orange[100],
                                //       //   borderRadius: BorderRadius.circular(4)
                                //       // ),
                                //    // width: Screens.width(context) * 0.1,
                                //       child: Text(
                                //           "",
                                //           style: widget.theme.textTheme.bodyText2?.copyWith(
                                //               color: Colors.grey,
                                //               fontSize: 12,
      
                                //              fontWeight: FontWeight.w500
                                //               )),
                                //     ),
                                  context.watch<EnquiryUserContoller>().filteropenEnqData[i].isVisitRequired !="Y"?Container():   Container(
                                    // color: Colors.amber,
                                  alignment: Alignment.centerRight,
                                   width: Screens.width(context) * 0.5,
                                    child:
                                         Text(
                                            "Site Visit on\t${context
                                              .watch<EnquiryUserContoller>()
                                              .config
                                              .alignDate(context.watch<EnquiryUserContoller>().filteropenEnqData[i].visitTime.toString())}", style: widget.theme.textTheme.bodyText2?.copyWith(
                                               fontSize: 12,
                                                color:Colors.grey,
                                                fontStyle: FontStyle.italic
                                               
                                               // fontWeight: FontWeight.bold
                                                )),
                                       
                                     
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
      ),
    );
  }
}
