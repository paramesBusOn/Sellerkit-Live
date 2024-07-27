import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/ReportsController/ReportsController.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../Constant/Configuration.dart';

class LineChartDataPage extends StatefulWidget {
  LineChartDataPage({
    Key? key,
    required this.title,
    required this.chartData,
    required this.cartesianChartKey,
    // required this.reportCnt
  }) : super(key: key);
  final String title;
  final List<LineChartData> chartData;
  final GlobalKey<SfCartesianChartState> cartesianChartKey;
  // ReportsController reportCnt;

  @override
  State<LineChartDataPage> createState() => _LineChartState();
}

class _LineChartState extends State<LineChartDataPage> {
  TooltipBehavior? _tooltipBehavior;
  ZoomPanBehavior? _zoomPanBehavior;
  TrackballBehavior? _trackballBehavior;
  Config config = Config();

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
        enable: true,
        tooltipSettings:
            const InteractiveTooltip(enable: true, color: Colors.red));
    // widget.chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true, shared: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                // palette: <Color>[
                //   Color.fromARGB(255, 239, 85, 136),
                //   Colors.blue,
                //   Color.fromARGB(255, 234, 137, 81),
                //   Colors.teal,
                //   Color.fromARGB(255, 82, 141, 245),
                //   Color.fromARGB(255, 237, 91, 91),
                //   Colors.yellow,
                // ],
                // palette: context.read<ReportsController>().pieChartsClr,
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(),
                trackballBehavior: _trackballBehavior,
                tooltipBehavior: _tooltipBehavior,
                zoomPanBehavior: _zoomPanBehavior,
                title: ChartTitle(text: widget.title),
                key: widget.cartesianChartKey,
                series: <CartesianSeries>[
                  LineSeries<LineChartData, String>(
                      dataLabelSettings: const DataLabelSettings(
                        useSeriesColor: true,
                        isVisible: true,
                      ),
                      markerSettings: MarkerSettings(
                          color: theme.primaryColor, isVisible: true),
                      isVisible: true,
                      enableTooltip: true,
                      dataSource: widget.chartData,
                      // Dash values for line
                      dashArray: <double>[3, 3],
                      dataLabelMapper: (LineChartData data, _) =>
                          Config.k_m_b_generator22(data.y.toString()),
                      pointColorMapper: (LineChartData data, _) => data.colors,
                      xValueMapper: (LineChartData data, _) => data.x,
                      yValueMapper: (LineChartData data, _) => data.y),
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

class LineChartData {
  LineChartData({this.x, this.y, this.colors});
  String? x;
  double? y;
  Color? colors;
}
