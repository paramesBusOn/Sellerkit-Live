// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_new, prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings, sized_box_for_whitespace

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/AccountsController/NewCustomerController.dart';
import 'package:sellerkit/Pages/Accounts/widgets/ShowSearchDialog.dart';
import '../../Widgets/Appbar.dart';
import '../../Widgets/Navi3.dart';

class NewCustomerReg extends StatefulWidget {
  NewCustomerReg({Key? key}) : super(key: key);

  @override
  State<NewCustomerReg> createState() => NewCustomerRegState();
}

class NewCustomerRegState extends State<NewCustomerReg> {
   static bool iscomfromLead = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // context.read<NewCustomerContoller>().init();
       setState(() {
        //  context.read<NewCustomerContoller>().init();
        // log("  iscomfromLead;"+  iscomfromLead.toString());
        if (iscomfromLead == false) {
          log("ANBU222::");
         context.read<NewCustomerContoller>().init();
        } else if (iscomfromLead == true) {
          log("ANBU::");
          context.read<NewCustomerContoller>().checkComeFromEnq(context);

          iscomfromLead = false;
        }
      });
      // context.read<NewCustomerContoller>().getDataMethod();

      // print("sap user id: "+ConstantValues.sapUserID);

      // log("page on: "+context.read<NewCustomerContoller>().pageChanged.toString());
      // log("showItemList"+context.read<NewCustomerContoller>().showItemList.toString());
      //  log("oldcutomer: "+context.read<NewCustomerContoller>().oldcutomer.toString());
    });
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

    return Scaffold(        
        drawerEnableOpenDragGesture: false,
        // backgroundColor: Colors.grey[200],
        /// resizeToAvoidBottomInset: true,
        key: scaffoldKey1,
        appBar: appbar("New Customer", scaffoldKey1, theme, context),
        drawer: drawer3(context),
        body: SingleChildScrollView(
          child: GestureDetector(onHorizontalDragUpdate: (details) {
                    // Check if the user is swiping from left to right
                    print(details.primaryDelta);
                    if (details.primaryDelta! > ConstantValues.slidevalue!) {
                      setState(() {
                        Get.offAllNamed(ConstantRoutes.accounts);
                      });
                    }
                  },
            child:context.read<NewCustomerContoller>(). customerapicLoading==true?
            Center(child:CircularProgressIndicator()) 
            
            : Column(
              children: [
             Container(
                   color: Colors.white,
                  width: Screens.width(context),
                  height: Screens.bodyheight(context),
                  padding: EdgeInsets.symmetric(
                      horizontal: Screens.width(context) * 0.03,
                      vertical: Screens.bodyheight(context) * 0.02),
                  child: SingleChildScrollView(
                    child: Form(
                      key: context.read<NewCustomerContoller>().formkey[0],
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
                                        .read<NewCustomerContoller>()
                                        .mycontroller[0],
                                    focusNode: context
                                        .read<NewCustomerContoller>()
                                        .focusNode2,
                                        readOnly: context
                                        .watch<NewCustomerContoller>()
                                        .iscomeforupdate ==true?true:false,
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
                                            .read<NewCustomerContoller>()
                                            .mycontroller[0].text.length==10){
 context
                                                .read<NewCustomerContoller>()
                                                .callApi(context);
                                            }
                                         
                                        },
                                    onChanged: (v) {
                                      if (v.length == 10 &&
                                          context
                                                  .read<NewCustomerContoller>()
                                                  .getcustomerapicalled ==
                                              false) {
                                        context
                                            .read<NewCustomerContoller>()
                                            .callApi(context);
                                      } else if (v.length != 10) {
                                        context
                                            .read<NewCustomerContoller>()
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
                                        .read<NewCustomerContoller>()
                                        .mycontroller[16],
                                         readOnly: context
                                        .watch<NewCustomerContoller>()
                                        .iscomeforupdate ==true?true:false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter Customer";
                                      }
                                      return null;
                                    },
                                 onTap: () {
                                                    if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
                                    onChanged: (v) {
                                      // setState(() {
                                      //   context
                                      //       .read<NewCustomerContoller>()
                                      //       .filterListcustomer(v);
                                      //   if (v.isEmpty) {
                                      //     context
                                      //         .read<NewCustomerContoller>()
                                      //         .customerbool = false;
                                      //   } else {
                                      //     context
                                      //         .read<NewCustomerContoller>()
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
                                      .read<NewCustomerContoller>()
                                      .customerbool,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            Screens.bodyheight(context) * 0.01,
                                      ),
                                      context
                                              .read<NewCustomerContoller>()
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
                                                          NewCustomerContoller>()
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
                                                                  NewCustomerContoller>()
                                                              .customerbool = false;
                                                          context
                                                              .read<
                                                                  NewCustomerContoller>()
                                                              .getExiCustomerData(
                                                                  context
                                                                      .read<
                                                                          NewCustomerContoller>()
                                                                      .filterCustomerList[
                                                                          i]
                                                                      .cardname
                                                                      .toString(),
                                                                  context
                                                                      .read<
                                                                          NewCustomerContoller>()
                                                                      .filterCustomerList[
                                                                          i]
                                                                      .cardcode
                                                                      .toString());
                                                          context
                                                                  .read<
                                                                      NewCustomerContoller>()
                                                                  .mycontroller[16]
                                                                  .text =
                                                              context
                                                                  .read<
                                                                      NewCustomerContoller>()
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
                                                              "${context.watch<NewCustomerContoller>().filterCustomerList[i].cardname}",
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
                                        .read<NewCustomerContoller>()
                                        .mycontroller[1],
                                        onTap: () {
                                                    if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
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
                                        .read<NewCustomerContoller>()
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
                                        .read<NewCustomerContoller>()
                                        .mycontroller[7],
                                        onTap: () {
                                                    if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
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
                                        .read<NewCustomerContoller>()
                                        .mycontroller[25],
                                          inputFormatters: [
                                      // FilteringTextInputFormatter.digitsOnly,
                                      new LengthLimitingTextInputFormatter(15),
                                    ],
                                        onTap: () {
                                                    if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statebool2 = false;
                                                      });
                                                    }
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
//                                      
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
                                                .read<NewCustomerContoller>()
                                                .mycontroller[2],
                                                onTap: () {
                                                    if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
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
                                                .read<NewCustomerContoller>()
                                                .mycontroller[3],
                                                onTap: () {
                                                    if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
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
                                                          NewCustomerContoller>()
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
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
                                                  onChanged: (v) {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .filterListArea(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .areabool = false;
                                                      } else {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
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
                                                          NewCustomerContoller>()
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
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
                                                  onChanged: (v) {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .filterListCity(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .citybool = false;
                                                      } else {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
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
                                        //       .read<NewCustomerContoller>()
                                        //       .areabool,
                                        //   child: Column(
                                        //     children: [
                                        //       SizedBox(
                                        //         height:
                                        //             Screens.bodyheight(context) * 0.01,
                                        //       ),
                                        //       context
                                        //               .read<NewCustomerContoller>()
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
                                        //                           NewCustomerContoller>()
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
                                        //                                   NewCustomerContoller>()
                                        //                               .areabool = false;
                                        //                           context
                                        //                                   .read<
                                        //                                       NewCustomerContoller>()
                                        //                                   .mycontroller[17]
                                        //                                   .text =
                                        //                               context
                                        //                                   .read<
                                        //                                       NewCustomerContoller>()
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
                                        //                               "${context.watch<NewCustomerContoller>().filterCustomerList[i].area}",
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
                                        //       .read<NewCustomerContoller>()
                                        //       .citybool,
                                        //   child: Column(
                                        //     children: [
                                        //       SizedBox(
                                        //         height:
                                        //             Screens.bodyheight(context) * 0.01,
                                        //       ),
                                        //       context
                                        //               .read<NewCustomerContoller>()
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
                                        //                           NewCustomerContoller>()
                                        //                       .filterCustomerList
                                        //                       .length,
                                        //                   itemBuilder:
                                        //                       (BuildContext context,
                                        //                           int i) {
                                        //                     return InkWell(
                                        //                       onTap: () {
                                        //                         setState(() {
                                        //                           context.read<
                                        //                               NewCustomerContoller>();

                                        //                           context
                                        //                               .read<
                                        //                                   NewCustomerContoller>()
                                        //                               .citybool = false;
                                        //                           context
                                        //                                   .read<
                                        //                                       NewCustomerContoller>()
                                        //                                   .mycontroller[5]
                                        //                                   .text =
                                        //                               context
                                        //                                   .read<
                                        //                                       NewCustomerContoller>()
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
                                        //                               "${context.watch<NewCustomerContoller>().filterCustomerList[i].city}",
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
                                                          NewCustomerContoller>()
                                                      .mycontroller[4],
                                                  onTap: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
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
                                                              NewCustomerContoller>()
                                                          .filterListPincode(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .pincodebool = false;
                                                      } else {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .pincodebool = true;
                                                      }
                                                    });
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
                                                          NewCustomerContoller>()
                                                      .mycontroller[18],
                                                  focusNode: context
                                                      .read<
                                                          NewCustomerContoller>()
                                                      .focusNode1,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .always,
                                                  onChanged: (v) {
                                                    setState(() {
                                                       context
                                                          .read<
                                                              NewCustomerContoller>().  isText1Correct=false;
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .filterListState2(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
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
                                                                NewCustomerContoller>()
                                                            .methidstate(context
                                                                .read<
                                                                    NewCustomerContoller>()
                                                                .mycontroller[
                                                                    18]
                                                                .text,context);
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
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
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .methidstate(context
                                                              .read<
                                                                  NewCustomerContoller>()
                                                              .mycontroller[18]
                                                              .text,context);
                                                      FocusScope.of(context)
                                                          .requestFocus(context
                                                              .read<
                                                                  NewCustomerContoller>()
                                                              .focusNode1);
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .statebool = false;
                                                      return "Enter Correct State";
                                                    }
                                                    return null;
                                                  },
                                                  onEditingComplete: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .statebool = false;
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .focusNode1
                                                          .unfocus();
                                                      // context
                                                      //   .read<NewEnqController>()
                                                      //   .  methodfortest();
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .methidstate(context
                                                              .read<
                                                                  NewCustomerContoller>()
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
                                              .read<NewCustomerContoller>()
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
                                                          NewCustomerContoller>()
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
                                                                  NewCustomerContoller>()
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
                                                                          NewCustomerContoller>()
                                                                      .pincodebool = false;
                                                                  context.read<
                                                                      NewCustomerContoller>();

                                                                  context
                                                                          .read<
                                                                              NewCustomerContoller>()
                                                                          .mycontroller[
                                                                              4]
                                                                          .text =
                                                                      context
                                                                          .read<
                                                                              NewCustomerContoller>()
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
                                                                      "${context.watch<NewCustomerContoller>().filterCustomerList[i].zipcode}",
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
                                                    .read<NewCustomerContoller>()
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
                                                    .read<NewCustomerContoller>()
                                                    .value3,
                                                onChanged: (value) {
                                                  setState(() {
                                                    context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .converttoShipping(
                                                            value!);
                                                    context
                                                        .read<
                                                            NewCustomerContoller>()
                                                        .value3 = value;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextFormField(
                                            controller: context
                                                .read<NewCustomerContoller>()
                                                .mycontroller[19],
                                                onTap: () {
                                                    if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
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
                                                .read<NewCustomerContoller>()
                                                .mycontroller[20],
                                                onTap: () {
                                                    if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
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
                                                          NewCustomerContoller>()
                                                      .mycontroller[21],
                                                      onTap: () {
                                                    if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
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
                                                  //             NewCustomerContoller>()
                                                  //         .clearbool();
                                                  //   });
                                                  // },
                                                  onChanged: (v) {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .filterListArea(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .areabool = false;
                                                      } else {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
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
                                                          NewCustomerContoller>()
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
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[18]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statebool = false;
                                                      });
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .ontapvalid2(context);
                                                    } else if (context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .mycontroller[24]
                                                            .text
                                                            .isNotEmpty &&
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isNotEmpty) {
                                                      setState(() {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .statebool2 = false;
                                                      });
                                                    }
                                                  },
                                                  onChanged: (v) {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .filterListCity(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .citybool = false;
                                                      } else {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
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
                                              .read<NewCustomerContoller>()
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
                                                          NewCustomerContoller>()
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
                                                                  NewCustomerContoller>()
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
                                                                          NewCustomerContoller>()
                                                                      .areabool = false;
                                                                  context
                                                                          .read<
                                                                              NewCustomerContoller>()
                                                                          .mycontroller[
                                                                              21]
                                                                          .text =
                                                                      context
                                                                          .read<
                                                                              NewCustomerContoller>()
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
                                                                      "${context.watch<NewCustomerContoller>().filterCustomerList[i].area}",
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
                                              .read<NewCustomerContoller>()
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
                                                          NewCustomerContoller>()
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
                                                                  NewCustomerContoller>()
                                                              .filterCustomerList
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext context,
                                                                  int i) {
                                                            return InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  context.read<
                                                                      NewCustomerContoller>();

                                                                  context
                                                                      .read<
                                                                          NewCustomerContoller>()
                                                                      .citybool = false;
                                                                  context
                                                                          .read<
                                                                              NewCustomerContoller>()
                                                                          .mycontroller[
                                                                              22]
                                                                          .text =
                                                                      context
                                                                          .read<
                                                                              NewCustomerContoller>()
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
                                                                      "${context.watch<NewCustomerContoller>().filterCustomerList[i].city}",
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
                                                          NewCustomerContoller>()
                                                      .mycontroller[23],
                                                  onTap: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
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
                                                              NewCustomerContoller>()
                                                          .filterListPincode(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .pincodebool = false;
                                                      } else {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
                                                            .pincodebool = true;
                                                      }
                                                    });
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
                                                          NewCustomerContoller>()
                                                      .mycontroller[24],
                                                  focusNode: context
                                                      .read<
                                                          NewCustomerContoller>()
                                                      .focusNode3,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .always,
                                                  onChanged: (v) {
                                                    setState(() {
                                                       context
                                                          .read<
                                                              NewCustomerContoller>() . isText1Correct2=false;
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .filterListState2(v);
                                                      if (v.isEmpty) {
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
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
                                                                NewCustomerContoller>()
                                                            .methidstate2(context
                                                                .read<
                                                                    NewCustomerContoller>()
                                                                .mycontroller[
                                                                    24]
                                                                .text);
                                                        context
                                                            .read<
                                                                NewCustomerContoller>()
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
                                                                NewCustomerContoller>()
                                                            .statecode2
                                                            .isEmpty) {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .methidstate2(context
                                                              .read<
                                                                  NewCustomerContoller>()
                                                              .mycontroller[24]
                                                              .text);
                                                      FocusScope.of(context)
                                                          .requestFocus(context
                                                              .read<
                                                                  NewCustomerContoller>()
                                                              .focusNode3);
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .statebool2 = false;
                                                      return "Enter Correct State";
                                                    }
                                                    return null;
                                                  },
                                                  onEditingComplete: () {
                                                    setState(() {
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .statebool2 = false;
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .focusNode3
                                                          .unfocus();
                                                      // context
                                                      //   .read<NewEnqController>()
                                                      //   .  methodfortest();
                                                      context
                                                          .read<
                                                              NewCustomerContoller>()
                                                          .methidstate2(context
                                                              .read<
                                                                  NewCustomerContoller>()
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
                                                    .read<NewCustomerContoller>()
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
                                              .read<NewCustomerContoller>()
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
                                                          NewCustomerContoller>()
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
                                                                  NewCustomerContoller>()
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
                                                              "${context.watch<NewCustomerContoller>().filterstateData[i].stateName}",
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
                                    .read<NewCustomerContoller>()
                                    .statebool,
                                child: Positioned(
                                    top: Screens.bodyheight(context) * 0.35,
                                    left: Screens.width(context) * 0.45,
                                    child: Container(
                                      width: Screens.width(context) * 0.8,
                                      // height: Screens.bodyheight(context)*0.05,
                                      color: Colors.white,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: context
                                              .read<NewCustomerContoller>()
                                              .filterstateData
                                              .length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  context
                                                      .read<
                                                          NewCustomerContoller>()
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
                                                      "${context.watch<NewCustomerContoller>().filterstateData[i].stateName}",
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
                          //         .read<NewCustomerContoller>()
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
                          //         .read<NewCustomerContoller>()
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
                          //                   .read<NewCustomerContoller>()
                          //                   .validateGender ==
                          //               true
                          //           ? "Gender *"
                          //           : "Gender",
                          //       style: context
                          //                   .read<NewCustomerContoller>()
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
                          //                 .read<NewCustomerContoller>()
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
                          //                                 NewCustomerContoller>()
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
                          //                                       NewCustomerContoller>()
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
                          //                 .read<NewCustomerContoller>()
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
                          //                                 NewCustomerContoller>()
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
                          //                                       NewCustomerContoller>()
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
                          //                 .read<NewCustomerContoller>()
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
                          //                                 NewCustomerContoller>()
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
                          //                                       NewCustomerContoller>()
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
                          //       context.read<NewCustomerContoller>().validateAge ==
                          //               true
                          //           ? "Age Group *"
                          //           : "Age Group",
                          //       style: context
                          //                   .read<NewCustomerContoller>()
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
                          //                 .read<NewCustomerContoller>()
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
                          //                                 NewCustomerContoller>()
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
                          //                                       NewCustomerContoller>()
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
                          //                 .read<NewCustomerContoller>()
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
                          //                                 NewCustomerContoller>()
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
                          //                                       NewCustomerContoller>()
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
                          //                 .read<NewCustomerContoller>()
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
                          //                                 NewCustomerContoller>()
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
                          //                                       NewCustomerContoller>()
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
                          //             .read<NewCustomerContoller>()
                          //             .selectage("50>");
                          //       },
                          //       child: Container(
                          //         width: Screens.width(context) * 0.29,
                          //         height: Screens.bodyheight(context) * 0.06,
                          //         //  padding: EdgeInsets.all(10),
                          //         decoration: BoxDecoration(
                          //             color: context
                          //                         .watch<NewCustomerContoller>()
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
                          //                                   NewCustomerContoller>()
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
                          //                   .read<NewCustomerContoller>()
                          //                   .validateComas ==
                          //               true
                          //           ? "Came as *"
                          //           : "Came as",
                          //       style: context
                          //                   .read<NewCustomerContoller>()
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
                          //                 .read<NewCustomerContoller>()
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
                          //                                 NewCustomerContoller>()
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
                          //                                       NewCustomerContoller>()
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
                          //                 .read<NewCustomerContoller>()
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
                          //                                 NewCustomerContoller>()
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
                          //                                       NewCustomerContoller>()
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
                          //                 .read<NewCustomerContoller>()
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
                          //                                 NewCustomerContoller>()
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
                          //                                       NewCustomerContoller>()
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
                          //             .read<NewCustomerContoller>()
                          //             .selectComeas("Corporate");
                          //       },
                          //       child: Container(
                          //         width: Screens.width(context) * 0.29,
                          //         height: Screens.bodyheight(context) * 0.06,
                          //         //  padding: EdgeInsets.all(10),
                          //         decoration: BoxDecoration(
                          //             color: context
                          //                         .watch<NewCustomerContoller>()
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
                          //                                   NewCustomerContoller>()
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
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: Screens.width(context) ,
                              height: Screens.bodyheight(context) * 0.07,
                              child: ElevatedButton(
                                  onPressed: () {
                                    // provi.pageController.animateToPage(++provi.pageChanged,
                                    //     duration: Duration(milliseconds: 250),
                                    //     curve: Curves.bounceIn);
                                    context
                                        .read<NewCustomerContoller>()
                                        .firstPageNextBtn(context);
                                    log("oldcutomer: " +
                                        context
                                            .read<NewCustomerContoller>()
                                            .oldcutomer
                                            .toString());
                                  },
                                  child:Text("Submit")),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
             
                // Container(
                //   //  color: Colors.red,
                //   width: Screens.width(context),
                //   height: Screens.bodyheight(context),
                //   padding: EdgeInsets.symmetric(
                //       horizontal: Screens.width(context) * 0.03,
                //       vertical: Screens.bodyheight(context) * 0.02),
                //   child: SingleChildScrollView(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Form(
                //           key: context.read<NewCustomerContoller>().formkey[0],
                //           child: AnimatedContainer(
                //             duration: Duration(milliseconds: 500),
                //             curve: Curves.linear,
                //             height: context
                //                         .read<NewCustomerContoller>()
                //                         .custInfobool ==
                //                     true
                //                 ? Screens.bodyheight(context) * 0.09
                //                 : Screens.bodyheight(context) * 0.74,
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: Screens.width(context) * 0.03,
                //                 vertical: Screens.bodyheight(context) * 0.008),
                //             width: Screens.width(context),
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(8),
                //                 border: Border.all(color: theme.primaryColor)),
                //             child: context
                //                         .read<NewCustomerContoller>()
                //                         .custInfobool ==
                //                     true
                //                 ? Column(children: [
                //                     InkWell(
                //                       onTap: () {
                //                         setState(() {
                //                           context
                //                               .read<NewCustomerContoller>()
                //                               .customerDropDown();
                //                         });
                //                       },
                //                       child: Container(
                //                         // width: Screens.width(context),
                //                         height:
                //                             Screens.bodyheight(context) * 0.06,
                //                         child: Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             Container(
                //                               width: Screens.width(context) * 0.5,
                //                               child: Text(
                //                                 "Customer Info",
                //                                 style: theme.textTheme.titleLarge!
                //                                     .copyWith(
                //                                   fontWeight: FontWeight.bold,
                //                                 ),
                //                               ),
                //                             ),
                //                             Container(
                //                               alignment: Alignment.centerRight,
                //                               width: Screens.width(context) * 0.1,
                //                               child: IconButton(
                //                                   padding: EdgeInsets.all(0),
                //                                   onPressed: () {
                //                                     context
                //                                         .read<
                //                                             NewCustomerContoller>()
                //                                         .customerDropDown();
                //                                   },
                //                                   iconSize: 30,
                //                                   icon: Icon(
                //                                       Icons.arrow_drop_down,
                //                                       color: Colors.black)),
                //                             )
                //                           ],
                //                         ),
                //                       ),
                //                     ),
                //                   ])
                //                 : Stack(
                //                     children: [
                //                       SingleChildScrollView(
                //                         child: Column(
                //                           children: [
                //                             SizedBox(
                //                               height:
                //                                   Screens.bodyheight(context) *
                //                                       0.06,
                //                             ),
                //                             TextFormField(
                //                                 controller: context
                //                                     .read<NewCustomerContoller>()
                //                                     .mycontroller[0],
                //                                 validator: (value) {
                //                                   if (value!.isEmpty) {
                //                                     return "Enter Customer Name";
                //                                   }
                //                                   return null;
                //                                 },
                //                                 onTap: () {},
                //                                 onChanged: (v) {},
                //                                 decoration: InputDecoration(
                //                                   labelText: 'Company Name',
                //                                   border: UnderlineInputBorder(),
                //                                   labelStyle: theme
                //                                       .textTheme.bodyText1!
                //                                       .copyWith(
                //                                           color: Colors.grey),
                //                                   enabledBorder:
                //                                       UnderlineInputBorder(
                //                                     borderSide: BorderSide(
                //                                         color: Colors.grey),
                //                                     //  when the TextFormField in unfocused
                //                                   ),
                //                                   focusedBorder:
                //                                       UnderlineInputBorder(
                //                                     borderSide: BorderSide(
                //                                         color: Colors.grey),
                //                                     //  when the TextFormField in focused
                //                                   ),
                //                                   errorBorder:
                //                                       UnderlineInputBorder(),
                //                                   focusedErrorBorder:
                //                                       UnderlineInputBorder(),
                //                                 )),
                //                             TextFormField(
                //                                 controller: context
                //                                     .read<NewCustomerContoller>()
                //                                     .mycontroller[1],
                //                                 validator: (value) {
                //                                   if (value!.isEmpty) {
                //                                     return "Enter Contact Name";
                //                                   }
                //                                   return null;
                //                                 },
                //                                 decoration: InputDecoration(
                //                                   labelText: 'Contact Name',
                //                                   labelStyle: theme
                //                                       .textTheme.bodyText1!
                //                                       .copyWith(
                //                                           color: Colors.grey),
                //                                   enabledBorder:
                //                                       UnderlineInputBorder(
                //                                     borderSide: BorderSide(
                //                                         color: Colors.grey),
                //                                     //  when the TextFormField in unfocused
                //                                   ),
                //                                   focusedBorder:
                //                                       UnderlineInputBorder(
                //                                     borderSide: BorderSide(
                //                                         color: Colors.grey),
                //                                     //  when the TextFormField in focused
                //                                   ),
                //                                   border: UnderlineInputBorder(),
                //                                   // enabledBorder: UnderlineInputBorder(),
                //                                   // focusedBorder: UnderlineInputBorder(),
                //                                   errorBorder:
                //                                       UnderlineInputBorder(),
                //                                   focusedErrorBorder:
                //                                       UnderlineInputBorder(),
                //                                 )),
                //                             TextFormField(
                //                                 controller: context
                //                                     .read<NewCustomerContoller>()
                //                                     .mycontroller[2],
                //                                 validator: (value) {
                //                                   if (value!.isEmpty) {
                //                                     return "Enter Mobile Number";
                //                                   } else if (value.length > 10 ||
                //                                       value.length < 10) {
                //                                     return "Enter a valid Mobile Number";
                //                                   }
                //                                   return null;
                //                                 },
                //                                 onChanged: (v) {},
                //                                 inputFormatters: [
                //                                   new LengthLimitingTextInputFormatter(
                //                                       10),
                //                                 ],
                //                                 keyboardType:
                //                                     TextInputType.number,
                //                                 decoration: InputDecoration(
                //                                   labelText: 'Mobile',
                //                                   labelStyle: theme
                //                                       .textTheme.bodyText1!
                //                                       .copyWith(
                //                                           color: Colors.grey),
                //                                   enabledBorder:
                //                                       UnderlineInputBorder(
                //                                     borderSide: BorderSide(
                //                                         color: Colors.grey),
                //                                     //  when the TextFormField in unfocused
                //                                   ),
                //                                   focusedBorder:
                //                                       UnderlineInputBorder(
                //                                     borderSide: BorderSide(
                //                                         color: Colors.grey),
                //                                     //  when the TextFormField in focused
                //                                   ),
                //                                   border: UnderlineInputBorder(),
                //                                   // enabledBorder: UnderlineInputBorder(),
                //                                   // focusedBorder: UnderlineInputBorder(),
                //                                   errorBorder:
                //                                       UnderlineInputBorder(),
                //                                   focusedErrorBorder:
                //                                       UnderlineInputBorder(),
                //                                 )),
                //                             TextFormField(
                //                                 controller: context
                //                                     .read<NewCustomerContoller>()
                //                                     .mycontroller[3],
                //                                 // validator: (value) {
                //                                 //   if (value!.isEmpty) {
                //                                 //     return "Enter Email";
                //                                 //   }else if(!value.contains("@")){
                //                                 //       return "Enter Valid Email";
                //                                 //   }
                //                                 //   return null;
                //                                 // },
                //                                 decoration: InputDecoration(
                //                                   labelText: 'Email',
                //                                   labelStyle: theme
                //                                       .textTheme.bodyText1!
                //                                       .copyWith(
                //                                           color: Colors.grey),
                //                                   enabledBorder:
                //                                       UnderlineInputBorder(
                //                                     borderSide: BorderSide(
                //                                         color: Colors.grey),
                //                                     //  when the TextFormField in unfocused
                //                                   ),
                //                                   focusedBorder:
                //                                       UnderlineInputBorder(
                //                                     borderSide: BorderSide(
                //                                         color: Colors.grey),
                //                                     //  when the TextFormField in focused
                //                                   ),
                //                                   border: UnderlineInputBorder(),
                //                                   // enabledBorder: UnderlineInputBorder(),
                //                                   // focusedBorder: UnderlineInputBorder(),
                //                                   errorBorder:
                //                                       UnderlineInputBorder(),
                //                                   focusedErrorBorder:
                //                                       UnderlineInputBorder(),
                //                                 )),
                //                             // TextFormField(
                //                             //     controller: context
                //                             //         .read<NewCustomerContoller>()
                //                             //         .mycontroller[4],
                //                             //     // validator: (value) {
                //                             //     //   if (value!.isEmpty) {
                //                             //     //     return "Enter Email";
                //                             //     //   }else if(!value.contains("@")){
                //                             //     //       return "Enter Valid Email";
                //                             //     //   }
                //                             //     //   return null;
                //                             //     // },
                //                             //     decoration: InputDecoration(
                //                             //       labelText: 'Landline',
                //                             //       labelStyle: theme
                //                             //           .textTheme.bodyText1!
                //                             //           .copyWith(
                //                             //               color: Colors.grey),
                //                             //       enabledBorder:
                //                             //           UnderlineInputBorder(
                //                             //         borderSide: BorderSide(
                //                             //             color: Colors.grey),
                //                             //         //  when the TextFormField in unfocused
                //                             //       ),
                //                             //       focusedBorder:
                //                             //           UnderlineInputBorder(
                //                             //         borderSide: BorderSide(
                //                             //             color: Colors.grey),
                //                             //         //  when the TextFormField in focused
                //                             //       ),
                //                             //       border: UnderlineInputBorder(),
                //                             //       // enabledBorder: UnderlineInputBorder(),
                //                             //       // focusedBorder: UnderlineInputBorder(),
                //                             //       errorBorder:
                //                             //           UnderlineInputBorder(),
                //                             //       focusedErrorBorder:
                //                             //           UnderlineInputBorder(),
                //                             //     )),
                //                             TextFormField(
                //                                 controller: context
                //                                     .read<NewCustomerContoller>()
                //                                     .mycontroller[5],
                //                                 // validator: (value) {
                //                                 //   if (value!.isEmpty) {
                //                                 //     return "Enter Email";
                //                                 //   }else if(!value.contains("@")){
                //                                 //       return "Enter Valid Email";
                //                                 //   }
                //                                 //   return null;
                //                                 // },
                //                                 decoration: InputDecoration(
                //                                   labelText: 'Alternate Mobile Number',
                //                                   labelStyle: theme
                //                                       .textTheme.bodyText1!
                //                                       .copyWith(
                //                                           color: Colors.grey),
                //                                   enabledBorder:
                //                                       UnderlineInputBorder(
                //                                     borderSide: BorderSide(
                //                                         color: Colors.grey),
                //                                     //  when the TextFormField in unfocused
                //                                   ),
                //                                   focusedBorder:
                //                                       UnderlineInputBorder(
                //                                     borderSide: BorderSide(
                //                                         color: Colors.grey),
                //                                     //  when the TextFormField in focused
                //                                   ),
                //                                   border: UnderlineInputBorder(),
                //                                   // enabledBorder: UnderlineInputBorder(),
                //                                   // focusedBorder: UnderlineInputBorder(),
                //                                   errorBorder:
                //                                       UnderlineInputBorder(),
                //                                   focusedErrorBorder:
                //                                       UnderlineInputBorder(),
                //                                 )),
                //                             TextFormField(
                //                                 controller: context
                //                                     .read<NewCustomerContoller>()
                //                                     .mycontroller[6],
                //                                 // validator: (value) {
                //                                 //   if (value!.isEmpty) {
                //                                 //     return "Enter Email";
                //                                 //   }else if(!value.contains("@")){
                //                                 //       return "Enter Valid Email";
                //                                 //   }
                //                                 //   return null;
                //                                 // },
                //                                 decoration: InputDecoration(
                //                                   labelText: 'GST No',
                //                                   labelStyle: theme
                //                                       .textTheme.bodyText1!
                //                                       .copyWith(
                //                                           color: Colors.grey),
                //                                   enabledBorder:
                //                                       UnderlineInputBorder(
                //                                     borderSide: BorderSide(
                //                                         color: Colors.grey),
                //                                     //  when the TextFormField in unfocused
                //                                   ),
                //                                   focusedBorder:
                //                                       UnderlineInputBorder(
                //                                     borderSide: BorderSide(
                //                                         color: Colors.grey),
                //                                     //  when the TextFormField in focused
                //                                   ),
                //                                   border: UnderlineInputBorder(),
                //                                   // enabledBorder: UnderlineInputBorder(),
                //                                   // focusedBorder: UnderlineInputBorder(),
                //                                   errorBorder:
                //                                       UnderlineInputBorder(),
                //                                   focusedErrorBorder:
                //                                       UnderlineInputBorder(),
                //                                 )),
                //                             SizedBox(
                //                               height:
                //                                   Screens.bodyheight(context) *
                //                                       0.01,
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                       Positioned(
                //                         top: 0,
                //                         child: InkWell(
                //                           onTap: () {
                //                             setState(() {
                //                               context
                //                                   .read<NewCustomerContoller>()
                //                                   .customerDropDown();
                //                             });
                //                           },
                //                           child: Container(
                //                             width: Screens.width(context) * 0.872,
                //                             height: Screens.bodyheight(context) *
                //                                 0.06,
                //                             color: Colors.white,
                //                             child: Row(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.spaceBetween,
                //                               children: [
                //                                 Container(
                //                                   width: Screens.width(context) *
                //                                       0.5,
                //                                   child: Text(
                //                                     "Customer Info",
                //                                     style: theme
                //                                         .textTheme.titleLarge!
                //                                         .copyWith(
                //                                       fontWeight: FontWeight.bold,
                //                                     ),
                //                                   ),
                //                                 ),
                //                                 Container(
                //                                   // color: Colors.black,
                //                                   alignment:
                //                                       Alignment.centerRight,
                //                                   width: Screens.width(context) *
                //                                       0.1,
                //                                   child: IconButton(
                //                                       padding: EdgeInsets.all(0),
                //                                       onPressed: () {
                //                                         context
                //                                             .read<
                //                                                 NewCustomerContoller>()
                //                                             .customerDropDown();
                //                                       },
                //                                       iconSize: 30,
                //                                       icon: Icon(
                //                                           Icons.arrow_drop_down,
                //                                           color: Colors.black)),
                //                                 )
                //                               ],
                //                             ),
                //                           ),
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //           ),
                //         ),
                //         SizedBox(
                //           height: Screens.bodyheight(context) * 0.015,
                //         ),
                //         //Office
                //         // Form(
                //         //   key: context.read<NewCustomerContoller>().formkey[1],
                //         //   child: AnimatedContainer(
                //         //     duration: Duration(milliseconds: 500),
                //         //     curve: Curves.linear,
                //         //     height: context
                //         //                 .read<NewCustomerContoller>()
                //         //                 .officeaddress ==
                //         //             true
                //         //         ? Screens.bodyheight(context) * 0.09
                //         //         : Screens.bodyheight(context) * 0.55,
                //         //     padding: EdgeInsets.symmetric(
                //         //         horizontal: Screens.width(context) * 0.03,
                //         //         vertical: Screens.bodyheight(context) * 0.008),
                //         //     width: Screens.width(context),
                //         //     decoration: BoxDecoration(
                //         //         borderRadius: BorderRadius.circular(8),
                //         //         border: Border.all(color: theme.primaryColor)),
                //         //     child: context
                //         //                 .read<NewCustomerContoller>()
                //         //                 .officeaddress ==
                //         //             true
                //         //         ? Column(children: [
                //         //             InkWell(
                //         //               onTap: () {
                //         //                 setState(() {
                //         //                   context
                //         //                       .read<NewCustomerContoller>()
                //         //                       .OfficeDropDown();
                //         //                 });
                //         //               },
                //         //               child: Container(
                //         //                 height:
                //         //                     Screens.bodyheight(context) * 0.06,
                //         //                 child: Row(
                //         //                   mainAxisAlignment:
                //         //                       MainAxisAlignment.spaceBetween,
                //         //                   children: [
                //         //                     Container(
                //         //                       width: Screens.width(context) * 0.5,
                //         //                       child: Text(
                //         //                         "Office Address",
                //         //                         style: theme.textTheme.titleLarge!
                //         //                             .copyWith(
                //         //                           fontWeight: FontWeight.bold,
                //         //                         ),
                //         //                       ),
                //         //                     ),
                //         //                     Container(
                //         //                       // color: Colors.amber,
                //         //                       alignment: Alignment.centerRight,
                //         //                       width: Screens.width(context) * 0.1,
                //         //                       child: IconButton(
                //         //                           padding: EdgeInsets.all(0),
                //         //                           onPressed: () {
                //         //                             context
                //         //                                 .read<
                //         //                                     NewCustomerContoller>()
                //         //                                 .OfficeDropDown();
                //         //                           },
                //         //                           iconSize: 30,
                //         //                           icon: Icon(
                //         //                               Icons.arrow_drop_down,
                //         //                               color: Colors.black)),
                //         //                     )
                //         //                   ],
                //         //                 ),
                //         //               ),
                //         //             ),
                //         //           ])
                //         //         : Stack(
                //         //             //  width: Screens.width(context)*0.875,
                //         //             //           height: Screens.bodyheight(context) *
                //         //             //               0.06,
                //         //             children: [
                //         //               SingleChildScrollView(
                //         //                 child: Column(
                //         //                   children: [
                //         //                     SizedBox(
                //         //                       height:
                //         //                           Screens.bodyheight(context) *
                //         //                               0.06,
                //         //                     ),
                //         //                     TextFormField(
                //         //                         controller: context
                //         //                             .read<NewCustomerContoller>()
                //         //                             .mycontroller1[0],
                //         //                         validator: (value) {
                //         //                           if (value!.isEmpty) {
                //         //                             return "Enter Address1";
                //         //                           }
                //         //                           return null;
                //         //                         },
                //         //                         decoration: InputDecoration(
                //         //                           labelText: 'Address1',
                //         //                           // fillColor: Colors.amber,
                //         //                           border: UnderlineInputBorder(),
                //         //                           labelStyle: theme
                //         //                               .textTheme.bodyText1!
                //         //                               .copyWith(
                //         //                                   color: Colors.grey),
                //         //                           enabledBorder:
                //         //                               UnderlineInputBorder(
                //         //                             borderSide: BorderSide(
                //         //                                 color: Colors.grey),
                //         //                             //  when the TextFormField in unfocused
                //         //                           ),
                //         //                           focusedBorder:
                //         //                               UnderlineInputBorder(
                //         //                             borderSide: BorderSide(
                //         //                                 color: Colors.grey),
                //         //                             //  when the TextFormField in focused
                //         //                           ),
                //         //                           errorBorder:
                //         //                               UnderlineInputBorder(),
                //         //                           focusedErrorBorder:
                //         //                               UnderlineInputBorder(),
                //         //                         )),
                //         //                     // SizedBox(
                //         //                     //   height: Screens.bodyheight(context) * 0.005,
                //         //                     // ),
                //         //                     TextFormField(
                //         //                         controller: context
                //         //                             .read<NewCustomerContoller>()
                //         //                             .mycontroller1[1],
                //         //                         // validator: (value) {
                //         //                         //   if (value!.isEmpty) {
                //         //                         //     return "Enter Address2";
                //         //                         //   }
                //         //                         //   return null;
                //         //                         // },
                //         //                         decoration: InputDecoration(
                //         //                           labelText: 'Address2',
                //         //                           border: UnderlineInputBorder(),
                //         //                           labelStyle: theme
                //         //                               .textTheme.bodyText1!
                //         //                               .copyWith(
                //         //                                   color: Colors.grey),
                //         //                           enabledBorder:
                //         //                               UnderlineInputBorder(
                //         //                             borderSide: BorderSide(
                //         //                                 color: Colors.grey),
                //         //                             //  when the TextFormField in unfocused
                //         //                           ),
                //         //                           focusedBorder:
                //         //                               UnderlineInputBorder(
                //         //                             borderSide: BorderSide(
                //         //                                 color: Colors.grey),
                //         //                             //  when the TextFormField in focused
                //         //                           ),
                //         //                           errorBorder:
                //         //                               UnderlineInputBorder(),
                //         //                           focusedErrorBorder:
                //         //                               UnderlineInputBorder(),
                //         //                         )),
                //         //                     // SizedBox(
                //         //                     //   height: Screens.bodyheight(context) * 0.005,
                //         //                     // ),
                //         //                     Row(
                //         //                       mainAxisAlignment:
                //         //                           MainAxisAlignment.spaceBetween,
                //         //                       children: [
                //         //                         SizedBox(
                //         //                           width: Screens.width(context) *
                //         //                               0.4,
                //         //                           child: TextFormField(
                //         //                               controller: context
                //         //                                   .read<
                //         //                                       NewCustomerContoller>()
                //         //                                   .mycontroller1[2],
                //         //                               validator: (value) {
                //         //                                 if (value!.isEmpty) {
                //         //                                   return "Enter Area";
                //         //                                 }
                //         //                                 return null;
                //         //                               },
                //         //                               onTap: () {
                //         //                                 setState(() {});
                //         //                               },
                //         //                               onChanged: (v) {
                //         //                                 setState(() {});
                //         //                               },
                //         //                               decoration: InputDecoration(
                //         //                                 labelText: 'Area',
                //         //                                 border:
                //         //                                     UnderlineInputBorder(),
                //         //                                 labelStyle: theme
                //         //                                     .textTheme.bodyText1!
                //         //                                     .copyWith(
                //         //                                         color:
                //         //                                             Colors.grey),
                //         //                                 enabledBorder:
                //         //                                     UnderlineInputBorder(
                //         //                                   borderSide: BorderSide(
                //         //                                       color: Colors.grey),
                //         //                                   //  when the TextFormField in unfocused
                //         //                                 ),
                //         //                                 focusedBorder:
                //         //                                     UnderlineInputBorder(
                //         //                                   borderSide: BorderSide(
                //         //                                       color: Colors.grey),
                //         //                                   //  when the TextFormField in focused
                //         //                                 ),
                //         //                                 errorBorder:
                //         //                                     UnderlineInputBorder(),
                //         //                                 focusedErrorBorder:
                //         //                                     UnderlineInputBorder(),
                //         //                               )),
                //         //                         ),
                //         //                         SizedBox(
                //         //                           width: Screens.width(context) *
                //         //                               0.4,
                //         //                           child: TextFormField(
                //         //                               controller: context
                //         //                                   .read<
                //         //                                       NewCustomerContoller>()
                //         //                                   .mycontroller1[3],
                //         //                               validator: (value) {
                //         //                                 if (value!.isEmpty) {
                //         //                                   return "Enter City";
                //         //                                 }
                //         //                                 return null;
                //         //                               },
                //         //                               onTap: () {
                //         //                                 setState(() {});
                //         //                               },
                //         //                               onChanged: (v) {
                //         //                                 setState(() {});
                //         //                               },
                //         //                               decoration: InputDecoration(
                //         //                                 labelText: 'City',
                //         //                                 border:
                //         //                                     UnderlineInputBorder(),
                //         //                                 labelStyle: theme
                //         //                                     .textTheme.bodyText1!
                //         //                                     .copyWith(
                //         //                                         color:
                //         //                                             Colors.grey),
                //         //                                 enabledBorder:
                //         //                                     UnderlineInputBorder(
                //         //                                   borderSide: BorderSide(
                //         //                                       color: Colors.grey),
                //         //                                   //  when the TextFormField in unfocused
                //         //                                 ),
                //         //                                 focusedBorder:
                //         //                                     UnderlineInputBorder(
                //         //                                   borderSide: BorderSide(
                //         //                                       color: Colors.grey),
                //         //                                   //  when the TextFormField in focused
                //         //                                 ),
                //         //                                 errorBorder:
                //         //                                     UnderlineInputBorder(),
                //         //                                 focusedErrorBorder:
                //         //                                     UnderlineInputBorder(),
                //         //                               )),
                //         //                         ),
                //         //                       ],
                //         //                     ),
          
                //         //                     Row(
                //         //                       mainAxisAlignment:
                //         //                           MainAxisAlignment.spaceBetween,
                //         //                       children: [
                //         //                         SizedBox(
                //         //                           width: Screens.width(context) *
                //         //                               0.4,
                //         //                           child: TextFormField(
                //         //                               controller: context
                //         //                                   .read<
                //         //                                       NewCustomerContoller>()
                //         //                                   .mycontroller1[4],
                //         //                               onTap: () {},
                //         //                               validator: (value) {
                //         //                                 if (value!.isEmpty) {
                //         //                                   return "Enter Pincode";
                //         //                                 }
                //         //                                 return null;
                //         //                               },
                //         //                               onChanged: (v) {
                //         //                                 setState(() {});
                //         //                               },
                //         //                               keyboardType:
                //         //                                   TextInputType.number,
                //         //                               inputFormatters: [
                //         //                                 new LengthLimitingTextInputFormatter(
                //         //                                     6),
                //         //                               ],
                //         //                               decoration: InputDecoration(
                //         //                                 labelText: 'Pincode',
                //         //                                 border:
                //         //                                     UnderlineInputBorder(),
                //         //                                 labelStyle: theme
                //         //                                     .textTheme.bodyText1!
                //         //                                     .copyWith(
                //         //                                         color:
                //         //                                             Colors.grey),
                //         //                                 enabledBorder:
                //         //                                     UnderlineInputBorder(
                //         //                                   borderSide: BorderSide(
                //         //                                       color: Colors.grey),
                //         //                                   //  when the TextFormField in unfocused
                //         //                                 ),
                //         //                                 focusedBorder:
                //         //                                     UnderlineInputBorder(
                //         //                                   borderSide: BorderSide(
                //         //                                       color: Colors.grey),
                //         //                                   //  when the TextFormField in focused
                //         //                                 ),
                //         //                                 errorBorder:
                //         //                                     UnderlineInputBorder(),
                //         //                                 focusedErrorBorder:
                //         //                                     UnderlineInputBorder(),
                //         //                               )),
                //         //                         ),
                //         //                         SizedBox(
                //         //                           width: Screens.width(context) *
                //         //                               0.4,
                //         //                           child: TextFormField(
                //         //                               controller: context
                //         //                                   .read<
                //         //                                       NewCustomerContoller>()
                //         //                                   .mycontroller1[5],
                //         //                               onTap: () {
                //         //                                 setState(() {});
                //         //                               },
                //         //                               validator: (value) {
                //         //                                 if (value!.isEmpty) {
                //         //                                   return "Enter State";
                //         //                                 }
                //         //                                 return null;
                //         //                               },
                //         //                               onChanged: (v) {
                //         //                                 setState(() {});
                //         //                               },
                //         //                               decoration: InputDecoration(
                //         //                                 labelText: 'State',
                //         //                                 border:
                //         //                                     UnderlineInputBorder(),
                //         //                                 labelStyle: theme
                //         //                                     .textTheme.bodyText1!
                //         //                                     .copyWith(
                //         //                                         color:
                //         //                                             Colors.grey),
                //         //                                 enabledBorder:
                //         //                                     UnderlineInputBorder(
                //         //                                   borderSide: BorderSide(
                //         //                                       color: Colors.grey),
                //         //                                   //  when the TextFormField in unfocused
                //         //                                 ),
                //         //                                 focusedBorder:
                //         //                                     UnderlineInputBorder(
                //         //                                   borderSide: BorderSide(
                //         //                                       color: Colors.grey),
                //         //                                   //  when the TextFormField in focused
                //         //                                 ),
                //         //                                 errorBorder:
                //         //                                     UnderlineInputBorder(),
                //         //                                 focusedErrorBorder:
                //         //                                     UnderlineInputBorder(),
                //         //                               )),
                //         //                         ),
                //         //                       ],
                //         //                     ),
                //         //                     Row(
                //         //                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         //                       children: [
                //         //                         SizedBox(
                //         //                           width: Screens.width(context) *
                //         //                               0.4,
                //         //                           child: TextFormField(
                //         //                               controller: context
                //         //                                   .read<
                //         //                                       NewCustomerContoller>()
                //         //                                   .mycontroller1[6],
                //         //                               onTap: () {},
                //         //                               // validator: (value) {
                //         //                               //   if (value!.isEmpty) {
                //         //                               //     return "Enter Pincode";
                //         //                               //   }
                //         //                               //   return null;
                //         //                               // },
                //         //                               onChanged: (v) {
                //         //                                 setState(() {});
                //         //                               },
                //         //                               keyboardType:
                //         //                                   TextInputType.number,
                //         //                               inputFormatters: [
                //         //                                 new LengthLimitingTextInputFormatter(
                //         //                                     6),
                //         //                               ],
                //         //                               decoration: InputDecoration(
                //         //                                 labelText: 'Latitude ',
                //         //                                 border:
                //         //                                     UnderlineInputBorder(),
                //         //                                 labelStyle: theme
                //         //                                     .textTheme.bodyText1!
                //         //                                     .copyWith(
                //         //                                         color:
                //         //                                             Colors.grey),
                //         //                                 enabledBorder:
                //         //                                     UnderlineInputBorder(
                //         //                                   borderSide: BorderSide(
                //         //                                       color: Colors.grey),
                //         //                                   //  when the TextFormField in unfocused
                //         //                                 ),
                //         //                                 focusedBorder:
                //         //                                     UnderlineInputBorder(
                //         //                                   borderSide: BorderSide(
                //         //                                       color: Colors.grey),
                //         //                                   //  when the TextFormField in focused
                //         //                                 ),
                //         //                                 errorBorder:
                //         //                                     UnderlineInputBorder(),
                //         //                                 focusedErrorBorder:
                //         //                                     UnderlineInputBorder(),
                //         //                               )),
                //         //                         ),
                //         //                         SizedBox(
                //         //                           width: Screens.width(context) *
                //         //                               0.075,
                //         //                         ),
                //         //                         SizedBox(
                //         //                           width: Screens.width(context) *
                //         //                               0.32,
                //         //                           child: TextFormField(
                //         //                               controller: context
                //         //                                   .read<
                //         //                                       NewCustomerContoller>()
                //         //                                   .mycontroller1[7],
                //         //                               onTap: () {
                //         //                                 setState(() {});
                //         //                               },
                //         //                               // validator: (value) {
                //         //                               //   if (value!.isEmpty) {
                //         //                               //     return "Longitude";
                //         //                               //   }
                //         //                               //   return null;
                //         //                               // },
                //         //                               onChanged: (v) {
                //         //                                 setState(() {});
                //         //                               },
                //         //                               decoration: InputDecoration(
                //         //                                 labelText: 'Longitude',
                //         //                                 border:
                //         //                                     UnderlineInputBorder(),
                //         //                                 labelStyle: theme
                //         //                                     .textTheme.bodyText1!
                //         //                                     .copyWith(
                //         //                                         color:
                //         //                                             Colors.grey),
                //         //                                 enabledBorder:
                //         //                                     UnderlineInputBorder(
                //         //                                   borderSide: BorderSide(
                //         //                                       color: Colors.grey),
                //         //                                   //  when the TextFormField in unfocused
                //         //                                 ),
                //         //                                 focusedBorder:
                //         //                                     UnderlineInputBorder(
                //         //                                   borderSide: BorderSide(
                //         //                                       color: Colors.grey),
                //         //                                   //  when the TextFormField in focused
                //         //                                 ),
                //         //                                 errorBorder:
                //         //                                     UnderlineInputBorder(),
                //         //                                 focusedErrorBorder:
                //         //                                     UnderlineInputBorder(),
                //         //                               )),
                //         //                         ),
                //         //                         Container(
                //         //                           width: Screens.width(context) *
                //         //                               0.05,
                //         //                           alignment:
                //         //                               Alignment.centerRight,
                //         //                           child: Switch(
                //         //                             activeColor:
                //         //                                 theme.primaryColor,
                //         //                             value: context
                //         //                                 .watch<
                //         //                                     NewCustomerContoller>()
                //         //                                 .latilongbool,
                //         //                             onChanged: (value) {
                //         //                               setState(() {
                //         //                                 context
                //         //                                     .read<
                //         //                                         NewCustomerContoller>()
                //         //                                     .latilongbool = value;
                //         //                                 context
                //         //                                     .read<
                //         //                                         NewCustomerContoller>()
                //         //                                     .radio(value);
                //         //                               });
                //         //                             },
                //         //                           ),
                //         //                         ),
                //         //                       ],
                //         //                     ),
          
                //         //                     SizedBox(
                //         //                       height:
                //         //                           Screens.bodyheight(context) *
                //         //                               0.01,
                //         //                     ),
                //         //                   ],
                //         //                 ),
                //         //               ),
                //         //               Positioned(
                //         //                 top: 0,
                //         //                 child: InkWell(
                //         //                   onTap: () {
                //         //                     setState(() {
                //         //                       context
                //         //                           .read<NewCustomerContoller>()
                //         //                           .OfficeDropDown();
                //         //                     });
                //         //                   },
                //         //                   child: Container(
                //         //                     width: Screens.width(context) * 0.872,
                //         //                     height: Screens.bodyheight(context) *
                //         //                         0.06,
                //         //                     color: Colors.white,
                //         //                     child: Row(
                //         //                       mainAxisAlignment:
                //         //                           MainAxisAlignment.spaceBetween,
                //         //                       children: [
                //         //                         Container(
                //         //                           width: Screens.width(context) *
                //         //                               0.5,
                //         //                           child: Text(
                //         //                             "Office Address",
                //         //                             style: theme
                //         //                                 .textTheme.titleLarge!
                //         //                                 .copyWith(
                //         //                               fontWeight: FontWeight.bold,
                //         //                             ),
                //         //                           ),
                //         //                         ),
                //         //                         Container(
                //         //                           // color: Colors.amber,
                //         //                           // alignment:
                //         //                           //     Alignment.bottomLeft,
                //         //                           width: Screens.width(context) *
                //         //                               0.1,
                //         //                           child: IconButton(
                //         //                               padding: EdgeInsets.all(0),
                //         //                               onPressed: () {
                //         //                                 context
                //         //                                     .read<
                //         //                                         NewCustomerContoller>()
                //         //                                     .OfficeDropDown();
                //         //                               },
                //         //                               iconSize: 30,
                //         //                               icon: Icon(
                //         //                                   Icons.arrow_drop_down,
                //         //                                   color: Colors.black)),
                //         //                         )
                //         //                       ],
                //         //                     ),
                //         //                   ),
                //         //                 ),
                //         //               )
                //         //             ],
                //         //           ),
                //         //   ),
                //         // ),
                //         SizedBox(
                //           height: Screens.bodyheight(context) * 0.015,
                //         ),
                //         Form(
                //           key: context.read<NewCustomerContoller>().formkey[2],
                //           child: AnimatedContainer(
                //             duration: Duration(milliseconds: 500),
                //             curve: Curves.linear,
                //             height: context
                //                         .read<NewCustomerContoller>()
                //                         .billadressbool ==
                //                     true
                //                 ? Screens.bodyheight(context) * 0.09
                //                 : Screens.bodyheight(context) * 0.46,
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: Screens.width(context) * 0.03,
                //                 vertical: Screens.bodyheight(context) * 0.008),
                //             width: Screens.width(context),
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(8),
                //                 border: Border.all(color: theme.primaryColor)),
                //             child: context
                //                         .read<NewCustomerContoller>()
                //                         .billadressbool ==
                //                     true
                //                 ? Column(children: [
                //                     InkWell(
                //                       onTap: () {
                //                         setState(() {
                //                           context
                //                               .read<NewCustomerContoller>()
                //                               .billingAddDropDown();
                //                         });
                //                       },
                //                       child: Container(
                //                         height:
                //                             Screens.bodyheight(context) * 0.06,
                //                         child: Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             Container(
                //                               width: Screens.width(context) * 0.5,
                //                               child: Text(
                //                                 "Billing Address",
                //                                 style: theme.textTheme.titleLarge!
                //                                     .copyWith(
                //                                   fontWeight: FontWeight.bold,
                //                                 ),
                //                               ),
                //                             ),
                //                             Container(
                //                               alignment: Alignment.centerRight,
                //                               width: Screens.width(context) * 0.1,
                //                               child: IconButton(
                //                                   padding: EdgeInsets.all(0),
                //                                   onPressed: () {
                //                                     context
                //                                         .read<
                //                                             NewCustomerContoller>()
                //                                         .billingAddDropDown();
                //                                   },
                //                                   iconSize: 30,
                //                                   icon: Icon(
                //                                       Icons.arrow_drop_down,
                //                                       color: Colors.black)),
                //                             )
                //                           ],
                //                         ),
                //                       ),
                //                     ),
                //                   ])
                //                 : Stack(
                //                     children: [
                //                       SingleChildScrollView(
                //                         child: Column(
                //                           children: [
                //                             SizedBox(
                //                               height:
                //                                   Screens.bodyheight(context) *
                //                                       0.06,
                //                             ),
                //                             Container(
                //                               width: Screens.width(context) * 0.9,
                //                               child: Row(
                //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                                 children: [
                //                                   Container(
                //                                     // color:Colors.amber,
                //                                     width:
                //                                         Screens.width(context) *
                //                                             0.72,
                //                                     child: TextFormField(
                //                                         controller: context
                //                                             .read<
                //                                                 NewCustomerContoller>()
                //                                             .mycontroller2[0],
                //                                         validator: (value) {
                //                                           if (value!.isEmpty) {
                //                                             return "Enter Address1";
                //                                           }
                //                                           return null;
                //                                         },
                //                                         decoration:
                //                                             InputDecoration(
                //                                           labelText: 'Address1',
                //                                           labelStyle: theme
                //                                               .textTheme
                //                                               .bodyText1!
                //                                               .copyWith(
                //                                                   color: Colors
                //                                                       .grey),
                //                                           enabledBorder:
                //                                               UnderlineInputBorder(
                //                                             borderSide:
                //                                                 BorderSide(
                //                                                     color: Colors
                //                                                         .grey),
                //                                             //  when the TextFormField in unfocused
                //                                           ),
                //                                           focusedBorder:
                //                                               UnderlineInputBorder(
                //                                             borderSide:
                //                                                 BorderSide(
                //                                                     color: Colors
                //                                                         .grey),
                //                                             //  when the TextFormField in focused
                //                                           ),
                //                                           border:
                //                                               UnderlineInputBorder(),
                //                                           // enabledBorder: UnderlineInputBorder(),
                //                                           // focusedBorder: UnderlineInputBorder(),
                //                                           errorBorder:
                //                                               UnderlineInputBorder(),
                //                                           focusedErrorBorder:
                //                                               UnderlineInputBorder(),
                //                                         )),
                //                                   ),
                //                                   // Container(
                //                                   //      width:
                //                                   //       Screens.width(context) *
                //                                   //           0.1,
                //                                   //   child: Checkbox(
                //                                   //     value: context
                //                                   //         .read<NewCustomerContoller>()
                //                                   //         .billingCheckbox,
                //                                   //     onChanged: (value) {
                //                                   //       setState(() {
                //                                   //         context
                //                                   //             .read<
                //                                   //                 NewCustomerContoller>()
                //                                   //             .billAddCheckboxmethod(
                //                                   //                 value!);
                //                                   //         context
                //                                   //             .read<
                //                                   //                 NewCustomerContoller>()
                //                                   //             .billingCheckbox = value;
                //                                   //       });
                //                                   //     },
                //                                   //   ),
                //                                   // ),
                //                                 ],
                //                               ),
                //                             ),
                //                             // SizedBox(
                //                             //   height: Screens.bodyheight(context) * 0.01,
                //                             // ),
                //                             TextFormField(
                //                                 controller: context
                //                                     .read<NewCustomerContoller>()
                //                                     .mycontroller2[1],
                //                                 // validator: (value) {
                //                                 //   if (value!.isEmpty) {
                //                                 //     return "Enter Address2";
                //                                 //   }
                //                                 //   return null;
                //                                 // },
                //                                 decoration: InputDecoration(
                //                                   labelText: 'Address2',
                //                                   labelStyle: theme
                //                                       .textTheme.bodyText1!
                //                                       .copyWith(
                //                                           color: Colors.grey),
                //                                   enabledBorder:
                //                                       UnderlineInputBorder(
                //                                     borderSide: BorderSide(
                //                                         color: Colors.grey),
                //                                     //  when the TextFormField in unfocused
                //                                   ),
                //                                   focusedBorder:
                //                                       UnderlineInputBorder(
                //                                     borderSide: BorderSide(
                //                                         color: Colors.grey),
                //                                     //  when the TextFormField in focused
                //                                   ),
                //                                   border: UnderlineInputBorder(),
                //                                   // enabledBorder: UnderlineInputBorder(),
                //                                   // focusedBorder: UnderlineInputBorder(),
                //                                   errorBorder:
                //                                       UnderlineInputBorder(),
                //                                   focusedErrorBorder:
                //                                       UnderlineInputBorder(),
                //                                 )),
                //                             // SizedBox(
                //                             //   height: Screens.bodyheight(context) * 0.01,
                //                             // ),
                //                             Row(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.spaceBetween,
                //                               children: [
                //                                 SizedBox(
                //                                   width: Screens.width(context) *
                //                                       0.4,
                //                                   child: TextFormField(
                //                                       controller: context
                //                                           .read<
                //                                               NewCustomerContoller>()
                //                                           .mycontroller2[2],
                //                                       validator: (value) {
                //                                         if (value!.isEmpty) {
                //                                           return "Enter Area";
                //                                         }
                //                                         return null;
                //                                       },
                //                                       onTap: () {},
                //                                       onChanged: (v) {
                //                                         setState(() {});
                //                                       },
                //                                       decoration: InputDecoration(
                //                                         labelText: 'Area',
                //                                         border:
                //                                             UnderlineInputBorder(),
                //                                         labelStyle: theme
                //                                             .textTheme.bodyText1!
                //                                             .copyWith(
                //                                                 color:
                //                                                     Colors.grey),
                //                                         enabledBorder:
                //                                             UnderlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                               color: Colors.grey),
                //                                           //  when the TextFormField in unfocused
                //                                         ),
                //                                         focusedBorder:
                //                                             UnderlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                               color: Colors.grey),
                //                                           //  when the TextFormField in focused
                //                                         ),
                //                                         errorBorder:
                //                                             UnderlineInputBorder(),
                //                                         focusedErrorBorder:
                //                                             UnderlineInputBorder(),
                //                                       )),
                //                                 ),
                //                                 SizedBox(
                //                                   width: Screens.width(context) *
                //                                       0.4,
                //                                   child: TextFormField(
                //                                       controller: context
                //                                           .read<
                //                                               NewCustomerContoller>()
                //                                           .mycontroller2[3],
                //                                       validator: (value) {
                //                                         if (value!.isEmpty) {
                //                                           return "Enter City";
                //                                         }
                //                                         return null;
                //                                       },
                //                                       onTap: () {
                //                                         setState(() {});
                //                                       },
                //                                       onChanged: (v) {
                //                                         setState(() {});
                //                                       },
                //                                       decoration: InputDecoration(
                //                                         labelText: 'City',
                //                                         border:
                //                                             UnderlineInputBorder(),
                //                                         labelStyle: theme
                //                                             .textTheme.bodyText1!
                //                                             .copyWith(
                //                                                 color:
                //                                                     Colors.grey),
                //                                         enabledBorder:
                //                                             UnderlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                               color: Colors.grey),
                //                                           //  when the TextFormField in unfocused
                //                                         ),
                //                                         focusedBorder:
                //                                             UnderlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                               color: Colors.grey),
                //                                           //  when the TextFormField in focused
                //                                         ),
                //                                         errorBorder:
                //                                             UnderlineInputBorder(),
                //                                         focusedErrorBorder:
                //                                             UnderlineInputBorder(),
                //                                       )),
                //                                 ),
                //                               ],
                //                             ),
          
                //                             Row(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.spaceBetween,
                //                               children: [
                //                                 SizedBox(
                //                                   width: Screens.width(context) *
                //                                       0.4,
                //                                   child: TextFormField(
                //                                       controller: context
                //                                           .read<
                //                                               NewCustomerContoller>()
                //                                           .mycontroller2[4],
                //                                       onTap: () {
                //                                         setState(() {});
                //                                       },
                //                                       validator: (value) {
                //                                         if (value!.isEmpty) {
                //                                           return "Enter Pincode";
                //                                         }
                //                                         return null;
                //                                       },
                //                                       onChanged: (v) {
                //                                         setState(() {});
                //                                       },
                //                                       keyboardType:
                //                                           TextInputType.number,
                //                                       inputFormatters: [
                //                                         new LengthLimitingTextInputFormatter(
                //                                             6),
                //                                       ],
                //                                       decoration: InputDecoration(
                //                                         labelText: 'Pincode',
                //                                         border:
                //                                             UnderlineInputBorder(),
                //                                         labelStyle: theme
                //                                             .textTheme.bodyText1!
                //                                             .copyWith(
                //                                                 color:
                //                                                     Colors.grey),
                //                                         enabledBorder:
                //                                             UnderlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                               color: Colors.grey),
                //                                           //  when the TextFormField in unfocused
                //                                         ),
                //                                         focusedBorder:
                //                                             UnderlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                               color: Colors.grey),
                //                                           //  when the TextFormField in focused
                //                                         ),
                //                                         errorBorder:
                //                                             UnderlineInputBorder(),
                //                                         focusedErrorBorder:
                //                                             UnderlineInputBorder(),
                //                                       )),
                //                                 ),
                //                                 SizedBox(
                //                                   width: Screens.width(context) *
                //                                       0.4,
                //                                   child: TextFormField(
                //                                       controller: context
                //                                           .read<
                //                                               NewCustomerContoller>()
                //                                           .mycontroller2[5],
                //                                       onTap: () {
                //                                         setState(() {});
                //                                       },
                //                                       validator: (value) {
                //                                         if (value!.isEmpty) {
                //                                           return "Enter State";
                //                                         }
                //                                         return null;
                //                                       },
                //                                       onChanged: (v) {
                //                                         setState(() {});
                //                                       },
                //                                       decoration: InputDecoration(
                //                                         labelText: 'State',
                //                                         border:
                //                                             UnderlineInputBorder(),
                //                                         labelStyle: theme
                //                                             .textTheme.bodyText1!
                //                                             .copyWith(
                //                                                 color:
                //                                                     Colors.grey),
                //                                         enabledBorder:
                //                                             UnderlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                               color: Colors.grey),
                //                                           //  when the TextFormField in unfocused
                //                                         ),
                //                                         focusedBorder:
                //                                             UnderlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                               color: Colors.grey),
                //                                           //  when the TextFormField in focused
                //                                         ),
                //                                         errorBorder:
                //                                             UnderlineInputBorder(),
                //                                         focusedErrorBorder:
                //                                             UnderlineInputBorder(),
                //                                       )),
                //                                 ),
                //                               ],
                //                             ),
                //                             SizedBox(
                //                               height:
                //                                   Screens.bodyheight(context) *
                //                                       0.01,
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                       Positioned(
                //                         top: 0,
                //                         child: InkWell(
                //                           onTap: () {
                //                             setState(() {
                //                               context
                //                                   .read<NewCustomerContoller>()
                //                                   .billingAddDropDown();
                //                             });
                //                           },
                //                           child: Container(
                //                             height: Screens.bodyheight(context) *
                //                                 0.06,
                //                             color: Colors.white,
                //                             width: Screens.width(context) * 0.872,
                //                             child: Row(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.spaceBetween,
                //                               children: [
                //                                 Container(
                //                                   width: Screens.width(context) *
                //                                       0.5,
                //                                   child: Text(
                //                                     "Billing Address",
                //                                     style: theme
                //                                         .textTheme.titleLarge!
                //                                         .copyWith(
                //                                       fontWeight: FontWeight.bold,
                //                                     ),
                //                                   ),
                //                                 ),
                //                                 Container(
                //                                   color: Colors.white,
                //                                   alignment:
                //                                       Alignment.centerRight,
                //                                   width: Screens.width(context) *
                //                                       0.1,
                //                                   child: IconButton(
                //                                       padding: EdgeInsets.all(0),
                //                                       onPressed: () {
                //                                         context
                //                                             .read<
                //                                                 NewCustomerContoller>()
                //                                             .billingAddDropDown();
                //                                       },
                //                                       iconSize: 30,
                //                                       icon: Icon(
                //                                           Icons.arrow_drop_down,
                //                                           color: Colors.black)),
                //                                 )
                //                               ],
                //                             ),
                //                           ),
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //           ),
                //         ),
          
                //         SizedBox(
                //           height: Screens.bodyheight(context) * 0.015,
                //         ),
          
                //         //Ship
                //         Form(
                //           key: context.read<NewCustomerContoller>().formkey[3],
                //           child: AnimatedContainer(
                //             duration: Duration(milliseconds: 500),
                //             curve: Curves.linear,
                //             height: context
                //                         .read<NewCustomerContoller>()
                //                         .shipaddressbool ==
                //                     true
                //                 ? Screens.bodyheight(context) * 0.09
                //                 : Screens.bodyheight(context) * 0.46,
                //             padding: EdgeInsets.symmetric(
                //                 horizontal: Screens.width(context) * 0.03,
                //                 vertical: Screens.bodyheight(context) * 0.008),
                //             width: Screens.width(context),
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(8),
                //                 border: Border.all(color: theme.primaryColor)),
                //             child: context
                //                         .read<NewCustomerContoller>()
                //                         .shipaddressbool ==
                //                     true
                //                 ? Column(children: [
                //                     InkWell(
                //                       onTap: () {
                //                         setState(() {
                //                           context
                //                               .read<NewCustomerContoller>()
                //                               .ShipAddDropDown();
                //                         });
                //                       },
                //                       child: Container(
                //                         height:
                //                             Screens.bodyheight(context) * 0.06,
                //                         child: Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceBetween,
                //                           children: [
                //                             Container(
                //                               width: Screens.width(context) * 0.5,
                //                               child: Text(
                //                                 "Delivery Address",
                //                                 style: theme.textTheme.titleLarge!
                //                                     .copyWith(
                //                                   fontWeight: FontWeight.bold,
                //                                 ),
                //                               ),
                //                             ),
                //                             Container(
                //                               alignment: Alignment.centerRight,
                //                               width: Screens.width(context) * 0.1,
                //                               child: IconButton(
                //                                   padding: EdgeInsets.all(0),
                //                                   onPressed: () {
                //                                     context
                //                                         .read<
                //                                             NewCustomerContoller>()
                //                                         .ShipAddDropDown();
                //                                   },
                //                                   iconSize: 30,
                //                                   icon: Icon(
                //                                       Icons.arrow_drop_down,
                //                                       color: Colors.black)),
                //                             )
                //                           ],
                //                         ),
                //                       ),
                //                     ),
                //                   ])
                //                 : Stack(
                //                     children: [
                //                       SingleChildScrollView(
                //                         child: Column(
                //                           children: [
                //                             SizedBox(
                //                               height:
                //                                   Screens.bodyheight(context) *
                //                                       0.06,
                //                             ),
                //                            Container(
                //                               width: Screens.width(context) * 0.9,
                //                               child: Row(
                //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                                 children: [
                //                                   Container(
                //                                     // color:Colors.amber,
                //                                     width:
                //                                         Screens.width(context) *
                //                                             0.72,
                //                                     child: TextFormField(
                //                                         controller: context
                //                                             .read<
                //                                                 NewCustomerContoller>()
                //                                             .mycontroller3[0],
                //                                         validator: (value) {
                //                                           if (value!.isEmpty) {
                //                                             return "Enter Address1";
                //                                           }
                //                                           return null;
                //                                         },
                //                                         decoration:
                //                                             InputDecoration(
                //                                           labelText: 'Address1',
                //                                           labelStyle: theme
                //                                               .textTheme
                //                                               .bodyText1!
                //                                               .copyWith(
                //                                                   color: Colors
                //                                                       .grey),
                //                                           enabledBorder:
                //                                               UnderlineInputBorder(
                //                                             borderSide:
                //                                                 BorderSide(
                //                                                     color: Colors
                //                                                         .grey),
                //                                             //  when the TextFormField in unfocused
                //                                           ),
                //                                           focusedBorder:
                //                                               UnderlineInputBorder(
                //                                             borderSide:
                //                                                 BorderSide(
                //                                                     color: Colors
                //                                                         .grey),
                //                                             //  when the TextFormField in focused
                //                                           ),
                //                                           border:
                //                                               UnderlineInputBorder(),
                //                                           // enabledBorder: UnderlineInputBorder(),
                //                                           // focusedBorder: UnderlineInputBorder(),
                //                                           errorBorder:
                //                                               UnderlineInputBorder(),
                //                                           focusedErrorBorder:
                //                                               UnderlineInputBorder(),
                //                                         )),
                //                                   ),
                //                                   Container(
                //                                        width:
                //                                         Screens.width(context) *
                //                                             0.1,
                //                                     child: Checkbox(
                //                                       value: context
                //                                           .read<NewCustomerContoller>()
                //                                           .delivAddCheckbox,
                //                                       onChanged: (value) {
                //                                         setState(() {
                //                                           context
                //                                               .read<
                //                                                   NewCustomerContoller>()
                //                                               .deliAddCheckboxmethod(
                //                                                   value!);
                //                                           context
                //                                               .read<
                //                                                   NewCustomerContoller>()
                //                                               .delivAddCheckbox = value;
                //                                         });
                //                                       },
                //                                     ),
                //                                   ),
                //                                 ],
                //                               ),
                //                             ),
                //                             // SizedBox(
                //                             //   height: Screens.bodyheight(context) * 0.005,
                //                             // ),
                //                             TextFormField(
                //                                 controller: context
                //                                     .read<NewCustomerContoller>()
                //                                     .mycontroller3[1],
                //                                 // validator: (value) {
                //                                 //   if (value!.isEmpty) {
                //                                 //     return "Enter Address2";
                //                                 //   }
                //                                 //   return null;
                //                                 // },
                //                                 decoration: InputDecoration(
                //                                   labelText: 'Address2',
                //                                   border: UnderlineInputBorder(),
                //                                   labelStyle: theme
                //                                       .textTheme.bodyText1!
                //                                       .copyWith(
                //                                           color: Colors.grey),
                //                                   enabledBorder:
                //                                       UnderlineInputBorder(
                //                                     borderSide: BorderSide(
                //                                         color: Colors.grey),
                //                                     //  when the TextFormField in unfocused
                //                                   ),
                //                                   focusedBorder:
                //                                       UnderlineInputBorder(
                //                                     borderSide: BorderSide(
                //                                         color: Colors.grey),
                //                                     //  when the TextFormField in focused
                //                                   ),
                //                                   errorBorder:
                //                                       UnderlineInputBorder(),
                //                                   focusedErrorBorder:
                //                                       UnderlineInputBorder(),
                //                                 )),
                //                             // SizedBox(
                //                             //   height: Screens.bodyheight(context) * 0.005,
                //                             // ),
                //                             Row(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.spaceBetween,
                //                               children: [
                //                                 SizedBox(
                //                                   width: Screens.width(context) *
                //                                       0.4,
                //                                   child: TextFormField(
                //                                       controller: context
                //                                           .read<
                //                                               NewCustomerContoller>()
                //                                           .mycontroller3[2],
                //                                       validator: (value) {
                //                                         if (value!.isEmpty) {
                //                                           return "Enter Area";
                //                                         }
                //                                         return null;
                //                                       },
                //                                       onTap: () {
                //                                         setState(() {});
                //                                       },
                //                                       onChanged: (v) {
                //                                         setState(() {});
                //                                       },
                //                                       decoration: InputDecoration(
                //                                         labelText: 'Area',
                //                                         border:
                //                                             UnderlineInputBorder(),
                //                                         labelStyle: theme
                //                                             .textTheme.bodyText1!
                //                                             .copyWith(
                //                                                 color:
                //                                                     Colors.grey),
                //                                         enabledBorder:
                //                                             UnderlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                               color: Colors.grey),
                //                                           //  when the TextFormField in unfocused
                //                                         ),
                //                                         focusedBorder:
                //                                             UnderlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                               color: Colors.grey),
                //                                           //  when the TextFormField in focused
                //                                         ),
                //                                         errorBorder:
                //                                             UnderlineInputBorder(),
                //                                         focusedErrorBorder:
                //                                             UnderlineInputBorder(),
                //                                       )),
                //                                 ),
                //                                 SizedBox(
                //                                   width: Screens.width(context) *
                //                                       0.4,
                //                                   child: TextFormField(
                //                                       controller: context
                //                                           .read<
                //                                               NewCustomerContoller>()
                //                                           .mycontroller3[3],
                //                                       validator: (value) {
                //                                         if (value!.isEmpty) {
                //                                           return "Enter City";
                //                                         }
                //                                         return null;
                //                                       },
                //                                       onTap: () {
                //                                         setState(() {});
                //                                       },
                //                                       onChanged: (v) {
                //                                         setState(() {});
                //                                       },
                //                                       decoration: InputDecoration(
                //                                         labelText: 'City',
                //                                         border:
                //                                             UnderlineInputBorder(),
                //                                         labelStyle: theme
                //                                             .textTheme.bodyText1!
                //                                             .copyWith(
                //                                                 color:
                //                                                     Colors.grey),
                //                                         enabledBorder:
                //                                             UnderlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                               color: Colors.grey),
                //                                           //  when the TextFormField in unfocused
                //                                         ),
                //                                         focusedBorder:
                //                                             UnderlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                               color: Colors.grey),
                //                                           //  when the TextFormField in focused
                //                                         ),
                //                                         errorBorder:
                //                                             UnderlineInputBorder(),
                //                                         focusedErrorBorder:
                //                                             UnderlineInputBorder(),
                //                                       )),
                //                                 ),
                //                               ],
                //                             ),
          
                //                             Row(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.spaceBetween,
                //                               children: [
                //                                 SizedBox(
                //                                   width: Screens.width(context) *
                //                                       0.4,
                //                                   child: TextFormField(
                //                                       controller: context
                //                                           .read<
                //                                               NewCustomerContoller>()
                //                                           .mycontroller3[4],
                //                                       onTap: () {},
                //                                       validator: (value) {
                //                                         if (value!.isEmpty) {
                //                                           return "Enter Pincode";
                //                                         }
                //                                         return null;
                //                                       },
                //                                       onChanged: (v) {
                //                                         setState(() {});
                //                                       },
                //                                       keyboardType:
                //                                           TextInputType.number,
                //                                       inputFormatters: [
                //                                         new LengthLimitingTextInputFormatter(
                //                                             6),
                //                                       ],
                //                                       decoration: InputDecoration(
                //                                         labelText: 'Pincode',
                //                                         border:
                //                                             UnderlineInputBorder(),
                //                                         labelStyle: theme
                //                                             .textTheme.bodyText1!
                //                                             .copyWith(
                //                                                 color:
                //                                                     Colors.grey),
                //                                         enabledBorder:
                //                                             UnderlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                               color: Colors.grey),
                //                                           //  when the TextFormField in unfocused
                //                                         ),
                //                                         focusedBorder:
                //                                             UnderlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                               color: Colors.grey),
                //                                           //  when the TextFormField in focused
                //                                         ),
                //                                         errorBorder:
                //                                             UnderlineInputBorder(),
                //                                         focusedErrorBorder:
                //                                             UnderlineInputBorder(),
                //                                       )),
                //                                 ),
                //                                 SizedBox(
                //                                   width: Screens.width(context) *
                //                                       0.4,
                //                                   child: TextFormField(
                //                                       controller: context
                //                                           .read<
                //                                               NewCustomerContoller>()
                //                                           .mycontroller3[5],
                //                                       onTap: () {
                //                                         setState(() {});
                //                                       },
                //                                       validator: (value) {
                //                                         if (value!.isEmpty) {
                //                                           return "Enter State";
                //                                         }
                //                                         return null;
                //                                       },
                //                                       onChanged: (v) {
                //                                         setState(() {});
                //                                       },
                //                                       decoration: InputDecoration(
                //                                         labelText: 'State',
                //                                         border:
                //                                             UnderlineInputBorder(),
                //                                         labelStyle: theme
                //                                             .textTheme.bodyText1!
                //                                             .copyWith(
                //                                                 color:
                //                                                     Colors.grey),
                //                                         enabledBorder:
                //                                             UnderlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                               color: Colors.grey),
                //                                           //  when the TextFormField in unfocused
                //                                         ),
                //                                         focusedBorder:
                //                                             UnderlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                               color: Colors.grey),
                //                                           //  when the TextFormField in focused
                //                                         ),
                //                                         errorBorder:
                //                                             UnderlineInputBorder(),
                //                                         focusedErrorBorder:
                //                                             UnderlineInputBorder(),
                //                                       )),
                //                                 ),
                //                               ],
                //                             ),
                //                             // SizedBox(
                //                             //   height:
                //                             //       Screens.bodyheight(context) * 0.01,
                //                             // ),
                //                           ],
                //                         ),
                //                       ),
                //                       Positioned(
                //                         top: 0,
                //                         child: InkWell(
                //                           onTap: () {
                //                             setState(() {
                //                               context
                //                                   .read<NewCustomerContoller>()
                //                                   .ShipAddDropDown();
                //                             });
                //                           },
                //                           child: Container(
                //                             height: Screens.bodyheight(context) *
                //                                 0.06,
                //                             color: Colors.white,
                //                             width: Screens.width(context) * 0.872,
                //                             child: Row(
                //                               mainAxisAlignment:
                //                                   MainAxisAlignment.spaceBetween,
                //                               children: [
                //                                 Container(
                //                                   width: Screens.width(context) *
                //                                       0.5,
                //                                   child: Text(
                //                                     "Delivery Address",
                //                                     style: theme
                //                                         .textTheme.titleLarge!
                //                                         .copyWith(
                //                                       fontWeight: FontWeight.bold,
                //                                     ),
                //                                   ),
                //                                 ),
                //                                 Container(
                //                                   alignment:
                //                                       Alignment.centerRight,
                //                                   width: Screens.width(context) *
                //                                       0.1,
                //                                   child: IconButton(
                //                                       padding: EdgeInsets.all(0),
                //                                       onPressed: () {
                //                                         context
                //                                             .read<
                //                                                 NewCustomerContoller>()
                //                                             .ShipAddDropDown();
                //                                       },
                //                                       iconSize: 30,
                //                                       icon: Icon(
                //                                           Icons.arrow_drop_down,
                //                                           color: Colors.black)),
                //                                 )
                //                               ],
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //           ),
                //         ),
                //         SizedBox(
                //           height: Screens.bodyheight(context) * 0.015,
                //         ),
                //         Column(
                //           children: [
                //             Container(
                //               width: Screens.width(context),
                //               height: Screens.bodyheight(context) * 0.28,
                //               decoration: BoxDecoration(
                //                   color: theme.primaryColor,
                //                   borderRadius: BorderRadius.circular(8)),
                //               padding: EdgeInsets.only(
                //                 left: Screens.width(context) * 0.02,
                //                 right: Screens.width(context) * 0.02,
                //                 top: Screens.bodyheight(context) * 0.01,
                //               ),
                //               child: SingleChildScrollView(
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       "Payment Terms",
                //                       style: theme.textTheme.bodyText1
                //                           ?.copyWith(color: Colors.white),
                //                     ),
                //                     SizedBox(
                //                         height:
                //                             Screens.bodyheight(context) * 0.02),
                //                     Center(
                //                       child: Wrap(
                //                           spacing: 20.0, // width
                //                           runSpacing: 8.0, // height
                //                           children:
                //                               listContainersRefferes(theme)),
                //                     )
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //         // //nextbtn
                //         SizedBox(
                //           height: Screens.bodyheight(context) * 0.015,
                //         ),
                //         Form(
                //           key: context.read<NewCustomerContoller>().formkey[4],
                //           child: SizedBox(
                //             child: TextFormField(
                //               controller: context
                //                   .read<NewCustomerContoller>()
                //                   .mycontroller3[6],
                //               onTap: () {
                //                 showDialog<dynamic>(
                //                     context: context,
                //                     builder: (_) {
                //                       return ShowSearchDialog();
                //                     });
                //               },
                //               validator: (value) {
                //                 if (value!.isEmpty) {
                //                   return "Enter Looking for";
                //                 }
                //                 return null;
                //               },
                //               // readOnly: true,
                //               // controller:
                //               //     context.read<NewEnqController>().mycontroller[7],
                //               readOnly: true,
                //               decoration: InputDecoration(
                //                 contentPadding: EdgeInsets.symmetric(
                //                     vertical: 10, horizontal: 10),
                //                 labelText: "Select Group",
                //                 labelStyle: TextStyle(
                //                     color: theme.primaryColor,
                //                     fontWeight: FontWeight.bold),
                //                 border: OutlineInputBorder(
                //                   borderRadius: BorderRadius.circular(8),
                //                   borderSide:
                //                       BorderSide(color: theme.primaryColor),
                //                 ),
                //                 enabledBorder: OutlineInputBorder(
                //                   borderRadius: BorderRadius.circular(8),
                //                   borderSide:
                //                       BorderSide(color: theme.primaryColor),
                //                 ),
                //                 focusedBorder: OutlineInputBorder(
                //                   borderRadius: BorderRadius.circular(8),
                //                   borderSide:
                //                       BorderSide(color: theme.primaryColor),
                //                 ),
                //               ),
                //               // cursorColor: Colors.green,
                //             ),
                //           ),
                //         ),
                //         SizedBox(
                //           height: Screens.bodyheight(context) * 0.015,
                //         ),
                //         Align(
                //             alignment: Alignment.centerRight,
                //             child: SizedBox(
                //               width: Screens.width(context),
                //               height: Screens.bodyheight(context) * 0.07,
                //               child: ElevatedButton(
                //                   onPressed: () {
                //                     context
                //                         .read<NewCustomerContoller>()
                //                         .validate2(context);
                //                   },
                //                   child: Text("Save")),
                //             ))
                //       ],
                //     ),
                //   ),
                // ),
             
              ],
            ),
          ),
        ));
  }

  bool switched = false;
  bool switched2 = false;

  List<Widget> listContainersRefferes(
    ThemeData theme,
  ) {
    return List.generate(
      context.read<NewCustomerContoller>().getenqReffList.length,
      (index) => InkWell(
        onTap: () {
          // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
          // .getenqReffList[index].Name.toString();
          context.read<NewCustomerContoller>().selectEnqReffers(
              context
                  .read<NewCustomerContoller>()
                  .getenqReffList[index]
                  .Name
                  .toString(),
              context.read<NewCustomerContoller>().getenqReffList[index].Name!, context.read<NewCustomerContoller>().getenqReffList[index].Code!);
        },
        child: Container(
          width: Screens.width(context) * 0.4,
          height: Screens.bodyheight(context) * 0.06,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context
                          .read<NewCustomerContoller>()
                          .getisSelectedenquiryReffers ==
                      context
                          .read<NewCustomerContoller>()
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
                      .watch<NewCustomerContoller>()
                      .getenqReffList[index]
                      .Name
                      .toString(),
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyText1?.copyWith(
                    color: context
                                .read<NewCustomerContoller>()
                                .getisSelectedenquiryReffers ==
                            context
                                .read<NewCustomerContoller>()
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

  // List<Widget> listContainersCustomertags(
  //   ThemeData theme,
  // ) {
  //   return List.generate(
  //     context.watch<NewCustomerContoller>().getcusReffList.length,
  //     (index) => InkWell(
  //       onTap: () {
  //         // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
  //         // .getenqReffList[index].Name.toString();
  //         context.read<NewCustomerContoller>().selectEnqReffers(
  //             context
  //                 .read<NewCustomerContoller>()
  //                 .getcusReffList[index]
  //                 .tagname
  //                 .toString(),
  //             context.read<NewCustomerContoller>().getcusReffList[index].tagname!);
  //       },
  //       child: Container(
  //         width: Screens.width(context) * 0.2,
  //         height: Screens.bodyheight(context) * 0.05,
  //         //  padding: EdgeInsets.all(10),
  //         decoration: BoxDecoration(
  //             color: context
  //                         .watch<NewCustomerContoller>()
  //                         .getisSelectedenquiryReffers ==
  //                     context
  //                         .read<NewCustomerContoller>()
  //                         .getcusReffList[index]
  //                         .tagname
  //                         .toString()
  //                 ? Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
  //                 : Colors.white,
  //             border: Border.all(color: theme.primaryColor, width: 1),
  //             borderRadius: BorderRadius.circular(10)),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //                 context
  //                     .watch<NewCustomerContoller>()
  //                     .getcusReffList[index]
  //                     .tagname
  //                     .toString(),
  //                 maxLines: 8,
  //                 overflow: TextOverflow.ellipsis,
  //                 style: theme.textTheme.bodyText1?.copyWith(
  //                   color: context
  //                               .watch<NewCustomerContoller>()
  //                               .getisSelectedenquiryReffers ==
  //                           context
  //                               .read<NewCustomerContoller>()
  //                               .getcusReffList[index]
  //                               .tagname
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
  List<Widget> listContainersCustomertags(
    ThemeData theme,
  ) {
    return List.generate(
      context.watch<NewCustomerContoller>().customerTagTypeData.length,
      (index) => InkWell(
        onTap: () {
          // context.read<NewEnqController>(). isSelectedenquirytype = context.read<NewEnqController>()
          // .getenqReffList[index].Name.toString();
          context.read<NewCustomerContoller>().selectCustomerTag(
              context
                  .read<NewCustomerContoller>()
                  .customerTagTypeData[index]
                  .Name
                  .toString(),
              context
                  .read<NewCustomerContoller>()
                  .customerTagTypeData[index]
                  .Name!,
              context
                  .read<NewCustomerContoller>()
                  .customerTagTypeData[index]
                  .Code!);
        },
        child: Container(
          width: Screens.width(context) * 0.2,
          height: Screens.bodyheight(context) * 0.05,
          alignment: Alignment.center,
          //  padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: context.watch<NewCustomerContoller>().isSelectedCusTagcode ==
                      context
                          .read<NewCustomerContoller>()
                          .customerTagTypeData[index]
                          .Code
                          .toString()
                  ? Color(0xffB299A5) //theme.primaryColor.withOpacity(0.5)
                  : Colors.white,
              border: Border.all(color: theme.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
              context
                  .watch<NewCustomerContoller>()
                  .customerTagTypeData[index]
                  .Name
                  .toString(),
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10,
                color:
                    context.watch<NewCustomerContoller>().isSelectedCusTagcode ==
                            context
                                .read<NewCustomerContoller>()
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
