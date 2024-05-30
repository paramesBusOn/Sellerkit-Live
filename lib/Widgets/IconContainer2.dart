// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constant/Screen.dart';

class IconContainer2 extends StatelessWidget {
  const IconContainer2({
    Key? key,
    required this.theme,
    required this.callback,
    required this.iconColor,
    required this.title,
    required this.icon,
    this.textalign,
  }) : super(key: key);

  final ThemeData theme;
  final VoidCallback callback;
  final Color? iconColor;
  final String title;
  final IconData icon;
  final TextAlign? textalign;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        alignment: Alignment.bottomCenter,
        width: Screens.width(context)*0.29,
        height: Screens.fullHeight(context)*0.11,
        decoration: BoxDecoration(
                      //  color: Colors.red[200],
          borderRadius: BorderRadius.circular(8)
        ),
        child:iconColor==null?SizedBox(): Column(
          mainAxisAlignment:   MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: Screens.width(context) * 0.26,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                      width: Screens.width(context) * 0.108,
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withOpacity(0.2),//,Colors.amber,
                        borderRadius: BorderRadius.circular(10)
                      ),
                    child: Icon(
                     icon,// Icons.home,
                      color: iconColor,//Colors.red,//Colors.white,
                      size: Screens.padingHeight(context) * 0.04,
                    ),
                  ),
               
                ],
              ),
            ),
                   Container(
                    // color:Colors.amber,
                        width: Screens.width(context) * 0.38,
                        alignment: Alignment.center,
                      child: Text(
                        "$title",
                        textAlign: textalign,
                        style: theme.textTheme.bodyText1?.copyWith(
                           color: theme.primaryColor,//color:Colors.red,//Colors.white,// 
                            fontWeight: FontWeight.w400),
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}