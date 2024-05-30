// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, sort_child_properties_last, unnecessary_string_interpolations, duplicate_import, unused_import, unnecessary_import, unnecessary_null_comparison, prefer_is_empty

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Pages/SiteOut/Widgets/AssignToMeAlertBox.dart';
import 'package:sellerkit/Pages/SiteOut/Widgets/userdialog.dart';
// import 'package:sellerkit/Controller/EnquiryController/SiteOutController.dart';
import '../../../Constant/ConstantRoutes.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/ShowSearchDialog.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/SiteOutController/SiteOutController.dart';
import '../../../Controller/SiteOutController/SiteOutController.dart';
import '../../../Controller/VisitplanController/NewVisitController.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';
import '../../VisitPlans/widgets/PurposeShowSearchDialog.dart';
import '../Widgets/LookingforAlertBox.dart';
import '../Widgets/PurposeSearchDialog.dart';

class SiteOut extends StatefulWidget {
  SiteOut({Key? key}) : super(key: key);

  @override
  State<SiteOut> createState() => _SiteOutState();
}

class _SiteOutState extends State<SiteOut> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Paddings paddings = Paddings();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        // context.read<SiteOutController>().init(context);
      });
    });
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.offAllNamed(ConstantRoutes.dashboard);
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
          appBar: appbar("Site Check-Out", scaffoldKey, theme, context),
          body: GestureDetector(
             onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.collectionlist);
                      });
                    }
                  },
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
            child: Container(
              padding: paddings.padding2(context),
              child:context.watch<SiteOutController>().isloadingmainPage==true?Center(child: CircularProgressIndicator(),) : Form(
                key: context.read<SiteOutController>().formkey,
                child: SingleChildScrollView(
                  child: GestureDetector(onHorizontalDragUpdate: (details) {
                      // Check if the user is swiping from left to right
                      print(details.primaryDelta);
                      if (details.primaryDelta! > ConstantValues.slidevalue!) {
                        setState(() {
                          Get.offAllNamed(ConstantRoutes.dashboard);
                        });
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: Screens.bodyheight(context) * 0.04,
                          alignment: Alignment.centerLeft,
                          // color: Colors.amber,
                          child:context.watch<SiteOutController>().customerName==null||context.watch<SiteOutController>().customerName=='null'||context.watch<SiteOutController>().customerName!.isEmpty?Text(""): Text(
                            "${context.watch<SiteOutController>().customerName}",
                            style: theme.textTheme.headline6
                                ?.copyWith(color: theme.primaryColor),
                          ),
                        ),
                        Container(
                          width: Screens.width(context),
                          // height: Screens.bodyheight(context) * 0.9,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // TextFormField(
                                //     controller: context
                                //         .read<SiteOutController>()
                                //         .mycontroller[0],
                                //     validator: (value) {
                                //       if (value!.isEmpty) {
                                //         return "Enter Customer";
                                //       }
                                //       return null;
                                //     },
                                //     onTap: () {
                  
                                //     },
                                //     onChanged: (v) {
                  
                                //     },
                                //     decoration: InputDecoration(
                                //       labelText: 'Customer',
                                //       border: UnderlineInputBorder(),
                                //       labelStyle: theme.textTheme.bodyText1!
                                //           .copyWith(color: Colors.grey),
                                //       enabledBorder: UnderlineInputBorder(
                                //         borderSide: BorderSide(color: Colors.grey),
                                //         //  when the TextFormField in unfocused
                                //       ),
                                //       focusedBorder: UnderlineInputBorder(
                                //         borderSide: BorderSide(color: Colors.grey),
                                //         //  when the TextFormField in focused
                                //       ),
                                //       errorBorder: UnderlineInputBorder(),
                                //       focusedErrorBorder: UnderlineInputBorder(),
                                //     )),
                  
                                // SizedBox(
                                //   height: Screens.bodyheight(context) * 0.005,
                                // ),
                                //tags
                  
                                ///
                  
                                TextFormField(
                                    controller: context
                                        .read<SiteOutController>()
                                        .mycontroller[2],
                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return "Enter Contact Name";
                                    //   }
                                    //   return null;
                                    // },
                                    onTap: () {},
                                    decoration: InputDecoration(
                                      labelText: 'Contact Name',
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
                                TextFormField(
                                    controller: context
                                        .read<SiteOutController>()
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
                                    onChanged: (v) {},
                                    inputFormatters: [
                                      
                                      new LengthLimitingTextInputFormatter(10),
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Mobile No*',
                                      border: UnderlineInputBorder(),
                                      labelStyle: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
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
                                  readOnly: true,
                                    controller: context
                                        .read<SiteOutController>()
                                        .mycontroller[3],
                                    onTap: () {},
                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return "Enter Location";
                                    //   }
                                    //   return null;
                                    // },
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      labelText: 'Location',
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
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.01,
                                            ),
                                            TextFormField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: context
                                                    .read<SiteOutController>()
                                                    .mycontroller[21],
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
                                                      0.01,
                                            ),
                                SizedBox(
                                  height: context
                                          .read<SiteOutController>()
                                          .mycontroller[9]
                                          .text
                                          .isEmpty
                                      ? Screens.bodyheight(context) * 0.015
                                      : Screens.bodyheight(context) * 0.02,
                                ),
                                Column(
                                  children: [
                                    Stack(clipBehavior: Clip.none, children: [
                                      SizedBox(
                                        child: TextFormField(
                                          controller: context
                                              .read<SiteOutController>()
                                              .mycontroller[9],
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<SiteOutController>()
                                                  .mycontroller[9]
                                                  .clear();
                                              // context
                                              //     .read<SiteOutController>()
                                              //     .clearbool();
                                              showDialog<dynamic>(
                                                  context: context,
                                                  builder: (_) {
                                                    return SiteOutShowDialog();
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
                                          //     .read<SiteOutController>()
                                          //     .mycontroller[7],
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            labelText: "Purpose Of Visit *",
                                            labelStyle: TextStyle(
                                                color: theme.primaryColor,
                                                fontWeight: FontWeight.bold),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: theme.primaryColor),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: theme.primaryColor),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: theme.primaryColor),
                                            ),
                                          ),
                                          // cursorColor: Colors.green,
                                        ),
                                      ),
                                      Positioned(
                                          top: 0,
                                          left: Screens.width(context) * 0.74,
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  // context
                                                  //     .read<SiteOutController>()
                                                  //     .mycontroller[12]
                                                  //     .clear();
                                                  // context
                                                  //     .read<SiteOutController>()
                                                  //     .clearbool();
                                                  showDialog<dynamic>(
                                                      context: context,
                                                      builder: (_) {
                                                        return SiteOutShowDialog();
                                                      });
                                                });
                                              },
                                              child: Container(
                                                  width:
                                                      Screens.width(context) * 0.2,
                                                  // height:
                                                  //     Screens.bodyheight(context) *
                                                  //         0.065,
                                                  padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 11,
                                                                    horizontal:
                                                                        10),
                                                  decoration: BoxDecoration(
                                                      color: theme.primaryColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(8),
                                                        bottomRight:
                                                            Radius.circular(8),
                                                      )),
                                                  child: Icon(Icons.search))))
                                    ]),
                                  ],
                                ),
                                SizedBox(
                                  height: context
                                          .read<SiteOutController>()
                                          .mycontroller[7]
                                          .text
                                          .isEmpty
                                      ? Screens.bodyheight(context) * 0.015
                                      : Screens.bodyheight(context) * 0.02,
                                ),
                                Column(
                                  children: [
                                    Stack(clipBehavior: Clip.none, children: [
                                      SizedBox(
                                        child: TextFormField(
                                          onTap: () {
                                            showDialog<dynamic>(
                                                context: context,
                                                builder: (_) {
                                                  return LookingSearchDialog();
                                                }).then((value) {
                                                             context
                                                              .read<
                                                                  SiteOutController>()
                                                              .setcatagorydata();    
                                                              });
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter Looking for ";
                                            }
                                            return null;
                                          },
                                          // readOnly: true,
                                          controller: context
                                              .read<SiteOutController>()
                                              .mycontroller[7],
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            labelText: "Looking for *",
                                            labelStyle: TextStyle(
                                                color: theme.primaryColor,
                                                fontWeight: FontWeight.bold),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: theme.primaryColor),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: theme.primaryColor),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                  color: theme.primaryColor),
                                            ),
                                          ),
                                          // cursorColor: Colors.green,
                                        ),
                                      ),
                                      Positioned(
                                          top: 0,
                                          left: Screens.width(context) * 0.74,
                                          child: InkWell(
                                              onTap: () {
                                                showDialog<dynamic>(
                                                    context: context,
                                                    builder: (_) {
                                                      return LookingSearchDialog();
                                                    }).then((value) {
                                                             context
                                                              .read<
                                                                  SiteOutController>()
                                                              .setcatagorydata();    
                                                              });
                                              },
                                              child: Container(
                                                  width:
                                                      Screens.width(context) * 0.2,
                                                  // height:
                                                  //     Screens.bodyheight(context) *
                                                  //         0.065,
                                                  padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 11,
                                                                    horizontal:
                                                                        10),
                                                  decoration: BoxDecoration(
                                                      color: theme.primaryColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(8),
                                                        bottomRight:
                                                            Radius.circular(8),
                                                      )),
                                                  child: Icon(Icons.search))))
                                    ]),
                                  ],
                                ),
                                // SizedBox(
                                //   height: Screens.bodyheight(context) * 0.015,
                                // ),
                                Container(
                                  height: Screens.bodyheight(context) * 0.05,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    " Visits Outcomes*",
                                    style: TextStyle(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextFormField(
                                  minLines: 6,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  controller: context
                                      .read<SiteOutController>()
                                      .mycontroller[18],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter visit Outcomes";
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
                                // SizedBox(
                                //   height: Screens.bodyheight(context) * 0.015,
                                // ),
                  
                              context
                                        .read<SiteOutController>()
                                        .getleadcheckdatas.isEmpty?Container():   Container(
                                  height: Screens.bodyheight(context) * 0.05,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    " Site Visit CheckList",
                                    style: TextStyle(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                context
                                        .read<SiteOutController>()
                                        .getleadcheckdatas.isEmpty?Container():  Container(
                                  width: Screens.width(context),
                                  height: Screens.bodyheight(context) * 0.3,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: theme.primaryColor),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: ListView.builder(
                                    padding: EdgeInsets.only(
                                        bottom: Screens.bodyheight(context) * 0.02),
                                    itemCount: context
                                        .read<SiteOutController>()
                                        .getleadcheckdatas
                                        .length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          print("");
                                        },
                                        child: Container(
                                          width: Screens.width(context),
                                          padding: EdgeInsets.only(
                                            top: Screens.bodyheight(context) * 0.01,
                                            //  bottom: Screens.bodyheight(context) * 0.01,
                                            left: Screens.width(context) * 0.02,
                                            right: Screens.width(context) * 0.02,
                                          ),
                                          child: Column(
                                            children: [
                                              Row(children: [
                                                Container(
                                                  width:
                                                      Screens.width(context) * 0.7,
                                                  child: Text(
                                                    "${context.watch<SiteOutController>().getleadcheckdatas[index].Name}",
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                // Checkbox(
                                                //     value: provi
                                                //         .getleadcheckdatas[index].ischecked,
                                                //     onChanged: (v) {
                                                //       provi.LeadcheckListClicked(v, index);
                                                //     })
                  
                                                FlutterSwitch(
                                                    showOnOff: true,
                                                    width: 60,
                                                    height: 25,
                                                    activeText: "Yes",
                                                    inactiveText: "No",
                                                    activeColor: theme.primaryColor,
                                                    value: context
                                                        .read<SiteOutController>()
                                                        .getleadcheckdatas[index]
                                                        .ischecked!,
                                                    onToggle: (val) {
                                                      // context.read<SiteOutController>().switchremainder(val);
                                                      //  print(val);
                                                      // setState(() {
                                                      //   switched = val;
                                                      //   reqfinance = "Y";
                                                      // });
                                                      context
                                                          .read<SiteOutController>()
                                                          .LeadcheckListClicked(
                                                              val, index);
                                                    })
                                              ]),
                                              SizedBox(
                                                height:
                                                    Screens.bodyheight(context) *
                                                        0.01,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors.grey))),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.015,
                                ),
                                //
                                //Attach
                                Container(
                        //  width: Screens.width(context),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: theme.primaryColor)),
                        padding: EdgeInsets.only(
                            top: Screens.padingHeight(context) * 0.01,
                            left: Screens.padingHeight(context) * 0.01,
                            bottom: Screens.padingHeight(context) * 0.015,
                            right: Screens.padingHeight(context) * 0.01),
                        // height: Screens.padingHeight(context) * 0.14,
                        // color: Colors.red,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Attachment',
                                      style: theme.textTheme.subtitle1?.copyWith(
                                          color: context
                                                      .read<SiteOutController>()
                                                      .fileValidation ==
                                                  true
                                              ? Colors.red
                                              : Colors.black)),
                                  Row(
                                    children: [
                                      Container(
                                          // alignment: Alignment.center,
                                          height: Screens.padingHeight(context) *
                                              0.06,
                                          width: Screens.width(context) * 0.13,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: context
                                                          .read<
                                                              SiteOutController>()
                                                          .fileValidation ==
                                                      true
                                                  ? Colors.red
                                                  : theme.primaryColor
                                              // shape: BoxShape
                                              //     .circle
                                              ),
                                          child: Center(
                                            child: IconButton(
                                                onPressed: context
                                                            .read<
                                                                SiteOutController>()
                                                            .files
                                                            .length >
                                                        4
                                                    ? null
                                                    : () {
                                                        setState(() {
                                                          log("files length" +
                                                              context
                                                                  .read<
                                                                      SiteOutController>()
                                                                  .files
                                                                  .length
                                                                  .toString());
                                                          // showtoast();
                                                          if (context
                                                                  .read<
                                                                      SiteOutController>()
                                                                  .files
                                                                  .length <=
                                                              3) {
                                                            setState(() {
                                                              context
                                                                  .read<
                                                                      SiteOutController>()
                                                                  .imagetoBinary(
                                                                      ImageSource
                                                                          .camera);
                                                              context
                                                                  .read<
                                                                      SiteOutController>()
                                                                  .fileValidation = false;
                                                            });
                                                          } else {
                                                            print("obAAAAAject");
                                                            context
                                                                .read<
                                                                    SiteOutController>()
                                                                .showtoast();
                                                          }
                                                        });
                                                      },
                                                icon: Icon(
                                                  Icons.photo_camera,
                                                  color: Colors.white,
                                                )),
                                          )),
                                      SizedBox(
                                        width: Screens.width(context) * 0.02,
                                      ),
          
                                      //old
                                      Container(
                                          // alignment: Alignment.center,
                                          height: Screens.padingHeight(context) *
                                              0.06,
                                          width: Screens.width(context) * 0.13,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: context
                                                          .read<
                                                              SiteOutController>()
                                                          .fileValidation ==
                                                      true
                                                  ? Colors.red
                                                  : theme.primaryColor
                                              // shape: BoxShape
                                              //     .circle
                                              ),
                                          child: Center(
                                            child: IconButton(
                                                onPressed: context
                                                            .read<
                                                                SiteOutController>()
                                                            .files
                                                            .length >
                                                        4
                                                    ? null
                                                    : () {
                                                        setState(() {
                                                          // log("files length" + files.length.toString());
                                                          // showtoast();
                                                          if (context
                                                                  .read<
                                                                      SiteOutController>()
                                                                  .files
                                                                  .length <=
                                                              3) {
                                                            setState(() {
                                                              context
                                                                  .read<
                                                                      SiteOutController>()
                                                                  .selectattachment();
          
                                                              context
                                                                  .read<
                                                                      SiteOutController>()
                                                                  .fileValidation = false;
                                                            });
                                                          } else {
                                                            print("obAAAAAject");
          
                                                            context
                                                                .read<
                                                                    SiteOutController>()
                                                                .showtoast();
                                                          }
                                                        });
                                                      },
                                                icon: Icon(
                                                  Icons.attach_file,
                                                  color: Colors.white,
                                                )),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                              context.read<SiteOutController>().files == null
                                  ? Container(
                                      height: Screens.padingHeight(context) * 0.3,
                                      padding: EdgeInsets.only(
                                        top:
                                            Screens.padingHeight(context) * 0.001,
                                        right:
                                            Screens.padingHeight(context) * 0.015,
                                        left:
                                            Screens.padingHeight(context) * 0.015,
                                        bottom:
                                            Screens.padingHeight(context) * 0.015,
                                      ),
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                  child: Text(
                                                "No Files Selected",
                                                style: theme.textTheme.bodyText1!
                                                    .copyWith(
                                                        color: context
                                                                    .read<
                                                                        SiteOutController>()
                                                                    .fileValidation ==
                                                                true
                                                            ? Colors.red
                                                            : Colors.green),
                                              )),
                                              Icon(
                                                Icons.file_present_outlined,
                                                color: theme.primaryColor,
                                              )
                                            ],
                                          )))
                                  : Container(
                                      height: context
                                                  .read<SiteOutController>()
                                                  .files
                                                  .length ==
                                              0
                                          ? Screens.padingHeight(context) * 0.0
                                          : Screens.padingHeight(context) * 0.3,
                                      padding: EdgeInsets.only(
                                        top:
                                            Screens.padingHeight(context) * 0.001,
                                        right:
                                            Screens.padingHeight(context) * 0.015,
                                        left:
                                            Screens.padingHeight(context) * 0.015,
                                        bottom:
                                            Screens.padingHeight(context) * 0.015,
                                      ),
                                      child: ListView.builder(
                                          itemCount: context
                                              .read<SiteOutController>()
                                              .files
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            if (context
                                                .read<SiteOutController>()
                                                .files[i]
                                                .path
                                                .split('/')
                                                .last
                                                .contains("png")) {
                                              return Container(
                                                  child: Column(children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                          decoration:
                                                              BoxDecoration(),
                                                          width: Screens.width(
                                                                  context) *
                                                              0.09,
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.06,
                                                          child: Center(
                                                              child: Image.asset(
                                                                  "Assets/img.jpg"))),
                                                      Container(
                                                          padding:
                                                              EdgeInsets.all(10),
                                                          decoration:
                                                              BoxDecoration(),
                                                          width: Screens.width(
                                                                  context) *
                                                              0.6,
                                                          // height: Screens.padingHeight(context) * 0.06,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            context
                                                                .watch<
                                                                    SiteOutController>()
                                                                .files[i]
                                                                .path
                                                                .split('/')
                                                                .last,
                                                            // overflow: TextOverflow.ellipsis,
                                                          )),
                                                      Container(
                                                          width: Screens.width(
                                                                  context) *
                                                              0.1,
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.06,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  context
                                                                      .read<
                                                                          SiteOutController>()
                                                                      .files
                                                                      .removeAt(
                                                                          i);
                                                                          context
                                                                      .read<
                                                                          SiteOutController>()
                                                                      .filedata
                                                                      .removeAt(
                                                                          i);
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .cancel_rounded,
                                                                color:
                                                                    Colors.grey,
                                                              )))
                                                    ])
                                              ])
                                                  // )
                                                  );
                                            } else if (context
                                                .read<SiteOutController>()
                                                .files[i]
                                                .path
                                                .split('/')
                                                .last
                                                .contains("jp")) {
                                              return Container(
                                                  child: Column(children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                          decoration:
                                                              BoxDecoration(),
                                                          width: Screens.width(
                                                                  context) *
                                                              0.09,
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.06,
                                                          child: Center(
                                                              child: Image.asset(
                                                                  "Assets/img.jpg"))),
                                                      Container(
                                                          padding:
                                                              EdgeInsets.all(10),
                                                          decoration:
                                                              BoxDecoration(),
                                                          width: Screens.width(
                                                                  context) *
                                                              0.6,
                                                          // height: Screens.padingHeight(context) * 0.06,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            context
                                                                .watch<
                                                                    SiteOutController>()
                                                                .files[i]
                                                                .path
                                                                .split('/')
                                                                .last,
                                                          )),
                                                      Container(
                                                          width: Screens.width(
                                                                  context) *
                                                              0.1,
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.06,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  context
                                                                      .read<
                                                                          SiteOutController>()
                                                                      .files
                                                                      .removeAt(
                                                                          i);
                                                                          context
                                                                      .read<
                                                                          SiteOutController>()
                                                                      .filedata
                                                                      .removeAt(
                                                                          i);
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .cancel_rounded,
                                                                color:
                                                                    Colors.grey,
                                                              )))
                                                    ])
                                              ])
                                                  // )
                                                  );
                                            } else if (context
                                                .read<SiteOutController>()
                                                .files[i]
                                                .path
                                                .split('/')
                                                .last
                                                .contains("pdf")) {
                                              return Container(
                                                  child: Column(children: [
                                                SizedBox(
                                                  height: Screens.padingHeight(
                                                          context) *
                                                      0.01,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                        width: Screens.width(
                                                                context) *
                                                            0.09,
                                                        height:
                                                            Screens.padingHeight(
                                                                    context) *
                                                                0.06,
                                                        child: Center(
                                                            child: Image.asset(
                                                                "Assets/PDFimg.png")),
                                                      ),
                                                      Container(
                                                          padding:
                                                              EdgeInsets.all(10),
                                                          decoration:
                                                              BoxDecoration(),
                                                          width: Screens.width(
                                                                  context) *
                                                              0.6,
                                                          // height: Screens.padingHeight(context) * 0.06,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            context
                                                                .watch<
                                                                    SiteOutController>()
                                                                .files[i]
                                                                .path
                                                                .split('/')
                                                                .last,
                                                          )),
                                                      Container(
                                                          width: Screens.width(
                                                                  context) *
                                                              0.1,
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.06,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  context
                                                                      .read<
                                                                          SiteOutController>()
                                                                      .files
                                                                      .removeAt(
                                                                          i);
                                                                          context
                                                                      .read<
                                                                          SiteOutController>()
                                                                      .filedata
                                                                      .removeAt(
                                                                          i);
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .cancel_rounded,
                                                                color:
                                                                    Colors.grey,
                                                              )))
                                                    ])
                                              ]));
                                            } else if (context
                                                .read<SiteOutController>()
                                                .files[i]
                                                .path
                                                .split('/')
                                                .last
                                                .contains("xlsx")) {
                                              return Container(
                                                  child: Column(children: [
                                                SizedBox(
                                                  height: Screens.padingHeight(
                                                          context) *
                                                      0.01,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                          decoration:
                                                              BoxDecoration(),
                                                          width: Screens.width(
                                                                  context) *
                                                              0.09,
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.06,
                                                          child: Center(
                                                              child: Image.asset(
                                                                  "Assets/xls.png"))),
                                                      Container(
                                                          padding:
                                                              EdgeInsets.all(10),
                                                          decoration:
                                                              BoxDecoration(),
                                                          width: Screens.width(
                                                                  context) *
                                                              0.6,
                                                          // height: Screens.padingHeight(context) * 0.06,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            context
                                                                .read<
                                                                    SiteOutController>()
                                                                .files[i]
                                                                .path
                                                                .split('/')
                                                                .last,
                                                          )),
                                                      Container(
                                                          width: Screens.width(
                                                                  context) *
                                                              0.1,
                                                          height: Screens
                                                                  .padingHeight(
                                                                      context) *
                                                              0.06,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  context
                                                                      .read<
                                                                          SiteOutController>()
                                                                      .files
                                                                      .removeAt(
                                                                          i);
                                                                          context
                                                                      .read<
                                                                          SiteOutController>()
                                                                      .filedata
                                                                      .removeAt(
                                                                          i);
                                                                });
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .cancel_rounded,
                                                                color:
                                                                    Colors.grey,
                                                              )))
                                                    ])
                                              ])
                                                  // )
                                                  );
                                            }
                                            return Container(
                                                child: Column(children: [
                                              SizedBox(
                                                height: Screens.padingHeight(
                                                        context) *
                                                    0.01,
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        decoration:
                                                            BoxDecoration(),
                                                        width: Screens.width(
                                                                context) *
                                                            0.09,
                                                        height:
                                                            Screens.padingHeight(
                                                                    context) *
                                                                0.06,
                                                        child: Center(
                                                            child: Image.asset(
                                                                "Assets/txt.png"))),
                                                    Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        decoration:
                                                            BoxDecoration(),
                                                        width: Screens.width(
                                                                context) *
                                                            0.6,
                                                        // height: Screens.padingHeight(context) * 0.06,
                                                        alignment:
                                                            Alignment.centerLeft,
                                                        child: Text(
                                                          context
                                                              .watch<
                                                                  SiteOutController>()
                                                              .files[i]
                                                              .path
                                                              .split('/')
                                                              .last,
                                                        )),
                                                    Container(
                                                        width: Screens.width(
                                                                context) *
                                                            0.1,
                                                        height:
                                                            Screens.padingHeight(
                                                                    context) *
                                                                0.06,
                                                        child: IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                context
                                                                    .read<
                                                                        SiteOutController>()
                                                                    .files
                                                                    .removeAt(i);
                                                                    context
                                                                      .read<
                                                                          SiteOutController>()
                                                                      .filedata
                                                                      .removeAt(
                                                                          i);
                                                              });
                                                            },
                                                            icon: Icon(
                                                              Icons
                                                                  .cancel_rounded,
                                                              color: Colors.grey,
                                                            )))
                                                  ])
                                            ]));
                                          })),
                            ])),
                                // Container(
                                //     //  width: Screens.width(context),
                                //     decoration: BoxDecoration(
                                //         borderRadius: BorderRadius.circular(8),
                                //         border:
                                //             Border.all(color: theme.primaryColor)),
                                //     padding: EdgeInsets.only(
                                //         top: Screens.padingHeight(context) * 0.01,
                                //         left: Screens.padingHeight(context) * 0.01,
                                //         bottom:
                                //             Screens.padingHeight(context) * 0.015,
                                //         right:
                                //             Screens.padingHeight(context) * 0.01),
                                //     // height: Screens.padingHeight(context) * 0.14,
                                //     // color: Colors.red,
                                //     child: Column(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           Row(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.spaceBetween,
                                //             children: [
                                //               Text('Attachment',
                                //                   style: theme.textTheme.subtitle1
                                //                       ?.copyWith(
                                //                           color: context
                                //                                       .read<
                                //                                           SiteOutController>()
                                //                                       .fileValidation ==
                                //                                   true
                                //                               ? Colors.red
                                //                               : Colors.black)),
                                //               Row(
                                //                 children: [
                                //                   Container(
                                //                       // alignment: Alignment.center,
                                //                       height: Screens.padingHeight(
                                //                               context) *
                                //                           0.06,
                                //                       width:
                                //                           Screens.width(context) *
                                //                               0.13,
                                //                       decoration: BoxDecoration(
                                //                           borderRadius:
                                //                               BorderRadius.circular(
                                //                                   6),
                                //                           color: context
                                //                                       .read<
                                //                                           SiteOutController>()
                                //                                       .fileValidation ==
                                //                                   true
                                //                               ? Colors.red
                                //                               : theme.primaryColor
                                //                           // shape: BoxShape
                                //                           //     .circle
                                //                           ),
                                //                       child: Center(
                                //                         child: IconButton(
                                //                             onPressed: context
                                //                                         .read<
                                //                                             SiteOutController>()
                                //                                         .files
                                //                                         .length >
                                //                                     3
                                //                                 ? (){
                                //                                    context
                                //                                             .read<
                                //                                                 SiteOutController>()
                                //                                             .showtoast();
                                //                                 }
                                //                                 : () {
                                //                                     setState(() {
                                //                                       // log("files length" + files.length.toString());
                                //                                       // showtoast();
                                //                                       if (context
                                //                                               .read<
                                //                                                   SiteOutController>()
                                //                                               .files
                                //                                               .length <=
                                //                                           3) {
                                //                                         setState(
                                //                                             () {
                                //                                           context
                                //                                               .read<
                                //                                                   SiteOutController>()
                                //                                               .imagetoBinary(
                                //                                                   ImageSource.camera);
                                //                                           context
                                //                                               .read<
                                //                                                   SiteOutController>()
                                //                                               .fileValidation = false;
                                //                                         });
                                //                                       } else {
                                //                                         print(
                                //                                             "obAAAAAject");
                                //                                         context
                                //                                             .read<
                                //                                                 SiteOutController>()
                                //                                             .showtoast();
                                //                                       }
                                //                                     });
                                //                                   },
                                //                             icon: Icon(
                                //                               Icons.photo_camera,
                                //                               color: Colors.white,
                                //                             )),
                                //                       )),
                                //                   SizedBox(
                                //                     width: Screens.width(context) *
                                //                         0.02,
                                //                   ),
                  
                                //                   //old
                                //                   Container(
                                //                       // alignment: Alignment.center,
                                //                       height: Screens.padingHeight(
                                //                               context) *
                                //                           0.06,
                                //                       width:
                                //                           Screens.width(context) *
                                //                               0.13,
                                //                       decoration: BoxDecoration(
                                //                           borderRadius:
                                //                               BorderRadius.circular(
                                //                                   6),
                                //                           color: context
                                //                                       .read<
                                //                                           SiteOutController>()
                                //                                       .fileValidation ==
                                //                                   true
                                //                               ? Colors.red
                                //                               : theme.primaryColor
                                //                           // shape: BoxShape
                                //                           //     .circle
                                //                           ),
                                //                       child: Center(
                                //                         child: IconButton(
                                //                             onPressed: context
                                //                                         .read<
                                //                                             SiteOutController>()
                                //                                         .files
                                //                                         .length >
                                //                                     5
                                //                                 ? null
                                //                                 : () {
                                //                                     setState(() {
                                //                                       // log("files length" + files.length.toString());
                                //                                       // showtoast();
                                //                                       if (context
                                //                                               .read<
                                //                                                   SiteOutController>()
                                //                                               .files
                                //                                               .length <=
                                //                                           4) {
                                //                                         setState(
                                //                                             () {
                                //                                           context
                                //                                               .read<
                                //                                                   SiteOutController>()
                                //                                               .selectattachment();
                  
                                //                                           context
                                //                                               .read<
                                //                                                   SiteOutController>()
                                //                                               .fileValidation = false;
                                //                                         });
                                //                                       } else {
                                //                                         print(
                                //                                             "obAAAAAject");
                  
                                //                                         context
                                //                                             .read<
                                //                                                 SiteOutController>()
                                //                                             .showtoast();
                                //                                       }
                                //                                     });
                                //                                   },
                                //                             icon: Icon(
                                //                               Icons.attach_file,
                                //                               color: Colors.white,
                                //                             )),
                                //                       )),
                                //                 ],
                                //               )
                                //             ],
                                //           ),
                                //           context.read<SiteOutController>().files ==
                                //                   null
                                //               ? Container(
                                //                   height: Screens.padingHeight(
                                //                           context) *
                                //                       0.3,
                                //                   padding: EdgeInsets.only(
                                //                     top: Screens.padingHeight(
                                //                             context) *
                                //                         0.001,
                                //                     right: Screens.padingHeight(
                                //                             context) *
                                //                         0.015,
                                //                     left: Screens.padingHeight(
                                //                             context) *
                                //                         0.015,
                                //                     bottom: Screens.padingHeight(
                                //                             context) *
                                //                         0.015,
                                //                   ),
                                //                   child: Container(
                                //                       alignment: Alignment.center,
                                //                       child: Row(
                                //                         mainAxisAlignment:
                                //                             MainAxisAlignment
                                //                                 .center,
                                //                         children: [
                                //                           Center(
                                //                               child: Text(
                                //                             "No Files Selected",
                                //                             style: theme.textTheme
                                //                                 .bodyText1!
                                //                                 .copyWith(
                                //                                     color: context
                                //                                                 .read<
                                //                                                     SiteOutController>()
                                //                                                 .fileValidation ==
                                //                                             true
                                //                                         ? Colors.red
                                //                                         : Colors
                                //                                             .green),
                                //                           )),
                                //                           Icon(
                                //                             Icons
                                //                                 .file_present_outlined,
                                //                             color:
                                //                                 theme.primaryColor,
                                //                           )
                                //                         ],
                                //                       )))
                                //               : Container(
                                //                   height: context
                                //                               .read<
                                //                                   SiteOutController>()
                                //                               .files
                                //                               .length ==
                                //                           0
                                //                       ? Screens.padingHeight(
                                //                               context) *
                                //                           0.0
                                //                       : Screens.padingHeight(
                                //                               context) *
                                //                           0.3,
                                //                   padding: EdgeInsets.only(
                                //                     top: Screens.padingHeight(
                                //                             context) *
                                //                         0.001,
                                //                     right: Screens.padingHeight(
                                //                             context) *
                                //                         0.015,
                                //                     left: Screens.padingHeight(
                                //                             context) *
                                //                         0.015,
                                //                     bottom: Screens.padingHeight(
                                //                             context) *
                                //                         0.015,
                                //                   ),
                                //                   child: ListView.builder(
                                //                       itemCount: context
                                //                           .watch<
                                //                               SiteOutController>()
                                //                           .files
                                //                           .length,
                                //                       itemBuilder:
                                //                           (BuildContext context,
                                //                               int i) {
                                //                         if (context
                                //                             .read<
                                //                                 SiteOutController>()
                                //                             .files[i]
                                //                             .path
                                //                             .split('/')
                                //                             .last
                                //                             .contains("png")) {
                                //                           return Container(
                                //                               child: Column(
                                //                                   children: [
                                //                                 SizedBox(
                                //                                   height: 10,
                                //                                 ),
                                //                                 Row(
                                //                                     mainAxisAlignment:
                                //                                         MainAxisAlignment
                                //                                             .spaceBetween,
                                //                                     children: [
                                //                                       Container(
                                //                                           decoration:
                                //                                               BoxDecoration(),
                                //                                           width: Screens.width(
                                //                                                   context) *
                                //                                               0.09,
                                //                                           height: Screens.padingHeight(
                                //                                                   context) *
                                //                                               0.06,
                                //                                           child: Center(
                                //                                               child:
                                //                                                   Image.asset("Assets/img.jpg"))),
                                //                                       Container(
                                //                                           padding:
                                //                                               EdgeInsets.all(
                                //                                                   10),
                                //                                           decoration:
                                //                                               BoxDecoration(),
                                //                                           width: Screens.width(
                                //                                                   context) *
                                //                                               0.6,
                                //                                           // height: Screens.padingHeight(context) * 0.06,
                                //                                           alignment:
                                //                                               Alignment
                                //                                                   .centerLeft,
                                //                                           child:
                                //                                               Text(
                                //                                             context
                                //                                                 .watch<SiteOutController>()
                                //                                                 .files[i]
                                //                                                 .path
                                //                                                 .split('/')
                                //                                                 .last,
                                //                                             // overflow: TextOverflow.ellipsis,
                                //                                           )),
                                //                                       Container(
                                //                                           width: Screens.width(
                                //                                                   context) *
                                //                                               0.1,
                                //                                           height: Screens.padingHeight(
                                //                                                   context) *
                                //                                               0.06,
                                //                                           child: IconButton(
                                //                                               onPressed: () {
                                //                                                 setState(() {
                                //                                                   context.read<SiteOutController>().files.removeAt(i);
                                //                                                 });
                                //                                               },
                                //                                               icon: Icon(
                                //                                                 Icons.cancel_rounded,
                                //                                                 color:
                                //                                                     Colors.grey,
                                //                                               )))
                                //                                     ])
                                //                               ])
                                //                               // )
                                //                               );
                                //                         } else if (context
                                //                             .read<
                                //                                 SiteOutController>()
                                //                             .files[i]
                                //                             .path
                                //                             .split('/')
                                //                             .last
                                //                             .contains("jp")) {
                                //                           return Container(
                                //                               child: Column(
                                //                                   children: [
                                //                                 SizedBox(
                                //                                   height: 10,
                                //                                 ),
                                //                                 Row(
                                //                                     mainAxisAlignment:
                                //                                         MainAxisAlignment
                                //                                             .spaceBetween,
                                //                                     children: [
                                //                                       Container(
                                //                                           decoration:
                                //                                               BoxDecoration(),
                                //                                           width: Screens.width(
                                //                                                   context) *
                                //                                               0.09,
                                //                                           height: Screens.padingHeight(
                                //                                                   context) *
                                //                                               0.06,
                                //                                           child: Center(
                                //                                               child:
                                //                                                   Image.asset("Assets/img.jpg"))),
                                //                                       Container(
                                //                                           padding:
                                //                                               EdgeInsets.all(
                                //                                                   10),
                                //                                           decoration:
                                //                                               BoxDecoration(),
                                //                                           width: Screens.width(
                                //                                                   context) *
                                //                                               0.6,
                                //                                           // height: Screens.padingHeight(context) * 0.06,
                                //                                           alignment:
                                //                                               Alignment
                                //                                                   .centerLeft,
                                //                                           child:
                                //                                               Text(
                                //                                             context
                                //                                                 .watch<SiteOutController>()
                                //                                                 .files[i]
                                //                                                 .path
                                //                                                 .split('/')
                                //                                                 .last,
                                //                                           )),
                                //                                       Container(
                                //                                           width: Screens.width(
                                //                                                   context) *
                                //                                               0.1,
                                //                                           height: Screens.padingHeight(
                                //                                                   context) *
                                //                                               0.06,
                                //                                           child: IconButton(
                                //                                               onPressed: () {
                                //                                                 setState(() {
                                //                                                   context.read<SiteOutController>().files.removeAt(i);
                                //                                                 });
                                //                                               },
                                //                                               icon: Icon(
                                //                                                 Icons.cancel_rounded,
                                //                                                 color:
                                //                                                     Colors.grey,
                                //                                               )))
                                //                                     ])
                                //                               ])
                                //                               // )
                                //                               );
                                //                         } else if (context
                                //                             .read<
                                //                                 SiteOutController>()
                                //                             .files[i]
                                //                             .path
                                //                             .split('/')
                                //                             .last
                                //                             .contains("pdf")) {
                                //                           return Container(
                                //                               child: Column(
                                //                                   children: [
                                //                                 SizedBox(
                                //                                   height: Screens
                                //                                           .padingHeight(
                                //                                               context) *
                                //                                       0.01,
                                //                                 ),
                                //                                 Row(
                                //                                     mainAxisAlignment:
                                //                                         MainAxisAlignment
                                //                                             .spaceBetween,
                                //                                     children: [
                                //                                       Container(
                                //                                         decoration:
                                //                                             BoxDecoration(),
                                //                                         width: Screens.width(
                                //                                                 context) *
                                //                                             0.09,
                                //                                         height: Screens.padingHeight(
                                //                                                 context) *
                                //                                             0.06,
                                //                                         child: Center(
                                //                                             child: Image.asset(
                                //                                                 "Assets/pdfimg.png")),
                                //                                       ),
                                //                                       Container(
                                //                                           padding:
                                //                                               EdgeInsets.all(
                                //                                                   10),
                                //                                           decoration:
                                //                                               BoxDecoration(),
                                //                                           width: Screens.width(
                                //                                                   context) *
                                //                                               0.6,
                                //                                           // height: Screens.padingHeight(context) * 0.06,
                                //                                           alignment:
                                //                                               Alignment
                                //                                                   .centerLeft,
                                //                                           child:
                                //                                               Text(
                                //                                             context
                                //                                                 .watch<SiteOutController>()
                                //                                                 .files[i]
                                //                                                 .path
                                //                                                 .split('/')
                                //                                                 .last,
                                //                                           )),
                                //                                       Container(
                                //                                           width: Screens.width(
                                //                                                   context) *
                                //                                               0.1,
                                //                                           height: Screens.padingHeight(
                                //                                                   context) *
                                //                                               0.06,
                                //                                           child: IconButton(
                                //                                               onPressed: () {
                                //                                                 setState(() {
                                //                                                   context.read<SiteOutController>().files.removeAt(i);
                                //                                                 });
                                //                                               },
                                //                                               icon: Icon(
                                //                                                 Icons.cancel_rounded,
                                //                                                 color:
                                //                                                     Colors.grey,
                                //                                               )))
                                //                                     ])
                                //                               ]));
                                //                         } else if (context
                                //                             .read<
                                //                                 SiteOutController>()
                                //                             .files[i]
                                //                             .path
                                //                             .split('/')
                                //                             .last
                                //                             .contains("xlsx")) {
                                //                           return Container(
                                //                               child: Column(
                                //                                   children: [
                                //                                 SizedBox(
                                //                                   height: Screens
                                //                                           .padingHeight(
                                //                                               context) *
                                //                                       0.01,
                                //                                 ),
                                //                                 Row(
                                //                                     mainAxisAlignment:
                                //                                         MainAxisAlignment
                                //                                             .spaceBetween,
                                //                                     children: [
                                //                                       Container(
                                //                                           decoration:
                                //                                               BoxDecoration(),
                                //                                           width: Screens.width(
                                //                                                   context) *
                                //                                               0.09,
                                //                                           height: Screens.padingHeight(
                                //                                                   context) *
                                //                                               0.06,
                                //                                           child: Center(
                                //                                               child:
                                //                                                   Image.asset("Assets/xcelomg.png"))),
                                //                                       Container(
                                //                                           padding:
                                //                                               EdgeInsets.all(
                                //                                                   10),
                                //                                           decoration:
                                //                                               BoxDecoration(),
                                //                                           width: Screens.width(
                                //                                                   context) *
                                //                                               0.6,
                                //                                           // height: Screens.padingHeight(context) * 0.06,
                                //                                           alignment:
                                //                                               Alignment
                                //                                                   .centerLeft,
                                //                                           child:
                                //                                               Text(
                                //                                             context
                                //                                                 .read<SiteOutController>()
                                //                                                 .files[i]
                                //                                                 .path
                                //                                                 .split('/')
                                //                                                 .last,
                                //                                           )),
                                //                                       Container(
                                //                                           width: Screens.width(
                                //                                                   context) *
                                //                                               0.1,
                                //                                           height: Screens.padingHeight(
                                //                                                   context) *
                                //                                               0.06,
                                //                                           child: IconButton(
                                //                                               onPressed: () {
                                //                                                 setState(() {
                                //                                                   context.read<SiteOutController>().files.removeAt(i);
                                //                                                 });
                                //                                               },
                                //                                               icon: Icon(
                                //                                                 Icons.cancel_rounded,
                                //                                                 color:
                                //                                                     Colors.grey,
                                //                                               )))
                                //                                     ])
                                //                               ])
                                //                               // )
                                //                               );
                                //                         }
                                //                         return Container(
                                //                             child: Column(
                                //                                 children: [
                                //                               SizedBox(
                                //                                 height: Screens
                                //                                         .padingHeight(
                                //                                             context) *
                                //                                     0.01,
                                //                               ),
                                //                               Row(
                                //                                   mainAxisAlignment:
                                //                                       MainAxisAlignment
                                //                                           .spaceBetween,
                                //                                   children: [
                                //                                     Container(
                                //                                         decoration:
                                //                                             BoxDecoration(),
                                //                                         width: Screens.width(
                                //                                                 context) *
                                //                                             0.09,
                                //                                         height: Screens.padingHeight(
                                //                                                 context) *
                                //                                             0.06,
                                //                                         child: Center(
                                //                                             child: Image.asset(
                                //                                                 "Assets/txt.png"))),
                                //                                     Container(
                                //                                         padding:
                                //                                             EdgeInsets.all(
                                //                                                 10),
                                //                                         decoration:
                                //                                             BoxDecoration(),
                                //                                         width: Screens.width(
                                //                                                 context) *
                                //                                             0.6,
                                //                                         // height: Screens.padingHeight(context) * 0.06,
                                //                                         alignment:
                                //                                             Alignment
                                //                                                 .centerLeft,
                                //                                         child: Text(
                                //                                           context
                                //                                               .watch<
                                //                                                   SiteOutController>()
                                //                                               .files[
                                //                                                   i]
                                //                                               .path
                                //                                               .split(
                                //                                                   '/')
                                //                                               .last,
                                //                                         )),
                                //                                     Container(
                                //                                         width: Screens.width(
                                //                                                 context) *
                                //                                             0.1,
                                //                                         height: Screens.padingHeight(
                                //                                                 context) *
                                //                                             0.06,
                                //                                         child: IconButton(
                                //                                             onPressed: () {
                                //                                               setState(
                                //                                                   () {
                                //                                                 context.read<SiteOutController>().files.removeAt(i);
                                //                                               });
                                //                                             },
                                //                                             icon: Icon(
                                //                                               Icons
                                //                                                   .cancel_rounded,
                                //                                               color:
                                //                                                   Colors.grey,
                                //                                             )))
                                //                                   ])
                                //                             ]));
                                //                       })),
                                //         ])),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.015,
                                ),
                                // TextFormField(
                                //     onTap: () {
                                //       context
                                //           .read<SiteOutController>()
                                //           .showNextVisitOn(context);
                                //     },
                                //     controller: context
                                //         .read<SiteOutController>()
                                //         .mycontroller[13],
                                //     // validator: (value) {
                                //     //   if (value!.isEmpty) {
                                //     //     return "Choose Next Visit Date";
                                //     //   }
                                //     //   return null;
                                //     // },
                                //     readOnly: true,
                                //     decoration: InputDecoration(
                                //         labelText: 'Next Visit On', //
                                //         border: UnderlineInputBorder(),
                                //         labelStyle: theme.textTheme.bodyText1!
                                //             .copyWith(color: Colors.grey),
                                //         enabledBorder: UnderlineInputBorder(
                                //           borderSide:
                                //               BorderSide(color: Colors.grey),
                                //           //  when the TextFormField in unfocused
                                //         ),
                                //         focusedBorder: UnderlineInputBorder(
                                //           borderSide:
                                //               BorderSide(color: Colors.grey),
                                //           //  when the TextFormField in focused
                                //         ),
                                //         errorBorder: UnderlineInputBorder(),
                                //         focusedErrorBorder: UnderlineInputBorder(),
                                //         suffixIcon:
                                //             Icon(Icons.date_range_outlined))),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.015,
                                ),
                               Container(
                                width: Screens.width(context),
          
                                        // height:Screens.bodyheight(context)*0.28 ,
                                        decoration: BoxDecoration(
                                            // color: Colors.amber,
                                            border: Border.all(color: theme.primaryColor),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                Screens.width(context) * 0.02,
                                            vertical:
                                                Screens.bodyheight(context) *
                                                    0.01),
                                child: Column(children: [
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
                                                            color: theme.primaryColor),
                                                  ),
                                                  Checkbox(
                                                      checkColor:
                                                          Colors.white,
                                                      activeColor: theme.primaryColor,
                                                      side: BorderSide(
                                                          color: theme.primaryColor),
                                                      value: context
                                                          .read<
                                                              SiteOutController>()
                                                          .sitevisitreq,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          context
                                                              .read<
                                                                  SiteOutController>()
                                                              .checksitevisit(
                                                                  value!);
                                                        });
                                                      }),
                                                ],
                                              ),
                                            ),
          
                                            //time date
          
                                            context
                                                        .read<SiteOutController>()
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
                                                                        SiteOutController>()
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
                                                                  SiteOutController>()
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
                                                              //     .read<SiteOutController>()
                                                              //     .clearbool();
                                                              context
                                                                  .read<
                                                                      SiteOutController>()
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
                                                                            SiteOutController>()
                                                                        .visitDatebool ==
                                                                    false) {
                                                              setState(() {
                                                                context
                                                                    .read<
                                                                        SiteOutController>()
                                                                    .visitDatebool = true;
                                                              });
          
                                                              return 'Please Enter Date';
                                                            } else if (value
                                                                .isNotEmpty) {
                                                              setState(() {
                                                                context
                                                                    .read<
                                                                        SiteOutController>()
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
                                                                              SiteOutController>()
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
                                                                        SiteOutController>()
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
                                                                  SiteOutController>()
                                                              .mycontroller[15],
          
                                                          onTap: () {
                                                            setState(() {
                                                              // context
                                                              //     .read<SiteOutController>()
                                                              //     .clearbool();
                                                              context
                                                                  .read<
                                                                      SiteOutController>()
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
                                                                            SiteOutController>()
                                                                        .visittimebool ==
                                                                    false) {
                                                              setState(() {
                                                                context
                                                                    .read<
                                                                        SiteOutController>()
                                                                    .visittimebool = true;
                                                              });
          
                                                              return 'Enter the Time';
                                                            } else if (value
                                                                .isNotEmpty) {
                                                              setState(() {
                                                                context
                                                                    .read<
                                                                        SiteOutController>()
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
                                                                                SiteOutController>()
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
                                                              SiteOutController>()
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
                                                        .read<SiteOutController>()
                                                        .errorTime ==
                                                    ''
                                                ? Container()
                                                : Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      "${context.read<SiteOutController>().errorTime}",
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                               
                            context
                                                        .read<SiteOutController>()
                                                        .sitevisitreq ==
                                                    false
                                                ? Container():    Stack(
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
                                                                SiteOutController>()
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
                                                        .read<SiteOutController>()
                                                        .mycontroller[16],
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
                                                        0.70,
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
                               
                               ],),)
                                // Container(
                                //   width: Screens.width(context),
                                //   alignment: Alignment.centerLeft,
                                //   height: Screens.bodyheight(context) * 0.05,
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: [
                                //       Container(
                                //         width: Screens.width(context) * 0.05,
                                //         // color: Colors.amber,
                                //         child: Checkbox(
                                //           value: context
                                //               .read<SiteOutController>()
                                //               .value,
                                //           onChanged: (value) {
                                //             setState(() {
                                //               context
                                //                   .read<SiteOutController>()
                                //                   .checkboxselect(value!);
                                //               // context
                                //               //     .read<SiteOutController>()
                                //               //     .value = value;
                                //             });
                                //           },
                                //         ),
                                //       ),
                                //       InkWell(
                                //         onTap: () {
                                //           context
                                //               .read<SiteOutController>()
                                //               .checkboxselect2();
                                //         },
                                //         child: Container(
                                //           height:
                                //               Screens.bodyheight(context) * 0.05,
                                //           alignment: Alignment.centerLeft,
                                //           child: Text(
                                //             "  Create as Enquiry",
                                //             style: TextStyle(
                                //                 color: theme.primaryColor,
                                //                 fontWeight: FontWeight.bold),
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                  
                                // context.read<SiteOutController>().value == false
                                //     ? Container()
                                //     : TextFormField(
                                //         onTap: () {
                                //           context
                                //               .read<SiteOutController>()
                                //               .showNextFollowupDate(context);
                                //         },
                                //         controller: context
                                //             .read<SiteOutController>()
                                //             .mycontroller[14],
                                //         // validator: (value) {
                                //         //   if (value!.isEmpty) {
                                //         //     return "Choose Next Followup Date";
                                //         //   }
                                //         //   return null;
                                //         // },
                                //         readOnly: true,
                                //         decoration: InputDecoration(
                                //             labelText: 'Next Followup Date', //
                                //             border: UnderlineInputBorder(),
                                //             labelStyle: theme.textTheme.bodyText1!
                                //                 .copyWith(color: Colors.grey),
                                //             enabledBorder: UnderlineInputBorder(
                                //               borderSide:
                                //                   BorderSide(color: Colors.grey),
                                //               //  when the TextFormField in unfocused
                                //             ),
                                //             focusedBorder: UnderlineInputBorder(
                                //               borderSide:
                                //                   BorderSide(color: Colors.grey),
                                //               //  when the TextFormField in focused
                                //             ),
                                //             errorBorder: UnderlineInputBorder(),
                                //             focusedErrorBorder:
                                //                 UnderlineInputBorder(),
                                //             suffixIcon:
                                //                 Icon(Icons.date_range_outlined))),
                  
                                
                                // Container(
                                //   width: Screens.width(context),
                                //   alignment: Alignment.centerLeft,
                                //   height: Screens.bodyheight(context) * 0.05,
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: [
                                //       Container(
                                //         width: Screens.width(context) * 0.05,
                                //         // color: Colors.amber,
                                //         child: Checkbox(
                                //           value: context
                                //               .read<SiteOutController>()
                                //               .valueLead,
                                //           onChanged: (value) {
                                //             setState(() {
                                //               context
                                //                   .read<SiteOutController>()
                                //                   .checkboxselectLead(value!);
                                //               // context
                                //               //     .read<SiteOutController>()
                                //               //     .value = value;
                                //             });
                                //           },
                                //         ),
                                //       ),
                                //       InkWell(
                                //         onTap: () {
                                //           context
                                //               .read<SiteOutController>()
                                //               .checkboxselectLead2();
                                //         },
                                //         child: Container(
                                //           height:
                                //               Screens.bodyheight(context) * 0.05,
                                //           alignment: Alignment.centerLeft,
                                //           child: Text(
                                //             "  Create as Lead",
                                //             style: TextStyle(
                                //                 color: theme.primaryColor,
                                //                 fontWeight: FontWeight.bold),
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // Container(
                                //   width: Screens.width(context),
                                //   alignment: Alignment.centerLeft,
                                //   height: Screens.bodyheight(context) * 0.05,
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: [
                                //       Container(
                                //         width: Screens.width(context) * 0.05,
                                //         // color: Colors.amber,
                                //         child: Checkbox(
                                //           value: context
                                //               .read<SiteOutController>()
                                //               .assignTo,
                                //           onChanged: (value) {
                                //             setState(() {
                                //               context
                                //                   .read<SiteOutController>()
                                //                   .checkboxAssignTo(value!);
                                //               // context
                                //               //     .read<SiteOutController>()
                                //               //     .value = value;
                                //             });
                                //           },
                                //         ),
                                //       ),
                                //       InkWell(
                                //         onTap: () {},
                                //         child: Container(
                                //           height:
                                //               Screens.bodyheight(context) * 0.05,
                                //           alignment: Alignment.centerLeft,
                                //           child: Text(
                                //             "  Assign To",
                                //             style: TextStyle(
                                //                 color: theme.primaryColor,
                                //                 fontWeight: FontWeight.bold),
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                  
                                // context.read<SiteOutController>().assignTo == false
                                //     ? SizedBox()
                                //     : SizedBox(
                                //         height: Screens.bodyheight(context) * 0.015,
                                //       ),
                                // context.read<SiteOutController>().assignTo == false
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
                                //                     .read<SiteOutController>()
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
                              ,  SizedBox(
                                  height: Screens.bodyheight(context) * 0.015,
                                ),
                                SizedBox(
                                  width: Screens.width(context),
                                  height: Screens.bodyheight(context) * 0.07,
                                  child: ElevatedButton(
                                      onPressed:context
                                            .watch<SiteOutController>().isloading==true?null: () {
                                        // controller:
                                        context
                                            .read<SiteOutController>()
                                            .validateCheckOut(context,context
                                            .read<SiteOutController>().mycontroller[1].text);
                                        // // context
                                        //     .read<SiteOutController>()
                                        //     .callAddEnq(context);
                                        // context.read<SiteOutController>().callAlertDialog(context, "Successfully Created..!!");
                                      },
                                      child:context
                                            .watch<SiteOutController>().isloading==true?Center(child: SizedBox(
                                               height: Screens.padingHeight(context)*0.06,
                                          width: Screens.width(context)*0.05,
                                              child: CircularProgressIndicator(color: Colors.white,)),): Text("Site Check-Out")),
                                )
                              ],
                            ),
                          ),
                        ),
                        //
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
