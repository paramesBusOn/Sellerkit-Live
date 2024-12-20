// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/constant_sapvalues.dart';

import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Constant/helper.dart';
import 'package:sellerkit/Controller/ConfigurationController/configuration_controller.dart';
import 'package:sellerkit/Pages/Configuration/updatedialogbox.dart';
import '../../../Constant/app_constant.dart';
import 'package:sellerkit/Constant/constant_routes.dart';
import '../../../Widgets/LottieContainer.dart';

class SplashPage extends StatefulWidget {
  SplashPage({
    Key? key,
  }) : super(key: key);
  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  String errormsg = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //  context.read<SplashController>().setURL();
    
      context.read<ConfigurationContoller>().showVersion();
    
      String? storeversion = await context
          .read<ConfigurationContoller>()
          .getStoreVersion('com.busondigitalservice.sellerkit');

      if (storeversion != null) {
        if (ConstantValues.appversion != storeversion) {
          await showDialog(
              context: context,
              builder: ((context) => Upgraderdialogbox(
                    storeversion: storeversion,
                  ))).then((value) async{
            try {
     
              context
                  .read<ConfigurationContoller>()
                  .checkBeforeLoginApi(context);
            } catch (e) {
              errormsg = e.toString();
            }
          });
        } else {
          try {
            log("ininin");
             
            context.read<ConfigurationContoller>().checkBeforeLoginApi(context);
          } catch (e) {
            errormsg = e.toString();
          }
        }
      }else{
         try {
            log("inininout");
            context.read<ConfigurationContoller>().checkBeforeLoginApi(context);
          } catch (e) {
            errormsg = e.toString();
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: Screens.width(context),
            height: Screens.padingHeight(context),
            padding: EdgeInsets.all(1),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(),
              Container(
                alignment: Alignment.center,
                width: Screens.width(context),
                //  height: Screens.padingHeight(context) * 0.3,
                //  color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: Screens.width(context) * 0.3,
                        height: Screens.padingHeight(context) * 0.2,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("Assets/SellerSymbol.png"),
                          fit: BoxFit.cover,
                        ))),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                    Container(
                      child: Text(
                        "SELLERKIT-CRM",
                        style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(
                      height: Screens.padingHeight(context) * 0.03,
                    ),
                    (context.watch<ConfigurationContoller>().isLoading ==
                                true &&
                            context
                                    .watch<ConfigurationContoller>()
                                    .getexceptionOnApiCall ==
                                '')
                        ? Column(
                          children: [
                            Container(
                                width: Screens.width(context) * 0.5,
                                // color: Colors.red,
                                child: LinearProgressIndicator(),
                              ),
                              SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                         Container(
                      child: Text(
                        "Connecting to Sellerkit Server ${context.watch<ConfigurationContoller>().progressPercentage.toStringAsFixed(0)} %",
                        style: theme.textTheme.bodyMedium!.copyWith(
                            
                            ),
                      ),
                    ),
                          ],
                        )
                        : Column(
                            children: [
                              Container(
                                  width: Screens.width(context) * 0.3,
                                  //  color: Colors.red,
                                  child: context
                                              .watch<ConfigurationContoller>()
                                              .getexceptionOnApiCall ==
                                          'Check your internet connectivity..!!'
                                      ? LottieContainer(
                                          file: 'Assets/90478-disconnect.json',
                                          height:
                                              Screens.padingHeight(context) *
                                                  0.2,
                                          width: Screens.width(context) * 0.2,
                                        )
                                      : LottieContainer(
                                          file:
                                              //"Assets/91069-like.json",
                                              'Assets/36087-user-denied.json',
                                          height:
                                              Screens.padingHeight(context) *
                                                  0.2,
                                          width: Screens.width(context) * 0.2,
                                        )),
                              Container(
                                width: Screens.width(context),
                                alignment: Alignment.center,
                                child: Text(
                                  context
                                      .watch<ConfigurationContoller>()
                                      .getexceptionOnApiCall,
                                  maxLines: 3,
                                ),
                              ),
                              SizedBox(
                                height: Screens.padingHeight(context) * 0.02,
                              ),
                              Container(
                                  width: Screens.width(context) * 0.8,
                                  child: InkWell(
                                    onTap: () {
                                      Get.offAllNamed(ConstantRoutes.login);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Text(
                                          "Click here to go ",
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: Colors.grey,
                                          ),
                                        )),
                                        Container(
                                            child: Text(
                                          "Login",
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                  fontSize: 16,
                                                  color: theme.primaryColor,
                                                  fontWeight: FontWeight.w400),
                                        )),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                    //  Container(
                    //   width: Screens.width(context)*0.5,
                    //   // color: Colors.red,
                    //   child: Text("errormsg:$errormsg"),
                    // ),
                    //     Container(
                    //   width: Screens.width(context)*0.5,
                    //   // color: Colors.red,
                    //   child: Text("geturl:${context.read<ConfigurationContoller>().geturlview}"),
                    // ),
                    // Container(
                    //   width: Screens.width(context)*0.5,
                    //   // color: Colors.red,
                    //   child: Text("deviceID:${context.read<ConfigurationContoller>().deviceIDview}"),
                    // ),
                    // Container(
                    //   width: Screens.width(context)*0.5,
                    //   // color: Colors.red,
                    //   child: Text("licenseKeyview:${context.read<ConfigurationContoller>().licenseKeyview}"),
                    // ),
                    // Container(
                    //   width: Screens.width(context)*0.5,
                    //   // color: Colors.red,
                    //   child: Text("userCodeview:${context.read<ConfigurationContoller>().userCodeview}"),
                    // ),
                    // Container(
                    //   width: Screens.width(context)*0.5,
                    //   // color: Colors.red,
                    //   child: Text("passswordview:${context.read<ConfigurationContoller>().passswordview}"),
                    // ),
                    // Container(
                    //   width: Screens.width(context)*0.5,
                    //   // color: Colors.red,
                    //   child: Text("tokenview:${context.read<ConfigurationContoller>().tokenview}"),
                    // ),
                    // Container(
                    //   width: Screens.width(context)*0.5,
                    //   // color: Colors.red,
                    //   child: Text("isLoggedInview:${context.read<ConfigurationContoller>().isLoggedInview}"),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: Screens.padingHeight(context) * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: Screens.padingHeight(context) * 0.01),
                child: Container(
                  width: Screens.width(context),
                  // height: Screens.padingHeight(context) * 0.05,

                  //  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // color: Colors.red,
                        // alignment: Alignment.bottomRight,
                        // width: Screens.width(context)*0.4,
                        child: Text("App Version"),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.02,
                      ),
                      Container(
                        // color: Colors.amber,
                        // padding:EdgeInsets.symmetric(horizontal: Screens.bodyheight(context)*0.01),
                        // alignment: Alignment.bottomLeft,
                        // width: Screens.width(context)*0.4,
                        child: Text(ConstantValues.appversion.isEmpty
                            ? "${AppConstant.version}"
                            : "${ConstantValues.appversion}"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Screens.padingHeight(context) * 0.002,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: Screens.padingHeight(context) * 0.01),
                child: Container(
                  width: Screens.width(context),
                  // height: Screens.padingHeight(context) * 0.05,

                  //  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // color: Colors.red,
                        // alignment: Alignment.bottomRight,
                        // width: Screens.width(context)*0.4,
                        child: Text("API Version"),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.02,
                      ),
                      Container(
                        // color: Colors.amber,
                        // padding:EdgeInsets.symmetric(horizontal: Screens.bodyheight(context)*0.01),
                        // alignment: Alignment.bottomLeft,
                        // width: Screens.width(context)*0.4,
                        child: Text("${AppConstant.version}"),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
