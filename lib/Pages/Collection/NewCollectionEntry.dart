// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_new, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps, prefer_is_empty, unnecessary_null_comparison, avoid_unnecessary_containers

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/CollectionController/NewCollectionEntryCotroller.dart';
import 'package:sellerkit/Widgets/Appbar.dart';
import 'package:sellerkit/Widgets/Navi3.dart';

class NewCollectionEntry extends StatefulWidget {
  NewCollectionEntry({Key? key}) : super(key: key);

  @override
  State<NewCollectionEntry> createState() => NewCollectionEntryState();
}

class NewCollectionEntryState extends State<NewCollectionEntry> {
  final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();
  ScrollController? controller;

  @override
  void initState() {
    // scaffoldKey1;
    super.initState();
    controller = ScrollController();

    //
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        if (NewCollectionContoller.comefromoutStanding.isEmpty &&
            NewCollectionContoller.comefromSiteOut.isEmpty &&
            NewCollectionContoller.comefromAcc.isEmpty) {
          context.read<NewCollectionContoller>().init(context);
        } else if (NewCollectionContoller.comefromoutStanding.isNotEmpty) {
          context.read<NewCollectionContoller>().init(context);
          // context.read<NewCollectionContoller>().visitId = iscomfromVisitId!;
          context
              .read<NewCollectionContoller>()
              .mapvaluefromOutstanding(context);
        } else if (NewCollectionContoller.comefromSiteOut.isNotEmpty) {
          context.read<NewCollectionContoller>().init(context);
          context.read<NewCollectionContoller>().mapvaluefromSiteOut(context);
        }else if (NewCollectionContoller.comefromAcc.isNotEmpty) {
          context.read<NewCollectionContoller>().init(context);
          context.read<NewCollectionContoller>().mapvaluefromAccounts(context);
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
      Get.offAllNamed(ConstantRoutes.collectionlist);
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
          key: scaffoldKey1,
          drawerEnableOpenDragGesture: false,
          // backgroundColor: Colors.grey[200],
          /// resizeToAvoidBottomInset: true,
          // key: scaffoldKey1,
          appBar: appbar("New Collection Entry", scaffoldKey1, theme, context),
          drawer: drawer3(context),
          // body: ChangeNotifierProvider<NewCollectionContoller>(
          //     create: (context) => NewCollectionContoller(),
          //     builder: (context, child) {
          //       return Consumer<NewCollectionContoller>(
          //           builder: (BuildContext context, provi, Widget? child) {
          // return
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
            child: PageView(
              //  clipBehavior :Clip.none,
              physics: new NeverScrollableScrollPhysics(),
              controller: context.read<NewCollectionContoller>().pageController,
              onPageChanged: (index) {
                log("index: ${index}");
                setState(() {
                  context.read<NewCollectionContoller>().pageChanged = index;
                });
                print(context.read<NewCollectionContoller>().pageChanged);
              },
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      FocusScope.of(context).unfocus();
                    });
                  },
                  onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.collectionlist);
                      });
                    }
                  },
                  child: FirstPage(
                    context,
                    theme,
                  ),
                ),
                SecondPage(context, theme),
                SingleChildScrollView(child: ThirdPage(context, theme)),
              ],
            ),
          )
          //   });
          // })
          ),
    );
  }

  Container ThirdPage(BuildContext context, ThemeData theme) {
    return Container(
        color: Colors.white,

        // color: Colors.blue,
        width: Screens.width(context),
        height: Screens.bodyheight(context),
        padding: EdgeInsets.only(
            left: Screens.width(context) * 0.01,
            right: Screens.width(context) * 0.01,
            bottom: Screens.bodyheight(context) * 0.01,
            top: Screens.bodyheight(context) * 0.02),
        child: Form(
          key: context.read<NewCollectionContoller>().formkey[1],
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Screens.width(context) * 0.03,
                      vertical: Screens.bodyheight(context) * 0.008),
                  width: Screens.width(context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: theme.primaryColor)),
                  child: Column(
                    children: [
                      Container(
                        width: Screens.width(context),
                        child: Text(
                          "Payment Mode",
                          style: theme.textTheme.headline6
                              ?.copyWith(color: theme.primaryColor),
                        ),
                      ),

                      TextFormField(
                          controller: context
                              .read<NewCollectionContoller>()
                              .mycontroller[15],
                          readOnly: context
                                  .watch<NewCollectionContoller>()
                                  .getProduct
                                  .isEmpty
                              ? false
                              : true,
                          validator: (value) {
                            // double value2 = 0.0;
                            // if (value!.isNotEmpty) {
                            //   double value2 = double.parse(value.toString());
                            // }
                            if (value!.isEmpty || value == '0.0' ||value == '0') {
                              return "Enter Amount..";
                            } else
                              return null;
                          },
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*')),
                          ],
                          // keyboardType:
                          //     TextInputType.numberWithOptions(decimal: true),

                          // inputFormatters: [
                          //   new LengthLimitingTextInputFormatter(10),
                          // ],
                          // keyboardType: TextInputType.number,
                          //  keyboardType: TextInputType.numberWithOptions(decimal: true),
                          // inputFormatters: [DecimalTextInputFormatter()],
                          decoration: InputDecoration(
                            labelText: 'Amount',
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
                            border: UnderlineInputBorder(),
                            // enabledBorder: UnderlineInputBorder(),
                            // focusedBorder: UnderlineInputBorder(),
                            errorBorder: UnderlineInputBorder(),
                            focusedErrorBorder: UnderlineInputBorder(),
                          )),
                      // Container(
                      //   width: Screens.width(context),
                      //   child: DropdownButton(
                      //     hint: Text("Select Mode"),
                      //     // value: context.read<EnquiryUserContoller>(). valueChosedReason,
                      //     //dropdownColor:Colors.green,
                      //     icon: Icon(Icons.arrow_drop_down),
                      //     iconSize: 30,
                      //     style: TextStyle(color: Colors.black, fontSize: 16),
                      //     isExpanded: true,
                      //     value:
                      //         context.read<NewCollectionContoller>().paymentmode,
                      //     onChanged: (val) {
                      //       // setState(() {
                      //       //   valueChosedReason = val.toString();
                      //       //   print(val.toString());
                      //       //   print("valavalaa: .........." +
                      //       //       valueChosedReason.toString());
                      //       // });
                      //       context
                      //           .read<NewCollectionContoller>()
                      //           .resonChoosed(val.toString());
                      //     },
                      //     items: <String>["Cash", "Cheque", "Card", "UPI", "DD"]
                      //         .map((String value) {
                      //       return DropdownMenuItem(
                      //           value: value, child: Text(value.toString()));
                      //     }).toList(),
                      //   ),
                      // ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.02,
                      ),
                      context
                              .read<NewCollectionContoller>()
                              .paymentmodeErro
                              .isEmpty
                          ? Container()
                          : Container(
                              width: Screens.width(context),
                              child: Text(
                                "${context.watch<NewCollectionContoller>().paymentmodeErro}",
                                style: theme.textTheme.bodyText1!
                                    .copyWith(color: Colors.red),
                              ),
                            ),
                      Container(
                        width: Screens.width(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  context
                                      .read<NewCollectionContoller>()
                                      .paymodeSelect('Cash');
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.15,
                                height: Screens.bodyheight(context) * 0.04,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: context
                                              .read<NewCollectionContoller>()
                                              .returnboolValue('Cash') ==
                                          true
                                      ? theme.primaryColor
                                      : Colors.grey[300],
                                ),
                                child: Text(
                                  'Cash',
                                  style: theme.textTheme.bodyText1!.copyWith(
                                    color: context
                                                .read<NewCollectionContoller>()
                                                .returnboolValue('Cash') ==
                                            true
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  context
                                      .read<NewCollectionContoller>()
                                      .paymodeSelect('Card');
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.15,
                                height: Screens.bodyheight(context) * 0.04,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: context
                                              .read<NewCollectionContoller>()
                                              .returnboolValue('Card') ==
                                          true
                                      ? theme.primaryColor
                                      : Colors.grey[300],
                                ),
                                child: Text(
                                  'Card',
                                  style: theme.textTheme.bodyText1!.copyWith(
                                    color: context
                                                .read<NewCollectionContoller>()
                                                .returnboolValue('Card') ==
                                            true
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  context
                                      .read<NewCollectionContoller>()
                                      .paymodeSelect('Cheque');
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.15,
                                height: Screens.bodyheight(context) * 0.04,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: context
                                              .read<NewCollectionContoller>()
                                              .returnboolValue('Cheque') ==
                                          true
                                      ? theme.primaryColor
                                      : Colors.grey[300],
                                ),
                                child: Text(
                                  'Cheque',
                                  style: theme.textTheme.bodyText1!.copyWith(
                                    color: context
                                                .read<NewCollectionContoller>()
                                                .returnboolValue('Cheque') ==
                                            true
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  context
                                      .read<NewCollectionContoller>()
                                      .paymodeSelect('NEFT');
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.15,
                                height: Screens.bodyheight(context) * 0.04,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: context
                                              .read<NewCollectionContoller>()
                                              .returnboolValue('NEFT') ==
                                          true
                                      ? theme.primaryColor
                                      : Colors.grey[300],
                                ),
                                child: Text(
                                  'NEFT',
                                  style: theme.textTheme.bodyText1!.copyWith(
                                    color: context
                                                .read<NewCollectionContoller>()
                                                .returnboolValue('NEFT') ==
                                            true
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  context
                                      .read<NewCollectionContoller>()
                                      .paymodeSelect('UPI');
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.15,
                                height: Screens.bodyheight(context) * 0.04,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: context
                                              .read<NewCollectionContoller>()
                                              .returnboolValue('UPI') ==
                                          true
                                      ? theme.primaryColor
                                      : Colors.grey[300],
                                ),
                                child: Text(
                                  'UPI',
                                  style: theme.textTheme.bodyText1!.copyWith(
                                    color: context
                                                .read<NewCollectionContoller>()
                                                .returnboolValue('UPI') ==
                                            true
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // Visibility(
                      //   visible: context
                      //       .read<NewCollectionContoller>()
                      //       .returnboolValue('Cash'),
                      //   child: Column(
                      //     children: [
                      //       TextFormField(
                      //           // controller: context
                      //           //     .read<NewCollectionContoller>()
                      //           //     .mycontroller[6],
                      //           // validator: (value) {
                      //           //   if (value!.isEmpty) {
                      //           //     return "Enter Reference";
                      //           //   }
                      //           //   return null;
                      //           // },
                      //           decoration: InputDecoration(
                      //         labelText: 'Reference',
                      //         labelStyle: theme.textTheme.bodyText1!
                      //             .copyWith(color: Colors.grey),
                      //         enabledBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: Colors.grey),
                      //           //  when the TextFormField in unfocused
                      //         ),
                      //         focusedBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: Colors.grey),
                      //           //  when the TextFormField in focused
                      //         ),
                      //         border: UnderlineInputBorder(),
                      //         // enabledBorder: UnderlineInputBorder(),
                      //         // focusedBorder: UnderlineInputBorder(),
                      //         errorBorder: UnderlineInputBorder(),
                      //         focusedErrorBorder: UnderlineInputBorder(),
                      //       )),
                      //     ],
                      //   ),
                      // ),
                      Visibility(
                        visible: context
                            .read<NewCollectionContoller>()
                            .returnboolValue('NEFT'),
                        child: Column(
                          children: [
                            TextFormField(
                                controller: context
                                    .read<NewCollectionContoller>()
                                    .mycontroller[19],
                                validator: context
                                            .read<NewCollectionContoller>()
                                            .returnboolValue('NEFT') ==
                                        true
                                    ? (value) {
                                        if (value!.isEmpty) {
                                          return "Enter Reference";
                                        }
                                        return null;
                                      }
                                    : (value) {},
                                decoration: InputDecoration(
                                  labelText: 'NEFT Reference',
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
                                  border: UnderlineInputBorder(),
                                  // enabledBorder: UnderlineInputBorder(),
                                  // focusedBorder: UnderlineInputBorder(),
                                  errorBorder: UnderlineInputBorder(),
                                  focusedErrorBorder: UnderlineInputBorder(),
                                )),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: context
                            .read<NewCollectionContoller>()
                            .returnboolValue('UPI'),
                        child: Column(
                          children: [
                            TextFormField(
                                controller: context
                                    .read<NewCollectionContoller>()
                                    .mycontroller[20],
                                validator: context
                                            .read<NewCollectionContoller>()
                                            .returnboolValue('UPI') ==
                                        true
                                    ? (value) {
                                        if (value!.isEmpty) {
                                          return "Enter Reference";
                                        }
                                        return null;
                                      }
                                    : (value) {},
                                decoration: InputDecoration(
                                  labelText: 'UPI Reference',
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
                                  border: UnderlineInputBorder(),
                                  // enabledBorder: UnderlineInputBorder(),
                                  // focusedBorder: UnderlineInputBorder(),
                                  errorBorder: UnderlineInputBorder(),
                                  focusedErrorBorder: UnderlineInputBorder(),
                                )),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: context
                            .read<NewCollectionContoller>()
                            .returnboolValue('Card'),
                        child: Column(
                          children: [
                            TextFormField(
                                controller: context
                                    .read<NewCollectionContoller>()
                                    .mycontroller[16],
                                validator: context
                                            .read<NewCollectionContoller>()
                                            .returnboolValue('Card') ==
                                        true
                                    ? (value) {
                                        if (value!.isEmpty) {
                                          return "Enter Reference";
                                        }
                                        return null;
                                      }
                                    : (value) {},
                                decoration: InputDecoration(
                                  labelText: 'Card Reference',
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
                                  border: UnderlineInputBorder(),
                                  // enabledBorder: UnderlineInputBorder(),
                                  // focusedBorder: UnderlineInputBorder(),
                                  errorBorder: UnderlineInputBorder(),
                                  focusedErrorBorder: UnderlineInputBorder(),
                                )),
                            SizedBox(
                              height: Screens.bodyheight(context) * 0.02,
                            ),
                            GetAttachment(theme, context),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: context
                            .read<NewCollectionContoller>()
                            .returnboolValue('Cheque'),
                        child: Column(
                          children: [
                            // TextFormField(
                            //     // controller: context
                            //     //     .read<NewCollectionContoller>()
                            //     //     .mycontroller[6],
                            //     // validator: (value) {
                            //     //   if (value!.isEmpty) {
                            //     //     return "Enter Reference";
                            //     //   }
                            //     //   return null;
                            //     // },
                            //     decoration: InputDecoration(
                            //   labelText: 'Cheque No',
                            //   labelStyle: theme.textTheme.bodyText1!
                            //       .copyWith(color: Colors.grey),
                            //   enabledBorder: UnderlineInputBorder(
                            //     borderSide: BorderSide(color: Colors.grey),
                            //     //  when the TextFormField in unfocused
                            //   ),
                            //   focusedBorder: UnderlineInputBorder(
                            //     borderSide: BorderSide(color: Colors.grey),
                            //     //  when the TextFormField in focused
                            //   ),
                            //   border: UnderlineInputBorder(),
                            //   // enabledBorder: UnderlineInputBorder(),
                            //   // focusedBorder: UnderlineInputBorder(),
                            //   errorBorder: UnderlineInputBorder(),
                            //   focusedErrorBorder: UnderlineInputBorder(),
                            // )),
                            TextFormField(
                                controller: context
                                    .read<NewCollectionContoller>()
                                    .mycontroller[17],
                                onTap: () {
                                  context
                                      .read<NewCollectionContoller>()
                                      .showchequeDate(context);
                                },
                                validator: context
                                            .read<NewCollectionContoller>()
                                            .returnboolValue('Cheque') ==
                                        true
                                    ? (value) {
                                        if (value!.isEmpty) {
                                          return "Enter Cheque Date";
                                        }
                                        return null;
                                      }
                                    : (value) {},
                                    readOnly: true,
                                decoration: InputDecoration(
                                  labelText: 'Cheque Date',
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
                                  border: UnderlineInputBorder(),
                                  // enabledBorder: UnderlineInputBorder(),
                                  // focusedBorder: UnderlineInputBorder(),
                                  errorBorder: UnderlineInputBorder(),
                                  focusedErrorBorder: UnderlineInputBorder(),
                                )),
                            TextFormField(
                                controller: context
                                    .read<NewCollectionContoller>()
                                    .mycontroller[18],
                                validator: context
                                            .read<NewCollectionContoller>()
                                            .returnboolValue('Cheque') ==
                                        true
                                    ? (value) {
                                        if (value!.isEmpty) {
                                          return "Enter Reference";
                                        }
                                        return null;
                                      }
                                    : (value) {},
                                decoration: InputDecoration(
                                  labelText: 'Cheque Reference',
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
                                  border: UnderlineInputBorder(),
                                  // enabledBorder: UnderlineInputBorder(),
                                  // focusedBorder: UnderlineInputBorder(),
                                  errorBorder: UnderlineInputBorder(),
                                  focusedErrorBorder: UnderlineInputBorder(),
                                )),

                            SizedBox(
                              height: Screens.bodyheight(context) * 0.02,
                            ),
                            GetAttachment(theme, context),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.01,
                      ),
                      TextFormField(
                          controller: context
                              .read<NewCollectionContoller>()
                              .mycontroller[21],
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "Enter Reference";
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            labelText: 'Remarks',
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
                            border: UnderlineInputBorder(),
                            // enabledBorder: UnderlineInputBorder(),
                            // focusedBorder: UnderlineInputBorder(),
                            errorBorder: UnderlineInputBorder(),
                            focusedErrorBorder: UnderlineInputBorder(),
                          )),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Screens.width(context) * 0.3,
                      height: Screens.bodyheight(context) * 0.07,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: context
                                          .read<NewCollectionContoller>()
                                          .saveprogress ==
                                      true
                                  ? Colors.grey
                                  : theme.primaryColor),
                          onPressed: context
                                      .read<NewCollectionContoller>()
                                      .saveprogress ==
                                  true
                              ? null
                              : () {
                                  context
                                      .read<NewCollectionContoller>()
                                      .pageController
                                      .animateToPage(
                                          --context
                                              .read<NewCollectionContoller>()
                                              .pageChanged,
                                          duration: Duration(milliseconds: 250),
                                          curve: Curves.bounceIn);
                                },
                          child: Icon(Icons.keyboard_arrow_left)),
                    ),
                    SizedBox(
                      width: Screens.width(context) * 0.3,
                      height: Screens.bodyheight(context) * 0.07,
                      child: ElevatedButton(
                          onPressed: context
                                      .read<NewCollectionContoller>()
                                      .saveprogress ==
                                  true
                              ? null
                              : () {
                                  FocusScopeNode focus = FocusScope.of(context);
                                  if (!focus.hasPrimaryFocus) {
                                    focus.unfocus();
                                  }
                                  // provi.pageController.animateToPage(++provi.pageChanged,
                                  //     duration: Duration(milliseconds: 250),
                                  //     curve: Curves.bounceIn);

                                  context
                                      .read<NewCollectionContoller>()
                                      .validateFinal(
                                        context,
                                      );
                                  // log("oldcutomer: " +
                                  //     context
                                  //         .read<NewCollectionContoller>()
                                  //         .oldcutomer
                                  //         .toString());
                                },
                          child: context
                                      .read<NewCollectionContoller>()
                                      .saveprogress ==
                                  true
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Icon(Icons.save)),
                    ),
                  ],
                )
              ]),
        ));
  }

  Container GetAttachment(ThemeData theme, BuildContext context) {
    return Container(
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Attachment',
                  style: theme.textTheme.subtitle1?.copyWith(
                      color: context
                                  .read<NewCollectionContoller>()
                                  .fileValidation ==
                              true
                          ? Colors.red
                          : Colors.black)),
              Row(
                children: [
                  Container(
                      // alignment: Alignment.center,
                      height: Screens.padingHeight(context) * 0.06,
                      width: Screens.width(context) * 0.13,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: context
                                      .read<NewCollectionContoller>()
                                      .fileValidation ==
                                  true
                              ? Colors.red
                              : theme.primaryColor
                          // shape: BoxShape
                          //     .circle
                          ),
                      child: Center(
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                // showtoast();
                                if (context
                                        .read<NewCollectionContoller>()
                                        .files
                                        .length ==
                                    0) {
                                  setState(() {
                                    context
                                        .read<NewCollectionContoller>()
                                        .imagetoBinary(ImageSource.camera);
                                    context
                                        .read<NewCollectionContoller>()
                                        .fileValidation = false;
                                  });
                                } else {
                                  print("obAAAAAject");
                                  context
                                      .read<NewCollectionContoller>()
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
                      height: Screens.padingHeight(context) * 0.06,
                      width: Screens.width(context) * 0.13,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: context
                                      .read<NewCollectionContoller>()
                                      .fileValidation ==
                                  true
                              ? Colors.red
                              : theme.primaryColor
                          // shape: BoxShape
                          //     .circle
                          ),
                      child: Center(
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                // log("files length" + files.length.toString());
                                // showtoast();
                                if (context
                                        .read<NewCollectionContoller>()
                                        .files
                                        .length ==
                                    0) {
                                  setState(() {
                                    context
                                        .read<NewCollectionContoller>()
                                        .selectattachment();

                                    context
                                        .read<NewCollectionContoller>()
                                        .fileValidation = false;
                                  });
                                } else {
                                  print("obAAAAAject");

                                  context
                                      .read<NewCollectionContoller>()
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
          context.read<NewCollectionContoller>().files == null
              ? Container(
                  height: Screens.padingHeight(context) * 0.3,
                  padding: EdgeInsets.only(
                    top: Screens.padingHeight(context) * 0.001,
                    right: Screens.padingHeight(context) * 0.015,
                    left: Screens.padingHeight(context) * 0.015,
                    bottom: Screens.padingHeight(context) * 0.015,
                  ),
                  child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Text(
                            "No Files Selected",
                            style: theme.textTheme.bodyText1!.copyWith(
                                color: context
                                            .read<NewCollectionContoller>()
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
                  height:
                      context.read<NewCollectionContoller>().files.length == 0
                          ? Screens.padingHeight(context) * 0.0
                          : Screens.padingHeight(context) * 0.09,
                  padding: EdgeInsets.only(
                    top: Screens.padingHeight(context) * 0.001,
                    right: Screens.padingHeight(context) * 0.015,
                    left: Screens.padingHeight(context) * 0.015,
                    bottom: Screens.padingHeight(context) * 0.015,
                  ),
                  child: ListView.builder(
                      itemCount:
                          context.read<NewCollectionContoller>().files.length,
                      itemBuilder: (BuildContext context, int i) {
                        if (context
                            .read<NewCollectionContoller>()
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
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(),
                                      width: Screens.width(context) * 0.09,
                                      height:
                                          Screens.padingHeight(context) * 0.06,
                                      child: Center(
                                          child:
                                              Image.asset("Assets/img.jpg"))),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(),
                                      width: Screens.width(context) * 0.6,
                                      // height: Screens.padingHeight(context) * 0.06,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        context
                                            .watch<NewCollectionContoller>()
                                            .files[i]
                                            .path
                                            .split('/')
                                            .last,
                                        // overflow: TextOverflow.ellipsis,
                                      )),
                                  Container(
                                      width: Screens.width(context) * 0.1,
                                      height:
                                          Screens.padingHeight(context) * 0.06,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              context
                                                  .read<
                                                      NewCollectionContoller>()
                                                  .files
                                                  .removeAt(i);
                                              context
                                                  .read<
                                                      NewCollectionContoller>()
                                                  .filedata
                                                  .removeAt(i);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.cancel_rounded,
                                            color: Colors.grey,
                                          )))
                                ])
                          ])
                              // )
                              );
                        } else if (context
                            .read<NewCollectionContoller>()
                            .files[i]
                            .path
                            .split('/')
                            .last
                            .contains("jpg")) {
                          return Container(
                              child: Column(children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(),
                                      width: Screens.width(context) * 0.09,
                                      height:
                                          Screens.padingHeight(context) * 0.06,
                                      child: Center(
                                          child:
                                              Image.asset("Assets/img.jpg"))),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(),
                                      width: Screens.width(context) * 0.6,
                                      // height: Screens.padingHeight(context) * 0.06,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        context
                                            .watch<NewCollectionContoller>()
                                            .files[i]
                                            .path
                                            .split('/')
                                            .last,
                                      )),
                                  Container(
                                      width: Screens.width(context) * 0.1,
                                      height:
                                          Screens.padingHeight(context) * 0.06,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              context
                                                  .read<
                                                      NewCollectionContoller>()
                                                  .files
                                                  .removeAt(i);
                                              context
                                                  .read<
                                                      NewCollectionContoller>()
                                                  .filedata
                                                  .removeAt(i);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.cancel_rounded,
                                            color: Colors.grey,
                                          )))
                                ])
                          ])
                              // )
                              );
                        }
                      
                      })),
        ]));
  }

  InkWell FirstPage(
    BuildContext context,
    ThemeData theme,
  ) {
    // return ChangeNotifierProvider<NewCollectionContoller>(
    //       create: (context) => NewCollectionContoller(),
    //       builder: (context, child) {
    //         return Consumer<NewCollectionContoller>(
    //           builder: (BuildContext context, provi, Widget? child) {
    return InkWell(
      onTap: () {
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) {
          focus.unfocus();
        }
      },
      child: (context
                  .read<NewCollectionContoller>()
                  .exceptionOnApiCall
                  .isEmpty &&
              context.read<NewCollectionContoller>().customerapicLoading ==
                  true)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (context
                      .read<NewCollectionContoller>()
                      .exceptionOnApiCall
                      .isNotEmpty &&
                  context.read<NewCollectionContoller>().customerapicLoading ==
                      false)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context
                            .read<NewCollectionContoller>()
                            .exceptionOnApiCall,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              : Container(
                  color: Colors.white,
                  width: Screens.width(context),
                  height: Screens.bodyheight(context),
                  padding: EdgeInsets.symmetric(
                      horizontal: Screens.width(context) * 0.03,
                      vertical: Screens.bodyheight(context) * 0.02),
                  child: SingleChildScrollView(
                    controller: controller,
                    scrollDirection: Axis.vertical,
                    child: Form(
                      key: context.read<NewCollectionContoller>().formkey[0],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.03,
                                vertical: Screens.bodyheight(context) * 0.008),
                            width: Screens.width(context),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: theme.primaryColor)),
                            child: Column(
                              children: [
                                Container(
                                  width: Screens.width(context),
                                  child: Text(
                                    "Customer Info",
                                    style: theme.textTheme.headline6
                                        ?.copyWith(color: theme.primaryColor),
                                  ),
                                ),
                                TextFormField(
                                    controller: context
                                        .read<NewCollectionContoller>()
                                        .mycontroller[0],
                                    // focusNode: context
                                    //     .read<NewCollectionContoller>()
                                    //     .focusNode2,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Mobile Number";
                                      } else if (value.length > 10 ||
                                          value.length < 10) {
                                        return "Enter a valid Mobile Number";
                                      }
                                      return null;
                                    },
                                    onEditingComplete: () {
                                      if (context
                                              .read<NewCollectionContoller>()
                                              .mycontroller[0]
                                              .text
                                              .length ==
                                          10) {
                                        context
                                            .read<NewCollectionContoller>()
                                            .callApi(context);
                                      }
                                    },
                                    onChanged: (v) {
                                      if (v.length == 10) {
                                        context
                                            .read<NewCollectionContoller>()
                                            .callApi(context);
                                      } else if (v.length != 10) {
                                        context
                                            .read<NewCollectionContoller>()
                                            .clearnum();
                                      }
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      new LengthLimitingTextInputFormatter(10),
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Mobile*',
                                      labelStyle: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
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
                                      border: UnderlineInputBorder(),
                                      // enabledBorder: UnderlineInputBorder(),
                                      // focusedBorder: UnderlineInputBorder(),
                                      errorBorder: UnderlineInputBorder(),
                                      focusedErrorBorder:
                                          UnderlineInputBorder(),
                                    )),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                                Center(
                                  child: Wrap(
                                      spacing: 5.0, // width
                                      runSpacing: 10.0, // height
                                      children: listContainersCustomertags(
                                        theme,
                                      )),
                                ),
                                // SizedBox(
                                //   height: Screens.bodyheight(context) * 0.005,
                                // ),
                                TextFormField(
                                    controller: context
                                        .read<NewCollectionContoller>()
                                        .mycontroller[1],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Customer";
                                      }
                                      return null;
                                    },
                                    onChanged: (v) {
                                      // setState(() {
                                      //   context
                                      //       .read<NewCollectionContoller>()
                                      //       .filterListcustomer(v);
                                      //   if (v.isEmpty) {
                                      //     context
                                      //         .read<NewCollectionContoller>()
                                      //         .customerbool = false;
                                      //   } else {
                                      //     context
                                      //         .read<NewCollectionContoller>()
                                      //         .customerbool = true;
                                      //   }
                                      // });
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Customer*',
                                      border: UnderlineInputBorder(),
                                      labelStyle: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
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
                                        .read<NewCollectionContoller>()
                                        .mycontroller[2],

                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return "Enter Contact Name";
                                    //   }
                                    //   return null;
                                    // },
                                    decoration: InputDecoration(
                                      labelText: 'Contact Name',
                                      labelStyle: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
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
                                      border: UnderlineInputBorder(),
                                      // enabledBorder: UnderlineInputBorder(),
                                      // focusedBorder: UnderlineInputBorder(),
                                      errorBorder: UnderlineInputBorder(),
                                      focusedErrorBorder:
                                          UnderlineInputBorder(),
                                    )),
                                TextFormField(
                                    controller: context
                                        .read<NewCollectionContoller>()
                                        .mycontroller[3],
                                    validator: (value) {
                                      if (value!.isNotEmpty) {
                                        if (value.length > 10 ||
                                            value.length < 10) {
                                          return "Enter a valid Mobile Number";
                                        }
                                      }
                                      return null;
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      new LengthLimitingTextInputFormatter(10),
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Alternate Mobile No',
                                      labelStyle: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
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
                                      border: UnderlineInputBorder(),
                                      // enabledBorder: UnderlineInputBorder(),
                                      // focusedBorder: UnderlineInputBorder(),
                                      errorBorder: UnderlineInputBorder(),
                                      focusedErrorBorder:
                                          UnderlineInputBorder(),
                                    )),
                                TextFormField(
                                    controller: context
                                        .read<NewCollectionContoller>()
                                        .mycontroller[4],
                                    validator: (value) {
                                      if (value!.isNotEmpty) {
                                        //   // context.read<SalesQuotationCon>().ffff =
                                        //   //     "Please Enter the Email Address";
                                        //   return "Please Enter the Email Address";
                                        if (!RegExp(
                                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                            .hasMatch(value.trim())) {
                                          // context.read<NewEnqController>().ffff ="Please Enter the Valid Email";
                                          return "Please Enter the Valid Email";
                                        }
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
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
                                      border: UnderlineInputBorder(),
                                      // enabledBorder: UnderlineInputBorder(),
                                      // focusedBorder: UnderlineInputBorder(),
                                      errorBorder: UnderlineInputBorder(),
                                      focusedErrorBorder:
                                          UnderlineInputBorder(),
                                    )),
                                TextFormField(
                                    maxLength: 15,
                                    controller: context
                                        .read<NewCollectionContoller>()
                                        .mycontroller[5],
                                    inputFormatters: [
                                      // FilteringTextInputFormatter.digitsOnly,
                                      new LengthLimitingTextInputFormatter(15),
                                    ],
                                    validator: (value) {
                                       if (value!.isNotEmpty) {
                                        if (value.length != 15) {
                                          return 'Enter Valid GST';
                                        }
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      counterText: '',
                                      labelText: 'GST No',
                                      labelStyle: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
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
                                      border: UnderlineInputBorder(),
                                      // enabledBorder: UnderlineInputBorder(),
                                      // focusedBorder: UnderlineInputBorder(),
                                      errorBorder: UnderlineInputBorder(),
                                      focusedErrorBorder:
                                          UnderlineInputBorder(),
                                    )),
                                TextFormField(
                                    maxLength: 15,
                                    controller: context
                                        .read<NewCollectionContoller>()
                                        .mycontroller[6],
                                         validator: (value) {
                                       if (value!.isNotEmpty) {
                                        if (value.length != 10) {
                                          return 'Enter Valid PAN';
                                        }
                                      }
                                      return null;
                                    },
                                    inputFormatters: [
                                      // FilteringTextInputFormatter.digitsOnly,
                                      new LengthLimitingTextInputFormatter(10),
                                    ],
                                    decoration: InputDecoration(
                                      counterText: '',
                                      labelText: 'PAN',
                                      labelStyle: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
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
                                      border: UnderlineInputBorder(),
                                      // enabledBorder: UnderlineInputBorder(),
                                      // focusedBorder: UnderlineInputBorder(),
                                      errorBorder: UnderlineInputBorder(),
                                      focusedErrorBorder:
                                          UnderlineInputBorder(),
                                    )),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.015,
                          ),
                          
                              Column(
                              
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.03,
                                        vertical: Screens.bodyheight(context) *
                                            0.008),
                                    //         height:context
                                    // .watch<NewCollectionContoller>()
                                    // .statebool ==true?Screens.padingHeight(context)*0.7:null,
                                    width: Screens.width(context),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: theme.primaryColor)),
                                    child: 
                                    // Stack(
                                    //   children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: Screens.width(context),
                                              child: Text(
                                                "Billing Address",
                                                style: theme.textTheme.headline6
                                                    ?.copyWith(
                                                        color: theme.primaryColor),
                                              ),
                                            ),
                                            TextFormField(
                                                controller: context
                                                    .read<NewCollectionContoller>()
                                                    .mycontroller[7],
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Enter Address1";
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  labelText: 'Address1*',
                                                  labelStyle: theme
                                                      .textTheme.bodyText1!
                                                      .copyWith(color: Colors.grey),
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
                                                  border: UnderlineInputBorder(),
                                                  // enabledBorder: UnderlineInputBorder(),
                                                  // focusedBorder: UnderlineInputBorder(),
                                                  errorBorder:
                                                      UnderlineInputBorder(),
                                                  focusedErrorBorder:
                                                      UnderlineInputBorder(),
                                                )),
                                            // SizedBox(
                                            //   height: Screens.bodyheight(context) * 0.01,
                                            // ),
                                            TextFormField(
                                                controller: context
                                                    .read<NewCollectionContoller>()
                                                    .mycontroller[8],
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Enter Address2";
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  labelText: 'Address2*',
                                                  labelStyle: theme
                                                      .textTheme.bodyText1!
                                                      .copyWith(color: Colors.grey),
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
                                                  border: UnderlineInputBorder(),
                                                  // enabledBorder: UnderlineInputBorder(),
                                                  // focusedBorder: UnderlineInputBorder(),
                                                  errorBorder:
                                                      UnderlineInputBorder(),
                                                  focusedErrorBorder:
                                                      UnderlineInputBorder(),
                                                )),
                                            // SizedBox(
                                            //   height: Screens.bodyheight(context) * 0.01,
                                            // ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      Screens.width(context) * 0.4,
                                                  child: TextFormField(
                                                      controller: context
                                                          .read<
                                                              NewCollectionContoller>()
                                                          .mycontroller[9],
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Enter Area";
                                                        }
                                                        return null;
                                                      },
                                                      onChanged: (v) {
                                                        setState(() {});
                                                      },
                                                      decoration: InputDecoration(
                                                        labelText: 'Area*',
                                                        border:
                                                            UnderlineInputBorder(),
                                                        labelStyle: theme
                                                            .textTheme.bodyText1!
                                                            .copyWith(
                                                                color: Colors.grey),
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
                                                  width:
                                                      Screens.width(context) * 0.4,
                                                  child: TextFormField(
                                                      controller: context
                                                          .read<
                                                              NewCollectionContoller>()
                                                          .mycontroller[10],
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Enter City";
                                                        }
                                                        return null;
                                                      },
                                                      decoration: InputDecoration(
                                                        labelText: 'City*',
                                                        border:
                                                            UnderlineInputBorder(),
                                                        labelStyle: theme
                                                            .textTheme.bodyText1!
                                                            .copyWith(
                                                                color: Colors.grey),
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

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width:
                                                      Screens.width(context) * 0.4,
                                                  child: TextFormField(
                                                      controller: context
                                                          .read<
                                                              NewCollectionContoller>()
                                                          .mycontroller[11],
                                                      onTap: () {},
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Enter Pincode";
                                                        }
                                                        return null;
                                                      },
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .digitsOnly,
                                                        new LengthLimitingTextInputFormatter(
                                                            6),
                                                      ],
                                                      decoration: InputDecoration(
                                                        labelText: 'Pincode*',
                                                        border:
                                                            UnderlineInputBorder(),
                                                        labelStyle: theme
                                                            .textTheme.bodyText1!
                                                            .copyWith(
                                                                color: Colors.grey),
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
                                                  width:
                                                      Screens.width(context) * 0.4,
                                                  child: TextFormField(
                                                      controller: context
                                                          .read<
                                                              NewCollectionContoller>()
                                                          .mycontroller[12],
                                                      // focusNode: context
                                                      //     .read<
                                                      //         NewCollectionContoller>()
                                                      //     .focusNode1,
                                                      autovalidateMode:
                                                          AutovalidateMode.always,
                                                      onChanged: (v) {
                                                        setState(() {
                                                          context
                                                              .read<
                                                                  NewCollectionContoller>()
                                                              .filterListState2(v);
                                                          if (v.isEmpty) {
                                                            context
                                                                .read<
                                                                    NewCollectionContoller>()
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
                                                                    NewCollectionContoller>()
                                                                .methidstate(
                                                                    context
                                                                        .read<
                                                                            NewCollectionContoller>()
                                                                        .mycontroller[
                                                                            12]
                                                                        .text,
                                                                    context);
                                                            setState(() {
                                                              context
                                                                  .read<
                                                                      NewCollectionContoller>()
                                                                  .statebool = true;
                                                            });
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
                                                                    NewCollectionContoller>()
                                                                .statecode
                                                                .isEmpty) {
                                                          context
                                                              .read<
                                                                  NewCollectionContoller>()
                                                              .methidstate(
                                                                  context
                                                                      .read<
                                                                          NewCollectionContoller>()
                                                                      .mycontroller[
                                                                          12]
                                                                      .text,
                                                                  context);
                                                          FocusScope.of(context)
                                                              .requestFocus();
                                                          context
                                                              .read<
                                                                  NewCollectionContoller>()
                                                              .statebool = false;
                                                          return "Enter Correct State";
                                                        }
                                                        return null;
                                                      },
                                                      onEditingComplete: () {
                                                        setState(() {
                                                          context
                                                                  .read<
                                                                      NewCollectionContoller>()
                                                                  .statebool = false;
                                                          FocusScope.of(context)
                                                              .unfocus();

                                                          
                                                          context
                                                              .read<
                                                                  NewCollectionContoller>()
                                                              .methidstate(
                                                                  context
                                                                      .read<
                                                                          NewCollectionContoller>()
                                                                      .mycontroller[
                                                                          12]
                                                                      .text,
                                                                  context);

                                                          // context
                                                          // .read<NewEnqController>()
                                                          // .statecode=false;
                                                        });
                                                      },
                                                      decoration: InputDecoration(
                                                        labelText: 'State*',
                                                        border:
                                                            UnderlineInputBorder(),
                                                        labelStyle: theme
                                                            .textTheme.bodyText1!
                                                            .copyWith(
                                                                color: Colors.grey),
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

                                            SizedBox(
                                              height: Screens.bodyheight(context) *
                                                  0.01,
                                            ),
                                            context
                                                        .read<
                                                            NewCollectionContoller>()
                                                        .isText1Correct ==
                                                    true
                                                ? Container(
                                                    padding: EdgeInsets.only(
                                                        right:
                                                            Screens.width(context) *
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
                                        
                                         Visibility(
                                visible: context
                                    .watch<NewCollectionContoller>()
                                    .statebool,
                                child: Padding(
                                   padding: EdgeInsets.only(
                                                left: Screens.width(context) *
                                                    0.4),
                                  child: Container(
                                    width: Screens.width(context) * 0.5,
                                    // height: Screens.bodyheight(context) * 0.3,
                                    color: Colors.white,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        // scrollDirection: Axis.vertical,
                                        itemCount: context
                                            .read<NewCollectionContoller>()
                                            .filterstateData
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          return InkWell(
                                            onTap: () {
                                                log("ontappppp");
                                              setState(() {
                                              
                                                context
                                                    .read<
                                                        NewCollectionContoller>()
                                                    .stateontap(i);
                                              });
                                            },
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                        Screens.bodyheight(
                                                                context) *
                                                            0.008),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    // color: Colors.red,
                                                    height: Screens.bodyheight(
                                                            context) *
                                                        0.05,
                                                    width:
                                                        Screens.width(context),
                                                    child: InkWell(
                                                      onTap: (() {
                                                        setState(() {
                                                          context
                                                              .read<
                                                                  NewCollectionContoller>()
                                                              .stateontap(i);
                                                        });
                                                      }),
                                                      child: Text(
                                                        "${context.watch<NewCollectionContoller>().filterstateData[i].stateName}",
                                                        style: theme
                                                            .textTheme.bodyText1
                                                            ?.copyWith(
                                                                color: theme
                                                                    .primaryColor),
                                                      ),
                                                    ),
                                                  ),
                                                  Divider()
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ),  
                                          ],
                                        ),
                                    
                                    
                                    //   ],
                                    // ),
                                  ),
                                
                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.015,
                                  ),
                                  
                                ],
                              ),
                              
                             
                           

                          SizedBox(
                            height: Screens.bodyheight(context) * 0.02,
                          ),
//  Padding(padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom))
                    //  ,
                          // //nextbtn
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: Screens.width(context) * 0.3,
                              height: Screens.bodyheight(context) * 0.07,
                              child: ElevatedButton(
                                  onPressed: () {
                                    // provi.pageController.animateToPage(++provi.pageChanged,
                                    //     duration: Duration(milliseconds: 250),
                                    //     curve: Curves.bounceIn);
                                    context
                                        .read<NewCollectionContoller>()
                                        .firstPageNextBtn(context);
                                  },
                                  child: Icon(Icons.navigate_next)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  Container SecondPage(
    BuildContext context,
    ThemeData theme,
  ) {
    Config config = Config();
    //  return ChangeNotifierProvider<NewCollectionContoller>(
    //       create: (context) => NewCollectionContoller(),
    //       builder: (context, child) {
    //         return Consumer<NewCollectionContoller>(
    //           builder: (BuildContext context, provi, Widget? child) {
    return Container(
      // color: Colors.blue,
      color: Colors.white,

      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: EdgeInsets.only(
          left: Screens.width(context) * 0.01,
          right: Screens.width(context) * 0.01,
          bottom: Screens.bodyheight(context) * 0.01,
          top: Screens.bodyheight(context) * 0.02),
      child: Column(
        children: [
          Container(
            height: Screens.bodyheight(context) * 0.06,
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1), //Colors.grey[200],
              borderRadius:
                  BorderRadius.circular(Screens.width(context) * 0.02),
            ),
            child: TextField(
              autocorrect: false,
              onChanged: (val) {
                context.read<NewCollectionContoller>().filterList(val);
              },
              controller:
                  context.read<NewCollectionContoller>().mycontroller[22],
              decoration: InputDecoration(
                filled: false,
                hintText: 'Search Here!!..',
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    FocusScopeNode focus = FocusScope.of(context);
                    if (!focus.hasPrimaryFocus) {
                      focus.unfocus();
                    }
                    context.read<NewCollectionContoller>().changeVisible();
                  }, //
                  color: theme.primaryColor,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 11,
                  horizontal: 10,
                ),
              ),
            ),
          ),
          SizedBox(
            height: Screens.bodyheight(context) * 0.01,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Screens.width(context) * 0.01,
            ),
            padding: EdgeInsets.symmetric(
                horizontal: Screens.width(context) * 0.03,
                vertical: Screens.bodyheight(context) * 0.02),
            decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black26)),
            width: Screens.width(context),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Text(
                      "${context.watch<NewCollectionContoller>().mycontroller[1].text.toString()}",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "${context.watch<NewCollectionContoller>().mycontroller[0].text}",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    child: Text(
                      "Total Outstanding",
                      style: theme.textTheme.bodyText1
                          ?.copyWith(color: theme.primaryColor, fontSize: 15),
                    ),
                  ),
                  Container(
                    child: Text(
                      "₹ ${Config.k_m_b_generator(context.read<NewCollectionContoller>().totaloutstanding!.toStringAsFixed(0))}",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyText1?.copyWith(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: Screens.padingHeight(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Overdue",
                          style: theme.textTheme.bodyText1?.copyWith(
                              color: theme.primaryColor, fontSize: 15),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Upcoming",
                          style: theme.textTheme.bodyText1?.copyWith(
                              color: theme.primaryColor, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "₹ ${Config.k_m_b_generator(context.read<NewCollectionContoller>().overdue!.toStringAsFixed(0))}",
                          style: theme.textTheme.bodyText1?.copyWith(),
                        ),
                      ),
                      Container(
                        child: Text(
                          "₹ ${Config.k_m_b_generator(context.read<NewCollectionContoller>().upcoming!.toStringAsFixed(0))}",
                          style: theme.textTheme.bodyText1?.copyWith(),
                        ),
                      ),
                    ],
                  )
                ]),
          ),
          SizedBox(
            height: Screens.padingHeight(context) * 0.008,
          ),
          context.read<NewCollectionContoller>().showItemList == true
              ? Expanded(
                  child: ListView.builder(
                    itemCount: context
                        .watch<NewCollectionContoller>()
                        .allProductDetails
                        .length,
                    itemBuilder: (BuildContext context, int i) {
                      return InkWell(
                        onTap: () {
                          context.read<NewCollectionContoller>().resetItems(i);
                          context
                              .read<NewCollectionContoller>()
                              .isUpdateClicked = false;
                          // context
                          //     .read<NewCollectionContoller>()
                          //     .showBottomSheetInsert(context, i);
                          context
                              .read<NewCollectionContoller>()
                              .showBottomSheetInsert(context, i);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Screens.width(context) * 0.01,
                              vertical: Screens.padingHeight(context) * 0.002),
                          child: Container(
                            width: Screens.width(context),
                            padding: EdgeInsets.symmetric(
                                horizontal: Screens.width(context) * 0.02,
                                vertical: Screens.padingHeight(context) * 0.01),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black26)),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "Invoice",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "${context.read<NewCollectionContoller>().allProductDetails[i].invoice}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Container(
                              //       child: Text('00',
                              //         // "${context.read<Outstandingcontroller>().allProductDetails[i].TransNum}",
                              //         style: theme.textTheme.bodyText1!
                              //             .copyWith(
                              //                 color: theme.primaryColor),
                              //       ),
                              //     ),
                              //     Container(
                              //       child: Text(
                              //         '22',
                              //         // "${context.read<Outstandingcontroller>().allProductDetails[i].age!.toInt()}",
                              //         style: theme.textTheme.bodyText1!
                              //             .copyWith(
                              //                 color: theme.primaryColor),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              SizedBox(
                                height: Screens.padingHeight(context) * 0.008,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "Due Date",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Age",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      // '33',
                                      "${config.alignDate(context.read<NewCollectionContoller>().allProductDetails[i].date.toString())}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      // '44',
                                      "${context.read<NewCollectionContoller>().allProductDetails[i].age.toString()}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Screens.padingHeight(context) * 0.002,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      "Trans Amount",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Paid Amount",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      // '34',
                                      "${context
                                  .watch<NewCollectionContoller>()
                                  .config
                                  .slpitCurrency22(context.read<NewCollectionContoller>().allProductDetails[i].trnsAmount.toString())}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      // '00',
                                      "${context
                                  .watch<NewCollectionContoller>()
                                  .config
                                  .slpitCurrency22(context.read<NewCollectionContoller>().allProductDetails[i].paidAmount.toString())}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      'Balance To Pay',
                                      // "${context.read<Outstandingcontroller>().allProductDetails[i].TransAmount}",
                                      style: theme.textTheme.bodyLarge!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      // '23455.00',
                                      "${context
                                  .watch<NewCollectionContoller>()
                                  .config
                                  .slpitCurrency22(context.read<NewCollectionContoller>().allProductDetails[i].balancetoPay.toString())}",
                                      style: theme.textTheme.bodyText1!
                                          .copyWith(color: theme.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: context
                        .read<NewCollectionContoller>()
                        .getProduct
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Screens.width(context) * 0.01,
                            vertical: Screens.padingHeight(context) * 0.002),
                        child: Container(
                          width: Screens.width(context),
                          padding: EdgeInsets.symmetric(
                              horizontal: Screens.width(context) * 0.02,
                              vertical: Screens.padingHeight(context) * 0.01),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black26)),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "Invoice",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "${context.read<NewCollectionContoller>().getProduct[index].invoice}",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment:
                            //       MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Container(
                            //       child: Text('00',
                            //         // "${context.read<Outstandingcontroller>().allProductDetails[i].TransNum}",
                            //         style: theme.textTheme.bodyText1!
                            //             .copyWith(
                            //                 color: theme.primaryColor),
                            //       ),
                            //     ),
                            //     Container(
                            //       child: Text(
                            //         '22',
                            //         // "${context.read<Outstandingcontroller>().allProductDetails[i].age!.toInt()}",
                            //         style: theme.textTheme.bodyText1!
                            //             .copyWith(
                            //                 color: theme.primaryColor),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.008,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "Due Date",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Age",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    // '33',
                                    "${config.alignDate(context.read<NewCollectionContoller>().getProduct[index].date)}",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    // '44',
                                    "${context.read<NewCollectionContoller>().getProduct[index].age.toString()}",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Screens.padingHeight(context) * 0.002,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    "Trans Amound",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: Colors.grey),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Paid Amount",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    // '34',
                                    "${context
                                  .watch<NewCollectionContoller>()
                                  .config
                                  .slpitCurrency22(context.read<NewCollectionContoller>().getProduct[index].trnsAmount.toString())}",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    // '00',
                                    "${context
                                  .watch<NewCollectionContoller>()
                                  .config
                                  .slpitCurrency22(context.read<NewCollectionContoller>().getProduct[index].paidAmount.toString())}",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Balance To Pay',
                                    // "${context.read<Outstandingcontroller>().allProductDetails[i].TransAmount}",
                                    style: theme.textTheme.bodyLarge!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    // '23455.00',
                                    "${context
                                  .watch<NewCollectionContoller>()
                                  .config
                                  .slpitCurrency22(context.read<NewCollectionContoller>().getProduct[index].balancetoPay.toString())}",
                                    style: theme.textTheme.bodyText1!
                                        .copyWith(color: theme.primaryColor),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        print(index);
                                        context
                                            .read<NewCollectionContoller>()
                                            .RemoveandAdd(context
                                                .read<NewCollectionContoller>()
                                                .getProduct[index]);
                                        // showItemList

                                        if (context
                                            .read<NewCollectionContoller>()
                                            .getProduct
                                            .isEmpty) {
                                          context
                                              .read<NewCollectionContoller>()
                                              .showItemList = true;
                                        }
                                        for (int i = 0;
                                            i <
                                                context
                                                    .read<
                                                        NewCollectionContoller>()
                                                    .productDetails
                                                    .length;
                                            i++) {
                                          //  provi.productDetails[i].lineId =
                                          //     (i + 1).toString();
                                        }
                                      });
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    )),
                                SizedBox(width: 10.0),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        context
                                                .read<NewCollectionContoller>()
                                                .mycontroller[14]
                                                .text =
                                            context
                                                .read<NewCollectionContoller>()
                                                .getProduct[index]
                                                .paidAmount
                                                .toStringAsFixed(2);

                                        context
                                            .read<NewCollectionContoller>()
                                            .isUpdateClicked = true;

                                        context
                                            .read<NewCollectionContoller>()
                                            .UpdateshowBottomSheetInsert(
                                                context, index);
                                      });
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    )),
                              ],
                            )
                          ]),
                        ),
                      );
                    },
                  ),
                ),
          //

          Column(
            children: [
              context.read<NewCollectionContoller>().showItemList == true
                  ? Container()
                  : Container(
                      width: Screens.width(context),
                      height: Screens.bodyheight(context) * 0.07,
                      //  padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(
                              0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                          ,
                          border:
                              Border.all(color: theme.primaryColor, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              "Total Collection Value Rs.${context.read<NewCollectionContoller>().colletionTotal()}",
                              maxLines: 8,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyText1?.copyWith(
                                color: theme.primaryColor,
                              ))
                        ],
                      ),
                    ),
              context.read<NewCollectionContoller>().showItemList == true
                  ? Container()
                  : SizedBox(
                      height: Screens.bodyheight(context) * 0.02,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Screens.width(context) * 0.3,
                    height: Screens.bodyheight(context) * 0.07,
                    child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<NewCollectionContoller>()
                              .pageController
                              .animateToPage(
                                  --context
                                      .read<NewCollectionContoller>()
                                      .pageChanged,
                                  duration: Duration(milliseconds: 250),
                                  curve: Curves.bounceIn);
                        },
                        child: Icon(Icons.keyboard_arrow_left)),
                  ),
                  SizedBox(
                    width: Screens.width(context) * 0.3,
                    height: Screens.bodyheight(context) * 0.07,
                    child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<NewCollectionContoller>()
                              .colletionTotal();
                          context
                              .read<NewCollectionContoller>()
                              .pageController
                              .animateToPage(
                                  ++context
                                      .read<NewCollectionContoller>()
                                      .pageChanged,
                                  duration: Duration(milliseconds: 250),
                                  curve: Curves.bounceIn);
                        },
                        child: Icon(Icons.navigate_next)),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
    //       }
    //     );
    //   }
    // );
  }

  List<Widget> listContainersCustomertags(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<NewCollectionContoller>().customerTagTypeData.length,
      (index) => InkWell(
        onTap: () {
          // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
          // .getenqReffList[index].Name.toString();
          context.read<NewCollectionContoller>().selectCustomerTag(
              context
                  .read<NewCollectionContoller>()
                  .customerTagTypeData[index]
                  .Name
                  .toString(),
              context
                  .read<NewCollectionContoller>()
                  .customerTagTypeData[index]
                  .Name!,
              context
                  .read<NewCollectionContoller>()
                  .customerTagTypeData[index]
                  .Code!);
        },
        child: Container(
          width: Screens.width(context) * 0.2,
          height: Screens.bodyheight(context) * 0.05,
          alignment: Alignment.center,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context
                          .watch<NewCollectionContoller>()
                          .isSelectedCusTagcode ==
                      context
                          .read<NewCollectionContoller>()
                          .customerTagTypeData[index]
                          .Code
                          .toString()
                  ? Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
              context
                  .watch<NewCollectionContoller>()
                  .customerTagTypeData[index]
                  .Name
                  .toString(),
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10,
                color: context
                            .watch<NewCollectionContoller>()
                            .isSelectedCusTagcode ==
                        context
                            .read<NewCollectionContoller>()
                            .customerTagTypeData[index]
                            .Code
                            .toString()
                    ? theme.primaryColor //,Colors.white
                    : theme.primaryColor,
              )),
        ),
      ),
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text == '.') {
      return newValue.copyWith(text: '0.');
    } else if (newValue.text == '0') {
      return newValue.copyWith(text: '');
    }

    // Ensure only one decimal point
    if (newValue.text.indexOf('.') != newValue.text.lastIndexOf('.')) {
      // If there are multiple dots, reject the change
      return oldValue;
    }

    // Allow digits, backspace, and one dot
    final regExp = RegExp(r'^\d*\.?\d*$');
    if (!regExp.hasMatch(newValue.text)) {
      // If the input is not valid, reject the change
      return oldValue;
    }

    return newValue;
  }
}
