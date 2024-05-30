// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/EarningController/EarningController.dart';
import 'package:sellerkit/Pages/MyEarnings/Screens/Earningloaddata.dart';
import 'package:sellerkit/Pages/MyEarnings/Widgets/MoneyWidget.dart';
import 'package:sellerkit/Widgets/Appbar.dart';

import '../../../Constant/padings.dart';
import '../../../Widgets/Navi3.dart';

class MyEarnings extends StatefulWidget {
  // const MyEarnings({Key? key}) : super(key: key);
  @override
  State<MyEarnings> createState() => MyEarningsState();
}

class MyEarningsState extends State<MyEarnings> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  Config config = Config();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<EarningController>().init();
    });
  }

  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
        onWillPop: context.read<EarningController>().onbackpress,
        child: Scaffold(
            drawerEnableOpenDragGesture: false,
            key: scaffoldKey,
            appBar: appbar("My Earnings", scaffoldKey, theme, context),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                //

                context.read<EarningController>().clearEarningFilterData();
                await context
                    .read<EarningController>()
                    .callTargetUsersApi(context);
                setState(() {
                  context.read<EarningController>().showbottombtn(context);
                });
              },
              child: Icon(Icons.filter_alt),
            ),
            drawer: drawer3(context),
            body: SafeArea(
                child: Container(
              height: Screens.padingHeight(context),
              padding: EdgeInsets.only(
                top: Screens.padingHeight(context) * 0.015,
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
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
                  context.watch<EarningController>().kpilottie.isNotEmpty &&
                          context
                              .watch<EarningController>()
                              .earningtableData1
                              .isEmpty
                      ? SizedBox(
                          height: Screens.padingHeight(context) * 0.5,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                context
                                        .watch<EarningController>()
                                        .kpilottie
                                        .contains(".png")
                                    ? Image.asset(
                                        '${context.watch<EarningController>().kpilottie}',
                                        height:
                                            Screens.padingHeight(context) * 0.2,
                                        width: Screens.width(context) * 0.5)
                                    : Lottie.asset(
                                        '${context.watch<EarningController>().kpilottie}',
                                        animate: true,
                                        repeat: true,
                                        // height: Screens.padingHeight(context) * 0.3,
                                        width: Screens.width(context) * 0.4),
                                Text(context
                                    .watch<EarningController>()
                                    .earningexp)
                              ],
                            ),
                          ),
                        )
                      : context
                                  .watch<EarningController>()
                                  .earningtableData1
                                  .isEmpty &&
                              context.watch<EarningController>().isloading ==
                                  true
                          ? Container(
                              height: Screens.padingHeight(context) * 0.7,
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: theme.primaryColor,
                              )),
                            )
                          : RefreshIndicator(
                              onRefresh: () {
                                return context
                                    .read<EarningController>()
                                    .refreshData();
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: paddings.padding2(context),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MoneyWidget(
                                        theme: theme,
                                        // prdern: prdEarn,
                                      ),
                                      SizedBox(
                                        height: Screens.padingHeight(context) *
                                            0.01,
                                      ),
                                      Container(
                                        height: Screens.padingHeight(context) *
                                            0.65,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          itemCount: context
                                              .watch<EarningController>()
                                              .earningtableData1
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return Card(
                                                margin: EdgeInsets.all(0.3),
                                                elevation: 0.5,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: Screens.width(
                                                              context) *
                                                          0.6,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: Screens.width(
                                                                      context) *
                                                                  0.01,
                                                              right: Screens.width(
                                                                      context) *
                                                                  0.01,
                                                              top: Screens.padingHeight(
                                                                      context) *
                                                                  0.01,
                                                              bottom: Screens
                                                                      .padingHeight(
                                                                          context) *
                                                                  0.01,
                                                            ),
                                                            // width: Screens.width(
                                                            //     context),
                                                            child: Text(
                                                              context
                                                                  .watch<
                                                                      EarningController>()
                                                                  .earningtableData1[
                                                                      i]
                                                                  .description
                                                                  .toString(),
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyText2
                                                                  ?.copyWith(),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: Screens
                                                                    .padingHeight(
                                                                        context) *
                                                                0.01,
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                              left: Screens.width(
                                                                      context) *
                                                                  0.01,
                                                              right: Screens.width(
                                                                      context) *
                                                                  0.01,
                                                              top: Screens.padingHeight(
                                                                      context) *
                                                                  0.001,
                                                              bottom: Screens
                                                                      .padingHeight(
                                                                          context) *
                                                                  0.01,
                                                            ),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              context
                                                                  .watch<
                                                                      EarningController>()
                                                                  .earningtableData1[
                                                                      i]
                                                                  .transDate,

                                                              // config.currentDateOnly(),
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyText2
                                                                  ?.copyWith(),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: Screens.width(
                                                              context) *
                                                          0.31,
                                                      padding: EdgeInsets.only(
                                                          right: Screens.width(
                                                                  context) *
                                                              0.015),
                                                      alignment:
                                                          Alignment.centerRight,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Text(
                                                        context
                                                            .watch<
                                                                EarningController>()
                                                            .earningtableData1[
                                                                i]
                                                            .amount
                                                            .toStringAsFixed(2),
                                                        style: theme.textTheme
                                                            .titleMedium
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    )
                                                  ],
                                                ));
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: Screens.padingHeight(context) *
                                            0.025,
                                      ),
                                      Container(
                                          alignment: Alignment.center,
                                          width: Screens.width(context),
                                          child: GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<EarningController>()
                                                  .loadDataClear();

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EarningMoreData()));
                                            },
                                            child: Text(
                                                "<<  Load More Data  >>",
                                                style: theme.textTheme.bodyLarge
                                                    ?.copyWith(
                                                        fontSize: 15,
                                                        color: theme
                                                            .primaryColor)),
                                          )),
                                    ],
                                  )),
                            ),
                ],
              ),
            )))
        // ),
        );
    //   });
    // });
  }
}
