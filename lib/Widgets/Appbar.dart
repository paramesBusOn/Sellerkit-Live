// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/PriceListController/PriceListController.dart';
import 'package:sellerkit/Controller/StockAvailabilityController/StockListController.dart';
import 'package:sellerkit/Widgets/qrpage.dart';

AppBar appbar(String titles,GlobalKey<ScaffoldState> key,ThemeData theme,BuildContext context){
  return AppBar(
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       
      GestureDetector(
      onTap: (){
      //  print("object");
       key.currentState?.openDrawer();
      },
      child: Icon(Icons.menu,
      color: theme.primaryColor,
      )),
      
        Container(child: Text(titles,
        style:theme.textTheme.headline6?.copyWith(color: theme.primaryColor,fontWeight: FontWeight.normal),
        ),),
//     titles =="Stock List"? Container(
//             // alignment: Alignment.center,
//             child: IconButton(
//               onPressed: (){
//                 // setState(() {
//                    context.read<StockListController>().     scannerreset();
//                    qrscannerState.stockscan=true;
//                 Navigator.push(context,MaterialPageRoute(builder: (_) => qrscanner()))
// //                 .then((value){
// // return context.read<StockListController>().scanneddataget(context);
// //                 } 
// //                  )
//                  ;
//                 // });
           
//               },
//               icon: Icon(Icons.qr_code_scanner_outlined,color: theme.primaryColor,size: 30,)),
//           ):
          
//      titles =="Price List"?     Container(
//             // alignment: Alignment.center,
//             child: IconButton(
//               onPressed: (){
//                 // setState(() {
//                    context.read<PriceListController>().     scannerreset();
//                    qrscannerState.pricelistscan=true;
//                 Navigator.push(context,MaterialPageRoute(builder: (_) => qrscanner()))
// //                 .then((value){
// // return context.read<PriceListController>().scanneddataget(context);
// //                 } 
// //                  )
//                  ;
//                 // });
           
//               },
//               icon: Icon(Icons.qr_code_scanner_outlined,color: theme.primaryColor,size: 30,)),
//           )
          
//           :
             Container(
          width: Screens.width(context)*0.15,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
         // color: Colors.red  
          ),
          child: Image.asset("Assets/SellerSymbol.png", fit: BoxFit.fill,),),
      ],
    ),
  );
}