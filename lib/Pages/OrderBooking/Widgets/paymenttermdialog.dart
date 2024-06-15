

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/OrderController/OrderNewController.dart';
import 'package:provider/provider.dart';

class paytermdialog extends StatefulWidget {
  const paytermdialog({super.key});

  @override
  State<paytermdialog> createState() => _paytermdialogState();
}

class _paytermdialogState extends State<paytermdialog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        width: Screens.width(context),
        padding: EdgeInsets.only(
          top: Screens.padingHeight(context)*0.02,
           bottom: Screens.padingHeight(context)*0.01,
           left: Screens.width(context)*0.03,
            right: Screens.width(context)*0.03,
        ),
        child: Form(
          key: context
                                 .read<OrderNewController>().formkey[5],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                context
                                 .watch<OrderNewController>()
                                 . PaymentTerms.toString().toLowerCase() =='neft'? Column(
                               children: [
                                 TextFormField(
                                     controller: context
                                         .read<OrderNewController>()
                                         .mycontroller[42],
                                     validator: context
                                .watch<OrderNewController>()
                                . PaymentTerms.toString().toLowerCase()  =='neft'
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
                             ):
                          context
                               .watch<OrderNewController>()
                               . PaymentTerms.toString().toLowerCase() =='upi'?
                           Column(
                            children: [
                              TextFormField(
                                  controller: context
                                      .read<OrderNewController>()
                                      .mycontroller[43],
                                  validator: context
                               .watch<OrderNewController>()
                               . PaymentTerms.toString().toLowerCase() =='upi'
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
                          ):
                          context
                             .watch<OrderNewController>()
                             . PaymentTerms.toString().toLowerCase() =='card'?
                           Column(
                            children: [
                              TextFormField(
                                  controller: context
                                      .read<OrderNewController>()
                                      .mycontroller[44],
                                  validator: context
                             .watch<OrderNewController>()
                             . PaymentTerms.toString().toLowerCase() =='card'
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
                          ):
                          context
                           .watch<OrderNewController>()
                           . PaymentTerms.toString().toLowerCase() =='cheque'?
                           Column(
                            children: [
                              // TextFormField(
                              //     // controller: context
                              //     //     .read<OrderNewController>()
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
                                      .read<OrderNewController>()
                                      .mycontroller[45],
                                  onTap: () {
                                    context
                                        .read<OrderNewController>()
                                        .showchequeDate(context);
                                  },
                                  validator:  context
                           .watch<OrderNewController>()
                           . PaymentTerms.toString().toLowerCase() =='cheque'
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
                                      .read<OrderNewController>()
                                      .mycontroller[46],
                                  validator:  context
                           .watch<OrderNewController>()
                           . PaymentTerms.toString().toLowerCase() =='cheque'
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
                          ):Container(),
                         
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.01,
                          ),
                          TextFormField(
                              controller: context
                                  .read<OrderNewController>()
                                  .mycontroller[41],
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
                        
                    SizedBox(
                            height: Screens.bodyheight(context) * 0.01,
                          ),  
                          ElevatedButton(onPressed: (){
                            setState(() {
                              context.read<OrderNewController>().validatepayterm(); 
                            });
                           
                          },
                           child: Text("ok"))    
                           
            ],
          ),
        ),
      ),
    );
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
}