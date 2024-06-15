// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, sort_child_properties_last, unnecessary_string_interpolations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Pages/VisitPlans/widgets/recentdialog.dart';
import 'package:sellerkit/Pages/VisitPlans/widgets/showdialog.dart';
import 'package:sellerkit/Pages/VisitPlans/widgets/userdialog.dart';
// import 'package:sellerkit/Controller/EnquiryController/NewEnqController.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/VisitplanController/NewVisitController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';
import '../widgets/PurposeShowSearchDialog.dart';

class NewVisitPlan extends StatefulWidget {
  NewVisitPlan({Key? key}) : super(key: key);

  @override
  State<NewVisitPlan> createState() => NewVisitPlanState();
}

class NewVisitPlanState extends State<NewVisitPlan> {
  static bool iscomfromLead = false;

  Paddings paddings = Paddings();

  @override
  void initState() {
    log("iscomfromLead::" + iscomfromLead.toString());
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        if (iscomfromLead == false) {
          log("An vuuuuu");
          context.read<NewVisitplanController>().init();
        } else if (iscomfromLead == true) {
          context.read<NewVisitplanController>().checkcomefrom(context);

          iscomfromLead = false;
        }
        // context.read<NewVisitplanController>().init();
      });
    });
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        drawerEnableOpenDragGesture: false,
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        drawer: drawer3(context),
        appBar: appbar("Schedule Visit", scaffoldKey, theme, context),
        body: GestureDetector(
           onTap: () {
              setState(() {
                 FocusScopeNode cf = FocusScope.of(context);
                if (!cf.hasPrimaryFocus && cf.focusedChild !=null) {
                  cf.focusedChild!.unfocus();
                cf.unfocus();  
                }
                // FocusScope.of(context).unfocus();
              });
            },
          onHorizontalDragUpdate: (details) {
            // Check if the user is swiping from left to right
            print(details.primaryDelta);
            if (details.primaryDelta! > ConstantValues.slidevalue!) {
              setState(() {
                Get.offAllNamed(ConstantRoutes.visitplan);
              });
            }
          },
          child: Container(
            padding: paddings.padding2(context),
            child: (context
                        .read<NewVisitplanController>()
                        .getexceptionOnApiCall
                        .isEmpty &&
                    context
                            .watch<NewVisitplanController>()
                            .getcustomerapicLoading ==
                        true)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : (context
                            .read<NewVisitplanController>()
                            .getexceptionOnApiCall
                            .isNotEmpty &&
                        context
                                .watch<NewVisitplanController>()
                                .getcustomerapicLoading ==
                            false)
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              context
                                  .read<NewVisitplanController>()
                                  .getexceptionOnApiCall,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      )
                    : Form(
                        key: context.read<NewVisitplanController>().formkey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Screens.width(context),
                              height: Screens.bodyheight(context) * 0.9,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextFormField(
                                        focusNode: context
                                            .read<NewVisitplanController>()
                                            .focusNode2,
                                        controller: context
                                            .read<NewVisitplanController>()
                                            .mycontroller[1],
                                        onTap: () {
                                          setState(() {
                                            context
                                                .read<NewVisitplanController>()
                                                .clearbool();
                                          });
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Enter Mobile Number";
                                          } else if (value.length > 10 ||
                                              value.length < 10) {
                                            return "Enter a valid Mobile Number";
                                          }
                                          return null;
                                        },
                                        onEditingComplete: (){
                                          if(context
                                            .read<NewVisitplanController>()
                                            .mycontroller[1].text.length==10){
 context
                                                .read<NewVisitplanController>()
                                                .callApi(context);
                                            }
                                         
                                        },
                                        onChanged: (v) {
                                          if (v.length == 10 &&
                                              context
                                                      .read<
                                                          NewVisitplanController>()
                                                      .getcustomerapicalled ==
                                                  false) {
                                            context
                                                .read<NewVisitplanController>()
                                                .callApi(context);
                                            // context
                                            //     .read<NewVisitplanController>()
                                            //     .callCheckEnqDetailsApi(context
                                            //         .read<NewVisitplanController>()
                                            //         .mycontroller[0]
                                            //         .text);
                                          } else if (v.length != 10) {
                                            context
                                                .read<NewVisitplanController>()
                                                .clearnum();
                                          }
                                        },
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          new LengthLimitingTextInputFormatter(
                                              10),
                                        ],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Mobile No*',
                                          border: UnderlineInputBorder(),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            //  when the TextFormField in unfocused
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            //  when the TextFormField in focused
                                          ),
                                          errorBorder: UnderlineInputBorder(),
                                          focusedErrorBorder:
                                              UnderlineInputBorder(),
                                        )),
                                    TextFormField(
                                        controller: context
                                            .read<NewVisitplanController>()
                                            .mycontroller[0],
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Enter Customer";
                                          }
                                          return null;
                                        },
                                        onTap: () {
                                          if (context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .mycontroller[8]
                                                  .text
                                                  .isNotEmpty &&
                                              context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .statecode
                                                  .isEmpty) {
                                            context
                                                .read<NewVisitplanController>()
                                                .ontapvalid(context);
                                          } else if (context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .mycontroller[8]
                                                  .text
                                                  .isNotEmpty &&
                                              context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .statecode
                                                  .isNotEmpty) {
                                            setState(() {
                                              context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .statebool = false;
                                            });
                                          }
                                        },
                                        onChanged: (v) {
                                          setState(() {
                                            context
                                                .read<NewVisitplanController>()
                                                .filterListcustomer(v);
                                            // if (context
                                            //     .read<NewVisitplanController>()
                                            //     .filterexistCusDataList
                                            //     .isEmpty) {
                                            //   context
                                            //       .read<NewVisitplanController>()
                                            //       .customerbool = false;
                                            // } else {
                                            //   context
                                            //       .read<NewVisitplanController>()
                                            //       .customerbool = true;
                                            // }
                                            if (v.isEmpty) {
                                              context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .customerbool = false;
                                            } else {
                                              context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .customerbool = true;
                                            }
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Customer*',
                                          border: UnderlineInputBorder(),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            //  when the TextFormField in unfocused
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            //  when the TextFormField in focused
                                          ),
                                          errorBorder: UnderlineInputBorder(),
                                          focusedErrorBorder:
                                              UnderlineInputBorder(),
                                        )),
                                    Visibility(
                                      visible: context
                                          .read<NewVisitplanController>()
                                          .customerbool,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.01,
                                          ),
                                          context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .filterexistCusDataList
                                                  .isEmpty
                                              ? Container()
                                              : Container(

                                                  // color: Colors.amber,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color: theme
                                                              .primaryColor)),
                                                  width: Screens.width(context),
                                                  height: Screens.bodyheight(
                                                          context) *
                                                      0.2,
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .filterexistCusDataList
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int i) {
                                                        return InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              context
                                                                  .read<
                                                                      NewVisitplanController>()
                                                                  .customerbool = false;
                                                              context
                                                                  .read<
                                                                      NewVisitplanController>()
                                                                  .getExiCustomerData(context
                                                                      .read<
                                                                          NewVisitplanController>()
                                                                      .filterexistCusDataList[
                                                                          i]
                                                                      .Customer
                                                                      .toString());
                                                              context
                                                                      .read<
                                                                          NewVisitplanController>()
                                                                      .mycontroller[
                                                                          0]
                                                                      .text =
                                                                  context
                                                                      .read<
                                                                          NewVisitplanController>()
                                                                      .filterexistCusDataList[
                                                                          i]
                                                                      .Customer
                                                                      .toString();
                                                            });
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets.all(
                                                                    Screens.bodyheight(
                                                                            context) *
                                                                        0.008),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                // color: Colors.red,
                                                                height: Screens
                                                                        .bodyheight(
                                                                            context) *
                                                                    0.05,
                                                                width: Screens
                                                                    .width(
                                                                        context),
                                                                child: Text(
                                                                  "${context.watch<NewVisitplanController>().filterexistCusDataList[i].Customer}",
                                                                  style: theme
                                                                      .textTheme
                                                                      .bodyText1
                                                                      ?.copyWith(
                                                                          color:
                                                                              Colors.black),
                                                                ),
                                                              ),
                                                              Divider()
                                                            ],
                                                          ),
                                                        );
                                                      })),
                                        ],
                                      ),
                                    ),

                                    // SizedBox(
                                    //   height: Screens.bodyheight(context) * 0.005,
                                    // ),

                                    // SizedBox(
                                    //   height: Screens.bodyheight(context) * 0.005,
                                    // ),
                                    //tags

                                    ///

                                    TextFormField(
                                        controller: context
                                            .read<NewVisitplanController>()
                                            .mycontroller[2],
                                        // validator: (value) {
                                        //   if (value!.isEmpty) {
                                        //     return "Enter Contact Name";
                                        //   }
                                        //   return null;
                                        // },
                                        onTap: () {
                                          if (context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .mycontroller[8]
                                                  .text
                                                  .isNotEmpty &&
                                              context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .statecode
                                                  .isEmpty) {
                                            context
                                                .read<NewVisitplanController>()
                                                .ontapvalid(context);
                                          } else if (context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .mycontroller[8]
                                                  .text
                                                  .isNotEmpty &&
                                              context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .statecode
                                                  .isNotEmpty) {
                                            setState(() {
                                              context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .statebool = false;
                                            });
                                          }
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Contact Name (optional)',
                                          border: UnderlineInputBorder(),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            //  when the TextFormField in unfocused
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            //  when the TextFormField in focused
                                          ),
                                          errorBorder: UnderlineInputBorder(),
                                          focusedErrorBorder:
                                              UnderlineInputBorder(),
                                        )),
                                    // SizedBox(
                                    //   height: Screens.bodyheight(context) * 0.005,
                                    // ),
                                    TextFormField(
                                        controller: context
                                            .read<NewVisitplanController>()
                                            .mycontroller[3],
                                        onTap: () {
                                          if (context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .mycontroller[8]
                                                  .text
                                                  .isNotEmpty &&
                                              context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .statecode
                                                  .isEmpty) {
                                            context
                                                .read<NewVisitplanController>()
                                                .ontapvalid(context);
                                          } else if (context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .mycontroller[8]
                                                  .text
                                                  .isNotEmpty &&
                                              context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .statecode
                                                  .isNotEmpty) {
                                            setState(() {
                                              context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .statebool = false;
                                            });
                                          }
                                        },
                                        // validator: (value) {
                                        //   if (value!.isEmpty) {
                                        //     return "Enter Address1";
                                        //   }
                                        //   return null;
                                        // },
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          labelText: 'Address1',
                                          border: UnderlineInputBorder(),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            //  when the TextFormField in unfocused
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            //  when the TextFormField in focused
                                          ),
                                          errorBorder: UnderlineInputBorder(),
                                          focusedErrorBorder:
                                              UnderlineInputBorder(),
                                        )),
                                    // SizedBox(
                                    //   height: Screens.bodyheight(context) * 0.005,
                                    // ),
                                    TextFormField(
                                        controller: context
                                            .read<NewVisitplanController>()
                                            .mycontroller[4],
                                        onTap: () {
                                          if (context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .mycontroller[8]
                                                  .text
                                                  .isNotEmpty &&
                                              context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .statecode
                                                  .isEmpty) {
                                            context
                                                .read<NewVisitplanController>()
                                                .ontapvalid(context);
                                          } else if (context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .mycontroller[8]
                                                  .text
                                                  .isNotEmpty &&
                                              context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .statecode
                                                  .isNotEmpty) {
                                            setState(() {
                                              context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .statebool = false;
                                            });
                                          }
                                        },
                                        // validator: (value) {
                                        //   if (value!.isEmpty) {
                                        //     return "Enter Address2";
                                        //   }
                                        //   return null;
                                        // },
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          labelText: 'Address2',
                                          border: UnderlineInputBorder(),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            //  when the TextFormField in unfocused
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            //  when the TextFormField in focused
                                          ),
                                          errorBorder: UnderlineInputBorder(),
                                          focusedErrorBorder:
                                              UnderlineInputBorder(),
                                        )),
                                    // SizedBox(
                                    //   height: Screens.bodyheight(context) * 0.005,
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: Screens.width(context) * 0.4,
                                          child: TextFormField(
                                              controller: context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .mycontroller[5],
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Enter Area";
                                                }
                                                return null;
                                              },
                                              onTap: () {
                                                if (context
                                                        .read<
                                                            NewVisitplanController>()
                                                        .mycontroller[8]
                                                        .text
                                                        .isNotEmpty &&
                                                    context
                                                        .read<
                                                            NewVisitplanController>()
                                                        .statecode
                                                        .isEmpty) {
                                                  context
                                                      .read<
                                                          NewVisitplanController>()
                                                      .ontapvalid(context);
                                                } else if (context
                                                        .read<
                                                            NewVisitplanController>()
                                                        .mycontroller[8]
                                                        .text
                                                        .isNotEmpty &&
                                                    context
                                                        .read<
                                                            NewVisitplanController>()
                                                        .statecode
                                                        .isNotEmpty) {
                                                  setState(() {
                                                    context
                                                        .read<
                                                            NewVisitplanController>()
                                                        .statebool = false;
                                                  });
                                                }
                                              },
                                              onChanged: (v) {
                                                setState(() {
                                                  context
                                                      .read<
                                                          NewVisitplanController>()
                                                      .filterListArea(v);
                                                  if (v.isEmpty) {
                                                    context
                                                        .read<
                                                            NewVisitplanController>()
                                                        .areabool = false;
                                                  } else {
                                                    context
                                                        .read<
                                                            NewVisitplanController>()
                                                        .areabool = true;
                                                  }
                                                });
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Area*',
                                                border: UnderlineInputBorder(),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  //  when the TextFormField in unfocused
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  //  when the TextFormField in focused
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(),
                                              )),
                                        ),
                                        SizedBox(
                                          width: Screens.width(context) * 0.4,
                                          child: TextFormField(
                                              controller: context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .mycontroller[6],
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Enter City";
                                                }
                                                return null;
                                              },
                                              onTap: () {
                                                if (context
                                                        .read<
                                                            NewVisitplanController>()
                                                        .mycontroller[8]
                                                        .text
                                                        .isNotEmpty &&
                                                    context
                                                        .read<
                                                            NewVisitplanController>()
                                                        .statecode
                                                        .isEmpty) {
                                                  context
                                                      .read<
                                                          NewVisitplanController>()
                                                      .ontapvalid(context);
                                                } else if (context
                                                        .read<
                                                            NewVisitplanController>()
                                                        .mycontroller[8]
                                                        .text
                                                        .isNotEmpty &&
                                                    context
                                                        .read<
                                                            NewVisitplanController>()
                                                        .statecode
                                                        .isNotEmpty) {
                                                  setState(() {
                                                    context
                                                        .read<
                                                            NewVisitplanController>()
                                                        .statebool = false;
                                                  });
                                                }
                                              },
                                              onChanged: (v) {
                                                setState(() {
                                                  context
                                                      .read<
                                                          NewVisitplanController>()
                                                      .filterListCity(v);
                                                  if (v.isEmpty) {
                                                    context
                                                        .read<
                                                            NewVisitplanController>()
                                                        .citybool = false;
                                                  } else {
                                                    context
                                                        .read<
                                                            NewVisitplanController>()
                                                        .citybool = true;
                                                  }
                                                });
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'City*',
                                                border: UnderlineInputBorder(),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  //  when the TextFormField in unfocused
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey),
                                                  //  when the TextFormField in focused
                                                ),
                                                errorBorder:
                                                    UnderlineInputBorder(),
                                                focusedErrorBorder:
                                                    UnderlineInputBorder(),
                                              )),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: context
                                          .read<NewVisitplanController>()
                                          .areabool,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.01,
                                          ),
                                          context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .filterexistCusDataList
                                                  .isEmpty
                                              ? Container()
                                              : Container(

                                                  // color: Colors.amber,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color: theme
                                                              .primaryColor)),
                                                  width: Screens.width(context),
                                                  height: Screens.bodyheight(
                                                          context) *
                                                      0.2,
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .filterexistCusDataList
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int i) {
                                                        return InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              // context
                                                              //     .read<
                                                              //         NewVisitplanController>()
                                                              //     .getExiAreaData(context
                                                              //         .read<
                                                              //             NewVisitplanController>()
                                                              //         .filterexistCusDataList[
                                                              //             i]
                                                              //         .U_Area
                                                              //         .toString());
                                                              context
                                                                  .read<
                                                                      NewVisitplanController>()
                                                                  .areabool = false;
                                                              context
                                                                      .read<
                                                                          NewVisitplanController>()
                                                                      .mycontroller[
                                                                          5]
                                                                      .text =
                                                                  context
                                                                      .read<
                                                                          NewVisitplanController>()
                                                                      .filterexistCusDataList[
                                                                          i]
                                                                      .U_Area
                                                                      .toString();
                                                            });
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets.all(
                                                                    Screens.bodyheight(
                                                                            context) *
                                                                        0.008),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                // color: Colors.red,
                                                                height: Screens
                                                                        .bodyheight(
                                                                            context) *
                                                                    0.05,
                                                                width: Screens
                                                                    .width(
                                                                        context),
                                                                child: Text(
                                                                  "${context.watch<NewVisitplanController>().filterexistCusDataList[i].U_Area}",
                                                                  style: theme
                                                                      .textTheme
                                                                      .bodyText1
                                                                      ?.copyWith(
                                                                          color:
                                                                              Colors.black),
                                                                ),
                                                              ),
                                                              Divider()
                                                            ],
                                                          ),
                                                        );
                                                      })),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: context
                                          .read<NewVisitplanController>()
                                          .citybool,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.01,
                                          ),
                                          context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .filterexistCusDataList
                                                  .isEmpty
                                              ? Container()
                                              : Container(

                                                  // color: Colors.amber,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color: theme
                                                              .primaryColor)),
                                                  width: Screens.width(context),
                                                  height: Screens.bodyheight(
                                                          context) *
                                                      0.2,
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .filterexistCusDataList
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int i) {
                                                        return InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              // context
                                                              //     .read<
                                                              //         NewVisitplanController>()
                                                              //     .getExicityData(context
                                                              //         .read<
                                                              //             NewVisitplanController>()
                                                              //         .filterexistCusDataList[
                                                              //             i]
                                                              //         .U_City
                                                              //         .toString());
                                                              context
                                                                  .read<
                                                                      NewVisitplanController>()
                                                                  .citybool = false;
                                                              context
                                                                      .read<
                                                                          NewVisitplanController>()
                                                                      .mycontroller[
                                                                          6]
                                                                      .text =
                                                                  context
                                                                      .read<
                                                                          NewVisitplanController>()
                                                                      .filterexistCusDataList[
                                                                          i]
                                                                      .U_City
                                                                      .toString();
                                                            });
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets.all(
                                                                    Screens.bodyheight(
                                                                            context) *
                                                                        0.008),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                // color: Colors.red,
                                                                height: Screens
                                                                        .bodyheight(
                                                                            context) *
                                                                    0.05,
                                                                width: Screens
                                                                    .width(
                                                                        context),
                                                                child: Text(
                                                                  "${context.watch<NewVisitplanController>().filterexistCusDataList[i].U_City}",
                                                                  style: theme
                                                                      .textTheme
                                                                      .bodyText1
                                                                      ?.copyWith(
                                                                          color:
                                                                              Colors.black),
                                                                ),
                                                              ),
                                                              Divider()
                                                            ],
                                                          ),
                                                        );
                                                      })),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: Screens.bodyheight(context) * 0.005,
                                    // ),
                                    Container(
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        Screens.width(context) *
                                                            0.4,
                                                    child: TextFormField(
                                                        controller: context
                                                            .read<
                                                                NewVisitplanController>()
                                                            .mycontroller[7],
                                                        onTap: () {
                                                          setState(() {
                                                            context
                                                                .read<
                                                                    NewVisitplanController>()
                                                                .clearbool();
                                                          });
                                                        },
                                                        // validator: (value) {
                                                        //   if (value!.isEmpty) {
                                                        //     return "Enter Pincode";
                                                        //   }
                                                        //   return null;
                                                        // },
                                                        onChanged: (v) {
                                                          setState(() {
                                                            context
                                                                .read<
                                                                    NewVisitplanController>()
                                                                .filterListPincode(
                                                                    v);
                                                            if (v.isEmpty) {
                                                              context
                                                                  .read<
                                                                      NewVisitplanController>()
                                                                  .pincodebool = false;
                                                            } else {
                                                              context
                                                                  .read<
                                                                      NewVisitplanController>()
                                                                  .pincodebool = true;
                                                            }
                                                          });
                                                        },
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly,
                                                          new LengthLimitingTextInputFormatter(
                                                              6),
                                                        ],
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: 'Pincode',
                                                          border:
                                                              UnderlineInputBorder(),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                            //  when the TextFormField in unfocused
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                            //  when the TextFormField in focused
                                                          ),
                                                          errorBorder:
                                                              UnderlineInputBorder(),
                                                          focusedErrorBorder:
                                                              UnderlineInputBorder(),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        Screens.width(context) *
                                                            0.4,
                                                    child: TextFormField(
                                                        controller: context
                                                            .read<
                                                                NewVisitplanController>()
                                                            .mycontroller[8],
                                                        focusNode: context
                                                            .read<
                                                                NewVisitplanController>()
                                                            .focusNode1,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .always,
                                                        onChanged: (v) {
                                                          setState(() {
                                                            context
                                                                .read<
                                                                    NewVisitplanController>()
                                                                .isText1Correct=false;
                                                            context
                                                                .read<
                                                                    NewVisitplanController>()
                                                                .filterListState2(
                                                                    v);
                                                            if (v.isEmpty) {
                                                              context
                                                                  .read<
                                                                      NewVisitplanController>()
                                                                  .statebool = false;
                                                            }
                                                            // else if(v.isNotEmpty&&context
                                                            //       .read<NewEnqController>()
                                                            //       .statecode.isEmpty){
                                                            //         log("ANBU");

                                                            //       }

                                                            else {
                                                              context
                                                                  .read<
                                                                      NewVisitplanController>()
                                                                  .methidstate(context
                                                                      .read<
                                                                          NewVisitplanController>()
                                                                      .mycontroller[
                                                                          8]
                                                                      .text,context);
                                                              context
                                                                  .read<
                                                                      NewVisitplanController>()
                                                                  .statebool = true;
                                                            }
                                                          });
                                                        },
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            // return "Enter State";
                                                          } else if (value
                                                                  .isNotEmpty &&
                                                              context
                                                                  .read<
                                                                      NewVisitplanController>()
                                                                  .statecode
                                                                  .isEmpty) {
                                                            context
                                                                .read<
                                                                    NewVisitplanController>()
                                                                .methidstate(context
                                                                    .read<
                                                                        NewVisitplanController>()
                                                                    .mycontroller[
                                                                        8]
                                                                    .text,context);
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(context
                                                                    .read<
                                                                        NewVisitplanController>()
                                                                    .focusNode1);
                                                            context
                                                                .read<
                                                                    NewVisitplanController>()
                                                                .statebool = false;
                                                            return "Enter Correct State";
                                                          }
                                                          return null;
                                                        },
                                                        onEditingComplete: () {
                                                          setState(() {
                                                            context
                                                                .read<
                                                                    NewVisitplanController>()
                                                                .statebool = false;
                                                            context
                                                                .read<
                                                                    NewVisitplanController>()
                                                                .focusNode1
                                                                .unfocus();
                                                            // context
                                                            //   .read<NewEnqController>()
                                                            //   .  methodfortest();
                                                            context
                                                                .read<
                                                                    NewVisitplanController>()
                                                                .methidstate(context
                                                                    .read<
                                                                        NewVisitplanController>()
                                                                    .mycontroller[
                                                                        8]
                                                                    .text,context);

                                                            // context
                                                            // .read<NewEnqController>()
                                                            // .statecode='';
                                                          });
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          labelText: 'State*',
                                                          border:
                                                              UnderlineInputBorder(),
                                                          // labelStyle: theme.textTheme.bodyText1!
                                                          //     .copyWith(color: Colors.grey),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                            //  when the TextFormField in unfocused
                                                          ),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                            //  when the TextFormField in focused
                                                          ),
                                                          errorBorder:
                                                              UnderlineInputBorder(),
                                                          focusedErrorBorder:
                                                              UnderlineInputBorder(),
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .isText1Correct ==
                                                      true
                                                  ? Container(
                                                      padding: EdgeInsets.only(
                                                          right: Screens.width(
                                                                  context) *
                                                              0.1,
                                                          top: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.001),
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        "Enter Correct State",
                                                        style: theme.textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 12),
                                                      ),
                                                    )
                                                  : Container(),
                                              TextFormField(
                                                  controller: context
                                                      .read<
                                                          NewVisitplanController>()
                                                      .mycontroller[16],
                                                      validator: (value) {
                                      if (value!.isNotEmpty) {
                                        if (value.length > 10 ||
                                            value.length < 10) {
                                          return "Enter a valid Mobile Number";
                                        }
                                      }
                                      return null;
                                    },
                                                  // validator: (value) {
                                                  //   if (value!.isEmpty) {
                                                  //     return "Enter Alternate Mobile No";
                                                  //   } else if (value.length > 10 || value.length < 10) {
                                                  //     return "Enter a valid Mobile Number";
                                                  //   }
                                                  //   return null;
                                                  // },
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    new LengthLimitingTextInputFormatter(
                                                        10),
                                                  ],
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        'Alternate Mobile No',
                                                    border:
                                                        UnderlineInputBorder(),
                                                    enabledBorder:
                                                        UnderlineInputBorder(),
                                                    focusedBorder:
                                                        UnderlineInputBorder(),
                                                    errorBorder:
                                                        UnderlineInputBorder(),
                                                    focusedErrorBorder:
                                                        UnderlineInputBorder(),
                                                  )),
                                              SizedBox(
                                                height: Screens.bodyheight(
                                                        context) *
                                                    0.01,
                                              ),
                                              TextFormField(
                                                  controller: context
                                                      .read<
                                                          NewVisitplanController>()
                                                      .mycontroller[17],
                                                  onTap: () {
                                                    if (context
                                                            .read<
                                                                NewVisitplanController>()
                                                            .mycontroller[8]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewVisitplanController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewVisitplanController>()
                                                            .mycontroller[8]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewVisitplanController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewVisitplanController>()
                                                            .statebool = false;
                                                      });
                                                    }
                                                  },
                                                  //  validator: (value) {
                                                  //   if (value!.isNotEmpty) {
                                                  //     //   // context.read<SalesQuotationCon>().ffff =
                                                  //     //   //     "Please Enter the Email Address";
                                                  //     //   return "Please Enter the Email Address";
                                                  //     if (!RegExp(
                                                  //             r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                                  //         .hasMatch(value.trim())) {
                                                  //       // context.read<NewEnqController>().ffff ="Please Enter the Valid Email";
                                                  //       return "Please Enter the Valid Email";
                                                  //     }
                                                  //   } else {
                                                  //     return null;
                                                  //   }
                                                  // },
                                                  decoration: InputDecoration(
                                                    labelText: 'Email',
                                                    border:
                                                        UnderlineInputBorder(),
                                                    enabledBorder:
                                                        UnderlineInputBorder(),
                                                    focusedBorder:
                                                        UnderlineInputBorder(),
                                                    errorBorder:
                                                        UnderlineInputBorder(),
                                                    focusedErrorBorder:
                                                        UnderlineInputBorder(),
                                                  )),
                                            ],
                                          ),
                                          Visibility(
                                            visible: context
                                                .read<NewVisitplanController>()
                                                .statebool,
                                            child: Positioned(
                                                top: Screens.bodyheight(
                                                        context) *
                                                    0.09,
                                                left: Screens.width(context) *
                                                    0.5,
                                                child: Container(
                                                  width:
                                                      Screens.width(context) *
                                                          0.8,
                                                  // height: Screens.bodyheight(context),
                                                  color: Colors.white,
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .filterstateData
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int i) {
                                                        return InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              context
                                                                  .read<
                                                                      NewVisitplanController>()
                                                                  .stateontap(
                                                                      i);
                                                            });
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets.all(
                                                                    Screens.bodyheight(
                                                                            context) *
                                                                        0.008),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                // color: Colors.red,
                                                                // height: Screens
                                                                //         .bodyheight(
                                                                //             context) *
                                                                //     0.05,
                                                                width: Screens
                                                                    .width(
                                                                        context),
                                                                child: Text(
                                                                  "${context.watch<NewVisitplanController>().filterstateData[i].stateName}",
                                                                  style: theme
                                                                      .textTheme
                                                                      .bodyText1
                                                                      ?.copyWith(
                                                                          color:
                                                                              theme.primaryColor),
                                                                ),
                                                              ),
                                                              Divider()
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: context
                                          .read<NewVisitplanController>()
                                          .pincodebool,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.01,
                                          ),
                                          context
                                                  .read<
                                                      NewVisitplanController>()
                                                  .filterexistCusDataList
                                                  .isEmpty
                                              ? Container()
                                              : Container(

                                                  // color: Colors.amber,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color: theme
                                                              .primaryColor)),
                                                  width: Screens.width(context),
                                                  height: Screens.bodyheight(
                                                          context) *
                                                      0.2,
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .filterexistCusDataList
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int i) {
                                                        return InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              context
                                                                  .read<
                                                                      NewVisitplanController>()
                                                                  .pincodebool = false;
                                                              // context
                                                              //     .read<
                                                              //         NewVisitplanController>()
                                                              //     .getExipincodeData(context
                                                              //         .read<
                                                              //             NewVisitplanController>()
                                                              //         .filterexistCusDataList[
                                                              //             i]
                                                              //         .U_Pincode
                                                              //         .toString());
                                                              context
                                                                      .read<
                                                                          NewVisitplanController>()
                                                                      .mycontroller[
                                                                          7]
                                                                      .text =
                                                                  context
                                                                      .read<
                                                                          NewVisitplanController>()
                                                                      .filterexistCusDataList[
                                                                          i]
                                                                      .U_Pincode
                                                                      .toString();
                                                            });
                                                          },
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets.all(
                                                                    Screens.bodyheight(
                                                                            context) *
                                                                        0.008),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                // color: Colors.red,
                                                                height: Screens
                                                                        .bodyheight(
                                                                            context) *
                                                                    0.05,
                                                                width: Screens
                                                                    .width(
                                                                        context),
                                                                child: Text(
                                                                  "${context.watch<NewVisitplanController>().filterexistCusDataList[i].U_Pincode}",
                                                                  style: theme
                                                                      .textTheme
                                                                      .bodyText1
                                                                      ?.copyWith(
                                                                          color:
                                                                              Colors.black),
                                                                ),
                                                              ),
                                                              Divider()
                                                            ],
                                                          ),
                                                        );
                                                      })),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: Screens.bodyheight(context) * 0.01,
                                    // ),

                                    //new

                                    // SizedBox(
                                    //   height: Screens.bodyheight(context) * 0.01,
                                    // ),
                                    SizedBox(
                                      height:
                                          Screens.bodyheight(context) * 0.02,
                                    ),
                                    Column(
                                      children: [
                                        Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              SizedBox(
                                                //  height: Screens.bodyheight(
                                                //                   context) *
                                                //               0.08,
                                                child: TextFormField(
                                                  onTap: () {
                                                    showDialog<dynamic>(
                                                        context: context,
                                                        builder: (_) {
                                                          return ShowSearchDialog();
                                                        }).then((value) {
                                                           context
                                                            .read<
                                                                NewVisitplanController>()
                                                            .setcatagorydata();    
                                                            });
                                                  },
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Enter Looking for";
                                                    }
                                                    return null;
                                                  },
                                                  // readOnly: true,
                                                  controller: context
                                                      .read<
                                                          NewVisitplanController>()
                                                      .mycontroller[18],
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    labelText: "Looking for",
                                                    hintText: "Looking for",
                                                    hintStyle: TextStyle(
                                                        color:
                                                            theme.primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    // labelStyle: TextStyle(
                                                    //     color:
                                                    //         theme.primaryColor,
                                                    //     fontWeight:
                                                    //         FontWeight.bold),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide: BorderSide(
                                                          color: theme
                                                              .primaryColor),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide: BorderSide(
                                                          color: theme
                                                              .primaryColor),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide: BorderSide(
                                                          color: theme
                                                              .primaryColor),
                                                    ),
                                                  ),
                                                  // cursorColor: Colors.green,
                                                ),
                                              ),
                                              Positioned(
                                                  top: 0,
                                                  left: Screens.width(context) *
                                                      0.74,
                                                  child: InkWell(
                                                      onTap: () {
                                                        showDialog<dynamic>(
                                                            context: context,
                                                            builder: (_) {
                                                              return ShowSearchDialog();
                                                            }).then((value) {
                                                           context
                                                            .read<
                                                                NewVisitplanController>()
                                                            .setcatagorydata();    
                                                            });
                                                      },
                                                      child: Container(
                                                          width: Screens.width(
                                                                  context) *
                                                              0.2,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 11,
                                                                  horizontal:
                                                                      10),
                                                          //  height: Screens.bodyheight(
                                                          //           context) *
                                                          //       0.08,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: theme
                                                                      .primaryColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            8),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            8),
                                                                  )),
                                                          child: Icon(
                                                              Icons.search))))
                                            ]),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.bodyheight(context) * 0.02,
                                    ),
                                    Column(
                                      children: [
                                        Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              SizedBox(
                                                child: TextFormField(
                                                  controller: context
                                                      .read<
                                                          NewVisitplanController>()
                                                      .mycontroller[9],
                                                  onTap: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .mycontroller[9]
                                                          .clear();
                                                      context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .clearbool();
                                                      showDialog<dynamic>(
                                                          context: context,
                                                          builder: (_) {
                                                            return VisitPlanShowDialog();
                                                          });
                                                    });
                                                  },
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Enter Purpose Of Visit";
                                                    }
                                                    return null;
                                                  },
                                                  // readOnly: true,
                                                  // controller: context
                                                  //     .read<NewEnqController>()
                                                  //     .mycontroller[7],
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 10),
                                                    hintText:
                                                        "Purpose Of Visit",
                                                    labelText:
                                                        "Purpose Of Visit",
                                                    hintStyle: TextStyle(
                                                        color:
                                                            theme.primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide: BorderSide(
                                                          color: theme
                                                              .primaryColor),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide: BorderSide(
                                                          color: theme
                                                              .primaryColor),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      borderSide: BorderSide(
                                                          color: theme
                                                              .primaryColor),
                                                    ),
                                                  ),
                                                  // cursorColor: Colors.green,
                                                ),
                                              ),
                                              Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  // bottom: 0,
                                                  // left: Screens.width(context) * 0.74,
                                                  child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          print(context
                                                              .read<
                                                                  NewVisitplanController>()
                                                              .filterpurposeofVisitList
                                                              .length);
                                                          context
                                                              .read<
                                                                  NewVisitplanController>()
                                                              .clearbool();
                                                          showDialog<dynamic>(
                                                              context: context,
                                                              builder: (_) {
                                                                return VisitPlanShowDialog();
                                                              });
                                                        });
                                                      },
                                                      child: Container(
                                                          width: Screens.width(
                                                                  context) *
                                                              0.2,
                                                          // height: Screens.bodyheight(context) *
                                                          //     0.065,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 11,
                                                                  horizontal:
                                                                      10),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: theme
                                                                      .primaryColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            8),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            8),
                                                                  )),
                                                          child: Icon(
                                                              Icons.search))))
                                            ]),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.bodyheight(context) * 0.02,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(vertical: Screens.padingHeight(context)*0.01,
                                                horizontal: Screens.width(context)*0.001
                                                ),
                                                decoration: BoxDecoration(
// color: Colors.amber,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.black26)),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(

                                                         child: Text("Recent Activities",
                                                         style: theme.textTheme.bodyText1!.copyWith(color: theme.primaryColor),
                                                         )
                                                        ),
                                        context
                                            .read<NewVisitplanController>()
                                            .viewleaddetails!
                                            .isEmpty &&   context
                                            .read<NewVisitplanController>()
                                            .viewenquirydetails!
                                            .isEmpty   ?Container():          Padding(
                                              padding:  EdgeInsets.only(
                                                right: Screens.width(context)*0.01
                                              ),
                                              child: InkWell(
                                                onTap: (){
                                              setState(() {
                                                 context
                                            .read<NewVisitplanController>()
                                            .  deletelist();
                                              });
                                               
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: theme.primaryColor.withOpacity(0.04),
                                                    borderRadius: BorderRadius.circular(5),
                                                    border: Border.all(color: Colors.black26)
                                                  ),
                                                          child:Icon(Icons.close,color: theme.primaryColor,)
                                                         ),
                                              ),
                                            )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: Screens.padingHeight(context)*0.01,
                                                    ),
                                                   
                                            
                                            context.read<NewVisitplanController>().purposecode != '05' 
            &&
                    context.read<NewVisitplanController>().purposecode != '06'||context.read<NewVisitplanController>().purposecode==null
                ? Center(
                    child: Container(
                      child: Text('No Data..!!'),
                    ),
                  )
                :
                                        context
                                            .read<NewVisitplanController>()
                                            .viewleaddetails!
                                            .isEmpty &&      context
                                            .read<NewVisitplanController>()
                                            .viewenquirydetails!
                                            .isEmpty
                                        ? Container(  child: Center(child: Text('No Data..!!')),)
                                        :context
                                            .read<NewVisitplanController>()
                                            .viewenquirydetails!
                                            .isNotEmpty ?Container(
                                            // height: 100,
                                            width: Screens.width(context),

                                            
                                            child: ListView.builder(
                                                itemCount: context
                                                    .read<
                                                        NewVisitplanController>()
                                                    .viewenquirydetails!
                                                    .length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    child: Container(
                                                      width: Screens.width(
                                                          context),
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal:
                                                              Screens.width(
                                                                      context) *
                                                                  0.02,
                                                          vertical: Screens
                                                                  .bodyheight(
                                                                      context) *
                                                              0.01),
                                                      child: Container(
                                                        // color: Colors.grey[200],
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                Screens.width(
                                                                        context) *
                                                                    0.02,
                                                            vertical: Screens
                                                                    .bodyheight(
                                                                        context) *
                                                                0.01),
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[200],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black26)
                                                            // border: Border(bottom: BorderSide(color: Colors.black38))
                                                            ),
                                                        width: Screens.width(
                                                            context),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      0.4,
                                                                  child: Text(
                                                                    "Customer",
                                                                    style: theme
                                                                        .textTheme
                                                                        .bodyText2
                                                                        ?.copyWith(
                                                                            color:
                                                                                Colors.grey),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      0.4,
                                                                  child: Text(
                                                                    "Date",
                                                                    style: theme
                                                                        .textTheme
                                                                        .bodyText2
                                                                        ?.copyWith(
                                                                            color:
                                                                                Colors.grey),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      0.4,
                                                                  child: Text(
                                                                      // "AAA",
                                                                      "${context.watch<NewVisitplanController>().customerdetails![0].customerName}",
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodyText2
                                                                          ?.copyWith(
                                                                        color: theme
                                                                            .primaryColor,
                                                                        // fontWeight: FontWeight.bold
                                                                      )),
                                                                ),
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      0.4,
                                                                  child: Text(
                                                                      // "Anb",
                                                                      context
                                                                          .watch<
                                                                              NewVisitplanController>()
                                                                          .config
                                                                          .alignDate(
                                                                              "${context.watch<NewVisitplanController>().viewenquirydetails![index].DocDate}"),
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodyText2
                                                                          ?.copyWith(
                                                                        color: theme
                                                                            .primaryColor,
                                                                        //fontWeight: FontWeight.bold
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: Screens
                                                                      .bodyheight(
                                                                          context) *
                                                                  0.01,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      0.4,
                                                                  child: Text(
                                                                    "Store",
                                                                    style: theme
                                                                        .textTheme
                                                                        .bodyText2
                                                                        ?.copyWith(
                                                                            color:
                                                                                Colors.grey),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      0.4,
                                                                  child: Text(
                                                                    "Potential Value",
                                                                    style: theme
                                                                        .textTheme
                                                                        .bodyText2
                                                                        ?.copyWith(
                                                                            color:
                                                                                Colors.grey),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      0.5,
                                                                  child: Text(
                                                                      // "Looking for ",
                                                                      " ${context.watch<NewVisitplanController>().viewenquirydetails![index].Store}",
                                                                      // ",
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodyText2
                                                                          ?.copyWith(
                                                                        color: theme
                                                                            .primaryColor,
                                                                        //fontWeight: FontWeight.bold
                                                                      )),
                                                                ),
                                                                Container(
                                                                  //color:Colors.red,
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      0.3,
                                                                  child: Text(
                                                                      // "777",
                                                                      // context.watch<NewVisitplanController>().config.slpitCurrency(
                                                                      //   context.watch<NewVisitplanController>().getopenEnqData[i].PotentialValue!.toStringAsFixed(0)
                                                                      // ),
                                                                      "₹ ${context.watch<NewVisitplanController>().viewenquirydetails![index].BusinessValue}",
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodyText2
                                                                          ?.copyWith(
                                                                        color: theme
                                                                            .primaryColor,
                                                                        //fontWeight: FontWeight.bold
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: Screens
                                                                      .bodyheight(
                                                                          context) *
                                                                  0.01,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  //color: Colors.red,
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      0.54,
                                                                  child: Text(
                                                                      // "ANb",

                                                                      "Call assigned to ${context.watch<NewVisitplanController>().viewenquirydetails![index].AssignedTo}",
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodyText2
                                                                          ?.copyWith(
                                                                        color: Colors
                                                                            .grey,
                                                                        // fontWeight: FontWeight.bold
                                                                      )),
                                                                ),
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  // color: Colors.green[200],
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      0.3,
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: Screens.width(
                                                                              context) *
                                                                          0.02,
                                                                      right: Screens.width(
                                                                              context) *
                                                                          0.02,
                                                                    ),
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.green[
                                                                            200],
                                                                        borderRadius:
                                                                            BorderRadius.circular(4)),
                                                                    // width: Screens.width(context) * 0.1,
                                                                    child: Text(
                                                                        // "uuuu",
                                                                        "${context.watch<NewVisitplanController>().viewenquirydetails![index].CurrentStatus}",
                                                                        style: theme.textTheme.bodyText2?.copyWith(
                                                                            color:
                                                                                Colors.green[700],
                                                                            fontSize: 12
                                                                            // fontWeight: FontWeight.bold
                                                                            )),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: Screens
                                                                      .bodyheight(
                                                                          context) *
                                                                  0.01,
                                                            ),

                                                            //new Row
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    left: Screens.width(
                                                                            context) *
                                                                        0.02,
                                                                    right: Screens.width(
                                                                            context) *
                                                                        0.02,
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                              .orange[
                                                                          100],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4)),
                                                                  // width: Screens.width(context) * 0.1,
                                                                  child: Text(
                                                                      // "aaaaa",
                                                                      "${context.watch<NewVisitplanController>().customerdetails![0].customerGroup}",
                                                                      style: theme.textTheme.bodyText2?.copyWith(
                                                                          color: Colors
                                                                              .grey,
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w500)),
                                                                ),
                                                                // context
                                                                //             .watch<NewVisitplanController>()
                                                                //             .viewenquirydetails![index]
                                                                //             .isVisitRequired !=
                                                                //         "Y"
                                                                //     ? Container()
                                                                //     : Container(
                                                                //         // color: Colors.amber,
                                                                //         alignment:
                                                                //             Alignment.centerRight,
                                                                //         width: Screens.width(context) *
                                                                //             0.5,
                                                                //         child: Text(
                                                                //             // "Aaaaa",
                                                                //             "Site Visit on\t${context.watch<NewVisitplanController>().config.alignDate(context.watch<NewVisitplanController>().viewenquirydetails![index].visitTime.toString())}",
                                                                //             style: theme.textTheme.bodyText2?.copyWith(fontSize: 12, color: Colors.grey, fontStyle: FontStyle.italic

                                                                //                 // fontWeight: FontWeight.bold
                                                                //                 )),
                                                                //       )
                                                              ],
                                                            ),
                                                            // Container(
                                                            //     padding: EdgeInsets.symmetric(
                                                            //         horizontal: Screens.width(context) * 0.1),
                                                            //     child: Divider(
                                                            //       thickness: 1,
                                                            //     ))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          )
                                           
                                            :Container(
                                              width:Screens.width(context),
                                              child:ListView.builder(
                                                shrinkWrap: true,
                        itemCount: context.read<NewVisitplanController>().viewleaddetails!.length,
                        itemBuilder: (BuildContext context, int i) {
                          return InkWell(
                    //         onTap: () {

                    //            Navigator.pop(context);
                    // context.read<NewVisitplanController>() . callleaddetails( context.read<NewVisitplanController>().leaddetails![i],context);
                   
                    //             },
                           
                            child: Container(
                              width: Screens.width(context),
                              padding: EdgeInsets.symmetric(
                                  horizontal: Screens.width(context) * 0.02,
                                  vertical:
                                      Screens.bodyheight(context) * 0.006),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.02,
                                        vertical: Screens.bodyheight(context) *
                                            0.006),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(color: Colors.black26)
                                        // border: Border(bottom: BorderSide(color: Colors.black38))
                                        ),
                                    width: Screens.width(context),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "Customer",
                                                style:
                                                    theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                "",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                  "${context.read<NewVisitplanController>().customerdetails![0].customerName}", //  "${context.watch<EnquiryUserContoller>().getopenEnqData[i].CardName}",
                                                  style: theme.textTheme.bodyText2
                                                      ?.copyWith(
                                                    color:theme.primaryColor,
                                                    // fontWeight: FontWeight.bold
                                                  )),
                                            ),
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  //context
                                                  // leadOpenAllData[i].DocDate!.isEmpty?'':
                                                  //  context.read<NewVisitplanController>().config.alignDate(
                                                  "#${context.read<NewVisitplanController>().viewleaddetails![i].DocNum}",
                                                  //),//         // .watch<EnquiryUserContoller>()
                                                  // .config
                                                  // .alignDate(
                                                  //     "${context.watch<EnquiryUserContoller>().getopenEnqData[i].EnqDate}"),
                                                  style: theme.textTheme.bodyText2
                                                      ?.copyWith(
                                                    color: theme.primaryColor,
                                                    //fontWeight: FontWeight.bold
                                                  )),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Screens.bodyheight(context) *
                                              0.01,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: Screens.width(context),
                                              child: Text(
                                                "Store",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              width: Screens.width(context),
                                              // color: Colors.red,
                                              child: Text(
                                                  "${context.read<NewVisitplanController>().leaddetails![i].Store}",
                                                  style: theme.textTheme.bodyText2
                                                  //?.copyWith(color: Colors.grey),
                                                  ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Screens.bodyheight(context) *
                                              0.01,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              // color: Colors.red,
                                              child: Text(
                                                  "Next Follow up", //  "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[i].Lookingfor}",
                                                  style: theme.textTheme.bodyText2
                                                      ?.copyWith(
                                                          //color:theme.primaryColor,
                                                          //fontWeight: FontWeight.bold
                                                          color: Colors.grey)),
                                            ),
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              //color: Colors.red,
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  "Order Value", //  "₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                                  style: theme.textTheme.bodyText2
                                                      ?.copyWith(
                                                          //color:theme.primaryColor,
                                                          //fontWeight: FontWeight.bold
                                                          color: Colors.grey)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: Text(
                                                  context.watch<NewVisitplanController>().viewleaddetails![i].DocDate!.isEmpty
                                                      ? ''
                                                      : context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .config
                                                          .alignDate(
                                                              "${context.watch<NewVisitplanController>().viewleaddetails![i].DocDate}"), //  "Looking for ${context.watch<EnquiryUserContoller>().getopenEnqData[i].Lookingfor}",
                                                  style: theme.textTheme.bodyText2
                                                      ?.copyWith(
                                                          //color:theme.primaryColor,
                                                          //fontWeight: FontWeight.bold
                                                          )),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                var format =
                                                    NumberFormat.currency(
                                                  name: "INR",
                                                  locale: 'en_IN',
                                                  decimalDigits:
                                                      0, // change it to get decimal places
                                                  symbol: '₹ ',
                                                );
                                                String formattedCurrency =
                                                    format.format(30000);
                                                print(formattedCurrency);
                                              },
                                              child: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: Screens.width(context) *
                                                    0.4,
                                                child: Text(
                                                    context.watch<NewVisitplanController>().viewleaddetails![i]
                                                                .BusinessValue ==
                                                            -1
                                                        ? ""
                                                        : context
                                                            .read<
                                                                NewVisitplanController>()
                                                            .config
                                                            .slpitCurrency(context.watch<NewVisitplanController>().viewleaddetails![i].BusinessValue!
                                                                .toStringAsFixed(
                                                                    0)), //  "₹ ${context.watch<EnquiryUserContoller>().getopenEnqData[i].PotentialValue}",
                                                    style: theme
                                                        .textTheme.bodyText2
                                                        ?.copyWith(
                                                            //color:theme.primaryColor,
                                                            //fontWeight: FontWeight.bold
                                                            )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Screens.bodyheight(context) *
                                              0.01,
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          width: Screens.width(context),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  left: Screens.width(context) *
                                                      0.02,
                                                  right:
                                                      Screens.width(context) *
                                                          0.02,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.green[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                child: Text(
                                                    context.watch<NewVisitplanController>().viewleaddetails![i].CurrentStatus!
                                                            .isEmpty
                                                        ? ''
                                                        : "${context.watch<NewVisitplanController>().viewleaddetails![i].CurrentStatus}",
                                                    style: theme
                                                        .textTheme.bodyText2
                                                        ?.copyWith(
                                                      //color:theme.primaryColor,
                                                      color: Colors.green[700],
                                                      // fontWeight: FontWeight.bold
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: Screens.bodyheight(context) *
                                              0.01,
                                        ),

                                        Container(
                                          // color: Colors.green[200],
                                          alignment: Alignment.centerLeft,
                                          width: Screens.width(context),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Text(
                                              context.watch<NewVisitplanController>().viewleaddetails![i].DocDate!.isEmpty
                                                    ? ''
                                                    : "Last Updated: " +
                                                        context
                                                            .watch<
                                                                NewVisitplanController>()
                                                            .config
                                                            .subtractDateTime(
                                                                "${context.watch<NewVisitplanController>().viewleaddetails![i].DocDate!}"), //     "${context.watch<EnquiryUserContoller>().getopenEnqData[i].Status}",
                                                style: theme.textTheme.bodyText2
                                                    ?.copyWith(
                                                  color: Colors.grey,
                                                  // color: Colors.green[700],
                                                  // fontWeight: FontWeight.bold
                                                )),
                                          ),
                                        )

                                        // Container(
                                        //     padding: EdgeInsets.symmetric(
                                        //         horizontal: Screens.width(context) * 0.1),
                                        //     child: Divider(
                                        //       thickness: 1,
                                        //     ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                                            )

                                            
                                              
                                                  ],
                                                ),
                                              ),
                                              // Positioned(
                                              //     top: 0,
                                              //     left: Screens.width(context) * 0.74,
                                              //     child: InkWell(
                                              //         onTap: () {
                                              //           setState(() {
                                              //             print(context
                                              //                 .read<NewVisitplanController>()
                                              //                 .filterpurposeofVisitList
                                              //                 .length);
                                              //             context
                                              //                 .read<NewVisitplanController>()
                                              //                 .clearbool();
                                              //             showDialog<dynamic>(
                                              //                 context: context,
                                              //                 builder: (_) {
                                              //                   return VisitPlanShowDialog();
                                              //                 });
                                              //           });
                                              //         },
                                              //         child: Container(
                                              //             width: Screens.width(context) * 0.2,
                                              //             height: Screens.bodyheight(context) *
                                              //                 0.065,
                                              //             decoration: BoxDecoration(
                                              //                 color: theme.primaryColor,
                                              //                 borderRadius: BorderRadius.only(
                                              //                   topRight: Radius.circular(8),
                                              //                   bottomRight: Radius.circular(8),
                                              //                 )),
                                              //             child: Icon(Icons.search))))
                                            ]),
                                   
                                   
                                   
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.padingHeight(context) * 0.01,
                                    ),
                                   
                                   
                                    // Column(
                                    //   children: [
                                    //     Stack(children: [
                                    //       SizedBox(
                                    //         child: TextFormField(
                                    //           onTap: () {
                                    //             // showDialog<dynamic>(
                                    //             //     context: context,
                                    //             //     builder: (_) {
                                    //             //       return EnqAssignUserDialog();
                                    //             //     });
                                    //           },
                                    //           validator: (value) {
                                    //             if (value!.isEmpty) {
                                    //               return "Enter Assigned To";
                                    //             }
                                    //             return null;
                                    //           },
                                    //           // readOnly: true,
                                    //           // controller: context
                                    //           //     .read<NewEnqController>()
                                    //           //     .mycontroller[8],
                                    //           readOnly: true,
                                    //           decoration: InputDecoration(
                                    //             contentPadding: EdgeInsets.symmetric(
                                    //                 vertical: 10, horizontal: 10),
                                    //             labelText: "Assigned To:",
                                    //             labelStyle: TextStyle(
                                    //                 color: theme.primaryColor,
                                    //                 fontWeight: FontWeight.bold),
                                    //             border: OutlineInputBorder(
                                    //               borderRadius: BorderRadius.circular(8),
                                    //               borderSide:
                                    //                   BorderSide(color: theme.primaryColor),
                                    //             ),
                                    //             enabledBorder: OutlineInputBorder(
                                    //               borderRadius: BorderRadius.circular(8),
                                    //               borderSide:
                                    //                   BorderSide(color: theme.primaryColor),
                                    //             ),
                                    //             focusedBorder: OutlineInputBorder(
                                    //               borderRadius: BorderRadius.circular(8),
                                    //               borderSide:
                                    //                   BorderSide(color: theme.primaryColor),
                                    //             ),
                                    //           ),
                                    //           // cursorColor: Colors.green,
                                    //         ),
                                    //       ),
                                    //       Positioned(
                                    //           top: 0,
                                    //           left: Screens.width(context) * 0.74,
                                    //           child: InkWell(
                                    //               onTap: () {
                                    //                 // showDialog<dynamic>(
                                    //                 //     context: context,
                                    //                 //     builder: (_) {
                                    //                 //       return EnqAssignUserDialog();
                                    //                 //     });
                                    //               },
                                    //               child: Container(
                                    //                   width: Screens.width(context) * 0.2,
                                    //                   height: Screens.bodyheight(context) *
                                    //                       0.079,
                                    //                   decoration: BoxDecoration(
                                    //                       color: theme.primaryColor,
                                    //                       borderRadius: BorderRadius.only(
                                    //                         topRight: Radius.circular(8),
                                    //                         bottomRight: Radius.circular(8),
                                    //                       )),
                                    //                   child: Icon(Icons.search))))
                                    //     ]),
                                    //   ],
                                    // ),
                                    SizedBox(
                                      height:
                                          Screens.bodyheight(context) * 0.015,
                                    ),
                                    Container(
                                      width: Screens.width(context),
                                      // height: Screens.bodyheight(context) * 0.15,
                                      decoration: BoxDecoration(
                                          color: theme.primaryColor,
                                          //  border: Border.all(color: theme.primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              Screens.width(context) * 0.02,
                                          vertical:
                                              Screens.bodyheight(context) *
                                                  0.02),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.topLeft,
                                            // color: Colors.amber,
                                            // height: Screens.bodyheight(context) * 0.05,
                                            child: Text(
                                              "Meeting Time*",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(
                                                      color:  Colors.white),
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 
                                                // context
                                                //             .read<
                                                //                 NewVisitplanController>()
                                                //             .Datebool ==
                                                //         false
                                                    // ?
                                                     Screens.bodyheight(
                                                            context) *
                                                        0.06,
                                                    // : null,
                                                // height: Screens.width(context) * 0.06,
                                                width: Screens.width(context) *
                                                    0.5,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.grey
                                                      .withOpacity(0.01),
                                                ),
                                                // child: GestureDetector(
                                                //   onTap: () {
                                                //     st(() {
                                                //       posC.getDate(context, 'Cheque');
                                                //     });
                                                //   },
                                                child: TextFormField(
                                                  controller: context
                                                      .read<
                                                          NewVisitplanController>()
                                                      .mycontroller[10],
                                                  // decoration: InputDecoration(
                                                  //   filled:
                                                  //       true, //<-- SEE HERE
                                                  //   fillColor: Colors
                                                  //       .white, //<-- SEE HERE
                                                  // ),
                                                  onTap: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .clearbool();
                                                      context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .getDate(context);
                                                    });
                                                  },
                                                  autofocus: true,
                                                  readOnly: true,
                                                  // controller: posC.mycontroller[24],
                                                  cursorColor: Colors.grey,
                                                  style: theme
                                                      .textTheme.bodyText2
                                                      ?.copyWith(
                                                          backgroundColor:
                                                              Colors.white),
                                                  onChanged: (v) {},
                                                  // validator: (value) {
                                                  //   if (value!.isEmpty &&
                                                  //       context
                                                  //               .read<
                                                  //                   NewVisitplanController>()
                                                  //               .Datebool ==
                                                  //           false) {
                                                  //     setState(() {
                                                  //       context
                                                  //           .read<
                                                  //               NewVisitplanController>()
                                                  //           .Datebool = true;
                                                  //     });

                                                  //     return 'Please Enter Date';
                                                  //   } else if (value
                                                  //       .isNotEmpty) {
                                                  //     setState(() {
                                                  //       context
                                                  //           .read<
                                                  //               NewVisitplanController>()
                                                  //           .Datebool = false;
                                                  //     });

                                                  //     return null;
                                                  //   }
                                                  // },
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    suffixIcon: IconButton(
                                                        padding: EdgeInsets.only(
                                                            top: Screens
                                                                    .bodyheight(
                                                                        context) *
                                                                0.002),
                                                        onPressed: () {
                                                          context
                                                              .read<
                                                                  NewVisitplanController>()
                                                              .getDate(context);
                                                        },
                                                        icon: Icon(
                                                          Icons.date_range,
                                                          color: theme
                                                              .primaryColor,
                                                        )),
                                                    filled: true,
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide: BorderSide(
                                                          color: Colors.red),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide: BorderSide(
                                                          color: Colors.red),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      vertical: 11,
                                                      horizontal: 10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 
                                                // context
                                                //             .read<
                                                //                 NewVisitplanController>()
                                                //             .timebool ==
                                                //         false
                                                //     ?
                                                     Screens.bodyheight(
                                                            context) *
                                                        0.06,
                                                    // : null,
                                                // height: cashHeight * 0.2,
                                                width: Screens.width(context) *
                                                    0.37,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  // color: Colors.grey
                                                  //     .withOpacity(0.01),
                                                ),
                                                // child: GestureDetector(
                                                //   onTap: () {
                                                //     st(() {
                                                //       posC.getDate(context, 'Cheque');
                                                //     });
                                                //   },
                                                child: TextFormField(
                                                  controller: context
                                                      .read<
                                                          NewVisitplanController>()
                                                      .mycontroller[11],

                                                  onTap: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .clearbool();
                                                      context
                                                          .read<
                                                              NewVisitplanController>()
                                                          .selectTime(context);
                                                    });
                                                  },
                                                  autofocus: true,
                                                  readOnly: true,
                                                  // controller: posC.mycontroller[24],
                                                  cursorColor: Colors.grey,
                                                  style: theme
                                                      .textTheme.bodyText2
                                                      ?.copyWith(
                                                          backgroundColor:
                                                              Colors.white),
                                                  onChanged: (v) {},
                                                  // validator: (value) {
                                                  //   if (value!.isEmpty &&
                                                  //       context
                                                  //               .read<
                                                  //                   NewVisitplanController>()
                                                  //               .timebool ==
                                                  //           false) {
                                                  //     setState(() {
                                                  //       context
                                                  //           .read<
                                                  //               NewVisitplanController>()
                                                  //           .timebool = true;
                                                  //     });

                                                  //     return '  Please Enter the Time';
                                                  //   } else if (value
                                                  //       .isNotEmpty) {
                                                  //     setState(() {
                                                  //       context
                                                  //           .read<
                                                  //               NewVisitplanController>()
                                                  //           .timebool = false;
                                                  //     });

                                                  //     return null;
                                                  //   }
                                                  // },
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    suffixIcon: IconButton(
                                                        padding: EdgeInsets.only(
                                                            top: Screens
                                                                    .bodyheight(
                                                                        context) *
                                                                0.002),
                                                        onPressed: () {
                                                          setState(() {
                                                            context
                                                                .read<
                                                                    NewVisitplanController>()
                                                                .selectTime(
                                                                    context);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.timer,
                                                          color: theme
                                                              .primaryColor,
                                                        )),
                                                    filled: true,
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide: BorderSide(
                                                          color: Colors.red),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide: BorderSide(
                                                          color: Colors.red),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                    ),
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      vertical: 11,
                                                      horizontal: 10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // SizedBox(
                                          //   height:context
                                          //       .read<NewEnqController>()
                                          //       .isSwitched ==
                                          //           true
                                          //       ? Screens.bodyheight(context) *
                                          //           0.02
                                          //       : Screens.bodyheight(context) *
                                          //           0.04,
                                          // ),
                                          // Center(
                                          //   child: Wrap(
                                          //       spacing: 20.0, // width
                                          //       runSpacing: 20.0, // height
                                          //       children:
                                          //           listContainersRefferes(
                                          //         theme,
                                          //       )),
                                          // )
                                    //       SizedBox(
                                    //   height:
                                    //       Screens.bodyheight(context) * 0.01,
                                    // ),
                                    //       Stack(
                                    //           clipBehavior: Clip.none,
                                    //           children: [
                                    //             SizedBox(
                                    //               // height: Screens.bodyheight(
                                    //               //                   context) *
                                    //               //               0.08,
                                    //               child: TextFormField(
                                    //                 onTap: () {
                                    //                   // context
                                    //                   //   .read<NewEnqController>().setUserdata();
                                    //                   showDialog<dynamic>(
                                    //                       context: context,
                                    //                       builder: (_) {
                                    //                         return EnqAssignUserDialog();
                                    //                       }).then((value) {
                                    //                     context
                                    //                         .read<
                                    //                             NewVisitplanController>()
                                    //                         .setUserdata();
                                    //                   });
                                    //                 },
                                    //                 validator: (value) {
                                    //                   if (value!.isEmpty) {
                                    //                     return "Enter Assigned To";
                                    //                   }
                                    //                   return null;
                                    //                 },
                                    //                 // readOnly: true,
                                    //                 controller: context
                                    //                     .read<NewVisitplanController>()
                                    //                     .mycontroller[19],
                                    //                 readOnly: true,
                                    //                 decoration: InputDecoration(
                                    //                   contentPadding:
                                    //                       EdgeInsets.symmetric(
                                    //                           vertical: 10,
                                    //                           horizontal: 10),
                                    //                   labelText: "Assigned To:",
                                    //                   labelStyle: TextStyle(
                                    //                       color:
                                    //                           theme.primaryColor,
                                    //                       fontWeight:
                                    //                           FontWeight.bold),
                                    //                   border: OutlineInputBorder(
                                    //                     borderRadius:
                                    //                         BorderRadius.circular(
                                    //                             8),
                                    //                     borderSide: BorderSide(
                                    //                         color: theme
                                    //                             .primaryColor),
                                    //                   ),
                                    //                   enabledBorder:
                                    //                       OutlineInputBorder(
                                    //                     borderRadius:
                                    //                         BorderRadius.circular(
                                    //                             8),
                                    //                     borderSide: BorderSide(
                                    //                         color: theme
                                    //                             .primaryColor),
                                    //                   ),
                                    //                   focusedBorder:
                                    //                       OutlineInputBorder(
                                    //                     borderRadius:
                                    //                         BorderRadius.circular(
                                    //                             8),
                                    //                     borderSide: BorderSide(
                                    //                         color: theme
                                    //                             .primaryColor),
                                    //                   ),
                                    //                 ),
                                    //                 // cursorColor: Colors.green,
                                    //               ),
                                    //             ),
                                    //             Positioned(
                                    //                 top: 0,
                                    //                 left: Screens.width(context) *
                                    //                     0.70,
                                    //                 child: InkWell(
                                    //                     onTap: () {
                                    //                       showDialog<dynamic>(
                                    //                           context: context,
                                    //                           builder: (_) {
                                    //                             return EnqAssignUserDialog();
                                    //                           });
                                    //                     },
                                    //                     child: Container(
                                    //                         width: Screens.width(
                                    //                                 context) *
                                    //                             0.2,
                                    //                         padding: EdgeInsets
                                    //                             .symmetric(
                                    //                                 vertical: 11,
                                    //                                 horizontal:
                                    //                                     10),
                                    //                         // height: Screens.bodyheight(
                                    //                         //         context) *
                                    //                         //     0.08,
                                    //                         decoration:
                                    //                             BoxDecoration(
                                    //                                 color: theme
                                    //                                     .primaryColor,
                                    //                                 borderRadius:
                                    //                                     BorderRadius
                                    //                                         .only(
                                    //                                   topRight: Radius
                                    //                                       .circular(
                                    //                                           8),
                                    //                                   bottomRight:
                                    //                                       Radius.circular(
                                    //                                           8),
                                    //                                 )),
                                    //                         child: Icon(
                                    //                             Icons.search))))
                                    //           ]),



                                        ],
                                      ),
                                    ),
                                 context
                                            .watch<NewVisitplanController>()
                                            .   islodingtime==false?
                                            Container():Container(
                                              alignment: Alignment.centerLeft,
                                              child:Text("Choose Meeting Time*",
                                              style:TextStyle(color: Colors.red)
                                              )
                                            ),
                                    context
                                            .read<NewVisitplanController>()
                                            .errorTime
                                            .isEmpty
                                        ? Container()
                                        : Container(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.1,
                                            width:
                                                Screens.width(context) * 0.95,
                                            child: Text(
                                              "${context.watch<NewVisitplanController>().errorTime}",
                                              style: theme.textTheme.bodyText1!
                                                  .copyWith(color: Colors.red),
                                            ),
                                          ),
                                    // Text(
                                    //       "${context.watch<NewVisitplanController>().errorTime}")
                                    // SizedBox(
                                    //   height: Screens.bodyheight(context) * 0.02,
                                    // ),

                                    //new
                                    // SizedBox(
                                    //   height: Screens.bodyheight(context) * 0.01,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            //
                            SizedBox(
                              width: Screens.width(context),
                              height: Screens.bodyheight(context) * 0.07,
                              child: ElevatedButton(
                                  onPressed: context
                                              .watch<NewVisitplanController>()
                                              .isloding ==
                                          true
                                      ? null
                                      : () {
                                          setState(() {
                                            context
                                                .read<NewVisitplanController>()
                                                .validateSchedule(context);
                                          });

                                          // context
                                          //     .read<NewEnqController>()
                                          //     .callAddEnq(context);
                                          // context.read<NewEnqController>().callAlertDialog(context, "Successfully Created..!!");
                                        },
                                  child: context
                                              .watch<NewVisitplanController>()
                                              .isloding ==
                                          true
                                      ? SizedBox(
                                        height: Screens.padingHeight(context)*0.06,
                                        width: Screens.width(context)*0.05,
                                        child: CircularProgressIndicator(
                                            color: Colors.white,),
                                      )
                                      : Text("Schedule Visit")),
                            )
                          ],
                        ),
                      ),
          ),
        ));
  }
}
