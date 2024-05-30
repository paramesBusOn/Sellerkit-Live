// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Widgets/Appbar.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/FeedCreationcontroller/FeedCrtController.dart';
import '../../../Widgets/Navi3.dart';
import '../widgets/RecordingPage.dart';
import '../widgets/FeedCreationPage.dart';

class FeedCrt extends StatefulWidget {
  FeedCrt({Key? key}) : super(key: key);

  @override
  State<FeedCrt> createState() => _FeedCrtState();
}

class _FeedCrtState extends State<FeedCrt> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return 
           Scaffold(
        drawer: drawer3(context),
        appBar: appbar("Feed Creation", scaffoldKey, theme, context),
             body: SafeArea(
               child: ChangeNotifierProvider<FeedCreationProv>(
                  create: (context) => FeedCreationProv(),
                  builder: (context, child) {
                    return Consumer<FeedCreationProv>(
                        builder: (BuildContext context, fdp, Widget? child) {
                      return
                  
         FeedCreationPage(theme: theme, fdp: fdp,);
                     
                    });
                  }),
             ),
           );
        
  }




}


//  Container(
//            // height: Screens.bodyheight(context) * 0.06,
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(
//                     Screens.width(context) * 0.01),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.7),
//                     spreadRadius: 3,
//                     blurRadius: 4,
//                     offset: Offset(0, 3), // changes position of shadow
//                   ),
//                 ]),
//             child: TextField(
//               autocorrect: false,
//               onChanged: (v) {},
//               decoration: InputDecoration(
//                 filled: true,
//                 hintText: 'Title',
//                 enabledBorder: InputBorder.none,
//                 focusedBorder: InputBorder.none,
//                 // suffixIcon: Icon(
//                 //   Icons.search,
//                 //   color: theme.primaryColor,
//                 // ),
//                 contentPadding: const EdgeInsets.symmetric(
//                   vertical: 12,
//                   horizontal: 5,
//                 ),
//               ),
//             ),
//           ),
