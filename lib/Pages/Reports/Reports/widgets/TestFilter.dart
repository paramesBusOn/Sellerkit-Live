// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/ReportsController/ReportsController.dart';

class FilterDrawer2 extends StatefulWidget {
  const FilterDrawer2({Key? key}) : super(key: key);

  @override
  State<FilterDrawer2> createState() => _FilterDrawer2State();
}

class _FilterDrawer2State extends State<FilterDrawer2> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
        child: Container(
      padding: EdgeInsets.only(bottom: Screens.padingHeight(context) * 0.01),
      child: Column(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: Screens.padingHeight(context) * 0.09,
            width: Screens.width(context),
            padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(Screens.padingHeight(context) * 0.03),
                  bottomRight:
                      Radius.circular(Screens.padingHeight(context) * 0.03),
                )),
            child: Text(
              "Lead Analysis",
              style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
            ),
          ),
          // SizedBox(
          //   height: Screens.padingHeight(context) * 0.01,
          // ),
          Expanded(
            child: ListView.builder(
                itemCount:
                    context.watch<ReportsController>().rTestListItem2.length,
                itemBuilder: ((context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: Screens.width(context) * 0.015,
                        top: Screens.padingHeight(context) * 0.01),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Screens.padingHeight(context) * 0.025,
                          child: TextField(
                            onTap: () {
                              setState(() {
                                context
                                    .read<ReportsController>()
                                    .onChangedDropDown(index);
                              });
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: context
                                    .watch<ReportsController>()
                                    .rTestListItem2[index]
                                    .titleName
                                    .toString(),
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 15),
                                // contentPadding: EdgeInsets.all(8.0),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                suffixIcon: context
                                            .watch<ReportsController>()
                                            .rTestListItem2[index]
                                            .rangeType ==
                                        'Text'
                                    ? Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      )
                                    : null),
                          ),
                        ),
                        context
                                    .watch<ReportsController>()
                                    .rTestListItem2[index]
                                    .onTabList ==
                                true
                            ? Container(
                                child: context
                                            .watch<ReportsController>()
                                            .rTestListItem2[index]
                                            .rangeType ==
                                        'Text'
                                    ? SizedBox(
                                        height: context
                                                    .watch<ReportsController>()
                                                    .rTestListItem2[index]
                                                    .itemNamer
                                                    .length >
                                                3
                                            ? Screens.padingHeight(context) *
                                                0.2
                                            : null,
                                        child: SingleChildScrollView(
                                          child: ListBody(
                                              children: context
                                                  .read<ReportsController>()
                                                  .rTestListItem2[index]
                                                  .itemNamer
                                                  .map((item) =>
                                                          CheckboxListTile(
                                                              activeColor: theme
                                                                  .primaryColor,
                                                              checkColor:
                                                                  Colors.white,
                                                              value: item
                                                                  .isCheckbox,
                                                              title: Text(item
                                                                  .textlist),
                                                              controlAffinity:
                                                                  ListTileControlAffinity
                                                                      .leading,
                                                              onChanged:
                                                                  (ischeckedbox) {
                                                                context
                                                                        .read<
                                                                            ReportsController>()
                                                                        .isValSelect =
                                                                    ischeckedbox!;
                                                                item.isCheckbox =
                                                                    ischeckedbox;
                                                                context
                                                                    .read<
                                                                        ReportsController>()
                                                                    .selectcheckval(
                                                                      item.title!,
                                                                      item.textlist,
                                                                      ischeckedbox,
                                                                    );
                                                              })
                                                      // : Container(),
                                                      )
                                                  .toList()),
                                        ),
                                      )
                                    : context
                                                .watch<ReportsController>()
                                                .rTestListItem2[index]
                                                .rangeType ==
                                            'Integer'
                                        ? SliderTheme(
                                            data: SliderTheme.of(context)
                                                .copyWith(
                                              valueIndicatorColor: Colors.white,
                                              showValueIndicator:
                                                  ShowValueIndicator.always,
                                              valueIndicatorTextStyle: TextStyle(
                                                  color: theme
                                                      .primaryColor // Change text color here
                                                  ),
                                              trackHeight:
                                                  2, // Adjust thickness here
                                            ),
                                            child: RangeSlider(
                                              activeColor: theme.primaryColor,
                                              values: context
                                                  .read<ReportsController>()
                                                  .currentRangeValues!,
                                              min: context
                                                  .read<ReportsController>()
                                                  .minValuesAmount,
                                              max: context
                                                  .read<ReportsController>()
                                                  .maxValuesAmount,
                                              divisions: 50,
                                              labels: RangeLabels(
                                                context
                                                    .read<ReportsController>()
                                                    .currentRangeValues!
                                                    .start
                                                    .round()
                                                    .toString(),
                                                context
                                                    .read<ReportsController>()
                                                    .currentRangeValues!
                                                    .end
                                                    .round()
                                                    .toString(),
                                              ),
                                              onChanged: (RangeValues values) {
                                                setState(() {
                                                  context
                                                      .read<ReportsController>()
                                                      .currentRangeValues = values;
                                                  context
                                                          .read<ReportsController>()
                                                          .minSelectedAmount =
                                                      values.start;
                                                  context
                                                          .read<ReportsController>()
                                                          .maxSelectedAmount =
                                                      values.end;
                                                });
                                              },
                                            ),
                                          )
                                        : context
                                                    .watch<ReportsController>()
                                                    .rTestListItem2[index]
                                                    .rangeType ==
                                                'DateTime'
                                            ? Container(
                                                padding: EdgeInsets.only(),
                                                height: Screens.padingHeight(
                                                        context) *
                                                    0.04,
                                                decoration: BoxDecoration(
                                                    // color: Colors.green,
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.grey))),
                                                child: TextField(
                                                  readOnly: true,
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            ReportsController>()
                                                        .datePicker(context,
                                                            'Lead Date', index);
                                                  },
                                                  controller: context
                                                      .read<ReportsController>()
                                                      .myDatecontroller[index],
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    hintStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                    suffixIcon: IconButton(
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                                ReportsController>()
                                                            .datePicker(
                                                                context,
                                                                'Lead Date',
                                                                index);
                                                      },
                                                      icon: Icon(
                                                        Icons.calendar_month,
                                                        color:
                                                            theme.primaryColor,
                                                      ),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 5),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                              )
                            : Container(),
                        SizedBox(
                          height: Screens.padingHeight(context) * 0.01,
                        ),
                      ],
                    ),
                  );
                })),
          ),
          SizedBox(
            height: Screens.padingHeight(context) * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: Screens.width(context) * 0.3,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<ReportsController>().clearfilterval();
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                      child: Text(
                        "Cancel",
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: Colors.white),
                      ))),
              SizedBox(
                  width: Screens.width(context) * 0.3,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);

                          context.read<ReportsController>().onfilterapply();
                        });
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                      child: Text(
                        "Apply",
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: Colors.white),
                      )))
            ],
          )
        ],
      ),
    ));
  }
}
