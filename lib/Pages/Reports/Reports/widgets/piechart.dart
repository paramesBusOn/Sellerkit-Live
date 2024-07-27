import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/ReportsController/ReportsController.dart';

import 'package:flutter/material.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../Constant/Configuration.dart';

class PieChartPage extends StatefulWidget {
  PieChartPage({
    Key? key,
    required this.title,
    // required this.chartData,
    required this.circularChartKey,
    // required this.reportCnt
  }) : super(key: key);
  final String title;
  // List<PieChartData> chartData;
  final GlobalKey<SfCircularChartState> circularChartKey;
  // ReportsController reportCnt;

  @override
  State<PieChartPage> createState() => PieChartPageState();
}

class PieChartPageState extends State<PieChartPage> {
  TooltipBehavior? _tooltipBehavior;
  Config config = Config();
  @override
  void initState() {
    // _tooltipBehavior = TooltipBehavior(enable: true);
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
          child: SfCircularChart(
            palette: context.watch<ReportsController>().electricShuffle,
            key: widget.circularChartKey,
            title: ChartTitle(text: widget.title),
            legend: Legend(
                isVisible: true, overflowMode: LegendItemOverflowMode.scroll),
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              PieSeries<PieChartData, String>(
                radius: '100',
                dataSource: context
                    .watch<ReportsController>()
                    .pieChartData, //date, userpartner
                animationDuration: 2000,
                xValueMapper: (PieChartData data, _) => data.valueName,
                yValueMapper: (PieChartData data, _) =>
                    double.parse((data.value.toStringAsFixed(2))),
                dataLabelMapper: (PieChartData data, _) =>
                    '${Config.k_m_b_generator22(data.value.toString())}\n${data.percentage.toStringAsFixed(4)}%',
                // selectionBehavior: SelectionBehavior(
                //   enable: true,
                //   toggleSelection: false,
                // ),
                dataLabelSettings: const DataLabelSettings(
                    labelIntersectAction: LabelIntersectAction.shift,
                    connectorLineSettings: ConnectorLineSettings(
                        length: '18%',
                        width: 2,
                        type: ConnectorType.line,
                        color: Colors.black),
                    isVisible: true,
                    useSeriesColor: true,
                    labelPosition: ChartDataLabelPosition.inside),
                enableTooltip: true,
              )
            ],
          ),
        ),
        Positioned(
            top: 0,
            right: 0,
            child: IconButton(
                color: theme.primaryColor,
                onPressed: () {
                  context
                      .read<ReportsController>()
                      .renderPDF(widget.circularChartKey);
                },
                icon: const Icon(Icons.picture_as_pdf)))
      ],
    );
  }

  // List<PieChartData> getChartData() {

  //   return chartData;
  // }
}

class PieChartData {
  PieChartData(this.valueName, this.value, this.percentage, this.valueCount);
  final String valueName;
  double valueCount;
  final double value;
  double percentage;
}
