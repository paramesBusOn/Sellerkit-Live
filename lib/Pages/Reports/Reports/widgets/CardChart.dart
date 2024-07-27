import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/ReportsController/ReportsController.dart';
import 'package:sellerkit/Pages/Reports/Reports/widgets/lineCahrt.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../Constant/Configuration.dart';

class CardChartPage extends StatelessWidget {
  CardChartPage(
      {Key? key,
      required this.theme,
      required this.name,
      required this.value,
      required this.color,
      this.newe,
      required this.cartesianChartKey,
      required this.reportCnt
      //this.count
      })
      : super(key: key);

  final ThemeData theme;
  final String value;
  final String name;
  Color color;
  bool? newe = false;
  ReportsController reportCnt;
  GlobalKey<SfCartesianChartState>? cartesianChartKey;
  // int? count = 0;
  Config config = Config();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Container(
        width: Screens.width(context) * 0.46,
        height: Screens.bodyheight(context) * 0.073,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    alignment: Alignment.topCenter,
                    child: Text(name,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.white))),
                Container(
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Text(
                        name.contains('Value')
                            ? Config.k_m_b_generator22(value.toString())
                            : value.replaceAll('.0', ''),
                        style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500))), //
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardChart {
  String? name;
  double? value;
  Color? colors;

  CardChart({
    required this.name,
    required this.value,
    this.colors,
  });
}
