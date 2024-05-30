// ignore_for_file: public_member_api_docs, prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/CollectionController/NewCollectionEntryCotroller.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/OrderSavePostModel.dart';
import 'package:sellerkit/Pages/OrderBooking/Widgets/pdfinv.dart';
import 'package:sellerkit/Services/customerdetApi/customerdetApi.dart';

import 'CollectionPdfHelper.dart';

class CollectionReceiptPdf extends StatefulWidget {
  const CollectionReceiptPdf({Key? key}) : super(key: key);

  @override
  State<CollectionReceiptPdf> createState() => CollectionReceiptPdfState();
}

class CollectionReceiptPdfState extends State<CollectionReceiptPdf> {
  final pdf = pw.Document();
  // static List<DocumentLines> davta = [];
  // static String paymode = '';
  // List<DocumentLines> data2 = [];

  // static customerdetData? customermodeldata;
  // // List<DocumentLines> data4 = [];
  // List<DocumentLines> data5 = [];
  // List<DocumentLines> data6 = [];
  // // static List<ordermaster>? orderMasterdata2 = [];
  // // List<ordermaster>? orderMasterdata = [];

  // static List<ontapKpi>? orderMasterdata2 = [];
  // List<ontapKpi>? orderMasterdata = [];
  // static List<InvoiceData>? dasa = [];
  // String? date = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Config config = Config();
      // data2 = data;

      // orderMasterdata = orderMasterdata2;
      // log("orderMasterdata::" + data2!.length.toString());

      // // date:
      // // config.alignDate(orderMasterdata![0].DocDate.toString());
      // dasa = [
      //   InvoiceData(id: 1, invoiceNo: 'invoiceNo', total: 2, totalPayment: 1)
      // ];
    });
  }

  // static List<InvoiceDetails>? dasa = [];
  var name;
  var subject1;
  var subject2;
  var subject3;
  var marks;

  @override
  Widget build(BuildContext context) {
    // initState(){

    // }
    return Scaffold(
      appBar: AppBar(),
      body: PdfPreview(
          initialPageFormat: PdfPageFormat.a4,
          dynamicLayout: true,
          // pages: [1,2],
          onPageFormatChanged: (PdfPageFormat) {},
          build: (format)
              // => generatePdf(format, 'title'),
              {
            // CollectionReceiptPdfHelper.data2 = data2;
            // CollectionReceiptPdfHelper.paymode = paymode;
            // log("paymode::" + paymode.toString());

            // CollectionReceiptPdfHelper.orderMasterdata = orderMasterdata;

            // CollectionReceiptPdfHelper.customermodeldata = customermodeldata;
            return CollectionReceiptPdfHelper.generatePdf(format, 'title');
          }),
    );
  }

//   Future<pw.TtfFont> loadFont() async {
//     final ByteData data = await rootBundle.load('Assets/Ingeborg-Regular.ttf');
//     final Uint8List bytes = data.buffer.asUint8List();
//     return pw.TtfFont(bytes.buffer.asByteData());
//   }

//   Future<pw.TtfFont> caliberFont() async {
//     final ByteData data = await rootBundle.load('Assets/Calibri.ttf');
//     final Uint8List bytes = data.buffer.asUint8List();
//     return pw.TtfFont(bytes.buffer.asByteData());
//   }

//   Future<Uint8List> generatePdf(PdfPageFormat format, String title) async {
//     Config config = Config();
//     final pw.TtfFont font = await loadFont();
//     final pw.TtfFont Calibrifont = await caliberFont();
//     final pdf = pw.Document(
//         // pageMode: PdfPageMode.none,
//         //   theme: pw.ThemeData().copyWith(
//         //   pageBackground: pw.Paint()..color = pw.PdfColor.fromHex('#F0F0F0'),
//         // ),
//         // pageFormat: PdfPageFormat.a4,
//         // pageMode: PdfPageMode.fullscreen,
//         //     : PdfPageFormat.a4.copyWith(
//         //   width: PdfPageFormat.a4.width - 100,
//         //   height: PdfPageFormat.a4.height - 100,
//         // ),
//         // version: PdfVersion.pdf_1_4, compress: true

//         );
//     final headers = [
//       'S.No',
//       'Description',
//       'Qty',
//       'Price',
//       'Tax %',
//       'Total',
//     ];

//     final data3 = data2.map((item) {
//       // final total = item.unitPrice * item.quantity * (1 + item.vat);

//       return [
//         item.linenum,
//         item.ItemDescription,
//         item.Quantity!.toInt(),
//         item.BasePrice!.toStringAsFixed(2),
//         item.TaxCode!.toStringAsFixed(2),
//         item.LineTotal!.toStringAsFixed(2),
//       ];
//     }).toList();

//     // final font = await PdfGoogleFonts.nunitoExtraLight();
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;

// // ic
//     pdf.addPage(
//       pw.MultiPage(
//         maxPages: 100,
//         orientation: pw.PageOrientation.portrait,
//         // pageFormat: PdfPageFormat.a4.copyWith(
//         // //  marginBottom: 0,
//         // //     marginLeft: 0,
//         // //     marginRight: width*0.07,
//         // //     marginTop: 0,
//         //     width: PdfPageFormat.a4.width ,
//         // height: PdfPageFormat.a4.height ,

//         //  ),
//         // header: ,
//         build: (context) =>
//             //  pages
//             [
//           //  pw.initialpage()
//           pw.Expanded(
//               child:
//                   // ren: [
//                   pw.Container(

//                       // alignment: pw.Alignment.t,
//                       // width: double.infinity,
//                       // height: height*0.96,
//                       // color: PdfColors.amber,
//                       child: pw.Row(
//                           mainAxisAlignment: pw.MainAxisAlignment.start,
//                           crossAxisAlignment: pw.CrossAxisAlignment.start,
//                           children: [
//                 //             pw.Container(
//                 //    width: width*0.07,

//                 //    height:PdfPageFormat.a4.height,
//                 //             color: PdfColor.fromHex("#750537"),
//                 //  ),
//                 pw.SizedBox(width: width * 0.07),
//                 pw.Expanded(
//                     // width: width*.,
//                     // height:height* 0.80,
//                     // color: PdfColors.blue,
//                     child: pw.Column(
//                   children: [
//                     pw.SizedBox(height: 1 * PdfPageFormat.cm),
//                     pw.Row(
//                         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                         children: [
//                           pw.Container(
//                             alignment: pw.Alignment.center,
//                             // color: PdfColors.amber,
//                             child: pw.Text(
//                               'ORDER',
//                               style: pw.TextStyle(
//                                   font: font,
//                                   // fontWeight:pw.FontWeight.bold,
//                                   //  fontStyle: P,
//                                   fontSize: 40,
//                                   color: PdfColor.fromHex("#750537")),
//                             ),
//                           ),
//                           pw.Container(
//                             alignment: pw.Alignment.centerRight,
//                             // width: width*0.5,
//                             //  color: PdfColors.amber,
//                             child: pw.Column(
//                                 crossAxisAlignment: pw.CrossAxisAlignment.end,
//                                 children: [
//                                   pw.Text(
//                                     'BUSON DIGITAL SERVICE INDIA PVT LTD',
//                                     textAlign: pw.TextAlign.right,
//                                     style: pw.TextStyle(
//                                         font: Calibrifont,
//                                         fontWeight: pw.FontWeight.bold,
//                                         fontSize: 12,
//                                         color: PdfColor.fromHex("#750537")),
//                                   ),
//                                   pw.Container(
//                                     alignment: pw.Alignment.centerRight,
//                                     width: width * 0.5,
//                                     child: pw.Text(
//                                       ' 206/3, 2nd Floor, Devarajan Center, Sathyamurthy Rd, Peranaidu Layout, Ram Nagar, Coimbatore, Tamil Nadu 641009',
//                                       textAlign: pw.TextAlign.right,
//                                       maxLines: 3,
//                                       style: pw.TextStyle(
//                                         font: Calibrifont,
//                                         //  fontWeight: pw.FontWeight.bold,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                           ),
//                         ]),

//                     pw.SizedBox(height: 1 * PdfPageFormat.cm),

//                     pw.Container(
//                         // padding: pw.EdgeInsets.all(height * 0.01),
//                         // width: double.infinity,
//                         alignment: pw.Alignment.center,
//                         decoration: pw.BoxDecoration(
//                             // color: PdfColor.fromHex("#FF6347"),
//                             // border: pw.Border.all()
//                             ),
//                         child: pw.Column(
//                             crossAxisAlignment: pw.CrossAxisAlignment.start,
//                             mainAxisAlignment:
//                                 pw.MainAxisAlignment.spaceBetween,
//                             children: [
//                               pw.SizedBox(height: 0.02 * PdfPageFormat.cm),
//                               pw.Row(
//                                   crossAxisAlignment:
//                                       pw.CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                       pw.MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     pw.Container(
//                                       child: pw.Column(
//                                           crossAxisAlignment:
//                                               pw.CrossAxisAlignment.start,
//                                           children: [
//                                             pw.Text(
//                                               'TO:',
//                                               style: pw.TextStyle(
//                                                   font: Calibrifont,
//                                                   fontWeight:
//                                                       pw.FontWeight.bold,
//                                                   fontSize: 12,
//                                                   color: PdfColor.fromHex(
//                                                       "#750537")),
//                                             ),
//                                             pw.Text(
//                                               '  ${orderMasterdata![0].CustomerName}',
//                                               style: pw.TextStyle(
//                                                 font: Calibrifont,
//                                                 fontWeight: pw.FontWeight.bold,
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                             pw.Container(
//                                               width: width * 0.5,
//                                               // color: PdfColors.amber,
//                                               alignment:
//                                                   pw.Alignment.centerLeft,
//                                               child: pw.Text(
//                                                 '  ${orderMasterdata![0].Bil_City},${orderMasterdata![0].Bil_State}',
//                                                 textAlign: pw.TextAlign.left,
//                                                 maxLines: 10,
//                                                 style: pw.TextStyle(
//                                                   font: Calibrifont,
//                                                   // fontWeight:FontWeight.bold,
//                                                   fontSize: 12,
//                                                 ),
//                                               ),
//                                             ),
//                                             // pw.Container(
//                                             //   width: width * 0.5,
//                                             //   // color: PdfColors.amber,
//                                             //   alignment:
//                                             //       pw.Alignment.centerLeft,
//                                             //   child: pw.Text(
//                                             //     '',
//                                             //     textAlign: pw.TextAlign.left,
//                                             //     maxLines: 10,
//                                             //     style: pw.TextStyle(
//                                             //       // fontWeight:FontWeight.bold,
//                                             //       fontSize: 15,
//                                             //     ),
//                                             //   ),
//                                             // ),
//                                             pw.Container(
//                                               width: width * 0.5,
//                                               // color: PdfColors.amber,
//                                               alignment:
//                                                   pw.Alignment.centerLeft,
//                                               child: pw.Text(
//                                                 '  ${orderMasterdata![0].Bil_State},${orderMasterdata![0].Bil_City}',

//                                                 // '  ${orderMasterdata![0].Bil_Area},${orderMasterdata![0].Bil_City}',
//                                                 textAlign: pw.TextAlign.left,
//                                                 maxLines: 10,
//                                                 style: pw.TextStyle(
//                                                   font: Calibrifont,
//                                                   // fontWeight:FontWeight.bold,
//                                                   fontSize: 12,
//                                                 ),
//                                               ),
//                                             ),
//                                             // pw.Container(
//                                             //   width: width * 0.5,
//                                             //   // color: PdfColors.amber,
//                                             //   alignment:
//                                             //       pw.Alignment.centerLeft,
//                                             //   child: pw.Text(
//                                             //     '',
//                                             //     textAlign: pw.TextAlign.left,
//                                             //     maxLines: 10,
//                                             //     style: pw.TextStyle(
//                                             //       // fontWeight:FontWeight.bold,
//                                             //       fontSize: 15,
//                                             //     ),
//                                             //   ),
//                                             // ),
//                                             pw.Container(
//                                               width: width * 0.5,
//                                               // color: PdfColors.amber,
//                                               alignment:
//                                                   pw.Alignment.centerLeft,
//                                               child: pw.Text("",
//                                                 // '  ${orderMasterdata![0].Bil_State},${orderMasterdata![0].Bil_Pincode}',
//                                                 textAlign: pw.TextAlign.left,
//                                                 maxLines: 10,
//                                                 style: pw.TextStyle(
//                                                   font: Calibrifont,
//                                                   // fontWeight:FontWeight.bold,
//                                                   fontSize: 12,
//                                                 ),
//                                               ),
//                                             ),
//                                             pw.Container(
//                                               width: width * 0.5,
//                                               // color: PdfColors.amber,
//                                               alignment:
//                                                   pw.Alignment.centerLeft,
//                                               child: pw.Text(
//                                                 '  GSTIN:',
//                                                 //  ${orderMasterdata![0].gstno}',
//                                                 textAlign: pw.TextAlign.left,
//                                                 maxLines: 10,
//                                                 style: pw.TextStyle(
//                                                   font: Calibrifont,
//                                                   // fontWeight:FontWeight.bold,
//                                                   fontSize: 12,
//                                                 ),
//                                               ),
//                                             ),
//                                           ]),
//                                     ),
//                                     // pw.Container(
//                                     //     width: width * 0.5,
//                                     //     // color: PdfColors.amber,
//                                     //     child: pw.Column(children: [
//                                     //       pw.Row(children: [
//                                     //         pw.Container(
//                                     //           alignment:
//                                     //               pw.Alignment.centerLeft,
//                                     //           child: pw.Text(
//                                     //             'Order No ',
//                                     //             textAlign: pw.TextAlign.right,
//                                     //             style: pw.TextStyle(
//                                     //               font: Calibrifont,
//                                     //               fontWeight:
//                                     //                   pw.FontWeight.bold,
//                                     //               fontSize: 12,
//                                     //               //  color: PdfColor.fromHex("#750537")
//                                     //             ),
//                                     //           ),
//                                     //         ),
//                                     //         pw.Container(
//                                     //           //  alignment: pw.Alignment.centerLeft,
//                                     //           child: pw.Text(
//                                     //             '#${orderMasterdata![0].DocNo}',
//                                     //             textAlign: pw.TextAlign.right,
//                                     //             style: pw.TextStyle(
//                                     //               font: Calibrifont,
//                                     //               // fontWeight: pw.FontWeight.bold,
//                                     //               fontSize: 12,
//                                     //               //  color: PdfColor.fromHex("#750537")
//                                     //             ),
//                                     //           ),
//                                     //         )
//                                     //       ]),
//                                     //       pw.Row(children: [
//                                     //         pw.Container(
//                                     //           alignment:
//                                     //               pw.Alignment.centerLeft,
//                                     //           child: pw.Text(
//                                     //             'Order Dt:',
//                                     //             style: pw.TextStyle(
//                                     //               font: Calibrifont,
//                                     //               fontWeight:
//                                     //                   pw.FontWeight.bold,
//                                     //               fontSize: 12,
//                                     //             ),
//                                     //           ),
//                                     //         ),
//                                     //         pw.Container(
//                                     //           alignment:
//                                     //               pw.Alignment.centerLeft,
//                                     //           child: pw.Text(
//                                     //             ' ${config.alignDate(orderMasterdata![0].DocDate.toString())}',
//                                     //             style: pw.TextStyle(
//                                     //               font: Calibrifont,
//                                     //               // fontWeight: pw.FontWeight.bold,
//                                     //               fontSize: 12,
//                                     //             ),
//                                     //           ),
//                                     //         ),
//                                     //       ]),
//                                     //     ]))
                                 
                                 
                                 
                                 
//                                   ]),
//                               //  pw.SizedBox(height: 0.05 * PdfPageFormat.cm),

//                               // pw.Text(
//                               //   '',
//                               //   style: pw.TextStyle(
//                               //     fontWeight: pw.FontWeight.bold,
//                               //     fontSize: 14,
//                               //   ),
//                               // ),
//                               pw.SizedBox(height: 1 * PdfPageFormat.cm),

//                               pw.Table.fromTextArray(
//                                 headers: headers,
//                                 data: data3,
//                                 border: null,
//                                 cellStyle: pw.TextStyle(
//                                     font: Calibrifont, fontSize: 12),
//                                 headerStyle: pw.TextStyle(
//                                     font: Calibrifont,
//                                     fontWeight: pw.FontWeight.bold,
//                                     color: PdfColors.white),
//                                 headerDecoration: pw.BoxDecoration(
//                                     color: PdfColor.fromHex("#750537")),
//                                 cellHeight: 20,
//                                 columnWidths: {
//                                   0: pw.FlexColumnWidth(width * 0.06),
//                                   1: pw.FlexColumnWidth(width * 0.2),
//                                   2: pw.FlexColumnWidth(width * 0.1),
//                                   3: pw.FlexColumnWidth(width * 0.1),
//                                   4: pw.FlexColumnWidth(width * 0.1),
//                                   5: pw.FlexColumnWidth(width * 0.1),
//                                 },
//                                 headerAlignments: {
//                                   0: pw.Alignment.centerLeft,
//                                   1: pw.Alignment.center,
//                                   2: pw.Alignment.centerRight,
//                                   3: pw.Alignment.centerRight,
//                                   4: pw.Alignment.centerRight,
//                                   5: pw.Alignment.centerRight,
//                                 },
//                                 cellAlignments: {
//                                   0: pw.Alignment.centerLeft,
//                                   1: pw.Alignment.centerLeft,
//                                   2: pw.Alignment.centerRight,
//                                   3: pw.Alignment.centerRight,
//                                   4: pw.Alignment.centerRight,
//                                   5: pw.Alignment.centerRight,
//                                 },
//                               ),

//                               pw.Divider(),
//                             ])),
//                     // pw.Container(
//                     //     child: pw.Row(children: [
//                     //   pw.Spacer(flex: 6),
//                     //   pw.Container(
//                     //     width: width * 0.4,
//                     //     // color: PdfColors.amber,
//                     //     child: pw.Row(
//                     //       children: [
//                     //         pw.Expanded(
//                     //             child: pw.Text("Sub Total",
//                     //                 style: pw.TextStyle(
//                     //                   font: Calibrifont,
//                     //                   fontWeight: pw.FontWeight.bold,
//                     //                   fontSize: 12,
//                     //                 ))),
//                     //         pw.Text(
//                     //             "${orderMasterdata![0].GrossTotal!.toStringAsFixed(2)}",
//                     //             style: pw.TextStyle(
//                     //               font: Calibrifont,
//                     //               fontSize: 12,
//                     //             )),
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ])),
//                     // pw.Container(
//                     //     child: pw.Row(children: [
//                     //   pw.Spacer(flex: 6),
//                     //   pw.Container(
//                     //     width: width * 0.4,
//                     //     child: pw.Row(
//                     //       children: [
//                     //         pw.Expanded(
//                     //             child: pw.Text("Tax",
//                     //                 style: pw.TextStyle(
//                     //                   font: Calibrifont,
//                     //                   fontWeight: pw.FontWeight.bold,
//                     //                   fontSize: 12,
//                     //                 ))),
//                     //         pw.Text(
//                     //             "${orderMasterdata![0].TaxAmount!.toStringAsFixed(2)}",
//                     //             style: pw.TextStyle(
//                     //               font: Calibrifont,
//                     //               fontSize: 12,
//                     //             )),
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ])),
//                     // pw.Container(
//                     //     child: pw.Row(children: [
//                     //   pw.Spacer(flex: 6),
//                     //   pw.Container(
//                     //     width: width * 0.4,
//                     //     child: pw.Row(
//                     //       children: [
//                     //         pw.Expanded(
//                     //             child: pw.Text("Round off",
//                     //                 style: pw.TextStyle(
//                     //                   font: Calibrifont,
//                     //                   fontWeight: pw.FontWeight.bold,
//                     //                   fontSize: 12,
//                     //                 ))),
//                     //         pw.Text(
//                     //             "${orderMasterdata![0].roundoff!.toStringAsFixed(2)}",
//                     //             style: pw.TextStyle(
//                     //               font: Calibrifont,
//                     //               fontSize: 12,
//                     //             )),
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ])),

//                     // pw.Container(
//                     //     child: pw.Row(children: [
//                     //   pw.Spacer(flex: 6),
//                     //   pw.Container(
//                     //     width: width * 0.4,
//                     //     child: pw.Row(
//                     //       children: [
//                     //         pw.Expanded(
//                     //             child: pw.Text("Total",
//                     //                 style: pw.TextStyle(
//                     //                   fontWeight: pw.FontWeight.bold,
//                     //                   font: Calibrifont,
//                     //                   fontSize: 12,
//                     //                 ))),
//                     //         pw.Text(
//                     //             "${orderMasterdata![0].DocTotal!.toStringAsFixed(2)}",
//                     //             style: pw.TextStyle(
//                     //               font: Calibrifont,
//                     //               fontSize: 12,
//                     //             )),
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ])),
                   
//                   ],
//                 ))
//               ]))

//               // ]
//               )
//         ],
// //  footer: (context) =>
// //  pw. Column(
// //         crossAxisAlignment:pw. CrossAxisAlignment.center,
// //         children: [
// //         pw.  Divider(),
// //         pw.  SizedBox(height: 2 * PdfPageFormat.mm),
// //          pw. Text( 'Address', ),
// //          pw. SizedBox(height: 1 * PdfPageFormat.mm),
// //           pw. Text( 'Address', ),
// //         ],
// //       )
//       ),
//     );

// // }

//     return pdf.save();
//   }
}
