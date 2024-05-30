// // import 'dart:html';
// import 'dart:io';
// //import 'dart:js';
// // import 'package:generate_pdf_invoice_example/api/pdf_api.dart';
// // import 'package:generate_pdf_invoice_example/model/customer.dart';
// // import 'package:generate_pdf_invoice_example/model/invoice.dart';
// // import 'package:generate_pdf_invoice_example/model/supplier.dart';
// // import 'package:generate_pdf_invoice_example/utils.dart';
// //import 'package:pdf/widgets.dart' as pw;
// // import 'package:collectionapp/Pages/pdfApi.dart';

// // import 'package:pdf/pdf.dart';
// // import 'package:pdf/widgets.dart';
// import 'package:sellerkit/Pages/Collection/widgets/pdfApi.dart';

// class PdfInvoiceApi {
//   static int? height;
//   static String? remark;
//   static Future<File> generate(InvoiceData invoice) async {
//     final pdf = Document();
//     pdf.addPage(MultiPage(
//         maxPages: 100,
//         pageFormat: PdfPageFormat.a4,
//         // pageFormat: PdfPageFormat(
//         //     10 * PdfPageFormat.cm, height! * PdfPageFormat.cm,
//         //     marginAll: 0.3 * PdfPageFormat.cm
//         //     ),
//         build: (context) => [
//               //   inVoiceHead(invoice),
//               inVoiceMiddle(invoice),
//               //  inVoiceTable(invoice),
//               // inVoiceCash(invoice)
//             ]));

//     return PdfApi.saveDocument(name: "voice.pdf", pdf: pdf);
//   }

//   static Widget inVoiceMiddle(String) {
//     final headers = ["S.No", "Description", "Price"];
//    var data = [    
//     'Item 1',
//     'Item 2',
//     'Item 3',
//     'Item 4',
//     'Item 5',
//   ];

//     return Wrap(children: [
//       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Center(
//             child: Text("ZxX",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0))),
//         Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//           Center(
//               child: Text("invoice.data![0].id.toString()",
//                   style: TextStyle(
//                       // fontWeight: FontWeight.bold,
//                       fontSize: 10.0)))
//         ]),
//         SizedBox(height: 0.2 * PdfPageFormat.cm),
//         // Table.fromTextArray(
//         //     columnWidths: {
//         //       0: FlexColumnWidth(0.5),
//         //       1: FlexColumnWidth(2.5),
//         //       2: FlexColumnWidth(0.8),
//         //     },
//         //     headerStyle: TextStyle(
//         //       fontSize: 10.0,
//         //     ),
//         //     cellStyle: TextStyle(
//         //       fontSize: 9.0,
//         //     ),
//         //     headers: headers,
//         //     ),
//         SizedBox(height: 0.2 * PdfPageFormat.cm),
//         SizedBox(height: 0.2 * PdfPageFormat.cm),
//       ])
//     ]);
//   }

//   // static Widget inVoiceHead(InvoiceData invoice) =>
//   //     Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//   //       Center(
//   //           child: Text(invoice.data![0].body,
//   //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0))),
//   //       Center(
//   //           child: Text(invoice.data![0].id.toString(),
//   //               style: TextStyle(
//   //                   // fontWeight: FontWeight.bold,
//   //                   fontSize: 10.0))),
//   //       SizedBox(height: 0.4 * PdfPageFormat.cm),
//   //       SizedBox(height: 0.4 * PdfPageFormat.cm),
//   //     ]);
//   // static Widget inVoiceTable(Invoice invoice) {
//   //   final headers = ["s.No", "Description", "Quantity"];
//   //   final data = invoice.items.map((e) {
//   //     final total = (e.quantity);
//   //     return [e.slNo, '${e.descripton}', '${e.quantity}'];
//   //   }).toList();
//   //   return Table.fromTextArray(headers: headers, data: data);
//   // }

//   // static Widget inVoiceCash(Invoice invoice) =>
//   //     Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//   //       SizedBox(height: 0.4 * PdfPageFormat.cm),
//   //       Text("Cash: " + invoice.invoiceCash.cash,
//   //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0)),
//   //       Text("Card: " + invoice.invoiceCash.card1,
//   //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0)),
//   //       Text("Exchange: " + invoice.invoiceCash.exchange,
//   //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0)),
//   //       // Text("Finance: "+invoice.invoiceCash.finance,style: TextStyle(
//   //       //  fontWeight: FontWeight.bold,
//   //       //  fontSize: 10.0
//   //       // )),
//   //       Text("COD: " + invoice.invoiceCash.cod,
//   //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0)),
//   //       Text("Credit: " + invoice.invoiceCash.credit,
//   //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0)),
//   //       SizedBox(height: 0.2 * PdfPageFormat.cm),
//   //       Center(
//   //           child: Text("Total: " + invoice.invoiceCash.total,
//   //               style: TextStyle(
//   //                   // fontWeight: FontWeight.bold,
//   //                   fontSize: 10.0))),
//   //       SizedBox(height: 0.2 * PdfPageFormat.cm),
//   //       Text("Sales Employee: " + invoice.invoiceCash.salesEmployee,
//   //           style: TextStyle(
//   //               // fontWeight: FontWeight.bold,
//   //               fontSize: 10.0))
//   //     ]);

// }

// class InvoiceData {
//   List<PostEnq> data;
//   InvoiceData({required this.data});
// }

// class PostEnq {
//   String? CardCode="";
//   String? Activity="";
//   int? ActivityType=0;
//   String? U_Lookingfor="";
//   String? U_PotentialValue="";
//   String? U_AssignedTo="";
//   String? U_EnqStatus="";
//   String? U_EnqRefer="";
//   int? assignedtoslpCode;

//   PostEnq(
//       {this.CardCode,
//       this.Activity,
//       this.ActivityType,
//       this.U_Lookingfor,
//       this.U_PotentialValue,
//       this.U_AssignedTo,
//       this.U_EnqStatus,
//       this.U_EnqRefer,
//       this.assignedtoslpCode});
// }
