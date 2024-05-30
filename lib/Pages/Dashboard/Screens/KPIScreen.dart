// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/DashBoardController/KPIController.dart';
import '../../../Constant/Configuration.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/DashBoardController/DashBoardController.dart';
import '../../../Models/KpiModel/KpiModel.dart';
import '../widgets/TokenWidgets.dart';

class KPIScreen extends StatelessWidget {
  Paddings paddings = new Paddings();
  //  List<GridConValue> data1;
  //  List<GridConValue> data2;//required this.data1,required this.data2
  KpiModelData? kpiData;
  int color = 0;
  DashBoardController pvdDSBD;
  KPIScreen(
      {Key? key,
      required this.kpiData,
      required this.color,
      required this.pvdDSBD})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Container(
        width: Screens.width(context),
        height: Screens.bodyheight(context),
        //color: Colors.blue,
        padding: paddings.padding3(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //GridContaiers(data: data1, theme: theme),
            //
            //  SizedBox(height: Screens.bodyheight(context)*0.02,),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () {
                  return pvdDSBD.swipeRefreshIndiactor();
                },
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            TokenWidgets(
                              newe: true,
                              //  count: color,
                              theme: theme, color: 'blue', name: 'Enquiry',
                              value: '${kpiData!.Enquiries}',
                            ),
                            TokenWidgets(
                              theme: theme,
                              color: 'rose',
                              name: 'OpenLeads',
                              value: '${kpiData!.OpenLeads}',
                            ),
                            TokenWidgets(
                              theme: theme,
                              color: '',
                              name: 'Lead Conversion',
                              value: '${kpiData!.LeadConversion.toStringAsFixed(2)}',
                            ), //.toStringAsFixed(2)
                          ],
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        Row(
                          children: [
                            TokenWidgets(
                              theme: theme,
                              color: 'blue',
                              name: 'Today Followup',
                              value: '${kpiData!.TodayFUP}',
                            ),
                            TokenWidgets(
                              theme: theme,
                              color: 'rose',
                              name: 'Overdue Followup',
                              value: '${kpiData!.OverdueFUP}',
                            ),
                            TokenWidgets(
                              theme: theme,
                              color: '',
                              name: 'Sales conversion',
                              value: '${kpiData!.SalesConversion}',
                            ), //.toStringAsFixed(2)
                          ],
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.03,
                        ),
                        Container(
                          width: Screens.width(context),
                          child: Text(
                            "NPS (Last 30 days) ${kpiData!.NPS}",
                            style: theme.textTheme.bodyText1,
                          ),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.008,
                        ),
                        NpsContainer(
                          mark: kpiData!.NPS,
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.02,
                        ),
                        //GridContaiers(data: data2, theme: theme),
                        Row(
                          children: [
                            TokenWidgets(
                                theme: theme,
                                color: 'blue',
                                name: 'Sales',
                                value: "${kpiData!.Sales}"
                                // Config.k_m_b_generator(kpiData!.Sales.toStringAsFixed(0))
                                ), // '₹ ${kpiData!.Sales.toStringAsFixed(2)}' NumberFormatter.formatter(kpiData!.Sales.toString()),
                            TokenWidgets(
                                theme: theme,
                                color: 'rose',
                                name: 'Target',
                                value: "${kpiData!.Target}"
                                //Config.k_m_b_generator(kpiData!.Target.toStringAsFixed(0))
                                ), //'₹ ${kpiData!.Target.toStringAsFixed(2)}',
                            TokenWidgets(
                              theme: theme,
                              color: '',
                              name: 'Ach%',
                              value: "${kpiData!.Ach}"
                              //'${kpiData!.Ach.toStringAsFixed(2)}'
                              ,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        Row(
                          children: [
                            TokenWidgets(
                                theme: theme,
                                color: 'blue',
                                name: 'Day Target',
                                value: "${kpiData!.DayTarget}"
                                // Config.k_m_b_generator(kpiData!.DayTarget.toStringAsFixed(0))
                                ), //'${kpiData!.DayTarget.toStringAsFixed(2)}',/NumberFormatter.formatter(kpiData!.DayTarget.toStringAsFixed(0))
                            TokenWidgets(
                              theme: theme,
                              color: 'rose',
                              name: 'Till Now',
                              value: '${kpiData!.TillNow}',
                            ), //.toStringAsFixed(2)
                            TokenWidgets(
                              theme: theme,
                              color: '',
                              name: 'Run Rate',
                              value: '${kpiData!.RunRate}',
                            ), //.toStringAsFixed(2)
                          ],
                        ),
                      ],
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

class NpsContainer extends StatelessWidget {
  const NpsContainer({
    required this.mark,
    Key? key,
  }) : super(key: key);

  final double mark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: Screens.width(context),
      height: Screens.bodyheight(context) * 0.09,
      //color: Colors.black,
      child: Stack(
        children: [
          Positioned(
            top: Screens.bodyheight(context) * 0.01,
            left: Screens.width(context) * 0.01,
            child: Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
              //  color: Colors.red,
              child: Row(
                children: [
                  Container(
                    width: Screens.width(context) * 0.09,
                    height: Screens.bodyheight(context) * 0.06,
                    color: Colors.red[800],
                    alignment: Alignment.center,
                    child: Text(
                      "1",
                      style: theme.textTheme.bodyText1
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: Screens.width(context) * 0.09,
                    height: Screens.bodyheight(context) * 0.06,
                    color: Colors.red[700],
                    alignment: Alignment.center,
                    child: Text(
                      "2",
                      style: theme.textTheme.bodyText1
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: Screens.width(context) * 0.09,
                    height: Screens.bodyheight(context) * 0.06,
                    color: Colors.red[600],
                    alignment: Alignment.center,
                    child: Text(
                      "3",
                      style: theme.textTheme.bodyText1
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: Screens.width(context) * 0.09,
                    height: Screens.bodyheight(context) * 0.06,
                    color: Colors.red[500],
                    alignment: Alignment.center,
                    child: Text(
                      "4",
                      style: theme.textTheme.bodyText1
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: Screens.width(context) * 0.09,
                    height: Screens.bodyheight(context) * 0.06,
                    color: Colors.red[400],
                    alignment: Alignment.center,
                    child: Text(
                      "5",
                      style: theme.textTheme.bodyText1
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: Screens.width(context) * 0.09,
                    height: Screens.bodyheight(context) * 0.06,
                    color: Colors.red[300],
                    alignment: Alignment.center,
                    child: Text(
                      "6",
                      style: theme.textTheme.bodyText1
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: Screens.width(context) * 0.09,
                    height: Screens.bodyheight(context) * 0.06,
                    color: Colors.yellow[300],
                    alignment: Alignment.center,
                    child: Text(
                      "7",
                      style: theme.textTheme.bodyText1
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                  Container(
                    width: Screens.width(context) * 0.09,
                    height: Screens.bodyheight(context) * 0.06,
                    color: Colors.yellow,
                    alignment: Alignment.center,
                    child: Text(
                      "8",
                      style: theme.textTheme.bodyText1
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                  Container(
                    width: Screens.width(context) * 0.09,
                    height: Screens.bodyheight(context) * 0.06,
                    color: Colors.green[400],
                    alignment: Alignment.center,
                    child: Text(
                      "9",
                      style: theme.textTheme.bodyText1
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: Screens.width(context) * 0.09,
                    height: Screens.bodyheight(context) * 0.06,
                    color: Colors.green,
                    alignment: Alignment.center,
                    child: Text(
                      "10",
                      style: theme.textTheme.bodyText1
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //    width: Screens.width(context)*0.7,
          //      height: Screens.bodyheight(context)*0.08,
          //      color: theme.primaryColor.withOpacity(0.3),
          // ),
          Positioned(
            left: mark >= 1 && mark <= 1.9
                ? Screens.width(context) * 0.02
                : mark >= 2 && mark <= 2.9
                    ? Screens.width(context) * 0.1
                    : mark >= 3 && mark <= 3.9
                        ? Screens.width(context) * 0.19
                        : mark >= 4 && mark <= 4.9
                            ? Screens.width(context) * 0.28
                            : mark >= 5 && mark <= 5.9
                                ? Screens.width(context) * 0.37
                                : mark >= 6 && mark <= 6.9
                                    ? Screens.width(context) * 0.46
                                    : mark >= 7 && mark < 7.9
                                        ? Screens.width(context) * 0.55
                                        : mark >= 8 && mark < 8.9
                                            ? Screens.width(context) * 0.64
                                            : mark >= 9 && mark < 9.9
                                                ? Screens.width(context) * 0.73
                                                : Screens.width(context) *
                                                    0.82, //0.82,
            child: Container(
              alignment: Alignment.topCenter,
              width: Screens.width(context) * 0.09,
              height: Screens.bodyheight(context) * 0.08,
              //   color: theme.primaryColor.withOpacity(0.3),
              child: Icon(Icons.arrow_drop_down,
                  color: mark > 7 || mark < 8 ? Colors.black : Colors.white),
            ),
          )
        ],
      ),
    );
  }
} //10 -> 0.82 9 -> 0.73 ,8->0.64,7->0.55,6->0.46,5->0.37,4->0.28,3->0.19,2->0.1,1->0.02

//  Container(
//    width: Screens.width(context),
//    // height: Screens.fullHeight(context)*0.3,
//    //Colors.white,//Colors.amber,
//    padding: EdgeInsets.symmetric(
//        vertical: Screens.fullHeight(context) * 0.02,
//        horizontal: Screens.width(context) * 0.04),
//    decoration: BoxDecoration(
//        color: Color(0xFFfcedee),//color == 0?theme.primaryColor:Colors.white,
//        borderRadius: BorderRadius.circular(8)),
//    alignment: Alignment.center,
//    child: Center(
//      child: Row(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: [
//          Container(
//            child: Icon(Icons.notification_important_outlined,
//            color:color == 0? Colors.red:Colors.black ,
//            ),
//          ),
//          Container(
//            width: Screens.width(context) * 0.4,
//            alignment: Alignment.center,
//            child: Text(
//              "New Enquiry 2",
//              style: theme.textTheme.bodyLarge
//                  ?.copyWith(color:color == 0? Colors.red:Colors.black),
//            ),
//          ),
//        ],
//      ),
//    ),
//  ),

//     Card(
//    elevation: 2,shadowColor: Colors.red,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(6)
//       ),
//    child: Container(
//      width: Screens.width(context)*0.29,
//      height: Screens.bodyheight(context)*0.12,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//                 color:
//                // data1[0].color=='fcedee'?
//                 Color(0xFFfcedee),//:
//                 // data1[0].color=='ebf4fa'?Color(0xFFebf4fa):
//                 //  data1[0].color=='ebfaef'?Color(0xFFebfaef):
//                  //Colors.red,
//               borderRadius: BorderRadius.circular(6),
//               ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5)),
//                   child: Text("20",
//                       style: theme.textTheme.headline6
//                           ?.copyWith(color:theme.primaryColor))),//
//               Container(
//                   alignment: Alignment.topCenter,
//                   child: Text(
//                     "Enquiry",
//                     style: theme.textTheme.bodyText2?.copyWith(
//                       fontSize: 12
//                       )
//                   )),
//             ],
//           ),
//         ),
//  ),
//     Card(
//    elevation: 2,shadowColor: Colors.red,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(6)
//       ),
//    child: Container(
//      width: Screens.width(context)*0.29,
//      height: Screens.bodyheight(context)*0.12,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//                 color:
//                // data1[0].color=='fcedee'?
//                 Color(0xFFfcedee),//:
//                 // data1[0].color=='ebf4fa'?Color(0xFFebf4fa):
//                 //  data1[0].color=='ebfaef'?Color(0xFFebfaef):
//                  //Colors.red,
//               borderRadius: BorderRadius.circular(6),
//               ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5)),
//                   child: Text("20",
//                       style: theme.textTheme.headline6
//                           ?.copyWith(color:theme.primaryColor))),//
//               Container(
//                   alignment: Alignment.topCenter,
//                   child: Text(
//                     "Enquiry",
//                     style: theme.textTheme.bodyText2?.copyWith(
//                       fontSize: 12
//                       )
//                   )),
//             ],
//           ),
//         ),
//  ),
