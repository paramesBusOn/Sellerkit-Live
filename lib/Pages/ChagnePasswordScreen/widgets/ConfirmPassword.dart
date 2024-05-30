import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Helper.dart';
import 'package:sellerkit/Controller/LoginController/LoginController.dart';
import 'package:sellerkit/Pages/Splash/Widgets/custom_elevatedBtn.dart';

import '../../../Constant/ConstantRoutes.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/ChangePasswordContoller/ChangepwdCtrl.dart';
import '../../../Widgets/custom_shake_transtition.dart';

class ConfirmPasswordPage extends StatefulWidget {
  const ConfirmPasswordPage({Key? key}) : super(key: key);

  @override
  State<ConfirmPasswordPage> createState() => _ConfirmPasswordPageState();
}

class _ConfirmPasswordPageState extends State<ConfirmPasswordPage> {
  Paddings constant = Paddings();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            body: ChangeNotifierProvider<ChangePasswordController>(
                create: (context) => ChangePasswordController(),
                builder: (context, child) {
                  return Consumer<ChangePasswordController>(
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
                                  "Old Password",
                                  style: theme.textTheme.bodyLarge
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
                                      if (value!.isEmpty) {
                                        return "Enter Old Password";
                                      } else if (prdconf!.mycontroller[6].text !=
                                          prdconf.oldPassword) {
                                        return "Invalid Password";
                                      }
                                      return null;
                                    },
                                    obscureText: true,
                                    controller: prdconf.mycontroller[6],
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
                                  "New Password",
                                  style: theme.textTheme.bodyLarge
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
                                        return "Enter New Password";
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
                                  style: theme.textTheme.bodyLarge
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
                                        return "Enter Confirm Password";
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
