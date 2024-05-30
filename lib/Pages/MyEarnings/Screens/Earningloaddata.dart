import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/EarningController/EarningController.dart';

import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/padings.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class EarningMoreData extends StatefulWidget {
  EarningMoreData({
    Key? key,
  }) : super(key: key);
  @override
  State<EarningMoreData> createState() => _EarningMoreDataState();
}

class _EarningMoreDataState extends State<EarningMoreData> {
  final maxLines = 3;
  Paddings paddings = Paddings();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: context.read<EarningController>().onbackpress2,
      child: Scaffold(
        key: scaffoldKey,
        appBar: appbar("My Earnings", scaffoldKey, theme, context),
        drawer: drawer3(context),
        body: SingleChildScrollView(
          child: Container(
            padding: paddings.padding2(context),
            height: Screens.padingHeight(context),
            width: Screens.width(context),
            child: RefreshIndicator(
              onRefresh: () {
                return context.read<EarningController>().refreshLoadData();
              },
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      top: Screens.padingHeight(context) * 0.01,
                      bottom: Screens.padingHeight(context) * 0.015,
                      left: Screens.width(context) * 0.04,
                      right: Screens.width(context) * 0.01,
                    ),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      context.watch<EarningController>().salesPerName.isEmpty
                          ? ConstantValues.firstName.toString()
                          : context.watch<EarningController>().salesPerName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Screens.padingHeight(context) * 0.01,
                        horizontal: Screens.width(context) * 0.04),
                    decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    width: Screens.width(context),
                    child: Form(
                      key: context.watch<EarningController>().formkey[1],
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: Screens.width(context) * 0.3,
                                child: Text(
                                  'From Date *',
                                  style: theme.textTheme.subtitle1?.copyWith(
                                    color: Colors.white,
                                    // fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              Container(
                                width: Screens.width(context) * 0.5,
                                child: TextFormField(
                                  controller: context
                                      .watch<EarningController>()
                                      .dateController[2],
                                  onEditingComplete: () {
                                    context
                                        .read<EarningController>()
                                        .dateValidation();
                                  },
                                  onTap: () {
                                    context
                                        .read<EarningController>()
                                        .showFromDate(context);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Choose The From Date";
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  style: theme.textTheme.bodyText2
                                      ?.copyWith(color: Colors.white),
                                  decoration: InputDecoration(
                                    errorStyle: theme.textTheme.bodyText2
                                        ?.copyWith(color: Colors.white),
                                    suffixIcon: const Icon(
                                        Icons.date_range_outlined,
                                        color: Colors.grey),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 3),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                              height: Screens.padingHeight(context) * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: Screens.width(context) * 0.3,
                                child: Text(
                                  'To Date *',
                                  style: theme.textTheme.subtitle1?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                width: Screens.width(context) * 0.5,
                                child: TextFormField(
                                  controller: context
                                      .watch<EarningController>()
                                      .dateController[3],
                                  onEditingComplete: () {
                                    context
                                        .read<EarningController>()
                                        .dateValidation();
                                  },
                                  onTap: () {
                                    context
                                        .read<EarningController>()
                                        .showToDate(context);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Choose The To Date";
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  style: theme.textTheme.bodyText2
                                      ?.copyWith(color: Colors.white),
                                  decoration: InputDecoration(
                                    errorStyle: theme.textTheme.bodyText2
                                        ?.copyWith(color: Colors.white),
                                    suffixIcon: Icon(Icons.date_range_outlined,
                                        color: Colors.grey),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 3),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                              height: Screens.padingHeight(context) * 0.02),
                          context
                                  .watch<EarningController>()
                                  .dateRangeError
                                  .isNotEmpty
                              ? Container(
                                  child: Text(
                                    context
                                        .watch<EarningController>()
                                        .dateRangeError,
                                    style: theme.textTheme.bodyText2
                                        ?.copyWith(color: Colors.white),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                              height: Screens.padingHeight(context) * 0.02),
                          Container(
                              width: Screens.width(context) * 0.8,
                              height: Screens.padingHeight(context) * 0.06,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: MaterialButton(
                                  onPressed: () {
                                    context
                                        .read<EarningController>()
                                        .btnLoadingProgress = true;
                                    context
                                        .read<EarningController>()
                                        .loadBtnClick();
                                  },
                                  child: context
                                              .watch<EarningController>()
                                              .btnLoadingProgress ==
                                          true
                                      ? CircularProgressIndicator(
                                          color: theme.primaryColor)
                                      : Text(
                                          "Load Data",
                                          style: theme.textTheme.bodyText2
                                              ?.copyWith(
                                            color: theme.primaryColor,
                                          ),
                                        ))),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Screens.padingHeight(context) * 0.02),
                  // context.watch<EarningController>().kpilottie.isNotEmpty &&
                  //         context
                  //             .watch<EarningController>()
                  //             .earningexp
                  //             .isNotEmpty
                  //     ? Container(
                  //         height: Screens.padingHeight(context) * 0.5,
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Lottie.asset(
                  //                 context.watch<EarningController>().kpilottie,
                  //                 animate: true,
                  //                 repeat: true,
                  //                 // height: Screens.padingHeight(context) * 0.3,
                  //                 width: Screens.width(context) * 0.4),
                  // Text(
                  //     context.watch<EarningController>().earningexp)
                  //           ],
                  //         ))

                  context.watch<EarningController>().kpilottie.isNotEmpty &&
                          context
                              .watch<EarningController>()
                              .earningloadData
                              .isEmpty
                      ? SizedBox(
                          height: Screens.padingHeight(context) * 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              context
                                      .watch<EarningController>()
                                      .kpilottie
                                      .contains(".png")
                                  ? Image.asset(
                                      context
                                          .watch<EarningController>()
                                          .kpilottie,
                                      height:
                                          Screens.padingHeight(context) * 0.2,
                                      width: Screens.width(context) * 0.5)
                                  : Lottie.asset(
                                      context
                                          .watch<EarningController>()
                                          .kpilottie,
                                      animate: true,
                                      repeat: true,
                                      // height: Screens.padingHeight(context) * 0.3,
                                      width: Screens.width(context) * 0.4),
                              Text(
                                  context.watch<EarningController>().earningexp)
                            ],
                          ),
                        )

                      // Container(
                      //     height: Screens.padingHeight(context) * 0.5,
                      //     child: Center(
                      //       child: Text(
                      //           context.watch<EarningController>().earningexp),
                      //     ),
                      //   )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: context
                                .watch<EarningController>()
                                .getearningloadData
                                .length,
                            itemBuilder: (BuildContext context, int i) {
                              return Card(
                                margin: EdgeInsets.all(0.3),
                                elevation: 0.5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: Screens.width(context) * 0.6,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                              left:
                                                  Screens.width(context) * 0.01,
                                              right:
                                                  Screens.width(context) * 0.01,
                                              top: Screens.padingHeight(
                                                      context) *
                                                  0.01,
                                              bottom: Screens.padingHeight(
                                                      context) *
                                                  0.01,
                                            ),
                                            child: Text(
                                              context
                                                  .watch<EarningController>()
                                                  .getearningloadData[i]
                                                  .description
                                                  .toString(),
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(),
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                Screens.padingHeight(context) *
                                                    0.01,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              left:
                                                  Screens.width(context) * 0.01,
                                              right:
                                                  Screens.width(context) * 0.01,
                                              top: Screens.padingHeight(
                                                      context) *
                                                  0.001,
                                              bottom: Screens.padingHeight(
                                                      context) *
                                                  0.01,
                                            ),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              // context
                                              //     .watch<EarningController>()
                                              //     .loadedDateOnly(
                                              context
                                                  .watch<EarningController>()
                                                  .getearningloadData[i]
                                                  .transDate
                                                  .toString(),
                                              // ),
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: Screens.width(context) * 0.01,
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context) * 0.31,
                                      child: Text(
                                        context
                                            .watch<EarningController>()
                                            .getearningloadData[i]
                                            .amount
                                            .toStringAsFixed(2),
                                        textAlign: TextAlign.end,
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                  SizedBox(height: Screens.padingHeight(context) * 0.09),
                ],
              ),
            ),
            // )
          ),
        ),
      ),
    );
  }
}

// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:provider/provider.dart';
// import 'package:sellerkit/Constant/Screen.dart';
// import 'package:sellerkit/Constant/padings.dart';
// import 'package:sellerkit/Controller/EarningController/EarningController.dart';
// import 'package:sellerkit/Widgets/Appbar.dart';
// import 'package:sellerkit/Widgets/Navi3.dart';

// class EarningMoreData extends StatefulWidget {
//   EarningMoreData({Key? key, required this.prdernctr}) : super(key: key);

//   EarningController prdernctr;

//   @override
//   State<EarningMoreData> createState() => _EarningMoreDataState();
// }

// class _EarningMoreDataState extends State<EarningMoreData> {
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//   Paddings paddings = Paddings();
//   final maxLines = 3;
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return SafeArea(
//         child: Scaffold(
            // key: scaffoldKey,
            // appBar: appbar("My Earnings", scaffoldKey, theme, context),
            // drawer: drawer3(context),
//             body: ChangeNotifierProvider<EarningController>(
//                 create: (context) => EarningController(),
//                 builder: (context, child) {
//                   return Consumer<EarningController>(
//                       builder: (BuildContext context, prdearn, Widget? child) {
//                     return Container(
//                       padding: paddings.padding2(context),
                      //  child:   RefreshIndicator(
                      //     onRefresh: () {
                      //       return prdearn.refreshData();
                      //     },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Card(
//                               child: Container(
                            // padding: EdgeInsets.symmetric(
                            //     vertical: Screens.padingHeight(context) * 0.01,
                            //     horizontal: Screens.width(context) * 0.02),
                            // decoration: BoxDecoration(
                            //     color: theme.primaryColor,
                            //     borderRadius: BorderRadius.circular(5)),
                            // width: Screens.width(context),
//                             child: Form(
//                               key: prdearn.formkey[1],
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         width: Screens.width(context) * 0.22,
//                                         child: Text(
//                                           "From Date",
                                          // style: theme.textTheme.subtitle1
                                          //     ?.copyWith(
                                          //         color: Colors.white,
                                          //         fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                       // SizedBox(
//                                       //   width: Screens.width(context) * 0.05,
//                                       // ),
//                                       TextFormField(
                                        // onTap: () {
                                        //   prdearn
                                        //       .showFromDate(context);
                                        // },
                                        // validator: (value) {
                                        //   if (value!.isEmpty) {
                                        //     return "Choose From Date";
                                        //   }
                                        //   return null;
                                        // },
                                        // readOnly: true,
//                                         controller:
//                                             prdearn.dateController[2],
                                        // style: theme
                                        //     .textTheme.bodyText2
                                        //     ?.copyWith(
                                        //         color: Colors.white),
//                                         decoration: InputDecoration(
                                          // errorStyle: theme
                                          //     .textTheme.bodyText2
                                          //     ?.copyWith(
                                          //         color:
                                          //             Colors.white),
                                        //   suffixIcon: Icon(
                                        //       Icons
                                        //           .date_range_outlined,
                                        //       color: Colors.grey),
                                        //   contentPadding:
                                        //       EdgeInsets.symmetric(
                                        //           vertical: 3,
                                        //           horizontal: 3),
                                        //   enabledBorder:
                                        //       OutlineInputBorder(
                                        //     borderRadius:
                                        //         BorderRadius.circular(
                                        //             5),
                                        //     borderSide: BorderSide(
                                        //         color: Colors.grey),
                                        //   ),
                                        //   focusedBorder:
                                        //       OutlineInputBorder(
                                        //     borderRadius:
                                        //         BorderRadius.circular(
                                        //             5),
                                        //     borderSide: BorderSide(
                                        //         color: Colors.grey),
                                        //   ),
                                        //   errorBorder:
                                        //       OutlineInputBorder(
                                        //     borderRadius:
                                        //         BorderRadius.circular(
                                        //             5),
                                        //     borderSide: BorderSide(
                                        //         color: Colors.red),
                                        //   ),
                                        //   focusedErrorBorder:
                                        //       OutlineInputBorder(
                                        //     borderRadius:
                                        //         BorderRadius.circular(
                                        //             5),
                                        //     borderSide: BorderSide(
                                        //         color: Colors.red),
                                        //   ),
                                        // ),
//                                       ),
//                                     ],
//                                   ),
                                  // SizedBox(
                                  //     height:
                                  //         Screens.padingHeight(context) * 0.01),
//                                   Row(
//                                     children: [
//                                       Container(
//                                         width: Screens.width(context) * 0.22,
//                                         child: Text(
//                                           "To Date",
//                                           style: theme.textTheme.subtitle1
//                                               ?.copyWith(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: Screens.width(context) * 0.05,
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Container(
//                                               width:
//                                                   Screens.width(context) * 0.6,
//                                               height:
//                                                   Screens.padingHeight(context) *
//                                                       0.05,
//                                               child:
//                                                   prdearn.gettoerrortextfield ==
//                                                           true
//                                                       ? Column(
//                                                           children: [
//                                                             GestureDetector(
//                                                               onTap: () {
//                                                                 prdearn
//                                                                     .showToDate(
//                                                                         context);
//                                                               },
//                                                               child: Container(
//                                                                 padding:
//                                                                     EdgeInsets
//                                                                         .all(5),
//                                                                 width: Screens
//                                                                         .width(
//                                                                             context) *
//                                                                     0.6,
//                                                                 height: Screens
//                                                                         .padingHeight(
//                                                                             context) *
//                                                                     0.05,
//                                                                 decoration:
//                                                                     BoxDecoration(
//                                                                   border: Border.all(
//                                                                       color: Colors
//                                                                           .white),
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .circular(
//                                                                               5),
//                                                                 ),
//                                                                 child: Row(
//                                                                   mainAxisAlignment:
//                                                                       MainAxisAlignment
//                                                                           .spaceBetween,
//                                                                   children: [
//                                                                     Text(
//                                                                       prdearn
//                                                                           .dateController[
//                                                                               3]
//                                                                           .text,
//                                                                       style: theme
//                                                                           .textTheme
//                                                                           .bodyText2
//                                                                           ?.copyWith(
//                                                                               color: Colors.white),
//                                                                     ),
//                                                                     Icon(
//                                                                         Icons
//                                                                             .date_range_outlined,
//                                                                         color: Colors
//                                                                             .grey),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             )
//                                                           ],
//                                                         )
//                                                       : TextFormField(
//                                                           onTap: () {
//                                                             prdearn.showToDate(
//                                                                 context);
//                                                           },
//                                                           validator: (value) {
//                                                             if (value!
//                                                                 .isEmpty) {
//                                                               prdearn.gettoerrortextfield ==
//                                                                   true;
//                                                               return "Choose To Date";
//                                                             }
//                                                             return null;
//                                                           },
//                                                           readOnly: true,
//                                                           controller: prdearn
//                                                               .dateController[3],
//                                                           style: theme.textTheme
//                                                               .bodyText2
//                                                               ?.copyWith(
//                                                                   color: Colors
//                                                                       .white),
//                                                           decoration:
//                                                               InputDecoration(
//                                                             errorStyle: theme
//                                                                 .textTheme
//                                                                 .bodyText2
//                                                                 ?.copyWith(
//                                                                     color: Colors
//                                                                         .white),
//                                                             suffixIcon: Icon(
//                                                                 Icons
//                                                                     .date_range_outlined,
//                                                                 color: Colors
//                                                                     .grey),
//                                                             contentPadding:
//                                                                 const EdgeInsets
//                                                                     .symmetric(
//                                                                     vertical:
//                                                                         10,
//                                                                     horizontal:
//                                                                         10),
//                                                             enabledBorder:
//                                                                 OutlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           5),
//                                                               borderSide:
//                                                                   BorderSide(
//                                                                       color: Colors
//                                                                           .grey),
//                                                             ),
//                                                             focusedBorder:
//                                                                 OutlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           5),
//                                                               borderSide:
//                                                                   BorderSide(
//                                                                       color: Colors
//                                                                           .grey),
//                                                             ),
//                                                             errorBorder:
//                                                                 OutlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           5),
//                                                               borderSide:
//                                                                   BorderSide(
//                                                                       color: Colors
//                                                                           .grey),
//                                                             ),
//                                                             focusedErrorBorder:
//                                                                 OutlineInputBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           5),
//                                                               borderSide:
//                                                                   BorderSide(
//                                                                       color: Colors
//                                                                           .grey),
//                                                             ),
//                                                           ),
//                                                         )),
//                                           Container(
//                                             alignment: Alignment.centerLeft,
//                                             child: Visibility(
//                                                 visible:
//                                                     prdearn.gettoerrortextfield,
//                                                 child: Text(
//                                                   "Choose To Date",
//                                                   style: theme
//                                                       .textTheme.bodyText2
//                                                       ?.copyWith(
//                                                           color: Colors.white),
//                                                 )),
//                                           )
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                       height:
//                                           Screens.padingHeight(context) * 0.04),
//                                   Container(
//                                     width: Screens.width(context) * 0.9,
//                                     height: Screens.padingHeight(context) * 0.06,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: MaterialButton(
                                        // child: prdearn.getbtnLoadingProgress ==
                                        //         true
                                        //     ? CircularProgressIndicator(
                                        //         color: theme.primaryColor)
                                        //     : Text(
//                                                 'Load Data',
                                                // style: theme.textTheme.bodyText2
                                                //     ?.copyWith(
                                                //   color: theme.primaryColor,
                                                // ),
//                                               ),
//                                         onPressed: () {
//                                           prdearn.loadBtnClick();
//                                         }),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )),
                  //         SizedBox(height: Screens.padingHeight(context) * 0.02),
                  //         Expanded(
                  //           // child: RefreshIndicator(
                  //           //   onRefresh: () {
                  //           //     return prdearn.refreshData();
                  //           //   },
                  //           child: ListView.builder(
                  //             itemCount: prdearn.getearningloadData.length,
                  //             itemBuilder: (BuildContext context, int i) {
                  //               var keys = prdearn.getearningloadData.toList();
                  //               return

                  //                   // AnimationConfiguration
                  //                   //           .staggeredList(
                  //                   //               position: i,
                  //                   //               duration:
                  //                   //                   const Duration(
                  //                   //                       milliseconds:
                  //                   //                           400),
                  //                   //               child: SlideAnimation(
                  //                   //                   verticalOffset:
                  //                   //                       100.0,
                  //                   //                   child:
                  //                   //                       FlipAnimation(
                  //                   //                     child:
                  //                   Card(
                  //                 margin: EdgeInsets.all(0.3),
                  //                 elevation: 0.5,
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(5)),
                  //                 child: Row(
                  //                   children: [
                  //                     Container(
                  //                       width: Screens.width(context) * 0.7,
                  //                       child: Column(
                  //                         children: [
                  //                           Container(
                  //                             padding: EdgeInsets.only(
                  //                               left: Screens.width(context) *
                  //                                   0.01,
                  //                               right: Screens.width(context) *
                  //                                   0.01,
                  //                               top: Screens.padingHeight(
                  //                                       context) *
                  //                                   0.01,
                  //                               bottom: Screens.padingHeight(
                  //                                       context) *
                  //                                   0.01,
                  //                             ),
                  //                             child: Text(
                  //                               keys[i].transDetails.toString(),
                  //                               style: theme.textTheme.bodyText1
                  //                                   ?.copyWith(),
                  //                             ),
                  //                           ),
                  //                           SizedBox(
                  //                             height:
                  //                                 Screens.padingHeight(context) *
                  //                                     0.01,
                  //                           ),
                  //                           Container(
                  //                             padding: EdgeInsets.only(
                  //                               left: Screens.width(context) *
                  //                                   0.01,
                  //                               right: Screens.width(context) *
                  //                                   0.01,
                  //                               top: Screens.padingHeight(
                  //                                       context) *
                  //                                   0.001,
                  //                               bottom: Screens.padingHeight(
                  //                                       context) *
                  //                                   0.01,
                  //                             ),
                  //                             alignment: Alignment.centerLeft,
                  //                             child: Text(
                  //                               prdearn.loadedDateOnly(
                  //                                   keys[i].date!.toString()),
                  //                               style: theme.textTheme.bodyText1
                  //                                   ?.copyWith(),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       width: Screens.width(context) * 0.01,
                  //                     ),
                  //                     Container(
                  //                       alignment: Alignment.centerRight,
                  //                       width: Screens.width(context) * 0.2,
                  //                       decoration: BoxDecoration(

                  //                           // color: Colors.red,

                  //                           ),
                  //                       child: Text(
                  //                         keys[i].amount!.toStringAsFixed(2),
                  //                         textAlign: TextAlign.end,
                  //                         style: theme.textTheme.titleMedium
                  //                             ?.copyWith(
                  //                                 fontWeight: FontWeight.w600),
                  //                       ),
                  //                     )
                  //                   ],
                  //                 ),
                  //                 //         )
                  //                 //         )
                  //                 //  )
                  //               );
                  //             },
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //     // )
                  //   );
                  // });
//                 })));
//   }
// }
