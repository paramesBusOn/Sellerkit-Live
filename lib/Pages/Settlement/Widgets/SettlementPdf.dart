// ignore_for_file: public_member_api_docs, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import 'SettlementPdfHelper.dart';

class SettlementPdf extends StatefulWidget {
  const SettlementPdf({Key? key}) : super(key: key);

  @override
  State<SettlementPdf> createState() => SettlementPdfState();
}

class SettlementPdfState extends State<SettlementPdf> {
  final pdf = pw.Document();

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text(
          'Settlement',
          style: theme.textTheme.bodyText1!.copyWith(color: Colors.white),
        ),
      ),
      body: PdfPreview(
          initialPageFormat: PdfPageFormat.a4,
          dynamicLayout: true,
          onPageFormatChanged: (PdfPageFormat) {},
          build: (format) {
            return SettlementPdfHelper.generatePdf(format, 'title');
          }),
    );
  }
}
