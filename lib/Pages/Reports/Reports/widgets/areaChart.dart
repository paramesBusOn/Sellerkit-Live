import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AreaCahrt extends StatefulWidget {
  const AreaCahrt({Key? key});

  @override
  State<AreaCahrt> createState() => _AreaCahrtState();
}

class _AreaCahrtState extends State<AreaCahrt> {
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(2010, 35),
      ChartData(2011, 28),
      ChartData(2012, 34),
      ChartData(2013, 32),
      ChartData(2014, 40)
    ];
    return Center(
        child: SfCartesianChart(
            tooltipBehavior: _tooltipBehavior,
            backgroundColor: Colors.white,

            // backgroundColor: Colors.,
            title:  ChartTitle(text: 'Area Cahrt'),
            series: <CartesianSeries>[
          // Renders area chart
          AreaSeries<ChartData, int>(
              enableTooltip: true,
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y)
        ]));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}
