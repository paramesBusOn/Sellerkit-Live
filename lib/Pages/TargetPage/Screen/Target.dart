// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/TargetController/TargetController.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class Target extends StatefulWidget {
  const Target({Key? key}) : super(key: key);

  @override
  State<Target> createState() => _TargetState();
}

class _TargetState extends State<Target> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<TargetTabController>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // return ChangeNotifierProvider<TargetTabController>(
    //     create: (context) => TargetTabController(),
    //     builder: (context, child) {
    //       return Consumer<TargetTabController>(
    //           builder: (BuildContext context, prdFUP, Widget? child) {
    return WillPopScope(
      onWillPop: context.watch<TargetTabController>().onbackpress,
      child: Scaffold(
          drawerEnableOpenDragGesture: false,
          key: scaffoldKey,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              //
              // context.read<TargetTabController>().clearTargetFilterData();
              await context
                  .read<TargetTabController>()
                  .callTargetUsersApi(context);
              setState(() {
                log("vvvv::" +
                    context
                        .read<TargetTabController>()
                        .targetUserList
                        .length
                        .toString());
                context.read<TargetTabController>().showbottombtn(context);
              });
            },
            child: Icon(Icons.filter_alt),
          ),
          drawer: drawer3(context),
          appBar: appbar("Target", scaffoldKey, theme, context),
          body: GestureDetector(
              child: SafeArea(
                  child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: Screens.padingHeight(context) * 0.025,
                  bottom: Screens.padingHeight(context) * 0.03),
              // padding: paddings.padding2(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      bottom: Screens.padingHeight(context) * 0.01,
                      left: Screens.width(context) * 0.04,
                      right: Screens.width(context) * 0.01,
                    ),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      context.watch<TargetTabController>().salesPerName.isEmpty
                          ? ConstantValues.firstName.toString()
                          : context.watch<TargetTabController>().salesPerName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                  context.read<TargetTabController>().isloading == false &&
                          context
                              .read<TargetTabController>()
                              .noTargetInit
                              .isNotEmpty
                      ? Container(
                          height: Screens.padingHeight(context),
                          child: Center(
                              child: Text(context
                                  .watch<TargetTabController>()
                                  .noTargetInit)))
                      : context.read<TargetTabController>().isloading == true &&
                              context
                                      .read<TargetTabController>()
                                      .targetCheckDataExcep ==
                                  ''
                          ? Container(
                              height: Screens.padingHeight(context),
                              child: Center(child: CircularProgressIndicator()))
                          : (context.read<TargetTabController>().isloading ==
                                      false &&
                                  context
                                          .read<TargetTabController>()
                                          .targetCheckDataExcep !=
                                      '')
                              ? Container(
                                  height: Screens.padingHeight(context),
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      context
                                              .watch<TargetTabController>()
                                              .lottie
                                              .isEmpty
                                          ? Container()
                                          : context
                                                      .watch<
                                                          TargetTabController>()
                                                      .lottie
                                                      .isNotEmpty &&
                                                  context
                                                      .watch<
                                                          TargetTabController>()
                                                      .lottie
                                                      .contains(".png")
                                              ? InkWell(
                                                  onTap: () {},
                                                  child: Image.asset(
                                                      '${context.watch<TargetTabController>().lottie}',
                                                      height:
                                                          Screens.padingHeight(
                                                                  context) *
                                                              0.2,
                                                      width: Screens.width(
                                                              context) *
                                                          0.5),
                                                )
                                              : InkWell(
                                                  onTap: () {},
                                                  child: Lottie.asset(
                                                      '${context.watch<TargetTabController>().lottie}',
                                                      animate: true,
                                                      repeat: true,
                                                      // height: Screens.padingHeight(context) * 0.3,
                                                      width: Screens.width(
                                                              context) *
                                                          0.4),
                                                ),
                                      Text(
                                        '${context.watch<TargetTabController>().targetCheckDataExcep}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )),
                                )
                              : Container(
                                  padding: EdgeInsets.only(
                                      top: Screens.bodyheight(context) * 0.015),
                                  child: Center(
                                    child:
                                        CupertinoSlidingSegmentedControl<int>(
                                      backgroundColor: Colors.grey,
                                      padding: EdgeInsets.all(0),
                                      thumbColor: theme.primaryColor,
                                      groupValue: context
                                          .watch<TargetTabController>()
                                          .groupValueSelected,
                                      children: {
                                        0: Container(
                                          alignment: Alignment.center,
                                          width: Screens.width(context) * 0.425,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 7, horizontal: 5),
                                          // height: Screens.bodyheight(context) * 0.05,
                                          child: Text(
                                            'Today',
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                          ),
                                        ),
                                        1: Container(
                                          alignment: Alignment.center,
                                          width: Screens.width(context) * 0.42,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 7, horizontal: 5),
                                          // height: Screens.bodyheight(context) * 0.05,
                                          child: Text(
                                            'MTD',
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                          ),
                                        ),
                                      },
                                      onValueChanged: (v) {
                                        setState(() {
                                          context
                                              .read<TargetTabController>()
                                              .groupSelectvalue(v!);
                                          print(v);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.005,
                  ),
                  context
                          .watch<TargetTabController>()
                          .targetTodayMasterData22
                          .isNotEmpty
                      ? Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: Screens.bodyheight(context) * 0.01,
                                    ),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8))),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: theme.primaryColor
                                                .withOpacity(0.05)),
                                        height:
                                            Screens.bodyheight(context) * 0.14,
                                        width: Screens.width(context) * 0.45,
                                        child: Column(
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8)),
                                                    color: theme.primaryColor,
                                                    border: Border.all(
                                                        color:
                                                            theme.primaryColor)
                                                    // borderRadius: BorderRadius.circular(10)),
                                                    ),
                                                child: Text(
                                                  context
                                                              .read<
                                                                  TargetTabController>()
                                                              .groupValueSelected ==
                                                          0
                                                      ? 'Today Target'
                                                      // '${   context.watch<TargetTabController>() .targetTodayMasterData22[0].targetValue}'
                                                      : 'MTD Target',
                                                  // '${   context.watch<TargetTabController>() .targetMonthMasterData22[0].targetQty}',
                                                  style: theme
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                )),
                                            SizedBox(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                    context
                                                                .read<
                                                                    TargetTabController>()
                                                                .groupValueSelected ==
                                                            0
                                                        ? '${context.watch<TargetTabController>().targetTodayMasterData22[0].targetValue}'
                                                        : '${context.watch<TargetTabController>().targetMonthMasterData22[0].targetValue}',
                                                    style: theme
                                                        .textTheme.subtitle1
                                                        // headline6
                                                        ?.copyWith(
                                                            // fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                            ),
                                            Text(
                                                context
                                                            .watch<
                                                                TargetTabController>()
                                                            .groupValueSelected ==
                                                        0
                                                    ? '${context.watch<TargetTabController>().targetTodayMasterData22[0].targetQty}'
                                                    : '${context.watch<TargetTabController>().targetMonthMasterData22[0].targetQty}',
                                                style: theme.textTheme.bodyText1
                                                    ?.copyWith(
                                                        color:
                                                            Colors.grey[600]))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: Screens.bodyheight(context) * 0.01,
                                    ),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8))),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: theme.primaryColor
                                                .withOpacity(0.05)),
                                        height:
                                            Screens.bodyheight(context) * 0.14,
                                        width: Screens.width(context) * 0.45,
                                        child: Column(
                                          children: [
                                            Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 5),
                                                // height: Screens.bodyheight(context) * 0.05,
                                                // width: Screens.width(context) * 0.4,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8)),
                                                    color: theme.primaryColor,
                                                    border: Border.all(
                                                        color: theme
                                                            .primaryColor)),
                                                child: Text(
                                                  context
                                                              .watch<
                                                                  TargetTabController>()
                                                              .groupValueSelected ==
                                                          0
                                                      ? 'Today Achievement'
                                                      : 'MTD Achievement',
                                                  // ? '${   context.watch<TargetTabController>() .targetTodayMasterData22[0].kPI2Title}'
                                                  // : '${   context.watch<TargetTabController>() .targetMonthMasterData22[0].kPI2Title}',
                                                  textAlign: TextAlign.center,
                                                  style: theme
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                )),
                                            SizedBox(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                            ),
                                            Text(
                                                context
                                                            .watch<
                                                                TargetTabController>()
                                                            .groupValueSelected ==
                                                        0
                                                    ? '${context.watch<TargetTabController>().targetTodayMasterData22[0].achPer}'
                                                    : '${context.watch<TargetTabController>().targetMonthMasterData22[0].achPer}',
                                                textAlign: TextAlign.center,
                                                style: theme.textTheme.subtitle1
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500)),
                                            SizedBox(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                            ),
                                            Text(
                                                context
                                                            .watch<
                                                                TargetTabController>()
                                                            .groupValueSelected ==
                                                        0
                                                    ? '${context.watch<TargetTabController>().targetTodayMasterData22[0].achVal}'
                                                    : '${context.watch<TargetTabController>().targetMonthMasterData22[0].achVal}',
                                                textAlign: TextAlign.center,
                                                style: theme.textTheme.bodyText1
                                                    ?.copyWith(
                                                        color:
                                                            Colors.grey[600]))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.005,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: Screens.bodyheight(context) * 0.01,
                                    ),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8))),
                                      child: Container(
                                        height:
                                            Screens.bodyheight(context) * 0.16,
                                        width: Screens.width(context) * 0.45,
                                        decoration: BoxDecoration(
                                            color: theme.primaryColor
                                                .withOpacity(0.05)),
                                        child: Column(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 5),
                                                alignment: Alignment.center,
                                                // height: Screens.bodyheight(context) * 0.05,
                                                // width: Screens.width(context) * 0.4,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8)),
                                                    color: theme.primaryColor,
                                                    border: Border.all(
                                                        color:
                                                            theme.primaryColor)
                                                    // borderRadius: BorderRadius.circular(10)),
                                                    ),
                                                child: Text(
                                                  context
                                                              .watch<
                                                                  TargetTabController>()
                                                              .groupValueSelected ==
                                                          0
                                                      ? 'Expected Closure for This Month'
                                                      : 'Expected Closure for This Month',
                                                  textAlign: TextAlign.center,
                                                  style: theme
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                )),
                                            SizedBox(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                            ),
                                            Text(
                                                context
                                                            .watch<
                                                                TargetTabController>()
                                                            .groupValueSelected ==
                                                        0
                                                    ? '${context.watch<TargetTabController>().targetTodayMasterData22[0].expClosePerc}'
                                                    : '${context.watch<TargetTabController>().targetMonthMasterData22[0].expClosePerc}',
                                                style: theme.textTheme.subtitle1
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500)),
                                            SizedBox(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                            ),
                                            Text(
                                                context
                                                            .watch<
                                                                TargetTabController>()
                                                            .groupValueSelected ==
                                                        0
                                                    ? '${context.watch<TargetTabController>().targetTodayMasterData22[0].expCloseVal}'
                                                    : '${context.watch<TargetTabController>().targetMonthMasterData22[0].expCloseVal}',
                                                style: theme.textTheme.bodyText1
                                                    ?.copyWith(
                                                        color:
                                                            Colors.grey[600]))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: Screens.bodyheight(context) * 0.01,
                                    ),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8))),
                                      child: Container(
                                        height:
                                            Screens.bodyheight(context) * 0.16,
                                        width: Screens.width(context) * 0.45,
                                        decoration: BoxDecoration(
                                            color: theme.primaryColor
                                                .withOpacity(0.05)),
                                        child: Column(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 5),
                                                alignment: Alignment.center,
                                                // height: Screens.bodyheight(context) * 0.05,
                                                // width: Screens.width(context) * 0.4,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(8),
                                                            topRight:
                                                                Radius.circular(
                                                                    8)),
                                                    color: theme.primaryColor,
                                                    border: Border.all(
                                                        color:
                                                            theme.primaryColor)
                                                    // borderRadius: BorderRadius.circular(10)),
                                                    ),
                                                child: Text(
                                                  context
                                                              .watch<
                                                                  TargetTabController>()
                                                              .groupValueSelected ==
                                                          0
                                                      ? 'Run Rate Req. to Ach Target'
                                                      : 'Run Rate Req. to Ach Target',
                                                  textAlign: TextAlign.center,
                                                  style: theme
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                )),
                                            SizedBox(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                            ),
                                            Text(
                                                context
                                                            .watch<
                                                                TargetTabController>()
                                                            .groupValueSelected ==
                                                        0
                                                    ? '${context.watch<TargetTabController>().targetTodayMasterData22[0].runRatePerc}'
                                                    : '${context.watch<TargetTabController>().targetMonthMasterData22[0].runRatePerc}',
                                                textAlign: TextAlign.center,
                                                style: theme.textTheme.subtitle1
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500)),
                                            SizedBox(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                            ),
                                            Text(
                                                context
                                                            .watch<
                                                                TargetTabController>()
                                                            .groupValueSelected ==
                                                        0
                                                    ? '${context.watch<TargetTabController>().targetTodayMasterData22[0].runRateVal}'
                                                    : '${context.watch<TargetTabController>().targetMonthMasterData22[0].runRateVal}',
                                                textAlign: TextAlign.center,
                                                style: theme.textTheme.bodyText1
                                                    ?.copyWith(
                                                        color:
                                                            Colors.grey[600]))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: Screens.bodyheight(context) * 0.01),
                              Padding(
                                  padding: EdgeInsets.only(
                                    right: Screens.bodyheight(context) * 0.015,
                                    left: Screens.bodyheight(context) * 0.015,
                                  ),
                                  child: context
                                      .watch<TargetTabController>()
                                      .createTable(
                                        theme,
                                      ))
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          )))),
    );
    //   });
    // });
  }

  // Widget createTable(

  //   ThemeData theme,
  // ) {
  //   var todaykeyss = context.watch<TargetTabController>().getTodaydTableData;
  //   var monthkeyss2 = context.watch<TargetTabController>().getMonthTableData;
  //   log('todaykeysstodaykeyss::${context.watch<TargetTabController>().getTodaydTableData.length}');
  //   List<TableRow> rows = [];
  //   rows.add(TableRow(children: [
  //     Container(
  //       color: theme.primaryColor,
  //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //       child: Text(
  //         "Product Group",
  //         style: theme.textTheme.bodyLarge?.copyWith(
  //           fontWeight: FontWeight.normal,
  //           color: Colors.white,
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //     Container(
  //       // alignment: Alignment.center,
  //       color: theme.primaryColor,
  //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
  //       child: Text(
  //         "Target",
  //         style: theme.textTheme.bodyLarge?.copyWith(
  //           fontWeight: FontWeight.normal,
  //           color: Colors.white,
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //     Container(
  //       color: theme.primaryColor,
  //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
  //       child: Text(
  //         "Achieved",
  //         style: theme.textTheme.bodyLarge
  //             ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //     Container(
  //       color: theme.primaryColor,
  //       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
  //       child: Text(
  //         "Ach %",
  //         style: theme.textTheme.bodyLarge
  //             ?.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //   ]));
  //   print("Above Row");
  //   for (int i = 0; i < todaykeyss.length; ++i) {
  //     print("in Row");
  //     rows.add(TableRow(children: [
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //         child: Text(
  //           context.watch<TargetTabController>().groupValueSelected == 0
  //               ? '${todaykeyss[i].productGroup}'
  //               : '${monthkeyss2[i].productGroup}',
  //           textAlign: TextAlign.left,
  //           style: theme.textTheme.bodyText1?.copyWith(
  //             color: theme.primaryColor,
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
  //         child: Text(
  //           context.watch<TargetTabController>().groupValueSelected == 0
  //               ? '${todaykeyss[i].targetVal}'
  //               : '${monthkeyss2[i].targetVal}',
  //           textAlign: TextAlign.right,
  //           style: theme.textTheme.bodyText1?.copyWith(
  //             color: theme.primaryColor,
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
  //         child: Text(
  //           context.watch<TargetTabController>().groupValueSelected == 0
  //               ? '${todaykeyss[i].achVal}'
  //               : '${monthkeyss2[i].achVal}',
  //           textAlign: TextAlign.right,
  //           style: theme.textTheme.bodyText1?.copyWith(
  //             color: theme.primaryColor,
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
  //         child: Text(
  //           context.watch<TargetTabController>().groupValueSelected == 0
  //               ? '${todaykeyss[i].ach_Perc}'
  //               : '${monthkeyss2[i].ach_Perc}',
  //           textAlign: TextAlign.right,
  //           style: theme.textTheme.bodyText1?.copyWith(
  //             color: theme.primaryColor,
  //           ),
  //         ),
  //       ),
  //     ]));
  //   }
  //   return Table(columnWidths: {
  //     0: FlexColumnWidth(2.2), //tp
  //     1: FlexColumnWidth(2.2), //seg
  //     2: FlexColumnWidth(1.5), //tar
  //     3: FlexColumnWidth(1.3), //ach
  //     // 4: FlexColumnWidth(1.1), //ach%
  //   }, children: rows);
  // }
}

// context
//             .watch<TargetTabController>()
//             .gettargetCheckDataExcep
//             .isNotEmpty &&
//         context
//                 .watch<TargetTabController>()
//                 .isloading ==
//             false
//     ? Center(
//         child: Text(context
//             .watch<TargetTabController>()
//             .gettargetCheckDataExcep))
//     : context
//                     .watch<TargetTabController>()
//                     .isloading ==
//                 true &&
//             context
//                 .watch<TargetTabController>()
//                 .gettargetCheckDataExcep
//                 .isEmpty
//         ? Center(
//             child: CircularProgressIndicator(
//             color: theme.primaryColor,
//           ))
// :
// TableRow builRow(List<String> cells, ThemeData theme) => TableRow(
//         children: cells.map((e) {
//       return Padding(
//         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
//         child: Center(
//           child: Text(
//             e,
//             style: theme.textTheme.bodyText1,
//           ),
//         ),
//       );
//     }).toList());

// TableRow builRowchild(List<String> cells, ThemeData theme) => TableRow(
//         children: cells.map((e) {
//       return Padding(
//         padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
//         child: Center(
//           child: Text(
//             e,
//             style: theme.textTheme.bodyText1?.copyWith(color: Colors.grey),
//           ),
//         ),
//       )
//     }).toList());
