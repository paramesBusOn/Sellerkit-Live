import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/OpenLeadController/OpenLeadController.dart';
import '../Widegts/OpenLeadFDP.dart';

class ListViewOpenLead extends StatefulWidget {
  ListViewOpenLead({
    Key? key,
    required this.theme,
    // required this.prdFUP
  }) : super(key: key);
// OpenLeadController prdFUP;
  final ThemeData theme;

  @override
  State<ListViewOpenLead> createState() => _ListViewOpenLeadState();
}

class _ListViewOpenLeadState extends State<ListViewOpenLead> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.01,
          vertical: Screens.bodyheight(context) * 0.01),
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
            // Container(
            //       // padding: EdgeInsets.symmetric(
            //       //         horizontal: Screens.bodyheight(context) * 0.02),
            //     child: Column(
            //       children: [
            //         Container(
            //                         height: Screens.bodyheight(context) * 0.06,
            //                         decoration: BoxDecoration(
            //                             color: Colors.grey[200],
            //                             borderRadius: BorderRadius.circular(
            //                                 Screens.width(context) * 0.02),
            //                             // boxShadow: [
            //                             //   BoxShadow(
            //                             //     color: Colors.grey.withOpacity(0.01),
            //                             //     spreadRadius: 3,
            //                             //     blurRadius: 4,
            //                             //     offset: Offset(
            //                             //         0, 3), // changes position of shadow
            //                             //   ),
            //                             // ]
            //                             ),
            //                         child: TextField(
            //                           controller:context.read<OpenLeadController>().mycontroller[5] ,
            //                           onTap: () {
                          
            //                             // Get.toNamed(ConstantRoutes.screenshot);
            //                           },
            //                           autocorrect: false,
            //                           onChanged: (v) {
                                           
            //                             context.read<OpenLeadController>().SearchFilterOpenTab(v);
                          
                                     
                          
                          
            //                           },
            //                           decoration: InputDecoration(
            //                             filled: false,
            //                             hintText: 'Search',
            //                             enabledBorder: InputBorder.none,
            //                             focusedBorder: InputBorder.none,
            //                             suffixIcon: Icon(
            //                               Icons.search,
            //                               color: widget.theme.primaryColor,
            //                             ),
            //                             contentPadding: const EdgeInsets.symmetric(
            //                               vertical: 12,
            //                               horizontal: 5,
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //       ],
            //     ),
            //   ),
            // InkWell(
            //   onTap: () {
            //     context.read<OpenLeadController>().getDistinct();
            //     context.read<OpenLeadController>().firstPageNextBtn();
            //   },
            //   child: Container(
            //     height: Screens.bodyheight(context) * 0.06,
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius:
            //             BorderRadius.circular(Screens.width(context) * 0.01),
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey.withOpacity(0.7),
            //             spreadRadius: 3,
            //             blurRadius: 4,
            //             offset: Offset(0, 3), // changes position of shadow
            //           ),
            //         ]),
            //     child: TextField(
            //       onTap: () {
            //         context.read<OpenLeadController>().getDistinct();
            //         context.read<OpenLeadController>().firstPageNextBtn();
            //       },
            //       autocorrect: false,
            //       readOnly: true,
            //       onChanged: (v) {},
            //       decoration: InputDecoration(
            //         filled: false,
            //         hintText: 'All',
            //         enabledBorder: InputBorder.none,
            //         focusedBorder: InputBorder.none,
            //         suffixIcon: Icon(
            //           Icons.filter_alt,
            //           color: widget.theme.primaryColor,
            //         ),
            //         contentPadding: const EdgeInsets.symmetric(
            //           vertical: 12,
            //           horizontal: 5,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.015,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return context
                      .read<OpenLeadController>()
                      .swipeRefreshIndiactor();
                },
                child:context.watch<OpenLeadController>().filterleadOpenAllData.isEmpty? Center(child: Column(
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
                         Text("No Data..!!",textAlign: TextAlign.center),
                       ],
                     )):
                
                
                 ListView.builder(
                  itemCount:
                      context.watch<OpenLeadController>().filterleadOpenAllData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onDoubleTap: () {
                        // context.read<OpenLeadController>().clearAlertboxVariable();
                        showDialog<dynamic>(
                            context: context,
                            builder: (_) {
                              return OpenLeadFDP(
                                  index: index,
                                  followUPListData: context
                                      .read<OpenLeadController>()
                                      .filterleadOpenAllData[index]);
                            }).then((value) { 
                              setState(() {
                                   context.read<OpenLeadController>().clearAlertboxVariable();
                          context.read<OpenLeadController>().callGetAllApi();
                              });
                           
                          }
                            );
                      },
                      onLongPress: () {
                        // context.read<OpenLeadController>().clearAlertboxVariable();
                        showDialog<dynamic>(
                            context: context,
                            builder: (_) {
                              return OpenLeadFDP(
                                  index: index,
                                  followUPListData: context
                                      .watch<OpenLeadController>()
                                      .filterleadOpenAllData[index]);
                            }).then((value) { 
                              setState(() {
                                   context.read<OpenLeadController>().clearAlertboxVariable();
                          context.read<OpenLeadController>().callGetAllApi();
                              });
                           
                          }
                            );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            // horizontal: Screens.width(context) * 0.02,
                            vertical: Screens.bodyheight(context) * 0.01),
                        width: Screens.width(context),
                        // padding: EdgeInsets.symmetric(
                        //     horizontal: Screens.width(context) * 0.02,
                        //     vertical: Screens.bodyheight(context) * 0.006),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.02,
                                  vertical: Screens.bodyheight(context) * 0.006),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black26)),
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
                                          style: widget.theme.textTheme.bodyText2
                                              ?.copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Text(
                                          "",
                                          style: widget.theme.textTheme.bodyText2
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
                                        child: Text(
                                            "${context.watch<OpenLeadController>().filterleadOpenAllData[index].CustomerName}",
                                            style:
                                                widget.theme.textTheme.bodyText2?.copyWith(
                                              color: widget.theme.primaryColor,
                                            )),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                            "# ${context.watch<OpenLeadController>().filterleadOpenAllData[index].LeadNum}",
                                            style:
                                                widget.theme.textTheme.bodyText2?.copyWith(
                                              color: widget.theme.primaryColor,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.01,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: Screens.width(context),
                                        child: Text(
                                          "Product",
                                          style: widget.theme.textTheme.bodyText2
                                              ?.copyWith(color: Colors.grey),
                                        ),
                                      ),
                                      Container(
                                        width: Screens.width(context),
                                        child: Text(
                                            "${context.watch<OpenLeadController>().filterleadOpenAllData[index].Product}",
                                            style: widget.theme.textTheme.bodyText2),
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
                                        child: Text("Next Follow up",
                                            style: widget.theme.textTheme.bodyText2
                                                ?.copyWith(color: Colors.grey)),
                                      ),
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        //color: Colors.red,
                                        alignment: Alignment.centerRight,
                                        child: Text("Order Value",
                                            style: widget.theme.textTheme.bodyText2
                                                ?.copyWith(color: Colors.grey)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: Screens.width(context) * 0.4,
                                        child: Text(
                                           context
                                                .read<OpenLeadController>()
                                                . filterleadOpenAllData[index]
                                                            .NextFollowup!.isEmpty
                                                        ? '':
                                                        context
                                                .read<OpenLeadController>()
                                                .config
                                                .alignDate(
                                                    "${context.watch<OpenLeadController>().filterleadOpenAllData[index].NextFollowup}"),
                                            style: widget.theme.textTheme.bodyText2
                                                ?.copyWith()),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          width: Screens.width(context) * 0.4,
                                          child: Text(
                                              context
                                                  .read<OpenLeadController>()
                                                  .config
                                                  .slpitCurrency(
                                                      "${context.watch<OpenLeadController>().filterleadOpenAllData[index].Value!.toStringAsFixed(0)}"),
                                              style: widget.theme.textTheme.bodyText2
                                                  ?.copyWith()),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.01,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: Screens.width(context),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                            left: Screens.width(context) * 0.02,
                                            right: Screens.width(context) * 0.02,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.green[200],
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Text(
                                           context.watch<OpenLeadController>().  filterleadOpenAllData[index]
                                                              .LastUpdateTime!
                                                              .isEmpty
                                                          ? ''
                                                          : "${context.watch<OpenLeadController>().filterleadOpenAllData[index].LastUpdateMessage} ",
                                              style: widget.theme.textTheme.bodyText2
                                                  ?.copyWith(
                                                color: Colors.green[700],
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.01,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: Screens.width(context),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(4)),
                                      child: Text(
                                          context
                                                      .watch<OpenLeadController>()
                                                      .filterleadOpenAllData[index]
                                                      .createdDate !=
                                                  ''
                                              ?"Created Date:"+ 
                                              context
                                                  .read<OpenLeadController>()
                                                  .config
                                                  .alignDate(
                                                      "${context.watch<OpenLeadController>().filterleadOpenAllData[index].createdDate}")
                                              : '',
                                          style:
                                              widget.theme.textTheme.bodyText2?.copyWith(
                                            color: Colors.grey,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
