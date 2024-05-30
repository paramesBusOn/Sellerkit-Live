// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Constant/padings.dart';
import 'package:sellerkit/Widgets/Appbar.dart';
import '../../../Controller/ScoreCardController/Scorecardcontroller.dart';
import '../../../Widgets/Navi3.dart';
import '../Widgets/PositionWidgets.dart';

class ScoreCardScreenOne extends StatefulWidget {
  const ScoreCardScreenOne({Key? key}) : super(key: key);

  @override
  State<ScoreCardScreenOne> createState() => _ScoreCardScreenOneState();
}

class _ScoreCardScreenOneState extends State<ScoreCardScreenOne> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        drawerEnableOpenDragGesture: false,
        key: scaffoldKey,
        appBar: appbar("Score Card 1", scaffoldKey, theme, context),
        drawer: drawer3(context),
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            // Check if the user is swiping from left to right
            print(details.primaryDelta);
            if (details.primaryDelta! > ConstantValues.slidevalue!) {
              setState(() {
                Get.offAllNamed(ConstantRoutes.dashboard);
              });
            }
          },
          child: ChangeNotifierProvider<ScoreCardController>(
              create: (context) => ScoreCardController(),
              builder: (context, child) {
                return Consumer<ScoreCardController>(
                    builder: (BuildContext context, prdSCD, Widget? child) {
                  return SafeArea(
                      child: prdSCD.getscorecardDataExcep.isEmpty &&
                              prdSCD.getscoreloading == true
                          ? Center(
                              child: CircularProgressIndicator(
                              color: theme.primaryColor,
                            ))
                          : prdSCD.getscorecardDataExcep.isNotEmpty &&
                                  prdSCD.getscoreloading == false
                              ? Center(
                                  child: Text(prdSCD.getscorecardDataExcep))
                              : SingleChildScrollView(
                                  child: Container(
                                      // height: Screens.padingHeight(context) * 1.6,
                                      padding: paddings.padding2(context),
                                      child: Column(
                                        children: [
                                          MonthToperWidget(
                                            theme: theme,
                                            prdFUP: prdSCD,
                                          ),

                                          BranchToperWidget(
                                            theme: theme,
                                            prdFUP: prdSCD,
                                          ),

                                          SpecialPerformerWidget(
                                            theme: theme,
                                            prdFUP: prdSCD,
                                          ),

                                          PositionWidget(
                                            theme: theme,
                                            prdFUP: prdSCD,
                                          ),

                                          ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                prdSCD.getlistViewData.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              var keyss = prdSCD.getlistViewData
                                                  .toList();

                                              return Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        Screens.bodyheight(
                                                                context) *
                                                            0.01,
                                                    horizontal:
                                                        Screens.width(context) *
                                                            0.03),
                                                color: index % 2 == 0
                                                    ? Colors.grey[200]
                                                    : Colors.white,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          child: Text(
                                                              keyss[index]
                                                                  .kpi
                                                                  .toString(),
                                                              style: theme
                                                                  .textTheme
                                                                  .subtitle1),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              //  color: Colors.red,
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              width: Screens.width(
                                                                      context) *
                                                                  0.2,
                                                              child: Text(
                                                                  keyss[index]
                                                                      .rank
                                                                      .toString(),
                                                                  style: theme
                                                                      .textTheme
                                                                      .bodyLarge),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                          // )),
                                        ],
                                        // ),
                                      ))));
                });
              }),
        ));
  }
}

class MonthToperWidget extends StatelessWidget {
  const MonthToperWidget({
    Key? key,
    required this.theme,
    required this.prdFUP,
  }) : super(key: key);

  final ThemeData theme;
  final ScoreCardController prdFUP;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Screens.width(context),
      height: Screens.bodyheight(context) * 0.26,
      child: Column(children: [
        Container(
            padding: EdgeInsets.all(Screens.bodyheight(context) * 0.011),
            alignment: Alignment.center,
            width: Screens.width(context),
            decoration: BoxDecoration(color: theme.primaryColor),
            child: Text(
              prdFUP.getmonthScore1Data[0].title.toString(),
              style: theme.textTheme.bodyText1?.copyWith(color: Colors.white),
            )),
        SizedBox(
          height: Screens.bodyheight(context) * 0.01,
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: prdFUP.getmonthScore1Data.length,
            itemBuilder: (BuildContext context, int index) {
              var keyss1 = prdFUP.getmonthScore1Data.toList();

              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    vertical: Screens.bodyheight(context) * 0.005,
                    horizontal: Screens.width(context) * 0.02),
                width: Screens.width(context) * 0.3,
                child: Column(
                  children: [
                    Container(
                      width: Screens.width(context) * 0.2,
                      height: Screens.bodyheight(context) * 0.1,
                      color: Colors.grey[200],
                      child: keyss1[index].profilePic != null
                          ? Image.network('${keyss1[index].profilePic}')
                          : Icon(
                              Icons.perm_identity,
                              size: Screens.bodyheight(context) * 0.065,
                              color: theme.primaryColor,
                            ),
                    ),
                    Container(
                      child: Text(
                        keyss1[index].rank.toString(),
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: theme.primaryColor),
                      ),
                    ),
                    Container(
                      child: Text(
                        keyss1[index].name.toString(),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: theme.primaryColor),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}

class BranchToperWidget extends StatelessWidget {
  const BranchToperWidget({
    Key? key,
    required this.theme,
    required this.prdFUP,
  }) : super(key: key);

  final ThemeData theme;
  final ScoreCardController prdFUP;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Screens.width(context),
      height: Screens.bodyheight(context) * 0.26,
      child: Column(children: [
        Container(
            padding: EdgeInsets.all(Screens.bodyheight(context) * 0.016),
            alignment: Alignment.center,
            width: Screens.width(context),
            decoration: BoxDecoration(color: theme.primaryColor),
            child: Text(
              prdFUP.getbranchScore2Data[0].title.toString(),
              style: theme.textTheme.bodyText1?.copyWith(color: Colors.white),
            )),
        SizedBox(
          height: Screens.bodyheight(context) * 0.01,
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: prdFUP.getbranchScore2Data.length,
            itemBuilder: (BuildContext context, int index) {
              var keys2 = prdFUP.getbranchScore2Data.toList();
              // itemCount:
              //     context.watch<ScoreCardController>().getbranchScore2Data.length,
              // itemBuilder: (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    vertical: Screens.bodyheight(context) * 0.005,
                    horizontal: Screens.width(context) * 0.02),
                width: Screens.width(context) * 0.3,
                child: Column(
                  children: [
                    Container(
                      width: Screens.width(context) * 0.2,
                      height: Screens.bodyheight(context) * 0.1,
                      color: Colors.grey[200],
                      child: keys2[index].profilePic != null
                          ? Image.network('${keys2[index].profilePic}')
                          : Icon(
                              Icons.perm_identity,
                              size: Screens.bodyheight(context) * 0.065,
                              color: theme.primaryColor,
                            ),
                    ),
                    //  Column(
                    //    children: [
                    Container(
                      child: Text(
                        keys2[index].rank.toString(),
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: theme.primaryColor),
                      ),
                    ),
                    Container(
                      child: Text(
                        keys2[index].name.toString(),
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: theme.primaryColor),
                      ),
                    ),
                    //    ],
                    //  )
                  ],
                ),
                // ),
              );
            },
          ),
        )
      ]),
    );
  }
}

class SpecialPerformerWidget extends StatelessWidget {
  const SpecialPerformerWidget({
    Key? key,
    required this.theme,
    required this.prdFUP,
  }) : super(key: key);

  final ThemeData theme;
  final ScoreCardController prdFUP;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Screens.width(context),
      height: Screens.bodyheight(context) * 0.26,
      // color: Colors.grey,getspecialScore2Data
      child: Column(children: [
        Container(
            padding: EdgeInsets.all(Screens.bodyheight(context) * 0.011),
            alignment: Alignment.center,
            width: Screens.width(context),
            decoration: BoxDecoration(color: theme.primaryColor),
            child: Text(
              prdFUP.getspecialScore3Data[0].title.toString(),
              style: theme.textTheme.bodyText1?.copyWith(color: Colors.white),
            )),
        SizedBox(
          height: Screens.bodyheight(context) * 0.01,
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,

            itemCount: prdFUP.getspecialScore3Data.length,
            //prdFUP.getdistinctData.length,

            itemBuilder: (BuildContext context, int index) {
              var keyss3 = prdFUP.getspecialScore3Data.toList();

              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    vertical: Screens.bodyheight(context) * 0.005,
                    horizontal: Screens.width(context) * 0.02),
                width: Screens.width(context) * 0.3,
                child: Column(
                  children: [
                    Container(
                      width: Screens.width(context) * 0.2,
                      height: Screens.bodyheight(context) * 0.1,
                      color: Colors.grey[200],
                      child: keyss3[index].profilePic != null
                          ? Image.network('${keyss3[index].profilePic}')
                          : Icon(
                              Icons.perm_identity,
                              size: Screens.bodyheight(context) * 0.065,
                              color: theme.primaryColor,
                            ),
                    ),
                    //  Column(
                    //    children: [
                    Container(
                      child: Text(
                        keyss3[index].rank.toString(),
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: theme.primaryColor),
                      ),
                    ),
                    Container(
                      child: Text(
                        keyss3[index].name.toString(),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText1
                            ?.copyWith(color: theme.primaryColor),
                      ),
                    ),
                    //    ],
                    //  )
                  ],
                ),
                // ),
              );
            },
          ),
        )
      ]),
    );
  }
}
