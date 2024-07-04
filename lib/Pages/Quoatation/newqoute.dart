// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_new, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/QuotationController/newquotecontroller.dart';
import 'package:sellerkit/Widgets/qrpage.dart';

import '../../Widgets/Appbar.dart';
import '../../Widgets/Navi3.dart';

class QuoteNew extends StatefulWidget {
  QuoteNew({Key? key}) : super(key: key);

  @override
  State<QuoteNew> createState() => QuoteNewState();
}

class QuoteNewState extends State<QuoteNew> {
  static bool iscomfromLead=false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      log("iscomfromLead::"+iscomfromLead.toString());
      setState(() {
        if(ConstantValues.  multistoreuser ==1){

context.read<NewquoteController>().restricteddialog(context);
        }else{
 if (iscomfromLead == false) {
          log("ANBU222::");
          context.read<NewquoteController>().init(context);
        } else   {
          log("ANBU::");
          context.read<NewquoteController>().checkComeFromEnq(context);
setState(() {
    iscomfromLead = false;
});
        
        }
        }
       
      
       
      });

      
    });
  }
   DateTime? currentBackPressTime;
  // Future<bool> onbackpress() {
  //   DateTime now = DateTime.now();
  //   if (currentBackPressTime == null ||
  //       now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
  //     currentBackPressTime = now;
  //     Get.toNamed(ConstantRoutes.dashboard);
  //     return Future.value(true);
  //   }
  //   return Future.value(true);
  // }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

  //  // });
  // }
  final GlobalKey<ScaffoldState> scaffoldKey1 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(        
      drawerEnableOpenDragGesture: false,
        // backgroundColor: Colors.grey[200],
        /// resizeToAvoidBottomInset: true,
        key: scaffoldKey1,
        appBar: appbar("New Quotation", scaffoldKey1, theme, context),
        drawer: drawer3(context),
        // body: ChangeNotifierProvider<NewquoteController>(
        //     create: (context) => NewquoteController(),
        //     builder: (context, child) {
        //       return Consumer<NewquoteController>(
        //           builder: (BuildContext context, provi, Widget? child) {
        // return
        body: PageView(
          physics: new NeverScrollableScrollPhysics(),
          controller: context.read<NewquoteController>().pageController,
          onPageChanged: (index) {
            log("index: ${index}");
            setState(() {
              context.read<NewquoteController>().pageChanged = index;
            });
            print(context.read<NewquoteController>().pageChanged);
          },
          children: [
            GestureDetector(onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.quotespage);
                      });
                    }
                  },
              child: FirstPage(
                context,
                theme,
              ),
            ),
            SecondPage(
              context,
              theme,
            ),
            ThirdPage(
              context,
              theme,
            ),
          ],
        )
        //   });
        // })
        );
  }

  Container ThirdPage(
    BuildContext context,
    ThemeData theme,
  ) {
    //NewquoteController provi
    return Container(
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: EdgeInsets.only(
        left: Screens.width(context) * 0.03,
        right: Screens.width(context) * 0.03,
        top: Screens.bodyheight(context) * 0.02,
        bottom: Screens.bodyheight(context) * 0.01,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.82,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Screens.width(context),
                      height: Screens.bodyheight(context) * 0.28,
                      decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.only(
                        left: Screens.width(context) * 0.02,
                        right: Screens.width(context) * 0.02,
                        top: Screens.bodyheight(context) * 0.01,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment Terms*",
                              style: theme.textTheme.bodyText1
                                  ?.copyWith(color: Colors.white),
                            ),
                            SizedBox(
                                height: Screens.bodyheight(context) * 0.02),
                            // Visibility(
                            //   visible: provi.getvisibleRefferal,
                            //   child: Column(
                            //     children: [
                            //       Text(
                            //         "Required Referral*",
                            //         style: theme.textTheme.bodyText1
                            //             ?.copyWith(color: Colors.white),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: provi.getvisibleRefferal == true
                            //       ? Screens.bodyheight(context) * 0.02
                            //       : Screens.bodyheight(context) * 0.04,
                            // ),
                            Center(
                              child: Wrap(
                                  spacing: 20.0, // width
                                  runSpacing: 8.0, // height
                                  children: listContainersPaymentTerms(theme)),
                            )
                          ],
                        ),
                      ),
                    ),

                      context.watch<NewquoteController>().     paymentTerm ==false?Container():  Text("Enter Payment Terms",style: TextStyle(color: Colors.red),),
           
                    //SizedBox(height: Screens.bodyheight(context)*0.02,),
                    // SizedBox(
                    //   height: Screens.bodyheight(context) * 0.01,
                    // ),
                    //dates
                    Form(
                      key: context.read<NewquoteController>().formkey[1],
                      child: Column(
                        children: [
                          // TextFormField(
                          //   onTap: () {
                          //     context
                          //         .read<NewquoteController>()
                          //         .showpurchaseDate(context);
                          //   },
                          //   controller: context
                          //       .read<NewquoteController>()
                          //       .mycontroller[35],
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return "Choose Purchase Date";
                          //     }
                          //     return null;
                          //   },
                          //   readOnly: true,
                          //   decoration: InputDecoration(
                          //       hintText: 'Plan of Purchase Date*', //
                          //        border: UnderlineInputBorder(),
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
                          //         errorBorder: UnderlineInputBorder(),
                          //         focusedErrorBorder: UnderlineInputBorder(),
                          //       suffixIcon: Icon(Icons.date_range_outlined))),
                          TextFormField(
                              onTap: () {
                                context
                                    .read<NewquoteController>()
                                    .showFollowupDate(context);
                              },
                              controller: context
                                  .read<NewquoteController>()
                                  .mycontroller[13],
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Delivery Due Date";
                                }
                                return null;
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                  labelText: 'Delivery Due Date*', //
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
                                  suffixIcon: Icon(Icons.date_range_outlined))),
                        
                          SizedBox(
                          height: Screens.bodyheight(context) * 0.005,
                        ),
                        TextFormField(
                            onTap: () {
                              context
                                  .read<NewquoteController>()
                                  .showPaymentDate(context);
                            },
                            controller: context
                                .read<NewquoteController>()
                                .mycontroller[31],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Choose Payment Due Date";
                              }
                              return null;
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                                labelText: 'Payment Due Date*', //
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
                                suffixIcon: Icon(Icons.date_range_outlined))),
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.005,
                          ),
                          TextFormField(
                              onTap: () {
                                // context
                                //     .read<NewquoteController>()
                                //     .showPurchaseDate(context);
                              },
                              controller: context
                                  .read<NewquoteController>()
                                  .mycontroller[14],
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return "Enter Customer PO Reference"; //
                              //   }
                              //   return null;
                              // },
                              readOnly: false,
                              decoration: InputDecoration(
                                labelText: 'Customer PO Reference',
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
                                // suffixIcon: Icon(Icons.date_range_outlined)
                              )),
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.02,
                          ),
                          TextFormField(
                            controller: context
                                .read<NewquoteController>()
                                .mycontroller[15],
                            minLines: 6,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                top: Screens.bodyheight(context) * 0.04,
                                left: Screens.bodyheight(context) * 0.01,
                              ),
                              alignLabelWithHint: true,
                              // border: OutlineInputBorder(),
                              hintText: 'Notes',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.015,
                    ),
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
                                                    .read<NewquoteController>()
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
                                                            NewquoteController>()
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
                                                              NewquoteController>()
                                                          .files
                                                          .length >
                                                      5
                                                  ? null
                                                  : () {
                                                      setState(() {
                                                        log("files length" +
                                                            context
                                                                .read<
                                                                    NewquoteController>()
                                                                .files
                                                                .length
                                                                .toString());
                                                        // showtoast();
                                                        if (context
                                                                .read<
                                                                    NewquoteController>()
                                                                .files
                                                                .length <=
                                                            4) {
                                                          setState(() {
                                                            context
                                                                .read<
                                                                    NewquoteController>()
                                                                .imagetoBinary(
                                                                    ImageSource
                                                                        .camera);
                                                            context
                                                                .read<
                                                                    NewquoteController>()
                                                                .fileValidation = false;
                                                          });
                                                        } else {
                                                          print("obAAAAAject");
                                                          context
                                                              .read<
                                                                  NewquoteController>()
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
                                                            NewquoteController>()
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
                                                              NewquoteController>()
                                                          .files
                                                          .length >
                                                      5
                                                  ? null
                                                  : () {
                                                      setState(() {
                                                        // log("files length" + files.length.toString());
                                                        // showtoast();
                                                        if (context
                                                                .read<
                                                                    NewquoteController>()
                                                                .files
                                                                .length <=
                                                            4) {
                                                          setState(() {
                                                            context
                                                                .read<
                                                                    NewquoteController>()
                                                                .selectattachment();

                                                            context
                                                                .read<
                                                                    NewquoteController>()
                                                                .fileValidation = false;
                                                          });
                                                        } else {
                                                          print("obAAAAAject");

                                                          context
                                                              .read<
                                                                  NewquoteController>()
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
                            context.read<NewquoteController>().files == null
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
                                                                      NewquoteController>()
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
                                                .read<NewquoteController>()
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
                                            .read<NewquoteController>()
                                            .files
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          if (context
                                              .read<NewquoteController>()
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
                                                                  NewquoteController>()
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
                                                                        NewquoteController>()
                                                                    .files
                                                                    .removeAt(
                                                                        i);
                                                                        context
                                                                    .read<
                                                                        NewquoteController>()
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
                                              .read<NewquoteController>()
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
                                                                  NewquoteController>()
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
                                                                        NewquoteController>()
                                                                    .files
                                                                    .removeAt(
                                                                        i);
                                                                        context
                                                                    .read<
                                                                        NewquoteController>()
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
                                              .read<NewquoteController>()
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
                                                              "Assets/pdfimg.png")),
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
                                                                  NewquoteController>()
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
                                                                        NewquoteController>()
                                                                    .files
                                                                    .removeAt(
                                                                        i);
                                                                        context
                                                                    .read<
                                                                        NewquoteController>()
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
                                              .read<NewquoteController>()
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
                                                                  NewquoteController>()
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
                                                                        NewquoteController>()
                                                                    .files
                                                                    .removeAt(
                                                                        i);
                                                                        context
                                                                    .read<
                                                                        NewquoteController>()
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
                                                                NewquoteController>()
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
                                                                      NewquoteController>()
                                                                  .files
                                                                  .removeAt(i);
                                                                  context
                                                                    .read<
                                                                        NewquoteController>()
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
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context) * 0.07,
                  //  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(
                          0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                      ,
                      border: Border.all(color: theme.primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        // ${context.read<NewquoteController>().getTotalOrderAmount()
                          "Total Quotes Value Rs.${context.read<NewquoteController>().getTotalOrderAmount()}",
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyText1?.copyWith(
                            color: theme.primaryColor,
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
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
                                .read<NewquoteController>()
                                .pageController
                                .animateToPage(
                                    --context
                                        .read<NewquoteController>()
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
                          onPressed:
                              context
                                          .watch<NewquoteController>()
                                          .getisloadingBtn ==
                                      true
                                  ? null
                                  :
                              () {
                            // print("aaaa");
                            context
                                .read<NewquoteController>()
                                .thirPageBtnClicked(context);
                          },
                          child: context
                                      .watch<NewquoteController>()
                                      .getisloadingBtn ==
                                  true
                              ? SizedBox(
                                  width: Screens.width(context) * 0.08,
                                  height: Screens.bodyheight(context) * 0.07,
                                  child: CircularProgressIndicator(
                                      color: Colors.white))
                              : Icon(Icons.save)),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
    //       }
    //     );
    //   }
    // );
  }

  bool switched = false;
  bool switched2 = false;

  Container SecondPage(
    BuildContext context,
    ThemeData theme,
  ) {
    //  return ChangeNotifierProvider<NewquoteController>(
    //       create: (context) => NewquoteController(),
    //       builder: (context, child) {
    //         return Consumer<NewquoteController>(
    //           builder: (BuildContext context, provi, Widget? child) {
    return Container(
      // color: Colors.blue,
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: EdgeInsets.only(
          left: Screens.width(context) * 0.01,
          right: Screens.width(context) * 0.01,
          bottom: Screens.bodyheight(context) * 0.01,
          top: Screens.bodyheight(context) * 0.02),
      child: Column(
        children: [
          Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  width:context.read<NewquoteController>().showItemList == true? Screens.width(context)*0.80:Screens.width(context)*0.95,
                
                height: Screens.bodyheight(context) * 0.06,
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1), //Colors.grey[200],
                  borderRadius:
                      BorderRadius.circular(Screens.width(context) * 0.02),
                ),
                child: TextField(
                  autocorrect: false,
                  onChanged: (val) {
                    context.read<NewquoteController>().filterList(val);
                  },
                  controller: context.read<NewquoteController>().mycontroller[12],
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
                        context.read<NewquoteController>().changeVisible();
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
          
           context.read<NewquoteController>().showItemList == true?   Container(
            // alignment: Alignment.center,
            child: IconButton(
              onPressed: (){
                setState(() {
                   context.read<NewquoteController>().     scannerreset();
                   qrscannerState.quotescan=true;
                Navigator.push(context,MaterialPageRoute(builder: (_) => qrscanner()))
//                 .then((value){
// return context.read<NewquoteController>().scanneddataget(context);
//                 } 
//                  )
                 ;
                });
           
              },
              icon: Icon(Icons.qr_code_scanner_outlined,color: theme.primaryColor,size: 30,)),
          ):Container()
          
            ],
          ),
          context.read<NewquoteController>().showItemList == true
              ? Expanded(
                  child: ListView.builder(
                    itemCount: context
                        .watch<NewquoteController>()
                        .getAllProductDetails
                        .length,
                    itemBuilder: (BuildContext context, int i) {
                      return InkWell(
                        onTap: () {
                          context.read<NewquoteController>().resetItems(i);
                          context.read<NewquoteController>().isUpdateClicked =
                              false;
                          // context
                          //     .read<NewquoteController>()
                          //     .showBottomSheetInsert(context, i);
                          context
                              .read<NewquoteController>()
                              .showBottomSheetInsert(context, i);
                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                            width: Screens.width(context),
                            padding: EdgeInsets.symmetric(
                                vertical: Screens.bodyheight(context) * 0.01,
                                horizontal: Screens.width(context) * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                          "Item code: ${context.read<NewquoteController>().getAllProductDetails[i].itemCode}",
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                                  color: theme.primaryColor)),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                        "Date: " +
                                            context
                                                .read<NewquoteController>()
                                                .config
                                                .alignDate(context
                                                    .read<NewquoteController>()
                                                    .getAllProductDetails[i]
                                                    .refreshedRecordDate!),
                                      
                                        style: theme.textTheme.bodyText1
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Screens.width(context) * 0.05),
                                  child: Divider(
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: Screens.width(context) * 0.4,
                                  child: Text("Product",
                                      style: theme.textTheme.bodyText1
                                          ?.copyWith(color: Colors.grey)),
                                ),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: Screens.width(context) * 0.4,
                                      child: Text(
                                          "${context.read<NewquoteController>().getAllProductDetails[i].itemName}",
                                          style: theme.textTheme.bodyText1
                                              ?.copyWith(
                                                  //color: theme.primaryColor
                                                  )),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: Screens.width(context) * 0.1,
                                          child: Text(
                                            "₹ ",
                                            style: theme.textTheme.bodyText1
                                                ?.copyWith(color: Colors.grey),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          //width: Screens.width(context) * 0.2,
                                          child: Text(
                                            "${context
                                    .read<NewquoteController>()
                                    .config.slpitCurrency22(context.read<NewquoteController>().getAllProductDetails[i].sp.toString())}",
                                            style: theme.textTheme.bodyText1
                                                ?.copyWith(
                                                    color: theme.primaryColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount:
                        context.read<NewquoteController>().getProduct.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                        "" +
                                            context
                                                .read<NewquoteController>()
                                                .getProduct[index]
                                                .ItemCode
                                                .toString(),
                                        style: TextStyle(
                                          color: theme.primaryColor,
                                          fontSize: 15.0,
                                        )),
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    children: [
                                      Text("Product",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15.0,
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    // width: Screens.width(context)*0.8,
                                    ///  color: Colors.red,
                                    child: Text(
                                        context
                                            .read<NewquoteController>()
                                            .getProduct[index]
                                            .ItemDescription!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.0,
                                        )),
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "Qty: " +
                                              context
                                                  .read<NewquoteController>()
                                                  .getProduct[index]
                                                  .Quantity
                                                  .toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                          )),
                                      // SizedBox(
                                      //     width: Screens.bodyheight(context) /
                                      //         2.9),
                                      Text(
                                          "Price: " +
                                            context
                                                .read<NewquoteController>()
                                                .config.slpitCurrency22(context
                                                  .read<NewquoteController>()
                                                  .getProduct[index]
                                                  .Price
                                                  .toString()),  
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                          )),
                                    ],
                                  ),
                                   SizedBox(height: 5),
                        (context
                                                      .read<
                                                          NewquoteController>()
                                                      .getProduct[index]
                                                      .partname !=null &&        context
                                                      .read<
                                                          NewquoteController>()
                                                      .getProduct[index]
                                                      .partname!.isNotEmpty)?      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                        context
                                                      .read<
                                                          NewquoteController>()
                                                      .getProduct[index]
                                                      .partcode !=null?  Container(
                                            child:Text("${context
                                                      .read<
                                                          NewquoteController>()
                                                      .getProduct[index]
                                                      .partname}")
                                          ):Container(),
                               

                                      ],):Container(),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 40, right: 40),
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text("Total: " +
                                                context
                                                .read<NewquoteController>()
                                                .config.slpitCurrency22( context
                                                      .read<
                                                          NewquoteController>()
                                                      .getProduct[index]
                                                      .LineTotal
                                                      .toString()))
                                            ]),
                                        Row(
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    print(index);
                                                    context
                                                        .read<
                                                            NewquoteController>()
                                                        .getProduct
                                                        .removeAt(index);
 if(context
                                                                .read<
                                                                    NewquoteController>()
                                                                .productDetails.isEmpty){
                                                            context
                                                                .read<
                                                                    NewquoteController>()
                                                                .      changeVisible();

                                                        }
                                                    for (int i = 0;
                                                        i <
                                                            context
                                                                .read<
                                                                    NewquoteController>()
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
                                                  context
                                                          .read<
                                                              NewquoteController>()
                                                          .mycontroller[10]
                                                          .text =
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .getProduct[index]
                                                          .Price!
                                                          .toStringAsFixed(2);
                                                  context
                                                          .read<
                                                              NewquoteController>()
                                                          .mycontroller[11]
                                                          .text =
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .getProduct[index]
                                                          .Quantity!
                                                          .toStringAsFixed(2);
                                                  context
                                                          .read<
                                                              NewquoteController>()
                                                          .mycontroller[11]
                                                          .text =
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .getProduct[index]
                                                          .Quantity!
                                                          .toStringAsFixed(0);
                                                  context
                                                          .read<
                                                              NewquoteController>()
                                                          .total =
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .getProduct[index]
                                                          .LineTotal!;
                                                  context
                                                      .read<
                                                          NewquoteController>()
                                                      .isUpdateClicked = true;

                                                  context
                                                      .read<
                                                          NewquoteController>()
                                                      .showBottomSheetInsertforedit(
                                                          context, index);
                                                },
                                                child: Icon(
                                                  Icons.edit,
                                                  color: Colors.blue,
                                                )),
                                          ],
                                        ),
                                      ]),
                                ]),
                          ));
                    },
                  ),
                ),
          //

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Screens.width(context) * 0.3,
                height: Screens.bodyheight(context) * 0.07,
                child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<NewquoteController>()
                          .pageController
                          .animateToPage(
                              --context.read<NewquoteController>().pageChanged,
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
                      FocusScopeNode focus = FocusScope.of(context);
                      if (!focus.hasPrimaryFocus) {
                        focus.unfocus();
                      }
                      // provi.pageController.animateToPage(++provi.pageChanged,
                      //     duration: Duration(milliseconds: 250),
                      //     curve: Curves.bounceIn);

                      context.read<NewquoteController>().seconPageBtnClicked();
                      log("oldcutomer: " +
                          context
                              .read<NewquoteController>()
                              .oldcutomer
                              .toString());
                    },
                    child: Icon(Icons.keyboard_arrow_right)),
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


InkWell FirstPage(
    BuildContext context,
    ThemeData theme,
  ) {
    // return ChangeNotifierProvider<NewquoteController>(
    //       create: (context) => NewquoteController(),
    //       builder: (context, child) {
    //         return Consumer<NewquoteController>(
    //           builder: (BuildContext context, provi, Widget? child) {
    return InkWell(
      onTap: () {
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) {
          focus.unfocus();
        }
      },
      child: (context
                  .read<NewquoteController>()
                  .getexceptionOnApiCall
                  .isEmpty &&
              context.read<NewquoteController>().getcustomerapicLoading == true ||  context.read<NewquoteController>().isloading==true)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (context
                      .read<NewquoteController>()
                      .getexceptionOnApiCall
                      .isNotEmpty &&
                  context.read<NewquoteController>().getcustomerapicLoading ==
                      false&&context.read<NewquoteController>().isloading==false)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context
                            .read<NewquoteController>()
                            .getexceptionOnApiCall,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              : Container(
                  //  color: Colors.red,
                  width: Screens.width(context),
                  height: Screens.bodyheight(context),
                  padding: EdgeInsets.symmetric(
                      horizontal: Screens.width(context) * 0.03,
                      vertical: Screens.bodyheight(context) * 0.02),
                  child: SingleChildScrollView(
                    child: Form(
                      key: context.read<NewquoteController>().formkey[0],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text("Lead No : ${context.read<NewquoteController>().leadnum}"),
                          ),
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
                                        .read<NewquoteController>()
                                        .mycontroller[0],
                                    focusNode: context
                                        .read<NewquoteController>()
                                        .focusNode2,
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
                                            .read<NewquoteController>()
                                            .mycontroller[0].text.length==10){
 context
                                                .read<NewquoteController>()
                                                .callApi(context);
                                            }
                                         
                                        },
                                    onChanged: (v) {
                                      if (v.length == 10 &&
                                          context
                                                  .read<NewquoteController>()
                                                  .getcustomerapicalled ==
                                              false) {
                                        context
                                            .read<NewquoteController>()
                                            .callApi(context);
                                      } else if (v.length != 10) {
                                        context
                                            .read<NewquoteController>()
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
                                        .read<NewquoteController>()
                                        .mycontroller[16],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Customer";
                                      }
                                      return null;
                                    },
                                 onTap: () {
                                                    if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
                                    onChanged: (v) {
                                      // setState(() {
                                      //   context
                                      //       .read<NewquoteController>()
                                      //       .filterListcustomer(v);
                                      //   if (v.isEmpty) {
                                      //     context
                                      //         .read<NewquoteController>()
                                      //         .customerbool = false;
                                      //   } else {
                                      //     context
                                      //         .read<NewquoteController>()
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
                                Visibility(
                                  visible: context
                                      .read<NewquoteController>()
                                      .customerbool,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      context
                                              .read<NewquoteController>()
                                              .filterCustomerList
                                              .isEmpty
                                          ? Container()
                                          : Container(

                                              // color: Colors.amber,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color:
                                                          theme.primaryColor)),
                                              width: Screens.width(context),
                                              height:
                                                  Screens.bodyheight(context) *
                                                      0.2,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: context
                                                      .read<
                                                          NewquoteController>()
                                                      .filterCustomerList
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int i) {
                                                    return InkWell(
                                                      onTap: () {
                                                        // setState(() {
                                                        //   context
                                                        //       .read<
                                                        //           NewquoteController>()
                                                        //       .customerbool = false;
                                                        //   context
                                                        //       .read<
                                                        //           NewquoteController>()
                                                        //       .getExiCustomerData(
                                                        //           context
                                                        //               .read<
                                                        //                   NewquoteController>()
                                                        //               .filterCustomerList[
                                                        //                   i]
                                                        //               .cardname
                                                        //               .toString(),
                                                        //           context
                                                        //               .read<
                                                        //                   NewquoteController>()
                                                        //               .filterCustomerList[
                                                        //                   i]
                                                        //               .cardcode
                                                        //               .toString());
                                                        //   context
                                                        //           .read<
                                                        //               NewquoteController>()
                                                        //           .mycontroller[16]
                                                        //           .text =
                                                        //       context
                                                        //           .read<
                                                        //               NewquoteController>()
                                                        //           .filterCustomerList[
                                                        //               i]
                                                        //           .cardname
                                                        //           .toString();
                                                        // });
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
                                                            width:
                                                                Screens.width(
                                                                    context),
                                                            child: Text(
                                                              "${context.watch<NewquoteController>().filterCustomerList[i].cardname}",
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyText1
                                                                  ?.copyWith(
                                                                      color: Colors
                                                                          .black),
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

                                TextFormField(
                                    controller: context
                                        .read<NewquoteController>()
                                        .mycontroller[1],
                                        onTap: () {
                                                    if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool2 = false;
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
                                        .read<NewquoteController>()
                                        .mycontroller[6],
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
                                        .read<NewquoteController>()
                                        .mycontroller[7],
                                        onTap: () {
                                                    if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
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
                                        .read<NewquoteController>()
                                        .mycontroller[25],
                                          inputFormatters: [
                                      // FilteringTextInputFormatter.digitsOnly,
                                      new LengthLimitingTextInputFormatter(15),
                                    ],
                                        onTap: () {
                                                    if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
validator: (value) {
                                       if (value!.isNotEmpty) {
                                        if (value.length != 15) {
                                          return 'Enter Valid GST';
                                        }
                                      }
                                      return null;
                                    },
                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return "Enter Email";
                                    //   }else if(!value.contains("@")){
                                    //       return "Enter Valid Email";
                                    //   }
                                    //   return null;
                                    // },
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
                                    
                                     Container(
                                      height: Screens.padingHeight(context)*0.1,
                                       child: DropdownButtonFormField(
                                         decoration: InputDecoration(
                                                  // hintText: 'Email',
                                                  labelText: 'Order Type',
                                                  border: UnderlineInputBorder(),
                                                  enabledBorder:
                                                      UnderlineInputBorder(borderSide:
                                            BorderSide(color: Colors.grey),),
                                                  focusedBorder:
                                                      UnderlineInputBorder(borderSide:
                                            BorderSide(color: Colors.grey),),
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
                                                                         .read<NewquoteController>()
                                                                         .valueChosedCusType,
                                                                     //dropdownColor:Colors.green,
                                                                     icon: Icon(Icons.arrow_drop_down),
                                                                     iconSize: 30,
                                                                     style: TextStyle(
                                                                         color: Colors.black, fontSize: 16),
                                                                     isExpanded: true,
                                                                     onChanged: (val) {
                                                                       setState(() {
                                                                         context
                                          .read<NewquoteController>()
                                          .choosedType(val.toString());
                                                                       });
                                                                     },
                                                                     items: context
                                                                         .read<NewquoteController>()
                                                                         .ordertypedata
                                                                         .map((e) {
                                                                       return DropdownMenuItem(
                                        // ignore: unnecessary_brace_in_string_interps
                                        value: "${e.Code}",
                                        child: Container(
                                            // height: Screens.bodyheight(context)*0.1,
                                            child: Text("${e.Name}")));
                                                                     }).toList(),
                                                                   ),
                                     ),

                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.015,
                          ),
                          Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.03,
                                        vertical: Screens.bodyheight(context) *
                                            0.008),
                                    width: Screens.width(context),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: theme.primaryColor)),
                                    child: Column(
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
                                                .read<NewquoteController>()
                                                .mycontroller[2],
                                                onTap: () {
                                                    if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
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
                                                .read<NewquoteController>()
                                                .mycontroller[3],
                                                onTap: () {
                                                    if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
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
                                                          NewquoteController>()
                                                      .mycontroller[17],
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Enter Area";
                                                    }
                                                    return null;
                                                  },
                                                  onTap: () {
                                                    if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
                                                  onChanged: (v) {
                                                    // setState(() {
                                                    //   context
                                                    //       .read<
                                                    //           NewquoteController>()
                                                    //       .filterListArea(v);
                                                    //   if (v.isEmpty) {
                                                    //     context
                                                    //         .read<
                                                    //             NewquoteController>()
                                                    //         .areabool = false;
                                                    //   } else {
                                                    //     context
                                                    //         .read<
                                                    //             NewquoteController>()
                                                    //         .areabool = true;
                                                    //   }
                                                    // });
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
                                                          NewquoteController>()
                                                      .mycontroller[5],
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Enter City";
                                                    }
                                                    return null;
                                                  },
                                                  onTap: () {
                                                    if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
                                                  onChanged: (v) {
                                                    // setState(() {
                                                    //   context
                                                    //       .read<
                                                    //           NewquoteController>()
                                                    //       .filterListCity(v);
                                                    //   if (v.isEmpty) {
                                                    //     context
                                                    //         .read<
                                                    //             NewquoteController>()
                                                    //         .citybool = false;
                                                    //   } else {
                                                    //     context
                                                    //         .read<
                                                    //             NewquoteController>()
                                                    //         .citybool = true;
                                                    //   }
                                                    // });
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
                                        // Visibility(
                                        //   visible: context
                                        //       .read<NewquoteController>()
                                        //       .areabool,
                                        //   child: Column(
                                        //     children: [
                                        //       SizedBox(
                                        //         height:
                                        //             Screens.bodyheight(context) * 0.01,
                                        //       ),
                                        //       context
                                        //               .read<NewquoteController>()
                                        //               .filterCustomerList
                                        //               .isEmpty
                                        //           ? Container()
                                        //           : Container(

                                        //               // color: Colors.amber,
                                        //               decoration: BoxDecoration(
                                        //                   borderRadius:
                                        //                       BorderRadius.circular(8),
                                        //                   border: Border.all(
                                        //                       color:
                                        //                           theme.primaryColor)),
                                        //               width: Screens.width(context),
                                        //               height:
                                        //                   Screens.bodyheight(context) *
                                        //                       0.2,
                                        //               child: ListView.builder(
                                        //                   scrollDirection:
                                        //                       Axis.vertical,
                                        //                   itemCount: context
                                        //                       .read<
                                        //                           NewquoteController>()
                                        //                       .filterCustomerList
                                        //                       .length,
                                        //                   itemBuilder:
                                        //                       (BuildContext context,
                                        //                           int i) {
                                        //                     return InkWell(
                                        //                       onTap: () {
                                        //                         setState(() {
                                        //                           context
                                        //                               .read<
                                        //                                   NewquoteController>()
                                        //                               .areabool = false;
                                        //                           context
                                        //                                   .read<
                                        //                                       NewquoteController>()
                                        //                                   .mycontroller[17]
                                        //                                   .text =
                                        //                               context
                                        //                                   .read<
                                        //                                       NewquoteController>()
                                        //                                   .filterCustomerList[
                                        //                                       i]
                                        //                                   .area
                                        //                                   .toString();
                                        //                         });
                                        //                       },
                                        //                       child: Column(
                                        //                         children: [
                                        //                           Container(
                                        //                             padding: EdgeInsets.all(
                                        //                                 Screens.bodyheight(
                                        //                                         context) *
                                        //                                     0.008),
                                        //                             alignment: Alignment
                                        //                                 .centerLeft,
                                        //                             // color: Colors.red,
                                        //                             height: Screens
                                        //                                     .bodyheight(
                                        //                                         context) *
                                        //                                 0.05,
                                        //                             width:
                                        //                                 Screens.width(
                                        //                                     context),
                                        //                             child: Text(
                                        //                               "${context.watch<NewquoteController>().filterCustomerList[i].area}",
                                        //                               style: theme
                                        //                                   .textTheme
                                        //                                   .bodyText1
                                        //                                   ?.copyWith(
                                        //                                       color: Colors
                                        //                                           .black),
                                        //                             ),
                                        //                           ),
                                        //                           Divider()
                                        //                         ],
                                        //                       ),
                                        //                     );
                                        //                   })),
                                        //     ],
                                        //   ),
                                        // ),
                                        // // Visibility(
                                        //   visible: context
                                        //       .read<NewquoteController>()
                                        //       .citybool,
                                        //   child: Column(
                                        //     children: [
                                        //       SizedBox(
                                        //         height:
                                        //             Screens.bodyheight(context) * 0.01,
                                        //       ),
                                        //       context
                                        //               .read<NewquoteController>()
                                        //               .filterCustomerList
                                        //               .isEmpty
                                        //           ? Container()
                                        //           : Container(

                                        //               // color: Colors.amber,
                                        //               decoration: BoxDecoration(
                                        //                   borderRadius:
                                        //                       BorderRadius.circular(8),
                                        //                   border: Border.all(
                                        //                       color:
                                        //                           theme.primaryColor)),
                                        //               width: Screens.width(context),
                                        //               height:
                                        //                   Screens.bodyheight(context) *
                                        //                       0.2,
                                        //               child: ListView.builder(
                                        //                   scrollDirection:
                                        //                       Axis.vertical,
                                        //                   itemCount: context
                                        //                       .read<
                                        //                           NewquoteController>()
                                        //                       .filterCustomerList
                                        //                       .length,
                                        //                   itemBuilder:
                                        //                       (BuildContext context,
                                        //                           int i) {
                                        //                     return InkWell(
                                        //                       onTap: () {
                                        //                         setState(() {
                                        //                           context.read<
                                        //                               NewquoteController>();

                                        //                           context
                                        //                               .read<
                                        //                                   NewquoteController>()
                                        //                               .citybool = false;
                                        //                           context
                                        //                                   .read<
                                        //                                       NewquoteController>()
                                        //                                   .mycontroller[5]
                                        //                                   .text =
                                        //                               context
                                        //                                   .read<
                                        //                                       NewquoteController>()
                                        //                                   .filterCustomerList[
                                        //                                       i]
                                        //                                   .city
                                        //                                   .toString();
                                        //                         });
                                        //                       },
                                        //                       child: Column(
                                        //                         children: [
                                        //                           Container(
                                        //                             padding: EdgeInsets.all(
                                        //                                 Screens.bodyheight(
                                        //                                         context) *
                                        //                                     0.008),
                                        //                             alignment: Alignment
                                        //                                 .centerLeft,
                                        //                             // color: Colors.red,
                                        //                             height: Screens
                                        //                                     .bodyheight(
                                        //                                         context) *
                                        //                                 0.05,
                                        //                             width:
                                        //                                 Screens.width(
                                        //                                     context),
                                        //                             child: Text(
                                        //                               "${context.watch<NewquoteController>().filterCustomerList[i].city}",
                                        //                               style: theme
                                        //                                   .textTheme
                                        //                                   .bodyText1
                                        //                                   ?.copyWith(
                                        //                                       color: Colors
                                        //                                           .black),
                                        //                             ),
                                        //                           ),
                                        //                           Divider()
                                        //                         ],
                                        //                       ),
                                        //                     );
                                        //                   })),
                                        //     ],
                                        //   ),
                                        // ),
                                        // // SizedBox(
                                        //   height: Screens.bodyheight(context) * 0.005,
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
                                                          NewquoteController>()
                                                      .mycontroller[4],
                                                  onTap: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .clearbool();
                                                    });
                                                  },
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Enter Pincode";
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (v) {
                                                    // setState(() {
                                                    //   context
                                                    //       .read<
                                                    //           NewquoteController>()
                                                    //       .filterListPincode(v);
                                                    //   if (v.isEmpty) {
                                                    //     context
                                                    //         .read<
                                                    //             NewquoteController>()
                                                    //         .pincodebool = false;
                                                    //   } else {
                                                    //     context
                                                    //         .read<
                                                    //             NewquoteController>()
                                                    //         .pincodebool = true;
                                                    //   }
                                                    // });
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.digitsOnly,
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
                                                          NewquoteController>()
                                                      .mycontroller[18],
                                                  focusNode: context
                                                      .read<
                                                          NewquoteController>()
                                                      .focusNode1,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .always,
                                                  onChanged: (v) {
                                                    setState(() {
                                                       context
                                                          .read<
                                                              NewquoteController>() . isText1Correct=false;
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .filterListState2(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                NewquoteController>()
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
                                                                NewquoteController>()
                                                            .methidstate(context
                                                                .read<
                                                                    NewquoteController>()
                                                                .mycontroller[
                                                                    18]
                                                                .text,context);
                                                        context
                                                            .read<
                                                                NewquoteController>()
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
                                                                NewquoteController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .methidstate(context
                                                              .read<
                                                                  NewquoteController>()
                                                              .mycontroller[18]
                                                              .text,context);
                                                      FocusScope.of(context)
                                                          .requestFocus(context
                                                              .read<
                                                                  NewquoteController>()
                                                              .focusNode1);
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .statebool = false;
                                                      return "Enter Correct State";
                                                    }
                                                    return null;
                                                  },
                                                  onEditingComplete: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .statebool = false;
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .focusNode1
                                                          .unfocus();
                                                      // context
                                                      //   .read<NewEnqController>()
                                                      //   .  methodfortest();
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .methidstate(context
                                                              .read<
                                                                  NewquoteController>()
                                                              .mycontroller[18]
                                                              .text,context);

                                                      // context
                                                      // .read<NewEnqController>()
                                                      // .statecode='';
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

                                        Visibility(
                                          visible: context
                                              .read<NewquoteController>()
                                              .pincodebool,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: Screens.bodyheight(
                                                        context) *
                                                    0.01,
                                              ),
                                              context
                                                      .read<
                                                          NewquoteController>()
                                                      .filterCustomerList
                                                      .isEmpty
                                                  ? Container()
                                                  : Container(

                                                      // color: Colors.amber,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                              color: theme
                                                                  .primaryColor)),
                                                      width: Screens.width(
                                                          context),
                                                      height:
                                                          Screens.bodyheight(
                                                                  context) *
                                                              0.2,
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount: context
                                                              .read<
                                                                  NewquoteController>()
                                                              .filterCustomerList
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext context,
                                                                  int i) {
                                                            return InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  context
                                                                      .read<
                                                                          NewquoteController>()
                                                                      .pincodebool = false;
                                                                  context.read<
                                                                      NewquoteController>();

                                                                  context
                                                                          .read<
                                                                              NewquoteController>()
                                                                          .mycontroller[
                                                                              4]
                                                                          .text =
                                                                      context
                                                                          .read<
                                                                              NewquoteController>()
                                                                          .filterCustomerList[
                                                                              i]
                                                                          .zipcode
                                                                          .toString();
                                                                });
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    padding: EdgeInsets.all(
                                                                        Screens.bodyheight(context) *
                                                                            0.008),
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    // color: Colors.red,
                                                                    height: Screens.bodyheight(
                                                                            context) *
                                                                        0.05,
                                                                    width: Screens
                                                                        .width(
                                                                            context),
                                                                    child: Text(
                                                                      "${context.watch<NewquoteController>().filterCustomerList[i].zipcode}",
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodyText1
                                                                          ?.copyWith(
                                                                              color: Colors.black),
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

                                        SizedBox(
                                          height: Screens.bodyheight(context) *
                                              0.01,
                                        ),
                                        context
                                                    .read<NewquoteController>()
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
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: Screens.bodyheight(context) * 0.015,
                                  ),
//Ship
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Screens.width(context) * 0.03,
                                        vertical: Screens.bodyheight(context) *
                                            0.008),
                                    width: Screens.width(context),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: theme.primaryColor)),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: Screens.bodyheight(context) *
                                              0.04,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: Screens.width(context) *
                                                    0.5,
                                                child: Text(
                                                  "Shipping Address",
                                                  style: theme
                                                      .textTheme.headline6
                                                      ?.copyWith(
                                                          color: theme
                                                              .primaryColor),
                                                ),
                                              ),
                                              Checkbox(
                                                value: context
                                                    .read<NewquoteController>()
                                                    .value3,
                                                onChanged: (value) {
                                                  setState(() {
                                                    context
                                                        .read<
                                                            NewquoteController>()
                                                        .converttoShipping(
                                                            value!);
                                                    context
                                                        .read<
                                                            NewquoteController>()
                                                        .value3 = value;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextFormField(
                                            controller: context
                                                .read<NewquoteController>()
                                                .mycontroller[19],
                                                onTap: () {
                                                    if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Enter Address1";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Address1*',
                                              // fillColor: Colors.amber,
                                              border: UnderlineInputBorder(),
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
                                              errorBorder:
                                                  UnderlineInputBorder(),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(),
                                            )),
                                        // SizedBox(
                                        //   height: Screens.bodyheight(context) * 0.005,
                                        // ),
                                        TextFormField(
                                            controller: context
                                                .read<NewquoteController>()
                                                .mycontroller[20],
                                                onTap: () {
                                                    if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Enter Address2";
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              labelText: 'Address2*',
                                              border: UnderlineInputBorder(),
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
                                              errorBorder:
                                                  UnderlineInputBorder(),
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
                                              width:
                                                  Screens.width(context) * 0.4,
                                              child: TextFormField(
                                                  controller: context
                                                      .read<
                                                          NewquoteController>()
                                                      .mycontroller[21],
                                                      onTap: () {
                                                    if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Enter Area";
                                                    }
                                                    return null;
                                                  },
                                                  // onTap: () {
                                                  //   setState(() {
                                                  //     context
                                                  //         .read<
                                                  //             NewquoteController>()
                                                  //         .clearbool();
                                                  //   });
                                                  // },
                                                  onChanged: (v) {
                                                    // setState(() {
                                                    //   context
                                                    //       .read<
                                                    //           NewquoteController>()
                                                    //       .filterListArea(v);
                                                    //   if (v.isEmpty) {
                                                    //     context
                                                    //         .read<
                                                    //             NewquoteController>()
                                                    //         .areabool = false;
                                                    //   } else {
                                                    //     context
                                                    //         .read<
                                                    //             NewquoteController>()
                                                    //         .areabool = true;
                                                    //   }
                                                    // });
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
                                                          NewquoteController>()
                                                      .mycontroller[22],
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Enter City";
                                                    }
                                                    return null;
                                                  },
                                                onTap: () {
                                                    if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewquoteController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
                                                  onChanged: (v) {
                                                    // setState(() {
                                                    //   context
                                                    //       .read<
                                                    //           NewquoteController>()
                                                    //       .filterListCity(v);
                                                    //   if (v.isEmpty) {
                                                    //     context
                                                    //         .read<
                                                    //             NewquoteController>()
                                                    //         .citybool = false;
                                                    //   } else {
                                                    //     context
                                                    //         .read<
                                                    //             NewquoteController>()
                                                    //         .citybool = true;
                                                    //   }
                                                    // });
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
                                        Visibility(
                                          visible: context
                                              .read<NewquoteController>()
                                              .areabool,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: Screens.bodyheight(
                                                        context) *
                                                    0.01,
                                              ),
                                              context
                                                      .read<
                                                          NewquoteController>()
                                                      .filterCustomerList
                                                      .isEmpty
                                                  ? Container()
                                                  : Container(

                                                      // color: Colors.amber,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                              color: theme
                                                                  .primaryColor)),
                                                      width: Screens.width(
                                                          context),
                                                      height:
                                                          Screens.bodyheight(
                                                                  context) *
                                                              0.2,
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount: context
                                                              .read<
                                                                  NewquoteController>()
                                                              .filterCustomerList
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext context,
                                                                  int i) {
                                                            return InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  context
                                                                      .read<
                                                                          NewquoteController>()
                                                                      .areabool = false;
                                                                  context
                                                                          .read<
                                                                              NewquoteController>()
                                                                          .mycontroller[
                                                                              21]
                                                                          .text =
                                                                      context
                                                                          .read<
                                                                              NewquoteController>()
                                                                          .filterCustomerList[
                                                                              i]
                                                                          .area
                                                                          .toString();
                                                                });
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    padding: EdgeInsets.all(
                                                                        Screens.bodyheight(context) *
                                                                            0.008),
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    // color: Colors.red,
                                                                    height: Screens.bodyheight(
                                                                            context) *
                                                                        0.05,
                                                                    width: Screens
                                                                        .width(
                                                                            context),
                                                                    child: Text(
                                                                      "${context.watch<NewquoteController>().filterCustomerList[i].area}",
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodyText1
                                                                          ?.copyWith(
                                                                              color: Colors.black),
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
                                              .read<NewquoteController>()
                                              .citybool,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: Screens.bodyheight(
                                                        context) *
                                                    0.01,
                                              ),
                                              context
                                                      .read<
                                                          NewquoteController>()
                                                      .filterCustomerList
                                                      .isEmpty
                                                  ? Container()
                                                  : Container(

                                                      // color: Colors.amber,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                              color: theme
                                                                  .primaryColor)),
                                                      width: Screens.width(
                                                          context),
                                                      height:
                                                          Screens.bodyheight(
                                                                  context) *
                                                              0.2,
                                                      child: ListView.builder(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount: context
                                                              .read<
                                                                  NewquoteController>()
                                                              .filterCustomerList
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext context,
                                                                  int i) {
                                                            return InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  context.read<
                                                                      NewquoteController>();

                                                                  context
                                                                      .read<
                                                                          NewquoteController>()
                                                                      .citybool = false;
                                                                  context
                                                                          .read<
                                                                              NewquoteController>()
                                                                          .mycontroller[
                                                                              22]
                                                                          .text =
                                                                      context
                                                                          .read<
                                                                              NewquoteController>()
                                                                          .filterCustomerList[
                                                                              i]
                                                                          .city
                                                                          .toString();
                                                                });
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    padding: EdgeInsets.all(
                                                                        Screens.bodyheight(context) *
                                                                            0.008),
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    // color: Colors.red,
                                                                    height: Screens.bodyheight(
                                                                            context) *
                                                                        0.05,
                                                                    width: Screens
                                                                        .width(
                                                                            context),
                                                                    child: Text(
                                                                      "${context.watch<NewquoteController>().filterCustomerList[i].city}",
                                                                      style: theme
                                                                          .textTheme
                                                                          .bodyText1
                                                                          ?.copyWith(
                                                                              color: Colors.black),
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
                                                          NewquoteController>()
                                                      .mycontroller[23],
                                                  onTap: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .clearbool();
                                                    });
                                                  },
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Enter Pincode";
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (v) {
                                                    // setState(() {
                                                    //   context
                                                    //       .read<
                                                    //           NewquoteController>()
                                                    //       .filterListPincode(v);
                                                    //   if (v.isEmpty) {
                                                    //     context
                                                    //         .read<
                                                    //             NewquoteController>()
                                                    //         .pincodebool = false;
                                                    //   } else {
                                                    //     context
                                                    //         .read<
                                                    //             NewquoteController>()
                                                    //         .pincodebool = true;
                                                    //   }
                                                    // });
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.digitsOnly,
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
                                                          NewquoteController>()
                                                      .mycontroller[24],
                                                  focusNode: context
                                                      .read<
                                                          NewquoteController>()
                                                      .focusNode3,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .always,
                                                  onChanged: (v) {
                                                    setState(() {
                                                       context
                                                          .read<
                                                              NewquoteController>().  isText1Correct2=false;
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .filterListState2(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool2 = false;
                                                      }
                                                      // else if(v.isNotEmpty&&context
                                                      //       .read<NewEnqController>()
                                                      //       .statecode.isEmpty){
                                                      //         log("ANBU");

                                                      //       }

                                                      else {
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .methidstate2(context
                                                                .read<
                                                                    NewquoteController>()
                                                                .mycontroller[
                                                                    24]
                                                                .text);
                                                        context
                                                            .read<
                                                                NewquoteController>()
                                                            .statebool2 = true;
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
                                                                NewquoteController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .methidstate2(context
                                                              .read<
                                                                  NewquoteController>()
                                                              .mycontroller[24]
                                                              .text);
                                                      FocusScope.of(context)
                                                          .requestFocus(context
                                                              .read<
                                                                  NewquoteController>()
                                                              .focusNode3);
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .statebool2 = false;
                                                      return "Enter Correct State";
                                                    }
                                                    return null;
                                                  },
                                                  onEditingComplete: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .statebool2 = false;
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .focusNode3
                                                          .unfocus();
                                                      // context
                                                      //   .read<NewEnqController>()
                                                      //   .  methodfortest();
                                                      context
                                                          .read<
                                                              NewquoteController>()
                                                          .methidstate2(context
                                                              .read<
                                                                  NewquoteController>()
                                                              .mycontroller[24]
                                                              .text);

                                                      // context
                                                      // .read<NewEnqController>()
                                                      // .statecode='';
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
                                        context
                                                    .read<NewquoteController>()
                                                    .isText1Correct2 ==
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
                                              .read<NewquoteController>()
                                              .statebool2,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: Screens.width(context) *
                                                    0.4),
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              width:
                                                  Screens.width(context) * 0.5,
                                              // height: Screens.bodyheight(context)*0.3,
                                              color: Colors.white,
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: context
                                                      .read<
                                                          NewquoteController>()
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
                                                                  NewquoteController>()
                                                              .stateontap2(i);
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
                                                              "${context.watch<NewquoteController>().filterstateData[i].stateName}",
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
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height: Screens.bodyheight(context) *
                                              0.01,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: context
                                    .read<NewquoteController>()
                                    .statebool,
                                child: Positioned(
                                    top: Screens.bodyheight(context) * 0.4,
                                    left: Screens.width(context) * 0.4,
                                    child: Container(
                                      width: Screens.width(context) * 0.8,
                                      // height: Screens.bodyheight(context)*0.05,
                                      color: Colors.white,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: context
                                              .read<NewquoteController>()
                                              .filterstateData
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  context
                                                      .read<
                                                          NewquoteController>()
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
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    // color: Colors.red,
                                                    // height: Screens
                                                    //         .bodyheight(
                                                    //             context) *
                                                    //     0.05,
                                                    width:
                                                        Screens.width(context),
                                                    child: Text(
                                                      "${context.watch<NewquoteController>().filterstateData[i].stateName}",
                                                      style: theme
                                                          .textTheme.bodyText1
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
                              ),
                            ],
                          ),

                          SizedBox(
                            height: Screens.bodyheight(context) * 0.02,
                          ),
                          // TextFormField(
                          //     controller: context
                          //         .read<NewquoteController>()
                          //         .mycontroller[8],
                          //     // validator: (value) {
                          //     //   if (value!.isEmpty) {
                          //     //     return "Enter Head Count";
                          //     //   }
                          //     //   return null;
                          //     // },
                          //     keyboardType: TextInputType.number,
                          //     decoration: InputDecoration(
                          //       hintText: 'Head Count',
                          //       border: UnderlineInputBorder(),
                          //       enabledBorder: UnderlineInputBorder(),
                          //       focusedBorder: UnderlineInputBorder(),
                          //       errorBorder: UnderlineInputBorder(),
                          //       focusedErrorBorder: UnderlineInputBorder(),
                          //     )),
                          // SizedBox(
                          //   height: Screens.bodyheight(context) * 0.005,
                          // ),
                          // TextFormField(
                          //     controller: context
                          //         .read<NewquoteController>()
                          //         .mycontroller[9],
                          //     // validator: (value) {
                          //     //   if (value!.isEmpty) {
                          //     //     return "Enter Max Budget";
                          //     //   }
                          //     //   return null;
                          //     // },
                          //     keyboardType: TextInputType.number,
                          //     decoration: InputDecoration(
                          //       hintText: 'Max Budget',
                          //       border: UnderlineInputBorder(),
                          //       enabledBorder: UnderlineInputBorder(),
                          //       focusedBorder: UnderlineInputBorder(),
                          //       errorBorder: UnderlineInputBorder(),
                          //       focusedErrorBorder: UnderlineInputBorder(),
                          //     )),
                          // SizedBox(
                          //   height: Screens.bodyheight(context) * 0.02,
                          // ),

                          // //Gender
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       context
                          //                   .read<NewquoteController>()
                          //                   .validateGender ==
                          //               true
                          //           ? "Gender *"
                          //           : "Gender",
                          //       style: context
                          //                   .read<NewquoteController>()
                          //                   .validateGender ==
                          //               true
                          //           ? theme.textTheme.bodyText1
                          //               ?.copyWith(color: Colors.red)
                          //           : theme.textTheme.bodyText1,
                          //     ),
                          //     SizedBox(
                          //       height: Screens.bodyheight(context) * 0.01,
                          //     ),
                          //     Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<NewquoteController>()
                          //                 .selectGender("Male");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 NewquoteController>()
                          //                             .getisSelectedGender ==
                          //                         'Male'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Male",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       NewquoteController>()
                          //                                   .getisSelectedGender ==
                          //                               "Male"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<NewquoteController>()
                          //                 .selectGender("Female");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 NewquoteController>()
                          //                             .getisSelectedGender ==
                          //                         'Female'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Female",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       NewquoteController>()
                          //                                   .getisSelectedGender ==
                          //                               "Female"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<NewquoteController>()
                          //                 .selectGender("Other");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 NewquoteController>()
                          //                             .getisSelectedGender ==
                          //                         'Other'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Other",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       NewquoteController>()
                          //                                   .getisSelectedGender ==
                          //                               "Other"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),

                          // //age group
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     SizedBox(
                          //       height: Screens.bodyheight(context) * 0.03,
                          //     ),
                          //     Text(
                          //       context.read<NewquoteController>().validateAge ==
                          //               true
                          //           ? "Age Group *"
                          //           : "Age Group",
                          //       style: context
                          //                   .read<NewquoteController>()
                          //                   .validateAge ==
                          //               true
                          //           ? theme.textTheme.bodyText1
                          //               ?.copyWith(color: Colors.red)
                          //           : theme.textTheme.bodyText1,
                          //     ),
                          //     SizedBox(
                          //       height: Screens.bodyheight(context) * 0.01,
                          //     ),
                          //     Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<NewquoteController>()
                          //                 .selectage("20-30");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 NewquoteController>()
                          //                             .getisSelectedAge ==
                          //                         '20-30'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("20-30",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       NewquoteController>()
                          //                                   .getisSelectedAge ==
                          //                               "20-30"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<NewquoteController>()
                          //                 .selectage("30-40");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 NewquoteController>()
                          //                             .getisSelectedAge ==
                          //                         '30-40'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("30-40",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       NewquoteController>()
                          //                                   .getisSelectedAge ==
                          //                               "30-40"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<NewquoteController>()
                          //                 .selectage("40-50");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 NewquoteController>()
                          //                             .getisSelectedAge ==
                          //                         '40-50'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("40-50",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       NewquoteController>()
                          //                                   .getisSelectedAge ==
                          //                               "40-50"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(
                          //       height: Screens.bodyheight(context) * 0.01,
                          //     ),
                          //     InkWell(
                          //       onTap: () {
                          //         context
                          //             .read<NewquoteController>()
                          //             .selectage("50>");
                          //       },
                          //       child: Container(
                          //         width: Screens.width(context) * 0.29,
                          //         height: Screens.bodyheight(context) * 0.06,
                          //         //  padding: EdgeInsets.all(10),
                          //         decoration: BoxDecoration(
                          //             color: context
                          //                         .watch<NewquoteController>()
                          //                         .getisSelectedAge ==
                          //                     '50>'
                          //                 ? theme.primaryColor
                          //                 : Colors.white,
                          //             border: Border.all(
                          //                 color: theme.primaryColor, width: 1),
                          //             borderRadius: BorderRadius.circular(10)),
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Text("50>",
                          //                 maxLines: 8,
                          //                 overflow: TextOverflow.ellipsis,
                          //                 style: theme.textTheme.bodyText1
                          //                     ?.copyWith(
                          //                   color: context
                          //                               .watch<
                          //                                   NewquoteController>()
                          //                               .getisSelectedAge ==
                          //                           "50>"
                          //                       ? Colors.white
                          //                       : theme.primaryColor,
                          //                 ))
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          // //come with as
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     SizedBox(
                          //       height: Screens.bodyheight(context) * 0.03,
                          //     ),
                          //     Text(
                          //       context
                          //                   .read<NewquoteController>()
                          //                   .validateComas ==
                          //               true
                          //           ? "Came as *"
                          //           : "Came as",
                          //       style: context
                          //                   .read<NewquoteController>()
                          //                   .validateComas ==
                          //               true
                          //           ? theme.textTheme.bodyText1
                          //               ?.copyWith(color: Colors.red)
                          //           : theme.textTheme.bodyText1,
                          //     ),
                          //     SizedBox(
                          //       height: Screens.bodyheight(context) * 0.01,
                          //     ),
                          //     Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<NewquoteController>()
                          //                 .selectComeas("Family");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 NewquoteController>()
                          //                             .getisSelectedcomeas ==
                          //                         'Family'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Family",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       NewquoteController>()
                          //                                   .getisSelectedcomeas ==
                          //                               "Family"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<NewquoteController>()
                          //                 .selectComeas("Individual");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 NewquoteController>()
                          //                             .getisSelectedcomeas ==
                          //                         'Individual'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Individual",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       NewquoteController>()
                          //                                   .getisSelectedcomeas ==
                          //                               "Individual"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context
                          //                 .read<NewquoteController>()
                          //                 .selectComeas("Friends");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.29,
                          //             height:
                          //                 Screens.bodyheight(context) * 0.06,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<
                          //                                 NewquoteController>()
                          //                             .getisSelectedcomeas ==
                          //                         'Friends'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor,
                          //                     width: 1),
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Friends",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                       color: context
                          //                                   .watch<
                          //                                       NewquoteController>()
                          //                                   .getisSelectedcomeas ==
                          //                               "Friends"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     SizedBox(
                          //       height: Screens.bodyheight(context) * 0.01,
                          //     ),
                          //     InkWell(
                          //       onTap: () {
                          //         context
                          //             .read<NewquoteController>()
                          //             .selectComeas("Corporate");
                          //       },
                          //       child: Container(
                          //         width: Screens.width(context) * 0.29,
                          //         height: Screens.bodyheight(context) * 0.06,
                          //         //  padding: EdgeInsets.all(10),
                          //         decoration: BoxDecoration(
                          //             color: context
                          //                         .watch<NewquoteController>()
                          //                         .getisSelectedcomeas ==
                          //                     'Corporate'
                          //                 ? theme.primaryColor
                          //                 : Colors.white,
                          //             border: Border.all(
                          //                 color: theme.primaryColor, width: 1),
                          //             borderRadius: BorderRadius.circular(10)),
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Text("Corporate",
                          //                 maxLines: 8,
                          //                 overflow: TextOverflow.ellipsis,
                          //                 style: theme.textTheme.bodyText1
                          //                     ?.copyWith(
                          //                   color: context
                          //                               .watch<
                          //                                   NewquoteController>()
                          //                               .getisSelectedcomeas ==
                          //                           "Corporate"
                          //                       ? Colors.white
                          //                       : theme.primaryColor,
                          //                 ))
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),

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
                                        .read<NewquoteController>()
                                        .firstPageNextBtn(context);
                                    log("oldcutomer: " +
                                        context
                                            .read<NewquoteController>()
                                            .oldcutomer
                                            .toString());
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
    //       }
    //     );
    //   }
    // );
  }
//   InkWell FirstPage(
//     BuildContext context,
//     ThemeData theme,
//   ) {
//     // return ChangeNotifierProvider<NewquoteController>(
//     //       create: (context) => NewquoteController(),
//     //       builder: (context, child) {
//     //         return Consumer<NewquoteController>(
//     //           builder: (BuildContext context, provi, Widget? child) {
//     return InkWell(
//       onTap: () {
//         FocusScopeNode focus = FocusScope.of(context);
//         if (!focus.hasPrimaryFocus) {
//           focus.unfocus();
//         }
//       },
//       child: (context
//                   .read<NewquoteController>()
//                   .getexceptionOnApiCall
//                   .isEmpty &&
//               context.read<NewquoteController>().getcustomerapicLoading == true ||context.watch<NewquoteController>().isloading ==true)
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : (context
//                       .read<NewquoteController>()
//                       .getexceptionOnApiCall
//                       .isNotEmpty &&
//                   context.read<NewquoteController>().getcustomerapicLoading ==
//                       false &&context.watch<NewquoteController>().isloading !=true)
//               ? Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         context
//                             .read<NewquoteController>()
//                             .getexceptionOnApiCall,
//                         textAlign: TextAlign.center,
//                       )
//                     ],
//                   ),
//                 )
//               : Container(
//                   //  color: Colors.red,
//                   width: Screens.width(context),
//                   height: Screens.bodyheight(context),
//                   padding: EdgeInsets.symmetric(
//                       horizontal: Screens.width(context) * 0.03,
//                       vertical: Screens.bodyheight(context) * 0.02),
//                   child: SingleChildScrollView(
//                     child: Form(
//                       key: context.read<NewquoteController>().formkey[0],
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
                                     
//                                       child: Text(
//                                         "Lead No",
//                                         style: theme.textTheme.bodyText1!
//                                               .copyWith(color:theme.primaryColor),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: Screens.width(context)*0.01,
//                                     ),
//                                      Container(
                                     
//                                       child: Text(
//                                         ":",
//                                         style: theme.textTheme.bodyText1!
//                                               .copyWith(color: theme.primaryColor),
//                                       ),
//                                     ),  SizedBox(
//                                       width: Screens.width(context)*0.01,
//                                     ),
//                                     Container(
//                                       width: Screens.width(context)*0.10,
//                                       child: Text(
//                                         "${context
//                                         .read<NewquoteController>()
//                                         .leadnum}",
//                                         style: theme.textTheme.bodyText1!
//                                               .copyWith(color: theme.primaryColor),
//                                       ),
//                                     ),
//                             ],
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: Screens.width(context) * 0.03,
//                                 vertical: Screens.bodyheight(context) * 0.008),
//                             width: Screens.width(context),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(color: theme.primaryColor)),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   width: Screens.width(context),
//                                   child: Text(
//                                     "Customer Info",
//                                     style: theme.textTheme.headline6
//                                         ?.copyWith(color: theme.primaryColor),
//                                   ),
//                                 ),
//                                 TextFormField(
//                                     controller: context
//                                         .read<NewquoteController>()
//                                         .mycontroller[0],
//                                     validator: (value) {
//                                       if (value!.isEmpty) {
//                                         return "Enter Mobile Number";
//                                       } else if (value.length > 10 ||
//                                           value.length < 10) {
//                                         return "Enter a valid Mobile Number";
//                                       }
//                                       return null;
//                                     },
//                                     onChanged: (v) {
//                                       if (v.length == 10 &&
//                                           context
//                                                   .read<NewquoteController>()
//                                                   .getcustomerapicalled ==
//                                               false) {
//                                             //       context
//                                             // .read<NewquoteController>()
//                                             // .callCheckEnqDetailsApi(context);
//                                         // context.read<NewquoteController>().callApi();
                                      
//                                       }
//                                     },
//                                     inputFormatters: [
//                                       new LengthLimitingTextInputFormatter(10),
//                                     ],
//                                     keyboardType: TextInputType.number,
//                                     decoration: InputDecoration(
//                                       labelText: 'Mobile*',
//                                       labelStyle: theme.textTheme.bodyText1!
//                                           .copyWith(color: Colors.grey),
//                                       enabledBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in unfocused
//                                       ),
//                                       focusedBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in focused
//                                       ),
//                                       border: UnderlineInputBorder(),
//                                       // enabledBorder: UnderlineInputBorder(),
//                                       // focusedBorder: UnderlineInputBorder(),
//                                       errorBorder: UnderlineInputBorder(),
//                                       focusedErrorBorder:
//                                           UnderlineInputBorder(),
//                                     )),
//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),
//                                 Center(
//                                   child: Wrap(
//                                       spacing: 5.0, // width
//                                       runSpacing: 10.0, // height
//                                       children: listContainersCustomertags(
//                                         theme,
//                                       )),
//                                 ),
//                                 // SizedBox(
//                                 //   height: Screens.bodyheight(context) * 0.005,
//                                 // ),
//                                 TextFormField(
//                                     controller: context
//                                         .read<NewquoteController>()
//                                         .mycontroller[16],
//                                     validator: (value) {
//                                       if (value!.isEmpty) {
//                                         return "Enter Customer";
//                                       }
//                                       return null;
//                                     },
//                                     onTap: () {
//                                       setState(() {
//                                         context
//                                             .read<NewquoteController>()
//                                             .clearbool();
//                                       });
//                                     },
//                                     onChanged: (v) {
//                                       // setState(() {
//                                       //   context
//                                       //       .read<NewquoteController>()
//                                       //       .filterListcustomer(v);
//                                       //   if (v.isEmpty) {
//                                       //     context
//                                       //         .read<NewquoteController>()
//                                       //         .customerbool = false;
//                                       //   } else {
//                                       //     context
//                                       //         .read<NewquoteController>()
//                                       //         .customerbool = true;
//                                       //   }
//                                       // });
//                                     },
//                                     decoration: InputDecoration(
//                                       labelText: 'Customer',
//                                       border: UnderlineInputBorder(),
//                                       labelStyle: theme.textTheme.bodyText1!
//                                           .copyWith(color: Colors.grey),
//                                       enabledBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in unfocused
//                                       ),
//                                       focusedBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in focused
//                                       ),
//                                       errorBorder: UnderlineInputBorder(),
//                                       focusedErrorBorder:
//                                           UnderlineInputBorder(),
//                                     )),
//                                 Visibility(
//                                   visible: context
//                                       .read<NewquoteController>()
//                                       .customerbool,
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height:
//                                             Screens.bodyheight(context) * 0.01,
//                                       ),
//                                       context
//                                               .read<NewquoteController>()
//                                               .filterCustomerList
//                                               .isEmpty
//                                           ? Container()
//                                           : Container(

//                                               // color: Colors.amber,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   border: Border.all(
//                                                       color:
//                                                           theme.primaryColor)),
//                                               width: Screens.width(context),
//                                               height:
//                                                   Screens.bodyheight(context) *
//                                                       0.2,
//                                               child: ListView.builder(
//                                                   scrollDirection:
//                                                       Axis.vertical,
//                                                   itemCount: context
//                                                       .read<
//                                                           NewquoteController>()
//                                                       .filterCustomerList
//                                                       .length,
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                           int i) {
//                                                     return InkWell(
//                                                       onTap: () {
//                                                         setState(() {
//                                                           // context
//                                                           //     .read<
//                                                           //         NewquoteController>()
//                                                           //     .customerbool = false;
//                                                           // context
//                                                           //     .read<
//                                                           //         NewquoteController>()
//                                                           //     .getExiCustomerData(
//                                                           //         context
//                                                           //             .read<
//                                                           //                 NewquoteController>()
//                                                           //             .filterCustomerList[
//                                                           //                 i]
//                                                           //             .cardname
//                                                           //             .toString(),
//                                                           //         context
//                                                           //             .read<
//                                                           //                 NewquoteController>()
//                                                           //             .filterCustomerList[
//                                                           //                 i]
//                                                           //             .cardcode
//                                                           //             .toString());
//                                                           // context
//                                                           //         .read<
//                                                           //             NewquoteController>()
//                                                           //         .mycontroller[16]
//                                                           //         .text =
//                                                           //     context
//                                                           //         .read<
//                                                           //             NewquoteController>()
//                                                           //         .filterCustomerList[
//                                                           //             i]
//                                                           //         .cardname
//                                                           //         .toString();
//                                                         });
//                                                       },
//                                                       child: Column(
//                                                         children: [
//                                                           Container(
//                                                             padding: EdgeInsets.all(
//                                                                 Screens.bodyheight(
//                                                                         context) *
//                                                                     0.008),
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             // color: Colors.red,
//                                                             height: Screens
//                                                                     .bodyheight(
//                                                                         context) *
//                                                                 0.05,
//                                                             width:
//                                                                 Screens.width(
//                                                                     context),
//                                                             child: Text(
//                                                               "${context.watch<NewquoteController>().filterCustomerList[i].cardname}",
//                                                               style: theme
//                                                                   .textTheme
//                                                                   .bodyText1
//                                                                   ?.copyWith(
//                                                                       color: Colors
//                                                                           .black),
//                                                             ),
//                                                           ),
//                                                           Divider()
//                                                         ],
//                                                       ),
//                                                     );
//                                                   })),
//                                     ],
//                                   ),
//                                 ),
                                
//                                 TextFormField(
//                                     controller: context
//                                         .read<NewquoteController>()
//                                         .mycontroller[1],
//                                     // validator: (value) {
//                                     //   if (value!.isEmpty) {
//                                     //     return "Enter Contact Name";
//                                     //   }
//                                     //   return null;
//                                     // },
//                                     decoration: InputDecoration(
//                                       labelText: 'Contact Name*',
//                                       labelStyle: theme.textTheme.bodyText1!
//                                           .copyWith(color: Colors.grey),
//                                       enabledBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in unfocused
//                                       ),
//                                       focusedBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in focused
//                                       ),
//                                       border: UnderlineInputBorder(),
//                                       // enabledBorder: UnderlineInputBorder(),
//                                       // focusedBorder: UnderlineInputBorder(),
//                                       errorBorder: UnderlineInputBorder(),
//                                       focusedErrorBorder:
//                                           UnderlineInputBorder(),
//                                     )),
//                                 TextFormField(
//                                     controller: context
//                                         .read<NewquoteController>()
//                                         .mycontroller[6],
//                                     // validator: (value) {
//                                     //   if (value!.isEmpty) {
//                                     //     return "Enter Alternate Mobile No";
//                                     //   } else if (value.length > 10 || value.length < 10) {
//                                     //     return "Enter a valid Mobile Number";
//                                     //   }
//                                     //   return null;
//                                     // },
//                                     inputFormatters: [
//                                       new LengthLimitingTextInputFormatter(10),
//                                     ],
//                                     keyboardType: TextInputType.number,
//                                     decoration: InputDecoration(
//                                       labelText: 'Alternate Mobile No',
//                                       labelStyle: theme.textTheme.bodyText1!
//                                           .copyWith(color: Colors.grey),
//                                       enabledBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in unfocused
//                                       ),
//                                       focusedBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in focused
//                                       ),
//                                       border: UnderlineInputBorder(),
//                                       // enabledBorder: UnderlineInputBorder(),
//                                       // focusedBorder: UnderlineInputBorder(),
//                                       errorBorder: UnderlineInputBorder(),
//                                       focusedErrorBorder:
//                                           UnderlineInputBorder(),
//                                     )),
//                                 TextFormField(
//                                     controller: context
//                                         .read<NewquoteController>()
//                                         .mycontroller[7],
//                                     validator: (value) {
//                                       if (value!.isNotEmpty) {
//                                         //   // context.read<SalesQuotationCon>().ffff =
//                                         //   //     "Please Enter the Email Address";
//                                         //   return "Please Enter the Email Address";
//                                         if (!RegExp(
//                                                 r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                                             .hasMatch(value.trim())) {
//                                           // context.read<NewEnqController>().ffff ="Please Enter the Valid Email";
//                                           return "Please Enter the Valid Email";
//                                         }
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                     decoration: InputDecoration(
//                                       labelText: 'Email',
//                                       labelStyle: theme.textTheme.bodyText1!
//                                           .copyWith(color: Colors.grey),
//                                       enabledBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in unfocused
//                                       ),
//                                       focusedBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in focused
//                                       ),
//                                       border: UnderlineInputBorder(),
//                                       // enabledBorder: UnderlineInputBorder(),
//                                       // focusedBorder: UnderlineInputBorder(),
//                                       errorBorder: UnderlineInputBorder(),
//                                       focusedErrorBorder:
//                                           UnderlineInputBorder(),
//                                     )),
//                                 TextFormField(
//                                     maxLength: 15,
//                                     controller: context
//                                         .read<NewquoteController>()
//                                         .mycontroller[25],

//                                     // validator: (value) {
//                                     //   if (value!.isEmpty) {
//                                     //     return "Enter Email";
//                                     //   }else if(!value.contains("@")){
//                                     //       return "Enter Valid Email";
//                                     //   }
//                                     //   return null;
//                                     // },
//                                     decoration: InputDecoration(
//                                       counterText: '',
//                                       labelText: 'GST No',
//                                       labelStyle: theme.textTheme.bodyText1!
//                                           .copyWith(color: Colors.grey),
//                                       enabledBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in unfocused
//                                       ),
//                                       focusedBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in focused
//                                       ),
//                                       border: UnderlineInputBorder(),
//                                       // enabledBorder: UnderlineInputBorder(),
//                                       // focusedBorder: UnderlineInputBorder(),
//                                       errorBorder: UnderlineInputBorder(),
//                                       focusedErrorBorder:
//                                           UnderlineInputBorder(),
//                                     )),

//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: Screens.bodyheight(context) * 0.015,
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: Screens.width(context) * 0.03,
//                                 vertical: Screens.bodyheight(context) * 0.008),
//                             width: Screens.width(context),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(color: theme.primaryColor)),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   width: Screens.width(context),
//                                   child: Text(
//                                     "Billing Address",
//                                     style: theme.textTheme.headline6
//                                         ?.copyWith(color: theme.primaryColor),
//                                   ),
//                                 ),
//                                 TextFormField(
//                                     controller: context
//                                         .read<NewquoteController>()
//                                         .mycontroller[2],
//                                     validator: (value) {
//                                       if (value!.isEmpty) {
//                                         return "Enter Address1";
//                                       }
//                                       return null;
//                                     },
//                                     decoration: InputDecoration(
//                                       labelText: 'Address1*',
//                                       labelStyle: theme.textTheme.bodyText1!
//                                           .copyWith(color: Colors.grey),
//                                       enabledBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in unfocused
//                                       ),
//                                       focusedBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in focused
//                                       ),
//                                       border: UnderlineInputBorder(),
//                                       // enabledBorder: UnderlineInputBorder(),
//                                       // focusedBorder: UnderlineInputBorder(),
//                                       errorBorder: UnderlineInputBorder(),
//                                       focusedErrorBorder:
//                                           UnderlineInputBorder(),
//                                     )),
//                                 // SizedBox(
//                                 //   height: Screens.bodyheight(context) * 0.01,
//                                 // ),
//                                 TextFormField(
//                                     controller: context
//                                         .read<NewquoteController>()
//                                         .mycontroller[3],
//                                     // validator: (value) {
//                                     //   if (value!.isEmpty) {
//                                     //     return "Enter Address2";
//                                     //   }
//                                     //   return null;
//                                     // },
//                                     decoration: InputDecoration(
//                                       labelText: 'Address2*',
//                                       labelStyle: theme.textTheme.bodyText1!
//                                           .copyWith(color: Colors.grey),
//                                       enabledBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in unfocused
//                                       ),
//                                       focusedBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in focused
//                                       ),
//                                       border: UnderlineInputBorder(),
//                                       // enabledBorder: UnderlineInputBorder(),
//                                       // focusedBorder: UnderlineInputBorder(),
//                                       errorBorder: UnderlineInputBorder(),
//                                       focusedErrorBorder:
//                                           UnderlineInputBorder(),
//                                     )),
//                                 // SizedBox(
//                                 //   height: Screens.bodyheight(context) * 0.01,
//                                 // ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       width: Screens.width(context) * 0.4,
//                                       child: TextFormField(
//                                           controller: context
//                                               .read<NewquoteController>()
//                                               .mycontroller[17],
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return "Enter Area";
//                                             }
//                                             return null;
//                                           },
//                                           onTap: () {
//                                             setState(() {
//                                               context
//                                                   .read<NewquoteController>()
//                                                   .clearbool();
//                                             });
//                                           },
//                                           onChanged: (v) {
//                                             setState(() {
//                                               // context
//                                               //     .read<NewquoteController>()
//                                               //     .filterListArea(v);
//                                               if (v.isEmpty) {
//                                                 context
//                                                     .read<NewquoteController>()
//                                                     .areabool = false;
//                                               } else {
//                                                 context
//                                                     .read<NewquoteController>()
//                                                     .areabool = true;
//                                               }
//                                             });
//                                           },
//                                           decoration: InputDecoration(
//                                             labelText: 'Area*',
//                                             border: UnderlineInputBorder(),
//                                             labelStyle: theme
//                                                 .textTheme.bodyText1!
//                                                 .copyWith(color: Colors.grey),
//                                             enabledBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey),
//                                               //  when the TextFormField in unfocused
//                                             ),
//                                             focusedBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey),
//                                               //  when the TextFormField in focused
//                                             ),
//                                             errorBorder: UnderlineInputBorder(),
//                                             focusedErrorBorder:
//                                                 UnderlineInputBorder(),
//                                           )),
//                                     ),
//                                     SizedBox(
//                                       width: Screens.width(context) * 0.4,
//                                       child: TextFormField(
//                                           controller: context
//                                               .read<NewquoteController>()
//                                               .mycontroller[5],
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return "Enter City";
//                                             }
//                                             return null;
//                                           },
//                                           onTap: () {
//                                             setState(() {
//                                               context
//                                                   .read<NewquoteController>()
//                                                   .clearbool();
//                                             });
//                                           },
//                                           onChanged: (v) {
//                                             setState(() {
//                                               // context
//                                               //     .read<NewquoteController>()
//                                               //     .filterListCity(v);
//                                               if (v.isEmpty) {
//                                                 context
//                                                     .read<NewquoteController>()
//                                                     .citybool = false;
//                                               } else {
//                                                 context
//                                                     .read<NewquoteController>()
//                                                     .citybool = true;
//                                               }
//                                             });
//                                           },
//                                           decoration: InputDecoration(
//                                             labelText: 'City*',
//                                             border: UnderlineInputBorder(),
//                                             labelStyle: theme
//                                                 .textTheme.bodyText1!
//                                                 .copyWith(color: Colors.grey),
//                                             enabledBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey),
//                                               //  when the TextFormField in unfocused
//                                             ),
//                                             focusedBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey),
//                                               //  when the TextFormField in focused
//                                             ),
//                                             errorBorder: UnderlineInputBorder(),
//                                             focusedErrorBorder:
//                                                 UnderlineInputBorder(),
//                                           )),
//                                     ),
//                                   ],
//                                 ),
//                                 Visibility(
//                                   visible: context
//                                       .read<NewquoteController>()
//                                       .areabool,
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height:
//                                             Screens.bodyheight(context) * 0.01,
//                                       ),
//                                       context
//                                               .read<NewquoteController>()
//                                               .filterCustomerList
//                                               .isEmpty
//                                           ? Container()
//                                           : Container(

//                                               // color: Colors.amber,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   border: Border.all(
//                                                       color:
//                                                           theme.primaryColor)),
//                                               width: Screens.width(context),
//                                               height:
//                                                   Screens.bodyheight(context) *
//                                                       0.2,
//                                               child: ListView.builder(
//                                                   scrollDirection:
//                                                       Axis.vertical,
//                                                   itemCount: context
//                                                       .read<
//                                                           NewquoteController>()
//                                                       .filterCustomerList
//                                                       .length,
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                           int i) {
//                                                     return InkWell(
//                                                       onTap: () {
//                                                         setState(() {
//                                                           context
//                                                               .read<
//                                                                   NewquoteController>()
//                                                               .areabool = false;
//                                                           context
//                                                                   .read<
//                                                                       NewquoteController>()
//                                                                   .mycontroller[17]
//                                                                   .text =
//                                                               context
//                                                                   .read<
//                                                                       NewquoteController>()
//                                                                   .filterCustomerList[
//                                                                       i]
//                                                                   .area
//                                                                   .toString();
//                                                         });
//                                                       },
//                                                       child: Column(
//                                                         children: [
//                                                           Container(
//                                                             padding: EdgeInsets.all(
//                                                                 Screens.bodyheight(
//                                                                         context) *
//                                                                     0.008),
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             // color: Colors.red,
//                                                             height: Screens
//                                                                     .bodyheight(
//                                                                         context) *
//                                                                 0.05,
//                                                             width:
//                                                                 Screens.width(
//                                                                     context),
//                                                             child: Text(
//                                                               "${context.watch<NewquoteController>().filterCustomerList[i].area}",
//                                                               style: theme
//                                                                   .textTheme
//                                                                   .bodyText1
//                                                                   ?.copyWith(
//                                                                       color: Colors
//                                                                           .black),
//                                                             ),
//                                                           ),
//                                                           Divider()
//                                                         ],
//                                                       ),
//                                                     );
//                                                   })),
//                                     ],
//                                   ),
//                                 ),
//                                 Visibility(
//                                   visible: context
//                                       .read<NewquoteController>()
//                                       .citybool,
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height:
//                                             Screens.bodyheight(context) * 0.01,
//                                       ),
//                                       context
//                                               .read<NewquoteController>()
//                                               .filterCustomerList
//                                               .isEmpty
//                                           ? Container()
//                                           : Container(

//                                               // color: Colors.amber,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   border: Border.all(
//                                                       color:
//                                                           theme.primaryColor)),
//                                               width: Screens.width(context),
//                                               height:
//                                                   Screens.bodyheight(context) *
//                                                       0.2,
//                                               child: ListView.builder(
//                                                   scrollDirection:
//                                                       Axis.vertical,
//                                                   itemCount: context
//                                                       .read<
//                                                           NewquoteController>()
//                                                       .filterCustomerList
//                                                       .length,
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                           int i) {
//                                                     return InkWell(
//                                                       onTap: () {
//                                                         setState(() {
//                                                           context.read<
//                                                               NewquoteController>();

//                                                           context
//                                                               .read<
//                                                                   NewquoteController>()
//                                                               .citybool = false;
//                                                           context
//                                                                   .read<
//                                                                       NewquoteController>()
//                                                                   .mycontroller[5]
//                                                                   .text =
//                                                               context
//                                                                   .read<
//                                                                       NewquoteController>()
//                                                                   .filterCustomerList[
//                                                                       i]
//                                                                   .city
//                                                                   .toString();
//                                                         });
//                                                       },
//                                                       child: Column(
//                                                         children: [
//                                                           Container(
//                                                             padding: EdgeInsets.all(
//                                                                 Screens.bodyheight(
//                                                                         context) *
//                                                                     0.008),
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             // color: Colors.red,
//                                                             height: Screens
//                                                                     .bodyheight(
//                                                                         context) *
//                                                                 0.05,
//                                                             width:
//                                                                 Screens.width(
//                                                                     context),
//                                                             child: Text(
//                                                               "${context.watch<NewquoteController>().filterCustomerList[i].city}",
//                                                               style: theme
//                                                                   .textTheme
//                                                                   .bodyText1
//                                                                   ?.copyWith(
//                                                                       color: Colors
//                                                                           .black),
//                                                             ),
//                                                           ),
//                                                           Divider()
//                                                         ],
//                                                       ),
//                                                     );
//                                                   })),
//                                     ],
//                                   ),
//                                 ),
//                                 // SizedBox(
//                                 //   height: Screens.bodyheight(context) * 0.005,
//                                 // ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       width: Screens.width(context) * 0.4,
//                                       child: TextFormField(
//                                           controller: context
//                                               .read<NewquoteController>()
//                                               .mycontroller[4],
//                                           onTap: () {
//                                             setState(() {
//                                               context
//                                                   .read<NewquoteController>()
//                                                   .clearbool();
//                                             });
//                                           },
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return "Enter Pincode";
//                                             }
//                                             return null;
//                                           },
//                                           onChanged: (v) {
//                                             setState(() {
//                                               // context
//                                               //     .read<NewquoteController>()
//                                               //     .filterListPincode(v);
//                                               if (v.isEmpty) {
//                                                 context
//                                                     .read<NewquoteController>()
//                                                     .pincodebool = false;
//                                               } else {
//                                                 context
//                                                     .read<NewquoteController>()
//                                                     .pincodebool = true;
//                                               }
//                                             });
//                                           },
//                                           keyboardType: TextInputType.number,
//                                           inputFormatters: [
//                                             new LengthLimitingTextInputFormatter(
//                                                 6),
//                                           ],
//                                           decoration: InputDecoration(
//                                             labelText: 'Pincode*',
//                                             border: UnderlineInputBorder(),
//                                             labelStyle: theme
//                                                 .textTheme.bodyText1!
//                                                 .copyWith(color: Colors.grey),
//                                             enabledBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey),
//                                               //  when the TextFormField in unfocused
//                                             ),
//                                             focusedBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey),
//                                               //  when the TextFormField in focused
//                                             ),
//                                             errorBorder: UnderlineInputBorder(),
//                                             focusedErrorBorder:
//                                                 UnderlineInputBorder(),
//                                           )),
//                                     ),
//                                     SizedBox(
//                                       width: Screens.width(context) * 0.4,
//                                       child: TextFormField(
//                                           controller: context
//                                               .read<NewquoteController>()
//                                               .mycontroller[18],
//                                           onTap: () {
//                                             setState(() {
//                                               context
//                                                   .read<NewquoteController>()
//                                                   .clearbool();
//                                             });
//                                           },
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return "Enter State*";
//                                             }
//                                             return null;
//                                           },
//                                           onChanged: (v) {
//                                             setState(() {
//                                               // context
//                                               //     .read<NewquoteController>()
//                                               //     .filterListState(v);
//                                               if (v.isEmpty) {
//                                                 context
//                                                     .read<NewquoteController>()
//                                                     .statebool = false;
//                                               } else {
//                                                 context
//                                                     .read<NewquoteController>()
//                                                     .statebool = true;
//                                               }
//                                             });
//                                           },
//                                           decoration: InputDecoration(
//                                             labelText: 'State',
//                                             border: UnderlineInputBorder(),
//                                             labelStyle: theme
//                                                 .textTheme.bodyText1!
//                                                 .copyWith(color: Colors.grey),
//                                             enabledBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey),
//                                               //  when the TextFormField in unfocused
//                                             ),
//                                             focusedBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey),
//                                               //  when the TextFormField in focused
//                                             ),
//                                             errorBorder: UnderlineInputBorder(),
//                                             focusedErrorBorder:
//                                                 UnderlineInputBorder(),
//                                           )),
//                                     ),
//                                   ],
//                                 ),
//                                 Visibility(
//                                   visible: context
//                                       .read<NewquoteController>()
//                                       .pincodebool,
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height:
//                                             Screens.bodyheight(context) * 0.01,
//                                       ),
//                                       context
//                                               .read<NewquoteController>()
//                                               .filterCustomerList
//                                               .isEmpty
//                                           ? Container()
//                                           : Container(

//                                               // color: Colors.amber,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   border: Border.all(
//                                                       color:
//                                                           theme.primaryColor)),
//                                               width: Screens.width(context),
//                                               height:
//                                                   Screens.bodyheight(context) *
//                                                       0.2,
//                                               child: ListView.builder(
//                                                   scrollDirection:
//                                                       Axis.vertical,
//                                                   itemCount: context
//                                                       .read<
//                                                           NewquoteController>()
//                                                       .filterCustomerList
//                                                       .length,
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                           int i) {
//                                                     return InkWell(
//                                                       onTap: () {
//                                                         setState(() {
//                                                           context
//                                                               .read<
//                                                                   NewquoteController>()
//                                                               .pincodebool = false;
//                                                           context.read<
//                                                               NewquoteController>();

//                                                           context
//                                                                   .read<
//                                                                       NewquoteController>()
//                                                                   .mycontroller[4]
//                                                                   .text =
//                                                               context
//                                                                   .read<
//                                                                       NewquoteController>()
//                                                                   .filterCustomerList[
//                                                                       i]
//                                                                   .zipcode
//                                                                   .toString();
//                                                         });
//                                                       },
//                                                       child: Column(
//                                                         children: [
//                                                           Container(
//                                                             padding: EdgeInsets.all(
//                                                                 Screens.bodyheight(
//                                                                         context) *
//                                                                     0.008),
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             // color: Colors.red,
//                                                             height: Screens
//                                                                     .bodyheight(
//                                                                         context) *
//                                                                 0.05,
//                                                             width:
//                                                                 Screens.width(
//                                                                     context),
//                                                             child: Text(
//                                                               "${context.watch<NewquoteController>().filterCustomerList[i].zipcode}",
//                                                               style: theme
//                                                                   .textTheme
//                                                                   .bodyText1
//                                                                   ?.copyWith(
//                                                                       color: Colors
//                                                                           .black),
//                                                             ),
//                                                           ),
//                                                           Divider()
//                                                         ],
//                                                       ),
//                                                     );
//                                                   })),
//                                     ],
//                                   ),
//                                 ),
//                                 Visibility(
//                                   visible: context
//                                       .read<NewquoteController>()
//                                       .statebool,
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height:
//                                             Screens.bodyheight(context) * 0.01,
//                                       ),
//                                       context
//                                               .read<NewquoteController>()
//                                               .filterCustomerList
//                                               .isEmpty
//                                           ? Container()
//                                           : Container(

//                                               // color: Colors.amber,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   border: Border.all(
//                                                       color:
//                                                           theme.primaryColor)),
//                                               width: Screens.width(context),
//                                               height:
//                                                   Screens.bodyheight(context) *
//                                                       0.2,
//                                               child: ListView.builder(
//                                                   scrollDirection:
//                                                       Axis.vertical,
//                                                   itemCount: context
//                                                       .read<
//                                                           NewquoteController>()
//                                                       .filterCustomerList
//                                                       .length,
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                           int i) {
//                                                     return InkWell(
//                                                       onTap: () {
//                                                         setState(() {
//                                                           context.read<
//                                                               NewquoteController>();

//                                                           context
//                                                               .read<
//                                                                   NewquoteController>()
//                                                               .statebool = false;
//                                                           context
//                                                                   .read<
//                                                                       NewquoteController>()
//                                                                   .mycontroller[18]
//                                                                   .text =
//                                                               context
//                                                                   .read<
//                                                                       NewquoteController>()
//                                                                   .filterCustomerList[
//                                                                       i]
//                                                                   .state
//                                                                   .toString();
//                                                         });
//                                                       },
//                                                       child: Column(
//                                                         children: [
//                                                           Container(
//                                                             padding: EdgeInsets.all(
//                                                                 Screens.bodyheight(
//                                                                         context) *
//                                                                     0.008),
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             // color: Colors.red,
//                                                             height: Screens
//                                                                     .bodyheight(
//                                                                         context) *
//                                                                 0.05,
//                                                             width:
//                                                                 Screens.width(
//                                                                     context),
//                                                             child: Text(
//                                                               "${context.watch<NewquoteController>().filterCustomerList[i].state}",
//                                                               style: theme
//                                                                   .textTheme
//                                                                   .bodyText1
//                                                                   ?.copyWith(
//                                                                       color: Colors
//                                                                           .black),
//                                                             ),
//                                                           ),
//                                                           Divider()
//                                                         ],
//                                                       ),
//                                                     );
//                                                   })),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),
//                               ],
//                             ),
//                           ),

//                           SizedBox(
//                             height: Screens.bodyheight(context) * 0.015,
//                           ),
// //Ship
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: Screens.width(context) * 0.03,
//                                 vertical: Screens.bodyheight(context) * 0.008),
//                             width: Screens.width(context),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(color: theme.primaryColor)),
//                             child: Column(
//                               children: [
//                                 Container(
//                                   height: Screens.bodyheight(context) * 0.04,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         width: Screens.width(context) * 0.5,
//                                         child: Text(
//                                           "Shipping Address",
//                                           style: theme.textTheme.headline6
//                                               ?.copyWith(
//                                                   color: theme.primaryColor),
//                                         ),
//                                       ),
//                                       Checkbox(
//                                         value: context
//                                             .read<NewquoteController>()
//                                             .value,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             context
//                                                 .read<NewquoteController>()
//                                                 .converttoShipping(value!);
//                                             context
//                                                 .read<NewquoteController>()
//                                                 .value = value;
//                                           });
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 TextFormField(
//                                     controller: context
//                                         .read<NewquoteController>()
//                                         .mycontroller[19],
//                                     validator: (value) {
//                                       if (value!.isEmpty) {
//                                         return "Enter Address1";
//                                       }
//                                       return null;
//                                     },
//                                     decoration: InputDecoration(
//                                       labelText: 'Address1*',
//                                       // fillColor: Colors.amber,
//                                       border: UnderlineInputBorder(),
//                                       labelStyle: theme.textTheme.bodyText1!
//                                           .copyWith(color: Colors.grey),
//                                       enabledBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in unfocused
//                                       ),
//                                       focusedBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in focused
//                                       ),
//                                       errorBorder: UnderlineInputBorder(),
//                                       focusedErrorBorder:
//                                           UnderlineInputBorder(),
//                                     )),
//                                 // SizedBox(
//                                 //   height: Screens.bodyheight(context) * 0.005,
//                                 // ),
//                                 TextFormField(
//                                     controller: context
//                                         .read<NewquoteController>()
//                                         .mycontroller[20],
//                                     // validator: (value) {
//                                     //   if (value!.isEmpty) {
//                                     //     return "Enter Address2";
//                                     //   }
//                                     //   return null;
//                                     // },
//                                     decoration: InputDecoration(
//                                       labelText: 'Address2*',
//                                       border: UnderlineInputBorder(),
//                                       labelStyle: theme.textTheme.bodyText1!
//                                           .copyWith(color: Colors.grey),
//                                       enabledBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in unfocused
//                                       ),
//                                       focusedBorder: UnderlineInputBorder(
//                                         borderSide:
//                                             BorderSide(color: Colors.grey),
//                                         //  when the TextFormField in focused
//                                       ),
//                                       errorBorder: UnderlineInputBorder(),
//                                       focusedErrorBorder:
//                                           UnderlineInputBorder(),
//                                     )),
//                                 // SizedBox(
//                                 //   height: Screens.bodyheight(context) * 0.005,
//                                 // ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       width: Screens.width(context) * 0.4,
//                                       child: TextFormField(
//                                           controller: context
//                                               .read<NewquoteController>()
//                                               .mycontroller[21],
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return "Enter Area";
//                                             }
//                                             return null;
//                                           },
//                                           onTap: () {
//                                             setState(() {
//                                               context
//                                                   .read<NewquoteController>()
//                                                   .clearbool();
//                                             });
//                                           },
//                                           onChanged: (v) {
//                                             setState(() {
//                                               // context
//                                               //     .read<NewquoteController>()
//                                               //     .filterListArea(v);
//                                               if (v.isEmpty) {
//                                                 context
//                                                     .read<NewquoteController>()
//                                                     .areabool = false;
//                                               } else {
//                                                 context
//                                                     .read<NewquoteController>()
//                                                     .areabool = true;
//                                               }
//                                             });
//                                           },
//                                           decoration: InputDecoration(
//                                             labelText: 'Area*',
//                                             border: UnderlineInputBorder(),
//                                             labelStyle: theme
//                                                 .textTheme.bodyText1!
//                                                 .copyWith(color: Colors.grey),
//                                             enabledBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey),
//                                               //  when the TextFormField in unfocused
//                                             ),
//                                             focusedBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey),
//                                               //  when the TextFormField in focused
//                                             ),
//                                             errorBorder: UnderlineInputBorder(),
//                                             focusedErrorBorder:
//                                                 UnderlineInputBorder(),
//                                           )),
//                                     ),
//                                     SizedBox(
//                                       width: Screens.width(context) * 0.4,
//                                       child: TextFormField(
//                                           controller: context
//                                               .read<NewquoteController>()
//                                               .mycontroller[22],
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return "Enter City";
//                                             }
//                                             return null;
//                                           },
//                                           onTap: () {
//                                             setState(() {
//                                               context
//                                                   .read<NewquoteController>()
//                                                   .clearbool();
//                                             });
//                                           },
//                                           onChanged: (v) {
//                                             setState(() {
//                                               // context
//                                               //     .read<NewquoteController>()
//                                               //     .filterListCity(v);
//                                               if (v.isEmpty) {
//                                                 context
//                                                     .read<NewquoteController>()
//                                                     .citybool = false;
//                                               } else {
//                                                 context
//                                                     .read<NewquoteController>()
//                                                     .citybool = true;
//                                               }
//                                             });
//                                           },
//                                           decoration: InputDecoration(
//                                             labelText: 'City*',
//                                             border: UnderlineInputBorder(),
//                                             labelStyle: theme
//                                                 .textTheme.bodyText1!
//                                                 .copyWith(color: Colors.grey),
//                                             enabledBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey),
//                                               //  when the TextFormField in unfocused
//                                             ),
//                                             focusedBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey),
//                                               //  when the TextFormField in focused
//                                             ),
//                                             errorBorder: UnderlineInputBorder(),
//                                             focusedErrorBorder:
//                                                 UnderlineInputBorder(),
//                                           )),
//                                     ),
//                                   ],
//                                 ),
//                                 Visibility(
//                                   visible: context
//                                       .read<NewquoteController>()
//                                       .areabool,
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height:
//                                             Screens.bodyheight(context) * 0.01,
//                                       ),
//                                       context
//                                               .read<NewquoteController>()
//                                               .filterCustomerList
//                                               .isEmpty
//                                           ? Container()
//                                           : Container(

//                                               // color: Colors.amber,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   border: Border.all(
//                                                       color:
//                                                           theme.primaryColor)),
//                                               width: Screens.width(context),
//                                               height:
//                                                   Screens.bodyheight(context) *
//                                                       0.2,
//                                               child: ListView.builder(
//                                                   scrollDirection:
//                                                       Axis.vertical,
//                                                   itemCount: context
//                                                       .read<
//                                                           NewquoteController>()
//                                                       .filterCustomerList
//                                                       .length,
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                           int i) {
//                                                     return InkWell(
//                                                       onTap: () {
//                                                         setState(() {
//                                                           context
//                                                               .read<
//                                                                   NewquoteController>()
//                                                               .areabool = false;
//                                                           context
//                                                                   .read<
//                                                                       NewquoteController>()
//                                                                   .mycontroller[21]
//                                                                   .text =
//                                                               context
//                                                                   .read<
//                                                                       NewquoteController>()
//                                                                   .filterCustomerList[
//                                                                       i]
//                                                                   .area
//                                                                   .toString();
//                                                         });
//                                                       },
//                                                       child: Column(
//                                                         children: [
//                                                           Container(
//                                                             padding: EdgeInsets.all(
//                                                                 Screens.bodyheight(
//                                                                         context) *
//                                                                     0.008),
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             // color: Colors.red,
//                                                             height: Screens
//                                                                     .bodyheight(
//                                                                         context) *
//                                                                 0.05,
//                                                             width:
//                                                                 Screens.width(
//                                                                     context),
//                                                             child: Text(
//                                                               "${context.watch<NewquoteController>().filterCustomerList[i].area}",
//                                                               style: theme
//                                                                   .textTheme
//                                                                   .bodyText1
//                                                                   ?.copyWith(
//                                                                       color: Colors
//                                                                           .black),
//                                                             ),
//                                                           ),
//                                                           Divider()
//                                                         ],
//                                                       ),
//                                                     );
//                                                   })),
//                                     ],
//                                   ),
//                                 ),
//                                 Visibility(
//                                   visible: context
//                                       .read<NewquoteController>()
//                                       .citybool,
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height:
//                                             Screens.bodyheight(context) * 0.01,
//                                       ),
//                                       context
//                                               .read<NewquoteController>()
//                                               .filterCustomerList
//                                               .isEmpty
//                                           ? Container()
//                                           : Container(

//                                               // color: Colors.amber,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   border: Border.all(
//                                                       color:
//                                                           theme.primaryColor)),
//                                               width: Screens.width(context),
//                                               height:
//                                                   Screens.bodyheight(context) *
//                                                       0.2,
//                                               child: ListView.builder(
//                                                   scrollDirection:
//                                                       Axis.vertical,
//                                                   itemCount: context
//                                                       .read<
//                                                           NewquoteController>()
//                                                       .filterCustomerList
//                                                       .length,
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                           int i) {
//                                                     return InkWell(
//                                                       onTap: () {
//                                                         setState(() {
//                                                           context.read<
//                                                               NewquoteController>();

//                                                           context
//                                                               .read<
//                                                                   NewquoteController>()
//                                                               .citybool = false;
//                                                           context
//                                                                   .read<
//                                                                       NewquoteController>()
//                                                                   .mycontroller[22]
//                                                                   .text =
//                                                               context
//                                                                   .read<
//                                                                       NewquoteController>()
//                                                                   .filterCustomerList[
//                                                                       i]
//                                                                   .city
//                                                                   .toString();
//                                                         });
//                                                       },
//                                                       child: Column(
//                                                         children: [
//                                                           Container(
//                                                             padding: EdgeInsets.all(
//                                                                 Screens.bodyheight(
//                                                                         context) *
//                                                                     0.008),
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             // color: Colors.red,
//                                                             height: Screens
//                                                                     .bodyheight(
//                                                                         context) *
//                                                                 0.05,
//                                                             width:
//                                                                 Screens.width(
//                                                                     context),
//                                                             child: Text(
//                                                               "${context.watch<NewquoteController>().filterCustomerList[i].city}",
//                                                               style: theme
//                                                                   .textTheme
//                                                                   .bodyText1
//                                                                   ?.copyWith(
//                                                                       color: Colors
//                                                                           .black),
//                                                             ),
//                                                           ),
//                                                           Divider()
//                                                         ],
//                                                       ),
//                                                     );
//                                                   })),
//                                     ],
//                                   ),
//                                 ),
//                                 // SizedBox(
//                                 //   height: Screens.bodyheight(context) * 0.005,
//                                 // ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       width: Screens.width(context) * 0.4,
//                                       child: TextFormField(
//                                           controller: context
//                                               .read<NewquoteController>()
//                                               .mycontroller[23],
//                                           onTap: () {
//                                             setState(() {
//                                               context
//                                                   .read<NewquoteController>()
//                                                   .clearbool();
//                                             });
//                                           },
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return "Enter Pincode";
//                                             }
//                                             return null;
//                                           },
//                                           onChanged: (v) {
//                                             setState(() {
//                                               // context
//                                               //     .read<NewquoteController>()
//                                               //     .filterListPincode(v);
//                                               if (v.isEmpty) {
//                                                 context
//                                                     .read<NewquoteController>()
//                                                     .pincodebool = false;
//                                               } else {
//                                                 context
//                                                     .read<NewquoteController>()
//                                                     .pincodebool = true;
//                                               }
//                                             });
//                                           },
//                                           keyboardType: TextInputType.number,
//                                           inputFormatters: [
//                                             new LengthLimitingTextInputFormatter(
//                                                 6),
//                                           ],
//                                           decoration: InputDecoration(
//                                             labelText: 'Pincode*',
//                                             border: UnderlineInputBorder(),
//                                             labelStyle: theme
//                                                 .textTheme.bodyText1!
//                                                 .copyWith(color: Colors.grey),
//                                             enabledBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey),
//                                               //  when the TextFormField in unfocused
//                                             ),
//                                             focusedBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey),
//                                               //  when the TextFormField in focused
//                                             ),
//                                             errorBorder: UnderlineInputBorder(),
//                                             focusedErrorBorder:
//                                                 UnderlineInputBorder(),
//                                           )),
//                                     ),
//                                     SizedBox(
//                                       width: Screens.width(context) * 0.4,
//                                       child: TextFormField(
//                                           controller: context
//                                               .read<NewquoteController>()
//                                               .mycontroller[24],
//                                           onTap: () {
//                                             setState(() {
//                                               context
//                                                   .read<NewquoteController>()
//                                                   .clearbool();
//                                             });
//                                           },
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return "Enter State";
//                                             }
//                                             return null;
//                                           },
//                                           onChanged: (v) {
//                                             setState(() {
//                                               // context
//                                               //     .read<NewquoteController>()
//                                               //     .filterListState(v);
//                                               if (v.isEmpty) {
//                                                 context
//                                                     .read<NewquoteController>()
//                                                     .statebool = false;
//                                               } else {
//                                                 context
//                                                     .read<NewquoteController>()
//                                                     .statebool = true;
//                                               }
//                                             });
//                                           },
//                                           decoration: InputDecoration(
//                                             labelText: 'State*',
//                                             border: UnderlineInputBorder(),
//                                             labelStyle: theme
//                                                 .textTheme.bodyText1!
//                                                 .copyWith(color: Colors.grey),
//                                             enabledBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey),
//                                               //  when the TextFormField in unfocused
//                                             ),
//                                             focusedBorder: UnderlineInputBorder(
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey),
//                                               //  when the TextFormField in focused
//                                             ),
//                                             errorBorder: UnderlineInputBorder(),
//                                             focusedErrorBorder:
//                                                 UnderlineInputBorder(),
//                                           )),
//                                     ),
//                                   ],
//                                 ),
//                                 Visibility(
//                                   visible: context
//                                       .read<NewquoteController>()
//                                       .pincodebool,
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height:
//                                             Screens.bodyheight(context) * 0.01,
//                                       ),
//                                       context
//                                               .read<NewquoteController>()
//                                               .filterCustomerList
//                                               .isEmpty
//                                           ? Container()
//                                           : Container(

//                                               // color: Colors.amber,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   border: Border.all(
//                                                       color:
//                                                           theme.primaryColor)),
//                                               width: Screens.width(context),
//                                               height:
//                                                   Screens.bodyheight(context) *
//                                                       0.2,
//                                               child: ListView.builder(
//                                                   scrollDirection:
//                                                       Axis.vertical,
//                                                   itemCount: context
//                                                       .read<
//                                                           NewquoteController>()
//                                                       .filterCustomerList
//                                                       .length,
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                           int i) {
//                                                     return InkWell(
//                                                       onTap: () {
//                                                         setState(() {
//                                                           context
//                                                               .read<
//                                                                   NewquoteController>()
//                                                               .pincodebool = false;
//                                                           context.read<
//                                                               NewquoteController>();

//                                                           context
//                                                                   .read<
//                                                                       NewquoteController>()
//                                                                   .mycontroller[23]
//                                                                   .text =
//                                                               context
//                                                                   .read<
//                                                                       NewquoteController>()
//                                                                   .filterCustomerList[
//                                                                       i]
//                                                                   .zipcode
//                                                                   .toString();
//                                                         });
//                                                       },
//                                                       child: Column(
//                                                         children: [
//                                                           Container(
//                                                             padding: EdgeInsets.all(
//                                                                 Screens.bodyheight(
//                                                                         context) *
//                                                                     0.008),
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             // color: Colors.red,
//                                                             height: Screens
//                                                                     .bodyheight(
//                                                                         context) *
//                                                                 0.05,
//                                                             width:
//                                                                 Screens.width(
//                                                                     context),
//                                                             child: Text(
//                                                               "${context.watch<NewquoteController>().filterCustomerList[i].zipcode}",
//                                                               style: theme
//                                                                   .textTheme
//                                                                   .bodyText1
//                                                                   ?.copyWith(
//                                                                       color: Colors
//                                                                           .black),
//                                                             ),
//                                                           ),
//                                                           Divider()
//                                                         ],
//                                                       ),
//                                                     );
//                                                   })),
//                                     ],
//                                   ),
//                                 ),
//                                 Visibility(
//                                   visible: context
//                                       .read<NewquoteController>()
//                                       .statebool,
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height:
//                                             Screens.bodyheight(context) * 0.01,
//                                       ),
//                                       context
//                                               .read<NewquoteController>()
//                                               .filterCustomerList
//                                               .isEmpty
//                                           ? Container()
//                                           : Container(

//                                               // color: Colors.amber,
//                                               decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   border: Border.all(
//                                                       color:
//                                                           theme.primaryColor)),
//                                               width: Screens.width(context),
//                                               height:
//                                                   Screens.bodyheight(context) *
//                                                       0.2,
//                                               child: ListView.builder(
//                                                   scrollDirection:
//                                                       Axis.vertical,
//                                                   itemCount: context
//                                                       .read<
//                                                           NewquoteController>()
//                                                       .filterCustomerList
//                                                       .length,
//                                                   itemBuilder:
//                                                       (BuildContext context,
//                                                           int i) {
//                                                     return InkWell(
//                                                       onTap: () {
//                                                         setState(() {
//                                                           context.read<
//                                                               NewquoteController>();

//                                                           context
//                                                               .read<
//                                                                   NewquoteController>()
//                                                               .statebool = false;
//                                                           context
//                                                                   .read<
//                                                                       NewquoteController>()
//                                                                   .mycontroller[24]
//                                                                   .text =
//                                                               context
//                                                                   .read<
//                                                                       NewquoteController>()
//                                                                   .filterCustomerList[
//                                                                       i]
//                                                                   .state
//                                                                   .toString();
//                                                         });
//                                                       },
//                                                       child: Column(
//                                                         children: [
//                                                           Container(
//                                                             padding: EdgeInsets.all(
//                                                                 Screens.bodyheight(
//                                                                         context) *
//                                                                     0.008),
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             // color: Colors.red,
//                                                             height: Screens
//                                                                     .bodyheight(
//                                                                         context) *
//                                                                 0.05,
//                                                             width:
//                                                                 Screens.width(
//                                                                     context),
//                                                             child: Text(
//                                                               "${context.watch<NewquoteController>().filterCustomerList[i].state}",
//                                                               style: theme
//                                                                   .textTheme
//                                                                   .bodyText1
//                                                                   ?.copyWith(
//                                                                       color: Colors
//                                                                           .black),
//                                                             ),
//                                                           ),
//                                                           Divider()
//                                                         ],
//                                                       ),
//                                                     );
//                                                   })),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: Screens.bodyheight(context) * 0.01,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: Screens.bodyheight(context) * 0.02,
//                           ),
                        

//                           // //nextbtn
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: SizedBox(
//                               width: Screens.width(context) * 0.3,
//                               height: Screens.bodyheight(context) * 0.07,
//                               child: ElevatedButton(
//                                   onPressed: () {
//                                     // provi.pageController.animateToPage(++provi.pageChanged,
//                                     //     duration: Duration(milliseconds: 250),
//                                     //     curve: Curves.bounceIn);
//                                     context
//                                         .read<NewquoteController>()
//                                         .firstPageNextBtn();
//                                     log("oldcutomer: " +
//                                         context
//                                             .read<NewquoteController>()
//                                             .oldcutomer
//                                             .toString());
//                                   },
//                                   child: Icon(Icons.navigate_next)),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//     );
//     //       }
//     //     );
//     //   }
//     // );
//   }

  
  List<Widget> listContainersPaymentTerms(
    ThemeData theme,
  ) {
    return List.generate(
      context.read<NewquoteController>().paymode.length,
      (index) => InkWell(
        onTap: () {
          // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
          // .getenqReffList[index].Name.toString();
          context.read<NewquoteController>().selectpaymentTerms(
              context
                  .read<NewquoteController>()
                  .paymode[index]
                  .ModeName
                  .toString(),
              context
                  .read<NewquoteController>()
                  .paymode[index]
                  .ModeName!,
              context
                  .read<NewquoteController>()
                  .paymode[index]
                  .Code!);
        },
        child: Container(
          width: Screens.width(context) * 0.4,
          height: Screens.bodyheight(context) * 0.06,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context
                          .read<NewquoteController>()
                          .isSelectedpaymentTermsCode ==
                      context
                          .read<NewquoteController>()
                          .paymode[index]
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
                      .read<NewquoteController>()
                      .paymode[index]
                      .ModeName
                      .toString(),
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyText1?.copyWith(
                    color: context
                                .read<NewquoteController>()
                                .isSelectedpaymentTermsCode ==
                            context
                                .read<NewquoteController>()
                                .paymode[index]
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

  List<Widget> listContainersCustomertags(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<NewquoteController>().customerTagTypeData.length,
      (index) => InkWell(
        onTap: () {
          // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
          // .getenqReffList[index].Name.toString();
          context.read<NewquoteController>().selectCustomerTag(
              context
                  .read<NewquoteController>()
                  .customerTagTypeData[index]
                  .Name
                  .toString(),
              context
                  .read<NewquoteController>()
                  .customerTagTypeData[index]
                  .Name!,
              context
                  .read<NewquoteController>()
                  .customerTagTypeData[index]
                  .Code!);
        },
        child: Container(
          width: Screens.width(context) * 0.2,
          height: Screens.bodyheight(context) * 0.05,
          alignment: Alignment.center,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context.watch<NewquoteController>().getisSelectedCusTag ==
                      context
                          .read<NewquoteController>()
                          .customerTagTypeData[index]
                          .Name
                          .toString()
                  ? Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
              context
                  .watch<NewquoteController>()
                  .customerTagTypeData[index]
                  .Name
                  .toString(),
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10,
                color:
                    context.watch<NewquoteController>().getisSelectedCusTag ==
                            context
                                .read<NewquoteController>()
                                .customerTagTypeData[index]
                                .Name
                                .toString()
                        ? theme.primaryColor //,Colors.white
                        : theme.primaryColor,
              )),
        ),
      ),
    );
  }
}
