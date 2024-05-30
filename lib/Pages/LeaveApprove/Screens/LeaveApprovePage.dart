// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, sort_child_properties_last, unnecessary_string_interpolations, duplicate_import, unused_import, unnecessary_import, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Pages/SiteOut/Widgets/AssignToMeAlertBox.dart';
import '../../../Constant/ConstantRoutes.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/ShowSearchDialog.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/LeaveApproveController/LeaveApproveController.dart';
// import '../../../Controller/LeaveReqController/LeaveReqController.dart';
// import '../../../Controller/VisitplanController/NewVisitController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';
import '../../VisitPlans/widgets/PurposeShowSearchDialog.dart';

class LeaveApprovePage extends StatefulWidget {
  LeaveApprovePage({Key? key}) : super(key: key);

  @override
  State<LeaveApprovePage> createState() => _LeaveApprovePageState();
}

class _LeaveApprovePageState extends State<LeaveApprovePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        // context.read<LeaveApproveContoller>().init(context);
      });
    });
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.offAllNamed(ConstantRoutes.leaveApprList);
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(       drawerEnableOpenDragGesture: false,

          resizeToAvoidBottomInset: false,
          key: scaffoldKey,
          drawer: drawer3(context),
          appBar: appbar("Leave Approve", scaffoldKey, theme, context),
          body: GestureDetector(onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.leaveApprList);
                      });
                    }
                  },
            child: Container(
              padding: paddings.padding2(context),
              child: Form(
                key: context.read<LeaveApproveContoller>().formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Screens.width(context),
                      // height: Screens.bodyheight(context) * 0.9,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            //tags
                            TextFormField(
                                readOnly: true,
                                controller: context
                                    .read<LeaveApproveContoller>()
                                    .mycontroller[0],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Emp Name";
                                  }
                                  return null;
                                },
                                onTap: () {},
                                decoration: InputDecoration(
                                  labelText: 'Emp Name',
                                  border: UnderlineInputBorder(),
                                  // labelStyle: theme.textTheme.bodyText1!
                                  //     .copyWith(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                    // borderSide: BorderSide(color: Colors.grey),
                                    //  when the TextFormField in unfocused
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    // borderSide: BorderSide(color: Colors.grey),
                                    //  when the TextFormField in focused
                                  ),
                                  errorBorder: UnderlineInputBorder(),
                                  focusedErrorBorder: UnderlineInputBorder(),
                                )),
          
                            Container(
                              width: Screens.width(context),
                              // alignment: Alignment.centerLeft,
                              height: Screens.bodyheight(context) * 0.07,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: Screens.bodyheight(context),
                                    width: Screens.width(context) * 0.3,
                                    alignment: Alignment.center,
                                    // color: Colors.amber,
                                    child: RadioListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 0),
                                        title: Text(
                                          'Full Day',
                                          style: theme.textTheme.bodySmall,
                                        ),
                                        activeColor:theme.primaryColor,
                                        
                                        value: "Full Day",
                                        groupValue: context
                                            .read<LeaveApproveContoller>()
                                            .radioLeavetype,
                                        onChanged: null),
                                  ),
                                  Container(
                                    height: Screens.bodyheight(context),
                                    width: Screens.width(context) * 0.3,
                                    // color: Colors.amber,
                                    child: RadioListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 0),
                                        title: Text(
                                          'Half Day',
                                          style: theme.textTheme.bodySmall,
                                        ),
                                        activeColor:theme.primaryColor,
                                        value: "Half Day",
                                        groupValue: context
                                            .read<LeaveApproveContoller>()
                                            .radioLeavetype,
                                        onChanged: null),
                                  ),
                                  Container(
                                    height: Screens.bodyheight(context),
                                    width: Screens.width(context) * 0.34,
                                    // color: Colors.amber,
                                    child: RadioListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 0),
                                        title: Text(
                                          'Permission',
                                          style: theme.textTheme.bodySmall,
                                        ),
                                        activeColor:theme.primaryColor,
                                        value: "Permission",
                                        groupValue: context
                                            .read<LeaveApproveContoller>()
                                            .radioLeavetype,
                                        onChanged: null),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.015,
                            ),
                            context
                                        .read<LeaveApproveContoller>()
                                        .radioLeavetype ==
                                    "Full Day"
                                ? Container(
                                    width: Screens.width(context),
                                    padding: EdgeInsets.all(
                                        Screens.bodyheight(context) * 0.008),
                                    // height: Screens.bodyheight(context)*0.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: theme.primaryColor)),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: Screens.width(context),
                                          child: DropdownButtonFormField(
                                            // hint: Text("Settlement"),
                                            // value: context.read<EnquiryUserContoller>(). valueChosedReason,
                                            //dropdownColor:Colors.green,
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 30,
                                            validator: context
                                                        .read<
                                                            LeaveApproveContoller>()
                                                        .radioLeavetype !=
                                                    "Full Day"
                                                ? null
                                                : ((value) {
                                                    if (value == null) {
                                                      return "Select Leave Type..";
                                                    }
                                                    return null;
                                                  }),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                            isExpanded: true,
          
                                            value: context
                                                .read<LeaveApproveContoller>()
                                                .leaveMode,
                                            onChanged: (val) {
                                              setState(() {
                                                context
                                                    .read<LeaveApproveContoller>()
                                                    .resonChoosed(val.toString());
                                              });
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Leave type',
                                              // labelStyle: theme
                                              //     .textTheme.bodyText1!
                                              //     .copyWith(color: Colors.grey),
          
                                              enabledBorder: UnderlineInputBorder(
                                                // borderSide: BorderSide(
                                                //     color: Colors.grey),
                                                //  when the TextFormField in unfocused
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                // borderSide: BorderSide(
                                                //     color: Colors.grey),
                                                //  when the TextFormField in focused
                                              ),
                                              border: UnderlineInputBorder(),
                                              // contentPadding: EdgeInsets.symmetric(
                                              //   horizontal: Screens.width(context) * 0.05,
                                              //   // vertical: Screens.width(context)
                                              // )
                                            ),
                                            items: <String>[
                                              "${context.watch<LeaveApproveContoller>().leaveMode}",
                                            ].map((String value) {
                                              return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value.toString()));
                                            }).toList(),
                                          ),
                                        ),
                                        // Container(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: Screens.width(context) * 0.4,
                                              child: TextFormField(
                                                  onTap: () {
                                                    // context
                                                    //     .read<
                                                    //         LeaveApproveContoller>()
                                                    //     .StartAndEndDate(context,
                                                    //         "Start Date");
                                                  },
                                                  controller: context
                                                      .read<
                                                          LeaveApproveContoller>()
                                                      .mycontroller[1],
                                                  validator: context
                                                              .read<
                                                                  LeaveApproveContoller>()
                                                              .radioLeavetype !=
                                                          "Full Day"
                                                      ? null
                                                      : (value) {
                                                          if (value!.isEmpty) {
                                                            return "Choose Start Date";
                                                          }
                                                          return null;
                                                        },
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                      labelText: 'Start Date', //
                                                      border:
                                                          UnderlineInputBorder(),
                                                      // labelStyle: theme
                                                      //     .textTheme.bodyText1!
                                                      //     .copyWith(
                                                      //         color: Colors.grey),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color: Colors.grey),
                                                        //  when the TextFormField in unfocused
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color: Colors.grey),
                                                        //  when the TextFormField in focused
                                                      ),
                                                      errorBorder:
                                                          UnderlineInputBorder(),
                                                      // contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                                      focusedErrorBorder:
                                                          UnderlineInputBorder(),
                                                      suffixIcon: Icon(Icons
                                                          .date_range_outlined))),
                                            ),
                                            Container(
                                              width: Screens.width(context) * 0.4,
                                              child: TextFormField(
                                                  onTap: () {
                                                    // context
                                                    //     .read<
                                                    //         LeaveApproveContoller>()
                                                    //     .StartAndEndDate(
                                                    //         context, "End Date");
                                                  },
                                                  controller: context
                                                      .read<
                                                          LeaveApproveContoller>()
                                                      .mycontroller[2],
                                                  validator: context
                                                              .read<
                                                                  LeaveApproveContoller>()
                                                              .radioLeavetype !=
                                                          "Full Day"
                                                      ? null
                                                      : (value) {
                                                          if (value!.isEmpty) {
                                                            return "Choose End Date";
                                                          }
                                                          return null;
                                                        },
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                      labelText: 'End Date', //
                                                      border:
                                                          UnderlineInputBorder(),
                                                      // labelStyle: theme
                                                      //     .textTheme.bodyText1!
                                                      //     .copyWith(
                                                      //         color: Colors.grey),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color: Colors.grey),
                                                        //  when the TextFormField in unfocused
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color: Colors.grey),
                                                        //  when the TextFormField in focused
                                                      ),
                                                      errorBorder:
                                                          UnderlineInputBorder(),
                                                      focusedErrorBorder:
                                                          UnderlineInputBorder(),
                                                      suffixIcon: Icon(Icons
                                                          .date_range_outlined))),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              Screens.bodyheight(context) * 0.02,
                                        ),
                                        Container(
                                          width: Screens.width(context),
                                          child: Text(
                                            "No Of Leave Request Days : ${context.read<LeaveApproveContoller>().noOfDays()}",
                                            style: theme.textTheme.bodyText1,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              Screens.bodyheight(context) * 0.01,
                                        ),
                                      ],
                                    ),
                                  )
                                : context
                                            .read<LeaveApproveContoller>()
                                            .radioLeavetype ==
                                        "Half Day"
                                    ? Container(
                                        width: Screens.width(context),
                                        // alignment: Alignment.center,
          
                                        padding: EdgeInsets.all(
                                            Screens.bodyheight(context) * 0.01),
                                        // height: Screens.bodyheight(context)*0.5,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: theme.primaryColor)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Container(),
                                            Container(
                                              width: Screens.width(context),
                                              child: TextFormField(
                                                  onTap: () {
                                                    // context
                                                    //     .read<
                                                    //         LeaveApproveContoller>()
                                                    //     .StartAndEndDate(
                                                    //         context, "Half Day");
                                                  },
                                                  controller: context
                                                      .read<
                                                          LeaveApproveContoller>()
                                                      .mycontroller[3],
                                                  validator: context
                                                              .read<
                                                                  LeaveApproveContoller>()
                                                              .radioLeavetype !=
                                                          "Half Day"
                                                      ? null
                                                      : (value) {
                                                          if (value!.isEmpty) {
                                                            return "Choose Date";
                                                          }
                                                          return null;
                                                        },
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                      labelText: 'Select Date', //
                                                      border:
                                                          UnderlineInputBorder(),
                                                      // labelStyle:
                                                      //     theme.textTheme
                                                      //         .bodyText1!
                                                      //         .copyWith(
                                                      //             color: Colors
                                                      //                 .grey),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color: Colors.grey),
                                                        //  when the TextFormField in unfocused
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color: Colors.grey),
                                                        //  when the TextFormField in focused
                                                      ),
                                                      errorBorder:
                                                          UnderlineInputBorder(),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      focusedErrorBorder:
                                                          UnderlineInputBorder(),
                                                      suffixIcon: Icon(Icons
                                                          .date_range_outlined))),
                                            ),
                                            Container(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.08,
                                              // color: Colors.amber,
                                              child: Row(
                                                // crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    height: Screens.bodyheight(
                                                            context) *
                                                        0.09,
                                                    // color: Colors.blue,
          
                                                    width:
                                                        Screens.width(context) *
                                                            0.4,
                                                    // color: Colors.amber,
                                                    child: RadioListTile(
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        title: Text(
                                                          'First Half',
                                                          style: theme.textTheme
                                                              .bodySmall,
                                                        ),
                                                        value: "First Half",
                                                        groupValue: context
                                                            .read<
                                                                LeaveApproveContoller>()
                                                            .radioHalfLeavetype,
                                                        onChanged: null),
                                                    alignment: Alignment.center,
                                                  ),
                                                  Container(
                                                    // color: Colors.blue,
          
                                                    alignment: Alignment.center,
                                                    height: Screens.bodyheight(
                                                            context) *
                                                        0.09,
                                                    width:
                                                        Screens.width(context) *
                                                            0.4,
                                                    // color: Colors.amber,
                                                    child: RadioListTile(
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        title: Text(
                                                          'Second Half',
                                                          style: theme.textTheme
                                                              .bodySmall,
                                                        ),
                                                        value: "Second Half",
                                                        groupValue: context
                                                            .read<
                                                                LeaveApproveContoller>()
                                                            .radioHalfLeavetype,
                                                        onChanged: null),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // SizedBox(
                                            //   height: Screens.bodyheight(context) *
                                            //       0.02,
                                            // ),
                                            // Container(
                                            //   width: Screens.width(context),
                                            //   child: Text(
                                            //     "No Of Leave Request Days",
                                            //     style: theme.textTheme.bodyText1,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        width: Screens.width(context),
                                        // alignment: Alignment.center,
          
                                        padding: EdgeInsets.all(
                                            Screens.bodyheight(context) * 0.01),
                                        // height: Screens.bodyheight(context)*0.5,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: theme.primaryColor)),
          
                                        child: Column(
                                          children: [
                                            Container(
                                              width: Screens.width(context),
                                              child: TextFormField(
                                                  onTap: () {
                                                    // context
                                                    //     .read<
                                                    //         LeaveApproveContoller>()
                                                    //     .StartAndEndDate(context,
                                                    //         "Permission");
                                                  },
                                                  controller: context
                                                      .read<
                                                          LeaveApproveContoller>()
                                                      .mycontroller[4],
                                                  validator: context
                                                              .read<
                                                                  LeaveApproveContoller>()
                                                              .radioHalfLeavetype !=
                                                          "Permission"
                                                      ? null
                                                      : (value) {
                                                          if (value!.isEmpty) {
                                                            return "Choose Date";
                                                          }
                                                          return null;
                                                        },
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                      labelText: 'Select Date', //
                                                      border:
                                                          UnderlineInputBorder(),
                                                      // labelStyle: theme
                                                      //     .textTheme.bodyText1!
                                                      //     .copyWith(
                                                      //         color: Colors.grey),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color: Colors.grey),
                                                        //  when the TextFormField in unfocused
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color: Colors.grey),
                                                        //  when the TextFormField in focused
                                                      ),
                                                      errorBorder:
                                                          UnderlineInputBorder(),
                                                      focusedErrorBorder:
                                                          UnderlineInputBorder(),
                                                      suffixIcon: Icon(Icons
                                                          .date_range_outlined))),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: Screens.width(context) *
                                                      0.37,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                  ),
                                                  child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            LeaveApproveContoller>()
                                                        .mycontroller[5],
          
                                                    onTap: () {
                                                      setState(() {
                                                        // context
                                                        //     .read<
                                                        //         LeaveApproveContoller>()
                                                        //     .clearbool();
                                                        // context
                                                        //     .read<
                                                        //         LeaveApproveContoller>()
                                                        //     .selectTime(context,
                                                        //         "Start Time");
                                                      });
                                                    },
                                                    // autofocus: true,
                                                    readOnly: true,
                                                    style: theme
                                                        .textTheme.bodyText2
                                                        ?.copyWith(
                                                            backgroundColor:
                                                                Colors.white),
                                                    onChanged: (v) {},
                                                    validator: (value) {},
                                                    decoration: InputDecoration(
                                                      labelText: 'Start Time', //
                                                      border:
                                                          UnderlineInputBorder(),
                                                      // labelStyle: theme
                                                      //     .textTheme.bodyText1!
                                                      //     .copyWith(
                                                      //         color: Colors.grey),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color: Colors.grey),
                                                        //  when the TextFormField in unfocused
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color: Colors.grey),
                                                        //  when the TextFormField in focused
                                                      ),
                                                      errorBorder:
                                                          UnderlineInputBorder(),
                                                      focusedErrorBorder:
                                                          UnderlineInputBorder(),
                                                      suffixIcon: IconButton(
                                                          padding: EdgeInsets.only(
                                                              top: Screens
                                                                      .bodyheight(
                                                                          context) *
                                                                  0.002),
                                                          onPressed: () {
                                                            setState(() {
                                                              // context
                                                              //     .read<
                                                              //         LeaveApproveContoller>()
                                                              //     .selectTime(
                                                              //         context,
                                                              //         "Start Time");
                                                            });
                                                          },
                                                          icon: Icon(
                                                            Icons.timer,
                                                            color: theme
                                                                .primaryColor,
                                                          )),
                                                      // filled: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                        vertical: 11,
                                                        horizontal: 5,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: Screens.width(context) *
                                                      0.37,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                  ),
                                                  child: TextFormField(
                                                    controller: context
                                                        .read<
                                                            LeaveApproveContoller>()
                                                        .mycontroller[6],
          
                                                    onTap: () {
                                                      setState(() {
                                                        // context
                                                        //     .read<
                                                        //         LeaveApproveContoller>()
                                                        //     .clearbool();
                                                        // context
                                                        //     .read<
                                                        //         LeaveApproveContoller>()
                                                        //     .selectTime(context,
                                                        //         "End Time");
                                                      });
                                                    },
                                                    // autofocus: true,
                                                    readOnly: true,
                                                    style: theme
                                                        .textTheme.bodyText2
                                                        ?.copyWith(
                                                            backgroundColor:
                                                                Colors.white),
                                                    onChanged: (v) {},
                                                    validator: (value) {},
                                                    decoration: InputDecoration(
                                                      labelText: 'End Time', //
                                                      border:
                                                          UnderlineInputBorder(),
                                                      // labelStyle: theme
                                                      //     .textTheme.bodyText1!
                                                      //     .copyWith(
                                                      //         color: Colors.grey),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color: Colors.grey),
                                                        //  when the TextFormField in unfocused
                                                      ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        // borderSide: BorderSide(
                                                        //     color: Colors.grey),
                                                        //  when the TextFormField in focused
                                                      ),
                                                      errorBorder:
                                                          UnderlineInputBorder(),
                                                      focusedErrorBorder:
                                                          UnderlineInputBorder(),
                                                      suffixIcon: IconButton(
                                                          padding: EdgeInsets.only(
                                                              top: Screens
                                                                      .bodyheight(
                                                                          context) *
                                                                  0.002),
                                                          onPressed: () {
                                                            setState(() {
                                                              // context
                                                              //     .read<
                                                              //         LeaveApproveContoller>()
                                                              //     .selectTime(
                                                              //         context,
                                                              //         "End Time");
                                                            });
                                                          },
                                                          icon: Icon(
                                                            Icons.timer,
                                                            color: theme
                                                                .primaryColor,
                                                          )),
                                                      // filled: true,
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                        vertical: 11,
                                                        horizontal: 5,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.005,
                                            )
                                          ],
                                        ),
                                      ),
                            // context.read<LeaveApproveContoller>().assignTo == false
                            //     ? SizedBox()
                            //     : SizedBox(
                            //         height: Screens.bodyheight(context) * 0.015,
                            //       ),
                            // context.read<LeaveApproveContoller>().assignTo == false
                            //     ? Container()
                            //     : Column(
                            //         children: [
                            //           Stack(children: [
                            //             SizedBox(
                            //               child: TextFormField(
                            //                 onTap: () {
                            //                   showDialog<dynamic>(
                            //                       context: context,
                            //                       builder: (_) {
                            //                         return AssignToMeDialog();
                            //                       });
                            //                 },
                            //                 // validator: (value) {
                            //                 //   if (value!.isEmpty) {
                            //                 //     return "Enter Assigned To";
                            //                 //   }
                            //                 //   return null;
                            //                 // },
                            //                 // readOnly: true,
                            //                 controller: context
                            //                     .read<LeaveApproveContoller>()
                            //                     .mycontroller[8],
                            //                 readOnly: true,
                            //                 decoration: InputDecoration(
                            //                   contentPadding:
                            //                       EdgeInsets.symmetric(
                            //                           vertical: 10,
                            //                           horizontal: 10),
                            //                   labelText: "Assigned To:",
                            //                   labelStyle: TextStyle(
                            //                       color: theme.primaryColor,
                            //                       fontWeight: FontWeight.bold),
                            //                   border: OutlineInputBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(8),
                            //                     borderSide: BorderSide(
                            //                         color: theme.primaryColor),
                            //                   ),
                            //                   enabledBorder: OutlineInputBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(8),
                            //                     borderSide: BorderSide(
                            //                         color: theme.primaryColor),
                            //                   ),
                            //                   focusedBorder: OutlineInputBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(8),
                            //                     borderSide: BorderSide(
                            //                         color: theme.primaryColor),
                            //                   ),
                            //                 ),
                            //                 // cursorColor: Colors.green,
                            //               ),
                            //             ),
                            //             Positioned(
                            //                 top: 0,
                            //                 left: Screens.width(context) * 0.74,
                            //                 child: InkWell(
                            //                     onTap: () {
                            //                       showDialog<dynamic>(
                            //                           context: context,
                            //                           builder: (_) {
                            //                             return AssignToMeDialog();
                            //                           });
                            //                     },
                            //                     child: Container(
                            //                         width:
                            //                             Screens.width(context) *
                            //                                 0.2,
                            //                         height: Screens.bodyheight(
                            //                                 context) *
                            //                             0.079,
                            //                         decoration: BoxDecoration(
                            //                             color:
                            //                                 theme.primaryColor,
                            //                             borderRadius:
                            //                                 BorderRadius.only(
                            //                               topRight:
                            //                                   Radius.circular(
                            //                                       8),
                            //                               bottomRight:
                            //                                   Radius.circular(
                            //                                       8),
                            //                             )),
                            //                         child: Icon(Icons.search))))
                            //           ]),
                            //         ],
                            //       ),
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.01,
                            ),
                            Container(
                              height: Screens.bodyheight(context) * 0.05,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Resons",
                                style: TextStyle(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextFormField(
                              minLines: 6,
                              readOnly: true,
                              controller: context
                                  .read<LeaveApproveContoller>()
                                  .mycontroller[7],
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Reson..";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  top: Screens.bodyheight(context) * 0.04,
                                  left: Screens.bodyheight(context) * 0.01,
                                ),
                                alignLabelWithHint: true,
                                // border: OutlineInputBorder(),
                                hintText: '',
                              ),
                            ),
                            TextFormField(
                                readOnly: true,
                                controller: context
                                    .read<LeaveApproveContoller>()
                                    .mycontroller[8],
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Enter Emp Name";
                                //   }
                                //   return null;
                                // },
                                onTap: () {},
                                decoration: InputDecoration(
                                  labelText: 'Manager Name',
                                  border: UnderlineInputBorder(),
                                  // labelStyle: theme.textTheme.bodyText1!
                                  //     .copyWith(color: Colors.grey),
                                  enabledBorder: UnderlineInputBorder(
                                    // borderSide: BorderSide(color: Colors.grey),
                                    //  when the TextFormField in unfocused
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    // borderSide: BorderSide(color: Colors.grey),
                                    //  when the TextFormField in focused
                                  ),
                                  errorBorder: UnderlineInputBorder(),
                                  focusedErrorBorder: UnderlineInputBorder(),
                                )),
          
                            SizedBox(
                              // width: Screens.width(context),
                              height: Screens.bodyheight(context) * 0.01,
                            ),
                          ],
                        ),
                      ),
                    ),
                    //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.46,
                          height: Screens.bodyheight(context) * 0.07,
                          child: ElevatedButton(
                              onPressed: context
                                          .watch<LeaveApproveContoller>()
                                          .isloadingRej ==
                                      true
                                  ? null
                                  : () {
                                    setState(() {
                                        context
                                          .read<LeaveApproveContoller>()
                                          .validateLeaveReq(context, "Reject",-1);
                                    });
                                    
                                    },
                              child: context
                                          .watch<LeaveApproveContoller>()
                                          .isloadingRej ==
                                      true
                                  ? Center(
                                      child: CircularProgressIndicator(color: Colors.white,),
                                    )
                                  : Text("Reject")),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.46,
                          height: Screens.bodyheight(context) * 0.07,
                          child: ElevatedButton(
                              onPressed: context
                                          .watch<LeaveApproveContoller>()
                                          .isloadingAppro ==
                                      true
                                  ? null
                                  : () {setState(() {
                                     context
                                          .read<LeaveApproveContoller>()
                                          .validateLeaveReq(
                                              context, "Approved",1);
                                  });
                                     
                                    },
                              child: context
                                          .read<LeaveApproveContoller>()
                                          .isloadingAppro ==
                                      true
                                  ? Center(
                                      child: CircularProgressIndicator(color: Colors.white,),
                                    )
                                  : Text("Approve")),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
