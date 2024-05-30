// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:sellerkit/Constant/Screen.dart';

class Paddings{
  EdgeInsets padding1(BuildContext context){
    return EdgeInsets.only(
      top: Screens.padingHeight(context)*0.05,
      bottom: Screens.padingHeight(context)*0.05,
      left: Screens.width(context)*0.03,
      right: Screens.width(context)*0.03,
    );
  }

   EdgeInsets padding2(BuildContext context){
    return EdgeInsets.only(
      top: Screens.bodyheight(context)*0.005,
      bottom: Screens.bodyheight(context)*0.01,
      left: Screens.width(context)*0.03,
      right: Screens.width(context)*0.03,
    );
  }

    EdgeInsets padding3(BuildContext context){
    return EdgeInsets.only(
      top: Screens.padingHeight(context)*0.02,
      bottom: Screens.padingHeight(context)*0.02,
      left: Screens.width(context)*0.03,
      right: Screens.width(context)*0.03,
    );
  }


}