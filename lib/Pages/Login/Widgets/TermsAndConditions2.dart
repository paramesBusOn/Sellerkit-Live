// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, unused_local_variable, prefer_typing_uninitialized_variables, avoid_print, must_be_immutable

// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdfx/pdfx.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../../../../Constant/Screen.dart';

// class TermsAndConditionsBox2 extends StatefulWidget {
//   TermsAndConditionsBox2({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<TermsAndConditionsBox2> createState() => ShowSearchDialogState();
// }

// class ShowSearchDialogState extends State<TermsAndConditionsBox2> {
//   String pathPDF = "";

//  PdfController pdfController = PdfController(
//   document: PdfDocument.openAsset('Assets/terms/terms.pdf'),
// );

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return
//         // AlertDialog(
//         //   shape: RoundedRectangleBorder(
//         //     borderRadius: BorderRadius.circular(5.0),
//         //   ),
//         //   content:
//         Scaffold(
//           // resizeToAvoidBottomInset: true,
//           appBar: AppBar(
//             backgroundColor: theme.primaryColor,
//             title: Text('Terms and Conditions'),),
//       body: PdfView(
//          scrollDirection : Axis.vertical,
//       controller: pdfController,
//       backgroundDecoration:BoxDecoration(color: Colors.grey[300])
//     )
// ,
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     Get.back();
//       //   },
//       //   child: Icon(
//       //     Icons.arrow_back,
//       //   ),
//       // ),
//     );
//     // );
//   }
// }

// class Item {
//   late String name;
//   late double price;
//   Item({required this.name, required this.price});
// }
