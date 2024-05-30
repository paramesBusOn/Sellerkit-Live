// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, must_be_immutable, unused_element, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/DashBoardController/DashBoardController.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../Models/GridContainerModels/GridContainerModel.dart';
import '../widgets/GridContainers.dart';

class AnalyticsPage extends StatelessWidget {
  final  Map<String, double>? dataMap;
  Paddings paddings = new Paddings();
  final  List<GridConValue> data21;

  AnalyticsPage({Key? key,required this.dataMap,required this.data21}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Container(
        width: Screens.width(context),
        height: Screens.bodyheight(context),
        // color: Colors.yellow,
        padding: paddings.padding3(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Container(
                    padding: EdgeInsets.all(8),
                    width: Screens.width(context),
                           child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                // SizedBox(
              
                // ),
                SizedBox(
                  width: Screens.width(context)*0.2,
                  child: ElevatedButton(onPressed: (){}, child: Text("TODAY"))),
                SizedBox(
                   width: Screens.width(context)*0.2,
                  child: ElevatedButton(onPressed: (){}, child: Text("MTD"))),
                SizedBox(
                   width: Screens.width(context)*0.2,
                  child: ElevatedButton(onPressed: (){}, child: Text("OTD"))),
                SizedBox(
                   width: Screens.width(context)*0.2,
                  child: ElevatedButton(onPressed: (){}, child: Text("YTD")))
              
              
                           ],),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: Screens.width(context),
                  child: Column(
                    children: [
                      Container(
                        width: Screens.width(context),
                        child: Text(
                          "Target Achievement",
                          style: theme.textTheme.bodyText1,
                        ),
                      ),
                      Container(
                          width: Screens.width(context),
                          height: Screens.bodyheight(context) * 0.3,
                          // color: Colors.blue,
                          child: charts.BarChart(
                           context.read<DashBoardController>().createSampleData(),// _createSampleData(),
                            animate: true,
                            barGroupingType: charts.BarGroupingType.grouped,
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.01,
              ),
              Card(
                child: Container(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context) * 0.3,
                  child: PieChart(
                    dataMap: dataMap!,
                    chartValuesOptions:
                        ChartValuesOptions(showChartValueBackground: false),
                  ),
                ),
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.01,
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: Screens.width(context),
                  child: Column(
                    children: [
                      Container(
                        width: Screens.width(context),
                        child: Text(
                          "Self growth sales",
                          style: theme.textTheme.bodyText1,
                        ),
                      ),
                      Container(
                          width: Screens.width(context),
                          height: Screens.bodyheight(context) * 0.3,
                          child: new charts.TimeSeriesChart(
                          context.read<DashBoardController>(). createSampleData2(),//  _createSampleData2(),
                            animate: false,
                            selectionModels: [
                              // new charts.SelectionModelConfig(
                              //   type: charts.SelectionModelType.info,
                              //   listener: _onSelectionChanged,
                              // )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.01,
              ),
              GridContaiers(
                data: data21,
                theme: theme,
                height: data21.length <= 3
                    ? Screens.bodyheight(context) * 0.15
                    : Screens.bodyheight(context) * 0.25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}




  // ////
  // static List<charts.Series<LinearSales, int>> _createSampleData2() {
  //   final data = [
  //     new LinearSales(0, 40),
  //     new LinearSales(1, 40),
  //     new LinearSales(2, 30),
  //     new LinearSales(3, 50),
  //   ];

  //   return [
  //     new charts.Series<LinearSales, int>(
  //       id: 'Sales', displayName: "bla",
  //       //insideLabelStyleAccessorFn:  (LinearSales sales, _) => sales.sales,
  //       //colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
  //       domainFn: (LinearSales sales, _) => sales.year,
  //       measureFn: (LinearSales sales, _) => sales.sales,
  //       data: data,
  //       labelAccessorFn: (LinearSales row, _) => '${row.year}: ${row.sales}',
  //     )
  //   ];
  // }
