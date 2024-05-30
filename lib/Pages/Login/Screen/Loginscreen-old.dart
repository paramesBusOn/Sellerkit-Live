// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_build_context_synchronously, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Pages/Login/Widgets/TermsAndConditions.dart';
import 'package:sellerkit/Pages/Login/Widgets/TermsAndConditions2.dart';
import 'package:sellerkit/Pages/Login/Widgets/TermsAndConditions3.dart';
import '../../../Constant/ConstantRoutes.dart';
import '../../../Constant/AppConstant.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/LoginController/LoginController.dart';
import '../../../Widgets/custom_shake_transtition.dart';
import '../../Splash/Widgets/custom_elevatedBtn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Paddings constant = Paddings();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: ChangeNotifierProvider<LoginController>(
            create: (context) => LoginController(context),
            builder: (context, child) {
              return Consumer<LoginController>(
                  builder: (BuildContext context, prdlog, Widget? child) {
                return Container(
                  width: Screens.width(context),
                  height: Screens.fullHeight(context),
                  child: Stack(
                    children: [
                      Container(
                        width: Screens.width(context),
                        height: Screens.padingHeight(context) * 0.3,
                        decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                    Screens.width(context) * 0.2))),
                        padding: EdgeInsets.symmetric(
                            vertical: Screens.padingHeight(context) * 0.1,
                            horizontal: Screens.width(context) * 0.1),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Login",
                              style: theme.textTheme.headline5
                                  ?.copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          top: Screens.padingHeight(context) * 0.3,
                          child: Container(
                            width: Screens.width(context),
                            height: Screens.padingHeight(context) * 0.7,
                            decoration: BoxDecoration(
                                //color: Colors.red,
                                //borderRadius: BorderRadius.only(bottomLeft:Radius.circular( Screens.width(context)*0.2))
                                ),
                            padding: EdgeInsets.symmetric(
                                vertical: Screens.padingHeight(context) * 0.05,
                                horizontal: Screens.width(context) * 0.05),
                            child: Form(
                              key: prdlog.formkey,
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: prdlog.geterroMsgVisble,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: Screens.width(context),
                                      child: Column(
                                        children: [
                                          Text(
                                            prdlog.errorMsh,
                                            style: theme.textTheme.bodyText1
                                                ?.copyWith(color: Colors.red),
                                            maxLines: 4,
                                          ),
                                          SizedBox(
                                            height:
                                                Screens.bodyheight(context) *
                                                    0.02,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  CustomShakeTransition(
                                    duration: const Duration(milliseconds: 900),
                                    child: SizedBox(
                                      child: TextFormField(
                                        controller: prdlog.mycontroller[0],
                                        keyboardType: TextInputType.text,
                                        style: theme.textTheme.bodyText2,
                                        validator: (data) {
                                          if (data!.isEmpty) {
                                            return "Required*";
                                          }
                                          // else if (!data.contains("@")) {
                                          //   return "Enter Valid Email*";
                                          // }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                          fillColor: Colors.grey[200],
                                          filled: true,
                                          prefixIcon: const Icon(
                                            Icons.account_circle_outlined,
                                            size: 25,
                                          ),
                                          labelText: "Username",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              color: Colors.lightBlueAccent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.03,
                                  ),
                                  CustomShakeTransition(
                                    duration: const Duration(milliseconds: 900),
                                    child: SizedBox(
                                      child: TextFormField(
                                        controller: prdlog.mycontroller[1],
                                        validator: (data) {
                                          if (data!.isEmpty) {
                                            return "Required*";
                                          }
                                          return null;
                                        },
                                        obscureText: prdlog.getHidepassword,
                                        style: theme.textTheme.bodyText2,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                          fillColor: Colors.grey[200],
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              color: Colors.lightBlueAccent,
                                            ),
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.lock_outlined,
                                            size: 25,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: prdlog.getHidepassword
                                                ? const Icon(
                                                    Icons.visibility_off)
                                                : const Icon(Icons.visibility),
                                            onPressed: () {
                                              prdlog.obsecure();
                                            },
                                          ),
                                          labelText: "Password",
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  Container(
                                    width: Screens.width(context),
                                    // color: Colors.amber,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Checkbox(
                                          visualDensity: VisualDensity(
                                              horizontal: -4.0, vertical: -4.0),
                                          value: prdlog.TCbool,
                                          onChanged: (value) {
                                            setState(() {
                                              prdlog.setTermsAConditionsValue(
                                                  value);
                                              // _acceptTerms = value ?? false;
                                            });
                                          },
                                        ),
                                        Text('I accept the '),
                                        InkWell(
                                          onTap: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      pdfViwer()),
                                            );
                                            // await showDialog<dynamic>(

                                            //     context: context,
                                            //     builder: (_) {
                                            //       return TermsAndConditionsBox();
                                            //     });
                                          },
                                          child: Text(
                                            'Terms and Conditions',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.01,
                                  ),
                                  prdlog.TCbool == false
                                      ?  CustomSpinkitdButton(
                                        color: Colors.grey[300],
                                          onTap:(){
                                            // setState(() {
                                            //  prdlog.erroMsgVisble=true;
                                            //  prdlog.errorMsh='' 
                                            // });
                                          },
                                          isLoading: prdlog.isLoading,
                                          label: 'Login',
                                          labelLoading: "Login",
                                          textcolor: Colors.grey,
                                          // labelLoading: AppLocalizations.of(context)!.signing,
                                          // label: AppLocalizations.of(context)!.sign_in,
                                        )
                                      : CustomSpinkitdButton(
                                        // color: Colors.grey[300],
                                          onTap: prdlog.getsettingError ==
                                                      true ||
                                                  prdlog.isLoading == true
                                              ? null
                                              : () async {
                                                  prdlog.validateLogin(context);
                                                  // prdlog.testApi();
                                                },
                                          isLoading: prdlog.isLoading,
                                          label: 'Login',
                                          labelLoading: "Login",
                                          textcolor: Colors.white,
                                          // labelLoading: AppLocalizations.of(context)!.signing,
                                          // label: AppLocalizations.of(context)!.sign_in,
                                        ),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.03,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        LoginController.loginPageScrn = true;
                                        // ForgotPasswordController.loginscrn = true;
                                        // print("LoginController.loginpage:${LoginController.loginPageScrn}");
                                        Get.toNamed(ConstantRoutes.forgotregister);
                                      },
                                      child: Text("Forgot password?")),
                                  SizedBox(
                                    height:
                                        Screens.padingHeight(context) * 0.03,
                                  ),
                                  // Center(
                                  //   child: Container(
                                  //     width: Screens.width(context),
                                  //     alignment: Alignment.center,
                                  //     child: Row(
                                  //       mainAxisAlignment: MainAxisAlignment.center,
                                  //       children: [
                                  //         InkWell(
                                  //             onTap: () {
                                  //               //   Get.toNamed(ConstantRoutes.register);
                                  //             },
                                  //             child: Text("Do you have not account ")),
                                  //         InkWell(
                                  //             onTap: () {
                                  //               //  Get.toNamed(ConstantRoutes.register);
                                  //              prdlog.showShare("context");
                                  //             },
                                  //             child: Text("Register",
                                  //                 style: theme.textTheme.subtitle1
                                  //                     ?.copyWith(
                                  //                         color: theme.primaryColor))),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // )

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () async {
                                            // bool res =
                                            //     await prdlog.checkloc();
                                            // if (res == true) {
                                            showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          4))),
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      insetPadding:
                                                          EdgeInsets.all(Screens
                                                                  .bodyheight(
                                                                      context) *
                                                              0.02),
                                                      content: settings(
                                                          context, prdlog));
                                                });
                                            // } else {
                                            //   showDialog(
                                            //       context: context,
                                            //       builder:
                                            //           (BuildContext context) {
                                            //         return AlertDialog(
                                            //             shape: RoundedRectangleBorder(
                                            //                 borderRadius: BorderRadius
                                            //                     .all(Radius
                                            //                         .circular(
                                            //                             08))),
                                            //             contentPadding:
                                            //                 EdgeInsets.all(0),
                                            //             insetPadding: EdgeInsets.all(
                                            //                 Screens.bodyheight(
                                            //                         context) *
                                            //                     0.02),
                                            //             content:
                                            //                 locateAlert());
                                            //       }).then((value) {
                                            //   });
                                            //   // Get.defaultDialog(title: "Alert",middleText: 'Location is must for login..!!');
                                            // }
                                            // showDialog(
                                            //     context: context,
                                            //     barrierDismissible: true,
                                            //     builder:
                                            //         (BuildContext context) {
                                            //       return AlertDialog(
                                            //           shape: RoundedRectangleBorder(
                                            //               borderRadius:
                                            //                   BorderRadius
                                            //                       .all(Radius
                                            //                           .circular(
                                            //                               4))),
                                            //           contentPadding:
                                            //               EdgeInsets.all(0),
                                            //           insetPadding: EdgeInsets
                                            //               .all(Screens
                                            //                       .bodyheight(
                                            //                           context) *
                                            //                   0.02),
                                            //           content: settings(
                                            //               context, prdlog));
                                            //     });
                                          },
                                          child: Container(
                                              //color: Colors.amber,
                                              width:
                                                  Screens.width(context) * 0.1,
                                              child: Icon(
                                                Icons.settings,
                                                color: theme.primaryColor,
                                              ))),
                                      Container(
                                        child: Text(
                                          ConstantValues.appversion.isEmpty?"${AppConstant.version}":"${ConstantValues.appversion}",
                                          // 'V 1.0.8',
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Container(
                                  //   alignment: Alignment.centerRight,
                                  //         child: Text("Latt:"+
                                  //           '${ConstantValues.latitude}',
                                  //           // 'V 1.0.8',
                                  //           style: theme.textTheme.bodySmall,
                                  //         ),
                                  //       ),
                                  //        Container(
                                  //         alignment: Alignment.centerRight,
                                  //         child: Text("Lang::"+
                                  //           '${ConstantValues.langtitude}',
                                  //           // 'V 1.0.8',
                                  //           style: theme.textTheme.bodySmall,
                                  //         ),
                                  //       ),
                                  //       Container(
                                  //         alignment: Alignment.centerRight,
                                  //         child: Text("Header::"+
                                  //           '${ConstantValues.EncryptedSetup}',
                                  //           // 'V 1.0.8',
                                  //           style: theme.textTheme.bodySmall,
                                  //         ),
                                  //       ),
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                );
              });
            }));
  }

  locateAlert() {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        // height: Screens.padingHeight(context)*0.2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.padingHeight(context) * 0.05,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(08),
                      topLeft: Radius.circular(08),
                    ),
                  )),
                  child: Text("Alert")),
            ),
            Container(
              padding: EdgeInsets.only(
                left: Screens.width(context) * 0.05,
                right: Screens.width(context) * 0.05,
                top: Screens.bodyheight(context) * 0.02,
                bottom: Screens.bodyheight(context) * 0.01,
              ),
              alignment: Alignment.center,
              child: Text(
                "Location is must for login..!!\nGo to the App Settings Change Location Status",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    });
  }

  settings(BuildContext context, LoginController logCon) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.01,
            left: Screens.width(context) * 0.03,
            right: Screens.width(context) * 0.03,
            bottom: Screens.padingHeight(context) * 0.01),
        width: Screens.width(context) * 1.1,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Screens.width(context),
                height: Screens.padingHeight(context) * 0.05,
                color: theme.primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: Screens.padingHeight(context) * 0.02,
                          right: Screens.padingHeight(context) * 0.02),
                      // color: Colors.red,
                      width: Screens.width(context) * 0.7,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Configure",
                        style: theme.textTheme.bodyText2
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          size: Screens.padingHeight(context) * 0.025,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.01,
              ),
              Form(
                key: logCon.formkey2,
                child: Column(
                  children: [
                    // Container(
                    //   alignment: Alignment.centerRight,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(3),
                    //     color: Colors.grey.withOpacity(0.001),
                    //   ),
                    //   child: TextFormField(
                    //     autofocus: true,
                    //     controller: logCon.mycontroller[2],
                    //     cursorColor: Colors.grey,
                    //     //keyboardType: TextInputType.number,
                    //     onChanged: (v) {},
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return 'Enter the Host';
                    //       } else {
                    //         return null;
                    //       }
                    //     },
                    //     decoration: InputDecoration(
                    //       errorBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(5),
                    //         borderSide: BorderSide(color: Colors.red),
                    //       ),
                    //       focusedErrorBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(5),
                    //         borderSide: BorderSide(color: Colors.red),
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(5),
                    //         borderSide: BorderSide(color: Colors.grey),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(5),
                    //         borderSide: BorderSide(color: Colors.grey),
                    //       ),
                    //       hintText: 'Host',
                    //       hintStyle: theme.textTheme.bodyText2
                    //           ?.copyWith(color: Colors.grey),
                    //       filled: false,
                    //       contentPadding: const EdgeInsets.symmetric(
                    //         vertical: 10,
                    //         horizontal: 25,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: Screens.padingHeight(context) * 0.01,
                    // ),
                    Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.001),
                      ),
                      child: TextFormField(
                        autofocus: true,
                        controller: logCon.mycontroller[3],
                        cursorColor: Colors.grey,
                        //keyboardType: TextInputType.number,
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the Customer Id';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          hintText: 'Customer ID',
                          hintStyle: theme.textTheme.bodyText2
                              ?.copyWith(color: Colors.grey),
                          filled: false,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 25,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: logCon.progrestext == true
                    ? null
                    : () {
                        st(() {
                          logCon.settingvalidate(context);
                        });
                      },
                child: Container(
                  alignment: Alignment.center,
                  height: Screens.padingHeight(context) * 0.045,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                  ),
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: logCon.progrestext == true
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Ok",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyText1
                                  ?.copyWith(color: Colors.white),
                            ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
