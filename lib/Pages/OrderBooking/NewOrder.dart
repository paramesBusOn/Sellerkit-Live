// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_new, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Pages/OrderBooking/Widgets/paymenttermdialog.dart';
import 'package:sellerkit/Widgets/qrpage.dart';
import '../../Controller/OrderController/OrderNewController.dart';
import '../../Widgets/Appbar.dart';
import '../../Widgets/Navi3.dart';

class OrderBookNew extends StatefulWidget {
  OrderBookNew({Key? key}) : super(key: key);

  @override
  State<OrderBookNew> createState() => OrderBookNewState();
}

class OrderBookNewState extends State<OrderBookNew> {
  static bool iscomfromLead = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        // log("  iscomfromLead;"+  iscomfromLead.toString());

        if (ConstantValues.multistoreuser == 1) {
          context.read<OrderNewController>().restricteddialog(context);
        } else {
          if (iscomfromLead == false) {
            log("ANBU222::");
            context.read<OrderNewController>().init();
          } else if (iscomfromLead == true) {
            log("ANBU::");
            context.read<OrderNewController>().checkComeFromEnq(context);

            iscomfromLead = false;
          }
        }
      });

      // print("sap user id: "+ConstantValues.sapUserID);

      // log("page on: "+context.read<OrderNewController>().pageChanged.toString());
      // log("showItemList"+context.read<OrderNewController>().showItemList.toString());
      //  log("oldcutomer: "+context.read<OrderNewController>().oldcutomer.toString());
    });
  }

  DateTime? currentBackPressTime;

  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("object");
      Get.offAllNamed(ConstantRoutes.ordertab);
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }
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

    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
          drawerEnableOpenDragGesture: false,
          // backgroundColor: Colors.grey[200],
          /// resizeToAvoidBottomInset: true,
          key: scaffoldKey1,
          appBar: appbar("New Orders", scaffoldKey1, theme, context),
          drawer: drawer3(context),
          // body: ChangeNotifierProvider<OrderNewController>(
          //     create: (context) => OrderNewController(),
          //     builder: (context, child) {
          //       return Consumer<OrderNewController>(
          //           builder: (BuildContext context, provi, Widget? child) {
          // return
          body: PageView(
            physics: new NeverScrollableScrollPhysics(),
            controller: context.read<OrderNewController>().pageController,
            onPageChanged: (index) {
              log("index: ${index}");
              setState(() {
                context.read<OrderNewController>().pageChanged = index;
              });
              print(context.read<OrderNewController>().pageChanged);
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
                      Get.offAllNamed(ConstantRoutes.ordertab);
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
          ),
    );
  }

  Container ThirdPage(
    BuildContext context,
    ThemeData theme,
  ) {
    //OrderNewController provi
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
              // height: Screens.bodyheight(context) * 0.82,

              child: Form(
                key: context.read<OrderNewController>().formkey[1],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Screens.width(context),
                       height: Screens.bodyheight(context) * 0.28,
                      decoration: BoxDecoration(
                        // border: Border.all(color: theme.primaryColor),
                          color: theme.primaryColor,
                          
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.only(
                        left: Screens.width(context) * 0.02,
                        right: Screens.width(context) * 0.02,
                        top: Screens.bodyheight(context) * 0.01,
                        bottom: Screens.bodyheight(context) * 0.01,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment Terms *",
                              style: theme.textTheme.bodyText1
                                  ?.copyWith(color: Colors.white),
                            ),
                            SizedBox(height: Screens.bodyheight(context) * 0.02),
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
                              // child: Container(
                              //   height: Screens.bodyheight(context) * 0.25,
                              //   child: SingleChildScrollView(
                              //     child: Column(
                              //       children: [
                                  child:    Wrap(
                                          spacing: 20.0, // width
                                          runSpacing: 8.0, // height
                                          children: listContainersPaymentTerms(theme)),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ),
                        //   context
                        //        .read<OrderNewController>()
                        //        . PaymentTerms.toString().toLowerCase() =='neft'? Column(
                        //      children: [
                        //        TextFormField(
                        //            controller: context
                        //                .read<OrderNewController>()
                        //                .mycontroller[42],
                        //            validator: context
                        //       .read<OrderNewController>()
                        //       . PaymentTerms.toString().toLowerCase()  =='neft'
                        //                ? (value) {
                        //                    if (value!.isEmpty) {
                        //                      return "Enter Reference";
                        //                    }
                        //                    return null;
                        //                  }
                        //                : (value) {},
                        //            decoration: InputDecoration(
                        //              labelText: 'NEFT Reference',
                        //              labelStyle: theme.textTheme.bodyText1!
                        //                  .copyWith(color: Colors.grey),
                        //              enabledBorder: UnderlineInputBorder(
                        //                borderSide: BorderSide(color: Colors.grey),
                        //                //  when the TextFormField in unfocused
                        //              ),
                        //              focusedBorder: UnderlineInputBorder(
                        //                borderSide: BorderSide(color: Colors.grey),
                        //                //  when the TextFormField in focused
                        //              ),
                        //              border: UnderlineInputBorder(),
                        //              // enabledBorder: UnderlineInputBorder(),
                        //              // focusedBorder: UnderlineInputBorder(),
                        //              errorBorder: UnderlineInputBorder(),
                        //              focusedErrorBorder: UnderlineInputBorder(),
                        //            )),
                        //      ],
                        //    ):
                        // context
                        //      .read<OrderNewController>()
                        //      . PaymentTerms.toString().toLowerCase() =='upi'?
                        //  Column(
                        //   children: [
                        //     TextFormField(
                        //         controller: context
                        //             .read<OrderNewController>()
                        //             .mycontroller[43],
                        //         validator: context
                        //      .read<OrderNewController>()
                        //      . PaymentTerms.toString().toLowerCase() =='upi'
                        //             ? (value) {
                        //                 if (value!.isEmpty) {
                        //                   return "Enter Reference";
                        //                 }
                        //                 return null;
                        //               }
                        //             : (value) {},
                        //         decoration: InputDecoration(
                        //           labelText: 'UPI Reference',
                        //           labelStyle: theme.textTheme.bodyText1!
                        //               .copyWith(color: Colors.grey),
                        //           enabledBorder: UnderlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.grey),
                        //             //  when the TextFormField in unfocused
                        //           ),
                        //           focusedBorder: UnderlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.grey),
                        //             //  when the TextFormField in focused
                        //           ),
                        //           border: UnderlineInputBorder(),
                        //           // enabledBorder: UnderlineInputBorder(),
                        //           // focusedBorder: UnderlineInputBorder(),
                        //           errorBorder: UnderlineInputBorder(),
                        //           focusedErrorBorder: UnderlineInputBorder(),
                        //         )),
                        //   ],
                        // ):
                        // context
                        //    .read<OrderNewController>()
                        //    . PaymentTerms.toString().toLowerCase() =='card'?
                        //  Column(
                        //   children: [
                        //     TextFormField(
                        //         controller: context
                        //             .read<OrderNewController>()
                        //             .mycontroller[44],
                        //         validator: context
                        //    .read<OrderNewController>()
                        //    . PaymentTerms.toString().toLowerCase() =='card'
                        //             ? (value) {
                        //                 if (value!.isEmpty) {
                        //                   return "Enter Reference";
                        //                 }
                        //                 return null;
                        //               }
                        //             : (value) {},
                        //         decoration: InputDecoration(
                        //           labelText: 'Card Reference',
                        //           labelStyle: theme.textTheme.bodyText1!
                        //               .copyWith(color: Colors.grey),
                        //           enabledBorder: UnderlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.grey),
                        //             //  when the TextFormField in unfocused
                        //           ),
                        //           focusedBorder: UnderlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.grey),
                        //             //  when the TextFormField in focused
                        //           ),
                        //           border: UnderlineInputBorder(),
                        //           // enabledBorder: UnderlineInputBorder(),
                        //           // focusedBorder: UnderlineInputBorder(),
                        //           errorBorder: UnderlineInputBorder(),
                        //           focusedErrorBorder: UnderlineInputBorder(),
                        //         )),
                        //     SizedBox(
                        //       height: Screens.bodyheight(context) * 0.02,
                        //     ),
                        //     GetAttachment(theme, context),
                        //   ],
                        // ):
                        // context
                        //  .read<OrderNewController>()
                        //  . PaymentTerms.toString().toLowerCase() =='cheque'?
                        //  Column(
                        //   children: [
                        //     // TextFormField(
                        //     //     // controller: context
                        //     //     //     .read<OrderNewController>()
                        //     //     //     .mycontroller[6],
                        //     //     // validator: (value) {
                        //     //     //   if (value!.isEmpty) {
                        //     //     //     return "Enter Reference";
                        //     //     //   }
                        //     //     //   return null;
                        //     //     // },
                        //     //     decoration: InputDecoration(
                        //     //   labelText: 'Cheque No',
                        //     //   labelStyle: theme.textTheme.bodyText1!
                        //     //       .copyWith(color: Colors.grey),
                        //     //   enabledBorder: UnderlineInputBorder(
                        //     //     borderSide: BorderSide(color: Colors.grey),
                        //     //     //  when the TextFormField in unfocused
                        //     //   ),
                        //     //   focusedBorder: UnderlineInputBorder(
                        //     //     borderSide: BorderSide(color: Colors.grey),
                        //     //     //  when the TextFormField in focused
                        //     //   ),
                        //     //   border: UnderlineInputBorder(),
                        //     //   // enabledBorder: UnderlineInputBorder(),
                        //     //   // focusedBorder: UnderlineInputBorder(),
                        //     //   errorBorder: UnderlineInputBorder(),
                        //     //   focusedErrorBorder: UnderlineInputBorder(),
                        //     // )),
                        //     TextFormField(
                        //         controller: context
                        //             .read<OrderNewController>()
                        //             .mycontroller[45],
                        //         onTap: () {
                        //           context
                        //               .read<OrderNewController>()
                        //               .showchequeDate(context);
                        //         },
                        //         validator:  context
                        //  .read<OrderNewController>()
                        //  . PaymentTerms.toString().toLowerCase() =='cheque'
                        //             ? (value) {
                        //                 if (value!.isEmpty) {
                        //                   return "Enter Cheque Date";
                        //                 }
                        //                 return null;
                        //               }
                        //             : (value) {},
                        //             readOnly: true,
                        //         decoration: InputDecoration(
                        //           labelText: 'Cheque Date',
                        //           labelStyle: theme.textTheme.bodyText1!
                        //               .copyWith(color: Colors.grey),
                        //           enabledBorder: UnderlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.grey),
                        //             //  when the TextFormField in unfocused
                        //           ),
                        //           focusedBorder: UnderlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.grey),
                        //             //  when the TextFormField in focused
                        //           ),
                        //           border: UnderlineInputBorder(),
                        //           // enabledBorder: UnderlineInputBorder(),
                        //           // focusedBorder: UnderlineInputBorder(),
                        //           errorBorder: UnderlineInputBorder(),
                        //           focusedErrorBorder: UnderlineInputBorder(),
                        //         )),
                        //     TextFormField(
                        //         controller: context
                        //             .read<OrderNewController>()
                        //             .mycontroller[46],
                        //         validator:  context
                        //  .read<OrderNewController>()
                        //  . PaymentTerms.toString().toLowerCase() =='cheque'
                        //             ? (value) {
                        //                 if (value!.isEmpty) {
                        //                   return "Enter Reference";
                        //                 }
                        //                 return null;
                        //               }
                        //             : (value) {},
                        //         decoration: InputDecoration(
                        //           labelText: 'Cheque Reference',
                        //           labelStyle: theme.textTheme.bodyText1!
                        //               .copyWith(color: Colors.grey),
                        //           enabledBorder: UnderlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.grey),
                        //             //  when the TextFormField in unfocused
                        //           ),
                        //           focusedBorder: UnderlineInputBorder(
                        //             borderSide: BorderSide(color: Colors.grey),
                        //             //  when the TextFormField in focused
                        //           ),
                        //           border: UnderlineInputBorder(),
                        //           // enabledBorder: UnderlineInputBorder(),
                        //           // focusedBorder: UnderlineInputBorder(),
                        //           errorBorder: UnderlineInputBorder(),
                        //           focusedErrorBorder: UnderlineInputBorder(),
                        //         )),
                        
                        //     SizedBox(
                        //       height: Screens.bodyheight(context) * 0.02,
                        //     ),
                        //     GetAttachment(theme, context),
                        //   ],
                        // ):Container(),
                       
                        // SizedBox(
                        //   height: Screens.bodyheight(context) * 0.01,
                        // ),
                        // TextFormField(
                        //     controller: context
                        //         .read<OrderNewController>()
                        //         .mycontroller[41],
                        //     // validator: (value) {
                        //     //   if (value!.isEmpty) {
                        //     //     return "Enter Reference";
                        //     //   }
                        //     //   return null;
                        //     // },
                        //     decoration: InputDecoration(
                        //       labelText: 'Remarks',
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
                        //       border: UnderlineInputBorder(),
                        //       // enabledBorder: UnderlineInputBorder(),
                        //       // focusedBorder: UnderlineInputBorder(),
                        //       errorBorder: UnderlineInputBorder(),
                        //       focusedErrorBorder: UnderlineInputBorder(),
                        //     )),
                      
                      
                         
                          ],
                        ),
                      ),
                    ),
                    context.watch<OrderNewController>().paymentTerm == false
                        ? Container()
                        : Text(
                            "Enter Payment Terms",
                            style: TextStyle(color: Colors.red),
                          ),
                    //SizedBox(height: Screens.bodyheight(context)*0.02,),
                    // SizedBox(
                    //   height: Screens.bodyheight(context) * 0.01,
                    // ),
                    //dates
                    Column(
                      children: [
                        TextFormField(
                            onTap: () {
                              context
                                  .read<OrderNewController>()
                                  .showFollowupDate(context);
                            },
                            controller: context
                                .read<OrderNewController>()
                                .mycontroller[13],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Choose Delivery Date";
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
                                  .read<OrderNewController>()
                                  .showPaymentDate(context);
                            },
                            controller: context
                                .read<OrderNewController>()
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
                              //     .read<OrderNewController>()
                              //     .showPurchaseDate(context);
                            },
                            controller: context
                                .read<OrderNewController>()
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
                              .read<OrderNewController>()
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
                                                      .read<OrderNewController>()
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
                                                              OrderNewController>()
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
                                                                OrderNewController>()
                                                            .files
                                                            .length >
                                                        5
                                                    ? null
                                                    : () {
                                                        setState(() {
                                                          log("files length" +
                                                              context
                                                                  .read<
                                                                      OrderNewController>()
                                                                  .files
                                                                  .length
                                                                  .toString());
                                                          // showtoast();
                                                          if (context
                                                                  .read<
                                                                      OrderNewController>()
                                                                  .files
                                                                  .length <=
                                                              4) {
                                                            setState(() {
                                                              context
                                                                  .read<
                                                                      OrderNewController>()
                                                                  .imagetoBinary(
                                                                      ImageSource
                                                                          .camera);
                                                              context
                                                                  .read<
                                                                      OrderNewController>()
                                                                  .fileValidation = false;
                                                            });
                                                          } else {
                                                            print("obAAAAAject");
                                                            context
                                                                .read<
                                                                    OrderNewController>()
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
                                                              OrderNewController>()
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
                                                                OrderNewController>()
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
                                                                      OrderNewController>()
                                                                  .files
                                                                  .length <=
                                                              4) {
                                                            setState(() {
                                                              context
                                                                  .read<
                                                                      OrderNewController>()
                                                                  .selectattachment();
                
                                                              context
                                                                  .read<
                                                                      OrderNewController>()
                                                                  .fileValidation = false;
                                                            });
                                                          } else {
                                                            print("obAAAAAject");
                
                                                            context
                                                                .read<
                                                                    OrderNewController>()
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
                              context.read<OrderNewController>().files == null
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
                                                                        OrderNewController>()
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
                                                  .read<OrderNewController>()
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
                                              .read<OrderNewController>()
                                              .files
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            if (context
                                                .read<OrderNewController>()
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
                                                                    OrderNewController>()
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
                                                                          OrderNewController>()
                                                                      .files
                                                                      .removeAt(
                                                                          i);
                                                                  context
                                                                      .read<
                                                                          OrderNewController>()
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
                                                .read<OrderNewController>()
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
                                                                    OrderNewController>()
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
                                                                          OrderNewController>()
                                                                      .files
                                                                      .removeAt(
                                                                          i);
                                                                  context
                                                                      .read<
                                                                          OrderNewController>()
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
                                                .read<OrderNewController>()
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
                                                                    OrderNewController>()
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
                                                                          OrderNewController>()
                                                                      .files
                                                                      .removeAt(
                                                                          i);
                                                                  context
                                                                      .read<
                                                                          OrderNewController>()
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
                                                .read<OrderNewController>()
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
                                                                    OrderNewController>()
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
                                                                          OrderNewController>()
                                                                      .files
                                                                      .removeAt(
                                                                          i);
                                                                  context
                                                                      .read<
                                                                          OrderNewController>()
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
                                                                  OrderNewController>()
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
                                                                        OrderNewController>()
                                                                    .files
                                                                    .removeAt(i);
                                                                context
                                                                    .read<
                                                                        OrderNewController>()
                                                                    .filedata
                                                                    .removeAt(i);
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
            SizedBox(
              height: Screens.bodyheight(context) * 0.02,
            ),
            Column(
              children: [
           context.read<OrderNewController>(). postpaymentdata.isEmpty?Container():     Container(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context) * 0.1,
                  //  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      //theme.primaryColor.withOpacity(0.5)
                      
                      border: Border.all(color: theme.primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: ListView.builder(
                    itemCount:context.read<OrderNewController>(). postpaymentdata.length,
                    itemBuilder: (BuildContext context,ind){
                      return Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: Screens.width(context)*0.3,
                                        child:Text("${context.read<OrderNewController>(). postpaymentdata[ind].paymodename}", style: theme.textTheme.bodyText1?.copyWith(
                                                              ))
                                      ),
                                   Container(
                                  child:Text(":", style: theme.textTheme.bodyText1?.copyWith(
                        ))
                                ),
                                Container(
                                  
                                  child:Text(" ${context.read<OrderNewController>().config.slpitCurrency22(context.read<OrderNewController>(). postpaymentdata[ind].amount.toString())}",
                                   style: theme.textTheme.bodyText1?.copyWith()
                                  )
                                ),
                                    ],
                                  ),
                                ),
                               

                                Container(
                                  
                                  child:InkWell(
                                    onTap:(){
                                      setState(() {
                                       context.read<OrderNewController>(). deletepaymode(context.read<OrderNewController>(). postpaymentdata[ind],ind );
                                        context.read<OrderNewController>(). postpaymentdata.removeAt(ind);
                                      });

                                    },
                                    child: Icon(Icons.delete,color:Colors.red))
                                  )
                                
                              ],
                            ),
                          ],
                        ),
                      );
                  
                  }),
                ),
              SizedBox(
              height: Screens.bodyheight(context) * 0.01,
            ),
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
                          "Total Order Value Rs.${context.read<OrderNewController>().getTotalGrossAmount()}",
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyText1?.copyWith(
                            color: theme.primaryColor,
                          ))
                    ],
                  ),
                ),
                SizedBox(
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
                                .read<OrderNewController>()
                                .pageController
                                .animateToPage(
                                    --context
                                        .read<OrderNewController>()
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
                                      .watch<OrderNewController>()
                                      .getisloadingBtn ==
                                  true
                              ? null
                              : () {
                                  // print("aaaa");
                                  context
                                      .read<OrderNewController>()
                                      .thirPageBtnClicked(context);
                                },
                          child: context
                                      .watch<OrderNewController>()
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
                                  .read<OrderNewController>()
                                  .fileValidation2 ==
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
                                      .read<OrderNewController>()
                                      .fileValidation2 ==
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
                                        .read<OrderNewController>()
                                        .files2
                                        .length ==
                                    0) {
                                  setState(() {
                                    context
                                        .read<OrderNewController>()
                                        .imagetoBinary2(ImageSource.camera);
                                    context
                                        .read<OrderNewController>()
                                        .fileValidation2 = false;
                                  });
                                } else {
                                  print("obAAAAAject");
                                  context
                                      .read<OrderNewController>()
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
                                      .read<OrderNewController>()
                                      .fileValidation2 ==
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
                                        .read<OrderNewController>()
                                        .files2
                                        .length ==
                                    0) {
                                  setState(() {
                                    context
                                        .read<OrderNewController>()
                                        .selectattachment2();

                                    context
                                        .read<OrderNewController>()
                                        .fileValidation2 = false;
                                  });
                                } else {
                                  print("obAAAAAject");

                                  context
                                      .read<OrderNewController>()
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
          context.read<OrderNewController>().files2 == null
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
                                            .read<OrderNewController>()
                                            .fileValidation2 ==
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
                      context.read<OrderNewController>().files2.length == 0
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
                          context.read<OrderNewController>().files2.length,
                      itemBuilder: (BuildContext context, int i) {
                        if (context
                            .read<OrderNewController>()
                            .files2[i]
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
                                            .watch<OrderNewController>()
                                            .files2[i]
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
                                                      OrderNewController>()
                                                  .files2
                                                  .removeAt(i);
                                              context
                                                  .read<
                                                      OrderNewController>()
                                                  .filedata2
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
                            .read<OrderNewController>()
                            .files2[i]
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
                                            .watch<OrderNewController>()
                                            .files2[i]
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
                                                      OrderNewController>()
                                                  .files2
                                                  .removeAt(i);
                                              context
                                                  .read<
                                                      OrderNewController>()
                                                  .filedata2
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
  Container SecondPage(
    BuildContext context,
    ThemeData theme,
  ) {
    //  return ChangeNotifierProvider<OrderNewController>(
    //       create: (context) => OrderNewController(),
    //       builder: (context, child) {
    //         return Consumer<OrderNewController>(
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
                width: context.read<OrderNewController>().showItemList == true
                    ? Screens.width(context) * 0.80
                    : Screens.width(context) * 0.95,
                height: Screens.bodyheight(context) * 0.06,
                decoration: BoxDecoration(
                  color:
                      theme.primaryColor.withOpacity(0.1), //Colors.grey[200],
                  borderRadius:
                      BorderRadius.circular(Screens.width(context) * 0.02),
                ),
                child: TextField(
                  autocorrect: false,
                  onChanged: (val) {
                    context.read<OrderNewController>().filterList(val);
                  },
                  controller:
                      context.read<OrderNewController>().mycontroller[12],
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
                        context.read<OrderNewController>().changeVisible();
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
              context.read<OrderNewController>().showItemList == true
                  ? Container(
                      // alignment: Alignment.center,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              context.read<OrderNewController>().scannerreset();
                              qrscannerState.orderscan = true;
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => qrscanner()))
//                 .then((value){
// return context.read<OrderNewController>().scanneddataget(context);
//                 }
//                  )
                                  ;
                            });
                          },
                          icon: Icon(
                            Icons.qr_code_scanner_outlined,
                            color: theme.primaryColor,
                            size: 30,
                          )),
                    )
                  : Container()
            ],
          ),
          context.read<OrderNewController>().showItemList == true
              ? Expanded(
                  child: ListView.builder(
                    itemCount: context
                        .watch<OrderNewController>()
                        .getAllProductDetails
                        .length,
                    itemBuilder: (BuildContext context, int i) {
                      return InkWell(
                        onTap: () {
                          context.read<OrderNewController>().resetItems(i);
                          context.read<OrderNewController>().isUpdateClicked =
                              false;
                          // context
                          //     .read<OrderNewController>()
                          //     .showBottomSheetInsert(context, i);
                          context
                              .read<OrderNewController>()
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
                                          "Item code: ${context.read<OrderNewController>().getAllProductDetails[i].itemCode}",
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
                                                .read<OrderNewController>()
                                                .config
                                                .alignDate(context
                                                    .read<OrderNewController>()
                                                    .getAllProductDetails[i]
                                                    .refreshedRecordDate!),
                                        // context
                                        //     .watch<OrderNewController>()
                                        //     .config
                                        //     .alignDate(context
                                        //         .read<OrderNewController>()
                                        //         .getAllProductDetails[i]
                                        //         .refreshedRecordDate!),
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
                                          "${context.read<OrderNewController>().getAllProductDetails[i].itemName}",
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
                                            "${context.read<OrderNewController>().config.slpitCurrency22(context.read<OrderNewController>().getAllProductDetails[i].sp.toString())}",
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
                  //            height: Screens.padingHeight(context)*0.6,
                  // width: Screens.width(context),
                  // color:Colors.amber,
                  child: ListView.builder(
                    itemCount:
                        context.read<OrderNewController>().getProduct.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                            "" +
                                                context
                                                    .read<OrderNewController>()
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
                                                .read<OrderNewController>()
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
                                                      .read<
                                                          OrderNewController>()
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
                                                      .read<
                                                          OrderNewController>()
                                                      .config
                                                      .slpitCurrency22(context
                                                          .read<
                                                              OrderNewController>()
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                   context
                                                      .read<
                                                          OrderNewController>()
                                                      .getProduct[index]
                                                      .partcode !=null?        Container(child:Text("Referal Name",style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15.0,
                                              ))
                                          ):Container(),
                                    context
                                                      .read<
                                                          OrderNewController>()
                                                      .getProduct[index]
                                                      .couponcode !=null?Container(child:Text("Couponcode",style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 15.0,
                                              ))
                                          ):Container()
                                        ],
                                      ),
                                      SizedBox(height: 5),
                        (context
                                                      .read<
                                                          OrderNewController>()
                                                      .getProduct[index]
                                                      .partname !=null &&        context
                                                      .read<
                                                          OrderNewController>()
                                                      .getProduct[index]
                                                      .partname!.isNotEmpty)|| (context
                                                      .read<
                                                          OrderNewController>()
                                                      .getProduct[index]
                                                      .couponcode != null &&context
                                                      .read<
                                                          OrderNewController>()
                                                      .getProduct[index]
                                                      .couponcode!.isNotEmpty)?      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                        context
                                                      .read<
                                                          OrderNewController>()
                                                      .getProduct[index]
                                                      .partcode !=null?  Container(
                                            child:Text("${context
                                                      .read<
                                                          OrderNewController>()
                                                      .getProduct[index]
                                                      .partname}")
                                          ):Container(),
                                context
                                                      .read<
                                                          OrderNewController>()
                                                      .getProduct[index]
                                                      .couponcode !=null?          Container(
                                            child:Text("${context
                                                      .read<
                                                          OrderNewController>()
                                                      .getProduct[index]
                                                      .couponcode}")
                                          ):Container()

                                      ],):Container(),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 40, right: 40),
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
                                                          .read<
                                                              OrderNewController>()
                                                          .config
                                                          .slpitCurrency22(context
                                                              .read<
                                                                  OrderNewController>()
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
                                                                OrderNewController>()
                                                            .getProduct
                                                            .removeAt(index);
                                                          context
                                                            .read<
                                                                OrderNewController>()
                                                            .  postpaymentdata.clear();
                                                           context
                                                            .read<
                                                                OrderNewController>()
                                                            .  deletepaymode2();
                                                        if (context
                                                            .read<
                                                                OrderNewController>()
                                                            .productDetails
                                                            .isEmpty) {
                                                          context
                                                              .read<
                                                                  OrderNewController>()
                                                              .changeVisible();
                                                        }

                                                        for (int i = 0;
                                                            i <
                                                                context
                                                                    .read<
                                                                        OrderNewController>()
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
                                                                  OrderNewController>()
                                                              .mycontroller[10]
                                                              .text =
                                                          context
                                                              .read<
                                                                  OrderNewController>()
                                                              .getProduct[index]
                                                              .Price!
                                                              .toStringAsFixed(
                                                                  2);
                                                      context
                                                              .read<
                                                                  OrderNewController>()
                                                              .mycontroller[11]
                                                              .text =
                                                          context
                                                              .read<
                                                                  OrderNewController>()
                                                              .getProduct[index]
                                                              .Quantity!
                                                              .toStringAsFixed(
                                                                  2);
                                                      context
                                                              .read<
                                                                  OrderNewController>()
                                                              .mycontroller[11]
                                                              .text =
                                                          context
                                                              .read<
                                                                  OrderNewController>()
                                                              .getProduct[index]
                                                              .Quantity!
                                                              .toStringAsFixed(
                                                                  0);
                                                      context
                                                              .read<
                                                                  OrderNewController>()
                                                              .total =
                                                          context
                                                              .read<
                                                                  OrderNewController>()
                                                              .getProduct[index]
                                                              .LineTotal!;
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .isUpdateClicked = true;

                                                      context
                                                          .read<
                                                              OrderNewController>()
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
                                      // SizedBox(height: 10),
                                      // Padding(
                                      //   padding: EdgeInsets.only(
                                      //       left: 40, right: 40),
                                      //   child: Divider(
                                      //     color: Colors.grey,
                                      //   ),
                                      // ),
                                      // Column(
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.start,
                                      //   children: [
                                      //     // Text("Complementary items:",
                                      //     //     style: TextStyle(
                                      //     //       color: Colors.grey,
                                      //     //       fontSize: 15.0,
                                      //     //     )),
                                      //     // SizedBox(height: 10),
                                      //     Container(
                                      //         child: context
                                      //             .read<OrderNewController>()
                                      //             .splitcomplement(context
                                      //                 .read<
                                      //                     OrderNewController>()
                                      //                 .getProduct[index]
                                      //                 .complementary
                                      //                 .toString())),
                                      //   ],
                                      // )
                                    ]),
                              )),
                        ],
                      );
                    },
                  ),
                ),

          //
          context.read<OrderNewController>().showItemList == true
              ? Container()
              : Container(
                  //  color:Colors.amber,
                  width: Screens.width(context),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            // color:Colors.amber,

                            width: Screens.width(context) * 0.45,
                            alignment: Alignment.centerRight,
                            child: Text("Total Amount :",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                )),
                          ),
                          //  Text("",style: TextStyle(
                          //                    color: Colors.black,
                          //                    fontSize: 15.0,
                          //                  )),
                          Container(
                            // color:Colors.amber,
                            alignment: Alignment.centerRight,
                            width: Screens.width(context) * 0.32,
                            child: Text(
                                "${context.read<OrderNewController>().getTotalOrderAmount()}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            // color:Colors.red,

                            width: Screens.width(context) * 0.45,
                            alignment: Alignment.centerRight,
                            child: Text("Tax Amount  :",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                )),
                          ),
                          //  Text("",style: TextStyle(
                          //                    color: Colors.black,
                          //                    fontSize: 15.0,
                          //                  )),
                          Container(
                            alignment: Alignment.centerRight,
                            width: Screens.width(context) * 0.32,
                            child: Text(
                                "${context.read<OrderNewController>().getTotalTaxAmount()}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            // color:Colors.amber,

                            width: Screens.width(context) * 0.45,
                            alignment: Alignment.centerRight,
                            child: Text("Gross Total :",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                )),
                          ),
                          //  Text("",style: TextStyle(
                          //                    color: Colors.black,
                          //                    fontSize: 15.0,
                          //                  )),
                          Container(
                            alignment: Alignment.centerRight,
                            width: Screens.width(context) * 0.32,
                            child: Text(
                                "${context.read<OrderNewController>().getTotalGrossAmount()}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                )),
                          ),
                        ],
                      ),
                    ],
                  )),
          SizedBox(
            height: Screens.padingHeight(context) * 0.002,
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
                          .read<OrderNewController>()
                          .pageController
                          .animateToPage(
                              --context.read<OrderNewController>().pageChanged,
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

                      context.read<OrderNewController>().seconPageBtnClicked();
                      log("oldcutomer: " +
                          context
                              .read<OrderNewController>()
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
    // return ChangeNotifierProvider<OrderNewController>(
    //       create: (context) => OrderNewController(),
    //       builder: (context, child) {
    //         return Consumer<OrderNewController>(
    //           builder: (BuildContext context, provi, Widget? child) {
    return InkWell(
      onTap: () {
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) {
          focus.unfocus();
        }
      },
      child: (context
                  .read<OrderNewController>()
                  .getexceptionOnApiCall
                  .isEmpty &&
              context.read<OrderNewController>().getcustomerapicLoading == true)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (context
                      .read<OrderNewController>()
                      .getexceptionOnApiCall
                      .isNotEmpty &&
                  context.read<OrderNewController>().getcustomerapicLoading ==
                      false)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context
                            .read<OrderNewController>()
                            .getexceptionOnApiCall,
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
                    child: Form(
                      key: context.read<OrderNewController>().formkey[0],
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
                                        .read<OrderNewController>()
                                        .mycontroller[0],
                                    focusNode: context
                                        .read<OrderNewController>()
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
                                    onEditingComplete: () {
                                      if (context
                                              .read<OrderNewController>()
                                              .mycontroller[0]
                                              .text
                                              .length ==
                                          10) {
                                        context
                                            .read<OrderNewController>()
                                            .callApi(context);
                                      }
                                    },
                                    onChanged: (v) {
                                      if (v.length == 10 &&
                                          context
                                                  .read<OrderNewController>()
                                                  .getcustomerapicalled ==
                                              false) {
                                        context
                                            .read<OrderNewController>()
                                            .callApi(context);
                                      } else if (v.length != 10) {
                                        context
                                            .read<OrderNewController>()
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
                                        .read<OrderNewController>()
                                        .mycontroller[16],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Customer";
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      if (context
                                              .read<OrderNewController>()
                                              .mycontroller[18]
                                              .text
                                              .isNotEmpty &&
                                          context
                                              .read<OrderNewController>()
                                              .statecode
                                              .isEmpty) {
                                        context
                                            .read<OrderNewController>()
                                            .ontapvalid(context);
                                      } else if (context
                                              .read<OrderNewController>()
                                              .mycontroller[18]
                                              .text
                                              .isNotEmpty &&
                                          context
                                              .read<OrderNewController>()
                                              .statecode
                                              .isNotEmpty) {
                                        setState(() {
                                          context
                                              .read<OrderNewController>()
                                              .statebool = false;
                                        });
                                      } else if (context
                                              .read<OrderNewController>()
                                              .mycontroller[24]
                                              .text
                                              .isNotEmpty &&
                                          context
                                              .read<OrderNewController>()
                                              .statecode2
                                              .isEmpty) {
                                        context
                                            .read<OrderNewController>()
                                            .ontapvalid2(context);
                                      } else if (context
                                              .read<OrderNewController>()
                                              .mycontroller[24]
                                              .text
                                              .isNotEmpty &&
                                          context
                                              .read<OrderNewController>()
                                              .statecode2
                                              .isNotEmpty) {
                                        setState(() {
                                          context
                                              .read<OrderNewController>()
                                              .statebool2 = false;
                                        });
                                      }
                                    },
                                    onChanged: (v) {
                                      // setState(() {
                                      //   context
                                      //       .read<OrderNewController>()
                                      //       .filterListcustomer(v);
                                      //   if (v.isEmpty) {
                                      //     context
                                      //         .read<OrderNewController>()
                                      //         .customerbool = false;
                                      //   } else {
                                      //     context
                                      //         .read<OrderNewController>()
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
                                      .read<OrderNewController>()
                                      .customerbool,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      context
                                              .read<OrderNewController>()
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
                                                          OrderNewController>()
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
                                                                  OrderNewController>()
                                                              .customerbool = false;
                                                          context
                                                              .read<
                                                                  OrderNewController>()
                                                              .getExiCustomerData(
                                                                  context
                                                                      .read<
                                                                          OrderNewController>()
                                                                      .filterCustomerList[
                                                                          i]
                                                                      .cardname
                                                                      .toString(),
                                                                  context
                                                                      .read<
                                                                          OrderNewController>()
                                                                      .filterCustomerList[
                                                                          i]
                                                                      .cardcode
                                                                      .toString());
                                                          context
                                                                  .read<
                                                                      OrderNewController>()
                                                                  .mycontroller[16]
                                                                  .text =
                                                              context
                                                                  .read<
                                                                      OrderNewController>()
                                                                  .filterCustomerList[
                                                                      i]
                                                                  .cardname
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
                                                            width:
                                                                Screens.width(
                                                                    context),
                                                            child: Text(
                                                              "${context.watch<OrderNewController>().filterCustomerList[i].cardname}",
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
                                        .read<OrderNewController>()
                                        .mycontroller[1],
                                    onTap: () {
                                      if (context
                                              .read<OrderNewController>()
                                              .mycontroller[18]
                                              .text
                                              .isNotEmpty &&
                                          context
                                              .read<OrderNewController>()
                                              .statecode
                                              .isEmpty) {
                                        context
                                            .read<OrderNewController>()
                                            .ontapvalid(context);
                                      } else if (context
                                              .read<OrderNewController>()
                                              .mycontroller[18]
                                              .text
                                              .isNotEmpty &&
                                          context
                                              .read<OrderNewController>()
                                              .statecode
                                              .isNotEmpty) {
                                        setState(() {
                                          context
                                              .read<OrderNewController>()
                                              .statebool = false;
                                        });
                                      } else if (context
                                              .read<OrderNewController>()
                                              .mycontroller[24]
                                              .text
                                              .isNotEmpty &&
                                          context
                                              .read<OrderNewController>()
                                              .statecode2
                                              .isEmpty) {
                                        context
                                            .read<OrderNewController>()
                                            .ontapvalid2(context);
                                      } else if (context
                                              .read<OrderNewController>()
                                              .mycontroller[24]
                                              .text
                                              .isNotEmpty &&
                                          context
                                              .read<OrderNewController>()
                                              .statecode2
                                              .isNotEmpty) {
                                        setState(() {
                                          context
                                              .read<OrderNewController>()
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
                                        .read<OrderNewController>()
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
                                        .read<OrderNewController>()
                                        .mycontroller[7],
                                    onTap: () {
                                      if (context
                                              .read<OrderNewController>()
                                              .mycontroller[18]
                                              .text
                                              .isNotEmpty &&
                                          context
                                              .read<OrderNewController>()
                                              .statecode
                                              .isEmpty) {
                                        context
                                            .read<OrderNewController>()
                                            .ontapvalid(context);
                                      } else if (context
                                              .read<OrderNewController>()
                                              .mycontroller[18]
                                              .text
                                              .isNotEmpty &&
                                          context
                                              .read<OrderNewController>()
                                              .statecode
                                              .isNotEmpty) {
                                        setState(() {
                                          context
                                              .read<OrderNewController>()
                                              .statebool = false;
                                        });
                                      } else if (context
                                              .read<OrderNewController>()
                                              .mycontroller[24]
                                              .text
                                              .isNotEmpty &&
                                          context
                                              .read<OrderNewController>()
                                              .statecode2
                                              .isEmpty) {
                                        context
                                            .read<OrderNewController>()
                                            .ontapvalid2(context);
                                      } else if (context
                                              .read<OrderNewController>()
                                              .mycontroller[24]
                                              .text
                                              .isNotEmpty &&
                                          context
                                              .read<OrderNewController>()
                                              .statecode2
                                              .isNotEmpty) {
                                        setState(() {
                                          context
                                              .read<OrderNewController>()
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
                                        .read<OrderNewController>()
                                        .mycontroller[25],
                                    inputFormatters: [
                                      // FilteringTextInputFormatter.digitsOnly,
                                      new LengthLimitingTextInputFormatter(15),
                                    ],
                                    onTap: () {
                                      if (context
                                              .read<OrderNewController>()
                                              .mycontroller[18]
                                              .text
                                              .isNotEmpty &&
                                          context
                                              .read<OrderNewController>()
                                              .statecode
                                              .isEmpty) {
                                        context
                                            .read<OrderNewController>()
                                            .ontapvalid(context);
                                      } else if (context
                                              .read<OrderNewController>()
                                              .mycontroller[18]
                                              .text
                                              .isNotEmpty &&
                                          context
                                              .read<OrderNewController>()
                                              .statecode
                                              .isNotEmpty) {
                                        setState(() {
                                          context
                                              .read<OrderNewController>()
                                              .statebool = false;
                                        });
                                      } else if (context
                                              .read<OrderNewController>()
                                              .mycontroller[24]
                                              .text
                                              .isNotEmpty &&
                                          context
                                              .read<OrderNewController>()
                                              .statecode2
                                              .isEmpty) {
                                        context
                                            .read<OrderNewController>()
                                            .ontapvalid2(context);
                                      } else if (context
                                              .read<OrderNewController>()
                                              .mycontroller[24]
                                              .text
                                              .isNotEmpty &&
                                          context
                                              .read<OrderNewController>()
                                              .statecode2
                                              .isNotEmpty) {
                                        setState(() {
                                          context
                                              .read<OrderNewController>()
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
//  Container(
//                                       height: Screens.padingHeight(context)*0.1,
//                                        child: DropdownButtonFormField(
//                                          decoration: InputDecoration(
//                                                   // hintText: 'Email',
//                                                   labelText: 'Level of Interest',
//                                                   border: UnderlineInputBorder(),
//                                                   enabledBorder:
//                                                       UnderlineInputBorder(borderSide:
//                                             BorderSide(color: Colors.grey),),
//                                                   focusedBorder:
//                                                       UnderlineInputBorder(borderSide:
//                                             BorderSide(color: Colors.grey),),
//                                                   errorBorder:
//                                                       UnderlineInputBorder(),
//                                                   focusedErrorBorder:
//                                                       UnderlineInputBorder(),
//                                                 ),
//                                                                      // hint: Text(
//                                                                      //   context
//                                                                      //       .watch<NewEnqController>()
//                                                                      //       .gethinttextforOpenLead!,
//                                                                      //   style: theme.textTheme.bodyText2?.copyWith(
//                                                                      //       color: context
//                                                                      //               .watch<NewEnqController>()
//                                                                      //               .gethinttextforOpenLead!
//                                                                      //               .contains(" *")
//                                                                      //           ? Colors.red
//                                                                      //           : Colors.black),
//                                                                      // ),
//                                                                      value: context
//                                                                          .read<OrderNewController>()
//                                                                          .valueChosedStatus,
//                                                                      //dropdownColor:Colors.green,
//                                                                      icon: Icon(Icons.arrow_drop_down),
//                                                                      iconSize: 30,
//                                                                      style: TextStyle(
//                                                                          color: Colors.black, fontSize: 16),
//                                                                      isExpanded: true,
//                                                                      onChanged: (val) {
//                                                                        setState(() {
//                                                                          context
//                                           .read<OrderNewController>()
//                                           .choosedStatus(val.toString());
//                                                                        });
//                                                                      },
//                                                                      items: context
//                                                                          .read<OrderNewController>()
//                                                                          .leveofdata
//                                                                          .map((e) {
//                                                                        return DropdownMenuItem(
//                                         // ignore: unnecessary_brace_in_string_interps
//                                         value: "${e.Code}",
//                                         child: Container(
//                                             // height: Screens.bodyheight(context)*0.1,
//                                             child: Text("${e.Name}")));
//                                                                      }).toList(),
//                                                                    ),
//                                      ),
                                Container(
                                  height: Screens.padingHeight(context) * 0.1,
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      // hintText: 'Email',
                                      labelText: 'Select Order Type',
                                      border: UnderlineInputBorder(),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      errorBorder: UnderlineInputBorder(),
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
                                        .read<OrderNewController>()
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
                                            .read<OrderNewController>()
                                            .choosedType(val.toString());
                                      });
                                    },
                                    items: context
                                        .read<OrderNewController>()
                                        .ordertypedata
                                        .map((e) {
                                      return DropdownMenuItem(
                                          // ignore: unnecessary_brace_in_string_interps
                                          value: "${e.Code}",
                                          child: Text("${e.Name}"));
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
                                                .read<OrderNewController>()
                                                .mycontroller[2],
                                            onTap: () {
                                              if (context
                                                      .read<
                                                          OrderNewController>()
                                                      .mycontroller[18]
                                                      .text
                                                      .isNotEmpty &&
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statecode
                                                      .isEmpty) {
                                                context
                                                    .read<OrderNewController>()
                                                    .ontapvalid(context);
                                              } else if (context
                                                      .read<
                                                          OrderNewController>()
                                                      .mycontroller[18]
                                                      .text
                                                      .isNotEmpty &&
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statecode
                                                      .isNotEmpty) {
                                                setState(() {
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statebool = false;
                                                });
                                              } else if (context
                                                      .read<
                                                          OrderNewController>()
                                                      .mycontroller[24]
                                                      .text
                                                      .isNotEmpty &&
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statecode2
                                                      .isEmpty) {
                                                context
                                                    .read<OrderNewController>()
                                                    .ontapvalid2(context);
                                              } else if (context
                                                      .read<
                                                          OrderNewController>()
                                                      .mycontroller[24]
                                                      .text
                                                      .isNotEmpty &&
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statecode2
                                                      .isNotEmpty) {
                                                setState(() {
                                                  context
                                                      .read<
                                                          OrderNewController>()
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
                                                .read<OrderNewController>()
                                                .mycontroller[3],
                                            onTap: () {
                                              if (context
                                                      .read<
                                                          OrderNewController>()
                                                      .mycontroller[18]
                                                      .text
                                                      .isNotEmpty &&
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statecode
                                                      .isEmpty) {
                                                context
                                                    .read<OrderNewController>()
                                                    .ontapvalid(context);
                                              } else if (context
                                                      .read<
                                                          OrderNewController>()
                                                      .mycontroller[18]
                                                      .text
                                                      .isNotEmpty &&
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statecode
                                                      .isNotEmpty) {
                                                setState(() {
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statebool = false;
                                                });
                                              } else if (context
                                                      .read<
                                                          OrderNewController>()
                                                      .mycontroller[24]
                                                      .text
                                                      .isNotEmpty &&
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statecode2
                                                      .isEmpty) {
                                                context
                                                    .read<OrderNewController>()
                                                    .ontapvalid2(context);
                                              } else if (context
                                                      .read<
                                                          OrderNewController>()
                                                      .mycontroller[24]
                                                      .text
                                                      .isNotEmpty &&
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statecode2
                                                      .isNotEmpty) {
                                                setState(() {
                                                  context
                                                      .read<
                                                          OrderNewController>()
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
                                                          OrderNewController>()
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
                                                                OrderNewController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                OrderNewController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                OrderNewController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                OrderNewController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
                                                  onChanged: (v) {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .filterListArea(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .areabool = false;
                                                      } else {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .areabool = true;
                                                      }
                                                    });
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
                                                          OrderNewController>()
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
                                                                OrderNewController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                OrderNewController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                OrderNewController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                OrderNewController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
                                                  onChanged: (v) {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .filterListCity(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .citybool = false;
                                                      } else {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .citybool = true;
                                                      }
                                                    });
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
                                        //       .read<OrderNewController>()
                                        //       .areabool,
                                        //   child: Column(
                                        //     children: [
                                        //       SizedBox(
                                        //         height:
                                        //             Screens.bodyheight(context) * 0.01,
                                        //       ),
                                        //       context
                                        //               .read<OrderNewController>()
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
                                        //                           OrderNewController>()
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
                                        //                                   OrderNewController>()
                                        //                               .areabool = false;
                                        //                           context
                                        //                                   .read<
                                        //                                       OrderNewController>()
                                        //                                   .mycontroller[17]
                                        //                                   .text =
                                        //                               context
                                        //                                   .read<
                                        //                                       OrderNewController>()
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
                                        //                               "${context.watch<OrderNewController>().filterCustomerList[i].area}",
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
                                        //       .read<OrderNewController>()
                                        //       .citybool,
                                        //   child: Column(
                                        //     children: [
                                        //       SizedBox(
                                        //         height:
                                        //             Screens.bodyheight(context) * 0.01,
                                        //       ),
                                        //       context
                                        //               .read<OrderNewController>()
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
                                        //                           OrderNewController>()
                                        //                       .filterCustomerList
                                        //                       .length,
                                        //                   itemBuilder:
                                        //                       (BuildContext context,
                                        //                           int i) {
                                        //                     return InkWell(
                                        //                       onTap: () {
                                        //                         setState(() {
                                        //                           context.read<
                                        //                               OrderNewController>();

                                        //                           context
                                        //                               .read<
                                        //                                   OrderNewController>()
                                        //                               .citybool = false;
                                        //                           context
                                        //                                   .read<
                                        //                                       OrderNewController>()
                                        //                                   .mycontroller[5]
                                        //                                   .text =
                                        //                               context
                                        //                                   .read<
                                        //                                       OrderNewController>()
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
                                        //                               "${context.watch<OrderNewController>().filterCustomerList[i].city}",
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
                                                          OrderNewController>()
                                                      .mycontroller[4],
                                                  onTap: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              OrderNewController>()
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
                                                    setState(() {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .filterListPincode(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .pincodebool = false;
                                                      } else {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .pincodebool = true;
                                                      }
                                                    });
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
                                                          OrderNewController>()
                                                      .mycontroller[18],
                                                  focusNode: context
                                                      .read<
                                                          OrderNewController>()
                                                      .focusNode1,
                                                  autovalidateMode:
                                                      AutovalidateMode.always,
                                                  onChanged: (v) {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .isText1Correct = false;
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .filterListState2(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                OrderNewController>()
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
                                                                OrderNewController>()
                                                            .methidstate(
                                                                context
                                                                    .read<
                                                                        OrderNewController>()
                                                                    .mycontroller[
                                                                        18]
                                                                    .text,
                                                                context);
                                                        context
                                                            .read<
                                                                OrderNewController>()
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
                                                                OrderNewController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .methidstate(
                                                              context
                                                                  .read<
                                                                      OrderNewController>()
                                                                  .mycontroller[
                                                                      18]
                                                                  .text,
                                                              context);
                                                      FocusScope.of(context)
                                                          .requestFocus(context
                                                              .read<
                                                                  OrderNewController>()
                                                              .focusNode1);
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .statebool = false;
                                                      return "Enter Correct State";
                                                    }
                                                    return null;
                                                  },
                                                  onEditingComplete: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .statebool = false;
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .focusNode1
                                                          .unfocus();
                                                      // context
                                                      //   .read<NewEnqController>()
                                                      //   .  methodfortest();
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .methidstate(
                                                              context
                                                                  .read<
                                                                      OrderNewController>()
                                                                  .mycontroller[
                                                                      18]
                                                                  .text,
                                                              context);

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
                                              .read<OrderNewController>()
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
                                                          OrderNewController>()
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
                                                                  OrderNewController>()
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
                                                                          OrderNewController>()
                                                                      .pincodebool = false;
                                                                  context.read<
                                                                      OrderNewController>();

                                                                  context
                                                                          .read<
                                                                              OrderNewController>()
                                                                          .mycontroller[
                                                                              4]
                                                                          .text =
                                                                      context
                                                                          .read<
                                                                              OrderNewController>()
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
                                                                      "${context.watch<OrderNewController>().filterCustomerList[i].zipcode}",
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
                                                    .read<OrderNewController>()
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
                                                    .read<OrderNewController>()
                                                    .value3,
                                                onChanged: (value) {
                                                  setState(() {
                                                    context
                                                        .read<
                                                            OrderNewController>()
                                                        .converttoShipping(
                                                            value!);
                                                    context
                                                        .read<
                                                            OrderNewController>()
                                                        .value3 = value;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextFormField(
                                            controller: context
                                                .read<OrderNewController>()
                                                .mycontroller[19],
                                            onTap: () {
                                              if (context
                                                      .read<
                                                          OrderNewController>()
                                                      .mycontroller[18]
                                                      .text
                                                      .isNotEmpty &&
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statecode
                                                      .isEmpty) {
                                                context
                                                    .read<OrderNewController>()
                                                    .ontapvalid(context);
                                              } else if (context
                                                      .read<
                                                          OrderNewController>()
                                                      .mycontroller[18]
                                                      .text
                                                      .isNotEmpty &&
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statecode
                                                      .isNotEmpty) {
                                                setState(() {
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statebool = false;
                                                });
                                              } else if (context
                                                      .read<
                                                          OrderNewController>()
                                                      .mycontroller[24]
                                                      .text
                                                      .isNotEmpty &&
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statecode2
                                                      .isEmpty) {
                                                context
                                                    .read<OrderNewController>()
                                                    .ontapvalid2(context);
                                              } else if (context
                                                      .read<
                                                          OrderNewController>()
                                                      .mycontroller[24]
                                                      .text
                                                      .isNotEmpty &&
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statecode2
                                                      .isNotEmpty) {
                                                setState(() {
                                                  context
                                                      .read<
                                                          OrderNewController>()
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
                                                .read<OrderNewController>()
                                                .mycontroller[20],
                                            onTap: () {
                                              if (context
                                                      .read<
                                                          OrderNewController>()
                                                      .mycontroller[18]
                                                      .text
                                                      .isNotEmpty &&
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statecode
                                                      .isEmpty) {
                                                context
                                                    .read<OrderNewController>()
                                                    .ontapvalid(context);
                                              } else if (context
                                                      .read<
                                                          OrderNewController>()
                                                      .mycontroller[18]
                                                      .text
                                                      .isNotEmpty &&
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statecode
                                                      .isNotEmpty) {
                                                setState(() {
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statebool = false;
                                                });
                                              } else if (context
                                                      .read<
                                                          OrderNewController>()
                                                      .mycontroller[24]
                                                      .text
                                                      .isNotEmpty &&
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statecode2
                                                      .isEmpty) {
                                                context
                                                    .read<OrderNewController>()
                                                    .ontapvalid2(context);
                                              } else if (context
                                                      .read<
                                                          OrderNewController>()
                                                      .mycontroller[24]
                                                      .text
                                                      .isNotEmpty &&
                                                  context
                                                      .read<
                                                          OrderNewController>()
                                                      .statecode2
                                                      .isNotEmpty) {
                                                setState(() {
                                                  context
                                                      .read<
                                                          OrderNewController>()
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
                                                          OrderNewController>()
                                                      .mycontroller[21],
                                                  onTap: () {
                                                    if (context
                                                            .read<
                                                                OrderNewController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                OrderNewController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                OrderNewController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                OrderNewController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                OrderNewController>()
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
                                                  //             OrderNewController>()
                                                  //         .clearbool();
                                                  //   });
                                                  // },
                                                  onChanged: (v) {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .filterListArea(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .areabool = false;
                                                      } else {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .areabool = true;
                                                      }
                                                    });
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
                                                          OrderNewController>()
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
                                                                OrderNewController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                OrderNewController>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                OrderNewController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                OrderNewController>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
                                                  onChanged: (v) {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .filterListCity(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .citybool = false;
                                                      } else {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .citybool = true;
                                                      }
                                                    });
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
                                              .read<OrderNewController>()
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
                                                          OrderNewController>()
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
                                                                  OrderNewController>()
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
                                                                          OrderNewController>()
                                                                      .areabool = false;
                                                                  context
                                                                          .read<
                                                                              OrderNewController>()
                                                                          .mycontroller[
                                                                              21]
                                                                          .text =
                                                                      context
                                                                          .read<
                                                                              OrderNewController>()
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
                                                                      "${context.watch<OrderNewController>().filterCustomerList[i].area}",
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
                                              .read<OrderNewController>()
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
                                                          OrderNewController>()
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
                                                                  OrderNewController>()
                                                              .filterCustomerList
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext context,
                                                                  int i) {
                                                            return InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  context.read<
                                                                      OrderNewController>();

                                                                  context
                                                                      .read<
                                                                          OrderNewController>()
                                                                      .citybool = false;
                                                                  context
                                                                          .read<
                                                                              OrderNewController>()
                                                                          .mycontroller[
                                                                              22]
                                                                          .text =
                                                                      context
                                                                          .read<
                                                                              OrderNewController>()
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
                                                                      "${context.watch<OrderNewController>().filterCustomerList[i].city}",
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
                                                          OrderNewController>()
                                                      .mycontroller[23],
                                                  onTap: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              OrderNewController>()
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
                                                    setState(() {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .filterListPincode(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .pincodebool = false;
                                                      } else {
                                                        context
                                                            .read<
                                                                OrderNewController>()
                                                            .pincodebool = true;
                                                      }
                                                    });
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
                                                          OrderNewController>()
                                                      .mycontroller[24],
                                                  focusNode: context
                                                      .read<
                                                          OrderNewController>()
                                                      .focusNode3,
                                                  autovalidateMode:
                                                      AutovalidateMode.always,
                                                  onChanged: (v) {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .isText1Correct2 = false;
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .filterListState2(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                OrderNewController>()
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
                                                                OrderNewController>()
                                                            .methidstate2(context
                                                                .read<
                                                                    OrderNewController>()
                                                                .mycontroller[
                                                                    24]
                                                                .text);
                                                        context
                                                            .read<
                                                                OrderNewController>()
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
                                                                OrderNewController>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .methidstate2(context
                                                              .read<
                                                                  OrderNewController>()
                                                              .mycontroller[24]
                                                              .text);
                                                      FocusScope.of(context)
                                                          .requestFocus(context
                                                              .read<
                                                                  OrderNewController>()
                                                              .focusNode3);
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .statebool2 = false;
                                                      return "Enter Correct State";
                                                    }
                                                    return null;
                                                  },
                                                  onEditingComplete: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .statebool2 = false;
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .focusNode3
                                                          .unfocus();
                                                      // context
                                                      //   .read<NewEnqController>()
                                                      //   .  methodfortest();
                                                      context
                                                          .read<
                                                              OrderNewController>()
                                                          .methidstate2(context
                                                              .read<
                                                                  OrderNewController>()
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
                                                    .read<OrderNewController>()
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
                                              .read<OrderNewController>()
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
                                                          OrderNewController>()
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
                                                                  OrderNewController>()
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
                                                              "${context.watch<OrderNewController>().filterstateData[i].stateName}",
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
                                    .read<OrderNewController>()
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
                                              .read<OrderNewController>()
                                              .filterstateData
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  context
                                                      .read<
                                                          OrderNewController>()
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
                                                      "${context.watch<OrderNewController>().filterstateData[i].stateName}",
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
                          //         .read<OrderNewController>()
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
                          //         .read<OrderNewController>()
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
                          //                   .read<OrderNewController>()
                          //                   .validateGender ==
                          //               true
                          //           ? "Gender *"
                          //           : "Gender",
                          //       style: context
                          //                   .read<OrderNewController>()
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
                          //                 .read<OrderNewController>()
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
                          //                                 OrderNewController>()
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
                          //                                       OrderNewController>()
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
                          //                 .read<OrderNewController>()
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
                          //                                 OrderNewController>()
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
                          //                                       OrderNewController>()
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
                          //                 .read<OrderNewController>()
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
                          //                                 OrderNewController>()
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
                          //                                       OrderNewController>()
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
                          //       context.read<OrderNewController>().validateAge ==
                          //               true
                          //           ? "Age Group *"
                          //           : "Age Group",
                          //       style: context
                          //                   .read<OrderNewController>()
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
                          //                 .read<OrderNewController>()
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
                          //                                 OrderNewController>()
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
                          //                                       OrderNewController>()
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
                          //                 .read<OrderNewController>()
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
                          //                                 OrderNewController>()
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
                          //                                       OrderNewController>()
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
                          //                 .read<OrderNewController>()
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
                          //                                 OrderNewController>()
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
                          //                                       OrderNewController>()
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
                          //             .read<OrderNewController>()
                          //             .selectage("50>");
                          //       },
                          //       child: Container(
                          //         width: Screens.width(context) * 0.29,
                          //         height: Screens.bodyheight(context) * 0.06,
                          //         //  padding: EdgeInsets.all(10),
                          //         decoration: BoxDecoration(
                          //             color: context
                          //                         .watch<OrderNewController>()
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
                          //                                   OrderNewController>()
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
                          //                   .read<OrderNewController>()
                          //                   .validateComas ==
                          //               true
                          //           ? "Came as *"
                          //           : "Came as",
                          //       style: context
                          //                   .read<OrderNewController>()
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
                          //                 .read<OrderNewController>()
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
                          //                                 OrderNewController>()
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
                          //                                       OrderNewController>()
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
                          //                 .read<OrderNewController>()
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
                          //                                 OrderNewController>()
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
                          //                                       OrderNewController>()
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
                          //                 .read<OrderNewController>()
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
                          //                                 OrderNewController>()
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
                          //                                       OrderNewController>()
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
                          //             .read<OrderNewController>()
                          //             .selectComeas("Corporate");
                          //       },
                          //       child: Container(
                          //         width: Screens.width(context) * 0.29,
                          //         height: Screens.bodyheight(context) * 0.06,
                          //         //  padding: EdgeInsets.all(10),
                          //         decoration: BoxDecoration(
                          //             color: context
                          //                         .watch<OrderNewController>()
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
                          //                                   OrderNewController>()
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
                                        .read<OrderNewController>()
                                        .firstPageNextBtn(context);
                                    log("oldcutomer: " +
                                        context
                                            .read<OrderNewController>()
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

  // List<Widget> listContainersRefferes(
  //   ThemeData theme,
  // ) {
  //   return List.generate(
  //     context.read<OrderNewController>().getenqReffList.length,
  //     (index) => InkWell(
  //       onTap: () {
  //         // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
  //         // .getenqReffList[index].Name.toString();
  //         context.read<OrderNewController>().selectEnqReffers(
  //             context
  //                 .read<OrderNewController>()
  //                 .getenqReffList[index]
  //                 .Name
  //                 .toString(),
  //             context.read<OrderNewController>().getenqReffList[index].Name!,
  //             context.read<OrderNewController>().getenqReffList[index].Code!);
  //       },
  //       child: Container(
  //         width: Screens.width(context) * 0.4,
  //         height: Screens.bodyheight(context) * 0.06,
  //         //  padding: EdgeInsets.all(10),
  //         decoration: BoxDecoration(
  //             color: context
  //                         .read<OrderNewController>()
  //                         .getisSelectedenquiryReffers ==
  //                     context
  //                         .read<OrderNewController>()
  //                         .getenqReffList[index]
  //                         .Name
  //                         .toString()
  //                 ? Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
  //                 : Colors.white,
  //             border: Border.all(color: theme.primaryColor, width: 1),
  //             borderRadius: BorderRadius.circular(10)),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //                 context
  //                     .read<OrderNewController>()
  //                     .getenqReffList[index]
  //                     .Name
  //                     .toString(),
  //                 maxLines: 8,
  //                 overflow: TextOverflow.ellipsis,
  //                 style: theme.textTheme.bodyText1?.copyWith(
  //                   color: context
  //                               .read<OrderNewController>()
  //                               .getisSelectedenquiryReffers ==
  //                           context
  //                               .read<OrderNewController>()
  //                               .getenqReffList[index]
  //                               .Name
  //                               .toString()
  //                       ? theme.primaryColor //,Colors.white
  //                       : theme.primaryColor,
  //                 ))
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  List<Widget> listContainersPaymentTerms(
    ThemeData theme,
  ) {
    return List.generate(
      context.read<OrderNewController>().paymode.length,
      (index) => InkWell(
        onTap: () {
           context.read<OrderNewController>().selectpaymentTerms(
              context
                  .read<OrderNewController>()
                  .paymode[index]
                  .ModeName
                  .toString(),
              context.read<OrderNewController>().paymode[index].ModeName!,
              context.read<OrderNewController>().paymode[index].Code!,
              context,
               context.read<OrderNewController>().paymode[index],
               index
              );
       
          
        },
        child: Stack(
          children: [
            Container(
              width: Screens.width(context) * 0.4,
              height: Screens.bodyheight(context) * 0.06,
              //  padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: 
                  // context
                  //             .read<OrderNewController>()
                  //             .isSelectedpaymentTermsCode ==
                          context
                              .read<OrderNewController>()
                              .paymode[index]
                              .isselected ==true
                      ? Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                      : Colors.white,
                  border: Border.all(color: theme.primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
              child: context.read<OrderNewController>().paymode[index].amount !=null && context.read<OrderNewController>().paymode[index].amount !=""? 
              Text("Rs.${context.read<OrderNewController>().config.slpitCurrency22(context.read<OrderNewController>().paymode[index].amount.toString())}",style: theme.textTheme.bodyText1?.copyWith(
                       color: context
                             .read<OrderNewController>()
                             .paymode[index]
                             .isselected ==true
                           ? theme.primaryColor //,Colors.white
                           : theme.primaryColor,
                     ) ,):
                 Text("${context
                         .read<OrderNewController>()
                         .paymode[index]
                         .ModeName
                         .toString()}",
                          maxLines: 8,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
                         style: theme.textTheme.bodyText1?.copyWith(
                       color: context
                             .read<OrderNewController>()
                             .paymode[index]
                             .isselected ==true
                           ? theme.primaryColor //,Colors.white
                           : theme.primaryColor,
                     ) ,
                         ),
            ),

         Positioned(
          top: Screens.padingHeight(context)*0.005,
          left:Screens.width(context)*0.01,
          child: context.read<OrderNewController>().paymode[index].amount !=null && context.read<OrderNewController>().paymode[index].amount !=""?Text("${context.read<OrderNewController>().paymode[index].ModeName}",style:theme.textTheme.bodyText1?.copyWith(color:theme.primaryColor,fontSize: 10)):Text("")
          )
      //  Positioned(
      //     top: Screens.padingHeight(context)*0.005,
      //     left:Screens.width(context)*0.01,
      //     child: context.read<OrderNewController>().paymode[index].amount !=null && context.read<OrderNewController>().paymode[index].amount !=""?Text("Rs.${context.read<OrderNewController>().paymode[index].amount}",style:theme.textTheme.bodyText1?.copyWith(color:theme.primaryColor,fontSize: 10)):Text("")
      //     )
          ],
        ),
      ),
    );
  }

  List<Widget> listContainersCustomertags(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<OrderNewController>().customerTagTypeData.length,
      (index) => InkWell(
        onTap: () {
          // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
          // .getenqReffList[index].Name.toString();
          context.read<OrderNewController>().selectCustomerTag(
              context
                  .read<OrderNewController>()
                  .customerTagTypeData[index]
                  .Name
                  .toString(),
              context
                  .read<OrderNewController>()
                  .customerTagTypeData[index]
                  .Name!,
              context
                  .read<OrderNewController>()
                  .customerTagTypeData[index]
                  .Code!);
        },
        child: Container(
          width: Screens.width(context) * 0.2,
          height: Screens.bodyheight(context) * 0.05,
          alignment: Alignment.center,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context.watch<OrderNewController>().isSelectedCusTagcode ==
                      context
                          .read<OrderNewController>()
                          .customerTagTypeData[index]
                          .Code
                          .toString()
                  ? Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
              context
                  .watch<OrderNewController>()
                  .customerTagTypeData[index]
                  .Name
                  .toString(),
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10,
                color:
                    context.watch<OrderNewController>().isSelectedCusTagcode ==
                            context
                                .read<OrderNewController>()
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
