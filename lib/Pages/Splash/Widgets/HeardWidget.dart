// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sellerkit/Constant/Screen.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         SizedBox(height: Screens.padingHeight(context) * 0.03),
        Container(
            alignment: Alignment.center,
            width: Screens.width(context),
            padding: EdgeInsets.all(10),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: CircleAvatar(
              backgroundImage: AssetImage('Assets/SellerSymbol.png'),
              backgroundColor: Colors.white,
              radius: Screens.padingHeight(context) * 0.08,
            )),
        SizedBox(height: Screens.padingHeight(context) * 0.1),
        Container(
            alignment: Alignment.center,
            width: Screens.width(context),
            // color: Colors.white,
            // padding: EdgeInsets.symmetric(horizontal: Screens.width(context)*0.15),
            child: Text(
              "Welcome to the new",
              style: theme.textTheme.headline5?.copyWith(color: Colors.white),
            )),
        Container(
            alignment: Alignment.center,
            width: Screens.width(context),
            //  color: Colors.white,
            // padding: EdgeInsets.symmetric(horizontal: Screens.width(context)*0.15),
            child: Text(
              "Seller kit",
              style: theme.textTheme.headline5?.copyWith(color: Colors.white),
            )),
        SizedBox(height: Screens.padingHeight(context) * 0.1),
        Container(
            alignment: Alignment.center,
            width: Screens.width(context),
             padding: EdgeInsets.all(0),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('Assets/thum.png'),
              radius: Screens.padingHeight(context) * 0.045,
            )),
        SizedBox(height: Screens.padingHeight(context) * 0.015),
      ],
    );
  }
}
