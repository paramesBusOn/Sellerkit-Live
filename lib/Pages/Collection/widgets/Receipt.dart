// ignore_for_file: prefer_const_constructors

import 'dart:typed_data';
// import 'package:collectionapp/Constant/Screen.dart';
// import 'package:collectionapp/Services/Model/InvoiceModel.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
import 'package:sellerkit/Controller/CollectionController/NewCollectionEntryCotroller.dart';


class reportt extends StatefulWidget {
// static List<InvoiceDetails>? dasa;

  @override
  State<reportt> createState() => reporttState();
}

class reporttState extends State<reportt> {
  final pdf = pw.Document();
  static List<InvoiceData>? dasa = [];

  // static List<InvoiceDetails>? dasa = [];
  var name;
  var subject1;
  var subject2;
  var subject3;
  var marks;

  // List<InvoiceDetails> sample = [];
  void initState() {
    // setState(() {
    //   print(dasa![0].id);
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("title")),

      // appBar: appbar("PDF Details", "", "", theme, context),
      body: Center(
        // child: PdfPreview(
        //   maxPageWidth: width,
        //   // // useActions: false,
        //   canChangePageFormat: false,
        //   canChangeOrientation: false,
        //   // // pageFormats:pageformat,
        //   canDebug: false,

        //   build: (format) => _generatePdf(format, "title"),
        // ),
      ),
    );
  }

  // Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
  //   final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  //   final font = await PdfGoogleFonts.nunitoExtraLight();
  //   final width = MediaQuery.of(context).size.width;
  //   final height = MediaQuery.of(context).size.height;

  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: format,
  //       build: (context) {
  //         final headers = [
  //           "S.No",
  //           "Invoice Document No",
  //           "Total",
  //           "Total Payment",
  //           // "EMI Date",
  //           // "EMI Status",
  //           // "Reason"
  //         ];
  //         List<List<dynamic>> data;
  //         data = dasa!.map((e) {
  //           // final total = ("123312");
  //           return [
  //             '${e.id}',
  //             '${e.invoiceNo}',
  //             '${e.total}',
  //             '${e.totalPayment}',
  //           ];
  //         }).toList();
  //         return pw.Column(
  //           children: [
  //             pw.SizedBox(height: height * 0.03),

  //             pw.Container(
  //               alignment: pw.Alignment.center,
  //               child: pw.Text(
  //                 'Incoming Payment',
  //                 style: pw.TextStyle(
  //                   // fontWeight:FontWeight.bold,
  //                   fontSize: 20,
  //                 ),
  //               ),
  //             ),
  //             pw.SizedBox(height: height * 0.03),

  //             pw.Container(
  //                 padding: pw.EdgeInsets.all(height * 0.01),
  //                 width: width * 1.5,
  //                 alignment: pw.Alignment.center,
  //                 decoration: pw.BoxDecoration(border: pw.Border.all()),
  //                 child: pw.Column(
  //                   children: [
  //                     pw.Row(
  //                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         pw.Column(
  //                           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                           // mainAxisAlignment: pw.MainAxisAlignment.start,
  //                           children: [
  //                             pw.Container(
  //                               alignment: pw.Alignment.centerLeft,
  //                               child: pw.Text(
  //                                 'Customer Code',
  //                                 style: pw.TextStyle(
  //                                   // fontWeight:FontWeight.bold,
  //                                   fontSize: 14,
  //                                 ),
  //                               ),
  //                             ),
  //                             pw.Container(
  //                               alignment: pw.Alignment.centerLeft,
  //                               child: pw.Text(
  //                                 'C0098',
  //                                 style: pw.TextStyle(
  //                                   // fontWeight:FontWeight.bold,
  //                                   fontSize: 14,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         pw.Column(
  //                           crossAxisAlignment: pw.CrossAxisAlignment.end,
  //                           children: [
  //                             pw.Container(
  //                               alignment: pw.Alignment.centerRight,
  //                               child: pw.Text(
  //                                 'Doc No',
  //                                 style: pw.TextStyle(
  //                                   // fontWeight:FontWeight.bold,
  //                                   fontSize: 14,
  //                                 ),
  //                               ),
  //                             ),
  //                             pw.Container(
  //                               alignment: pw.Alignment.centerRight,
  //                               child: pw.Text(
  //                                 '12',
  //                                 style: pw.TextStyle(
  //                                   // fontWeight:FontWeight.bold,
  //                                   fontSize: 14,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                     pw.SizedBox(height: height * 0.01),
  //                     pw.Row(
  //                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         pw.Column(
  //                           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                           children: [
  //                             pw.Container(
  //                               alignment: pw.Alignment.centerLeft,
  //                               child: pw.Text(
  //                                 'Customer Name',
  //                                 style: pw.TextStyle(
  //                                   // fontWeight:FontWeight.bold,
  //                                   fontSize: 15,
  //                                 ),
  //                               ),
  //                             ),
  //                             pw.Container(
  //                               alignment: pw.Alignment.centerLeft,
  //                               child: pw.Text(
  //                                 'Paramesvaran',
  //                                 style: pw.TextStyle(
  //                                   // fontWeight:FontWeight.bold,
  //                                   fontSize: 15,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         pw.Column(
  //                           crossAxisAlignment: pw.CrossAxisAlignment.end,
  //                           mainAxisAlignment: pw.MainAxisAlignment.end,
  //                           children: [
  //                             pw.Container(
  //                               alignment: pw.Alignment.centerRight,
  //                               child: pw.Text(
  //                                 'Doc Date',
  //                                 style: pw.TextStyle(
  //                                   // fontWeight:FontWeight.bold,
  //                                   fontSize: 15,
  //                                 ),
  //                               ),
  //                             ),
  //                             pw.Container(
  //                               alignment: pw.Alignment.centerRight,
  //                               child: pw.Text(
  //                                 '03/08/2023',
  //                                 style: pw.TextStyle(
  //                                   // fontWeight:FontWeight.bold,
  //                                   fontSize: 15,
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                     pw.SizedBox(height: height * 0.01),
  //                     // pw.Row(
  //                     //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                     //     children: [
  //                     //       pw.Container(
  //                     //         decoration:
  //                     //             pw.BoxDecoration(border: pw.Border.all()),
  //                     //         child: pw.Text(
  //                     //           'S.No',
  //                     //           style: pw.TextStyle(
  //                     //             // fontWeight:FontWeight.bold,
  //                     //             fontSize: 14,
  //                     //           ),
  //                     //         ),
  //                     //       ),
  //                     //       pw.Container(
  //                     //         decoration:
  //                     //             pw.BoxDecoration(border: pw.Border.all()),
  //                     //         child: pw.Text(
  //                     //           'Invoice Document No',
  //                     //           style: pw.TextStyle(
  //                     //             // fontWeight:FontWeight.bold,
  //                     //             fontSize: 14,
  //                     //           ),
  //                     //         ),
  //                     //       ),
  //                     //       pw.Container(
  //                     //         decoration:
  //                     //             pw.BoxDecoration(border: pw.Border.all()),
  //                     //         child: pw.Text(
  //                     //           'Total',
  //                     //           style: pw.TextStyle(
  //                     //             // fontWeight:FontWeight.bold,
  //                     //             fontSize: 14,
  //                     //           ),
  //                     //         ),
  //                     //       ),
  //                     //       pw.Container(
  //                     //         decoration:
  //                     //             pw.BoxDecoration(border: pw.Border.all()),
  //                     //         child: pw.Text(
  //                     //           'Total Payment',
  //                     //           style: pw.TextStyle(
  //                     //             // fontWeight:FontWeight.bold,
  //                     //             fontSize: 14,
  //                     //           ),
  //                     //         ),
  //                     //       ),
  //                     //     ]),
  //                     pw.Table.fromTextArray(
  //                         cellAlignment: pw.Alignment.center,
  //                         headerStyle: pw.TextStyle(
  //                           fontSize: 14.0,
  //                         ),
  //                         cellStyle: pw.TextStyle(
  //                           fontSize: 14.0,
  //                         ),
  //                         // columnWidths: {
  //                         //   0: pw.FlexColumnWidth(2.1),
  //                         //   1: pw.FlexColumnWidth(2.1),
  //                         //   2: pw.FlexColumnWidth(2.1),
  //                         //   // 3: pw.FlexColumnWidth(1.8),
  //                         //   // 4: pw.FlexColumnWidth(4),
  //                         //   // 5: pw.FlexColumnWidth(4),
  //                         // },
  //                         headers: headers,
  //                         data: data),
  //                     pw.Container(
  //                       child: pw.Row(
  //                         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           pw.Container(
  //                             child: pw.Column(
  //                               // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                               crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                               children: [
  //                                 pw.Container(
  //                                   alignment: pw.Alignment.centerLeft,
  //                                   child: pw.Text(
  //                                     "Remarks:Balance 2000",
  //                                     style: pw.TextStyle(
  //                                       fontSize: 14.0,
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 pw.SizedBox(height: height * 0.05),
  //                                 pw.Container(
  //                                     child: pw.Row(
  //                                   children: [
  //                                     pw.Column(
  //                                       crossAxisAlignment:
  //                                           pw.CrossAxisAlignment.start,
  //                                       children: [
  //                                         pw.Container(
  //                                           child: pw.Text("Boss",
  //                                               style: pw.TextStyle(
  //                                                 fontSize: 14.0,
  //                                               )),
  //                                         ),
  //                                         pw.Container(
  //                                           child: pw.Text("Signature",
  //                                               style: pw.TextStyle(
  //                                                   fontSize: 14.0,
  //                                                   fontWeight:
  //                                                       pw.FontWeight.bold)),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                     pw.SizedBox(width: width * 0.1),
  //                                     pw.Column(
  //                                       crossAxisAlignment:
  //                                           pw.CrossAxisAlignment.start,
  //                                       children: [
  //                                         pw.Container(
  //                                           child: pw.Text("04/07/2023",
  //                                               style: pw.TextStyle(
  //                                                 fontSize: 14.0,
  //                                               )),
  //                                         ),
  //                                         pw.Container(
  //                                           child: pw.Text("Date",
  //                                               style: pw.TextStyle(
  //                                                   fontSize: 14.0,
  //                                                   fontWeight:
  //                                                       pw.FontWeight.bold)),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ],
  //                                 ))
  //                               ],
  //                             ),
  //                           ),
  //                           //
  //                           pw.Container(
  //                             child: pw.Column(
  //                               children: [
  //                                 pw.Container(
  //                                   width: width * 0.4,
  //                                   child: pw.Row(
  //                                     mainAxisAlignment:
  //                                         pw.MainAxisAlignment.spaceBetween,
  //                                     children: [
  //                                       pw.Container(
  //                                         child: pw.Text("Cash",
  //                                             style: pw.TextStyle(
  //                                               fontSize: 14.0,
  //                                             )),
  //                                       ),
  //                                       pw.Container(
  //                                         child: pw.Text("20000",
  //                                             style: pw.TextStyle(
  //                                               fontSize: 14.0,
  //                                             )),
  //                                       )
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 pw.Container(
  //                                   width: width * 0.4,
  //                                   child: pw.Row(
  //                                     mainAxisAlignment:
  //                                         pw.MainAxisAlignment.spaceBetween,
  //                                     children: [
  //                                       pw.Container(
  //                                         child: pw.Text("Card",
  //                                             style: pw.TextStyle(
  //                                               fontSize: 14.0,
  //                                             )),
  //                                       ),
  //                                       pw.Container(
  //                                         child: pw.Text("1000",
  //                                             style: pw.TextStyle(
  //                                               fontSize: 14.0,
  //                                             )),
  //                                       )
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 pw.Container(
  //                                   width: width * 0.4,
  //                                   child: pw.Row(
  //                                     mainAxisAlignment:
  //                                         pw.MainAxisAlignment.spaceBetween,
  //                                     children: [
  //                                       pw.Container(
  //                                         child: pw.Text("Bank",
  //                                             style: pw.TextStyle(
  //                                               fontSize: 14.0,
  //                                             )),
  //                                       ),
  //                                       pw.Container(
  //                                         child: pw.Text("2000",
  //                                             style: pw.TextStyle(
  //                                               fontSize: 14.0,
  //                                             )),
  //                                       )
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 pw.Container(
  //                                   width: width * 0.4,
  //                                   child: pw.Row(
  //                                     mainAxisAlignment:
  //                                         pw.MainAxisAlignment.spaceBetween,
  //                                     children: [
  //                                       pw.Container(
  //                                         child: pw.Text("Cheque",
  //                                             style: pw.TextStyle(
  //                                               fontSize: 14.0,
  //                                             )),
  //                                       ),
  //                                       pw.Container(
  //                                         child: pw.Text("200",
  //                                             style: pw.TextStyle(
  //                                               fontSize: 14.0,
  //                                             )),
  //                                       )
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 pw.Container(
  //                                   width: width * 0.4,
  //                                   child: pw.Row(
  //                                     mainAxisAlignment:
  //                                         pw.MainAxisAlignment.spaceBetween,
  //                                     children: [
  //                                       pw.Container(
  //                                         child: pw.Text("Total",
  //                                             style: pw.TextStyle(
  //                                                 fontSize: 14.0,
  //                                                 fontWeight:
  //                                                     pw.FontWeight.bold)),
  //                                       ),
  //                                       pw.Container(
  //                                         child: pw.Text("23200",
  //                                             style: pw.TextStyle(
  //                                                 fontSize: 14.0,
  //                                                 fontWeight:
  //                                                     pw.FontWeight.bold)),
  //                                       )
  //                                     ],
  //                                   ),
  //                                 )
  //                               ],
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     )
  //                   ],
  //                 )),

  //             pw.SizedBox(height: 20),
  //             // pw.Flexible(child: pw.FlutterLogo())
  //           ],
  //         );
  //       },
  //     ),
  //   );

  //   return pdf.save();
  // }

  // List<pw.Widget> get NewPdf {
  //   return <pw.Widget>[
  //      final headers = [
  //         "Particular",
  //         "Amount",
  //         "Penalty",
  //       ];
  //       final data = dasa!.map((e) {
  //         // final total = ("123312");
  //         return [
  //           '${e.id}',
  //           '${e.userid}',
  //           '${e.body}',
  //         ];
  //       }).toList();

  //     return pw.Column(
  //           children: [
  //             // pw.Flexible(
  //             //   child: pw.SvgImage(
  //             //     svg: _logo,
  //             //     height: 100,
  //             //   ),
  //             // ),
  //             // pw.SizedBox(
  //             //   height: 20,
  //             // ),
  //             pw.Container(
  //               alignment: pw.Alignment.topLeft,
  //               child: pw.Text(
  //                 '${dasa![0].id}',
  //                 style: pw.TextStyle(
  //                   // fontWeight:FontWeight.bold,
  //                   fontSize: 28,
  //                 ),
  //               ),
  //             ),
  //             // pw.Divider(),
  //             pw.Container(
  //               alignment: pw.Alignment.topLeft,
  //               child: pw.Text(
  //                 'Gopinath  ',
  //                 style: pw.TextStyle(
  //                   fontSize: 22,
  //                 ),
  //               ),
  //             ),
  //             pw.Container(
  //               alignment: pw.Alignment.topLeft,
  //               child: pw.Text(
  //                 '7092571625',
  //                 style: pw.TextStyle(
  //                   fontSize: 22,
  //                 ),
  //               ),
  //             ),
  //             pw.Container(
  //               alignment: pw.Alignment.topLeft,
  //               child: pw.Text(
  //                 'Vadipatti Sangarapuram post',
  //                 style: pw.TextStyle(
  //                   fontSize: 22,
  //                 ),
  //               ),
  //             ),
  //             pw.SizedBox(
  //               height: 10,
  //             ),
  //             pw.Row(
  //               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //               children: [
  //                 pw.Column(children: [
  //                   pw.Container(
  //                     width: 180,
  //                     alignment: pw.Alignment.topLeft,
  //                     child: pw.Text(
  //                       'Product Details',
  //                       style: pw.TextStyle(
  //                         fontSize: 22,
  //                       ),
  //                     ),
  //                   ),
  //                   pw.Container(
  //                     width: 250,
  //                     alignment: pw.Alignment.topLeft,
  //                     child: pw.Text(
  //                       'Sony Experia',
  //                       style: pw.TextStyle(
  //                         fontSize: 22,
  //                       ),
  //                     ),
  //                   ),
  //                 ]),
  //                 pw.Column(children: [
  //                   pw.Container(
  //                     width: 200,
  //                     alignment: pw.Alignment.topLeft,
  //                     child: pw.Text(
  //                       'Loan No',
  //                       style: pw.TextStyle(
  //                         fontSize: 22,
  //                       ),
  //                     ),
  //                   ),
  //                   pw.Container(
  //                     width: 200,
  //                     alignment: pw.Alignment.topLeft,
  //                     child: pw.Text(
  //                       '11452655366353',
  //                       style: pw.TextStyle(
  //                         fontSize: 22,
  //                       ),
  //                     ),
  //                   ),
  //                 ]),
  //                 pw.Column(children: [
  //                   pw.Container(
  //                     alignment: pw.Alignment.centerLeft,
  //                     child: pw.Text(
  //                       'Loan Amount',
  //                       style: pw.TextStyle(
  //                         fontSize: 22,
  //                       ),
  //                     ),
  //                   ),
  //                   pw.Container(
  //                     alignment: pw.Alignment.centerLeft,
  //                     child: pw.Text(
  //                       '20 Lac',
  //                       style: pw.TextStyle(
  //                         fontSize: 22,
  //                       ),
  //                     ),
  //                   ),
  //                 ]),
  //               ],
  //             ),
  //             pw.SizedBox(
  //               height: 10,
  //             ),
  //             pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
  //             pw.Table.fromTextArray(
  //                 headerStyle: pw.TextStyle(
  //                   fontSize: 10.0,
  //                 ),
  //                 cellStyle: pw.TextStyle(
  //                   fontSize: 9.0,
  //                 ),
  //                 headers: headers,
  //                 data:data),

  //   ]);
  //     ];
  // }

}
