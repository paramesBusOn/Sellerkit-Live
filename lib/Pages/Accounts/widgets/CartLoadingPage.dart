import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';

import '../../../Constant/Screen.dart';

class Cartloading extends StatefulWidget {
  const Cartloading({Key? key}) : super(key: key);

  @override
  State<Cartloading> createState() => _CartloadingState();
}

class _CartloadingState extends State<Cartloading> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
      child: Container(
        width: Screens.width(context),
        height: Screens.bodyheight(context),
        padding: EdgeInsets.symmetric(
            horizontal: Screens.width(context) * 0.03,
            vertical: Screens.bodyheight(context) * 0.02),
        child:
            //  context.watch<DownLoadController>().exception == true &&
            //         context.watch<DownLoadController>().getErrorMsg != ''
            //     ? Center(
            //         child: Text('${context.watch<DownLoadController>().errorMsg}'),
            //       )
            //     :
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.toNamed(ConstantRoutes.accounts);
                // HelperFunctions.clearCheckedOnBoardSharedPref();
                // HelperFunctions.clearUserLoggedInSharedPref();
              },
              child: Lottie.asset('Assets/cart2.json',
                  animate: true,
                  repeat: true,
                  height: Screens.padingHeight(context) * 0.3,
                  width: Screens.width(context) * 0.3),
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Screens.width(context) * 0.3),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                ))
          ],
        ),
      ),
    ));
  }
}
