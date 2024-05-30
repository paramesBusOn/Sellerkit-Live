// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Constant/Screen.dart';
import '../../../Constant/padings.dart';
import '../../../Controller/ForgotPasswordController/ForgotPasswordController.dart';
import '../widgets/ForgotBodySection.dart';

class ForgotRegisterPage extends StatefulWidget {
  const ForgotRegisterPage({Key? key}) : super(key: key);

  @override
  State<ForgotRegisterPage> createState() => ForgotRegisterPageState();
}

class ForgotRegisterPageState extends State<ForgotRegisterPage> {
  Paddings constant = Paddings();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // context.read<ForgotPasswordController>().disPosed();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            width: Screens.width(context),
            height: Screens.padingHeight(context),
            //  decoration: BoxDecoration(
            //    color: Colors.white
            //  ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //  Stack(
              children: [
                //       Container(
                //   width: Screens.width(context),
                //   height: Screens.padingHeight(context) * 0.3,
                //   decoration: BoxDecoration(
                //       color: theme.primaryColor,
                //       borderRadius: BorderRadius.only(
                //           bottomLeft:
                //               Radius.circular(Screens.width(context) * 0.2))),
                //   padding: EdgeInsets.only(
                //       top: Screens.padingHeight(context) * 0.1,
                //       right: Screens.width(context) * 0.1,
                //       left: Screens.width(context) * 0.1),
                //   alignment: Alignment.center,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Text(
                //         "Forgot password",
                //         style: theme.textTheme.headline5
                //             ?.copyWith(color: Colors.white),
                //       )
                //     ],
                //   ),
                // ),
                // Positioned(
                //    top: Screens.padingHeight(context) * 0.3,
                //   child: BodySection()//)
                ForgotBodySection()
              ],
            ),
          ),
        )));
  }
}
