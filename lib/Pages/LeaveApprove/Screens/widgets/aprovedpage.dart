
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/LeaveApproveController/LeaveApproveController.dart';

class approvepage extends StatefulWidget {
   approvepage({Key? key, required this.theme,}) : super(key: key);
final ThemeData theme;
  @override
  State<approvepage> createState() => _approvepageState();
}

class _approvepageState extends State<approvepage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:GestureDetector(onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.dashboard);
                      });
                    }
                  },
            child: 
            Stack(
              children: [
                Container(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context),
                  // padding: paddings.padding2(context),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      // SearchWidget(themes: theme),
                      // SearchbarWidget(
                      //   theme: theme,
                      //   accountsContoller: prdACC,
                      // ),
                      // Container(
                      //   height: Screens.bodyheight(context) * 0.06,
                      //   decoration: BoxDecoration(
                      //     color: widget.theme.primaryColor
                      //         .withOpacity(0.1), //Colors.grey[200],
                      //     borderRadius: BorderRadius.circular(
                      //         Screens.width(context) * 0.02),
                      //   ),
                      //   child: TextField(
                      //     autocorrect: false,
                      //     onChanged: (v) {
                      //       //srdACC.SearchFilter(v);
                      //     },
                      //     decoration: InputDecoration(
                      //       filled: false,
                      //       hintText: 'Search Here!!..',
                      //       enabledBorder: InputBorder.none,
                      //       focusedBorder: InputBorder.none,
                      //       suffixIcon: IconButton(
                      //         icon: const Icon(Icons.search),
                      //         onPressed: () {
                      //           FocusScopeNode focus = FocusScope.of(context);
                      //           if (!focus.hasPrimaryFocus) {
                      //             focus.unfocus();
                      //           }
                      //           // accountsContoller.boolmethod();
                      //           // Get.offAllNamed(ConstantRoutes.cartLoading);
                      //           // setState(() {
                      //           // prdACC.boolmethod();
                      //           // });
                      //         }, //
                      //         color: widget.theme.primaryColor,
                      //       ),
                      //       contentPadding: const EdgeInsets.symmetric(
                      //         vertical: 12,
                      //         horizontal: 5,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.005,
                      ),
                context
                              .watch<LeaveApproveContoller>()
                              .leaveapprovedetails.isEmpty?Center(child: Column(
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
                                  Text("No Data..!!",textAlign: TextAlign.center,),
                                ],
                              ),):
                              
                                   Expanded(
                        child: ListView.builder(
                          itemCount: context
                              .watch<LeaveApproveContoller>()
                              .leaveapprovedetails
                              .length,
                          //  prdACC
                          //     .getAccountsDataFilter
                          //     .length,
                          // prdACC.getAccountsData.length,
                          itemBuilder: (BuildContext context, int i) {
                            return InkWell(
                                // onTap: () {
                                //   context
                                //       .read<LeaveApproveContoller>()
                                //       .setReqData(context
                                //           .read<LeaveApproveContoller>()
                                //           .leaveapprovedetails[i]);
                                //   // AccountsDetailsState
                                //   //         .data =
                                //   //     "Balamurugan";
                                //   Get.toNamed(ConstantRoutes.leaveApprove);
                                // },
                              child: Container(
                                // color: Colors.amber,
                                width: Screens.width(context),
                                                  padding: EdgeInsets.symmetric(
                              horizontal: Screens.width(context) * 0.02,
                              vertical: Screens.bodyheight(context) * 0.01
                              ),
                              child: Container(
                                
                                                    padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.02,
                                vertical: Screens.bodyheight(context) * 0.01
                                ),
                                decoration: BoxDecoration(
 color: Colors.grey[200],
 border: Border.all(color: Colors.black26),
 borderRadius: BorderRadius.circular(5)
                                ),
                            
                                                    width: Screens.width(context),
                                                    child: Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Container(
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                        "Name",
                                        style: widget.theme.textTheme.bodyText2
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                        "User Code",
                                        style: widget.theme.textTheme.bodyText2
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                    ),
                            
                              ],),
                                                   //2nd
                                                   Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Container(
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                        "${context.read<LeaveApproveContoller>().leaveapprovedetails[i].userName}",
                                        style: widget.theme.textTheme.bodyText2
                                            ?.copyWith(color: widget.theme.primaryColor),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                        "${context.read<LeaveApproveContoller>().leaveapprovedetails[i].userCode}",
                                        style: widget.theme.textTheme.bodyText2
                                            ?.copyWith(color:widget.theme.primaryColor),
                                      ),
                                    ),
                            
                              ],),
                              SizedBox(
                                height: Screens.padingHeight(context)*0.01,
                              ),
                                                    Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Container(
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                        "Leave Type",
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
                            
                              ],),
                                                  
                                                  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Container(
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                        "${context.read<LeaveApproveContoller>().leaveapprovedetails[i].leaveRequestType}",
                                        style: widget.theme.textTheme.bodyText2
                                            ?.copyWith(color: widget.theme.primaryColor),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context) * 0.45,
                                      child: Text(
                                        "${context.read<LeaveApproveContoller>().config.alignDate(context.read<LeaveApproveContoller>().leaveapprovedetails[i].startDate.toString()) }",
                                        style: widget.theme.textTheme.bodyText2
                                            ?.copyWith(color:widget.theme.primaryColor),
                                      ),
                                    ),
                            
                              ],),
                               SizedBox(
                                    height: Screens.padingHeight(context)*0.01,
                                  ),
                                     Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      //  Container(
                                      //     width: Screens.width(context) * 0.4,
                                      //     child: Text(
                                      //       "${context.read<LeaveReqContoller>().getallleavereqdetails[i].leaveRequestType}",
                                      //       style: theme.textTheme.bodyText2
                                      //           ?.copyWith(color: theme.primaryColor),
                                      //     ),
                                      //   ),
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
                                          child:
                                           Text(
                                              "Approved",
                                              style:widget. theme.textTheme.bodyText2?.copyWith(
                                                  color: Colors.green[700],
                                                  fontSize: 12
                                                 // fontWeight: FontWeight.bold
                                                  )
                                                  ),
                                        ),
                                      )
                            
                                  ],),
                                                    ],),
                            
                              ),
                              ),
                            );
                            
                            
                            // Card(
                            //   elevation: 4,
                            //   shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(8)),
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       context
                            //           .read<LeaveApproveContoller>()
                            //           .setReqData(context
                            //               .read<LeaveApproveContoller>()
                            //               .leaveapprovedetails[i]);
                            //       // AccountsDetailsState
                            //       //         .data =
                            //       //     "Balamurugan";
                            //       Get.toNamed(ConstantRoutes.leaveApprove);
                            //     },
                            //     child: Container(
                            //       padding: EdgeInsets.all(
                            //           Screens.bodyheight(context) * 0.005),
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(10),
                            //       ),
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.spaceBetween,
                            //             children: [
                            //               Container(
                            //                 padding: EdgeInsets.all(
                            //                     Screens.bodyheight(context) *
                            //                         0.002),
                            //                 alignment: Alignment.topLeft,
                            //                 // color: Colors.amber,
                            //                 // width: Screens.width(context) * 0.8,
                            //                 child: Text(
                            //                   "${context.read<LeaveApproveContoller>().leaveapprovedetails[i].empId}",
                            //                   // "${AccountsData[i].cardname}",
                            //                   // "${prdACC.getAccountsDataFilter[i].cardname}",
                            //                   style: theme.textTheme.bodyText1
                            //                       ?.copyWith(),
                            //                 ),
                            //               ),
                            //               Container(
                            //                 padding: EdgeInsets.all(
                            //                     Screens.bodyheight(context) *
                            //                         0.002),
                            //                 // color: Colors.amber,
                            //                 alignment: Alignment.centerLeft,
                            //                 // width: Screens.width(context) * 0.8,
                            //                 child: Text(
                            //                   "${context.read<LeaveApproveContoller>().leaveapprovedetails[i].empName}",
                            //                   // "${AccountsData[i].street}",
                            //                   // "${prdACC.getAccountsDataFilter[i].cardcode}",
                            //                   textAlign: TextAlign.left,
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
          
                            //           // SizedBox(
                            //           //   height:
                            //           //       Screens.bodyheight(context) * 0.01,
                            //           // ),
          
                            //           IntrinsicHeight(
                            //             child: Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.spaceBetween,
                            //               children: [
                            //                 Container(
                            //                   alignment: Alignment.topLeft,
                            //                   padding: EdgeInsets.all(
                            //                       Screens.bodyheight(context) *
                            //                           0.005),
                            //                   width: Screens.width(context) * 0.4,
                            //                   child: Text(
                            //                     "${context.read<LeaveApproveContoller>().leaveapprovedetails[i].leaveType}",
                            //                     style: theme.textTheme.bodyText1
                            //                         ?.copyWith(),
                            //                   ),
                            //                 ),
                            //                 Container(
                            //                   padding: EdgeInsets.all(
                            //                       Screens.bodyheight(context) *
                            //                           0.005),
          
                            //                   alignment: Alignment.bottomRight,
                            //                   // width: Screens.width(context),
                            //                   child: Text(
                            //                     "${context.read<LeaveApproveContoller>().leaveapprovedetails[i].createdDate}",
                            //                     style: theme.textTheme.bodySmall
                            //                         ?.copyWith(
                            //                             color: Colors.grey),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // );
                          },
                        ),
                      )
                   
                   
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}