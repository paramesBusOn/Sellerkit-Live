import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/ReportsController/ReportsController.dart';
import 'package:sellerkit/Pages/Reports/Reports/widgets/CardChart.dart';
import 'package:sellerkit/Pages/Reports/Reports/widgets/barChart.dart';
import 'package:sellerkit/Pages/Reports/Reports/widgets/bubbleChart.dart';
import 'package:sellerkit/Pages/Reports/Reports/widgets/columnChart.dart';
import 'package:sellerkit/Pages/Reports/Reports/widgets/lineCahrt.dart';
import 'package:sellerkit/Pages/Reports/Reports/widgets/piechart.dart';
import 'package:sellerkit/Pages/Reports/Reports/widgets/splineChart.dart';
import 'package:sellerkit/Pages/Reports/Reports/widgets/tablerColumn2.dart';
import 'package:sellerkit/Widgets/Navi3.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../widgets/TestFilter.dart';

// ...
class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ReportsPage> createState() => ReportsPageState();
}

class ReportsPageState extends State<ReportsPage> {
  final GlobalKey<ScaffoldState> scaffoldKeyys = GlobalKey<ScaffoldState>();
  final GlobalKey<SfCircularChartState> circularChartKeyPie =
      GlobalKey<SfCircularChartState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ReportsController>().init();
    });
  }

  // @override
  // void dispose() {
  //   disposeTextEditingControllers(
  //       context.read<ReportsController>().mycontroller);
  //   super.dispose();
  // }

  void disposeTextEditingControllers(List<TextEditingController> controllers) {
    for (var controller in controllers) {
      controller.dispose();
    }
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.offAllNamed(ConstantRoutes.dashboard);
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
          drawer: drawer3(context),
          endDrawer: const FilterDrawer2(),
          key: scaffoldKeyys,
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: theme.primaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      scaffoldKeyys.currentState?.openDrawer();
                    },
                    child: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    )),
                GestureDetector(
                  onTap: () async {
                    context.read<ReportsController>().source1 =
                        await context.read<ReportsController>().getPathOFDB();
                    context.read<ReportsController>().copyTo =
                        await context.read<ReportsController>().getDirectory();

                    bool permission = await context
                        .read<ReportsController>()
                        .getPermissionStorage();
                    if (permission == true) {
                      if ((await context
                          .read<ReportsController>()
                          .copyTo!
                          .exists())) {
                        print("EXISTS");
                        context.read<ReportsController>().createDBFile(
                            context.read<ReportsController>().copyTo!.path);
                      } else {
                        print("Not EXISTS");
                        context.read<ReportsController>().createDirectory();
                      }
                    } else if (permission == false) {
                      context.read<ReportsController>().showSnackBars(
                          'Please give stoage permission to continue!!..',
                          Colors.red);
                    }
                  },
                  child: Container(
                    child: Text(
                      "     Lead Analysis",
                      style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                // Container(
                //   width: Screens.width(context) * 0.15,
                //   padding: const EdgeInsets.all(10),
                //   decoration: const BoxDecoration(
                //       // color: Colors.red
                //       ),
                //   child: Image.asset(
                //     "Assets/SellerSymbol.png",
                //     fit: BoxFit.fill,
                //   ),
                // ),
              ],
            ),
          ),
          body: Stack(children: [
            Positioned(
                top: Screens.padingHeight(context) * 0.01,
                left: Screens.width(context) * 0.001,
                right: Screens.width(context) * 0.001,
                child: dateRangeContainer(
                  context,
                  theme,
                )),
            (context.watch<ReportsController>().kpilottie == null) &&
                    (context.watch<ReportsController>().reportexp == null) &&
                    (context
                            .watch<ReportsController>()
                            .leadAnalysismasterDataset2
                            .length <
                        1)
                ? Center(
                    child: CircularProgressIndicator(
                      color: theme.primaryColor,
                    ),
                  )
                : (context.watch<ReportsController>().kpilottie != null) &&
                        (context.watch<ReportsController>().reportexp != null)
                    ? Positioned(
                        left: Screens.width(context) * 0.25,
                        top: Screens.padingHeight(context) * 0.35,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                  context.watch<ReportsController>().kpilottie!,
                                  height: Screens.padingHeight(context) * 0.2,
                                  width: Screens.width(context) * 0.5),
                            ),
                            Center(
                                child: Text(
                              context.watch<ReportsController>().reportexp!,
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: theme.primaryColor),
                            ))
                          ],
                        ),
                      )
                    : Positioned(
                        top: Screens.padingHeight(context) * 0.165,
                        child: Container(
                            width: Screens.width(context),
                            height: Screens.padingHeight(context),
                            child:
                                // (context.read<ReportsController>().progress == true &&
                                //         context.read<ReportsController>().errormsg.isEmpty &&
                                //         (context
                                //                 .read<ReportsController>()
                                //                 .leadAnalysismasterDataset2
                                //                 .isEmpty ||
                                //             context
                                //                 .read<ReportsController>()
                                //                 .leadAnalysisReportDataset
                                //                 .isEmpty))
                                //     ? Center(
                                //         child: CircularProgressIndicator(
                                //           color: theme.primaryColor,
                                //         ),
                                //       )
                                //     :
                                // (context
                                //                 .watch<ReportsController>()
                                //                 .reportexp!
                                //                 .isNotEmpty ||
                                //             context
                                //                     .watch<ReportsController>()
                                //                     .reportexp !=
                                //                 null) ||
                                //         context
                                //             .watch<ReportsController>()
                                //             .leadAnalysismasterDataset2
                                //             .isEmpty
                                //     ? Center(
                                //         child: Text(
                                //           context
                                //             .watch<ReportsController>()
                                //             .reportexp!
                                //             ),
                                //       )
                                //     :

                                (context.watch<ReportsController>().chartload ==
                                            true &&
                                        (context
                                                    .watch<ReportsController>()
                                                    .leadAnalysismasterDataset2
                                                    .length <
                                                1 ||
                                            context
                                                .watch<ReportsController>()
                                                .leadAnalysismasterDataset2
                                                .isEmpty))
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: theme.primaryColor,
                                        ),
                                      )
                                    : context
                                                .watch<ReportsController>()
                                                .leadAnalysismasterDataset2
                                                .isEmpty &&
                                            context
                                                    .watch<ReportsController>()
                                                    .chartload ==
                                                false
                                        ? Container()
                                        : ListView(
                                            children: [
                                              context
                                                      .read<ReportsController>()
                                                      .cardChartData
                                                      .isEmpty
                                                  ? Container()
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(1),
                                                      ),
                                                      child: Card(
                                                        child: Column(
                                                          children: [
                                                            GridView.builder(
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              itemCount: context
                                                                  .read<
                                                                      ReportsController>()
                                                                  .cardChartData
                                                                  .length,
                                                              shrinkWrap: true,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    SizedBox(
                                                                      height: Screens.padingHeight(
                                                                              context) *
                                                                          0.003,
                                                                    ),
                                                                    CardChartPage(
                                                                      theme:
                                                                          theme,
                                                                      name: context.read<ReportsController>().cardChartData[index].name !=
                                                                              null
                                                                          ? context
                                                                              .read<ReportsController>()
                                                                              .cardChartData[index]
                                                                              .name!
                                                                          : '',
                                                                      value: context.read<ReportsController>().cardChartData[index].value !=
                                                                              null
                                                                          ? context
                                                                              .read<ReportsController>()
                                                                              .cardChartData[index]
                                                                              .value!
                                                                              .toString()
                                                                          // .replaceAll(
                                                                          //     ',', '')
                                                                          : '',
                                                                      color: theme
                                                                          .primaryColor,
                                                                      // .withOpacity(
                                                                      //     0.5),
                                                                      //  context
                                                                      //     .watch<
                                                                      //         ReportsController>()
                                                                      //     .cardChartData[
                                                                      //         index]
                                                                      //     .colors!,
                                                                      cartesianChartKey: context
                                                                          .watch<
                                                                              ReportsController>()
                                                                          .cartesianChartKey[0],
                                                                      reportCnt:
                                                                          context
                                                                              .read<ReportsController>(),
                                                                    ),
                                                                    SizedBox(
                                                                      height: Screens.padingHeight(
                                                                              context) *
                                                                          0.003,
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                              gridDelegate:
                                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    2,
                                                                childAspectRatio:
                                                                    2.7,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                              // SizedBox(
                                              //     child: Column(
                                              //       children: [
                                              //         Row(
                                              //           mainAxisAlignment:
                                              //               MainAxisAlignment
                                              //                   .spaceEvenly,
                                              //           children: [
                                              //             context
                                              //                     .read<
                                              //                         ReportsController>()
                                              //                     .cardChartData
                                              //                     .isNotEmpty
                                              // ? CardChartPage(
                                              //     theme: theme,
                                              //     name: context
                                              //                 .read<
                                              //                     ReportsController>()
                                              //                 .cardChartData[
                                              //                     0]
                                              //                 .name !=
                                              //             null
                                              //         ? context
                                              //             .read<
                                              //                 ReportsController>()
                                              //             .cardChartData[
                                              //                 0]
                                              //             .name!
                                              //         : '',
                                              //     value: context
                                              //                 .read<
                                              //                     ReportsController>()
                                              //                 .cardChartData[
                                              //                     0]
                                              //                 .value !=
                                              //             null
                                              //         ? context
                                              //             .read<
                                              //                 ReportsController>()
                                              //             .cardChartData[
                                              //                 0]
                                              //             .value!
                                              //             .toString()
                                              //             .replaceAll(
                                              //                 ',',
                                              //                 '')
                                              //         : '',
                                              //     color: 'rose',
                                              //     // context
                                              //     //     .read<
                                              //     //         ReportsController>()
                                              //     //     .cardChartData[
                                              //     //         0]
                                              //     //     .color!,
                                              //     cartesianChartKey: context
                                              //         .read<
                                              //             ReportsController>()
                                              //         .cartesianChartKey[0],
                                              //     reportCnt:
                                              //         context.read<
                                              //             ReportsController>(),
                                              //   )
                                              // : Container(),
                                              //             context
                                              //                     .read<
                                              //                         ReportsController>()
                                              //                     .cardChartData
                                              //                     .isNotEmpty
                                              //                 ? CardChartPage(
                                              //                     theme: theme,
                                              //                     name: (context.read<ReportsController>().cardChartData.isNotEmpty) && context.read<ReportsController>().cardChartData[1].name!.isNotEmpty ||
                                              //                             context.read<ReportsController>().cardChartData[1].name !=
                                              //                                 null
                                              //                         ? context
                                              //                             .read<
                                              //                                 ReportsController>()
                                              //                             .cardChartData[
                                              //                                 1]
                                              //                             .name!
                                              //                         : '',
                                              //                     value: context
                                              //                                 .read<
                                              //                                     ReportsController>()
                                              //                                 .cardChartData[
                                              //                                     1]
                                              //                                 .value !=
                                              //                             null
                                              //                         ? context
                                              //                             .read<
                                              //                                 ReportsController>()
                                              //                             .cardChartData[
                                              //                                 1]
                                              //                             .value!
                                              //                             .toString()
                                              //                             .replaceAll(
                                              //                                 ',',
                                              //                                 '')
                                              //                         : '',
                                              //                     color: 'blue',
                                              //                     // context
                                              //                     //     .read<
                                              //                     //         ReportsController>()
                                              //                     //     .cardChartData[
                                              //                     //         1]
                                              //                     //     .color!,
                                              //                     cartesianChartKey: context
                                              //                         .read<
                                              //                             ReportsController>()
                                              //                         .cartesianChartKey[0],
                                              //                     reportCnt:
                                              //                         context.read<
                                              //                             ReportsController>(),
                                              //                   )
                                              //                 : Container(),
                                              //           ],
                                              //         ),
                                              //         Row(
                                              //           mainAxisAlignment:
                                              //               MainAxisAlignment
                                              //                   .spaceEvenly,
                                              //           children: [
                                              //             context
                                              //                     .read<
                                              //                         ReportsController>()
                                              //                     .cardChartData
                                              //                     .isNotEmpty
                                              //                 ? CardChartPage(
                                              //                     theme: theme,
                                              //                     name: (context.read<ReportsController>().cardChartData.isNotEmpty || context.read<ReportsController>().cardChartData != null) && context.read<ReportsController>().cardChartData[2].name!.isNotEmpty ||
                                              //                             context.read<ReportsController>().cardChartData[2].name !=
                                              //                                 null
                                              //                         ? context
                                              //                             .read<
                                              //                                 ReportsController>()
                                              //                             .cardChartData[
                                              //                                 2]
                                              //                             .name!
                                              //                         : context
                                              //                             .read<
                                              //                                 ReportsController>()
                                              //                             .cardChartData[
                                              //                                 2]
                                              //                             .name!,
                                              //                     value: context
                                              //                                 .read<
                                              //                                     ReportsController>()
                                              //                                 .cardChartData[
                                              //                                     2]
                                              //                                 .value !=
                                              //                             null
                                              //                         ? context
                                              //                             .read<
                                              //                                 ReportsController>()
                                              //                             .cardChartData[
                                              //                                 2]
                                              //                             .value!
                                              //                             .toString()
                                              //                             .replaceAll(
                                              //                                 ',',
                                              //                                 '')
                                              //                         : '',
                                              //                     color: 'blue',
                                              //                     cartesianChartKey: context
                                              //                         .read<
                                              //                             ReportsController>()
                                              //                         .cartesianChartKey[0],
                                              //                     reportCnt:
                                              //                         context.read<
                                              //                             ReportsController>(),
                                              //                   )
                                              //                 : Container(),
                                              //             context
                                              //                     .read<
                                              //                         ReportsController>()
                                              //                     .cardChartData
                                              //                     .isNotEmpty
                                              //                 ? CardChartPage(
                                              //                     theme: theme,
                                              //                     name: (context.read<ReportsController>().cardChartData.isNotEmpty) && context.read<ReportsController>().cardChartData[3].name!.isNotEmpty ||
                                              //                             context.read<ReportsController>().cardChartData[3].name !=
                                              //                                 null
                                              //                         ? context
                                              //                             .read<
                                              //                                 ReportsController>()
                                              //                             .cardChartData[
                                              //                                 3]
                                              //                             .name!
                                              //                         : '',
                                              //                     value: context
                                              //                                 .read<
                                              //                                     ReportsController>()
                                              //                                 .cardChartData[
                                              //                                     3]
                                              //                                 .value !=
                                              //                             null
                                              //                         ? context
                                              //                             .read<
                                              //                                 ReportsController>()
                                              //                             .cardChartData[
                                              //                                 3]
                                              //                             .value!
                                              //                             .toString()
                                              //                             .replaceAll(
                                              //                                 ',',
                                              //                                 '')
                                              //                         : '',
                                              //                     color: 'rose',
                                              //                     cartesianChartKey: context
                                              //                         .read<
                                              //                             ReportsController>()
                                              //                         .cartesianChartKey[0],
                                              //                     reportCnt:
                                              //                         context.read<
                                              //                             ReportsController>(),
                                              //                   )
                                              //                 : Container(),
                                              //           ],
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ),

                                              context
                                                      .watch<
                                                          ReportsController>()
                                                      .pieChartData
                                                      .isNotEmpty
                                                  ? Container(
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: Screens
                                                                    .padingHeight(
                                                                        context) *
                                                                0.005,
                                                          ),
                                                          PieChartPage(
                                                            title: context
                                                                .watch<
                                                                    ReportsController>()
                                                                .pieChartTitle,
                                                            circularChartKey:
                                                                circularChartKeyPie,
                                                          )
                                                          // PieChartPage(
                                                          // title: context
                                                          //     .watch<
                                                          //         ReportsController>()
                                                          //     .pieChartTitle,
                                                          //   // chartData: context
                                                          //   //     .read<
                                                          //   //         ReportsController>()
                                                          //   //     .pieChartData,
                                                          // circularChartKey: context
                                                          //     .watch<
                                                          //         ReportsController>()
                                                          //     .circularChartKeyPie,
                                                          //   // reportCnt:
                                                          //   //     context.watch<
                                                          //   //         ReportsController>(),
                                                          // ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),

                                              context
                                                          .watch<
                                                              ReportsController>()
                                                          .barChartData
                                                          .length <
                                                      1
                                                  ? Container()
                                                  : Column(
                                                      children: [
                                                        SizedBox(
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.01,
                                                        ),
                                                        BarChartPage(
                                                          chartData: context
                                                              .read<
                                                                  ReportsController>()
                                                              .barChartData,
                                                          title: context
                                                              .watch<
                                                                  ReportsController>()
                                                              .barChartTitle, //'Bar Chart',
                                                          cartesianChartKey: context
                                                              .watch<
                                                                  ReportsController>()
                                                              .cartesianChartKey[1],
                                                        ),
                                                      ],
                                                    ),
                                              // SizedBox(
                                              //   height:
                                              //       Screens.padingHeight(context) *
                                              //           0.01,
                                              // ),
                                              context
                                                          .watch<
                                                              ReportsController>()
                                                          .columnChartData
                                                          .length <
                                                      1
                                                  ? Container()
                                                  : ColumnChartPage(
                                                      title: context
                                                          .watch<
                                                              ReportsController>()
                                                          .columnChartTitle, //'Column Chart',
                                                      chartData: context
                                                          .read<
                                                              ReportsController>()
                                                          .columnChartData,
                                                      cartesianChartKey: context
                                                          .watch<
                                                              ReportsController>()
                                                          .cartesianChartKey[2],
                                                    ),

                                              context
                                                          .watch<
                                                              ReportsController>()
                                                          .lineChartData
                                                          .length <
                                                      1
                                                  ? Container()
                                                  : Column(
                                                      children: [
                                                        SizedBox(
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.01,
                                                        ),
                                                        LineChartDataPage(
                                                          title: context
                                                              .watch<
                                                                  ReportsController>()
                                                              .lineChartTitle,
                                                          chartData: context
                                                              .read<
                                                                  ReportsController>()
                                                              .lineChartData,
                                                          cartesianChartKey: context
                                                              .watch<
                                                                  ReportsController>()
                                                              .cartesianChartKey[3],
                                                        ),
                                                      ],
                                                    ),

                                              context
                                                          .watch<
                                                              ReportsController>()
                                                          .splineChartData
                                                          .length <
                                                      1
                                                  ? Container()
                                                  : Column(
                                                      children: [
                                                        SizedBox(
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.01,
                                                        ),
                                                        SplineChartPage(
                                                          chartData: context
                                                              .read<
                                                                  ReportsController>()
                                                              .splineChartData,
                                                          title: context
                                                              .watch<
                                                                  ReportsController>()
                                                              .splineChartTitle,
                                                          cartesianChartKey: context
                                                              .watch<
                                                                  ReportsController>()
                                                              .cartesianChartKey[4],
                                                        ),
                                                      ],
                                                    ),

                                              context
                                                          .read<
                                                              ReportsController>()
                                                          .bubbleChartData
                                                          .length <
                                                      1
                                                  ? Container()
                                                  : Column(
                                                      children: [
                                                        SizedBox(
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.01,
                                                        ),
                                                        BubbleChartPage(
                                                          chartData: context
                                                              .read<
                                                                  ReportsController>()
                                                              .bubbleChartData,

                                                          title: context
                                                              .watch<
                                                                  ReportsController>()
                                                              .bubbleChartTitle,
                                                          cartesianChartKey: context
                                                              .watch<
                                                                  ReportsController>()
                                                              .cartesianChartKey[5],
                                                          // reportCnt: reportCnt,
                                                        ),
                                                      ],
                                                    ),
                                              // SizedBox(
                                              //   height:
                                              //       Screens.padingHeight(context) *
                                              //           0.01,
                                              // ),

                                              (context
                                                              .watch<
                                                                  ReportsController>()
                                                              .viewTypeCode ==
                                                          "A103") &&
                                                      (context
                                                                  .watch<
                                                                      ReportsController>()
                                                                  .tableColumLoad ==
                                                              true ||
                                                          context
                                                              .watch<
                                                                  ReportsController>()
                                                              .tablercolumn
                                                              .isEmpty)
                                                  ? Container(
                                                      height:
                                                          Screens.padingHeight(
                                                                  context) *
                                                              0.55,
                                                      width: Screens.width(
                                                              context) *
                                                          0.95,
                                                      child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                        color:
                                                            theme.primaryColor,
                                                      )),
                                                    )
                                                  : context
                                                          .watch<
                                                              ReportsController>()
                                                          .tablercolumn
                                                          .isNotEmpty
                                                      ? DataTableWidget(
                                                          tablerColumn: context
                                                              .watch<
                                                                  ReportsController>()
                                                              .tablercolumn)
                                                      : Container(),
                                              SizedBox(
                                                height: Screens.padingHeight(
                                                        context) *
                                                    0.27,
                                              ),
                                              // const CartesianChart(),
                                              // SizedBox(
                                              //   height: Screens.padingHeight(context) * 0.01,
                                              // ),
                                              // const HiloChart(),
                                              // SizedBox(
                                              //   height: Screens.padingHeight(context) * 0.01,
                                              // ),
                                              // const AreaCahrt()
                                            ],
                                          )),
                      ),
          ]),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                    heroTag: 'filter',
                    child: const Icon(
                      Icons.filter_alt_off,
                      color: Colors.white,
                    ),
                    onPressed:
                        context.read<ReportsController>().chartload == true
                            ? null
                            : () async {
                                setState(() {
                                  context.read<ReportsController>().init();
                                });
                              }),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.015,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        heroTag: 'search',
                        onPressed:
                            context.read<ReportsController>().chartload == true
                                ? null
                                : () {
                                    setState(() {});
                                    context
                                        .read<ReportsController>()
                                        .showBottomSheetInsert(context, theme);
                                  },
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      FloatingActionButton(
                          heroTag: 'filter1',
                          child: const Icon(
                            Icons.filter_alt_rounded,
                            color: Colors.white,
                          ),
                          onPressed:
                              context.read<ReportsController>().chartload ==
                                      true
                                  ? null
                                  : () async {
                                      setState(() {
                                        context
                                            .read<ReportsController>()
                                            .onTapFilter(context, theme);
                                        if ((context
                                                    .read<ReportsController>()
                                                    .startDate
                                                    .isNotEmpty &&
                                                context
                                                    .read<ReportsController>()
                                                    .endDate
                                                    .isNotEmpty) ||
                                            context
                                                    .read<ReportsController>()
                                                    .leadTablViewData
                                                    .length >
                                                0) {
                                          scaffoldKeyys.currentState
                                              ?.openEndDrawer();
                                        }
                                      });
                                    })
                    ]),
              ],
            ),
          )),
    );
  }

  Container dateRangeContainer(
    BuildContext context,
    ThemeData theme,
  ) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(
            bottom: Screens.padingHeight(context) * 0.01,
            top: Screens.padingHeight(context) * 0.008),
        // height: Screens.padingHeight(context) * 0.13,
        width: Screens.width(context),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey[400]!,
              offset: Offset.fromDirection(2.0),
              spreadRadius: 2.0,
              blurRadius: 0.2)
        ]),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Screens.width(context) * 0.02,
                  right: Screens.width(context) * 0.02),
              color: Colors.white,
              height: Screens.padingHeight(context) * 0.04,
              width: Screens.width(context),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: context.read<ReportsController>().dateRange.length,
                itemBuilder: (BuildContext context, int ind) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (context
                                    .read<ReportsController>()
                                    .onTapDateRange ==
                                false) {
                              context.read<ReportsController>().isselectRange(
                                  ind,
                                  context
                                      .read<ReportsController>()
                                      .dateRange[ind]
                                      .rangeType!,
                                  context);
                            } else {}
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: Screens.width(context) * 0.23,
                          height: Screens.padingHeight(context) * 0.035,
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: context
                                          .watch<ReportsController>()
                                          .dateRange[ind]
                                          .color ==
                                      1
                                  ? theme.primaryColor.withOpacity(0.5)
                                  : theme.primaryColor,
                              border: Border.all(
                                  color: theme.primaryColor, width: 1),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                              context
                                  .watch<ReportsController>()
                                  .dateRange[ind]
                                  .rangeType!,
                              // maxLines: 1,
                              //overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: context
                                            .read<ReportsController>()
                                            .dateRange[ind]
                                            .color ==
                                        1
                                    ? Colors.black
                                    : Colors.white,
                              )),
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.02,
                      )
                    ],
                  );
                },
              ),
            ),

            // Wrap(
            //     alignment: WrapAlignment.center,
            //     spacing: 10.0, // gap between adjacent chips
            //     runSpacing: 15.0,
            //     children: listofDateFilers(
            //       theme,
            //     )),
            Visibility(
              visible: context.read<ReportsController>().visibleSelectedDate,
              child: Container(
                padding: EdgeInsets.all(Screens.padingHeight(context) * 0.01),
                width: Screens.width(context),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.read<ReportsController>().startDate.isEmpty ||
                                  context.read<ReportsController>().startDate ==
                                      null
                              ? ''
                              :
                              // "${config.alignDate(config.findFirstDateOfTheWeek(DateTime.now()).toString())} to ${config.alignDate(config.findLastDateOfTheWeek(DateTime.now()).toString())}",
                              '${context.read<ReportsController>().startDate} to ${context.read<ReportsController>().endDate}',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const Divider(),
                    context.read<ReportsController>().viewType != null
                        ? Text(
                            'View : ${context.read<ReportsController>().viewType}',
                            style: theme.textTheme.bodyMedium,
                          )
                        : Container(),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  List<Widget> listofDateFilers(
    ThemeData theme,
  ) {
    return List.generate(
      context.read<ReportsController>().dateRange.length,
      (ind) => GestureDetector(
        onTap: () {
          setState(() {
            context.read<ReportsController>().isselectRange(
                ind,
                context.read<ReportsController>().dateRange[ind].rangeType!,
                context);
          });

          // repCon.openCustomrange(
          //     repCon.dateRange[ind].rangeType!, context, repCon);
          // context
          //.read<NewEnqController>().selectedIdxFUser = ind;
          // context.read<NewEnqController>().selectUser(ind);
        },
        child: Container(
          alignment: Alignment.center,
          width: Screens.width(context) * 0.23,
          height: Screens.padingHeight(context) * 0.035,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              color:
                  context.watch<ReportsController>().dateRange[ind].color == 1
                      ? theme.primaryColor.withOpacity(0.5)
                      : theme.primaryColor,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: Text(
              context.watch<ReportsController>().dateRange[ind].rangeType!,
              // maxLines: 1,
              //overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color:
                    context.read<ReportsController>().dateRange[ind].color == 1
                        ? Colors.black
                        : Colors.white,
              )),
        ),
      ),
    );
  }

  // listofDateFilersxx(
  //   ThemeData theme,
  // ) {
  //   return

  //       // List.generate(
  //       //   context.read<ReportsController>().dateRange.length,
  //       //   (ind) =>

  //       Container(
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: context.read<ReportsController>().dateRange.length,
  //       itemBuilder: (BuildContext context, int ind) {
  //         return GestureDetector(
  //           onTap: () {
  //             setState(() {
  //               context.read<ReportsController>().isselectRange(
  //                   ind,
  //                   context.read<ReportsController>().dateRange[ind].rangeType!,
  //                   context);
  //             });
  //           },
  //           child: Container(
  //             alignment: Alignment.center,
  //             width: Screens.width(context) * 0.23,
  //             height: Screens.padingHeight(context) * 0.035,
  //             padding: const EdgeInsets.all(3),
  //             decoration: BoxDecoration(
  //                 color:
  //                     context.watch<ReportsController>().dateRange[ind].color ==
  //                             1
  //                         ? theme.primaryColor.withOpacity(0.5)
  //                         : theme.primaryColor,
  //                 border: Border.all(color: theme.primaryColor, width: 1),
  //                 borderRadius: BorderRadius.circular(5)),
  //             child: Text(
  //                 context.watch<ReportsController>().dateRange[ind].rangeType!,
  //                 // maxLines: 1,
  //                 //overflow: TextOverflow.ellipsis,
  //                 style: theme.textTheme.bodyMedium?.copyWith(
  //                   fontWeight: FontWeight.normal,
  //                   fontSize: 12,
  //                   color: context
  //                               .read<ReportsController>()
  //                               .dateRange[ind]
  //                               .color ==
  //                           1
  //                       ? Colors.black
  //                       : Colors.white,
  //                 )),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // // BarChartData(1, 35),
  // BarChartData(
  //   2,
  //   23,
  // ),
  // BarChartData(3, 34),
  // BarChartData(4, 25),
  // BarChartData(5, 40)
  // [
  //   ColumnChartData(2010, 35, 23),
  //   ColumnChartData(2011, 38, 49),
  //   ColumnChartData(2012, 34, 12),
  //   ColumnChartData(2013, 52, 33),
  //   ColumnChartData(2014, 40, 30)
  // ],
  //  [
  //   SplineChartData(2010, 35),
  //   SplineChartData(2011, 13),
  //   SplineChartData(2012, 34),
  //   SplineChartData(2013, 27),
  //   SplineChartData(2014, 40)
  // ],
  // [
  //   BubbleChartData(DateTime(2010), 35,
  //       0.32, Colors.teal),
  //   BubbleChartData(DateTime(2011), 38,
  //       0.21, Colors.red),
  //   BubbleChartData(DateTime(2012), 34,
  //       0.38, Colors.blueGrey),
  //   BubbleChartData(DateTime(2013), 52,
  //       0.29, Colors.black),
  //   BubbleChartData(DateTime(2014), 40,
  //       0.34, Colors.indigo),
  //   BubbleChartData(DateTime(2010), 35,
  //       0.32, Colors.teal),
  //   BubbleChartData(DateTime(2011), 38,
  //       0.21, Colors.red),
  //   BubbleChartData(DateTime(2012), 34,
  //       0.38, Colors.blueGrey),
  //   BubbleChartData(DateTime(2013), 52,
  //       0.29, Colors.black),
  //   BubbleChartData(DateTime(2014), 40,
  //       0.34, Colors.indigo)
  // ],
// LineCharData(2010, 35, Colors.blue),
  // LineCharData(2011, 28, Colors.teal),
  // LineCharData(
  //     2012, 34, Colors.purpleAccent),
  // LineCharData(
  //     2013, 32, Colors.lightBlue),
  // LineCharData(
  //     2014, 40, Colors.cyanAccent),
  // LineCharData(2016, 35, Colors.blue),
  // LineCharData(2017, 28, Colors.teal),
  // LineCharData(
  //     2018, 34, Colors.purpleAccent),
  // LineCharData(
  //     2019, 32, Colors.lightBlue),
  // LineCharData(
  //     2029, 40, Colors.cyanAccent)

  // ); //
  // }); //
  // }

  // viewSearch(
  //   BuildContext context,
  // ) {
  //   return showModalBottomSheet(
  //       context: context,
  //       builder: (context) => StatefulBuilder(builder: (context, st) {
  //             return SingleChildScrollView(
  //               child: Container(
  //                 height: MediaQuery.of(context).size.height * 0.3,
  //                 decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(00.0),
  //                         topRight: Radius.circular(00.0))),
  //                 padding: EdgeInsets.all(Screens.padingHeight(context) * 0.01),
  //                 // height: Screens.padingHeight(context) * 0.3,
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     Expanded(
  //                         child: ListView.builder(
  //                             itemCount: context
  //                                 .watch<ReportsController>()
  //                                 .leadAnalysisReportDataset
  //                                 .length,
  //                             itemBuilder: (BuildContext context, int i) {
  //                               return InkWell(
  //                                   onTap: () {
  //                                     st(
  //                                       () {
  //                                         context
  //                                             .read<ReportsController>()
  //                                             .mapTableData();
  //                                         log('eadAnalysismasterDataset length::${context.read<ReportsController>().leadAnalysismasterDataset.length}');
  //                                         Navigator.pop(context);
  //                                       },
  //                                     );
  //                                   },
  //                                   child: Column(
  //                                     children: [
  //                                       Container(
  //                                         padding: EdgeInsets.all(
  //                                           Screens.padingHeight(context) * 0.01,
  //                                         ),
  //                                         child: Row(
  //                                           children: [
  //                                             Text(context
  //                                                 .watch<ReportsController>()
  //                                                 .leadAnalysisReportDataset[i]
  //                                                 .viewCode),
  //                                             Text(' - '),
  //                                             Text(context
  //                                                 .watch<ReportsController>()
  //                                                 .leadAnalysisReportDataset[i]
  //                                                 .viewName),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                       Divider()
  //                                     ],
  //                                   ));
  //                             })),
  //                     SizedBox(
  //                       height: Screens.padingHeight(context) * 0.02,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           }));
  // }

  // Container Titlebar(BuildContext context, ThemeData theme) {
  //   return Container(
  //       alignment: Alignment.center,
  //       height: Screens.padingHeight(context) * 0.15,
  //       width: Screens.width(context),
  //       decoration: BoxDecoration(color: Colors.white, boxShadow: [
  //         BoxShadow(
  //             color: Colors.grey[400]!,
  //             offset: Offset.fromDirection(2.0),
  //             spreadRadius: 2.0,
  //             blurRadius: 0.2)
  //       ]),
  //       child: Wrap(
  //         alignment: WrapAlignment.center,

  //         spacing: 25.0, // gap between adjacent chips
  //         runSpacing: 25.0,
  //         children: [
  //           Container(
  //             alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //                 color: theme.primaryColor,
  //                 borderRadius: BorderRadius.circular(
  //                     Screens.padingHeight(context) * 0.008)),
  //             height: Screens.padingHeight(context) * 0.04,
  //             width: Screens.width(context) * 0.2,
  //             child: Text(
  //               "This Week",
  //               style: theme.textTheme.bodyMedium!.copyWith(
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //           Container(
  //             alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //                 color: theme.primaryColor,
  //                 borderRadius: BorderRadius.circular(
  //                     Screens.padingHeight(context) * 0.008)),
  //             height: Screens.padingHeight(context) * 0.04,
  //             width: Screens.width(context) * 0.2,
  //             child: Text(
  //               "This Month",
  //               style: theme.textTheme.bodyMedium!.copyWith(
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //           Container(
  //             alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //                 color: theme.primaryColor,
  //                 borderRadius: BorderRadius.circular(
  //                     Screens.padingHeight(context) * 0.008)),
  //             height: Screens.padingHeight(context) * 0.04,
  //             width: Screens.width(context) * 0.2,
  //             child: Text(
  //               "This Year",
  //               style: theme.textTheme.bodyMedium!.copyWith(
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //           Container(
  //             alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //                 color: theme.primaryColor,
  //                 borderRadius: BorderRadius.circular(
  //                     Screens.padingHeight(context) * 0.008)),
  //             height: Screens.padingHeight(context) * 0.04,
  //             width: Screens.width(context) * 0.2,
  //             child: Text(
  //               "This Qtr",
  //               style: theme.textTheme.bodyMedium!.copyWith(
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //           Container(
  //             alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //                 color: theme.primaryColor,
  //                 borderRadius: BorderRadius.circular(
  //                     Screens.padingHeight(context) * 0.008)),
  //             height: Screens.padingHeight(context) * 0.04,
  //             width: Screens.width(context) * 0.2,
  //             child: Text(
  //               "Today",
  //               style: theme.textTheme.bodyMedium!.copyWith(
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //           Container(
  //             alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //                 color: theme.primaryColor,
  //                 borderRadius: BorderRadius.circular(
  //                     Screens.padingHeight(context) * 0.008)),
  //             height: Screens.padingHeight(context) * 0.04,
  //             width: Screens.width(context) * 0.2,
  //             child: Text(
  //               "Yesterday",
  //               style: theme.textTheme.bodyMedium!.copyWith(
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //           Container(
  //             alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //                 color: theme.primaryColor,
  //                 borderRadius: BorderRadius.circular(
  //                     Screens.padingHeight(context) * 0.008)),
  //             height: Screens.padingHeight(context) * 0.04,
  //             width: Screens.width(context) * 0.2,
  //             child: Text(
  //               "Customize",
  //               style: theme.textTheme.bodyMedium!.copyWith(
  //                 color: Colors.white,
  //               ),
  //             ),
  //           )
  //         ],
  //       ));
  // }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
