// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings, unused_local_variable, prefer_typing_uninitialized_variables, avoid_print, must_be_immutable

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sellerkit/Widgets/Appbar.dart';
import '../../../../Constant/Screen.dart';

class TermsAndConditionsBox extends StatefulWidget {
  TermsAndConditionsBox({
    Key? key,
  }) : super(key: key);

  @override
  State<TermsAndConditionsBox> createState() => ShowSearchDialogState();
}

class ShowSearchDialogState extends State<TermsAndConditionsBox> {
  String pathPDF = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fromAsset('Assets/terms/terms.pdf', 'demo1.pdf').then((f) {
      print('test:1');

      setState(() {
        pathPDF = f.path;
      });
    });
  }

  Future<File> fromAsset(String asset, String filename) async {
    print('test:2');

    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      print('test:' + file.toString());
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      
      body: PDFView(
        filePath: pathPDF,
        autoSpacing: true,
        enableSwipe: true,
        pageSnap: true,
        // swipeHorizontal: true,
        onError: (error) {
          print(error);
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },
        // onViewCreated: (PDFViewController vc) {
        //   pdfViewController = vc;
        // },
        // onPageChanged: (int page, int total) {
        //   print('page change: $page/$total');
        // },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back,
        ),
      ),
    );
  }
}

class Item {
  late String name;
  late double price;
  Item({required this.name, required this.price});
}
