import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/ReportsController/ReportsController.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SplineChartPage extends StatefulWidget {
  const SplineChartPage({
    Key? key,
    required this.chartData,
    required this.title,
    required this.cartesianChartKey,
    // required this.reportCnt
  }) : super(key: key);
  final List<SplineChartData> chartData;
  final String title;
  final GlobalKey<SfCartesianChartState> cartesianChartKey;
  // final ReportsController reportCnt;
  @override
  State<SplineChartPage> createState() => splineChartState();
}

class splineChartState extends State<SplineChartPage> {
  TooltipBehavior? _tooltipBehavior;
  ZoomPanBehavior? _zoomPanBehavior;
  TrackballBehavior? _trackballBehavior;

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
    // final List<SplineChartData> chartData = [
    //   SplineChartData(2010, 35),
    //   SplineChartData(2011, 13),
    //   SplineChartData(2012, 34),
    //   SplineChartData(2013, 27),
    //   SplineChartData(2014, 40)
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
                // isTransposed: true,
                // primaryXAxis: CategoryAxis(),
                // palette: const <Color>[
                //   Color.fromRGBO(75, 135, 185, 1),
                //   Color.fromRGBO(192, 108, 132, 1),
                //   Color.fromRGBO(246, 114, 128, 1),
                //   Color.fromRGBO(248, 177, 149, 1),
                //   Color.fromRGBO(116, 180, 155, 1),
                //   Color.fromRGBO(0, 168, 181, 1),
                //   Color.fromRGBO(73, 76, 162, 1),
                //   Color.fromRGBO(255, 205, 96, 1),
                //   Color.fromRGBO(255, 240, 219, 1),
                //   Color.fromRGBO(238, 238, 238, 1)
                // ],
                tooltipBehavior: _tooltipBehavior,
                zoomPanBehavior: _zoomPanBehavior,
                trackballBehavior: _trackballBehavior,
                key: widget.cartesianChartKey,
                primaryXAxis: CategoryAxis(
                    // title: AxisTitle(text: 'Items'),
                    ),
                primaryYAxis: NumericAxis(),
                title: ChartTitle(text: widget.title),
                series: <CartesianSeries>[
                  // Renders spline chart
                  SplineSeries<SplineChartData, String>(
                      isVisible: true,
                      markerSettings: MarkerSettings(
                          color: theme.primaryColor, isVisible: true),
                      enableTooltip: true,
                      dataSource: widget.chartData,
                      xValueMapper: (SplineChartData data, _) =>
                          data.x.toString(),
                      yValueMapper: (SplineChartData data, _) => data.y)
                ])),
        Positioned(
            top: 0,
            right: 0,
            child: IconButton(
                color: theme.primaryColor,
                onPressed: () {
                  // myMethod<GlobalKey<ScaffoldState>>(_scaffoldKey);

                  context.read<ReportsController>().renderPDF(
                      context.read<ReportsController>().cartesianChartKey);
                },
                icon: const Icon(Icons.picture_as_pdf)))
      ],
    );
  }
}

class SplineChartData {
  SplineChartData(this.x, this.y);
  final String x;
  final int? y;
}
