// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constant/Screen.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({
    Key? key,
    required this.theme,
    required this.callback,
    required this.iconColor,
    required this.title,
    required this.icon
  }) : super(key: key);

  final ThemeData theme;
  final VoidCallback callback;
  final Color? iconColor;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        alignment: Alignment.bottomCenter,
        width: Screens.width(context)*0.25,
        height: Screens.fullHeight(context)*0.11,
        decoration: BoxDecoration(
                     //   color: Colors.red[200],
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
                        width: Screens.width(context) * 0.26,
                        alignment: Alignment.center,
                      child: Text(
                        "$title",textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText1?.copyWith(
                           color: theme.primaryColor,
                           
                           //color:Colors.red,//Colors.white,// 
                            fontWeight: FontWeight.w400),
                      ),
                    ),
          ],
        ),
      ),
    );
  }
}