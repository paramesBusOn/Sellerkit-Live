// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, curly_braces_in_flow_control_structures, unrelated_type_equality_checks, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import '../../../Controller/FollowupController/FollowUPController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class FollowUpNew extends StatefulWidget {
  const FollowUpNew({Key? key});

  @override
  State<FollowUpNew> createState() => _FollowUpNewState();
}

class _FollowUpNewState extends State<FollowUpNew> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //context.read<FollowUPController>().callFollowUPApi();
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        key: scaffoldKey,
        appBar: appbar("Followup", scaffoldKey, theme, context),
        drawer: drawer3(context),
        body: ChangeNotifierProvider<FollowupController>(
            create: (context) => FollowupController(),
            builder: (context, child) {
              return Consumer<FollowupController>(
                  builder: (BuildContext context, prdFUP, Widget? child) {
                return SafeArea(
                  child: (prdFUP.getisLoading == true &&
                          prdFUP.getexcepMsg.isEmpty)
                      ? Center(child: CircularProgressIndicator())
                      : (prdFUP.getisLoading == false &&
                              prdFUP.getexcepMsg.isNotEmpty)
                          ? Center(child: Text(prdFUP.getexcepMsg))
                          : Container(
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
                                    height: Screens.bodyheight(context) * 0.16,
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.03,
                                        vertical:
                                            Screens.bodyheight(context) * 0.02),
                                    decoration: BoxDecoration(
                                        color: theme.primaryColor
                                            .withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(color: Colors.black26)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.4,
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              width:
                                                  Screens.width(context) * 0.4,
                                            )
                                          ],
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: Screens.width(context),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.008,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: prdFUP.fupODueListData.length,
                                  
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                     
                                        return Container(
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
                                border: Border.all(color: Colors.black26)
                                ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                          "{leadOpenAllData[i].CustomerName}", 
                                          style:
                                              theme.textTheme.bodyText2?.copyWith(
                                            color: theme.primaryColor,
                                          )),
                                    ),
                                    Container(
                                      width: Screens.width(context) * 0.4,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                         
                                          "#{leadOpenAllData[i].LeadNum}",
                                          
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      child: Text("{leadOpenAllData[i].Product}",
                                          style: theme.textTheme.bodyText2
                                          ),
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
                                      child: Text(
                                          "Next Follow up",
                                          style:
                                              theme.textTheme.bodyText2?.copyWith(
                                                  color: Colors.grey)),
                                    ),
                                    Container(
                                      width: Screens.width(context) * 0.4,
                                      //color: Colors.red,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                          "Order Value", 
                                          style:
                                              theme.textTheme.bodyText2?.copyWith(
                                                  color: Colors.grey)),
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
                                         "data 2",
                                          style:
                                              theme.textTheme.bodyText2?.copyWith(
                                                  )),
                                    ),
                                    InkWell(
                                      onTap: () {
                                       
                                      },
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        width: Screens.width(context) * 0.4,
                                        child: Text(
                                            "ddtaa", 
                                            style: theme.textTheme.bodyText2
                                                ?.copyWith(
                                                    )),
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
                                           "dta",
                                            style: theme.textTheme.bodyText2
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
                                       "data",
                                        style:
                                            theme.textTheme.bodyText2?.copyWith(
                                          color: Colors.grey,
                                        )),
                                  ),
                                )

                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                );
              });
            }));
  }

}

