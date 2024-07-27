import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/ReportsController/ReportsController.dart';

class FilterDrawer extends StatefulWidget {
  FilterDrawer({
    Key? key,
    // required this.reportCnt2
  }) : super(key: key);
  // ReportsController reportCnt2;
  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: ListView(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: Screens.padingHeight(context) * 0.1,
                    width: Screens.width(context),
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              Screens.padingHeight(context) * 0.05),
                          bottomRight: Radius.circular(
                              Screens.padingHeight(context) * 0.05),
                        )),
                    child: Text(
                      "Lead Analysis",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: Screens.width(context),
                    height: Screens.bodyheight(context) * 0.85,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: Screens.width(context),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Screens.width(context) * 0.02,
                                  right: Screens.width(context) * 0.02,
                                  top: Screens.padingHeight(context) * 0.01),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey))),
                                    child: Column(
                                      children: [
                                        TextField(
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<ReportsController>()
                                                  .ontapassignto();
                                            });
                                          },
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                              hintText: "Assigned to",
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                              contentPadding:
                                                  EdgeInsets.all(8.0),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              suffixIcon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black,
                                              )),
                                        ),
                                        context
                                                        .read<
                                                            ReportsController>()
                                                        .isassignto ==
                                                    true &&
                                                context
                                                    .read<ReportsController>()
                                                    .assigncolumn
                                                    .isNotEmpty
                                            ? SizedBox(
                                                height: Screens.padingHeight(
                                                        context) *
                                                    0.2,
                                                child: SingleChildScrollView(
                                                  child: ListBody(
                                                      children: context
                                                          .read<
                                                              ReportsController>()
                                                          .assigncolumn
                                                          .map((item) => CheckboxListTile(
                                                              value: context
                                                                  .read<
                                                                      ReportsController>()
                                                                  .selectedassignto
                                                                  .contains(item
                                                                      .name),
                                                              title: Text(
                                                                  item.name),
                                                              controlAffinity:
                                                                  ListTileControlAffinity
                                                                      .leading,
                                                              onChanged:
                                                                  (ischeckedbox) {}
                                                              // onChanged: (ischecked) => context
                                                              //     .read<
                                                              //         ReportsController>()
                                                              //     .itemselectassignto(
                                                              //         item.name,
                                                              //         ischecked!),
                                                              ))
                                                          .toList()),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Screens.width(context),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Screens.width(context) * 0.02,
                                  right: Screens.width(context) * 0.02,
                                  top: Screens.padingHeight(context) * 0.01),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey))),
                                    child: Column(
                                      children: [
                                        TextField(
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<ReportsController>()
                                                  .ontapcusgroup();
                                            });
                                          },
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                              hintText: "Customer Group",
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                              contentPadding:
                                                  EdgeInsets.all(8.0),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              suffixIcon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black,
                                              )),
                                        ),
                                        context
                                                        .watch<
                                                            ReportsController>()
                                                        .iscusgroup ==
                                                    true &&
                                                context
                                                    .watch<ReportsController>()
                                                    .cusgroupcolumn
                                                    .isNotEmpty
                                            ? SizedBox(
                                                height: Screens.padingHeight(
                                                        context) *
                                                    0.2,
                                                child: SingleChildScrollView(
                                                  child: ListBody(
                                                      children: context
                                                          .watch<
                                                              ReportsController>()
                                                          .cusgroupcolumn
                                                          .map((item) =>
                                                              CheckboxListTile(
                                                                value: context
                                                                    .watch<
                                                                        ReportsController>()
                                                                    .selectedcusgoup
                                                                    .contains(item
                                                                        .name),
                                                                title: Text(
                                                                    item.name),
                                                                controlAffinity:
                                                                    ListTileControlAffinity
                                                                        .leading,
                                                                onChanged: (ischecked) => context
                                                                    .read<
                                                                        ReportsController>()
                                                                    .itemselectCusgroup(
                                                                        item.name,
                                                                        ischecked!),
                                                              ))
                                                          .toList()),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   width: Screens.width(context),
                          //   child: Padding(
                          //     padding: EdgeInsets.only(
                          //         left: Screens.width(context) * 0.02,
                          //         right: Screens.width(context) * 0.02,
                          //         top: Screens.padingHeight(context) * 0.01),
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Container(
                          //           width: Screens.width(context),
                          //           decoration: BoxDecoration(
                          //               border: Border(
                          //                   bottom: BorderSide(
                          //                       color: Colors.grey))),
                          //           child: TextField(
                          //             readOnly: true,
                          //             onTap: () {
                          //               context
                          //                   .read<ReportsController>()
                          //                   .showfromDate(context);
                          //             },
                          //             controller: context
                          //                 .read<ReportsController>()
                          //                 .mycontroller[16],
                          //             decoration: InputDecoration(
                          //               hintText: "From Date",
                          //               hintStyle: TextStyle(
                          //                   color: Colors.black, fontSize: 15),
                          //               enabledBorder: InputBorder.none,
                          //               focusedBorder: InputBorder.none,
                          //               suffixIcon: IconButton(
                          //                 onPressed: () {
                          //                   context
                          //                       .read<ReportsController>()
                          //                       .showfromDate(context);
                          //                 },
                          //                 icon: Icon(
                          //                   Icons.calendar_month,
                          //                   color: theme.primaryColor,
                          //                 ),
                          //               ),
                          // contentPadding:
                          //     const EdgeInsets.symmetric(
                          //   vertical: 10,
                          //   horizontal: 5,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            width: Screens.width(context),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Screens.width(context) * 0.02,
                                  right: Screens.width(context) * 0.02,
                                  top: Screens.padingHeight(context) * 0.01),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Screens.width(context),
                                    height:
                                        Screens.padingHeight(context) * 0.06,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey))),
                                    child: TextField(
                                      readOnly: true,
                                      onTap: () {
                                        context
                                            .read<ReportsController>()
                                            .datePicker(
                                                context, 'Lead Date', 0);
                                        // context
                                        //     .read<ReportsController>()
                                        //     .showToDate(context);
                                      },
                                      controller: context
                                          .read<ReportsController>()
                                          .mycontroller[17],
                                      decoration: InputDecoration(
                                        hintText: "Lead Date",
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintStyle: const TextStyle(
                                            color: Colors.black, fontSize: 15),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            // context
                                            //     .read<ReportsController>()
                                            //     .showToDate(context);
                                            context
                                                .read<ReportsController>()
                                                .datePicker(
                                                    context, 'Lead Date', 0);
                                          },
                                          icon: Icon(
                                            Icons.calendar_month,
                                            color: theme.primaryColor,
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Screens.width(context),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Screens.width(context) * 0.02,
                                  right: Screens.width(context) * 0.02,
                                  top: Screens.padingHeight(context) * 0.01),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey))),
                                    child: Column(
                                      children: [
                                        TextField(
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<ReportsController>()
                                                  .onenqstatus();
                                            });
                                          },
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                              hintText: "Status",
                                              contentPadding:
                                                  EdgeInsets.all(8.0),
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              suffixIcon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black,
                                              )),
                                        ),
                                        context
                                                        .watch<
                                                            ReportsController>()
                                                        .isenqstatus ==
                                                    true &&
                                                context
                                                    .watch<ReportsController>()
                                                    .enqstatuscolumn
                                                    .isNotEmpty
                                            ? SizedBox(
                                                height: Screens.padingHeight(
                                                        context) *
                                                    0.2,
                                                child: SingleChildScrollView(
                                                  child: ListBody(
                                                      children: context
                                                          .watch<
                                                              ReportsController>()
                                                          .enqstatuscolumn
                                                          .map((item) =>
                                                              CheckboxListTile(
                                                                value: context
                                                                    .watch<
                                                                        ReportsController>()
                                                                    .selectedenqstatus
                                                                    .contains(item
                                                                        .name),
                                                                title: Text(
                                                                    item.name),
                                                                controlAffinity:
                                                                    ListTileControlAffinity
                                                                        .leading,
                                                                onChanged: (ischecked) => context
                                                                    .read<
                                                                        ReportsController>()
                                                                    .itemselectenqstatus(
                                                                        item.name,
                                                                        ischecked!),
                                                              ))
                                                          .toList()),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   width: Screens.width(context),
                          //   child: Padding(
                          //     padding: EdgeInsets.only(
                          //         left: Screens.width(context) * 0.02,
                          //         right: Screens.width(context) * 0.02,
                          //         top: Screens.padingHeight(context) * 0.01),
                          //     child: Column(
                          //       children: [
                          //         Container(
                          //           decoration: BoxDecoration(
                          //               border: Border(
                          //                   bottom: BorderSide(
                          //                       color: Colors.grey))),
                          //           child: Column(
                          //             children: [
                          //               TextField(
                          //                 onTap: () {
                          //                   setState(() {
                          //                     context
                          //                         .read<ReportsController>()
                          //                         .ontaplooking();
                          //                   });
                          //                 },
                          //                 readOnly: true,
                          //                 decoration: const InputDecoration(
                          //                     hintText: "Looking For",
                          //                     contentPadding:
                          //                         EdgeInsets.all(8.0),
                          //                     hintStyle: TextStyle(
                          //                         color: Colors.black,
                          //                         fontSize: 15),
                          //                     border: OutlineInputBorder(
                          //                         borderSide: BorderSide.none),
                          //                     disabledBorder:
                          //                         OutlineInputBorder(
                          //                             borderSide:
                          //                                 BorderSide.none),
                          //                     enabledBorder: OutlineInputBorder(
                          //                         borderSide: BorderSide.none),
                          //                     focusedBorder: OutlineInputBorder(
                          //                         borderSide: BorderSide.none),
                          //                     suffixIcon: Icon(
                          //                       Icons.arrow_drop_down,
                          //                       color: Colors.black,
                          //                     )),
                          //               ),
                          //               context
                          //                               .read<
                          //                                   ReportsController>()
                          //                               .islookingfor ==
                          //                           true &&
                          //                       context
                          //                           .read<ReportsController>()
                          //                           .filterlookingforcolumn
                          //                           .isNotEmpty
                          //                   ? Container(
                          //                       height: Screens.padingHeight(
                          //                               context) *
                          //                           0.2,
                          //                       child: SingleChildScrollView(
                          //                         child: ListBody(
                          //                             children: context
                          //                                 .read<
                          //                                     ReportsController>()
                          //                                 .filterlookingforcolumn
                          //                                 .map((item) =>
                          //                                     CheckboxListTile(
                          //                                       value: context
                          //                                           .watch<
                          //                                               ReportsController>()
                          //                                           .selectedlookingfor
                          //                                           .contains(item
                          //                                               .name),
                          //                                       title: Text(
                          //                                           item.name),
                          //                                       controlAffinity:
                          //                                           ListTileControlAffinity
                          //                                               .leading,
                          //                                       onChanged: (ischecked) => context
                          //                                           .read<
                          //                                               ReportsController>()
                          //                                           .itemselect(
                          //                                               item.name,
                          //                                               ischecked!),
                          //                                     ))
                          //                                 .toList()),
                          //                       ),
                          //                     )
                          //                   : Container()
                          //             ],
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),

                          SizedBox(
                            width: Screens.width(context),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Screens.width(context) * 0.02,
                                  right: Screens.width(context) * 0.02,
                                  top: Screens.padingHeight(context) * 0.01),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey))),
                                    child: Column(
                                      children: [
                                        TextField(
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<ReportsController>()
                                                  .ontapinterest();
                                            });
                                          },
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                              hintText: "Interest Level",
                                              contentPadding:
                                                  EdgeInsets.all(8.0),
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              suffixIcon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black,
                                              )),
                                        ),
                                        context
                                                        .read<
                                                            ReportsController>()
                                                        .isinterest ==
                                                    true &&
                                                context
                                                    .read<ReportsController>()
                                                    .intlevelcolumn
                                                    .isNotEmpty
                                            ? SizedBox(
                                                height: Screens.padingHeight(
                                                        context) *
                                                    0.2,
                                                child: SingleChildScrollView(
                                                  child: ListBody(
                                                      children: context
                                                          .read<
                                                              ReportsController>()
                                                          .intlevelcolumn
                                                          .map((item) =>
                                                              CheckboxListTile(
                                                                value: context
                                                                    .read<
                                                                        ReportsController>()
                                                                    .selectedinterest
                                                                    .contains(item
                                                                        .name),
                                                                title: Text(
                                                                    item.name),
                                                                controlAffinity:
                                                                    ListTileControlAffinity
                                                                        .leading,
                                                                onChanged: (ischecked) => context
                                                                    .read<
                                                                        ReportsController>()
                                                                    .itemselectinterest(
                                                                        item.name,
                                                                        ischecked!),
                                                              ))
                                                          .toList()),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Screens.width(context),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: Screens.width(context) * 0.02,
                                  right: Screens.width(context) * 0.02,
                                  top: Screens.padingHeight(context) * 0.01),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey))),
                                    child: Column(
                                      children: [
                                        TextField(
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<ReportsController>()
                                                  .ontaporder();
                                            });
                                          },
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                              hintText: "Order Type",
                                              contentPadding:
                                                  EdgeInsets.all(8.0),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                              suffixIcon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black,
                                              )),
                                        ),
                                        context
                                                        .read<
                                                            ReportsController>()
                                                        .isorder ==
                                                    true &&
                                                context
                                                    .read<ReportsController>()
                                                    .ordercolumn
                                                    .isNotEmpty
                                            ? SizedBox(
                                                height: Screens.padingHeight(
                                                        context) *
                                                    0.2,
                                                child: SingleChildScrollView(
                                                  child: ListBody(
                                                      children: context
                                                          .read<
                                                              ReportsController>()
                                                          .ordercolumn
                                                          .map((item) =>
                                                              CheckboxListTile(
                                                                value: context
                                                                    .read<
                                                                        ReportsController>()
                                                                    .selectedorder
                                                                    .contains(item
                                                                        .name),
                                                                title: Text(
                                                                    item.name),
                                                                controlAffinity:
                                                                    ListTileControlAffinity
                                                                        .leading,
                                                                onChanged: (ischecked) => context
                                                                    .read<
                                                                        ReportsController>()
                                                                    .itemselectorder(
                                                                        item.name,
                                                                        ischecked!),
                                                              ))
                                                          .toList()),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                              child: Padding(
                            padding: EdgeInsets.only(
                                // left: Screens.width(context) * 0.02,
                                right: Screens.width(context) * 0.02,
                                top: Screens.padingHeight(context) * 0.01),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: Screens.width(context) * 0.04),
                                  child: Text('Value Above',
                                      style:
                                          theme.textTheme.bodyLarge?.copyWith(
                                        color: Colors.black,
                                      )),
                                ),
                                // context
                                //             .watch<ReportsController>()
                                //             .minSelectedAmount ==
                                //         0
                                //     ? Container()
                                //     :
                                Container(
                                  padding: EdgeInsets.only(
                                      left: Screens.width(context) * 0.04),
                                  child: Text(
                                      'Minimum Amount : ${context.watch<ReportsController>().minSelectedAmount.toStringAsFixed(2)}',
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(
                                              color: Colors.grey,
                                              fontSize: 12)),
                                ),
                                // context
                                //             .watch<ReportsController>()
                                //             .maxSelectedAmount ==
                                //         0
                                //     ? Container()
                                //     :
                                Container(
                                  padding: EdgeInsets.only(
                                      left: Screens.width(context) * 0.04),
                                  child: Text(
                                      'Maximum Amount : ${context.watch<ReportsController>().maxSelectedAmount.toStringAsFixed(2)}',
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(
                                              color: Colors.grey,
                                              fontSize: 12)),
                                ),
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    valueIndicatorColor: Colors.white,
                                    showValueIndicator:
                                        ShowValueIndicator.always,
                                    valueIndicatorTextStyle: TextStyle(
                                        color: theme
                                            .primaryColor // Change text color here
                                        ),
                                    trackHeight: 2, // Adjust thickness here
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
                                    divisions: 500,
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
                                            context
                                                .read<ReportsController>()
                                                .currentRangeValues!
                                                .start;
                                        context
                                                .read<ReportsController>()
                                                .maxSelectedAmount =
                                            context
                                                .read<ReportsController>()
                                                .currentRangeValues!
                                                .end;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )),
                          // Container(
                          //   width: Screens.width(context),
                          //   child: Padding(
                          //     padding: EdgeInsets.only(
                          //         left: Screens.width(context) * 0.02,
                          //         right: Screens.width(context) * 0.02,
                          //         top: Screens.padingHeight(context) * 0.01),
                          //     child: Container(
                          //       width: Screens.width(context),
                          //       decoration: BoxDecoration(
                          //           border: Border(
                          //               bottom:
                          //                   BorderSide(color: Colors.grey))),
                          //       child: TextField(
                          //         controller: context
                          //             .read<ReportsController>()
                          //             .mycontroller[18],
                          //         keyboardType: TextInputType.number,
                          //         decoration: InputDecoration(
                          //           hintText: "Value Above",
                          //           enabledBorder: InputBorder.none,
                          //           focusedBorder: InputBorder.none,
                          //           hintStyle: TextStyle(
                          //               color: Colors.black, fontSize: 15),
                          //           contentPadding: const EdgeInsets.symmetric(
                          //             vertical: 10,
                          //             horizontal: 5,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: Screens.width(context) * 0.3,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                context
                                    .read<ReportsController>()
                                    .clearfilterval();
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)))),
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

                                  context
                                      .read<ReportsController>()
                                      .onfilterapply();
                                });
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)))),
                              child: Text(
                                "Apply",
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(color: Colors.white),
                              )))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
