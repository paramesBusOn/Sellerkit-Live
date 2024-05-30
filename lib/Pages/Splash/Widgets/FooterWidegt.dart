// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sellerkit/Constant/Screen.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Screens.width(context)*0.2,
             // color: Colors.red,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Row(
             
              children: [
                Container(
                  child: Text("Dont have an acount?  ",
                  style: theme.textTheme.bodySmall,
                  ),
                ),
                Container(
                  child: Text("Register",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color:theme.primaryColor),
                  ),
                ),
              ],
            ),
             SizedBox(
              width: Screens.width(context)*0.2,
              child: Divider(
                 color: Colors.black,
              ),
            ),
          ],
        ),
         SizedBox(height: Screens.padingHeight(context)*0.03),
               Center(
                        child: Text("Forgot password?",
                        style: theme.textTheme.bodySmall,
                        ),
                      ),
      ],
    );
  }
}
