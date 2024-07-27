import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HiloChart extends StatefulWidget {
  const HiloChart({Key? key});

  @override
  State<HiloChart> createState() => _HiloChartState();
}

class _HiloChartState extends State<HiloChart> {
  List<ChartSampleData>? _chartData;
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: Colors.white,
      legend: Legend(isVisible: true),
      tooltipBehavior: _tooltipBehavior,
      title: ChartTitle(text: 'Hilo Chart'),
      series: <RangeColumnSeries>[
        RangeColumnSeries<ChartSampleData, DateTime>(
            dataSource: _chartData!,
            name: 'Temperature',
            xValueMapper: (ChartSampleData data, _) => data.x,
            highValueMapper: (ChartSampleData data, _) => data.high,
            lowValueMapper: (ChartSampleData data, _) => data.low,
            dataLabelSettings: const DataLabelSettings(isVisible: true))
      ],
      primaryXAxis: DateTimeAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          // dateFormat: Data,
          intervalType: DateTimeIntervalType.months,
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(labelFormat: '{value}°C'),
    );
  }

  List<ChartSampleData> getChartData() {
    return <ChartSampleData>[
      ChartSampleData(DateTime(2021, 1, 1), 3, 9),
      ChartSampleData(DateTime(2021, 2, 1), 4, 11),
      ChartSampleData(DateTime(2021, 3, 1), 6, 13),
      ChartSampleData(DateTime(2021, 4, 1), 9, 17),
      ChartSampleData(DateTime(2021, 5, 1), 12, 20)
    ];
  }
}

class ChartSampleData {
  ChartSampleData(this.x, this.high, this.low);
  final DateTime x;
  final double high;
  final double low;
}
