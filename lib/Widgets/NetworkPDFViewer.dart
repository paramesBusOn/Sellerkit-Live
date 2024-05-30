// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'Appbar.dart';

class PDFViewerFromUrl extends StatefulWidget {
   PDFViewerFromUrl({Key? key, required this.url,required this.appbarreq,
   required this.title

   }) : super(key: key);

  final String url;
   bool appbarreq = false;
   final String? title;


  @override
  State<PDFViewerFromUrl> createState() => _PDFViewerFromUrlState();
}

class _PDFViewerFromUrlState extends State<PDFViewerFromUrl> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     url = '';
     url = widget.url;
     log("url changed: ${url}");
    setState(() {});
  }
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  
  String url = '';
  @override
  Widget build(BuildContext context) {
    final theme =  Theme.of(context);
    return Scaffold(
      appBar: 
      widget.appbarreq == false?null:
      appbar(widget.title!,scaffoldKey,theme,context),
      body: Container(
       
        child: 
        url.isEmpty?
        CircularProgressIndicator()
        :
        PDF(
          enableSwipe: true,
          swipeHorizontal: true,
        ).cachedFromUrl(
          url,
          placeholder: (double progress) => Center(child: Text('$progress %')),
          errorWidget: (dynamic error) => Center(child: Text(error.toString())),
        ),
      ),
    );
  }
}