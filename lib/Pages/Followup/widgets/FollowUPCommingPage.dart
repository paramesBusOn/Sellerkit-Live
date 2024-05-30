// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/FollowupController/FollowUPController.dart';
import 'FollowUPDialogPg.dart';

class FollowUPComming extends StatelessWidget {
  FollowUPComming({Key? key, required this.prdFUP}) : super(key: key);
  FollowupController prdFUP;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: EdgeInsets.only(
        left: Screens.width(context) * 0.03,
        right: Screens.width(context) * 0.03,
        top: Screens.bodyheight(context) * 0.02,
        bottom: Screens.bodyheight(context) * 0.01,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Screens.width(context) * 0.02,
            ),
            width: Screens.width(context),
            padding: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.03,
                vertical: Screens.bodyheight(context) * 0.02),
            decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black26)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                      Container(
                        width: Screens.width(context) ,
                        child: Text(
                          // "
                        // #0 Leads are over due for followup",
                        "${prdFUP.getfollowUPKPIupcoming[0].OverdueKPI_Line_1}",
                          textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText1?.copyWith(
                          fontSize: 15
                        ),
                        ),
                      ),
                //         Container(
                //   width: Screens.width(context) ,
                //   child: Text("1",
                //   // ${prdFUP.getfollowUPKPIOverDue[0].UpcomingKPI_Line_1}",
                //   style: theme.textTheme.bodyText2?.copyWith(
                //     fontSize: 14
                //   ),
                //   ),
                // ),
                Divider(),
                Container(
                  width: Screens.width(context),
                   child: Text(
                    // "About 0.00% of your sales target can be acheived by following",
                    "${prdFUP.getfollowUPKPIupcoming[0].OverdueKPI_Line_2}",
                  //  ${prdFUP.getfollowUPKPIOverDue[0].UpcomingKPI_SmallLine_1}",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyText2?.copyWith(
                    fontSize: 12
                  ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: Screens.bodyheight(context) * 0.008,
          ),
          Expanded(
            child: prdFUP.fupUpcmListData.isEmpty?Center(child: Column(
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
                Text("No data..!!",textAlign: TextAlign.center,),
              ],
            )):ListView.builder(
              itemCount: prdFUP.fupUpcmListData.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onDoubleTap: (){
                    showDialog<dynamic>(
                            context: context,
                            builder: (_) {
                              return FollowUPDialogPG(index:index,followUPListData: prdFUP.fupUpcmListData[index]);
                            }).then((value) => prdFUP.swipeRefreshIndiactor());
                    },
                    onLongPress: (){
                       showDialog<dynamic>(
                            context: context,
                            builder: (_) {
                              return FollowUPDialogPG(index:index,followUPListData: prdFUP.fupUpcmListData[index]);
                            }).then((value) => prdFUP.swipeRefreshIndiactor());
                    },
                  child: Container(
                    width: Screens.width(context),
                    padding: EdgeInsets.symmetric(
                        horizontal: Screens.width(context) * 0.02,
                        vertical: Screens.bodyheight(context) * 0.006),
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
                                    width: Screens.width(context) * 0.4,
                                    child: Text(
                                      "",
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
                                        "${prdFUP.fupUpcmListData[index].Customer}",
                                        style:
                                            theme.textTheme.bodyText2?.copyWith(
                                          color: theme.primaryColor,
                                        )),
                                  ),
                                  Container(
                                    width: Screens.width(context) * 0.4,
                                    alignment: Alignment.centerRight,
                                    child: Text("#${prdFUP.fupUpcmListData[index].LeadDocNum}",
                                        style:
                                            theme.textTheme.bodyText2?.copyWith(
                                          color: theme.primaryColor,
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.01,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: Screens.width(context),
                                    child: Text(
                                      "Product",
                                      style: theme.textTheme.bodyText2
                                          ?.copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    width: Screens.width(context),
                                    child: Text("${prdFUP.fupUpcmListData[index].Product}",
                                        style: theme.textTheme.bodyText2),
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
                                    child: Text("Next Follow up",
                                        style: theme.textTheme.bodyText2
                                            ?.copyWith(color: Colors.grey)),
                                  ),
                                  Container(
                                    width: Screens.width(context) * 0.3,
                                    // color: Colors.red,
                                    alignment: Alignment.centerRight,
                                    child: Text("Order Value",
                                        style: theme.textTheme.bodyText2
                                            ?.copyWith(color: Colors.grey)),
                                  ),
                                  // Container(
                                  //   width: Screens.width(context) * 0.4,
                                  //   //color: Colors.red,
                                  //   alignment: Alignment.centerRight,
                                  //   child: Text("Followup Time",
                                  //       style: theme.textTheme.bodyText2
                                  //           ?.copyWith(color: Colors.grey)),
                                  // ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: Screens.width(context) * 0.4,
                                    child: Text(
                                      prdFUP.config.alignDate(
                                      "${prdFUP.fupUpcmListData[index].FollowupDate}"),
                                        style: theme.textTheme.bodyText2
                                            ?.copyWith()),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context) * 0.3,
                                      child: Text(
                                        prdFUP.config.slpitCurrency("${prdFUP.fupUpcmListData[index].DocTotal!.toStringAsFixed(0)}"),
                                          style: theme.textTheme.bodyText2
                                              ?.copyWith()),
                                    ),
                                  ),
                                  // InkWell(
                                  //   onTap: () {},
                                  //   child:prdFUP.config.alignDateFollowTime("${prdFUP.fupUpcmListData[index].FollowupDate}")=="00:00:00"?
                                  //   Container():
                                  //    Container(
                                  //     alignment: Alignment.centerRight,
                                  //     width: Screens.width(context) * 0.4,
                                  //     child: Text(
                                  //       prdFUP.config.alignDateFollowTime("${prdFUP.fupUpcmListData[index].FollowupDate}"),
                                  //         style: theme.textTheme.bodyText2
                                  //             ?.copyWith()),
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: Screens.width(context)*0.5,
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
                                              borderRadius: BorderRadius.circular(4)),
                                          child: Text("${prdFUP.fupUpcmListData[index].LastFollowupStatus}",
                                              style:
                                                  theme.textTheme.bodyText2?.copyWith(
                                                color: Colors.green[700],
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                              Column(
                                children: [
                                  // Container(
                                  //   width: Screens.width(context) * 0.3,
                                  //   // color: Colors.red,
                                  //   alignment: Alignment.centerRight,
                                  //   child: Text("Order Value",
                                  //       style: theme.textTheme.bodyText2
                                  //           ?.copyWith(color: Colors.grey)),
                                  // ),
                                // InkWell(
                                //     onTap: () {},
                                //     child: Container(
                                //       alignment: Alignment.centerRight,
                                //       width: Screens.width(context) * 0.3,
                                //       child: Text(
                                //         prdFUP.config.slpitCurrency("${prdFUP.fupUpcmListData[index].DocTotal!.toStringAsFixed(0)}"),
                                //           style: theme.textTheme.bodyText2
                                //               ?.copyWith()),
                                //     ),
                                //   ),

                                ],
                              )
                              
                                ],
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
                                    prdFUP.fupUpcmListData[index].LastFollowupDate!=''?
                                    "Created Date:"+
                                     prdFUP.config
                                                          .alignDate(
                                                              "${prdFUP.fupUpcmListData[index].CretedDate}")
                                  // prdFUP.config.subtractDateTime3("${prdFUP.fupUpcmListData[index].LastFollowupDate}")
                                   :'',
                                      style: theme.textTheme.bodyText2?.copyWith(
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
        ],
      ),
    );
  }
}
