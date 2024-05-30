// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, prefer_const_constructors_in_immutables

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:sellerkit/Constant/ConstantRoutes.dart';
// import 'package:sellerkit/Constant/ConstantSapValues.dart';
// import 'package:sellerkit/Constant/Screen.dart';
// import 'package:sellerkit/Controller/WalkinController/WalkinController.dart';
// import '../../../Constant/padings.dart';
// import '../../../DBModel/ItemMasertDBModel.dart';
// import '../../../Widgets/Appbar.dart';
// import '../../../Widgets/Navi3.dart';

// class StockListOfDetails extends StatefulWidget {
//   StockListOfDetails({Key? key}) : super(key: key);

//   @override
//   State<StockListOfDetails> createState() => StockListOfDetailsState();
// }

// class StockListOfDetailsState extends State<StockListOfDetails> {
  
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   Paddings paddings = Paddings();
//     DateTime? currentBackPressTime;
//   Future<bool> onbackpress() {
//     DateTime now = DateTime.now();//WalkinController
//     if (currentBackPressTime == null ||
//         now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
//       currentBackPressTime = now;
//        print("are you sure");
//    //if(context.read<WalkinController>().getviewAll[0].brand != 'null'){
     
//      print("segment");
//   context.read<WalkinController>().segmentViewAllData().then((value) {
//        context.read<WalkinController>().clearViewAllData();
//      });
    
//     }
//    ScaffoldMessenger.of(context).removeCurrentSnackBar();
//       return Future.value(true);
//   }
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return WillPopScope(
//       onWillPop: onbackpress,
//       child: Scaffold(       
//           drawerEnableOpenDragGesture: false,
//           key: scaffoldKey,
//           appBar: appbar("Walkin", scaffoldKey, theme, context),
//           drawer: drawer3(context),
//           body: Container(
//             alignment: Alignment.center,
//             width: Screens.width(context),
//             height: Screens.bodyheight(context),
//             padding: paddings.padding3(context),
//             child: GestureDetector(onHorizontalDragUpdate: (details) {
//                     // Check if the user is swiping from left to right
//                     print(details.primaryDelta);
//                     if (details.primaryDelta! > ConstantValues.slidevalue!) {
//                       setState(() {
//                         Get.offAllNamed(ConstantRoutes.stock);
//                       });
//                     }
//                   },
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: 1,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Center(
//                           child: Wrap(
//                               spacing: 10.0, // gap between adjacent chips
//                               runSpacing: 15.0, // gap between lines
//                               children:
//                                   listContainersProduct(theme, 
//                                   context.read<WalkinController>().getviewAll
//                                    )),
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(
//                     width: Screens.width(context),
//                     child: ElevatedButton(
//                       onPressed: () {
                      
//                  print("segment");
//              context.read<WalkinController>().isselectedSegment().then((value) {
//                   //  context.read<WalkinController>().clearViewAllData();
//                  });
                
//                       },
//                       child: Text("Ok"),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )),
//     );
//   }

//   List<Widget> listContainersProduct(
//     ThemeData theme,
//     List<ItemMasterDBModel> content,
//   ) {
//     // if(content[0].brand != 'null'){
//   //  if(context.read<WalkinController>().getviewAllBrandSelected == true){
//   //     return List.generate(
//   //  context.read<WalkinController>().getviewAll.length,
//   //   //    content.length,
//   //       (index) => GestureDetector(
//   //         onTap: () {
//   //           context.read<WalkinController>().isselectedBrandViewAll(index);
//   //         },
//   //         child: Container(
//   //           alignment: Alignment.center,
//   //           width: Screens.width(context) * 0.28,
//   //           height: Screens.bodyheight(context) * 0.06,
//   //           padding: EdgeInsets.all(5),
//   //           decoration: BoxDecoration(
//   //               color:  context.watch<WalkinController>().getviewAll[index].isselected==1
//   //          //     content[index].isselected == 1
//   //                   ? theme.primaryColor
//   //                   : Colors.white,
//   //               border: Border.all(color: theme.primaryColor, width: 1),
//   //               borderRadius: BorderRadius.circular(10)),
//   //           child: Column(
//   //             mainAxisAlignment: MainAxisAlignment.center,
//   //             children: [
//   //               Text(content[index].brand,
//   //                   maxLines: 1,
//   //                   overflow: TextOverflow.ellipsis,
//   //                   style: theme.textTheme.bodyText1?.copyWith(
//   //                     fontSize: 10,
//   //                     color: 
//   //        context.watch<WalkinController>().getviewAll[index].isselected==1             
//   //                     //content[index].isselected == 1
//   //                         ? Colors.white
//   //                         : theme.primaryColor,
//   //                   ))
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     );
   
//   //   }
//   //   // else if(content[0].category != 'null'){

//   //     else if(context.read<WalkinController>().getviewAllProductSelected == true){
     
//   //     return List.generate(
//   //       content.length,
//   //       (index) => GestureDetector(
//   //         onTap: () {
//   //           context.read<WalkinController>().isselectedProductViewAll(index);
//   //         },
//   //         child: Container(
//   //           alignment: Alignment.center,
//   //           width: Screens.width(context) * 0.28,
//   //           height: Screens.bodyheight(context) * 0.06,
//   //           padding: EdgeInsets.all(5),
//   //           decoration: BoxDecoration(
//   //               color:
//   //               context.watch<WalkinController>().getviewAll[index].isselected == 1
//   //               // content[index].isselected == 1
//   //                   ? theme.primaryColor
//   //                   : Colors.white,
//   //               border: Border.all(color: theme.primaryColor, width: 1),
//   //               borderRadius: BorderRadius.circular(10)),
//   //           child: Column(
//   //             mainAxisAlignment: MainAxisAlignment.center,
//   //             children: [
//   //               Text(content[index].category,
//   //                   maxLines: 1,
//   //                   overflow: TextOverflow.ellipsis,
//   //                   style: theme.textTheme.bodyText1?.copyWith(
//   //                     fontSize: 10,
        
//   //                    color:
//   //                    context.watch<WalkinController>().getviewAll[index].isselected == 1
//   //                    // content[index].isselected == 1
//   //                         ? Colors.white
//   //                         : theme.primaryColor,
//   //                   ))
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     );
    
//   //   }
//     /// ELSE 
//     /// 
//       return List.generate(
//         content.length,
//         (index) => GestureDetector(
//           onTap: () {
//             context.read<WalkinController>().isselectedSegment(content[index].segment);
//           },
//           child: Container(
//             alignment: Alignment.center,
//             width: Screens.width(context) * 0.28,
//             height: Screens.bodyheight(context) * 0.06,
//             padding: EdgeInsets.all(5),
//             decoration: BoxDecoration(
//                 color: context.watch<WalkinController>().isSelectedDivision ==
//                         context.watch<WalkinController>().getviewAll[index].segment
                
//                 //content[index].isselected == 1
//                     ? theme.primaryColor
//                     : Colors.white,
//                 border: Border.all(color: theme.primaryColor, width: 1),
//                 borderRadius: BorderRadius.circular(10)),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(content[index].segment,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: theme.textTheme.bodyText1?.copyWith(
//                       fontSize: 10,
//                       color: 
//                      context.watch<WalkinController>().isSelectedDivision ==
//                         context.watch<WalkinController>().getviewAll[index].segment
//                       //content[index].isselected == 1
//                           ? Colors.white
//                           : theme.primaryColor,
//                     ))
//               ],
//             ),
//           ),
//         ),
//       );
   
//   }
// }
