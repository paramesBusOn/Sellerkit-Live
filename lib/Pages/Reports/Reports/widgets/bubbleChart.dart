import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/ReportsController/ReportsController.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BubbleChartPage extends StatefulWidget {
  const BubbleChartPage({
    Key? key,
    required this.chartData,
    required this.title,
    required this.cartesianChartKey,
    // required this.reportCnt
  }) : super(key: key);
  final List<BubbleChartData> chartData;
  final String title;
  final GlobalKey<SfCartesianChartState> cartesianChartKey;
  // final ReportsController reportCnt;
  @override
  State<BubbleChartPage> createState() => _BubbleChartState();
}

class _BubbleChartState extends State<BubbleChartPage> {
  // TooltipBehavior? _tooltipBehavior;
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
    // _tooltipBehavior = TooltipBehavior(enable: true, shared: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final LinearGradient gradientColors = LinearGradient(
    //   colors: context.read<ReportsController>().bubbleChartsClr,
    // );

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
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.grey[400]!,
              //       blurRadius: 2.0,
              //       spreadRadius: 2.0,
              //       offset: const Offset(2, 0))
              // ]
            ),
            child: SfCartesianChart(
                // tooltipBehavior: _tooltipBehavior,
                tooltipBehavior: TooltipBehavior(
                    enable: true,
                    shared: true,
                    builder: (dynamic chartData, dynamic point, dynamic series,
                        int pointIndex, int seriesIndex) {
                      return Container(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Count: ${chartData.x}\nValue: ${chartData.y.toStringAsFixed(4)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
                trackballBehavior: _trackballBehavior,
                zoomPanBehavior: _zoomPanBehavior,
                key: widget.cartesianChartKey,
                title: ChartTitle(text: widget.title),
                // palette: context.watch<ReportsController>().bubbleChartsClr,
                primaryXAxis: CategoryAxis(),
                series: <CartesianSeries>[
                  BubbleSeries<BubbleChartData, String>(
                    enableTooltip: true,
                    isVisible: true,
                    dataSource: widget.chartData,
                    pointColorMapper: (BubbleChartData data, _) => data.color,
                    // context
                    //     .watch<ReportsController>()
                    //     .getBubbleColor(data.name!),
                    xValueMapper: (BubbleChartData data, _) => data.name,
                    yValueMapper: (BubbleChartData data, _) => data.x,
                    sizeValueMapper: (BubbleChartData data, _) => data.y,
                    dataLabelMapper: (BubbleChartData data, _) =>
                        data.y.toString(),
                  )
                ])),
        // SfCartesianChart(
        // legend: Legend(isVisible: true),
        // tooltipBehavior: _tooltipBehavior,
        // trackballBehavior: _trackballBehavior,
        // zoomPanBehavior: _zoomPanBehavior,
        // key: widget.cartesianChartKey,
        // title: ChartTitle(text: widget.title),
        //     primaryXAxis: NumericAxis(
        //         // title: AxisTitle(text: 'X Axis'),
        //         ),
        //     primaryYAxis: NumericAxis(
        //         // title: AxisTitle(text: 'Y Axis'),
        //         ),

        //     // primaryXAxis: DateTimeAxis(),
        //     series: <CartesianSeries>[
        //       BubbleSeries<BubbleChartData, num>(
        //         name: '',
        // enableTooltip: true,
        // isVisible: true,
        //         dataSource: widget.chartData,
        // pointColorMapper: (BubbleChartData data, _) => context
        //     .watch<ReportsController>()
        //     .getBubbleColor(data.name),

        //         xValueMapper: (BubbleChartData data, _) => data.x,
        //         yValueMapper: (BubbleChartData data, _) => data.y,
        //         sizeValueMapper: (BubbleChartData data, _) => data.size,
        //         // dataLabelMapper: (BubbleChartData data, _) => data.name,
        //       ),
        //     ])),

        Positioned(
            top: 0,
            right: 0,
            child: IconButton(
                color: theme.primaryColor,
                onPressed: () {
                  context.read<ReportsController>().renderPDF(
                      context.read<ReportsController>().cartesianChartKey);
                },
                icon: const Icon(Icons.picture_as_pdf)))
      ],
    );
  }
}

class BubbleChartData {
  BubbleChartData({this.name, this.x, this.y, this.size, this.color});
  double? x;
  String? name;

  double? y;
  double? size;
  Color? color;
}
