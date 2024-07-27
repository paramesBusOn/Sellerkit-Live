import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/ReportsController/ReportsController.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartPage extends StatefulWidget {
  const BarChartPage({
    Key? key,
    required this.chartData,
    required this.title,
    required this.cartesianChartKey,
    // required this.reportCnt
  }) : super(key: key);
  final List<BarChartData> chartData;
  final String title;
  final GlobalKey<SfCartesianChartState> cartesianChartKey;
  // final ReportsController reportCnt;
  @override
  State<BarChartPage> createState() => _BarChartState();
}

class _BarChartState extends State<BarChartPage> {
  TooltipBehavior? _tooltipBehavior;
  ZoomPanBehavior? _zoomPanBehavior;
  TrackballBehavior? _trackballBehavior;
  @override
  void initState() {
    // widget.chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(
        // textStyle: TextStyle(color: Colors.white),
        enable: true,
        tooltipPosition: TooltipPosition.pointer);
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final List<ChartData> chartData = [
    //   ChartData(1, 35),
    //   ChartData(
    //     2,
    //     23,
    //   ),
    //   ChartData(3, 34),
    //   ChartData(4, 25),
    //   ChartData(5, 40)
    // ];
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
              //   Color.fromARGB(255, 82, 141, 245),
              //   Colors.teal,
              //   Color.fromARGB(255, 213, 90, 19),
              //   Color.fromARGB(255, 237, 91, 91),
              //   Colors.yellow,
              // ],
              // palette: context.watch<ReportsController>().heighContrast,
              zoomPanBehavior: _zoomPanBehavior,
              trackballBehavior: _trackballBehavior,
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(minimum: 0, maximum: 100, interval: 10),
              tooltipBehavior: _tooltipBehavior,
              //             isTransposed: true,
              key: widget.cartesianChartKey,
              title: ChartTitle(text: widget.title),
              series: <CartesianSeries>[
                // Renders bar chart
                BarSeries<BarChartData, String>(
                  isVisible: true,
                  enableTooltip: true,
                  dataLabelSettings: DataLabelSettings(
                      textStyle: TextStyle(color: theme.primaryColor),
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside),
                  dataSource: widget.chartData,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  xValueMapper: (BarChartData data, _) => data.x,
                  yValueMapper: (BarChartData data, _) => data.y,
                  pointColorMapper: (BarChartData data, _) => data.colors,
                ),
              ]),
        ),
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

class BarChartData {
  final String? x;
  final int? y;
  Color? colors;
  BarChartData({this.x, this.y, this.colors});
}
