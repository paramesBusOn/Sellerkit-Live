// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, sort_child_properties_last, unnecessary_string_interpolations

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
// import 'package:sellerkit/Controller/EnquiryController/NewEnqController.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/SiteInController/newcreatesitein.dart';
import '../../../Controller/VisitplanController/NewVisitController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';
import '../../VisitPlans/widgets/PurposeShowSearchDialog.dart';
import 'ShowSearchDialog.dart';

class NewSiteIn extends StatefulWidget {
  NewSiteIn({Key? key}) : super(key: key);

  @override
  State<NewSiteIn> createState() => NewSiteInState();
}

class NewSiteInState extends State<NewSiteIn> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
   static bool iscomfromLead = false;
  Paddings paddings = Paddings();
  int? i;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
         if (iscomfromLead == false) {
          log("An vuuuuu");
          context.read<createSiteInController>().init(context);
        } else if (iscomfromLead == true) {
          context.read<createSiteInController>().checkcomefrom(context);

          iscomfromLead = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(       drawerEnableOpenDragGesture: false,

        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        drawer: drawer3(context),
        appBar: appbar("Site Check-In",  scaffoldKey,theme,context),
        body: GestureDetector(onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.sitein);
                      });
                    }
                  },
          child: Container(
            padding: paddings.padding2(context),
            child:(context.read<createSiteInController>().getexceptionOnApiCall.isEmpty &&
                  context.watch<createSiteInController>().getcustomerapicLoading ==
                      true)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : (context
                          .read<createSiteInController>()
                          .getexceptionOnApiCall
                          .isNotEmpty &&
                      context.watch<createSiteInController>().getcustomerapicLoading ==
                          false)
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            context
                                .read<createSiteInController>()
                                .getexceptionOnApiCall,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    )
                  : Form(
                                key: context.read<createSiteInController>().formkey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                  Container(
                    width: Screens.width(context),
                    height: Screens.bodyheight(context)*0.9 ,
                    child: SingleChildScrollView(
                      // reverse: true,
                      child: Column(
                        children: [
                          TextFormField(
                             focusNode: context
                                            .read<createSiteInController>()
                                            .focusNode2,
                              controller: context
                                  .read<createSiteInController>()
                                  .mycontroller[1],
                              onTap: () {},
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
                                                      .read<
                                                          createSiteInController>()
                                                      .getcustomerapicalled ==
                                                  false) {
                                            context
                                                .read<createSiteInController>()
                                                .callApi(context);
                                            // context
                                            //     .read<createSiteInController>()
                                            //     .callCheckEnqDetailsApi(context
                                            //         .read<createSiteInController>()
                                            //         .mycontroller[0]
                                            //         .text);
                                          } else if (v.length != 10) {
                                            context
                                                .read<createSiteInController>()
                                                .clearnum();
                                          }
                                        },
                              inputFormatters: [
                                FilteringTextInputFormatter
                                                        .digitsOnly,
                                new LengthLimitingTextInputFormatter(10),
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Mobile No*',
                                border: UnderlineInputBorder(),
                                
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  //  when the TextFormField in unfocused
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  //  when the TextFormField in focused
                                ),
                                errorBorder: UnderlineInputBorder(),
                                focusedErrorBorder: UnderlineInputBorder(),
                              )),
                          TextFormField(
                              controller: context
                                  .read<createSiteInController>()
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
                                                                createSiteInController>()
                                                            .mycontroller[8]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              createSiteInController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                createSiteInController>()
                                                            .mycontroller[8]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statebool = false;
                                                      });
                                                    }
                                                  },
                              onChanged: (v) {},
                              decoration: InputDecoration(
                                labelText: 'Customer*',
                                border: UnderlineInputBorder(),
                                
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  //  when the TextFormField in unfocused
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  //  when the TextFormField in focused
                                ),
                                errorBorder: UnderlineInputBorder(),
                                focusedErrorBorder: UnderlineInputBorder(),
                              )),
                      
                          
                          // SizedBox(
                          //   height: Screens.bodyheight(context) * 0.005,
                          // ),
                          //tags
                      
                          ///
                      
                          TextFormField(
                              controller: context
                                  .read<createSiteInController>()
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
                                                                createSiteInController>()
                                                            .mycontroller[8]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              createSiteInController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                createSiteInController>()
                                                            .mycontroller[8]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statebool = false;
                                                      });
                                                    }
                                                  },
                              decoration: InputDecoration(
                                labelText: 'Contact Name (optional)',
                                border: UnderlineInputBorder(),
                                
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  //  when the TextFormField in unfocused
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  //  when the TextFormField in focused
                                ),
                                errorBorder: UnderlineInputBorder(),
                                focusedErrorBorder: UnderlineInputBorder(),
                              )),
                          // SizedBox(
                          //   height: Screens.bodyheight(context) * 0.005,
                          // ),
                          TextFormField(
                              controller: context
                                  .read<createSiteInController>()
                                  .mycontroller[3],
                              onTap: () {
                                                    if (context
                                                            .read<
                                                                createSiteInController>()
                                                            .mycontroller[8]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              createSiteInController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                createSiteInController>()
                                                            .mycontroller[8]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                createSiteInController>()
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
                                  borderSide: BorderSide(color: Colors.grey),
                                  //  when the TextFormField in unfocused
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  //  when the TextFormField in focused
                                ),
                                errorBorder: UnderlineInputBorder(),
                                focusedErrorBorder: UnderlineInputBorder(),
                              )),
                          // SizedBox(
                          //   height: Screens.bodyheight(context) * 0.005,
                          // ),
                          TextFormField(
                              controller: context
                                  .read<createSiteInController>()
                                  .mycontroller[4],
                              onTap: () {
                                                    if (context
                                                            .read<
                                                                createSiteInController>()
                                                            .mycontroller[8]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              createSiteInController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                createSiteInController>()
                                                            .mycontroller[8]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                createSiteInController>()
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
                                  borderSide: BorderSide(color: Colors.grey),
                                  //  when the TextFormField in unfocused
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                  //  when the TextFormField in focused
                                ),
                                errorBorder: UnderlineInputBorder(),
                                focusedErrorBorder: UnderlineInputBorder(),
                              )),
                          // SizedBox(
                          //   height: Screens.bodyheight(context) * 0.005,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: Screens.width(context) * 0.4,
                                child: TextFormField(
                                    controller: context
                                        .read<createSiteInController>()
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
                                                                createSiteInController>()
                                                            .mycontroller[8]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              createSiteInController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                createSiteInController>()
                                                            .mycontroller[8]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statebool = false;
                                                      });
                                                    }
                                                  },
                                    onChanged: (v) {},
                                    decoration: InputDecoration(
                                      labelText: 'Area*',
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
                                      focusedErrorBorder: UnderlineInputBorder(),
                                    )),
                              ),
                              SizedBox(
                                width: Screens.width(context) * 0.4,
                                child: TextFormField(
                                    controller: context
                                        .read<createSiteInController>()
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
                                                                createSiteInController>()
                                                            .mycontroller[8]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              createSiteInController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                createSiteInController>()
                                                            .mycontroller[8]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statebool = false;
                                                      });
                                                    }
                                                  },
                                    onChanged: (v) {},
                                    decoration: InputDecoration(
                                      labelText: 'City*',
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
                                      focusedErrorBorder: UnderlineInputBorder(),
                                    )),
                              ),
                            ],
                          ),
                      
                          Container(
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: Screens.width(context) * 0.4,
                                          child: TextFormField(
                                              controller: context
                                                  .read<createSiteInController>()
                                                  .mycontroller[7],
                                              onTap: () {},
                                              // validator: (value) {
                                              //   if (value!.isEmpty) {
                                              //     return "Enter Pincode";
                                              //   }
                                              //   return null;
                                              // },
                                              onChanged: (v) {},
                                              keyboardType: TextInputType.number,
                                              inputFormatters: [
                                                 FilteringTextInputFormatter
                                              .digitsOnly,
                                                new LengthLimitingTextInputFormatter(6),
                                              ],
                                              decoration: InputDecoration(
                                                labelText: 'Pincode',
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
                                                focusedErrorBorder: UnderlineInputBorder(),
                                              )),
                                        ),
                                        SizedBox(
                                          width: Screens.width(context) * 0.4,
                                          child: TextFormField(
                                              controller: context
                                                  .read<createSiteInController>()
                                                  .mycontroller[8],
                                               focusNode: context
                                                            .read<
                                                                createSiteInController>()
                                                            .focusNode1,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .always,
                                                        onChanged: (v) {
                                                          setState(() {
                                                             context
                                                                .read<
                                                                    createSiteInController>()
                                                                .isText1Correct=false;
                                                            context
                                                                .read<
                                                                    createSiteInController>()
                                                                .filterListState2(
                                                                    v);
                                                            if (v.isEmpty) {
                                                              context
                                                                  .read<
                                                                      createSiteInController>()
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
                                                                      createSiteInController>()
                                                                  .methidstate(context
                                                                      .read<
                                                                          createSiteInController>()
                                                                      .mycontroller[
                                                                          8]
                                                                      .text);
                                                              context
                                                                  .read<
                                                                      createSiteInController>()
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
                                                                      createSiteInController>()
                                                                  .statecode
                                                                  .isEmpty) {
                                                            context
                                                                .read<
                                                                    createSiteInController>()
                                                                .methidstate(context
                                                                    .read<
                                                                        createSiteInController>()
                                                                    .mycontroller[
                                                                        8]
                                                                    .text);
                                                            FocusScope.of(
                                                                    context)
                                                                .requestFocus(context
                                                                    .read<
                                                                        createSiteInController>()
                                                                    .focusNode1);
                                                            context
                                                                .read<
                                                                    createSiteInController>()
                                                                .statebool = false;
                                                            return "Enter Correct State";
                                                          }
                                                          return null;
                                                        },
                                                        onEditingComplete: () {
                                                          setState(() {
                                                            context
                                                                .read<
                                                                    createSiteInController>()
                                                                .statebool = false;
                                                            context
                                                                .read<
                                                                    createSiteInController>()
                                                                .focusNode1
                                                                .unfocus();
                                                            // context
                                                            //   .read<NewEnqController>()
                                                            //   .  methodfortest();
                                                            context
                                                                .read<
                                                                    createSiteInController>()
                                                                .methidstate(context
                                                                    .read<
                                                                        createSiteInController>()
                                                                    .mycontroller[
                                                                        8]
                                                                    .text);
                                  
                                                            // context
                                                            // .read<NewEnqController>()
                                                            // .statecode='';
                                                          });
                                                        },
                                              decoration: InputDecoration(
                                                labelText: 'State*',
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
                                                focusedErrorBorder: UnderlineInputBorder(),
                                              )),
                                        ),
                                      ],
                                    ),
                                 
                                   SizedBox(
                            height: Screens.bodyheight(context) * 0.02,
                                                    ),
                             context
                                                          .read<
                                                              createSiteInController>()
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
                                    .read<createSiteInController>()
                                    .mycontroller[10],
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
                                  new LengthLimitingTextInputFormatter(10),
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Alternate Mobile No',
                                  border: UnderlineInputBorder(),
                                  enabledBorder: UnderlineInputBorder(),
                                  focusedBorder: UnderlineInputBorder(),
                                  errorBorder: UnderlineInputBorder(),
                                  focusedErrorBorder: UnderlineInputBorder(),
                                )),
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.01,
                            ),
                            TextFormField(
                              controller: context.read<createSiteInController>().mycontroller[11],
                                  onTap: () {
                                                    if (context
                                                            .read<
                                                                createSiteInController>()
                                                            .mycontroller[8]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              createSiteInController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                createSiteInController>()
                                                            .mycontroller[8]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                createSiteInController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                createSiteInController>()
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
                                  hintText: 'Email',
                                  border: UnderlineInputBorder(),
                                  enabledBorder: UnderlineInputBorder(),
                                  focusedBorder: UnderlineInputBorder(),
                                  errorBorder: UnderlineInputBorder(),
                                  focusedErrorBorder: UnderlineInputBorder(),
                                )),
                                  ],
                                ),
                              Visibility(
                                            visible: context
                                                .read<createSiteInController>()
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
                                                              createSiteInController>()
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
                                                                      createSiteInController>()
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
                                                                  "${context.watch<createSiteInController>().filterstateData[i].stateName}",
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
                                      
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.02,
                            ),
                         
                      
                          Column(
                            children: [
                              Stack(clipBehavior: Clip.none, children: [
                                SizedBox(
                                  child: TextFormField(
                                    controller: context
                                        .read<createSiteInController>()
                                        .mycontroller[9],
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<createSiteInController>()
                                            .mycontroller[9]
                                            .clear();
                                        // context
                                        //     .read<createSiteInController>()
                                        //     .clearbool();
                                        showDialog<dynamic>(
                                            context: context,
                                            builder: (_) {
                                              return SiteInShowDialog();
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
                                      labelText: "Purpose of Visit*",
                                      labelStyle: TextStyle(
                                          color: theme.primaryColor,
                                          fontWeight: FontWeight.bold),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      hintText: "Purpose Of Visit",
                                      hintStyle: TextStyle(
                                          color: theme.primaryColor,
                                          fontWeight: FontWeight.bold),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: theme.primaryColor),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: theme.primaryColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: theme.primaryColor),
                                      ),
                                    ),
                                    // cursorColor: Colors.green,
                                  ),
                                ),
                                Positioned(
                                    top: 0,
                                    right: 0,
                                    // left: Screens.width(context) * 0.74,
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            // context
                                            //     .read<createSiteInController>()
                                            //     .clearbool();
                                            showDialog<dynamic>(
                                                context: context,
                                                builder: (_) {
                                                  return SiteInShowDialog();
                                                });
                                          });
                                        },
                                        child: Container(
                                            width: Screens.width(context) * 0.2,
                                            // height: Screens.bodyheight(context) *
                                            //     0.065,
                                            padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 11,
                                                                  horizontal:
                                                                      10),
                                            decoration: BoxDecoration(
                                                color: theme.primaryColor,
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(8),
                                                  bottomRight: Radius.circular(8),
                                                )),
                                            child: Icon(Icons.search))))
                              ]),
                            ],
                          ),
                      
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.05,
                          ),
                        
                      Padding(padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom))
                      
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
                                .watch<createSiteInController>()
                                .isloding==true?null:   () {
                                  setState(() {
                                    
                                      context
                                .read<createSiteInController>()
                                .validateSchedule(context,);
                                  });
                          
                            // context
                            //     .read<NewEnqController>()
                            //     .callAddEnq(context);
                            // context.read<NewEnqController>().callAlertDialog(context, "Successfully Created..!!");
                          },
                          child: context
                                .watch<createSiteInController>()
                                .isloding==true?Center(child: SizedBox(
                                   height: Screens.padingHeight(context)*0.06,
                                          width: Screens.width(context)*0.05,
                                  child: CircularProgressIndicator(color: Colors.white,)),):Text("Site Check-In")),
                                        )
                                  ],
                                ),
                              ),
          ),
        ));
  }
}
