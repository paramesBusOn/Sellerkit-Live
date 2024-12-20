import 'package:flutter/material.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/ScoreCardController/scorecard_controller.dart';

class PositionWidget extends StatelessWidget {
  PositionWidget({
    Key? key,
    required this.theme,
    required this.prdFUP,
  }) : super(key: key);

  final ThemeData theme;
  final ScoreCardController prdFUP;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Container(
          padding: EdgeInsets.all(Screens.bodyheight(context) * 0.016),
          alignment: Alignment.center,
          width: Screens.width(context),
          decoration: BoxDecoration(color: theme.primaryColor),
          child: Text(
            // context
            //     .watch<ScoreCardController>()
            prdFUP.getlistViewData[0].title.toString(),
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
          )),
      SizedBox(
        height: Screens.bodyheight(context) * 0.02,
      ),
      Container(
        padding:
            EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.03),
        width: Screens.width(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Screens.width(context) * 0.4,
              child: Text(
                prdFUP.getlistViewData[0].name.toString(),
                style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.primaryColor, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: Screens.width(context) * 0.4,
              alignment: Alignment.centerRight,
              child: Text(
                prdFUP.configg
                    .subtractDateTime("${prdFUP.getlistViewData[0].date}"),
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
      // ScoreCardTwoScrren()
    ]));
  }
}
