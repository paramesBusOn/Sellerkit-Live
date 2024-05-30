// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, require_trailing_commas, prefer_single_quotes, prefer_const_constructors, file_names, unused_label

import 'package:flutter/material.dart';
import '../../../Constant/Screen.dart';

 AppBar orderAppBar(BuildContext context, GlobalKey<ScaffoldState> keys,String title) {
  // key:keys;
  final width = MediaQuery.of(context).size.width;
  bool isTSH = false;
  final theme = Theme.of(context);
  return AppBar(
      // leading: GestureDetector(
      //     onTap: () {
      //       key.currentState!.openDrawer();
      //     },
      //     child: Icon(
      //       Icons.menu,
      //       color: Colors.white,
      //     )),
       backgroundColor: theme.primaryColor,
      // title: StatefulBuilder(
      //   builder: (context, setState) => Container(
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.only(right: 20),
      //           child: Container(
      //             child: Column(
      //               children: [
      //                 Text(
      //                  title, //AppLocalizations.of(context)!.dashboard,
      //                   style: TextStyle(
      //                       fontSize: title.length>10? Screens.width(context) * 0.04:  Screens.width(context) * 0.045,
      //                       color: Colors.white,
      //                       fontWeight: FontWeight.w600),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
             
      //       ],
      //     ),
      //   ),
      // ),
     // bottom:
     automaticallyImplyLeading: false,
      title:
       PreferredSize(
      preferredSize: const Size.fromHeight(50),
     child: Container(
       height: 46,
        width: Screens.width(context),
      decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.backgroundColor),
                color:theme. backgroundColor
              ),

                    child: TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.primaryColor),
                  color: theme.primaryColor,
                ),
                labelColor: theme.backgroundColor,
                unselectedLabelColor: theme.primaryColor,
                tabs: [
                  Tab(text: 'Feeds'),
                  Tab(text: 'KPI'),
                  Tab(text:'Dashboard'),
                ],
              ),
     ), ),
      );

      
}