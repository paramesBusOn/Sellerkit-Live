import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/ReportsController/ReportsController.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../../../../Constant/Configuration.dart';

class ColumnChartPage extends StatefulWidget {
  ColumnChartPage(
      {Key? key,
      required this.title,
      // required this.reportCnt,
      required this.chartData,
      required this.cartesianChartKey})
      : super(key: key);
  final String title;
  // ReportsController reportCnt;
  GlobalKey<SfCartesianChartState> cartesianChartKey;

  List<ColumnChartData> chartData;
  @override
  State<ColumnChartPage> createState() => _ColumnChartState();
}

class _ColumnChartState extends State<ColumnChartPage> {
  TooltipBehavior? _tooltipBehavior;
  ZoomPanBehavior? _zoomPanBehavior;
  TrackballBehavior? _trackballBehavior;
  Config configg = Config();
  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
        enablePinching: true,
        zoomMode: ZoomMode.x,
        enablePanning: true,
        selectionRectBorderColor: Colors.red,
        selectionRectBorderWidth: 1,
        selectionRectColor: Colors.grey);
    _trackballBehavior = TrackballBehavior(
        // Enables the trackball
        enable: true,
        tooltipSettings:
            const InteractiveTooltip(enable: true, color: Colors.red));
    // widget.chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true, shared: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final List<ColumnChartData> chartData = [
    //   ColumnChartData(2010, 35, 23),
    //   ColumnChartData(2011, 38, 49),
    //   ColumnChartData(2012, 34, 12),
    //   ColumnChartData(2013, 52, 33),
    //   ColumnChartData(2014, 40, 30)
    // ];
    final theme = Theme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            height: Screens.bodyheight(context) * 0.4,
            width: Screens.width(context) * 0.95,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(Screens.bodyheight(context) * 0.01),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[400]!,
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                      offset: const Offset(2, 0))
                ]),
            child: SfCartesianChart(
                trackballBehavior: _trackballBehavior,
                zoomPanBehavior: _zoomPanBehavior,
                tooltipBehavior: _tooltipBehavior,
                key: widget.cartesianChartKey,
                // palette: context.read<ReportsController>().chartsclr,
                title: ChartTitle(text: widget.title),
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                    numberFormat: NumberFormat.currency(
                  name: "INR", locale: 'en_IN',
                  decimalDigits: 2, // change it to get decimal places
                  symbol: '',
                )),
                enableSideBySideSeriesPlacement: false,
                series: <CartesianSeries<ColumnChartData, String>>[
                  ColumnSeries<ColumnChartData, String>(
                      isVisible: true,
                      enableTooltip: true,
                      width: 0.8,
                      color: const Color.fromARGB(255, 5, 181, 164),
                      // color: Color(0xFFFF985E),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      dataSource: widget.chartData,
                      xValueMapper: (ColumnChartData data, _) =>
                          data.name.toString(),
                      yValueMapper: (ColumnChartData data, _) => data.x,
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          textStyle: TextStyle(color: Colors.black))),
                  ColumnSeries<ColumnChartData, String>(
                      isVisible: true,
                      enableTooltip: true,
                      color: theme.primaryColor,
                      // color: Color(0xFF5C2D91),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      opacity: 0.9,
                      width: 0.4,
                      dataSource: widget.chartData,
                      xValueMapper: (ColumnChartData data, _) =>
                          data.name.toString(),
                      yValueMapper: (ColumnChartData data, _) => data.y,
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          textStyle: TextStyle(color: Colors.black)))
                ]
                // series: <CartesianSeries<ColumnChartData, String>>[
                //   ColumnSeries<ColumnChartData, String>(
                //       isVisible: true,
                //       enableTooltip: true,
                //       color: theme.primaryColor,
                //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                //       opacity: 0.9,
                //       width: 1,
                //       dataSource: widget.chartData,
                //       xValueMapper: (ColumnChartData data, _) => data.name,
                //       yValueMapper: (ColumnChartData data, _) => data.y,
                //       dataLabelSettings: DataLabelSettings(isVisible: true)),
                // ]

                )),
        Positioned(
            top: 0,
            right: 0,
            child: IconButton(
                color: theme.primaryColor,
                onPressed: () {
                  context
                      .read<ReportsController>()
                      .renderPDF(widget.cartesianChartKey);
                },
                icon: const Icon(Icons.picture_as_pdf)))
      ],
    );
  }
}

class ColumnChartData {
  ColumnChartData(this.x, this.y, this.name);
  final double x;
  final double y;
  final String name;
}
