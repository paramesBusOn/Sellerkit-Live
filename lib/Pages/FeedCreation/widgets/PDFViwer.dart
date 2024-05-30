import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PDFViewePage extends StatefulWidget {
   PDFViewePage({Key? key, required this.document,}) : super(key: key);
  final PDFDocument document;
  @override
  State<PDFViewePage> createState() => PDFViewePageState();
}

class PDFViewePageState extends State<PDFViewePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
      ),
      body: Center(
          child: widget.document == null
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(document: widget.document)),
    );
  }
}