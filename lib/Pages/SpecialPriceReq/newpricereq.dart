import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Constant/padings.dart';
import 'package:sellerkit/Controller/specialpricecontroller/newpagecontroller.dart';
import 'package:sellerkit/Widgets/Appbar.dart';
import 'package:sellerkit/Widgets/Navi3.dart';
import 'package:sellerkit/Widgets/qrpage.dart';

class NewpriceReq extends StatefulWidget {
   NewpriceReq({Key? key}) : super(key: key);

  @override
  State<NewpriceReq> createState() => NewpriceReqState();
}

class NewpriceReqState extends State<NewpriceReq> {
  static bool iscomfromLead = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? currentBackPressTime;
  Paddings paddings = Paddings();
  FocusNode focusNode = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
   Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("object");
      Get.offAllNamed(ConstantRoutes.specialpricereq);
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }
  bool _isDisposed = false;
  void initState() {
    super.initState();
    focusNode.addListener(onfocus);
    focusNode2.addListener(onreqprice);
    focusNode3.addListener(onreqpercent);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
      
if (ConstantValues.multistoreuser == 1) {
          context.read<NewpriceController>().restricteddialog(context);
        }else{
          if (iscomfromLead == false) {
            log("ANBU222::");
             context.read<NewpriceController>().init();
          } else if (iscomfromLead == true) {
            log("ANBU::");
            context.read<NewpriceController>().checkComeFromEnq(context);

            iscomfromLead = false;
          }
        }
       
      });
    });
  }
onfocus(){
  if(!_isDisposed){
context.read<NewpriceController>(). itemvisible();
  }
   
   
}
onreqpercent()async{
  if(context.read<NewpriceController>().mycontroller[11].text.isEmpty){
    context.read<NewpriceController>().  mycontroller[9].clear();
    }
  if(context.read<NewpriceController>().mycontroller[3].text.isNotEmpty &&context.read<NewpriceController>().mycontroller[11].text.isNotEmpty){
  
  await context.read<NewpriceController>().percentagecalculation(context.read<NewpriceController>().mycontroller[6].text,context.read<NewpriceController>().mycontroller[11].text,'');
    context.read<NewpriceController>().Approvergetcall();
  }
  
}
onreqprice()async{
  if(context.read<NewpriceController>().mycontroller[7].text.isEmpty){
    context.read<NewpriceController>().  mycontroller[9].clear();
    }
  if(context.read<NewpriceController>().mycontroller[3].text.isNotEmpty &&context.read<NewpriceController>().mycontroller[7].text.isNotEmpty){
  await context.read<NewpriceController>().percentagecalculation(context.read<NewpriceController>().mycontroller[6].text,'',context.read<NewpriceController>().mycontroller[7].text);
   
    context.read<NewpriceController>().Approvergetcall();
  }
  
}

 
 @override
  void dispose() {
    // setState(() {
      focusNode.dispose();
      focusNode2.dispose();
      focusNode3.dispose();
     
    // });
   _isDisposed = true;
    super.dispose();
  }
  @override
  
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        drawer: drawer3(context),
        appBar: appbar("New Special Price", scaffoldKey, theme, context),
        body:context.watch<NewpriceController>().isinitialloading ==true
        ?Center(
          child: CircularProgressIndicator(),
        )
        :
        Container(
          padding: paddings.padding2(context),
          child: Form(
            key: context.read<NewpriceController>().formkey,
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
                                              .read<NewpriceController>()
                                              .focusNode4,
                          controller:
                              context.read<NewpriceController>().mycontroller[0],
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Enter Mobile Number';
                            } else if (val.length > 10 || val.length < 10) {
                              return "Enter a valid Mobile Number";
                            }
                            return null;
                          },
                           onChanged: (v) {
                                            if (v.length == 10 &&
                                                context
                                                        .read<NewpriceController>()
                                                        .getcustomerapicalled ==
                                                    false) {
                                              context
                                                  .read<NewpriceController>()
                                                  .callApi(context);
                                            } else if (v.length != 10) {
                                              context
                                                  .read<NewpriceController>()
                                                  .clearnum();
                                            }
                                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: const InputDecoration(
                              label: Text("Mobile*"),
                              border: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              errorBorder: UnderlineInputBorder(),
                              focusedErrorBorder: UnderlineInputBorder()),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.8,
                              child: TextFormField(
                                controller: context
                                    .read<NewpriceController>()
                                    .mycontroller[1],
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Enter Customer Code';
                                  } else if (val.length > 10 || val.length < 10) {
                                    return "Enter a Customer Code";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                decoration: const InputDecoration(
                                    label: Text("Customer Code*"),
                                    border: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(),
                                    focusedBorder: UnderlineInputBorder(),
                                    errorBorder: UnderlineInputBorder(),
                                    focusedErrorBorder: UnderlineInputBorder()),
                              ),
                            ),
                            Checkbox(
                              value:
                                  context.read<NewpriceController>().iscopymobile,
                              onChanged: (val) {
                                setState(() {
                                  context
                                      .read<NewpriceController>()
                                      .copynumber(val!);
                                });
                              },
                              activeColor: theme.primaryColor,
                            )
                          ],
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        TextFormField(
                          controller:
                              context.read<NewpriceController>().mycontroller[2],
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Enter Customer Name';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              label: Text("Customer Name*"),
                              border: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              errorBorder: UnderlineInputBorder(),
                              focusedErrorBorder: UnderlineInputBorder()),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.8,
                              child: TextFormField(
                                focusNode:focusNode,
                                controller:
                                    context.read<NewpriceController>().mycontroller[3],
                                    onTap: (){
                                      setState(() {
                                            });
                                    
                                    },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Enter Item Code';
                                  }
                                  return null;
                                },
                                onChanged: (val){
                                context.read<NewpriceController>().  filterList(val);
                               
                                   
                                },
                                decoration: const InputDecoration(
                                    label: Text("Item Code*"),
                                    border: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(),
                                    focusedBorder: UnderlineInputBorder(),
                                    errorBorder: UnderlineInputBorder(),
                                    focusedErrorBorder: UnderlineInputBorder()),
                              ),
                            ),
                         
                         Container(
            // alignment: Alignment.center,
            child: IconButton(
              onPressed: (){
                setState(() {
                   context.read<NewpriceController>().     scannerreset();
                   qrscannerState.spreqscan=true;
                Navigator.push(context,MaterialPageRoute(builder: (_) => qrscanner()))
//                 .then((value){
// return context.read<LeadNewController>().scanneddataget(context);
//                 } 
//                  )
                 ;
                });
           
              },
              icon: Icon(Icons.qr_code_scanner_outlined,color: theme.primaryColor,size: 30,)),
          )
                          ],
                        ),
                         context.watch<NewpriceController>().     isitemcode ==false?Container():   SizedBox(
                          height: Screens.bodyheight(context) * 0.005,
                        ),    
                  context.watch<NewpriceController>().     isitemcode ==false?Container():  Container(
                          width: Screens.width(context),
                                  height: Screens.padingHeight(context)*0.3,
                                  color: Colors.white,
                          child: Column(children: [
                        context.watch<NewpriceController>().filterdataprice.isEmpty?
                                  
                                  Center(child: Text("No Data..!!",),):    Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: context.watch<NewpriceController>().filterdataprice.length,
                                itemBuilder: (context,i){
                                  return 
                                   InkWell(
                                    onTap: (){
                                      setState(() {
                                        focusNode.unfocus();
                                         context.read<NewpriceController>().fixingitems(i);
                                      });
                                    },
                                    child: Container(
                                      
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(context.watch<NewpriceController>().filterdataprice[i].itemCode.toString()),
                                          Divider(color: Colors.grey,)
                                        ],
                                      ),
                                                                  
                                    ),
                                  );
                                
                              }),
                            )
                          ],),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        TextFormField(
                          controller:
                              context.read<NewpriceController>().mycontroller[4],
                          // validator: (val) {
                          //   if (val!.isEmpty) {
                          //     return 'Enter Item Code';
                          //   }
                          //   return null;
                          // },
                          readOnly: true,
                          decoration: const InputDecoration(
                              label: Text("Item Name*"),
                              border: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              errorBorder: UnderlineInputBorder(),
                              focusedErrorBorder: UnderlineInputBorder()),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        TextFormField(
                          controller:
                              context.read<NewpriceController>().mycontroller[5],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Quantity";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                          decoration: const InputDecoration(
                              label: Text("Quantity*"),
                              border: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              errorBorder: UnderlineInputBorder(),
                              focusedErrorBorder: UnderlineInputBorder()),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        TextFormField(
                          controller:
                              context.read<NewpriceController>().mycontroller[6],
                          // validator: (val) {
                          //   if (val!.isEmpty) {
                          //     return 'Enter Unit Price';
                          //   }
                          //   return null;
                          // },
                           keyboardType:  TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*')),],
                                readOnly: true,
                          decoration: const InputDecoration(
                              label: Text("SP"),
                              border: UnderlineInputBorder(),
                              enabledBorder: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(),
                              errorBorder: UnderlineInputBorder(),
                              focusedErrorBorder: UnderlineInputBorder()),
                        ),
SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: Screens.width(context)*0.45,
                              child: TextFormField(
                                focusNode: focusNode2,
                                controller:
                                    context.read<NewpriceController>().mycontroller[7],
                                validator:(val) {
                                  if (val!.isEmpty) {
                                    return 'Enter Discount Percentage';
                                  }
                                  return null;
                                },
                              //                           onEditingComplete: (){
                              //  log('onEditingComplete');
                              //  context.read<NewpriceController>().Approvergetcall();
                              //                           },
                                
                              //                           onSaved: (val){
                              //                             log('onSaved');
                              
                              //                           },
                               
                                onTap: (){
                                  context.read<NewpriceController>().checkitemcodeselect();
                                },
                                readOnly:context.watch<NewpriceController>().isselectitem==false?false:true ,
                                 keyboardType:  TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d*')),],
                                decoration:  InputDecoration(
                                    label:Text("Discount Percentage*"),
                                    border: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(),
                                    focusedBorder: UnderlineInputBorder(),
                                    errorBorder: UnderlineInputBorder(),
                                    focusedErrorBorder: UnderlineInputBorder()),
                              ),
                            ),
                             Container(
                              width: Screens.width(context)*0.45,
                              child: TextFormField(
                                focusNode: focusNode3,
                                controller:
                                    context.read<NewpriceController>().mycontroller[11],
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Enter Discount Price';
                                  }
                                  return null;
                                },
                               
                                onTap: (){
                                  context.read<NewpriceController>().checkitemcodeselect();
                                },
                                readOnly:context.watch<NewpriceController>().isselectitem==false?false:true ,
                                 keyboardType:  TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d*')),],
                                decoration:  InputDecoration(
                                    label: Text("Discount Price*"),
                                    border: UnderlineInputBorder(),
                                    enabledBorder: UnderlineInputBorder(),
                                    focusedBorder: UnderlineInputBorder(),
                                    errorBorder: UnderlineInputBorder(),
                                    focusedErrorBorder: UnderlineInputBorder()),
                              ),
                            ),
                          ],
                        ),
//                         SizedBox(
//                           height: Screens.bodyheight(context) * 0.01,
//                         ),
//                        Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: Screens.width(context)*0.02,
//                           vertical: Screens.padingHeight(context)*0.02
//                         ),
//                         decoration: BoxDecoration(
//                            borderRadius: BorderRadius.circular(8),
//                           border: Border.all(
//                             color: theme.primaryColor
                           
                            
//                           )
//                         ),
//                          child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                           Text('Price Slab',style: theme.textTheme.bodyText2!.copyWith(color: Colors.grey[800],fontSize: 15),),
//                           SizedBox(
//                             height: Screens.bodyheight(context) * 0.007,
//                           ),
//                           Container(
//                             width: Screens.width(context),
//                             height: Screens.padingHeight(context)*0.06,
// // color:Colors.amber,
//                             child: ListView.builder(
//                             // physics: NeverScrollableScrollPhysics(),
//                               scrollDirection: Axis.horizontal,
//                               itemCount:  context.watch<NewpriceController>().planof.length,
//                               itemBuilder: (BuildContext context,int i){
//                               return Row(
//                                 children: [
//                                   SizedBox(
//                                           //  width: Screens.width(context)*0.15,
//                                           //  height: Screens.padingHeight(context)*0.06,
//                                            child: ElevatedButton(
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor:context.watch<NewpriceController>().isselectedprice.toString() ==
//                                             context.watch<NewpriceController>().planof[i].name.toString()? Color(0xffB299A5):
//                                             Colors.white
//                                             ),
//                                             onPressed: (){
//                                         context.read<NewpriceController>().   addvalue(context.read<NewpriceController>().planof[i].name);             
//                                            }, child: Text(
//                                             context.watch<NewpriceController>().planof[i].name.toString(),
//                                             style: theme.textTheme.bodyText2!.copyWith(color: 
//                                             context.watch<NewpriceController>().isselectedprice.toString() ==
//                                             context.watch<NewpriceController>().planof[i].name.toString()?theme.primaryColor:theme.primaryColor),
//                                             ))
                                           
//                                            ),
//                                SizedBox(width: Screens.width(context)*0.03,),
//                                 ],
//                               );


//                             }),
//                           ),
                       
                       
//                          ],),
//                        ),
                      
                      SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: Screens.width(context)*0.6,
                              child: TextFormField(
                                controller: context.read<NewpriceController>().mycontroller[8],
                                readOnly: true,
                                onTap:context.watch<NewpriceController>(). isimmediate==true?(){}: (){
                                context.read<NewpriceController>().  getDate2(context);
                                },
                                validator: (val){
                                  if( context.read<NewpriceController>(). isimmediate==false && val!.isEmpty){
                                    return "Choose Due Date";
                                  }
                                },
                                decoration: const InputDecoration(
                                  label: Text("Due Date*"),
                                  suffixIcon:Icon(Icons.calendar_month),
                                  border: UnderlineInputBorder(),
                                  focusedBorder: UnderlineInputBorder(),
                                  enabledBorder: UnderlineInputBorder(),
                                  errorBorder: UnderlineInputBorder(),
                                  focusedErrorBorder: UnderlineInputBorder()
                                ),
                              ),
                            ),
                         Checkbox(value:context.read<NewpriceController>(). isimmediate, onChanged: (val){
context.read<NewpriceController>().isimediate(val!);
                         },
                         activeColor: theme.primaryColor,
                         ),
                         Text("Immediate")
                          ],
                        ),
Container(
                                  height: Screens.bodyheight(context) * 0.05,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Approver",
                                    style: TextStyle(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextFormField(
                                  minLines: 6,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  readOnly: true,
                                  controller: context
                                      .read<NewpriceController>()
                                      .mycontroller[9],
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return "Enter Approver";
                                  //   }
                                  //   return null;
                                  // },
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
                      ],
                    ),
                  ),
                ),
             SizedBox(
                                width: Screens.width(context),
                                height: Screens.bodyheight(context) * 0.07,
                                child: ElevatedButton(
                                    onPressed: context
                                                .watch<NewpriceController>()
                                                .isloadingBtn ==
                                            true
                                        ? null
                                        : () {
                                         context
                                                .read<NewpriceController>()
                                                . validate(context,theme);
                                            
                                               },
                                    child: context
                                                .watch<NewpriceController>()
                                                .isloadingBtn ==
                                            true
                                        ? SizedBox(
                                            width: Screens.width(context) * 0.06,
                                            height: Screens.bodyheight(context) *
                                                0.04,
                                            child: CircularProgressIndicator(
                                                color: Colors.white))
                                        : Text("Submit Request")),
                              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
