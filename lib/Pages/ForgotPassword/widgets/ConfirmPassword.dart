import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Controller/ForgotPasswordController/ForgotPasswordController.dart';
import 'package:sellerkit/Controller/LoginController/LoginController.dart';
import 'package:sellerkit/Pages/Splash/Widgets/custom_elevatedBtn.dart';

import '../../../Constant/ConstantRoutes.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Widgets/custom_shake_transtition.dart';

class ForgotConfirmPasswordPage extends StatefulWidget {
  const ForgotConfirmPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotConfirmPasswordPage> createState() => _ForgotConfirmPasswordPageState();
}

class _ForgotConfirmPasswordPageState extends State<ForgotConfirmPasswordPage> {
  Paddings constant = Paddings();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return WillPopScope(
        onWillPop: () {
          //  onbackpresslogin,
          if (LoginController.loginPageScrn == true) {
            onbackpresslogin();
          } else {
            onbackpressprofile();
          }
          return Future.value(false);
        },
        child: Scaffold(
            body: ChangeNotifierProvider<ForgotPasswordController>(
                create: (context) => ForgotPasswordController(),
                builder: (context, child) {
                  return Consumer<ForgotPasswordController>(
                      builder: (BuildContext context, prdconf, Widget? child) {
                    return SafeArea(
                        child: Center(
                      child: Container(
                        padding: constant.padding2(context),
                        child: Form(
                          key: prdconf.formkey[2],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: Screens.padingHeight(context) * 0.04),
                              CustomShakeTransition(
                                child: Text(
                                  "New Password",
                                  style: theme.textTheme.headline6
                                      ?.copyWith(color: theme.primaryColor),
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                height: Screens.padingHeight(context) * 0.01,
                              ),
                              CustomShakeTransition(
                                duration: const Duration(milliseconds: 900),
                                child: SizedBox(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (prdconf.mycontroller[4].text !=
                                          prdconf.mycontroller[5].text) {
                                        return "*Not Match";
                                      } else if (prdconf
                                          .mycontroller[4].text.isEmpty) {
                                        return "Please Enter Password";
                                      }

                                      return null;
                                    },
                                    //  validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return "Please Enter new Password";
                                    //   }

                                    //   return null;
                                    // },
                                    obscureText: true,
                                    controller: prdconf.mycontroller[4],
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                    ),
                                    cursorColor: Colors.green,
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: Screens.padingHeight(context) * 0.05),
                              CustomShakeTransition(
                                child: Text(
                                  "Confirm Password",
                                  style: theme.textTheme.headline6
                                      ?.copyWith(color: theme.primaryColor),
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                height: Screens.padingHeight(context) * 0.01,
                              ),
                              CustomShakeTransition(
                                duration: Duration(milliseconds: 900),
                                child: SizedBox(
                                  child: TextFormField(
                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return "Please Enter Confirm Password";
                                    //   }

                                    //   return null;
                                    // },
                                    validator: (value) {
                                      if (prdconf.mycontroller[4].text !=
                                          prdconf.mycontroller[5].text) {
                                        return "*Not Match";
                                      } else if (prdconf
                                          .mycontroller[5].text.isEmpty) {
                                        return "Please Enter Password";
                                      }

                                      return null;
                                    },
                                    obscureText: true,
                                    controller: prdconf.mycontroller[5],
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                    ),
                                    cursorColor: Colors.green,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Screens.padingHeight(context) * 0.04,
                              ),
                              CustomSpinkitdButton(
                                onTap: () {
// if (prdconf.formkey[2].currentState!.validate()) {
//   if(prdconf.mycontroller[4].text==prdconf.mycontroller[5].text){
// prdconf.confirmpwd();

//   }

//   }
                                  prdconf.valdationconfirmpwd(context);
                                },
                                isLoading: prdconf.isLoadingRest,
                                labelLoading: 'Reseting',
                                label: 'Reset',
                                textcolor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
                  });
                })));
  }

  DateTime? currentBackPressprofile;
  Future<bool> onbackpressprofile() {
    DateTime now = DateTime.now();
    if (currentBackPressprofile == null ||
        now.difference(currentBackPressprofile!) > Duration(seconds: 2)) {
      currentBackPressprofile = now;
      Get.offAllNamed(ConstantRoutes.newprofile);
      return Future.value(false);
    }
    return Future.value(false);
  }

  DateTime? currentBackPressLogin;

  Future<bool> onbackpresslogin() {
    DateTime now = DateTime.now();
    if (currentBackPressLogin == null ||
        now.difference(currentBackPressLogin!) > Duration(seconds: 2)) {
      currentBackPressLogin = now;
      Get.offAllNamed(ConstantRoutes.login);
      return Future.value(false);
    }
    return Future.value(false);
  }
}
