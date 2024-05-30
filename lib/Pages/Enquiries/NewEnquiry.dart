// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, sort_child_properties_last, unrelated_type_equality_checks

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Controller/EnquiryController/NewEnqController.dart';
import '../../Constant/Screen.dart';
import '../../Constant/ShowSearchDialog.dart';
import '../../Constant/padings.dart';
import '../../Widgets/Appbar.dart';
import '../../Widgets/Navi3.dart';
import 'EnquiriesUser/Widgets/EnqAssingUser.dart';

class NewEnquiry extends StatefulWidget {
  NewEnquiry({Key? key}) : super(key: key);

  @override
  State<NewEnquiry> createState() => NewEnquiryState();
}

class NewEnquiryState extends State<NewEnquiry> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  static bool iscomfromLead = false;
  // FocusNode _focusNode1 = FocusNode();

  @override
  void initState() {
    // _focusNode1.addListener(() {
    //   if (!_focusNode1.hasFocus) {
    //     // Check if the entered text is correct (replace with your own logic)
    //     setState(() {
    //    context
    //                                                 .read<NewEnqController>()
    //                                                 .isText1Correct    = context
    //                                                 .read<NewEnqController>()
    //                                                 .mycontroller[12].text == context
    //                                                 .read<NewEnqController>()
    //                                                 .statecode;
    //     });
    //   }
    // });
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
          context.read<NewEnqController>().clearAllData();
        log("  iscomfromLead;"+  iscomfromLead.toString());
        if (iscomfromLead == false) {
          log("ANBU222::");
          context.read<NewEnqController>().clearAllData();
          context.read<NewEnqController>().customerapicalled = false;
          context.read<NewEnqController>().init();
        } else if (iscomfromLead == true) {
          log("ANBU::");
          context.read<NewEnqController>().clearAllData();

          context.read<NewEnqController>().mapValuesFormAcc();

          iscomfromLead = false;
        }
      });
    });
  }
   DateTime? currentBackPressTime;
  
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("object");
      Get.offAllNamed(ConstantRoutes.enquiriesUser);
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
      child: Scaffold(
          drawerEnableOpenDragGesture: false,
          resizeToAvoidBottomInset: false,
          key: scaffoldKey,
          drawer: drawer3(context),
          appBar: appbar("New Enquiry", scaffoldKey, theme, context),
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
                  Get.offAllNamed(ConstantRoutes.enquiriesUser);
                });
              }
            },
            child: (context
                        .read<NewEnqController>()
                        .getexceptionOnApiCall
                        .isEmpty &&
                    context.watch<NewEnqController>().getcustomerapicLoading ==
                        true)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : (context
                            .read<NewEnqController>()
                            .getexceptionOnApiCall
                            .isNotEmpty &&
                        context
                                .watch<NewEnqController>()
                                .getcustomerapicLoading ==
                            false)
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              context
                                  .read<NewEnqController>()
                                  .getexceptionOnApiCall,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      )
                    : Container(
                        padding: paddings.padding2(context),
                        child: Form(
                          key: context.read<NewEnqController>().formkey,
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
                                              .read<NewEnqController>()
                                              .focusNode2,
                                          controller: context
                                              .read<NewEnqController>()
                                              .mycontroller[0],
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter Mobile Number";
                                            } else if (value.length > 10 ||
                                                value.length < 10) {
                                              return "Enter a valid Mobile Number";
                                            }
                                            return null;
                                          },
                                          onChanged: (v) {
                                            if (v.length == 10 &&
                                                context
                                                        .read<NewEnqController>()
                                                        .getcustomerapicalled ==
                                                    false) {
                                              context
                                                  .read<NewEnqController>()
                                                  .callApi(context);
                                            } else if (v.length != 10) {
                                              context
                                                  .read<NewEnqController>()
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
                                            // hintText: 'aa',
                                            labelText: 'Mobile*',
                                            border: UnderlineInputBorder(),
                                            enabledBorder: UnderlineInputBorder(),
                                            focusedBorder: UnderlineInputBorder(),
                                            errorBorder: UnderlineInputBorder(),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(),
                                          )),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      //tags
                                      Center(
                                        child: Wrap(
                                            spacing: 5.0, // width
                                            runSpacing: 10.0, // height
                                            children: listContainersCustomerTag(
                                              theme,
                                            )),
                                      ),
                                      TextFormField(
                                          controller: context
                                              .read<NewEnqController>()
                                              .mycontroller[1],
                                          onTap: () {
                                            if (context
                                                    .read<NewEnqController>()
                                                    .mycontroller[12]
                                                    .text
                                                    .isNotEmpty &&
                                                context
                                                    .read<NewEnqController>()
                                                    .statecode
                                                    .isEmpty) {
                                              context
                                                  .read<NewEnqController>()
                                                  .ontapvalid(context);
                                            } else if (context
                                                    .read<NewEnqController>()
                                                    .mycontroller[12]
                                                    .text
                                                    .isNotEmpty &&
                                                context
                                                    .read<NewEnqController>()
                                                    .statecode
                                                    .isNotEmpty) {
                                              setState(() {
                                                context
                                                    .read<NewEnqController>()
                                                    .statebool = false;
                                              });
                                            }
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter Customer";
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            // hintText: 'Customer',
                                            labelText: 'Customer*',
                                            border: UnderlineInputBorder(),
                                            enabledBorder: UnderlineInputBorder(),
                                            focusedBorder: UnderlineInputBorder(),
                                            errorBorder: UnderlineInputBorder(),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(),
                                          )),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      TextFormField(
                                          controller: context
                                              .read<NewEnqController>()
                                              .mycontroller[10],
                                          onTap: () {
                                            if (context
                                                    .read<NewEnqController>()
                                                    .mycontroller[12]
                                                    .text
                                                    .isNotEmpty &&
                                                context
                                                    .read<NewEnqController>()
                                                    .statecode
                                                    .isEmpty) {
                                              context
                                                  .read<NewEnqController>()
                                                  .ontapvalid(context);
                                            } else if (context
                                                    .read<NewEnqController>()
                                                    .mycontroller[12]
                                                    .text
                                                    .isNotEmpty &&
                                                context
                                                    .read<NewEnqController>()
                                                    .statecode
                                                    .isNotEmpty) {
                                              setState(() {
                                                context
                                                    .read<NewEnqController>()
                                                    .statebool = false;
                                              });
                                            }
                                          },
                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return "Enter Contact Name";
                                          //   }
                                          //   return null;
                                          // },
                                          decoration: InputDecoration(
                                            // hintText: 'Contact Name (optional)',
                                            labelText: 'Contact Name (optional)',
                                            border: UnderlineInputBorder(),
                                            enabledBorder: UnderlineInputBorder(),
                                            focusedBorder: UnderlineInputBorder(),
                                            errorBorder: UnderlineInputBorder(),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(),
                                          )),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      TextFormField(
                                          controller: context
                                              .read<NewEnqController>()
                                              .mycontroller[2],
                                          onTap: () {
                                            if (context
                                                    .read<NewEnqController>()
                                                    .mycontroller[12]
                                                    .text
                                                    .isNotEmpty &&
                                                context
                                                    .read<NewEnqController>()
                                                    .statecode
                                                    .isEmpty) {
                                              context
                                                  .read<NewEnqController>()
                                                  .ontapvalid(context);
                                            } else if (context
                                                    .read<NewEnqController>()
                                                    .mycontroller[12]
                                                    .text
                                                    .isNotEmpty &&
                                                context
                                                    .read<NewEnqController>()
                                                    .statecode
                                                    .isNotEmpty) {
                                              setState(() {
                                                context
                                                    .read<NewEnqController>()
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
                                            // hintText: 'Address1',
                                            labelText: 'Address1',
                                            border: UnderlineInputBorder(),
                                            enabledBorder: UnderlineInputBorder(),
                                            focusedBorder: UnderlineInputBorder(),
                                            errorBorder: UnderlineInputBorder(),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(),
                                          )),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      TextFormField(
                                          controller: context
                                              .read<NewEnqController>()
                                              .mycontroller[3],
                                          onTap: () {
                                            if (context
                                                    .read<NewEnqController>()
                                                    .mycontroller[12]
                                                    .text
                                                    .isNotEmpty &&
                                                context
                                                    .read<NewEnqController>()
                                                    .statecode
                                                    .isEmpty) {
                                              context
                                                  .read<NewEnqController>()
                                                  .ontapvalid(context);
                                            } else if (context
                                                    .read<NewEnqController>()
                                                    .mycontroller[12]
                                                    .text
                                                    .isNotEmpty &&
                                                context
                                                    .read<NewEnqController>()
                                                    .statecode
                                                    .isNotEmpty) {
                                              setState(() {
                                                context
                                                    .read<NewEnqController>()
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
                                            // hintText: 'Address2',
                                            labelText: 'Address2',
                                      
                                            border: UnderlineInputBorder(),
                                            enabledBorder: UnderlineInputBorder(),
                                            focusedBorder: UnderlineInputBorder(),
                                            errorBorder: UnderlineInputBorder(),
                                            focusedErrorBorder:
                                                UnderlineInputBorder(),
                                          )),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: Screens.width(context) * 0.4,
                                            child: TextFormField(
                                                controller: context
                                                    .read<NewEnqController>()
                                                    .mycontroller[11],
                                                onTap: () {
                                                  if (context
                                                          .read<
                                                              NewEnqController>()
                                                          .mycontroller[12]
                                                          .text
                                                          .isNotEmpty &&
                                                      context
                                                          .read<
                                                              NewEnqController>()
                                                          .statecode
                                                          .isEmpty) {
                                                    context
                                                        .read<NewEnqController>()
                                                        .ontapvalid(context);
                                                  } else if (context
                                                          .read<
                                                              NewEnqController>()
                                                          .mycontroller[12]
                                                          .text
                                                          .isNotEmpty &&
                                                      context
                                                          .read<
                                                              NewEnqController>()
                                                          .statecode
                                                          .isNotEmpty) {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewEnqController>()
                                                          .statebool = false;
                                                    });
                                                  }
                                                },
                                                // validator: (value) {
                                                //   if (value!.isEmpty) {
                                                //     return "Enter City";
                                                //   }
                                                //   return null;
                                                // },
                                                decoration: InputDecoration(
                                                  // hintText: 'Area',
                                                  labelText: 'Area',
                                                  border: UnderlineInputBorder(),
                                                  enabledBorder:
                                                      UnderlineInputBorder(),
                                                  focusedBorder:
                                                      UnderlineInputBorder(),
                                                  errorBorder:
                                                      UnderlineInputBorder(),
                                                  focusedErrorBorder:
                                                      UnderlineInputBorder(),
                                                )),
                                          ),
                                          //
                                          SizedBox(
                                            width: Screens.width(context) * 0.4,
                                            child: TextFormField(
                                                controller: context
                                                    .read<NewEnqController>()
                                                    .mycontroller[5],
                                                onTap: () {
                                                  if (context
                                                          .read<
                                                              NewEnqController>()
                                                          .mycontroller[12]
                                                          .text
                                                          .isNotEmpty &&
                                                      context
                                                          .read<
                                                              NewEnqController>()
                                                          .statecode
                                                          .isEmpty) {
                                                    context
                                                        .read<NewEnqController>()
                                                        .ontapvalid(context);
                                                  } else if (context
                                                          .read<
                                                              NewEnqController>()
                                                          .mycontroller[12]
                                                          .text
                                                          .isNotEmpty &&
                                                      context
                                                          .read<
                                                              NewEnqController>()
                                                          .statecode
                                                          .isNotEmpty) {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewEnqController>()
                                                          .statebool = false;
                                                    });
                                                  }
                                                },
                                                // validator: (value) {
                                                //   if (value!.isEmpty) {
                                                //     return "Enter City";
                                                //   }
                                                //   return null;
                                                // },
                                                decoration: InputDecoration(
                                                  // hintText: 'City',
                                                  labelText: 'City',
                                                  border: UnderlineInputBorder(),
                                                  enabledBorder:
                                                      UnderlineInputBorder(),
                                                  focusedBorder:
                                                      UnderlineInputBorder(),
                                                  errorBorder:
                                                      UnderlineInputBorder(),
                                                  focusedErrorBorder:
                                                      UnderlineInputBorder(),
                                                )),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
    
                                      Container(
                                          child: Stack(
                                        children: [
                                          Column(children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: Screens.width(context) *
                                                      0.4,
                                                  child: TextFormField(
                                                      controller: context
                                                          .read<
                                                              NewEnqController>()
                                                          .mycontroller[4],
                                                      // validator: (value) {
                                                      //   if (value!.isEmpty) {
                                                      //     return "Enter Pincode";
                                                      //   }
                                                      //   return null;
                                                      // },
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                        new LengthLimitingTextInputFormatter(
                                                            6),
                                                      ],
                                                      decoration: InputDecoration(
                                                        // hintText: 'Pincode',
                                                        labelText: 'Pincode',
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
                                                ),
                                                //
                                                SizedBox(
                                                  width: Screens.width(context) *
                                                      0.4,
                                                  child: TextFormField(
                                                      controller: context
                                                          .read<
                                                              NewEnqController>()
                                                          .mycontroller[12],
                                                      // autocorrect: true,
                                                      focusNode: context
                                                          .read<
                                                              NewEnqController>()
                                                          .focusNode1,
                                                      autovalidateMode:
                                                          AutovalidateMode.always,
                                                      onChanged: (v) {
                                                        setState(() {
                                                        context
                                                                .read<
                                                                    NewEnqController>()
                                                                .  isText1Correct = false;
                                                          context
                                                              .read<
                                                                  NewEnqController>()
                                                              .filterListState2(
                                                                  v);
                                                          if (v.isEmpty) {
                                                            context
                                                                .read<
                                                                    NewEnqController>()
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
                                                                    NewEnqController>()
                                                                .methidstate(context
                                                                    .read<
                                                                        NewEnqController>()
                                                                    .mycontroller[
                                                                        12]
                                                                    .text);
                                                            context
                                                                .read<
                                                                    NewEnqController>()
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
                                                                    NewEnqController>()
                                                                .statecode
                                                                .isEmpty) {
                                                          context
                                                              .read<
                                                                  NewEnqController>()
                                                              .methidstate(context
                                                                  .read<
                                                                      NewEnqController>()
                                                                  .mycontroller[
                                                                      12]
                                                                  .text);
                                                          FocusScope.of(context)
                                                              .requestFocus(context
                                                                  .read<
                                                                      NewEnqController>()
                                                                  .focusNode1);
                                                          context
                                                              .read<
                                                                  NewEnqController>()
                                                              .statebool = false;
                                                          return "Enter Correct State";
                                                        }
                                                        return null;
                                                      },
                                                      onEditingComplete: () {
                                                        setState(() {
                                                          context
                                                              .read<
                                                                  NewEnqController>()
                                                              .statebool = false;
                                                          context
                                                              .read<
                                                                  NewEnqController>()
                                                              .focusNode1
                                                              .unfocus();
                                                          // context
                                                          //   .read<NewEnqController>()
                                                          //   .  methodfortest();
                                                          context
                                                              .read<
                                                                  NewEnqController>()
                                                              .methidstate(context
                                                                  .read<
                                                                      NewEnqController>()
                                                                  .mycontroller[
                                                                      12]
                                                                  .text);
                                                  
                                                          // context
                                                          // .read<NewEnqController>()
                                                          // .statecode='';
                                                        });
                                                      },
                                                      decoration: InputDecoration(
                                                        // hintText: 'State',
                                                        labelText: 'State*',
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
                                                ),
                                              ],
                                            ),
                                            context
                                                        .read<NewEnqController>()
                                                        .isText1Correct ==
                                                    true
                                                ? Container(
                                                    padding: EdgeInsets.only(
                                                        right: Screens.width(
                                                                context) *
                                                            0.1,
                                                        top: Screens.padingHeight(
                                                                context) *
                                                            0.001),
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      "Enter Correct State",
                                                      style: theme
                                                          .textTheme.bodyText2!
                                                          .copyWith(
                                                              color: Colors.red,
                                                              fontSize: 12),
                                                    ),
                                                  )
                                                : Container(),
                                            SizedBox(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                            ),
                                            SizedBox(
                                              width: Screens.width(context),
                                              child: TextFormField(
                                                  controller: context
                                                      .read<NewEnqController>()
                                                      .mycontroller[13],
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
                                                  //   }
                                                  //   return null;
                                                  // },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                    new LengthLimitingTextInputFormatter(
                                                        10),
                                                  ],
                                                  decoration: InputDecoration(
                                                    // hintText:
                                                    //     'Alternate Mobile No',
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
                                            ),
                                            //new
                                            SizedBox(
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                            ),
                                            TextFormField(
                                                controller: context
                                                    .read<NewEnqController>()
                                                    .mycontroller[6],
                                                onTap: () {
                                                  if (context
                                                          .read<
                                                              NewEnqController>()
                                                          .mycontroller[12]
                                                          .text
                                                          .isNotEmpty &&
                                                      context
                                                          .read<
                                                              NewEnqController>()
                                                          .statecode
                                                          .isEmpty) {
                                                    context
                                                        .read<NewEnqController>()
                                                        .ontapvalid(context);
                                                  } else if (context
                                                          .read<
                                                              NewEnqController>()
                                                          .mycontroller[12]
                                                          .text
                                                          .isNotEmpty &&
                                                      context
                                                          .read<
                                                              NewEnqController>()
                                                          .statecode
                                                          .isNotEmpty) {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewEnqController>()
                                                          .statebool = false;
                                                    });
                                                  }
                                                },
                                                // validator: (value) {
                                                //   //   // context.read<SalesQuotationCon>().ffff =
                                                //   //   //     "Please Enter the Email Address";
                                                //   //   return "Please Enter the Email Address";
                                                //   if (!RegExp(
                                                //           r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                                //       .hasMatch(value!.trim())) {
                                                //     // context.read<NewEnqController>().ffff ="Please Enter the Valid Email";
                                                //     return "Please Enter the Valid Email";
                                                //   }
                                                //   // } else {
                                                //   //   return null;
                                                //   // }
                                                // },
                                                decoration: InputDecoration(
                                                  // hintText: 'Email',
                                                  labelText: 'Email',
                                                  border: UnderlineInputBorder(),
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
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                            ),
                                            TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: context
                                                    .read<NewEnqController>()
                                                    .mycontroller[9],
                                                decoration: InputDecoration(
                                                  // hintText: 'Potential Value',
                                                  labelText: 'Potential Value',
                                                  border: UnderlineInputBorder(),
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
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.001,
                                            ),
                                            Container(
                                              height:
                                                  Screens.padingHeight(context) *
                                                      0.1,
                                              child: DropdownButtonFormField(
                                                decoration: InputDecoration(
                                                  // hintText: 'Email',
                                                  labelText: 'Level of Interest',
                                                  border: UnderlineInputBorder(),
                                                  enabledBorder:
                                                      UnderlineInputBorder(),
                                                  focusedBorder:
                                                      UnderlineInputBorder(),
                                                  errorBorder:
                                                      UnderlineInputBorder(),
                                                  focusedErrorBorder:
                                                      UnderlineInputBorder(),
                                                ),
                                                // hint: Text(
                                                //   context
                                                //       .watch<NewEnqController>()
                                                //       .gethinttextforOpenLead!,
                                                //   style: theme.textTheme.bodyText2?.copyWith(
                                                //       color: context
                                                //               .watch<NewEnqController>()
                                                //               .gethinttextforOpenLead!
                                                //               .contains(" *")
                                                //           ? Colors.red
                                                //           : Colors.black),
                                                // ),
                                                value: context
                                                    .read<NewEnqController>()
                                                    .valueChosedStatus,
                                                //dropdownColor:Colors.green,
                                                icon: Icon(Icons.arrow_drop_down),
                                                iconSize: 30,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                                isExpanded: true,
                                                onChanged: (val) {
                                                  setState(() {
                                                    context
                                                        .read<NewEnqController>()
                                                        .choosedStatus(
                                                            val.toString());
                                                  });
                                                },
                                                items: context
                                                    .read<NewEnqController>()
                                                    .leveofdata
                                                    .map((e) {
                                                  return DropdownMenuItem(
                                                      // ignore: unnecessary_brace_in_string_interps
                                                      value: "${e.Code}",
                                                      child: Container(
                                                          // height: Screens.bodyheight(context)*0.1,
                                                          child:
                                                              Text("${e.Name}")));
                                                }).toList(),
                                              ),
                                            ),
                                            Container(
                                              height:
                                                  Screens.padingHeight(context) *
                                                      0.1,
                                              child: DropdownButtonFormField(
                                                decoration: InputDecoration(
                                                  // hintText: 'Email',
                                                  labelText: 'Order Type',
                                                  border: UnderlineInputBorder(),
                                                  enabledBorder:
                                                      UnderlineInputBorder(),
                                                  focusedBorder:
                                                      UnderlineInputBorder(),
                                                  errorBorder:
                                                      UnderlineInputBorder(),
                                                  focusedErrorBorder:
                                                      UnderlineInputBorder(),
                                                ),
                                                // hint: Text(
                                                //   context
                                                //       .watch<NewEnqController>()
                                                //       .gethinttextforOpenLead!,
                                                //   style: theme.textTheme.bodyText2?.copyWith(
                                                //       color: context
                                                //               .watch<NewEnqController>()
                                                //               .gethinttextforOpenLead!
                                                //               .contains(" *")
                                                //           ? Colors.red
                                                //           : Colors.black),
                                                // ),
                                                value: context
                                                    .read<NewEnqController>()
                                                    .valueChosedCusType,
                                                //dropdownColor:Colors.green,
                                                icon: Icon(Icons.arrow_drop_down),
                                                iconSize: 30,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                                isExpanded: true,
                                                onChanged: (val) {
                                                  setState(() {
                                                    context
                                                        .read<NewEnqController>()
                                                        .choosedType(
                                                            val.toString());
                                                  });
                                                },
                                                items: context
                                                    .read<NewEnqController>()
                                                    .ordertypedata
                                                    .map((e) {
                                                  return DropdownMenuItem(
                                                      // ignore: unnecessary_brace_in_string_interps
                                                      value: "${e.Code}",
                                                      child: Container(
                                                          // height: Screens.bodyheight(context)*0.1,
                                                          child:
                                                              Text("${e.Name}")));
                                                }).toList(),
                                              ),
                                            ),
                                          ]),
                                          Visibility(
                                            visible: context
                                                .read<NewEnqController>()
                                                .statebool,
                                            child: Positioned(
                                                top: Screens.bodyheight(context) *
                                                    0.09,
                                                left:
                                                    Screens.width(context) * 0.5,
                                                child: Container(
                                                  width: Screens.width(context) *
                                                      0.8,
                                                  // height: Screens.bodyheight(context),
                                                  color: Colors.white,
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: context
                                                          .read<
                                                              NewEnqController>()
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
                                                                      NewEnqController>()
                                                                  .stateontap(i);
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
                                                                width:
                                                                    Screens.width(
                                                                        context),
                                                                child: Text(
                                                                  "${context.watch<NewEnqController>().filterstateData[i].stateName}",
                                                                  style: theme
                                                                      .textTheme
                                                                      .bodyText1
                                                                      ?.copyWith(
                                                                          color: theme
                                                                              .primaryColor),
                                                                ),
                                                              ),
                                                              Divider()
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                )),
                                          )
                                        ],
                                      )),
    
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
                                                                NewEnqController>()
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
                                                        .read<NewEnqController>()
                                                        .mycontroller[7],
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal: 10),
                                                      labelText: "Looking for:*",
                                                      labelStyle: TextStyle(
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
                                                                  NewEnqController>()
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
                                                  // height: Screens.bodyheight(
                                                  //                   context) *
                                                  //               0.08,
                                                  child: TextFormField(
                                                    onTap: () {
                                                      // context
                                                      //   .read<NewEnqController>().setUserdata();
                                                      showDialog<dynamic>(
                                                          context: context,
                                                          builder: (_) {
                                                            return EnqAssignUserDialog();
                                                          }).then((value) {
                                                        context
                                                            .read<
                                                                NewEnqController>()
                                                            .setUserdata();
                                                      });
                                                    },
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Enter Assigned To";
                                                      }
                                                      return null;
                                                    },
                                                    // readOnly: true,
                                                    controller: context
                                                        .read<NewEnqController>()
                                                        .mycontroller[8],
                                                    readOnly: true,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10,
                                                              horizontal: 10),
                                                      labelText: "Assigned To:",
                                                      labelStyle: TextStyle(
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
                                                    left: Screens.width(context) *
                                                        0.74,
                                                    child: InkWell(
                                                        onTap: () {
                                                          showDialog<dynamic>(
                                                              context: context,
                                                              builder: (_) {
                                                                return EnqAssignUserDialog();
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
                                                            // height: Screens.bodyheight(
                                                            //         context) *
                                                            //     0.08,
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
                                      TextFormField(
                                        minLines: 6,
                                        controller: context
                                            .read<NewEnqController>()
                                            .mycontroller[21],
                                        maxLines: null,
                                        keyboardType: TextInputType.multiline,
                                        validator: (value) {
                                          if (value!.trim() == "") {
                                            return "Enter Feedback..";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            top: Screens.bodyheight(context) *
                                                0.04,
                                            left: Screens.bodyheight(context) *
                                                0.01,
                                          ),
                                          alignLabelWithHint: true,
                                          // border: OutlineInputBorder(),
                                          hintText: 'Feedback*',
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.02,
                                      ),
                                      Container(
                                        width: Screens.width(context),
                                        height: context
                                                    .watch<NewEnqController>()
                                                    .getenqReffList
                                                    .length >
                                                2
                                            ? Screens.bodyheight(context) * 0.31
                                            : Screens.bodyheight(context) * 0.15,
                                        decoration: BoxDecoration(
                                            color: theme.primaryColor,
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
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Refferal",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(color: Colors.white),
                                            ),
                                            SizedBox(
                                                height:
                                                    Screens.bodyheight(context) *
                                                        0.01),
    
                                            Expanded(
                                              child: GridView.count(
                                                shrinkWrap: true,
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 12.0,
                                                mainAxisSpacing: 12.0,
                                                childAspectRatio: 4.0,
                                                children: listContainersRefferes(
                                                  theme,
                                                ),
                                              ),
                                            ),
                                            // Center(
                                            //   child: Wrap(
                                            //       spacing: 20.0, // width
                                            //       runSpacing: 20.0, // height
                                            //       children:
                                            //           listContainersRefferes(
                                            //         theme,
                                            //       )),
                                            // )
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: context
                                            .read<NewEnqController>()
                                            .getvisibleRefferal,
                                        child: Row(
                                          children: [
                                            Text(
                                              "Required Enquiry Refferal*",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.02,
                                      ),
    
                                      //new
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: Screens.width(context),
                                            height: context
                                                        .watch<NewEnqController>()
                                                        .getEnqList
                                                        .length >
                                                    2
                                                ? Screens.bodyheight(context) *
                                                    0.31
                                                : Screens.bodyheight(context) *
                                                    0.15,
                                            decoration: BoxDecoration(
                                                color: theme.primaryColor,
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
                                                Text(
                                                  "Enquiry Type",
                                                  style: theme.textTheme.bodyText1
                                                      ?.copyWith(
                                                          color: Colors.white),
                                                ),
                                                SizedBox(
                                                    height: Screens.bodyheight(
                                                            context) *
                                                        0.01),
                                                Expanded(
                                                  child: GridView.count(
                                                      shrinkWrap: true,
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 12.0,
                                                      mainAxisSpacing: 12.0,
                                                      childAspectRatio: 4.0,
                                                      children:
                                                          listContainersProduct(
                                                        theme,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Visibility(
                                        visible: context
                                            .read<NewEnqController>()
                                            .getvisibleEnqType,
                                        child: Row(
                                          children: [
                                            Text(
                                              "Required Enquiry Type*",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.02,
                                      ),
                                      Container(
                                        width: Screens.width(context),
    
                                        // height:Screens.bodyheight(context)*0.28 ,
                                        decoration: BoxDecoration(
                                            color: theme.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                Screens.width(context) * 0.02,
                                            vertical:
                                                Screens.bodyheight(context) *
                                                    0.01),
    
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // color: Colors.amber,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Required SiteVisit",
                                                    style: theme
                                                        .textTheme.bodyText1
                                                        ?.copyWith(
                                                            color: Colors.white),
                                                  ),
                                                  Checkbox(
                                                      checkColor:
                                                          theme.primaryColor,
                                                      activeColor: Colors.white,
                                                      side: BorderSide(
                                                          color: Colors.white),
                                                      value: context
                                                          .read<
                                                              NewEnqController>()
                                                          .sitevisitreq,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          context
                                                              .read<
                                                                  NewEnqController>()
                                                              .checksitevisit(
                                                                  value!);
                                                        });
                                                      }),
                                                ],
                                              ),
                                            ),
    
                                            //time date
    
                                            context
                                                        .read<NewEnqController>()
                                                        .sitevisitreq ==
                                                    false
                                                ? Container()
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: context
                                                                    .read<
                                                                        NewEnqController>()
                                                                    .visitDatebool ==
                                                                false
                                                            ? Screens.bodyheight(
                                                                    context) *
                                                                0.06
                                                            : null,
                                                        // height: cashHeight * 0.2,
                                                        width: Screens.width(
                                                                context) *
                                                            0.5,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
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
                                                                  NewEnqController>()
                                                              .mycontroller[14],
                                                          // decoration: InputDecoration(
                                                          //   filled:
                                                          //       true, //<-- SEE HERE
                                                          //   fillColor: Colors
                                                          //       .white, //<-- SEE HERE
                                                          // ),
                                                          onTap: () {
                                                            setState(() {
                                                              // context
                                                              //     .read<NewEnqController>()
                                                              //     .clearbool();
                                                              context
                                                                  .read<
                                                                      NewEnqController>()
                                                                  .getDate(
                                                                      context);
                                                            });
                                                          },
                                                          autofocus: true,
                                                          readOnly: true,
                                                          // controller: posC.mycontroller[24],
                                                          cursorColor:
                                                              Colors.grey,
                                                          style: theme
                                                              .textTheme.bodyText2
                                                              ?.copyWith(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white),
                                                          onChanged: (v) {},
                                                          validator: (value) {
                                                            if (value!.isEmpty &&
                                                                context
                                                                        .read<
                                                                            NewEnqController>()
                                                                        .visitDatebool ==
                                                                    false) {
                                                              setState(() {
                                                                context
                                                                    .read<
                                                                        NewEnqController>()
                                                                    .visitDatebool = true;
                                                              });
    
                                                              return 'Please Enter Date';
                                                            } else if (value
                                                                .isNotEmpty) {
                                                              setState(() {
                                                                context
                                                                    .read<
                                                                        NewEnqController>()
                                                                    .visitDatebool = false;
                                                              });
    
                                                              return null;
                                                            }
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            fillColor:
                                                                Colors.white,
                                                            suffixIcon:
                                                                IconButton(
                                                                    padding: EdgeInsets.only(
                                                                        top: Screens.bodyheight(
                                                                                context) *
                                                                            0.002),
                                                                    onPressed:
                                                                        () {
                                                                      context
                                                                          .read<
                                                                              NewEnqController>()
                                                                          .getDate(
                                                                              context);
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .date_range,
                                                                      color: theme
                                                                          .primaryColor,
                                                                    )),
                                                            filled: true,
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .red),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .red),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .grey),
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
                                                        height: context
                                                                    .read<
                                                                        NewEnqController>()
                                                                    .visittimebool ==
                                                                false
                                                            ? Screens.bodyheight(
                                                                    context) *
                                                                0.06
                                                            : null,
                                                        // height: cashHeight * 0.2,
                                                        width: Screens.width(
                                                                context) *
                                                            0.37,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
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
                                                                  NewEnqController>()
                                                              .mycontroller[15],
    
                                                          onTap: () {
                                                            setState(() {
                                                              // context
                                                              //     .read<NewEnqController>()
                                                              //     .clearbool();
                                                              context
                                                                  .read<
                                                                      NewEnqController>()
                                                                  .selectTime(
                                                                      context);
                                                            });
                                                          },
                                                          autofocus: true,
                                                          readOnly: true,
                                                          // controller: posC.mycontroller[24],
                                                          cursorColor:
                                                              Colors.grey,
                                                          style: theme
                                                              .textTheme.bodyText2
                                                              ?.copyWith(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white),
                                                          onChanged: (v) {},
                                                          validator: (value) {
                                                            if (value!.isEmpty &&
                                                                context
                                                                        .read<
                                                                            NewEnqController>()
                                                                        .visittimebool ==
                                                                    false) {
                                                              setState(() {
                                                                context
                                                                    .read<
                                                                        NewEnqController>()
                                                                    .visittimebool = true;
                                                              });
    
                                                              return 'Enter the Time';
                                                            } else if (value
                                                                .isNotEmpty) {
                                                              setState(() {
                                                                context
                                                                    .read<
                                                                        NewEnqController>()
                                                                    .visittimebool = false;
                                                              });
    
                                                              return null;
                                                            }
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            fillColor:
                                                                Colors.white,
                                                            suffixIcon:
                                                                IconButton(
                                                                    padding: EdgeInsets.only(
                                                                        top: Screens.bodyheight(
                                                                                context) *
                                                                            0.002),
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        context
                                                                            .read<
                                                                                NewEnqController>()
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
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .red),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .red),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .grey),
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
    
                                            SizedBox(
                                              height: context
                                                          .read<
                                                              NewEnqController>()
                                                          .sitevisitreq ==
                                                      false
                                                  ? Screens.padingHeight(
                                                          context) *
                                                      0.01
                                                  : Screens.padingHeight(
                                                          context) *
                                                      0.01,
                                            ),
                                          
                                            context
                                                        .read<NewEnqController>()
                                                        .istimevalid ==
                                                    false &&context
                                                        .watch<NewEnqController>()
                                                        . errorTime ==""
                                                ? Container()
                                                : Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      "${context.read<NewEnqController>().errorTime}",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                            //Reminder
                                            Text(
                                              "Reminder On*",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(color: Colors.white),
                                            ),
    
                                            SizedBox(
                                              height:
                                                  Screens.padingHeight(context) *
                                                      0.01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  height: context
                                                              .read<
                                                                  NewEnqController>()
                                                              .reminderDatebool ==
                                                          false
                                                      ? Screens.bodyheight(
                                                              context) *
                                                          0.06
                                                      : null,
                                                  // height: cashHeight * 0.2,
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
                                                        .read<NewEnqController>()
                                                        .mycontroller[16],
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
                                                                NewEnqController>()
                                                            .clearbool2();
                                                        context
                                                            .read<
                                                                NewEnqController>()
                                                            .getDate2(context);
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
                                                    validator: context
                                                                .read<
                                                                    NewEnqController>()
                                                                .mycontroller[16]
                                                                .text
                                                                .isEmpty &&
                                                            context
                                                                .read<
                                                                    NewEnqController>()
                                                                .mycontroller[17]
                                                                .text
                                                                .isEmpty
                                                        ? null
                                                        : (value) {
                                                            if (value!.isEmpty &&
                                                                context
                                                                        .read<
                                                                            NewEnqController>()
                                                                        .reminderDatebool ==
                                                                    false) {
                                                              setState(() {
                                                                context
                                                                    .read<
                                                                        NewEnqController>()
                                                                    .reminderDatebool = true;
                                                              });
    
                                                              return 'Please Enter Date';
                                                            } else if (value
                                                                .isNotEmpty) {
                                                              setState(() {
                                                                context
                                                                    .read<
                                                                        NewEnqController>()
                                                                    .reminderDatebool = false;
                                                              });
    
                                                              return null;
                                                            }
                                                          },
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
                                                                    NewEnqController>()
                                                                .getDate2(
                                                                    context);
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
                                                  height: Screens.bodyheight(
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
                                                        .read<NewEnqController>()
                                                        .mycontroller[17],
    
                                                    onTap: () {
                                                      setState(() {
                                                        // context
                                                        //     .read<
                                                        //         NewEnqController>()
                                                        //     .clearbool2();
                                                        context
                                                            .read<
                                                                NewEnqController>()
                                                            .selectTime2(context);
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
                                                    // validator: context
                                                    //             .read<
                                                    //                 NewEnqController>()
                                                    //             .mycontroller[16]
                                                    //             .text
                                                    //             .isEmpty &&
                                                    //         context
                                                    //             .read<
                                                    //                 NewEnqController>()
                                                    //             .mycontroller[17]
                                                    //             .text
                                                    //             .isEmpty
                                                    //     ? null
                                                    //     : (value) {
                                                    //         if (value!.isEmpty &&
                                                    //             context
                                                    //                     .read<
                                                    //                         NewEnqController>()
                                                    //                     .remindertimebool ==
                                                    //                 false) {
                                                    //           setState(() {
                                                    //             context
                                                    //                 .read<
                                                    //                     NewEnqController>()
                                                    //                 .remindertimebool = true;
                                                    //           });
    
                                                    //           return 'Enter the Time';
                                                    //         } else if (value
                                                    //             .isNotEmpty) {
                                                    //           setState(() {
                                                    //             context
                                                    //                 .read<
                                                    //                     NewEnqController>()
                                                    //                 .remindertimebool = false;
                                                    //           });
    
                                                    //           return null;
                                                    //         }
                                                    //       },
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
                                                                      NewEnqController>()
                                                                  .selectTime2(
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
    
                                            SizedBox(
                                              height:
                                                  Screens.padingHeight(context) *
                                                      0.01,
                                            ),
                                            
                                          context
                                                        .read<NewEnqController>()
                                                        .checkretime ==
                                                    false &&context
                                                        .watch<NewEnqController>()
                                                        .errorTime2 ==''
                                                ? Container()
                                                : Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      "${context
                                                        .watch<NewEnqController>()
                                                        .errorTime2}",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                          
                                            context
                                                        .read<NewEnqController>()
                                                        .checkdata ==
                                                    false
                                                ? Container()
                                                : Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "choose less then Visit Date",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible: context
                                            .read<NewEnqController>()
                                            .getvisibleremainder,
                                        child: Row(
                                          children: [
                                            Text(
                                              "${context.read<NewEnqController>().isremaider}",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                      ),
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
                                                .watch<NewEnqController>()
                                                .getisloadingBtn ==
                                            true
                                        ? null
                                        : () {
                                            context
                                                .read<NewEnqController>()
                                                .callAddEnq(context);
                                            // context.read<NewEnqController>().callAlertDialog(context, "Successfully Created..!!");
                                          },
                                    child: context
                                                .watch<NewEnqController>()
                                                .getisloadingBtn ==
                                            true
                                        ? SizedBox(
                                            width: Screens.width(context) * 0.06,
                                            height: Screens.bodyheight(context) *
                                                0.04,
                                            child: CircularProgressIndicator(
                                                color: Colors.white))
                                        : Text("Add Enquiry")),
                              )
                            ],
                          ),
                        ),
                      ),
          )),
    );
  }

  List<Widget> listContainersProduct(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<NewEnqController>().getEnqList.length,
      (index) => InkWell(
        onTap: () {
          // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
          // .getEnqList[index].Name.toString();
          context.read<NewEnqController>().selectEnqMeida(
              context
                  .read<NewEnqController>()
                  .getEnqList[index]
                  .Name
                  .toString(),
              context
                  .read<NewEnqController>()
                  .getEnqList[index]
                  .Code!
                  .toString());
        },
        child: Container(
          width: Screens.width(context) * 0.4,
          height: Screens.bodyheight(context) * 0.06,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color:
                  context.watch<NewEnqController>().getisSelectedenquirytype ==
                          context
                              .read<NewEnqController>()
                              .getEnqList[index]
                              .Name
                              .toString()
                      ? Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                      : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  context
                      .watch<NewEnqController>()
                      .getEnqList[index]
                      .Name
                      .toString(),
                  maxLines: 8,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyText1?.copyWith(
                    color: context
                                .watch<NewEnqController>()
                                .getisSelectedenquirytype ==
                            context
                                .read<NewEnqController>()
                                .getEnqList[index]
                                .Name
                                .toString()
                        ? theme.primaryColor //,Colors.white
                        : theme.primaryColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> listContainersRefferes(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<NewEnqController>().getenqReffList.length,
      (index) => InkWell(
        onTap: () {
          // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
          // .getenqReffList[index].Name.toString();
          context.read<NewEnqController>().selectEnqReffers(
              context
                  .read<NewEnqController>()
                  .getenqReffList[index]
                  .Name
                  .toString(),
              context.read<NewEnqController>().getenqReffList[index].Code!);
        },
        child: Container(
          width: Screens.width(context) * 0.4,
          height: Screens.bodyheight(context) * 0.06,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context
                          .watch<NewEnqController>()
                          .getisSelectedenquiryReffers ==
                      context
                          .read<NewEnqController>()
                          .getenqReffList[index]
                          .Name
                          .toString()
                  ? Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  context
                      .watch<NewEnqController>()
                      .getenqReffList[index]
                      .Name
                      .toString(),
                  maxLines: 8,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyText1?.copyWith(
                    color: context
                                .watch<NewEnqController>()
                                .getisSelectedenquiryReffers ==
                            context
                                .read<NewEnqController>()
                                .getenqReffList[index]
                                .Name
                                .toString()
                        ? theme.primaryColor //,Colors.white
                        : theme.primaryColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  //
  //
  List<Widget> listContainersCustomerTag(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<NewEnqController>().getCusTagList.length,
      (index) => InkWell(
        onTap: () {
          context.read<NewEnqController>().selectCsTag(context
              .read<NewEnqController>()
              .getCusTagList[index]
              .Code
              .toString());
          // log(context.read<NewEnqController>().getisSelectedCsTag.toString());
          // log(context
          //     .read<NewEnqController>()
          //     .getCusTagList[index]
          //     .Name
          //     .toString());
        },
        child: Container(
          width: Screens.width(context) * 0.3,
          height: Screens.bodyheight(context) * 0.045,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context.watch<NewEnqController>().getisSelectedCsTag ==
                      context
                          .read<NewEnqController>()
                          .getCusTagList[index]
                          .Code
                          .toString()
                  ? Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  context
                      .watch<NewEnqController>()
                      .getCusTagList[index]
                      .Name
                      .toString(),
                  textAlign: TextAlign.center,
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                    color:
                        context.watch<NewEnqController>().getisSelectedCsTag ==
                                context
                                    .read<NewEnqController>()
                                    .getCusTagList[index]
                                    .Code
                                    .toString()
                            ? theme.primaryColor //,Colors.white
                            : theme.primaryColor,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
