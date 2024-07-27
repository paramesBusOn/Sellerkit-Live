import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/CollectionController/NewCollectionEntryCotroller.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/paymodemodel.dart';

class paytermdialog extends StatefulWidget {
  paytermdialog({super.key, required this.paymode});
  final PaymodeModalData? paymode;
  @override
  State<paytermdialog> createState() => _paytermdialogState();
}

class _paytermdialogState extends State<paytermdialog> {
  final List<String> itemsdata = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      contentPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        width: Screens.width(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.bodyheight(context) * 0.06,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                        // fontSize: 12,
                        ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )), //Radius.circular(6)
                  ),
                  child: Text(
                    "${context.watch<NewCollectionContoller>().PaymentTerms.toString()}",
                  )),
            ),
            Container(
              padding: EdgeInsets.only(
                top: Screens.padingHeight(context) * 0.01,
                bottom: Screens.padingHeight(context) * 0.01,
                left: Screens.width(context) * 0.03,
                right: Screens.width(context) * 0.03,
              ),
              child: Form(
                key: context.read<NewCollectionContoller>().formkey[5],
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    widget.paymode!.Ref1 == false
                        ? Container()
                        : SizedBox(
                            // height: Screens.padingHeight(context) * 0.06,
                            child: TextFormField(
                                controller: context
                                    .read<NewCollectionContoller>()
                                    .mycontroller[43],
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Enter Ref1";
                                //   }
                                //   return null;
                                // },
                                decoration: InputDecoration(
                                  labelText: 'Ref1',
                                  labelStyle: theme.textTheme.bodyText1!
                                      .copyWith(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                )),
                          ),
                    //Ref2
                    widget.paymode!.Ref1 == false
                        ? Container()
                        : SizedBox(
                            height: Screens.padingHeight(context) * 0.01,
                          ),
                    widget.paymode!.Ref2 == false
                        ? Container()
                        : SizedBox(
                            // height: Screens.padingHeight(context) * 0.06,
                            child: TextFormField(
                                controller: context
                                    .read<NewCollectionContoller>()
                                    .mycontroller[44],
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Enter Ref2";
                                //   }
                                //   return null;
                                // },
                                decoration: InputDecoration(
                                  labelText: 'Ref2',
                                  labelStyle: theme.textTheme.bodyText1!
                                      .copyWith(color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                )),
                          ),
                    //
                    widget.paymode!.Ref2 == false
                        ? Container()
                        : SizedBox(
                            height: Screens.padingHeight(context) * 0.01,
                          ),
                    widget.paymode!.ListVal == false
                        ? Container()
                        : Container(
                            width: Screens.width(context),
                            height: Screens.padingHeight(context) * 0.06,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all()),
                            child: DropdownButtonFormField(
                                value: context
                                    .read<NewCollectionContoller>()
                                    .selecteditem,
                                isExpanded: true,
                                hint: Text("List Type"),
                                 validator: (value) {
                                  if (value==null) {
                                    return "*Select List Type";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  contentPadding:  EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8))
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8))
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8))
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8))
                                  ),
                                  disabledBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8))
                                  ),
                                ),
                                items: context
                                    .read<NewCollectionContoller>()
                                    .valueDroplist!
                                    .map((items) {
                                  return DropdownMenuItem(
                                    value: items.ListName,
                                    child: Text(items.ListName!),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    context
                                        .read<NewCollectionContoller>()
                                        .onselectdrop(val.toString());
                                  });
                                }),
                          ),
                    //date
                    widget.paymode!.ListVal == false
                        ? Container()
                        : SizedBox(
                            height: Screens.padingHeight(context) * 0.01,
                          ),
                    widget.paymode!.TransDate == false
                        ? Container()
                        : TextFormField(
                            controller: context
                                .read<NewCollectionContoller>()
                                .mycontroller[45],
                            onTap: () {
                              context
                                  .read<NewCollectionContoller>()
                                  .showchequeDate(context);
                            },
                            // validator: context
                            //             .watch<NewCollectionContoller>()
                            //             .PaymentTerms
                            //             .toString()
                            //             .toLowerCase() ==
                            //         'cheque'
                            //     ? (value) {
                            //         if (value!.isEmpty) {
                            //           return "Enter Date Ref";
                            //         }
                            //         return null;
                            //       }
                            //     : (value) {},
                            readOnly: true,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.calendar_month,
                                color: theme.primaryColor,
                              ),
                              labelText: 'Date Ref',
                              labelStyle: theme.textTheme.bodyText1!
                                  .copyWith(color: Colors.grey),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            )),
                    //Attach
                    widget.paymode!.TransDate == false
                        ? Container()
                        : SizedBox(
                            height: Screens.padingHeight(context) * 0.01,
                          ),
                    widget.paymode!.Attach == false
                        ? Container()
                        : GetAttachment(theme, context),
                    //Amount
                    widget.paymode!.Attach == false
                        ? Container()
                        : SizedBox(
                            height: Screens.padingHeight(context) * 0.01,
                          ),
                    SizedBox(
                      // height: Screens.padingHeight(context) * 0.06,
                      child: TextFormField(
                          controller: context
                              .read<NewCollectionContoller>()
                              .mycontroller[46],
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*')),
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Amount";
                            } else if (value.isNotEmpty) {
                              double parsedValue = double.parse(value);
                              double payTermTotal = double.parse(context
                                  .read<NewCollectionContoller>()
                                  .paytermtotal!
                                  .toStringAsFixed(2));
                                   double fullpayment2 = double.parse(context
                                  .read<NewCollectionContoller>()
                                  .fullpayment!
                                  .toStringAsFixed(2));
                                  if(context
                                                .read<NewCollectionContoller>()
                                                .payupdate==true){
                                 double fullupdatepay =  context
                                  .read<NewCollectionContoller>()
                                  . getpaymenttot2(context
                                                .read<NewCollectionContoller>()
                                                .payindex!);
                                  if(fullupdatepay <=0.0){
 return "No Payment amount pending";
                                  }
                              if (parsedValue>fullupdatepay   ) {
                                return "Amount Should be less than or equal to ${fullupdatepay.toStringAsFixed(2)}";
                              }
                                  }else{
 if(payTermTotal <=0.0){
 return "No Payment amount pending";
                                  }
                              if (parsedValue>payTermTotal   ) {
                                return "Amount Should be less than or equal to ${context.read<NewCollectionContoller>().paytermtotal!.toStringAsFixed(2)}";
                              }
                                  }
                                 
                             
                              // double.parse(value) > context
                              // .read<NewCollectionContoller>()
                              // .paytermtotal!.toStringAsFixed(2)
                            }
                            return null;
                          },
                          //                     onChanged: (val){
                          //                        if (val.isNotEmpty) {
                          //     context
                          //                         .read<NewCollectionContoller>()
                          //                         . onchangedpayterm(val);
                          //  }

                          //                     },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.copy),
                              color: theme.primaryColor,
                              onPressed: () {
                                setState(() {
                                  context.read<NewCollectionContoller>().oncopy();
                                });
                              },
                            ),
                            labelText: 'Amount',
                            labelStyle: theme.textTheme.bodyText1!
                                .copyWith(color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          )),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.005,
                    ),
// Container(
//   alignment: Alignment.centerLeft,
//   child: Text("*${context
//                               .read<NewCollectionContoller>()
//                               .payamounterror}",style: TextStyle(color: Colors.red,fontSize: 12),),
// ),

                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: Screens.padingHeight(context) * 0.06,
              width: Screens.width(context),
              child: context.watch<NewCollectionContoller>().payupdate == true
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )),
                      ),
                      onPressed:
                          context.watch<NewCollectionContoller>().payloading == true
                              ? () {}
                              : () {
                                  setState(() {
                                    context
                                        .read<NewCollectionContoller>()
                                        .validateupdate(
                                            context
                                                .read<NewCollectionContoller>()
                                                .payindex!,
                                            widget.paymode!,
                                            context);
                                  });
                                },
                      child: context.watch<NewCollectionContoller>().payloading ==
                              true
                          ? Center(
                              child: SizedBox(
                                  width: Screens.width(context) * 0.08,
                                  height: Screens.bodyheight(context) * 0.05,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                            )
                          : Text(
                              "Update",
                              style: theme.textTheme.bodyText1!
                                  .copyWith(color: Colors.white, fontSize: 18),
                            ))
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )),
                      ),
                      onPressed:
                          context.watch<NewCollectionContoller>().payloading == true
                              ? () {}
                              : () {
                                  setState(() {
                                    context
                                        .read<NewCollectionContoller>()
                                        .validatepayterm(
                                            widget.paymode!, context);
                                  });
                                },
                      child: context.watch<NewCollectionContoller>().payloading ==
                              true
                          ? Center(
                              child: SizedBox(
                                  width: Screens.width(context) * 0.08,
                                  height: Screens.bodyheight(context) * 0.05,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                            )
                          : Text(
                              "Save",
                              style: theme.textTheme.bodyText1!
                                  .copyWith(color: Colors.white, fontSize: 18),
                            )),
            )
          ],
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
            bottom: Screens.padingHeight(context) * 0.01,
            right: Screens.padingHeight(context) * 0.01),
        // height: Screens.padingHeight(context) * 0.14,
        // color: Colors.red,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Attachment',
                  style: theme.textTheme.subtitle1?.copyWith(
                      color:
                          context.read<NewCollectionContoller>().fileValidation2 ==
                                  true
                              ? Colors.red
                              : Colors.black)),
              Row(
                children: [
                  Container(
                      // alignment: Alignment.center,
                      height: Screens.padingHeight(context) * 0.05,
                      width: Screens.width(context) * 0.13,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: context
                                      .read<NewCollectionContoller>()
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
                                        .read<NewCollectionContoller>()
                                        .files2
                                        .length ==
                                    0) {
                                  setState(() {
                                    context
                                        .read<NewCollectionContoller>()
                                        .imagetoBinary2(ImageSource.camera);
                                    context
                                        .read<NewCollectionContoller>()
                                        .fileValidation2 = false;
                                  });
                                } else {
                                  print("obAAAAAject");
                                  context
                                      .read<NewCollectionContoller>()
                                      .showtoastpayattach();
                                }
                              });
                            },
                            icon: Icon(
                              Icons.photo_camera,
                              color: Colors.white,
                              size: 16,
                            )),
                      )),
                  SizedBox(
                    width: Screens.width(context) * 0.02,
                  ),

                  //old
                  Container(
                      // alignment: Alignment.center,
                      height: Screens.padingHeight(context) * 0.05,
                      width: Screens.width(context) * 0.13,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: context
                                      .read<NewCollectionContoller>()
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
                                        .read<NewCollectionContoller>()
                                        .files2
                                        .length ==
                                    0) {
                                  setState(() {
                                    context
                                        .read<NewCollectionContoller>()
                                        .selectattachment2();

                                    context
                                        .read<NewCollectionContoller>()
                                        .fileValidation2 = false;
                                  });
                                } else {
                                  print("obAAAAAject");

                                  context
                                      .read<NewCollectionContoller>()
                                      .showtoastpayattach();
                                }
                              });
                            },
                            icon: Icon(
                              Icons.attach_file,
                              color: Colors.white,
                                 size: 16,
                            )),
                      )),
                ],
              )
            ],
          ),
          context.read<NewCollectionContoller>().files2 == null
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
                  height: context.read<NewCollectionContoller>().files2.length == 0
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
                          context.read<NewCollectionContoller>().files2.length,
                      itemBuilder: (BuildContext context, int i) {
                        if (context
                            .read<NewCollectionContoller>()
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
                                            .watch<NewCollectionContoller>()
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
                                                  .read<NewCollectionContoller>()
                                                  .files2
                                                  .removeAt(i);
                                              context
                                                  .read<NewCollectionContoller>()
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
                            .read<NewCollectionContoller>()
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
                                            .watch<NewCollectionContoller>()
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
                                                  .read<NewCollectionContoller>()
                                                  .files2
                                                  .removeAt(i);
                                              context
                                                  .read<NewCollectionContoller>()
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
