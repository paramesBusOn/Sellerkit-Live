// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_new, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Widgets/qrpage.dart';
import '../../Controller/LeadController/LeadNewController.dart';
import '../../Widgets/Appbar.dart';
import '../../Widgets/Navi3.dart';

class LeadBookNew extends StatefulWidget {
  LeadBookNew({Key? key}) : super(key: key);

  @override
  State<LeadBookNew> createState() => LeadBookNewState();
}

class LeadBookNewState extends State<LeadBookNew> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

     if(ConstantValues.  multistoreuser ==1){
context.read<LeadNewController>().restricteddialog(context);
     } else{
 context.read<LeadNewController>().checkComeFromEnq();
     }
      // 
     
 });
  }

  DateTime? currentBackPressTime;
  
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("object");
      Get.offAllNamed(ConstantRoutes.leadstab);
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
          drawerEnableOpenDragGesture: false,
          // backgroundColor: Colors.grey[200],
          /// resizeToAvoidBottomInset: true,
          key: scaffoldKey,
          appBar: appbar("Leads", scaffoldKey, theme, context),
          drawer: drawer3(context),
          // body: ChangeNotifierProvider<LeadNewController>(
          //     create: (context) => LeadNewController(),
          //     builder: (context, child) {
          //       return Consumer<LeadNewController>(
          //           builder: (BuildContext context, provi, Widget? child) {
          // return
          body: PageView(
            physics: new NeverScrollableScrollPhysics(),
            controller: context.read<LeadNewController>().pageController,
            onPageChanged: (index) {
              log("index: ${index}");
              setState(() {
                context.read<LeadNewController>().pageChanged = index;
              });
              print(context.read<LeadNewController>().pageChanged);
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
                      Get.offAllNamed(ConstantRoutes.leadstab);
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
    //LeadNewController provi
    return Container(
      width: Screens.width(context),
      height: Screens.bodyheight(context),
      padding: EdgeInsets.only(
        left: Screens.width(context) * 0.03,
        right: Screens.width(context) * 0.03,
        top: Screens.bodyheight(context) * 0.02,
        bottom: Screens.bodyheight(context) * 0.01,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context) * 0.85,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            "Referrals",
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
                            child: Wrap(
                                spacing: 20.0, // width
                                runSpacing: 8.0, // height
                                children: listContainersRefferes(theme)),
                          )
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(height: Screens.bodyheight(context)*0.02,),
                  // SizedBox(
                  //   height: Screens.bodyheight(context) * 0.01,
                  // ),
                  //dates
                  Form(
                    key: context.read<LeadNewController>().formkey[1],
                    child: Column(
                      children: [
                        TextFormField(
                            onTap: () {
                              context
                                  .read<LeadNewController>()
                                  .showpurchaseDate(context);
                            },
                            controller: context
                                .read<LeadNewController>()
                                .mycontroller[13],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Choose Purchase Date";
                              }
                              return null;
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                                hintText: 'Plan of Purchase Date*', //
                                border: UnderlineInputBorder(),
                                enabledBorder: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(),
                                errorBorder: UnderlineInputBorder(),
                                focusedErrorBorder: UnderlineInputBorder(),
                                suffixIcon: Icon(Icons.date_range_outlined))),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Screens.width(context) * 0.5,
                                child: TextFormField(
                                    onTap: () {
                                      context
                                          .read<LeadNewController>()
                                          .showFollowDate(context);
                                    },
                                    controller: context
                                        .read<LeadNewController>()
                                        .mycontroller[14],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Choose Next Followup Date"; //
                                      }
                                      return null;
                                    },
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        hintText: 'Next Followup Date*',
                                        border: UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(),
                                        focusedBorder: UnderlineInputBorder(),
                                        errorBorder: UnderlineInputBorder(),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(),
                                        suffixIcon:
                                            Icon(Icons.date_range_outlined))
                                            ),
                              ),
                              InkWell(
                               
                                child: Container(
                                  width: Screens.width(context) * 0.4,
                                  // color: Colors.red,
                                  child:TextFormField(
                                     onTap:
                                    //   context
                                    //         .read<LeadNewController>()
                                    //         .visiblefollTime ==
                                    //     true
                                    // ?
                                     () {
                                        setState(() {
                                          context
                                              .read<LeadNewController>()
                                              .selectTime(context);
                                        });
                                      }
                                    // : null
                                    ,
                                  controller: context
                                  .read<LeadNewController>()
                                  .mycontroller[19],
                                  validator: (value) {
                                if (value!.isEmpty) {
                                  return "Choose Followup Time"; //
                                }
                                return null;
                                  },
                                  readOnly: true,
                                  decoration: InputDecoration(
                                  hintText: '',
                                  border: UnderlineInputBorder(),
                                  enabledBorder: UnderlineInputBorder(),
                                  focusedBorder: UnderlineInputBorder(),
                                  errorBorder: UnderlineInputBorder(),
                                  focusedErrorBorder:
                                      UnderlineInputBorder(),
                                  suffixIcon:
                                      Icon( Icons.timer,))

                                  )
                                  
                                //    Text(
                                //     context
                                //         .read<LeadNewController>()
                                //         .getnextFDTime,
                                //     //       context
                                //     // .read<LeadNewController>().apiNdate,
                                //     style: theme.textTheme.bodyText2
                                //         ?.copyWith(), //fontSize: 12
                                //   ),
                                // ),
                                // Container(
                                //   alignment: Alignment.centerRight,
                                //   width: Screens.width(context) * 0.15,
                                //   // color: Colors.red,
                                //   child: Icon(
                                //     Icons.timer,
                                //     // size: Screens.,
                                //     color: theme.primaryColor
                                //         .withOpacity(0.5),
                                //   ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
context.read<LeadNewController>().isdatevalid == false
                            ? Container()
                            : Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${context.read<LeadNewController>().excError}",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                               context.read<LeadNewController>().istimevalid == false
                          && context.watch<LeadNewController>().errorTime==''  ? Container()
                            : Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "${context.read<LeadNewController>().errorTime}",
                                  style: TextStyle(color: Colors.red,fontSize: 13),
                                ),
                              ),
                        ],)
                        
                      ],
                    ),
                  ),

                  // SizedBox(height: Screens.bodyheight(context) * 0.02),
                  Container(
                    width: Screens.width(context),
                    height: Screens.bodyheight(context) * 0.3,
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                          bottom: Screens.bodyheight(context) * 0.02),
                      itemCount: context
                          .read<LeadNewController>()
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
                                    width: Screens.width(context) * 0.7,
                                    child: Text(
                                      "${context.watch<LeadNewController>().getleadcheckdatas[index].Name}",
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
                                          .read<LeadNewController>()
                                          .getleadcheckdatas[index]
                                          .ischecked!,
                                      onToggle: (val) {
                                        // context.read<LeadNewController>().switchremainder(val);
                                        //  print(val);
                                        // setState(() {
                                        //   switched = val;
                                        //   reqfinance = "Y";
                                        // });
                                        context
                                            .read<LeadNewController>()
                                            .LeadcheckListClicked(val, index);
                                      })
                                ]),
                                SizedBox(
                                  height: Screens.bodyheight(context) * 0.01,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.grey))),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  //save btn
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.03,
                  ),
                ],
              ),
            ),
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
                          .read<LeadNewController>()
                          .pageController
                          .animateToPage(
                              --context.read<LeadNewController>().pageChanged,
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
                        context.watch<LeadNewController>().getisloadingBtn ==
                                true
                            ? null
                            : () {
                                context
                                    .read<LeadNewController>()
                                    .thirPageBtnClicked(context);
                              },
                    child: context.watch<LeadNewController>().getisloadingBtn ==
                            true
                        ? SizedBox(
                            width: Screens.width(context) * 0.08,
                            height: Screens.bodyheight(context) * 0.07,
                            child:
                                CircularProgressIndicator(color: Colors.white))
                        : Icon(Icons.save)),
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

  bool switched = false;
  bool switched2 = false;

  Container SecondPage(
    BuildContext context,
    ThemeData theme,
  ) {
    //  return ChangeNotifierProvider<LeadNewController>(
    //       create: (context) => LeadNewController(),
    //       builder: (context, child) {
    //         return Consumer<LeadNewController>(
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
                width:context.read<LeadNewController>().showItemList == true? Screens.width(context)*0.80:Screens.width(context)*0.95,
                
                height: Screens.bodyheight(context) * 0.06,
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1), //Colors.grey[200],
                  borderRadius:
                      BorderRadius.circular(Screens.width(context) * 0.02),
                ),
                child: TextField(
                  autocorrect: false,
                  onChanged: (val) {
                    context.read<LeadNewController>().filterList(val);
                  },
                  controller: context.read<LeadNewController>().mycontroller[12],
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
                        context.read<LeadNewController>().changeVisible();
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
          
           context.read<LeadNewController>().showItemList == true?   Container(
            // alignment: Alignment.center,
            child: IconButton(
              onPressed: (){
                setState(() {
                   context.read<LeadNewController>().     scannerreset();
                   qrscannerState.leadscan=true;
                Navigator.push(context,MaterialPageRoute(builder: (_) => qrscanner()))
//                 .then((value){
// return context.read<LeadNewController>().scanneddataget(context);
//                 } 
//                  )
                 ;
                });
           
              },
              icon: Icon(Icons.qr_code_scanner_outlined,color: theme.primaryColor,size: 30,)),
          ):Container()
          
            ],
          ),
          context.read<LeadNewController>().showItemList == true
              ? Expanded(
                  child: ListView.builder(
                    itemCount: context
                        .watch<LeadNewController>()
                        .getAllProductDetails
                        .length,
                    itemBuilder: (BuildContext context, int i) {
                      return InkWell(
                        onTap: () {
                          context.read<LeadNewController>().resetItems(i);
                          context.read<LeadNewController>().isUpdateClicked =
                              false;
                          // context
                          //     .read<LeadNewController>()
                          //     .showBottomSheetInsert(context, i);
                          context
                              .read<LeadNewController>()
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
                                          "Item code: ${context.read<LeadNewController>().getAllProductDetails[i].itemCode}",
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
                                                .read<LeadNewController>()
                                                .config
                                                .alignDate(context
                                                    .read<LeadNewController>()
                                                    .getAllProductDetails[i]
                                                    .refreshedRecordDate!),
                                        // context
                                        //     .watch<LeadNewController>()
                                        //     .config
                                        //     .alignDate(context
                                        //         .read<LeadNewController>()
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
                                          "${context.read<LeadNewController>().getAllProductDetails[i].itemName}",
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
                                            "${ context
                                                .read<LeadNewController>()
                                                .config.slpitCurrency22(context.read<LeadNewController>().getAllProductDetails[i].sp.toString())}",
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
                        context.read<LeadNewController>().getProduct.length,
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
                                                .read<LeadNewController>()
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
                                            .read<LeadNewController>()
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
                                                  .read<LeadNewController>()
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
                                                .read<LeadNewController>()
                                                .config.slpitCurrency22(context
                                                  .read<LeadNewController>()
                                                  .getProduct[index]
                                                  .Price
                                                  .toString()),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                          )),
                                    ],
                                  ),
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
                                                .read<LeadNewController>()
                                                .config.slpitCurrency22(  context
                                                      .read<LeadNewController>()
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
                                                            LeadNewController>()
                                                        .getProduct
                                                        .removeAt(index);
                                                        if(context
                                                                .read<
                                                                    LeadNewController>()
                                                                .productDetails.isEmpty){
                                                            context
                                                                .read<
                                                                    LeadNewController>()
                                                                .      changeVisible();

                                                        }

                                                    for (int i = 0;
                                                        i <
                                                            context
                                                                .read<
                                                                    LeadNewController>()
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
                                                          .read<LeadNewController>()
                                                          .mycontroller[10]
                                                          .text =
                                                      context
                                                          .read<
                                                              LeadNewController>()
                                                          .getProduct[index]
                                                          .Price!
                                                          .toStringAsFixed(2);
                                                  context
                                                          .read<LeadNewController>()
                                                          .mycontroller[11]
                                                          .text =
                                                      context
                                                          .read<
                                                              LeadNewController>()
                                                          .getProduct[index]
                                                          .Quantity!
                                                          .toStringAsFixed(2);
                                                  context
                                                          .read<LeadNewController>()
                                                          .mycontroller[11]
                                                          .text =
                                                      context
                                                          .read<
                                                              LeadNewController>()
                                                          .getProduct[index]
                                                          .Quantity!
                                                          .toStringAsFixed(0);
                                                  context
                                                          .read<LeadNewController>()
                                                          .total =
                                                      context
                                                          .read<
                                                              LeadNewController>()
                                                          .getProduct[index]
                                                          .LineTotal!;
                                                  context
                                                      .read<LeadNewController>()
                                                      .isUpdateClicked = true;

                                                  context
                                                      .read<LeadNewController>()
                                                      .showBottomSheetInsert(
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
                          .read<LeadNewController>()
                          .pageController
                          .animateToPage(
                              --context.read<LeadNewController>().pageChanged,
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

                      context.read<LeadNewController>().seconPageBtnClicked();
                      log("oldcutomer: " +
                          context
                              .read<LeadNewController>()
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
    // return ChangeNotifierProvider<LeadNewController>(
    //       create: (context) => LeadNewController(),
    //       builder: (context, child) {
    //         return Consumer<LeadNewController>(
    //           builder: (BuildContext context, provi, Widget? child) {
    return InkWell(
      onTap: () {
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) {
          focus.unfocus();
        }
      },
      child: (context.read<LeadNewController>().getexceptionOnApiCall.isEmpty &&
              context.read<LeadNewController>().getcustomerapicLoading == true)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (context
                      .read<LeadNewController>()
                      .getexceptionOnApiCall
                      .isNotEmpty &&
                  context.read<LeadNewController>().getcustomerapicLoading ==
                      false)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.read<LeadNewController>().getexceptionOnApiCall,
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
                      key: context.read<LeadNewController>().formkey[0],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text("Mobile"),
                          TextFormField(
                              controller: context
                                  .read<LeadNewController>()
                                  .mycontroller[0],
                              focusNode:
                                  context.read<LeadNewController>().focusNode2,
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
                                            .read<LeadNewController>()
                                            .getcustomerapicalled ==
                                        false) {
                                  context
                                      .read<LeadNewController>()
                                      .callApi(context);
                                  // context
                                  //     .read<LeadNewController>()
                                  //     .callCheckEnqDetailsApi(context);
                                } else if (v.length != 10) {
                                  context.read<LeadNewController>().clearnum();
                                }
                              },
                              onEditingComplete: (){
                                          if(context
                                            .read<LeadNewController>()
                                            .mycontroller[0].text.length==10){
 context
                                                .read<LeadNewController>()
                                                .callApi(context);
                                            }
                                         
                                        },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                new LengthLimitingTextInputFormatter(10),
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                // hintText: 'Mobile',
                                labelText: 'Mobile*',
                                border: UnderlineInputBorder(),
                                enabledBorder: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(),
                                errorBorder: UnderlineInputBorder(),
                                focusedErrorBorder: UnderlineInputBorder(),
                              )),
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.02,
                          ),
                          //Vip tags
                          Center(
                            child: Wrap(
                                spacing: 5.0, // width
                                runSpacing: 10.0, // height
                                children: listContainersCustomerTag(
                                  theme,
                                )),
                          ),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         InkWell(
                          //           onTap: () {
                          //             context.read<LeadNewController>().selectCsTag("Corporate");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.2,
                          //             height: Screens.bodyheight(context) * 0.05,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<LeadNewController>()
                          //                             .getisSelectedCsTag ==
                          //                         'Corporate'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor, width: 1),
                          //                 borderRadius: BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Corporate",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText2
                          //                         ?.copyWith(
                          //                           fontSize: 12,
                          //                           color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedCsTag ==
                          //                               "Corporate"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context.read<LeadNewController>().selectCsTag("Doctor");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.2,
                          //             height: Screens.bodyheight(context) * 0.05,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<LeadNewController>()
                          //                             .getisSelectedCsTag ==
                          //                         'Doctor'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor, width: 1),
                          //                 borderRadius: BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Doctor",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                           fontSize: 12,
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedCsTag ==
                          //                               "Doctor"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context.read<LeadNewController>().selectCsTag("Govt");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.2,
                          //             height: Screens.bodyheight(context) * 0.05,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<LeadNewController>()
                          //                             .getisSelectedCsTag ==
                          //                         'Govt'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor, width: 1),
                          //                 borderRadius: BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Govt",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                           fontSize: 12,
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedCsTag ==
                          //                               "Govt"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),

                          //         //
                          //          InkWell(
                          //           onTap: () {
                          //             context.read<LeadNewController>().selectCsTag("Student");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.2,
                          //             height: Screens.bodyheight(context) * 0.05,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<LeadNewController>()
                          //                             .getisSelectedCsTag ==
                          //                         'Student'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor, width: 1),
                          //                 borderRadius: BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Student",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                           fontSize: 12,
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedCsTag ==
                          //                               "Student"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //      SizedBox(
                          //       height: Screens.bodyheight(context) * 0.01,
                          //     ),
                          //         Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //       children: [
                          //         InkWell(
                          //           onTap: () {
                          //             context.read<LeadNewController>().selectCsTag("Police/Army");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.25,
                          //             height: Screens.bodyheight(context) * 0.05,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<LeadNewController>()
                          //                             .getisSelectedCsTag ==
                          //                         'Police/Army'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor, width: 1),
                          //                 borderRadius: BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Police/Army",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                           fontSize: 12,
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedCsTag ==
                          //                               "Police/Army"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         InkWell(
                          //           onTap: () {
                          //             context.read<LeadNewController>().selectCsTag("Advocate");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.2,
                          //             height: Screens.bodyheight(context) * 0.05,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<LeadNewController>()
                          //                             .getisSelectedCsTag ==
                          //                         'Advocate'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor, width: 1),
                          //                 borderRadius: BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Advocate",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                           fontSize: 12,
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedCsTag ==
                          //                               "Advocate"
                          //                           ? Colors.white
                          //                           : theme.primaryColor,
                          //                     ))
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //         ///
                          //         InkWell(
                          //           onTap: () {
                          //             context.read<LeadNewController>().selectCsTag("Celebrity");
                          //           },
                          //           child: Container(
                          //             width: Screens.width(context) * 0.2,
                          //             height: Screens.bodyheight(context) * 0.05,
                          //             //  padding: EdgeInsets.all(10),
                          //             decoration: BoxDecoration(
                          //                 color: context
                          //                             .watch<LeadNewController>()
                          //                             .getisSelectedCsTag ==
                          //                         'Celebrity'
                          //                     ? theme.primaryColor
                          //                     : Colors.white,
                          //                 border: Border.all(
                          //                     color: theme.primaryColor, width: 1),
                          //                 borderRadius: BorderRadius.circular(10)),
                          //             child: Column(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               children: [
                          //                 Text("Celebrity",
                          //                     maxLines: 8,
                          //                     overflow: TextOverflow.ellipsis,
                          //                     style: theme.textTheme.bodyText1
                          //                         ?.copyWith(
                          //                           fontSize: 12,
                          //                       color: context
                          //                                   .watch<
                          //                                       LeadNewController>()
                          //                                   .getisSelectedCsTag ==
                          //                               "Celebrity"
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

                          //   ],
                          // ),
                          //
                          TextFormField(
                              controller: context
                                  .read<LeadNewController>()
                                  .mycontroller[1],
                                  onTap: (){
                                                    if(context
                                                  .read<LeadNewController>()
                                                  .mycontroller[16].text.isNotEmpty &&context
                                                  .read<LeadNewController>()
                                                  .statecode.isEmpty){
 context
                                                  .read<LeadNewController>()
                                                  . ontapvalid(context);
                                                  
                                                  }else if(context
                                                  .read<LeadNewController>()
                                                  .mycontroller[16].text.isNotEmpty &&context
                                                  .read<LeadNewController>()
                                                  .statecode.isNotEmpty){
                                                    setState(() {
                                                        context
                                                  .read<LeadNewController>()
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
                                focusedErrorBorder: UnderlineInputBorder(),
                              )),
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.01,
                          ),
                          TextFormField(
                              controller: context
                                  .read<LeadNewController>()
                                  .mycontroller[17],
                                  onTap: (){
                                                    if(context
                                                  .read<LeadNewController>()
                                                  .mycontroller[16].text.isNotEmpty &&context
                                                  .read<LeadNewController>()
                                                  .statecode.isEmpty){
 context
                                                  .read<LeadNewController>()
                                                  . ontapvalid(context);
                                                  
                                                  }else if(context
                                                  .read<LeadNewController>()
                                                  .mycontroller[16].text.isNotEmpty &&context
                                                  .read<LeadNewController>()
                                                  .statecode.isNotEmpty){
                                                    setState(() {
                                                        context
                                                  .read<LeadNewController>()
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
                                // hintText: 'Contact Name',
                                labelText: 'Contact Name  (optional)',
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
                              controller: context
                                  .read<LeadNewController>()
                                  .mycontroller[2],
                                 onTap: (){
                                                    if(context
                                                  .read<LeadNewController>()
                                                  .mycontroller[16].text.isNotEmpty &&context
                                                  .read<LeadNewController>()
                                                  .statecode.isEmpty){
 context
                                                  .read<LeadNewController>()
                                                  . ontapvalid(context);
                                                  
                                                  }else if(context
                                                  .read<LeadNewController>()
                                                  .mycontroller[16].text.isNotEmpty &&context
                                                  .read<LeadNewController>()
                                                  .statecode.isNotEmpty){
                                                    setState(() {
                                                        context
                                                  .read<LeadNewController>()
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
                              decoration: InputDecoration(
                                // hintText: 'Address1',
                                labelText: 'Address1',
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
                              controller: context
                                  .read<LeadNewController>()
                                  .mycontroller[3],onTap: (){
                                                    if(context
                                                  .read<LeadNewController>()
                                                  .mycontroller[16].text.isNotEmpty &&context
                                                  .read<LeadNewController>()
                                                  .statecode.isEmpty){
 context
                                                  .read<LeadNewController>()
                                                  . ontapvalid(context);
                                                  
                                                  }else if(context
                                                  .read<LeadNewController>()
                                                  .mycontroller[16].text.isNotEmpty &&context
                                                  .read<LeadNewController>()
                                                  .statecode.isNotEmpty){
                                                    setState(() {
                                                        context
                                                  .read<LeadNewController>()
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
                              decoration: InputDecoration(
                                // hintText: 'Address2',
                                labelText: 'Address2',
                                border: UnderlineInputBorder(),
                                enabledBorder: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(),
                                errorBorder: UnderlineInputBorder(),
                                focusedErrorBorder: UnderlineInputBorder(),
                              )),
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.01,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: Screens.width(context) * 0.4,
                                child: TextFormField(
                                    controller: context
                                        .read<LeadNewController>()
                                        .mycontroller[15],
                                       onTap: (){
                                                    if(context
                                                  .read<LeadNewController>()
                                                  .mycontroller[16].text.isNotEmpty &&context
                                                  .read<LeadNewController>()
                                                  .statecode.isEmpty){
 context
                                                  .read<LeadNewController>()
                                                  . ontapvalid(context);
                                                  
                                                  }else if(context
                                                  .read<LeadNewController>()
                                                  .mycontroller[16].text.isNotEmpty &&context
                                                  .read<LeadNewController>()
                                                  .statecode.isNotEmpty){
                                                    setState(() {
                                                        context
                                                  .read<LeadNewController>()
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
                                      enabledBorder: UnderlineInputBorder(),
                                      focusedBorder: UnderlineInputBorder(),
                                      errorBorder: UnderlineInputBorder(),
                                      focusedErrorBorder:
                                          UnderlineInputBorder(),
                                    )),
                              ),
                              SizedBox(
                                width: Screens.width(context) * 0.4,
                                child: TextFormField(
                                    controller: context
                                        .read<LeadNewController>()
                                        .mycontroller[5],
                                         onTap: (){
                                                    if(context
                                                  .read<LeadNewController>()
                                                  .mycontroller[16].text.isNotEmpty &&context
                                                  .read<LeadNewController>()
                                                  .statecode.isEmpty){
 context
                                                  .read<LeadNewController>()
                                                  . ontapvalid(context);
                                                  
                                                  }else if(context
                                                  .read<LeadNewController>()
                                                  .mycontroller[16].text.isNotEmpty &&context
                                                  .read<LeadNewController>()
                                                  .statecode.isNotEmpty){
                                                    setState(() {
                                                        context
                                                  .read<LeadNewController>()
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
                                      enabledBorder: UnderlineInputBorder(),
                                      focusedBorder: UnderlineInputBorder(),
                                      errorBorder: UnderlineInputBorder(),
                                      focusedErrorBorder:
                                          UnderlineInputBorder(),
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.01,
                          ),

                          Container(
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: Screens.width(context) * 0.4,
                                          child: TextFormField(
                                              controller: context
                                                  .read<LeadNewController>()
                                                  .mycontroller[4],

                                              // validator: (value) {
                                              //   if (value!.isEmpty) {
                                              //     return "Enter Pincode";
                                              //   }
                                              //   return null;
                                              // },
                                              inputFormatters: [
                                                FilteringTextInputFormatter.digitsOnly,
                                                new LengthLimitingTextInputFormatter(
                                                    6),
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                // hintText: 'Pincode',
                                                labelText: 'Pincode',
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
                                        SizedBox(
                                          width: Screens.width(context) * 0.4,
                                          child: TextFormField(
                                              controller: context
                                                  .read<LeadNewController>()
                                                  .mycontroller[16],
                                              focusNode: context
                                                  .read<LeadNewController>()
                                                  .focusNode1,
                                              autovalidateMode: AutovalidateMode
                                                  .always,
                                              onChanged: (v) {
                                                
                                                setState(() {
                                                   context
                                                              .read<
                                                                  LeadNewController>()
                                                              .  isText1Correct = false;
                                                  context
                                                      .read<LeadNewController>()
                                                      .filterListState2(v);
                                                  if (v.isEmpty) {
                                                    context
                                                        .read<
                                                            LeadNewController>()
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
                                                                LeadNewController>()
                                                            .methidstate(context
                                                                .read<
                                                                    LeadNewController>()
                                                                .mycontroller[
                                                                    16]
                                                                .text,context);
                                                    context
                                                        .read<
                                                            LeadNewController>()
                                                        .statebool = true;
                                                  }
                                                });
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  // return "Enter State";
                                                } else if (value.isNotEmpty &&
                                                    context
                                                        .read<
                                                            LeadNewController>()
                                                        .statecode
                                                        .isEmpty) {
                                                  context
                                                      .read<LeadNewController>()
                                                      .methidstate(context
                                                          .read<
                                                              LeadNewController>()
                                                          .mycontroller[16]
                                                          .text,context);
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          context
                                                  .read<LeadNewController>()
                                                  .focusNode1);
                                                  context
                                                      .read<LeadNewController>()
                                                      .statebool = false;
                                                  return "Enter Correct State";
                                                }
                                                return null;
                                              },
                                              onEditingComplete: () {
                                                setState(() {
                                                  context
                                                      .read<LeadNewController>()
                                                      .statebool = false;
                                                  context
                                                  .read<LeadNewController>()
                                                  .focusNode1.unfocus();
                                                  // context
                                                  //   .read<NewEnqController>()
                                                  //   .  methodfortest();
                                                  context
                                                      .read<LeadNewController>()
                                                      .methidstate(context
                                                          .read<
                                                              LeadNewController>()
                                                          .mycontroller[16]
                                                          .text,context);

                                                  // context
                                                  // .read<NewEnqController>()
                                                  // .statecode='';
                                                });
                                              },
                                              decoration: InputDecoration(
                                                // hintText: 'State',
                                                labelText: 'State*',
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
                                    context
                                                .read<LeadNewController>()
                                                .isText1Correct ==
                                            true
                                        ? Container(
                                            padding: EdgeInsets.only(
                                                right: Screens.width(context) *
                                                    0.1,
                                                top: Screens.padingHeight(
                                                        context) *
                                                    0.001),
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "Enter Correct State",
                                              style: theme.textTheme.bodyText2!
                                                  .copyWith(
                                                      color: Colors.red,
                                                      fontSize: 12),
                                            ),
                                          )
                                        : Container(),
                                    SizedBox(
                                      height:
                                          Screens.bodyheight(context) * 0.01,
                                    ),
                                    TextFormField(
                                        controller: context
                                            .read<LeadNewController>()
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
                                          new LengthLimitingTextInputFormatter(
                                              10),
                                        ],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          // hintText: 'Alternate Mobile No',
                                          labelText: 'Alternate Mobile No',
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
                                            .read<LeadNewController>()
                                            .mycontroller[7],
                                             onTap: (){
                                                    if(context
                                                  .read<LeadNewController>()
                                                  .mycontroller[16].text.isNotEmpty &&context
                                                  .read<LeadNewController>()
                                                  .statecode.isEmpty){
 context
                                                  .read<LeadNewController>()
                                                  . ontapvalid(context);
                                                  
                                                  }else if(context
                                                  .read<LeadNewController>()
                                                  .mycontroller[16].text.isNotEmpty &&context
                                                  .read<LeadNewController>()
                                                  .statecode.isNotEmpty){
                                                    setState(() {
                                                        context
                                                  .read<LeadNewController>()
                                                  .statebool = false;
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
                                              // context.read<LeadNewController>().ffff ="Please Enter the Valid Email";
                                              return "Please Enter the Valid Email";
                                            }
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          // hintText: 'Email',
                                          labelText: 'Email',
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
                                            .read<LeadNewController>()
                                            .mycontroller[8],
                                        // validator: (value) {
                                        //   if (value!.isEmpty) {
                                        //     return "Enter Head Count";
                                        //   }
                                        //   return null;
                                        // },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          // hintText: 'Head Count',
                                          labelText: 'Head Count',
                                          border: UnderlineInputBorder(),
                                          enabledBorder: UnderlineInputBorder(),
                                          focusedBorder: UnderlineInputBorder(),
                                          errorBorder: UnderlineInputBorder(),
                                          focusedErrorBorder:
                                              UnderlineInputBorder(),
                                        )),
                                  ],
                                ),
                                Visibility(
                                  visible: context
                                      .read<LeadNewController>()
                                      .statebool,
                                  child: Positioned(
                                      top: Screens.bodyheight(context) * 0.09,
                                      left: Screens.width(context) * 0.5,
                                      child: Container(
                                        width: Screens.width(context) * 0.8,
                                        // height: Screens.bodyheight(context),
                                        color: Colors.white,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: context
                                                .read<LeadNewController>()
                                                .filterstateData
                                                .length,
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    context
                                                        .read<
                                                            LeadNewController>()
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
                                                      width: Screens.width(
                                                          context),
                                                      child: Text(
                                                        "${context.watch<LeadNewController>().filterstateData[i].stateName}",
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
                                )
                              ],
                            ),
                          ),

                          SizedBox(
                            height: Screens.bodyheight(context) * 0.01,
                          ),
                          TextFormField(
                              controller: context
                                  .read<LeadNewController>()
                                  .mycontroller[9],
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return "Enter Max Budget";
                              //   }
                              //   return null;
                              // },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                // hintText: 'Max Budget',
                                labelText: 'Max Budget',
                                border: UnderlineInputBorder(),
                                enabledBorder: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(),
                                errorBorder: UnderlineInputBorder(),
                                focusedErrorBorder: UnderlineInputBorder(),
                              )),
                             Container(
                                      height: Screens.padingHeight(context)*0.1,
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
                                                                         .read<LeadNewController>()
                                                                         .valueChosedStatus,
                                                                     //dropdownColor:Colors.green,
                                                                     icon: Icon(Icons.arrow_drop_down),
                                                                     iconSize: 30,
                                                                     style: TextStyle(
                                                                         color: Colors.black, fontSize: 16),
                                                                     isExpanded: true,
                                                                     onChanged: (val) {
                                                                       setState(() {
                                                                         context
                                          .read<LeadNewController>()
                                          .choosedStatus(val.toString());
                                                                       });
                                                                     },
                                                                     items: context
                                                                         .read<LeadNewController>()
                                                                         .leveofdata
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
                                     Container(
                                      height: Screens.padingHeight(context)*0.1,
                                       child: DropdownButtonFormField(
                                         decoration: InputDecoration(
                                                  // hintText: 'Email',
                                                  labelText: 'Select Order Type',
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
                                                                         .read<LeadNewController>()
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
                                          .read<LeadNewController>()
                                          .choosedType(val.toString());
                                                                       });
                                                                     },
                                                                     items: context
                                                                         .read<LeadNewController>()
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
                            height: Screens.bodyheight(context) * 0.03,
                          ),

                          //Gender

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context
                                            .read<LeadNewController>()
                                            .validateGender ==
                                        true
                                    ? "Gender *"
                                    : "Gender",
                                style: context
                                            .read<LeadNewController>()
                                            .validateGender ==
                                        true
                                    ? theme.textTheme.bodyText1
                                        ?.copyWith(color: Colors.red)
                                    : theme.textTheme.bodyText1,
                              ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.01,
                              ),
                              Center(
                                child: Wrap(
                                    spacing: 5.0, // width
                                    runSpacing: 10.0, // height
                                    children: listContainersGenderTag(
                                      theme,
                                    )),
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     InkWell(
                              //       onTap: () {
                              //         context
                              //             .read<LeadNewController>()
                              //             .selectGender("Male");
                              //       },
                              //       child: Container(
                              //         width: Screens.width(context) * 0.29,
                              //         height:
                              //             Screens.bodyheight(context) * 0.06,
                              //         //  padding: EdgeInsets.all(10),
                              //         decoration: BoxDecoration(
                              //             color: context
                              //                         .watch<
                              //                             LeadNewController>()
                              //                         .getisSelectedGender ==
                              //                     'Male'
                              //                 ? theme.primaryColor
                              //                 : Colors.white,
                              //             border: Border.all(
                              //                 color: theme.primaryColor,
                              //                 width: 1),
                              //             borderRadius:
                              //                 BorderRadius.circular(10)),
                              //         child: Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           children: [
                              //             Text("Male",
                              //                 maxLines: 8,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 style: theme.textTheme.bodyText1
                              //                     ?.copyWith(
                              //                   color: context
                              //                               .watch<
                              //                                   LeadNewController>()
                              //                               .getisSelectedGender ==
                              //                           "Male"
                              //                       ? Colors.white
                              //                       : theme.primaryColor,
                              //                 ))
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     InkWell(
                              //       onTap: () {
                              //         context
                              //             .read<LeadNewController>()
                              //             .selectGender("Female");
                              //       },
                              //       child: Container(
                              //         width: Screens.width(context) * 0.29,
                              //         height:
                              //             Screens.bodyheight(context) * 0.06,
                              //         //  padding: EdgeInsets.all(10),
                              //         decoration: BoxDecoration(
                              //             color: context
                              //                         .watch<
                              //                             LeadNewController>()
                              //                         .getisSelectedGender ==
                              //                     'Female'
                              //                 ? theme.primaryColor
                              //                 : Colors.white,
                              //             border: Border.all(
                              //                 color: theme.primaryColor,
                              //                 width: 1),
                              //             borderRadius:
                              //                 BorderRadius.circular(10)),
                              //         child: Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           children: [
                              //             Text("Female",
                              //                 maxLines: 8,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 style: theme.textTheme.bodyText1
                              //                     ?.copyWith(
                              //                   color: context
                              //                               .watch<
                              //                                   LeadNewController>()
                              //                               .getisSelectedGender ==
                              //                           "Female"
                              //                       ? Colors.white
                              //                       : theme.primaryColor,
                              //                 ))
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     InkWell(
                              //       onTap: () {
                              //         context
                              //             .read<LeadNewController>()
                              //             .selectGender("Other");
                              //       },
                              //       child: Container(
                              //         width: Screens.width(context) * 0.29,
                              //         height:
                              //             Screens.bodyheight(context) * 0.06,
                              //         //  padding: EdgeInsets.all(10),
                              //         decoration: BoxDecoration(
                              //             color: context
                              //                         .watch<
                              //                             LeadNewController>()
                              //                         .getisSelectedGender ==
                              //                     'Other'
                              //                 ? theme.primaryColor
                              //                 : Colors.white,
                              //             border: Border.all(
                              //                 color: theme.primaryColor,
                              //                 width: 1),
                              //             borderRadius:
                              //                 BorderRadius.circular(10)),
                              //         child: Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           children: [
                              //             Text("Other",
                              //                 maxLines: 8,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 style: theme.textTheme.bodyText1
                              //                     ?.copyWith(
                              //                   color: context
                              //                               .watch<
                              //                                   LeadNewController>()
                              //                               .getisSelectedGender ==
                              //                           "Other"
                              //                       ? Colors.white
                              //                       : theme.primaryColor,
                              //                 ))
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),

                          //age group

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.03,
                              ),
                              Text(
                                context.read<LeadNewController>().validateAge ==
                                        true
                                    ? "Age Group *"
                                    : "Age Group",
                                style: context
                                            .read<LeadNewController>()
                                            .validateAge ==
                                        true
                                    ? theme.textTheme.bodyText1
                                        ?.copyWith(color: Colors.red)
                                    : theme.textTheme.bodyText1,
                              ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.01,
                              ),
                              Center(
                                child: Wrap(
                                    spacing: 5.0, // width
                                    runSpacing: 10.0, // height
                                    children: listContainersAgeTag(
                                      theme,
                                    )),
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     InkWell(
                              //       onTap: () {
                              //         context
                              //             .read<LeadNewController>()
                              //             .selectage("20-30");
                              //       },
                              //       child: Container(
                              //         width: Screens.width(context) * 0.29,
                              //         height:
                              //             Screens.bodyheight(context) * 0.06,
                              //         //  padding: EdgeInsets.all(10),
                              //         decoration: BoxDecoration(
                              //             color: context
                              //                         .watch<
                              //                             LeadNewController>()
                              //                         .getisSelectedAge ==
                              //                     '20-30'
                              //                 ? theme.primaryColor
                              //                 : Colors.white,
                              //             border: Border.all(
                              //                 color: theme.primaryColor,
                              //                 width: 1),
                              //             borderRadius:
                              //                 BorderRadius.circular(10)),
                              //         child: Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           children: [
                              //             Text("20-30",
                              //                 maxLines: 8,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 style: theme.textTheme.bodyText1
                              //                     ?.copyWith(
                              //                   color: context
                              //                               .watch<
                              //                                   LeadNewController>()
                              //                               .getisSelectedAge ==
                              //                           "20-30"
                              //                       ? Colors.white
                              //                       : theme.primaryColor,
                              //                 ))
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     InkWell(
                              //       onTap: () {
                              //         context
                              //             .read<LeadNewController>()
                              //             .selectage("30-40");
                              //       },
                              //       child: Container(
                              //         width: Screens.width(context) * 0.29,
                              //         height:
                              //             Screens.bodyheight(context) * 0.06,
                              //         //  padding: EdgeInsets.all(10),
                              //         decoration: BoxDecoration(
                              //             color: context
                              //                         .watch<
                              //                             LeadNewController>()
                              //                         .getisSelectedAge ==
                              //                     '30-40'
                              //                 ? theme.primaryColor
                              //                 : Colors.white,
                              //             border: Border.all(
                              //                 color: theme.primaryColor,
                              //                 width: 1),
                              //             borderRadius:
                              //                 BorderRadius.circular(10)),
                              //         child: Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           children: [
                              //             Text("30-40",
                              //                 maxLines: 8,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 style: theme.textTheme.bodyText1
                              //                     ?.copyWith(
                              //                   color: context
                              //                               .watch<
                              //                                   LeadNewController>()
                              //                               .getisSelectedAge ==
                              //                           "30-40"
                              //                       ? Colors.white
                              //                       : theme.primaryColor,
                              //                 ))
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     InkWell(
                              //       onTap: () {
                              //         context
                              //             .read<LeadNewController>()
                              //             .selectage("40-50");
                              //       },
                              //       child: Container(
                              //         width: Screens.width(context) * 0.29,
                              //         height:
                              //             Screens.bodyheight(context) * 0.06,
                              //         //  padding: EdgeInsets.all(10),
                              //         decoration: BoxDecoration(
                              //             color: context
                              //                         .watch<
                              //                             LeadNewController>()
                              //                         .getisSelectedAge ==
                              //                     '40-50'
                              //                 ? theme.primaryColor
                              //                 : Colors.white,
                              //             border: Border.all(
                              //                 color: theme.primaryColor,
                              //                 width: 1),
                              //             borderRadius:
                              //                 BorderRadius.circular(10)),
                              //         child: Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           children: [
                              //             Text("40-50",
                              //                 maxLines: 8,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 style: theme.textTheme.bodyText1
                              //                     ?.copyWith(
                              //                   color: context
                              //                               .watch<
                              //                                   LeadNewController>()
                              //                               .getisSelectedAge ==
                              //                           "40-50"
                              //                       ? Colors.white
                              //                       : theme.primaryColor,
                              //                 ))
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: Screens.bodyheight(context) * 0.01,
                              // ),
                              // InkWell(
                              //   onTap: () {
                              //     context
                              //         .read<LeadNewController>()
                              //         .selectage("50>");
                              //   },
                              //   child: Container(
                              //     width: Screens.width(context) * 0.29,
                              //     height: Screens.bodyheight(context) * 0.06,
                              //     //  padding: EdgeInsets.all(10),
                              //     decoration: BoxDecoration(
                              //         color: context
                              //                     .watch<LeadNewController>()
                              //                     .getisSelectedAge ==
                              //                 '50>'
                              //             ? theme.primaryColor
                              //             : Colors.white,
                              //         border: Border.all(
                              //             color: theme.primaryColor, width: 1),
                              //         borderRadius: BorderRadius.circular(10)),
                              //     child: Column(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         Text("50>",
                              //             maxLines: 8,
                              //             overflow: TextOverflow.ellipsis,
                              //             style: theme.textTheme.bodyText1
                              //                 ?.copyWith(
                              //               color: context
                              //                           .watch<
                              //                               LeadNewController>()
                              //                           .getisSelectedAge ==
                              //                       "50>"
                              //                   ? Colors.white
                              //                   : theme.primaryColor,
                              //             ))
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),

                          //come with as

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.03,
                              ),
                              Text(
                                context
                                            .read<LeadNewController>()
                                            .validateComas ==
                                        true
                                    ? "Came as *"
                                    : "Came as",
                                style: context
                                            .read<LeadNewController>()
                                            .validateComas ==
                                        true
                                    ? theme.textTheme.bodyText1
                                        ?.copyWith(color: Colors.red)
                                    : theme.textTheme.bodyText1,
                              ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.01,
                              ),
                              Center(
                                child: Wrap(
                                    spacing: 5.0, // width
                                    runSpacing: 10.0, // height
                                    children: listContainersCamaAsTag(
                                      theme,
                                    )),
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     InkWell(
                              //       onTap: () {
                              //         context
                              //             .read<LeadNewController>()
                              //             .selectComeas("Family");
                              //       },
                              //       child: Container(
                              //         width: Screens.width(context) * 0.29,
                              //         height:
                              //             Screens.bodyheight(context) * 0.06,
                              //         //  padding: EdgeInsets.all(10),
                              //         decoration: BoxDecoration(
                              //             color: context
                              //                         .watch<
                              //                             LeadNewController>()
                              //                         .getisSelectedcomeas ==
                              //                     'Family'
                              //                 ? theme.primaryColor
                              //                 : Colors.white,
                              //             border: Border.all(
                              //                 color: theme.primaryColor,
                              //                 width: 1),
                              //             borderRadius:
                              //                 BorderRadius.circular(10)),
                              //         child: Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           children: [
                              //             Text("Family",
                              //                 maxLines: 8,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 style: theme.textTheme.bodyText1
                              //                     ?.copyWith(
                              //                   color: context
                              //                               .watch<
                              //                                   LeadNewController>()
                              //                               .getisSelectedcomeas ==
                              //                           "Family"
                              //                       ? Colors.white
                              //                       : theme.primaryColor,
                              //                 ))
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     InkWell(
                              //       onTap: () {
                              //         context
                              //             .read<LeadNewController>()
                              //             .selectComeas("Individual");
                              //       },
                              //       child: Container(
                              //         width: Screens.width(context) * 0.29,
                              //         height:
                              //             Screens.bodyheight(context) * 0.06,
                              //         //  padding: EdgeInsets.all(10),
                              //         decoration: BoxDecoration(
                              //             color: context
                              //                         .watch<
                              //                             LeadNewController>()
                              //                         .getisSelectedcomeas ==
                              //                     'Individual'
                              //                 ? theme.primaryColor
                              //                 : Colors.white,
                              //             border: Border.all(
                              //                 color: theme.primaryColor,
                              //                 width: 1),
                              //             borderRadius:
                              //                 BorderRadius.circular(10)),
                              //         child: Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           children: [
                              //             Text("Individual",
                              //                 maxLines: 8,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 style: theme.textTheme.bodyText1
                              //                     ?.copyWith(
                              //                   color: context
                              //                               .watch<
                              //                                   LeadNewController>()
                              //                               .getisSelectedcomeas ==
                              //                           "Individual"
                              //                       ? Colors.white
                              //                       : theme.primaryColor,
                              //                 ))
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     InkWell(
                              //       onTap: () {
                              //         context
                              //             .read<LeadNewController>()
                              //             .selectComeas("Friends");
                              //       },
                              //       child: Container(
                              //         width: Screens.width(context) * 0.29,
                              //         height:
                              //             Screens.bodyheight(context) * 0.06,
                              //         //  padding: EdgeInsets.all(10),
                              //         decoration: BoxDecoration(
                              //             color: context
                              //                         .watch<
                              //                             LeadNewController>()
                              //                         .getisSelectedcomeas ==
                              //                     'Friends'
                              //                 ? theme.primaryColor
                              //                 : Colors.white,
                              //             border: Border.all(
                              //                 color: theme.primaryColor,
                              //                 width: 1),
                              //             borderRadius:
                              //                 BorderRadius.circular(10)),
                              //         child: Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           children: [
                              //             Text("Friends",
                              //                 maxLines: 8,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 style: theme.textTheme.bodyText1
                              //                     ?.copyWith(
                              //                   color: context
                              //                               .watch<
                              //                                   LeadNewController>()
                              //                               .getisSelectedcomeas ==
                              //                           "Friends"
                              //                       ? Colors.white
                              //                       : theme.primaryColor,
                              //                 ))
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: Screens.bodyheight(context) * 0.01,
                              // ),
                              // InkWell(
                              //   onTap: () {
                              //     context
                              //         .read<LeadNewController>()
                              //         .selectComeas("Corporate");
                              //   },
                              //   child: Container(
                              //     width: Screens.width(context) * 0.29,
                              //     height: Screens.bodyheight(context) * 0.06,
                              //     //  padding: EdgeInsets.all(10),
                              //     decoration: BoxDecoration(
                              //         color: context
                              //                     .watch<LeadNewController>()
                              //                     .getisSelectedcomeas ==
                              //                 'Corporate'
                              //             ? theme.primaryColor
                              //             : Colors.white,
                              //         border: Border.all(
                              //             color: theme.primaryColor, width: 1),
                              //         borderRadius: BorderRadius.circular(10)),
                              //     child: Column(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         Text("Corporate",
                              //             maxLines: 8,
                              //             overflow: TextOverflow.ellipsis,
                              //             style: theme.textTheme.bodyText1
                              //                 ?.copyWith(
                              //               color: context
                              //                           .watch<
                              //                               LeadNewController>()
                              //                           .getisSelectedcomeas ==
                              //                       "Corporate"
                              //                   ? Colors.white
                              //                   : theme.primaryColor,
                              //             ))
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          // SizedBox(
                          //   height: Screens.bodyheight(context) * 0.01,
                          // ),
                          //  Container(
                          //   width: Screens.width(context),

                          //   // height:Screens.bodyheight(context)*0.28 ,
                          //   decoration: BoxDecoration(
                          //       color: theme.primaryColor,
                          //       borderRadius: BorderRadius.circular(8)),
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: Screens.width(context) * 0.02,
                          //       vertical: Screens.bodyheight(context) * 0.01),

                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       //time date

                          //       //Reminder
                          //       Text(
                          //         "Reminder On",
                          //         style: theme.textTheme.bodyText1
                          //             ?.copyWith(color: Colors.white),
                          //       ),

                          //       SizedBox(
                          //         height: Screens.padingHeight(context) * 0.01,
                          //       ),
                          //       Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Container(
                          //             height: context
                          //                         .read<LeadNewController>()
                          //                         .Datebool ==
                          //                     false
                          //                 ? Screens.bodyheight(context) * 0.075
                          //                 : null,
                          //             // height: cashHeight * 0.2,
                          //             width: Screens.width(context) * 0.5,
                          //             decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(8),
                          //               color: Colors.grey.withOpacity(0.01),
                          //             ),
                          //             // child: GestureDetector(
                          //             //   onTap: () {
                          //             //     st(() {
                          //             //       posC.getDate(context, 'Cheque');
                          //             //     });
                          //             //   },
                          //             child: TextFormField(
                          //               controller: context
                          //                   .read<LeadNewController>()
                          //                   .mycontroller[16],
                          //               // decoration: InputDecoration(
                          //               //   filled:
                          //               //       true, //<-- SEE HERE
                          //               //   fillColor: Colors
                          //               //       .white, //<-- SEE HERE
                          //               // ),
                          //               onTap: () {
                          //                 setState(() {
                          //                   context
                          //                       .read<LeadNewController>()
                          //                       .clearbool();
                          //                   context
                          //                       .read<LeadNewController>()
                          //                       .getDate2(context);
                          //                 });
                          //               },
                          //               autofocus: true,
                          //               readOnly: true,
                          //               // controller: posC.mycontroller[24],
                          //               cursorColor: Colors.grey,
                          //               style: theme.textTheme.bodyText2
                          //                   ?.copyWith(
                          //                       backgroundColor: Colors.white),
                          //               onChanged: (v) {},
                          //               validator: context
                          //                           .read<LeadNewController>()
                          //                           .mycontroller[16]
                          //                           .text
                          //                           .isEmpty &&
                          //                       context
                          //                           .read<LeadNewController>()
                          //                           .mycontroller[17]
                          //                           .text
                          //                           .isEmpty
                          //                   ? null
                          //                   : (value) {
                          //                       if (value!.isEmpty &&
                          //                           context
                          //                                   .read<
                          //                                       LeadNewController>()
                          //                                   .Datebool ==
                          //                               false) {
                          //                         setState(() {
                          //                           context
                          //                               .read<
                          //                                   LeadNewController>()
                          //                               .Datebool = true;
                          //                         });

                          //                         return 'Please Enter Date';
                          //                       } else if (value.isNotEmpty) {
                          //                         setState(() {
                          //                           context
                          //                               .read<
                          //                                   LeadNewController>()
                          //                               .Datebool = false;
                          //                         });

                          //                         return null;
                          //                       }
                          //                     },
                          //               decoration: InputDecoration(
                          //                 fillColor: Colors.white,
                          //                 suffixIcon: IconButton(
                          //                     padding: EdgeInsets.only(
                          //                         top: Screens.bodyheight(
                          //                                 context) *
                          //                             0.002),
                          //                     onPressed: () {
                          //                       context
                          //                           .read<LeadNewController>()
                          //                           .getDate2(context);
                          //                     },
                          //                     icon: Icon(
                          //                       Icons.date_range,
                          //                       color: theme.primaryColor,
                          //                     )),
                          //                 filled: true,
                          //                 focusedErrorBorder:
                          //                     OutlineInputBorder(
                          //                   borderRadius:
                          //                       BorderRadius.circular(5),
                          //                   borderSide:
                          //                       BorderSide(color: Colors.red),
                          //                 ),
                          //                 errorBorder: OutlineInputBorder(
                          //                   borderRadius:
                          //                       BorderRadius.circular(5),
                          //                   borderSide:
                          //                       BorderSide(color: Colors.red),
                          //                 ),
                          //                 enabledBorder: OutlineInputBorder(
                          //                   borderRadius:
                          //                       BorderRadius.circular(5),
                          //                   borderSide:
                          //                       BorderSide(color: Colors.grey),
                          //                 ),
                          //                 focusedBorder: OutlineInputBorder(
                          //                   borderRadius:
                          //                       BorderRadius.circular(5),
                          //                   borderSide:
                          //                       BorderSide(color: Colors.grey),
                          //                 ),
                          //                 contentPadding:
                          //                     const EdgeInsets.symmetric(
                          //                   vertical: 11,
                          //                   horizontal: 10,
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //           Container(
                          //             height: context
                          //                         .read<LeadNewController>()
                          //                         .timebool ==
                          //                     false
                          //                 ? Screens.bodyheight(context) * 0.075
                          //                 : null,
                          //             // height: cashHeight * 0.2,
                          //             width: Screens.width(context) * 0.37,
                          //             decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(8),
                          //               // color: Colors.grey
                          //               //     .withOpacity(0.01),
                          //             ),
                          //             // child: GestureDetector(
                          //             //   onTap: () {
                          //             //     st(() {
                          //             //       posC.getDate(context, 'Cheque');
                          //             //     });
                          //             //   },
                          //             child: TextFormField(
                          //               controller: context
                          //                   .read<LeadNewController>()
                          //                   .mycontroller[17],

                          //               onTap: () {
                          //                 setState(() {
                          //                   context
                          //                       .read<LeadNewController>()
                          //                       .clearbool();
                          //                   context
                          //                       .read<LeadNewController>()
                          //                       .selectTime2(context);
                          //                 });
                          //               },
                          //               autofocus: true,
                          //               readOnly: true,
                          //               // controller: posC.mycontroller[24],
                          //               cursorColor: Colors.grey,
                          //               style: theme.textTheme.bodyText2
                          //                   ?.copyWith(
                          //                       backgroundColor: Colors.white),
                          //               onChanged: (v) {},
                          //               validator: context
                          //                           .read<LeadNewController>()
                          //                           .mycontroller[16]
                          //                           .text
                          //                           .isEmpty &&
                          //                       context
                          //                           .read<LeadNewController>()
                          //                           .mycontroller[17]
                          //                           .text
                          //                           .isEmpty
                          //                   ? null
                          //                   : (value) {
                          //                       if (value!.isEmpty &&
                          //                           context
                          //                                   .read<
                          //                                       LeadNewController>()
                          //                                   .timebool ==
                          //                               false) {
                          //                         setState(() {
                          //                           context
                          //                               .read<
                          //                                   LeadNewController>()
                          //                               .timebool = true;
                          //                         });

                          //                         return '  Please Enter the Time';
                          //                       } else if (value.isNotEmpty) {
                          //                         setState(() {
                          //                           context
                          //                               .read<
                          //                                   LeadNewController>()
                          //                               .timebool = false;
                          //                         });

                          //                         return null;
                          //                       }
                          //                     },
                          //               decoration: InputDecoration(
                          //                 fillColor: Colors.white,
                          //                 suffixIcon: IconButton(
                          //                     padding: EdgeInsets.only(
                          //                         top: Screens.bodyheight(
                          //                                 context) *
                          //                             0.002),
                          //                     onPressed: () {
                          //                       setState(() {
                          //                         context
                          //                             .read<LeadNewController>()
                          //                             .selectTime2(context);
                          //                       });
                          //                     },
                          //                     icon: Icon(
                          //                       Icons.timer,
                          //                       color: theme.primaryColor,
                          //                     )),
                          //                 filled: true,
                          //                 focusedErrorBorder:
                          //                     OutlineInputBorder(
                          //                   borderRadius:
                          //                       BorderRadius.circular(5),
                          //                   borderSide:
                          //                       BorderSide(color: Colors.red),
                          //                 ),
                          //                 errorBorder: OutlineInputBorder(
                          //                   borderRadius:
                          //                       BorderRadius.circular(5),
                          //                   borderSide:
                          //                       BorderSide(color: Colors.red),
                          //                 ),
                          //                 enabledBorder: OutlineInputBorder(
                          //                   borderRadius:
                          //                       BorderRadius.circular(5),
                          //                   borderSide:
                          //                       BorderSide(color: Colors.grey),
                          //                 ),
                          //                 focusedBorder: OutlineInputBorder(
                          //                   borderRadius:
                          //                       BorderRadius.circular(5),
                          //                   borderSide:
                          //                       BorderSide(color: Colors.grey),
                          //                 ),
                          //                 contentPadding:
                          //                     const EdgeInsets.symmetric(
                          //                   vertical: 11,
                          //                   horizontal: 10,
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: Screens.bodyheight(context) * 0.01,
                          ),
                          //nextbtn
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
                                        .read<LeadNewController>()
                                        .firstPageNextBtn(context);
                                    log("oldcutomer: " +
                                        context
                                            .read<LeadNewController>()
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

  List<Widget> listContainersRefferes(
    ThemeData theme,
  ) {
    return List.generate(
      context.read<LeadNewController>().getenqReffList.length,
      (index) => InkWell(
        onTap: () {
          // context.read<LeadNewController>(). isSelectedenquirytype = context.read<LeadNewController>()
          // .getenqReffList[index].Name.toString();
          context.read<LeadNewController>().selectEnqReffers(
              context
                  .read<LeadNewController>()
                  .getenqReffList[index]
                  .Name
                  .toString(),
              context.read<LeadNewController>().getenqReffList[index].Name!,
              context
                  .read<LeadNewController>()
                  .getenqReffList[index]
                  .Code!
                  .toString());
        },
        child: Container(
          width: Screens.width(context) * 0.4,
          height: Screens.bodyheight(context) * 0.06,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context.read<LeadNewController>().isSelectedrefcode ==
                      context
                          .read<LeadNewController>()
                          .getenqReffList[index]
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
                      .read<LeadNewController>()
                      .getenqReffList[index]
                      .Name
                      .toString(),
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyText1?.copyWith(
                    color: context
                                .read<LeadNewController>()
                                .getisSelectedenquiryReffers ==
                            context
                                .read<LeadNewController>()
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

  List<Widget> listContainersCustomerTag(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<LeadNewController>().getCusTagList.length,
      (index) => InkWell(
        onTap: () {
          // context.read<LeadNewController>(). isSelectedenquirytype = context.read<LeadNewController>()
          // .getenqReffList[index].Name.toString();
          context.read<LeadNewController>().selectCsTag(context
              .read<LeadNewController>()
              .getCusTagList[index]
              .Code
              .toString());
          // log(context.read<LeadNewController>().getisSelectedCsTag.toString());
          // log(context
          //     .read<LeadNewController>()
          //     .getCusTagList[index]
          //     .Name
          //     .toString());
        },
        child: Container(
          width: Screens.width(context) * 0.3,
          height: Screens.bodyheight(context) * 0.045,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context.watch<LeadNewController>().getisSelectedCsTag ==
                      context
                          .read<LeadNewController>()
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
                      .watch<LeadNewController>()
                      .getCusTagList[index]
                      .Name
                      .toString(),
                  maxLines: 8,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                    color:
                        context.watch<LeadNewController>().getisSelectedCsTag ==
                                context
                                    .read<LeadNewController>()
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

  //age
  List<Widget> listContainersAgeTag(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<LeadNewController>().ageData.length,
      (index) => InkWell(
        onTap: () {
          // context.read<LeadNewController>(). isSelectedenquirytype = context.read<LeadNewController>()
          // .getenqReffList[index].Name.toString();
          context.read<LeadNewController>().selectage(context
              .read<LeadNewController>()
              .ageData[index]
              .description
              .toString());
          log(context.read<LeadNewController>().getisSelectedAge.toString());
          // log(context
          //     .read<LeadNewController>()
          //     .ageData[index]
          //     .description
          //     .toString()
          //     );
        },
        child: Container(
          width: Screens.width(context) * 0.3,
          height: Screens.bodyheight(context) * 0.045,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context.watch<LeadNewController>().getisSelectedAge ==
                      context
                          .read<LeadNewController>()
                          .ageData[index]
                          .description
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
                      .watch<LeadNewController>()
                      .ageData[index]
                      .description
                      .toString(),
                  maxLines: 8,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                    color:
                        context.watch<LeadNewController>().getisSelectedAge ==
                                context
                                    .read<LeadNewController>()
                                    .ageData[index]
                                    .description
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

  //gender
  List<Widget> listContainersGenderTag(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<LeadNewController>().genderData.length,
      (index) => InkWell(
        onTap: () {
          // context.read<LeadNewController>(). isSelectedenquirytype = context.read<LeadNewController>()
          // .getenqReffList[index].Name.toString();
          context.read<LeadNewController>().selectGender(context
              .read<LeadNewController>()
              .genderData[index]
              .description
              .toString());
          log(context.read<LeadNewController>().getisSelectedGender.toString());
          // log(context
          //     .read<LeadNewController>()
          //     .genderData[index]
          //     .Name
          //     .toString());
        },
        child: Container(
          width: Screens.width(context) * 0.3,
          height: Screens.bodyheight(context) * 0.045,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context.watch<LeadNewController>().getisSelectedGender ==
                      context
                          .read<LeadNewController>()
                          .genderData[index]
                          .description
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
                      .watch<LeadNewController>()
                      .genderData[index]
                      .description
                      .toString(),
                  maxLines: 8,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                    color: context
                                .watch<LeadNewController>()
                                .getisSelectedGender ==
                            context
                                .read<LeadNewController>()
                                .genderData[index]
                                .description
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

  //cameAs
  List<Widget> listContainersCamaAsTag(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<LeadNewController>().camaAsData.length,
      (index) => InkWell(
        onTap: () {
          // context.read<LeadNewController>(). isSelectedenquirytype = context.read<LeadNewController>()
          // .getenqReffList[index].Name.toString();
          context.read<LeadNewController>().selectComeas(context
              .read<LeadNewController>()
              .camaAsData[index]
              .description
              .toString());
          log(context.read<LeadNewController>().getisSelectedcomeas.toString());
          // log(context
          //     .read<LeadNewController>()
          //     .getCusTagList[index]
          //     .Name
          //     .toString());
        },
        child: Container(
          width: Screens.width(context) * 0.3,
          height: Screens.bodyheight(context) * 0.045,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context.watch<LeadNewController>().getisSelectedcomeas ==
                      context
                          .read<LeadNewController>()
                          .camaAsData[index]
                          .description
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
                      .watch<LeadNewController>()
                      .camaAsData[index]
                      .description
                      .toString(),
                  maxLines: 8,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    // fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: context
                                .watch<LeadNewController>()
                                .getisSelectedcomeas ==
                            context
                                .read<LeadNewController>()
                                .camaAsData[index]
                                .description
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
