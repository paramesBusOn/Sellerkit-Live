// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Controller/DashBoardController/DashBoardController.dart';
import '../../../Constant/Screen.dart';

class TokenWidgets extends StatelessWidget {
   TokenWidgets({
    Key? key,
    required this.theme,
    required this.name,
    required this.value,
    required this.color,
     this.newe,
     //this.count
  }) : super(key: key);

  final ThemeData theme;
  final String value;
  final String name;
  final String color;
  bool ?newe = false;
  // int? count = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,shadowColor: Colors.red,
         shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(6)
         ),
      child: GestureDetector(
       onTap: (){
      context.read<DashBoardController>().swipeRefreshIndiactor();
        },
        child: Container(
          width: Screens.width(context)*0.29,
          height: Screens.bodyheight(context)*0.12,
               alignment: Alignment.center,
               decoration: BoxDecoration(
                     color:
                    // data1[0].color=='fcedee'?
                   color=='High'?  Color(0xFFfcedee):
                    color=='Mid'? Color(0xFFebf4fa):
                    Color(0xFFebfaef),
                     // data1[0].color=='ebf4fa'?Color(0xFFebf4fa):
                     //  data1[0].color=='ebfaef'?Color(0xFFebfaef):
                      //Colors.red,
                   borderRadius: BorderRadius.circular(6),
                   ),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                //  newe==true?  Container(
                //    width: Screens.width(context)*0.12,
                //    alignment: Alignment.center,
                //      padding: EdgeInsets.symmetric(horizontal: 4),
                //      decoration: BoxDecoration(
                //        borderRadius:BorderRadius.circular(2),
                //      color:  Color(0xffC6AC5F),
                //      ),
                //      child: Text("2 New !",
                //      style: theme.textTheme.bodyText2?.copyWith(
                //        fontSize: 10
                //      ),
                //      ),
                //    ):SizedBox(),
                   Container(
                       alignment: Alignment.center,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(5)),
                       child: Text("$value",
                        textAlign: TextAlign.center,
                           style: theme.textTheme.subtitle1 
                               ?.copyWith(color:theme.primaryColor,fontWeight: FontWeight.w500))),//
                   Container(
                       alignment: Alignment.topCenter,
                       child: Text(
                        textAlign: TextAlign.center,
                         "$name",
                         style: theme.textTheme.bodyText2?.copyWith(
                           fontSize: 12
                           )
                       )),
                 ],
               ),
             ),
      ),
    );
  }
}