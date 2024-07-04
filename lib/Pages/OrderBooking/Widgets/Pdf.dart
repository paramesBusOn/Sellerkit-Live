// ignore_for_file: public_member_api_docs, prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' ;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/OrderSavePostModel.dart';
import 'package:sellerkit/Pages/OrderBooking/Widgets/pdfinv.dart';
import 'package:sellerkit/Services/customerdetApi/customerdetApi.dart';

class pdf extends StatefulWidget {
  const pdf({Key? key}) : super(key: key);

  @override
  State<pdf> createState() => pdfState();
}

class pdfState extends State<pdf> {
  final pdf = pw.Document();
  static List<DocumentLines> data = [];
  static String paymode = '';
  List<DocumentLines> data2 = [];
  
static customerdetData? customermodeldata;
  // List<DocumentLines> data4 = [];
  List<DocumentLines> data5 = [];
  List<DocumentLines> data6 = [];
  static List<ordermaster>? orderMasterdata2 = [];
  static  List<paymentorders>? orderpayment=[];
  List<ordermaster>? orderMasterdata = [];
  // static List<InvoiceData>? dasa = [];
  String? date = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Config config = Config();
      data2 = data;

      orderMasterdata = orderMasterdata2;
      log("orderMasterdata::"+data2!.length.toString());

      // date:
      // config.alignDate(orderMasterdata![0].DocDate.toString());
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
        initialPageFormat:PdfPageFormat.a4,
        dynamicLayout:true,
        // pages: [1,2],
        onPageFormatChanged:(PdfPageFormat){
          
        },
        
        build: (format)
        // => generatePdf(format, 'title'),
        {
          PdfInvoicePdfHelper.data2=data2;
          PdfInvoicePdfHelper.paymode=paymode;
          log("paymode::"+paymode.toString());
          // PdfInvoicePdfHelper.height=MediaQuery.of(context).size.height;
          // PdfInvoicePdfHelper.width=MediaQuery.of(context).size.width;
         PdfInvoicePdfHelper. orderMasterdata=orderMasterdata;
         PdfInvoicePdfHelper. customermodeldata = customermodeldata;
         PdfInvoicePdfHelper.orderpayment=orderpayment;
          return PdfInvoicePdfHelper.generatePdf(format, 'title');
        } 
        
      ),
    );
  }
Future<pw.TtfFont> loadFont() async {
  final ByteData data = await rootBundle.load('Assets/Ingeborg-Regular.ttf');
  final Uint8List bytes = data.buffer.asUint8List();
  return pw.TtfFont(bytes.buffer.asByteData());
}
Future<pw.TtfFont> caliberFont() async {
  final ByteData data = await rootBundle.load('Assets/Calibri.ttf');
  final Uint8List bytes = data.buffer.asUint8List();
  return pw.TtfFont(bytes.buffer.asByteData());
}

  Future<Uint8List> generatePdf(PdfPageFormat format, String title) async {
    Config config = Config();
      final pw.TtfFont font = await loadFont();
      final pw.TtfFont Calibrifont= await caliberFont();
    final pdf = pw.Document(
      // pageMode: PdfPageMode.none,
    //   theme: pw.ThemeData().copyWith(
    //   pageBackground: pw.Paint()..color = pw.PdfColor.fromHex('#F0F0F0'),
    // ),
    // pageFormat: PdfPageFormat.a4,
          // pageMode: PdfPageMode.fullscreen,
        //     : PdfPageFormat.a4.copyWith(
        //   width: PdfPageFormat.a4.width - 100,
        //   height: PdfPageFormat.a4.height - 100,
        // ),
          // version: PdfVersion.pdf_1_4, compress: true
      
        );
    final headers = [
      'S.No',
      'Description',
      'Qty',
      'Price',
      'Tax %',
      'Total',
    ];

    final data3 = data2.map((item) {
      // final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        item.linenum,
        item.ItemDescription,
        item.Quantity!.toInt(),
        item.BasePrice!.toStringAsFixed(2),
        item.TaxCode!.toStringAsFixed(2),
       item.LineTotal!.toStringAsFixed(2),

      ];
    }).toList();
    
    // final font = await PdfGoogleFonts.nunitoExtraLight();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
   
// ic
 pdf.addPage(
      pw.MultiPage(
   maxPages: 100,     
    orientation: pw.PageOrientation.portrait,
          // pageFormat: PdfPageFormat.a4.copyWith(
          // //  marginBottom: 0,
          // //     marginLeft: 0,
          // //     marginRight: width*0.07,
          // //     marginTop: 0,
          //     width: PdfPageFormat.a4.width ,
          // height: PdfPageFormat.a4.height ,

          //  ),
          // header: ,
          build: (context) =>
          //  pages
          [
          //  pw.initialpage()
          pw.Expanded(
            child:
            // ren: [
  pw.Container(

                    // alignment: pw.Alignment.t,
                    // width: double.infinity,
                    // height: height*0.96,
                    // color: PdfColors.amber,
                    child:
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
          //             pw.Container(
          //    width: width*0.07,
             
          //    height:PdfPageFormat.a4.height,
          //             color: PdfColor.fromHex("#750537"),
          //  ),
                      pw.SizedBox(width: width*0.07),
                      pw.Expanded(
                        // width: width*.,
                        // height:height* 0.80,
                      // color: PdfColors.blue,
                        child:   
                         pw.Column(
                         
                            children: [
                              pw.SizedBox(height: 1 * PdfPageFormat.cm),
                             pw.Row(
                              mainAxisAlignment:pw.MainAxisAlignment.spaceBetween,
                              children: [
                              pw.Container(
                                alignment: pw.Alignment.center,
                                // color: PdfColors.amber,
                                child: pw.Text(
                               'ORDER',
                               
                               style: pw.TextStyle(
                               font: font,
                                 // fontWeight:pw.FontWeight.bold,
                                //  fontStyle: P,
                                 fontSize: 40,
                                  color: PdfColor.fromHex("#750537")
                               ),
                                ),
                              ),
                                
                                
                              pw.Container(
                                 alignment: pw.Alignment.centerRight,
                                // width: width*0.5,
                                //  color: PdfColors.amber,
                                child: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                               children: [
                                 pw.Text(
                                               'BUSON DIGITAL SERVICE INDIA PVT LTD',
                                               textAlign: pw.TextAlign.right,
                                               style: pw.TextStyle(
                                                font: Calibrifont,
                                                 fontWeight: pw.FontWeight.bold,
                                                 fontSize: 12,
                                                  color: PdfColor.fromHex("#750537")
                                               ),
                                             ),
                                             pw.Container(
                                              alignment: pw.Alignment.centerRight,
                                             width: width*0.5, 
                                             child:  pw.Text(
                                               ' 206/3, 2nd Floor, Devarajan Center, Sathyamurthy Rd, Peranaidu Layout, Ram Nagar, Coimbatore, Tamil Nadu 641009',
                                               textAlign: pw.TextAlign.right,
                                               maxLines: 3,
                                               style: pw.TextStyle(
                                                font: Calibrifont,
                                                //  fontWeight: pw.FontWeight.bold,
                                                 fontSize: 12,
                                                  
                                               ),
                                             ),
                                             ),
                              
                                             
                                               ]
                                ),
                              ), 
                             ]),
                              

                              
                              pw.SizedBox(height: 1 * PdfPageFormat.cm),

                              pw.Container(
                                  // padding: pw.EdgeInsets.all(height * 0.01),
                                  // width: double.infinity,
                                  alignment: pw.Alignment.center,
                                  decoration: pw.BoxDecoration(
                                      // color: PdfColor.fromHex("#FF6347"),
                                      // border: pw.Border.all()
                                      ),
                                  child: pw.Column(
                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                       

                                        pw.SizedBox(height: 0.02 * PdfPageFormat.cm),
                                        pw.Row(
                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.spaceBetween,
                                            children: [
                                              pw.Container(
                                                child:  pw.Column(
                                                  crossAxisAlignment:
                                                      pw.CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Text(
                                                      'TO:',
                                                      style: pw.TextStyle(
                                                        font: Calibrifont,
                                                        fontWeight: pw.FontWeight.bold,
                                                        fontSize: 12,
                                                       color: PdfColor.fromHex("#750537")
                                                      ),
                                                    ),
                                                    pw.Text(
                                                      '  ${orderMasterdata![0].CardName}',
                                                      style: pw.TextStyle(
                                                        font: Calibrifont,
                                                        fontWeight: pw.FontWeight.bold,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                      pw.Container(
                                                        width: width * 0.5,
                                                        // color: PdfColors.amber,
                                                        alignment:
                                                            pw.Alignment.centerLeft,
                                                        child: pw.Text(

                                                          '  ${orderMasterdata![0].bil_Address1},${orderMasterdata![0].bil_Address2}',
                                                          textAlign: pw.TextAlign.left,
                                                          maxLines: 10,
                                                          style: pw.TextStyle(
                                                            font: Calibrifont,
                                                            // fontWeight:FontWeight.bold,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      // pw.Container(
                                                      //   width: width * 0.5,
                                                      //   // color: PdfColors.amber,
                                                      //   alignment:
                                                      //       pw.Alignment.centerLeft,
                                                      //   child: pw.Text(
                                                      //     '',
                                                      //     textAlign: pw.TextAlign.left,
                                                      //     maxLines: 10,
                                                      //     style: pw.TextStyle(
                                                      //       // fontWeight:FontWeight.bold,
                                                      //       fontSize: 15,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      pw.Container(
                                                        width: width * 0.5,
                                                        // color: PdfColors.amber,
                                                        alignment:
                                                            pw.Alignment.centerLeft,
                                                        child: pw.Text(
                                                          '  ${orderMasterdata![0].Bil_Area},${orderMasterdata![0].Bil_City}',
                                                          textAlign: pw.TextAlign.left,
                                                          maxLines: 10,
                                                          style: pw.TextStyle(
                                                            font: Calibrifont,
                                                            // fontWeight:FontWeight.bold,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      // pw.Container(
                                                      //   width: width * 0.5,
                                                      //   // color: PdfColors.amber,
                                                      //   alignment:
                                                      //       pw.Alignment.centerLeft,
                                                      //   child: pw.Text(
                                                      //     '',
                                                      //     textAlign: pw.TextAlign.left,
                                                      //     maxLines: 10,
                                                      //     style: pw.TextStyle(
                                                      //       // fontWeight:FontWeight.bold,
                                                      //       fontSize: 15,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      pw.Container(
                                                        width: width * 0.5,
                                                        // color: PdfColors.amber,
                                                        alignment:
                                                            pw.Alignment.centerLeft,
                                                        child: pw.Text(
                                                          '  ${orderMasterdata![0].Bil_State},${orderMasterdata![0].Bil_Pincode}',
                                                          textAlign: pw.TextAlign.left,
                                                          maxLines: 10,
                                                          style: pw.TextStyle(
                                                            font: Calibrifont,
                                                            // fontWeight:FontWeight.bold,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                      pw.Container(
                                                        width: width * 0.5,
                                                        // color: PdfColors.amber,
                                                        alignment:
                                                            pw.Alignment.centerLeft,
                                                        child: pw.Text(
                                                          '  GSTIN: ${orderMasterdata![0].gstno}',
                                                          textAlign: pw.TextAlign.left,
                                                          maxLines: 10,
                                                          style: pw.TextStyle(
                                                            font: Calibrifont,
                                                            // fontWeight:FontWeight.bold,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                  ]),
                                              
                                              ),
                                           pw.Container  (
                                            width: width*0.5,
                                            // color: PdfColors.amber,
                                            child:pw.Column(
                                              children: [
                                                 pw.Row(children: [
          pw.Container(
                                                     alignment: pw.Alignment.centerLeft,
child:  pw.Text(
                                                  'Order No ',
                                                  textAlign: pw.TextAlign.right,
                                                  style: pw.TextStyle(
                                                    font: Calibrifont,
                                                    fontWeight: pw.FontWeight.bold,
                                                    fontSize: 12,
                                                    //  color: PdfColor.fromHex("#750537")
                                                  ),
                                                ),
                                                  ),
                                                pw.Container(
                                                    //  alignment: pw.Alignment.centerLeft,
child:  pw.Text(
                                                  '#${orderMasterdata![0].DocNo}',
                                                  textAlign: pw.TextAlign.right,
                                                  style: pw.TextStyle(
                                                    font: Calibrifont,
                                                    // fontWeight: pw.FontWeight.bold,
                                                    fontSize: 12,
                                                    //  color: PdfColor.fromHex("#750537")
                                                  ),
                                                ),
                                                  )  
                                                 ]),
                                                pw.Row(children: [
pw.Container(
            alignment: pw.Alignment.centerLeft,
           child: pw.Text(
                                                      'Order Dt:',
                                                      style: pw.TextStyle(
                                                        font: Calibrifont,
                                                        fontWeight: pw.FontWeight.bold,
                                                        fontSize: 12,

                                                      ),
                                                    ),
),
pw.Container(
                                                    alignment: pw.Alignment.centerLeft,
                                                    child: pw.Text(
                                                      ' ${config.alignDate(orderMasterdata![0].DocDate.toString())}',
                                                      style: pw.TextStyle(
                                                        font: Calibrifont,
                                                        // fontWeight: pw.FontWeight.bold,
                                                        fontSize: 12,

                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                                
                                                  
                                               

                                              ]
                                            ) 
                                            )
                                            ]),
                                        //  pw.SizedBox(height: 0.05 * PdfPageFormat.cm),

                                        // pw.Text(
                                        //   '',
                                        //   style: pw.TextStyle(
                                        //     fontWeight: pw.FontWeight.bold,
                                        //     fontSize: 14,
                                        //   ),
                                        // ),
                                        pw.SizedBox(height: 1 * PdfPageFormat.cm),
                                        
pw.Table.fromTextArray(
                                          headers: headers,
                                          data: data3,
                                          border: null,
                                          cellStyle:  pw.TextStyle(
                                            font: Calibrifont,
                                            fontSize: 12
                                          ),
                                          headerStyle: pw.TextStyle(
                                            font: Calibrifont,
                                              fontWeight: pw.FontWeight.bold
                                              ,
                                              color: PdfColors.white
                                              ),
                                          headerDecoration:
                                              pw.BoxDecoration(
                                                
                                                color: PdfColor.fromHex("#750537")),
                                          cellHeight: 20,
                                          columnWidths: {
                                            0: pw.FlexColumnWidth(width * 0.06),
                                            1: pw.FlexColumnWidth(width * 0.2),
                                            2: pw.FlexColumnWidth(width * 0.1),
                                             3: pw.FlexColumnWidth(width * 0.1),
                                              4: pw.FlexColumnWidth(width * 0.1),
                                               5: pw.FlexColumnWidth(width * 0.1),
                                          },
                                          headerAlignments: {
                                            0: pw.Alignment.centerLeft,
                                            1: pw.Alignment.center,
                                            2: pw.Alignment.centerRight,
                                            3: pw.Alignment.centerRight,
                                            4:pw.Alignment.centerRight,
                                            5:pw.Alignment.centerRight,
                                          },
                                          cellAlignments: {
                                            0: pw.Alignment.centerLeft,
                                            1: pw.Alignment.centerLeft,
                                            2: pw.Alignment.centerRight,
                                            3: pw.Alignment.centerRight,
                                            4:pw.Alignment.centerRight,
                                            5:pw.Alignment.centerRight,
                                          },
                                        ),
                                        
                                        pw.Divider(),
                                      ])),
                                      pw.Container(
                                  child: pw.Row(children: [
                                pw.Spacer(flex: 6),
                                pw.Container(
                                  width: width * 0.4,
                                  // color: PdfColors.amber,
                                  child: pw.Row(
                                    children: [
                                      pw.Expanded(
                                          child: pw.Text("Sub Total",
                                              style: pw.TextStyle(
                                                font: Calibrifont,
                                                fontWeight: pw.FontWeight.bold,
                                                fontSize: 12,
                                              ))),
                                      pw.Text("${orderMasterdata![0].GrossTotal!.toStringAsFixed(2)}",
                                          style: pw.TextStyle(
                                            font: Calibrifont,
                                            fontSize: 12,
                                          )),
                                    ],
                                  ),
                                ),
                              ])),
                              pw.Container(
                                  child: pw.Row(children: [
                                pw.Spacer(flex: 6),
                                pw.Container(
                                  width: width * 0.4,
                                  child: pw.Row(
                                    children: [
                                      pw.Expanded(
                                          child: pw.Text("Tax",
                                              style: pw.TextStyle(
                                                font: Calibrifont,
                                                fontWeight: pw.FontWeight.bold,
                                                fontSize: 12,
                                              ))),
                                      pw.Text("${orderMasterdata![0].TaxAmount!.toStringAsFixed(2)}",
                                          style: pw.TextStyle(
                                            font: Calibrifont,
                                            fontSize: 12,
                                          )),
                                    ],
                                  ),
                                ),
                              ])),
                              pw.Container(
                                  child: pw.Row(children: [
                                pw.Spacer(flex: 6),
                                pw.Container(
                                  width: width * 0.4,
                                  child: pw.Row(
                                    children: [
                                      pw.Expanded(
                                          child: pw.Text("Round off",
                                              style: pw.TextStyle(
                                                font: Calibrifont,
                                                fontWeight: pw.FontWeight.bold,
                                                fontSize: 12,
                                              ))),
                                      pw.Text("${orderMasterdata![0].roundoff!.toStringAsFixed(2)}",
                                          style: pw.TextStyle(
                                            font: Calibrifont,
                                            fontSize: 12,
                                          )),
                                    ],
                                  ),
                                ),
                              ])),

                              pw.Container(
                                  child: pw.Row(children: [
                                pw.Spacer(flex: 6),
                                pw.Container(
                                  width: width * 0.4,
                                  child: pw.Row(
                                    children: [
                                      pw.Expanded(
                                          child: pw.Text("Total",
                                              style: pw.TextStyle(
                                                 fontWeight: pw.FontWeight.bold,
                                                font: Calibrifont,
                                               
                                                fontSize: 12,
                                              ))),
                                      pw.Text("${orderMasterdata![0].DocTotal!.toStringAsFixed(2)}",
                                          style: pw.TextStyle(
                                            font: Calibrifont,
                                            fontSize: 12,
                                          )),
                                    ],
                                  ),
                                ),
                              ])),
                              // pw.Container(
                              //     child: pw.Row(
                              //   children: [
                              //     pw.Spacer(flex: 6),

                                 
                              //   ],
                              // )),

                              // pw.SizedBox(height: 20),
                              // pw.Flexible(child: pw.FlutterLogo())
                            ],
                             )
                     
                      )
                    ])
                    
                    
                   )
            
         
            // ]
          )
             

         ],
//  footer: (context) => 
//  pw. Column(
//         crossAxisAlignment:pw. CrossAxisAlignment.center,
//         children: [
//         pw.  Divider(),
//         pw.  SizedBox(height: 2 * PdfPageFormat.mm),
//          pw. Text( 'Address', ),
//          pw. SizedBox(height: 1 * PdfPageFormat.mm),
//           pw. Text( 'Address', ),
//         ],
//       )
          ),
    );
    

// }

   
    return pdf.save();
  }
}
//  Widget buildFooter(Invoice invoice) => 

//old

// ignore_for_file: public_member_api_docs, prefer_typing_uninitialized_variables

// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:sellerkit/Constant/Configuration.dart';
// import 'package:sellerkit/Controller/CollectionController/NewCollectionEntryCotroller.dart';
// import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/OrderSavePostModel.dart';

// class pdf extends StatefulWidget {
//   const pdf({Key? key}) : super(key: key);

//   @override
//   State<pdf> createState() => pdfState();
// }

// class pdfState extends State<pdf> {
//   final pdf = pw.Document();
//   static List<DocumentLines> data = [];
//   List<DocumentLines> data2 = [];
//   static List<ordermaster>? orderMasterdata2 = [];
//   List<ordermaster>? orderMasterdata = [];
//   static List<InvoiceData>? dasa = [];
//   String? date = '';
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       Config config = Config();
//       data2 = data;
//       orderMasterdata = orderMasterdata2;

//       date:
//       config.alignDate(orderMasterdata![0].DocDate.toString());
//       dasa = [
//         InvoiceData(id: 1, invoiceNo: 'invoiceNo', total: 2, totalPayment: 1)
//       ];
//     });
//   }

//   // static List<InvoiceDetails>? dasa = [];
//   var name;
//   var subject1;
//   var subject2;
//   var subject3;
//   var marks;

//   @override
//   Widget build(BuildContext context) {
//     // initState(){

//     // }
//     return Scaffold(
//       appBar: AppBar(),
//       body: PdfPreview(
//         build: (format) => _generatePdf(format, 'title'),
//       ),
//     );
//   }

//   Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
//     final pdf = pw.Document(
//         //   pageMode: PdfPageMode.fullscreen,
//         // //     p: PdfPageFormat.a4.copyWith(
//         // //   width: PdfPageFormat.a4.width - 100,
//         // //   height: PdfPageFormat.a4.height - 100,
//         // // ),
//         //   version: PdfVersion.pdf_1_4, compress: true
//         );
//     final headers = [
//       'S.No',
//       'ItemDescription',
//       'Quantity',
//       'Unit Price',
//     ];

//     final data3 = data2.map((item) {
//       // final total = item.unitPrice * item.quantity * (1 + item.vat);

//       return [
//         item.linenum,
//         item.ItemDescription,
//         item.Quantity,
//         item.Price,
//       ];
//     }).toList();
//     // final font = await PdfGoogleFonts.nunitoExtraLight();
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;

//     pdf.addPage(
//       pw.MultiPage(
//           // pageFormat: PdfPageFormat.a4.copyWith(
//           //    width: PdfPageFormat.a4.width-200 ,
//           // height: PdfPageFormat.a4.height - 100,),
//           build: (context) => [
//                 pw.Column(
//                   children: [
//                     pw.SizedBox(height: 1 * PdfPageFormat.cm),

//                     pw.Container(
//                       alignment: pw.Alignment.center,
//                       child: pw.Text(
//                         'Order',
//                         style: pw.TextStyle(
//                           fontWeight: pw.FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ),
//                     pw.SizedBox(height: 1 * PdfPageFormat.cm),

//                     pw.Container(
//                         // padding: pw.EdgeInsets.all(height * 0.01),
//                         width: double.infinity,
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
//                               pw.Row(
//                                   mainAxisAlignment:
//                                       pw.MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     pw.Column(
//                                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                                       children: [
//                                       pw.Text(
//                                         'Order No',
//                                         style: pw.TextStyle(
//                                           fontWeight: pw.FontWeight.bold,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                       pw.Container(
//                                         alignment: pw.Alignment.centerLeft,
//                                      child:  pw.Text(
//                                         '#${orderMasterdata![0].DocNo}',
//                                         textAlign: pw.TextAlign.left,
//                                         style: pw.TextStyle(
//                                           // fontWeight: pw.FontWeight.bold,
//                                           fontSize: 14,
                                        
//                                         ),
//                                       ),
//                                       )
                                     
//                                     ]),
//                                     pw.Column(
//                                       crossAxisAlignment:
//                                           pw.CrossAxisAlignment.end,
//                                       mainAxisAlignment:
//                                           pw.MainAxisAlignment.end,
//                                       children: [
//                                         pw.Container(
//                                           alignment: pw.Alignment.centerRight,
//                                           child: pw.Text(
//                                             'Doc Date',
//                                             style: pw.TextStyle(
//                                               fontWeight: pw.FontWeight.bold,
//                                               fontSize: 15,
//                                             ),
//                                           ),
//                                         ),
//                                         pw.Container(
//                                           alignment: pw.Alignment.centerRight,
//                                           child: pw.Text(
//                                             '$date',
//                                             style: pw.TextStyle(
//                                               // fontWeight:FontWeight.bold,
//                                               fontSize: 15,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ]),

//                               pw.SizedBox(height: 0.02 * PdfPageFormat.cm),
//                               pw.Row(
//                                   mainAxisAlignment:
//                                       pw.MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     pw.Column(
//                                         crossAxisAlignment:
//                                             pw.CrossAxisAlignment.start,
//                                         children: [
//                                           pw.Text(
//                                             'Customer Name',
//                                             style: pw.TextStyle(
//                                               fontWeight: pw.FontWeight.bold,
//                                               fontSize: 14,
//                                             ),
//                                           ),
//                                           pw.Text(
//                                             '${orderMasterdata![0].CardName}',
//                                             style: pw.TextStyle(
//                                               // fontWeight: pw.FontWeight.bold,
//                                               fontSize: 14,
//                                             ),
//                                           ),
//                                         ]),
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
//                               pw.Row(
//                                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                     pw.MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   pw.Container(
//                                       // color: PdfColors.red,
//                                       alignment: pw.Alignment.centerLeft,
//                                       child: pw.Column(
//                                           crossAxisAlignment:
//                                               pw.CrossAxisAlignment.start,
//                                           children: [
//                                             pw.Text(
//                                               'Billing Address',
//                                               textAlign: pw.TextAlign.left,
//                                               style: pw.TextStyle(
//                                                 fontWeight: pw.FontWeight.bold,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                             pw.Container(
//                                               width: width * 0.5,
//                                               // color: PdfColors.amber,
//                                               alignment:
//                                                   pw.Alignment.centerLeft,
//                                               child: pw.Text(
//                                                 '${orderMasterdata![0].bil_Address1}',
//                                                 textAlign: pw.TextAlign.left,
//                                                 maxLines: 10,
//                                                 style: pw.TextStyle(
//                                                   // fontWeight:FontWeight.bold,
//                                                   fontSize: 15,
//                                                 ),
//                                               ),
//                                             ),
//                                             pw.Container(
//                                               width: width * 0.5,
//                                               // color: PdfColors.amber,
//                                               alignment:
//                                                   pw.Alignment.centerLeft,
//                                               child: pw.Text(
//                                                 '${orderMasterdata![0].bil_Address2}',
//                                                 textAlign: pw.TextAlign.left,
//                                                 maxLines: 10,
//                                                 style: pw.TextStyle(
//                                                   // fontWeight:FontWeight.bold,
//                                                   fontSize: 15,
//                                                 ),
//                                               ),
//                                             ),
//                                             pw.Container(
//                                               width: width * 0.5,
//                                               // color: PdfColors.amber,
//                                               alignment:
//                                                   pw.Alignment.centerLeft,
//                                               child: pw.Text(
//                                                 '${orderMasterdata![0].Bil_Area}',
//                                                 textAlign: pw.TextAlign.left,
//                                                 maxLines: 10,
//                                                 style: pw.TextStyle(
//                                                   // fontWeight:FontWeight.bold,
//                                                   fontSize: 15,
//                                                 ),
//                                               ),
//                                             ),
//                                             pw.Container(
//                                               width: width * 0.5,
//                                               // color: PdfColors.amber,
//                                               alignment:
//                                                   pw.Alignment.centerLeft,
//                                               child: pw.Text(
//                                                 '${orderMasterdata![0].Bil_City}',
//                                                 textAlign: pw.TextAlign.left,
//                                                 maxLines: 10,
//                                                 style: pw.TextStyle(
//                                                   // fontWeight:FontWeight.bold,
//                                                   fontSize: 15,
//                                                 ),
//                                               ),
//                                             ),
//                                             pw.Container(
//                                               width: width * 0.5,
//                                               // color: PdfColors.amber,
//                                               alignment:
//                                                   pw.Alignment.centerLeft,
//                                               child: pw.Text(
//                                                 '${orderMasterdata![0].Bil_State}',
//                                                 textAlign: pw.TextAlign.left,
//                                                 maxLines: 10,
//                                                 style: pw.TextStyle(
//                                                   // fontWeight:FontWeight.bold,
//                                                   fontSize: 15,
//                                                 ),
//                                               ),
//                                             ),
//                                             pw.Container(
//                                               width: width * 0.5,
//                                               // color: PdfColors.amber,
//                                               alignment:
//                                                   pw.Alignment.centerLeft,
//                                               child: pw.Text(
//                                                 '${orderMasterdata![0].Bil_Pincode}',
//                                                 textAlign: pw.TextAlign.left,
//                                                 maxLines: 10,
//                                                 style: pw.TextStyle(
//                                                   // fontWeight:FontWeight.bold,
//                                                   fontSize: 15,
//                                                 ),
//                                               ),
//                                             ),
//                                           ])),
//                                   pw.Container(
//                                       alignment: pw.Alignment.centerRight,
//                                       child: pw.Column(
//                                           crossAxisAlignment:
//                                               pw.CrossAxisAlignment.end,
//                                           children: [
//                                             pw.Text(
//                                               'Shipping Address',
//                                               style: pw.TextStyle(
//                                                 fontWeight: pw.FontWeight.bold,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                             pw.Container(
//                                               width: width * 0.5,
//                                               // color: PdfColors.amber,
//                                               alignment:
//                                                   pw.Alignment.centerRight,
//                                               child: pw.Text(
//                                                 '${orderMasterdata![0].Del_Address1}',
//                                                 textAlign: pw.TextAlign.left,
//                                                 maxLines: 10,
//                                                 style: pw.TextStyle(
//                                                   // fontWeight:FontWeight.bold,
//                                                   fontSize: 15,
//                                                 ),
//                                               ),
//                                             ),
//                                             pw.Container(
//                                               width: width * 0.5,
//                                               // color: PdfColors.amber,
//                                               alignment:
//                                                   pw.Alignment.centerRight,
//                                               child: pw.Text(
//                                                 '${orderMasterdata![0].Del_Address2}',
//                                                 textAlign: pw.TextAlign.left,
//                                                 maxLines: 10,
//                                                 style: pw.TextStyle(
//                                                   // fontWeight:FontWeight.bold,
//                                                   fontSize: 15,
//                                                 ),
//                                               ),
//                                             ),
//                                             pw.Container(
//                                               width: width * 0.5,
//                                               // color: PdfColors.amber,
//                                               alignment:
//                                                   pw.Alignment.centerRight,
//                                               child: pw.Text(
//                                                 '${orderMasterdata![0].Del_Area}',
//                                                 textAlign: pw.TextAlign.left,
//                                                 maxLines: 10,
//                                                 style: pw.TextStyle(
//                                                   // fontWeight:FontWeight.bold,
//                                                   fontSize: 15,
//                                                 ),
//                                               ),
//                                             ),
//                                             pw.Container(
//                                               width: width * 0.5,
//                                               // color: PdfColors.amber,
//                                               alignment:
//                                                   pw.Alignment.centerRight,
//                                               child: pw.Text(
//                                                 '${orderMasterdata![0].Del_City}',
//                                                 textAlign: pw.TextAlign.left,
//                                                 maxLines: 10,
//                                                 style: pw.TextStyle(
//                                                   // fontWeight:FontWeight.bold,
//                                                   fontSize: 15,
//                                                 ),
//                                               ),
//                                             ),
//                                             pw.Container(
//                                               width: width * 0.5,
//                                               // color: PdfColors.amber,
//                                               alignment:
//                                                   pw.Alignment.centerRight,
//                                               child: pw.Text(
//                                                 '${orderMasterdata![0].Del_State}',
//                                                 textAlign: pw.TextAlign.left,
//                                                 maxLines: 10,
//                                                 style: pw.TextStyle(
//                                                   // fontWeight:FontWeight.bold,
//                                                   fontSize: 15,
//                                                 ),
//                                               ),
//                                             ),
//                                             pw.Container(
//                                               width: width * 0.5,
//                                               // color: PdfColors.amber,
//                                               alignment:
//                                                   pw.Alignment.centerRight,
//                                               child: pw.Text(
//                                                 '${orderMasterdata![0].Del_Pincode}',
//                                                 textAlign: pw.TextAlign.left,
//                                                 maxLines: 10,
//                                                 style: pw.TextStyle(
//                                                   // fontWeight:FontWeight.bold,
//                                                   fontSize: 15,
//                                                 ),
//                                               ),
//                                             ),
//                                           ])),
//                                 ],
//                               ),
//                               pw.SizedBox(height: 1 * PdfPageFormat.cm),

//                               pw.Table.fromTextArray(
//                                 headers: headers,
//                                 data: data3,
//                                 border: null,
//                                 headerStyle: pw.TextStyle(
//                                     fontWeight: pw.FontWeight.bold),
//                                 headerDecoration:
//                                     pw.BoxDecoration(color: PdfColors.grey300),
//                                 cellHeight: 30,
//                                 columnWidths: {
//                                   0: pw.FlexColumnWidth(width * 0.05),
//                                   1: pw.FlexColumnWidth(width * 0.2),
//                                   2: pw.FlexColumnWidth(width * 0.05),
//                                 },
//                                 headerAlignments: {
//                                   0: pw.Alignment.centerLeft,
//                                   1: pw.Alignment.center,
//                                   2: pw.Alignment.centerRight,
//                                   3: pw.Alignment.centerRight,
//                                 },
//                                 cellAlignments: {
//                                   0: pw.Alignment.centerLeft,
//                                   1: pw.Alignment.center,
//                                   2: pw.Alignment.centerRight,
//                                   3: pw.Alignment.centerRight,
//                                 },
//                               ),
//                               pw.Divider(),
//                             ])),
//                     pw.Container(
//                         child: pw.Row(children: [
//                       pw.Spacer(flex: 6),
//                       pw.Container(
//                         width: width * 0.4,
//                         child: pw.Row(
//                           children: [
//                             pw.Expanded(
//                                 child: pw.Text("Tax Amount",
//                                     style: pw.TextStyle(
//                                       fontWeight: pw.FontWeight.bold,
//                                       fontSize: 15,
//                                     ))),
//                             pw.Text("${orderMasterdata![0].TaxAmount}",
//                                 style: pw.TextStyle(
//                                   fontSize: 14,
//                                 )),
//                           ],
//                         ),
//                       ),
//                     ])),

//                     pw.Container(
//                         child: pw.Row(children: [
//                       pw.Spacer(flex: 6),
//                       pw.Container(
//                         width: width * 0.4,
//                         child: pw.Row(
//                           children: [
//                             pw.Expanded(
//                                 child: pw.Text("Doc Total",
//                                     style: pw.TextStyle(
//                                       fontWeight: pw.FontWeight.bold,
//                                       fontSize: 15,
//                                     ))),
//                             pw.Text("${orderMasterdata![0].DocTotal}",
//                                 style: pw.TextStyle(
//                                   fontSize: 14,
//                                 )),
//                           ],
//                         ),
//                       ),
//                     ])),
//                     pw.Container(
//                         child: pw.Row(
//                       children: [
//                         pw.Spacer(flex: 6),

//                         // pw.Container(
//                         //     child: pw.Row(children: [
//                         //   pw.Spacer(flex: 6),
//                         //   pw.Container(
//                         //     width: width * 0.4,
//                         //     child: pw.Row(
//                         //       children: [
//                         //         pw.Expanded(
//                         //             child: pw.Text("Tax Amount",
//                         //                 style: pw.TextStyle(
//                         //                   fontWeight: pw.FontWeight.bold,
//                         //                   fontSize: 15,
//                         //                 ))),
//                         //         pw.Text("${orderMasterdata![0].TaxAmount}",
//                         //             style: pw.TextStyle(
//                         //               fontSize: 14,
//                         //             )),
//                         //       ],
//                         //     ),
//                         //   ),
//                         // ]))
//                         // pw.Row(
//                         //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                         //     children: [
//                         //       pw.Container(
//                         //         decoration:
//                         //             pw.BoxDecoration(border: pw.Border.all()),
//                         //         child: pw.Text(
//                         //           'S.No',
//                         //           style: pw.TextStyle(
//                         //             // fontWeight:FontWeight.bold,
//                         //             fontSize: 14,
//                         //           ),
//                         //         ),
//                         //       ),
//                         //       pw.Container(
//                         //         decoration:
//                         //             pw.BoxDecoration(border: pw.Border.all()),
//                         //         child: pw.Text(
//                         //           'Invoice Document No',
//                         //           style: pw.TextStyle(
//                         //             // fontWeight:FontWeight.bold,
//                         //             fontSize: 14,
//                         //           ),
//                         //         ),
//                         //       ),
//                         //       pw.Container(
//                         //         decoration:
//                         //             pw.BoxDecoration(border: pw.Border.all()),
//                         //         child: pw.Text(
//                         //           'Total',
//                         //           style: pw.TextStyle(
//                         //             // fontWeight:FontWeight.bold,
//                         //             fontSize: 14,
//                         //           ),
//                         //         ),
//                         //       ),
//                         //       pw.Container(
//                         //         decoration:
//                         //             pw.BoxDecoration(border: pw.Border.all()),
//                         //         child: pw.Text(
//                         //           'Total Payment',
//                         //           style: pw.TextStyle(
//                         //             // fontWeight:FontWeight.bold,
//                         //             fontSize: 14,
//                         //           ),
//                         //         ),
//                         //       ),
//                         //     ]),
//                         // pw.Table.fromTextArray(
//                         //     cellAlignment: pw.Alignment.center,
//                         //     headerStyle: pw.TextStyle(
//                         //       fontSize: 14.0,
//                         //     ),
//                         //     cellStyle: pw.TextStyle(
//                         //       fontSize: 14.0,
//                         //     ),
//                         //     columnWidths: {
//                         //       0: pw.FlexColumnWidth(2.1),
//                         //       1: pw.FlexColumnWidth(2.1),
//                         //       2: pw.FlexColumnWidth(2.1),
//                         //       // 3: pw.FlexColumnWidth(1.8),
//                         //       // 4: pw.FlexColumnWidth(4),
//                         //       // 5: pw.FlexColumnWidth(4),
//                         //     },
//                         //     // headers: headers,
//                         //     // data: data
//                         //     ),
//                         // pw.Container(
//                         //   child: pw.Row(
//                         //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                         //     children: [
//                         //       pw.Container(
//                         //         child: pw.Column(
//                         //           // mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                         //           crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         //           children: [
//                         //             pw.Container(
//                         //               alignment: pw.Alignment.centerLeft,
//                         //               child: pw.Text(
//                         //                 "Remarks:Balance 2000",
//                         //                 style: pw.TextStyle(
//                         //                   fontSize: 14.0,
//                         //                 ),
//                         //               ),
//                         //             ),
//                         //             pw.SizedBox(height: height * 0.05),
//                         //             pw.Container(
//                         //                 child: pw.Row(
//                         //               children: [
//                         //                 pw.Column(
//                         //                   crossAxisAlignment:
//                         //                       pw.CrossAxisAlignment.start,
//                         //                   children: [
//                         //                     pw.Container(
//                         //                       child: pw.Text("Boss",
//                         //                           style: pw.TextStyle(
//                         //                             fontSize: 14.0,
//                         //                           )),
//                         //                     ),
//                         //                     pw.Container(
//                         //                       child: pw.Text("Signature",
//                         //                           style: pw.TextStyle(
//                         //                               fontSize: 14.0,
//                         //                               fontWeight:
//                         //                                   pw.FontWeight.bold)),
//                         //                     ),
//                         //                   ],
//                         //                 ),
//                         //                 pw.SizedBox(width: width * 0.1),
//                         //                 pw.Column(
//                         //                   crossAxisAlignment:
//                         //                       pw.CrossAxisAlignment.start,
//                         //                   children: [
//                         //                     pw.Container(
//                         //                       child: pw.Text("04/07/2023",
//                         //                           style: pw.TextStyle(
//                         //                             fontSize: 14.0,
//                         //                           )),
//                         //                     ),
//                         //                     pw.Container(
//                         //                       child: pw.Text("Date",
//                         //                           style: pw.TextStyle(
//                         //                               fontSize: 14.0,
//                         //                               fontWeight:
//                         //                                   pw.FontWeight.bold)),
//                         //                     ),
//                         //                   ],
//                         //                 ),
//                         //               ],
//                         //             ))
//                         //           ],
//                         //         ),
//                         //       ),
//                         //       //
//                         //       pw.Container(
//                         //         child: pw.Column(
//                         //           children: [
//                         //             pw.Container(
//                         //               width: width * 0.4,
//                         //               child: pw.Row(
//                         //                 mainAxisAlignment:
//                         //                     pw.MainAxisAlignment.spaceBetween,
//                         //                 children: [
//                         //                   pw.Container(
//                         //                     child: pw.Text("Cash",
//                         //                         style: pw.TextStyle(
//                         //                           fontSize: 14.0,
//                         //                         )),
//                         //                   ),
//                         //                   pw.Container(
//                         //                     child: pw.Text("20000",
//                         //                         style: pw.TextStyle(
//                         //                           fontSize: 14.0,
//                         //                         )),
//                         //                   )
//                         //                 ],
//                         //               ),
//                         //             ),
//                         //             pw.Container(
//                         //               width: width * 0.4,
//                         //               child: pw.Row(
//                         //                 mainAxisAlignment:
//                         //                     pw.MainAxisAlignment.spaceBetween,
//                         //                 children: [
//                         //                   pw.Container(
//                         //                     child: pw.Text("Card",
//                         //                         style: pw.TextStyle(
//                         //                           fontSize: 14.0,
//                         //                         )),
//                         //                   ),
//                         //                   pw.Container(
//                         //                     child: pw.Text("1000",
//                         //                         style: pw.TextStyle(
//                         //                           fontSize: 14.0,
//                         //                         )),
//                         //                   )
//                         //                 ],
//                         //               ),
//                         //             ),
//                         //             pw.Container(
//                         //               width: width * 0.4,
//                         //               child: pw.Row(
//                         //                 mainAxisAlignment:
//                         //                     pw.MainAxisAlignment.spaceBetween,
//                         //                 children: [
//                         //                   pw.Container(
//                         //                     child: pw.Text("Bank",
//                         //                         style: pw.TextStyle(
//                         //                           fontSize: 14.0,
//                         //                         )),
//                         //                   ),
//                         //                   pw.Container(
//                         //                     child: pw.Text("2000",
//                         //                         style: pw.TextStyle(
//                         //                           fontSize: 14.0,
//                         //                         )),
//                         //                   )
//                         //                 ],
//                         //               ),
//                         //             ),
//                         //             pw.Container(
//                         //               width: width * 0.4,
//                         //               child: pw.Row(
//                         //                 mainAxisAlignment:
//                         //                     pw.MainAxisAlignment.spaceBetween,
//                         //                 children: [
//                         //                   pw.Container(
//                         //                     child: pw.Text("Cheque",
//                         //                         style: pw.TextStyle(
//                         //                           fontSize: 14.0,
//                         //                         )),
//                         //                   ),
//                         //                   pw.Container(
//                         //                     child: pw.Text("200",
//                         //                         style: pw.TextStyle(
//                         //                           fontSize: 14.0,
//                         //                         )),
//                         //                   )
//                         //                 ],
//                         //               ),
//                         //             ),
//                         //             pw.Container(
//                         //               width: width * 0.4,
//                         //               child: pw.Row(
//                         //                 mainAxisAlignment:
//                         //                     pw.MainAxisAlignment.spaceBetween,
//                         //                 children: [
//                         //                   pw.Container(
//                         //                     child: pw.Text("Total",
//                         //                         style: pw.TextStyle(
//                         //                             fontSize: 14.0,
//                         //                             fontWeight:
//                         //                                 pw.FontWeight.bold)),
//                         //                   ),
//                         //                   pw.Container(
//                         //                     child: pw.Text("23200",
//                         //                         style: pw.TextStyle(
//                         //                             fontSize: 14.0,
//                         //                             fontWeight:
//                         //                                 pw.FontWeight.bold)),
//                         //                   )
//                         //                 ],
//                         //               ),
//                         //             )
//                         //           ],
//                         //         ),
//                         //       )
//                         //     ],
//                         //   ),
//                         // )
//                       ],
//                     )),

//                     pw.SizedBox(height: 20),
//                     // pw.Flexible(child: pw.FlutterLogo())
//                   ],
//                 ),
//               ]

//           // final headers = [
//           //   "S.No",
//           //   "Invoice Document No",
//           //   "Total",
//           //   "Total Payment",
//           //   // "EMI Date",
//           //   // "EMI Status",
//           //   // "Reason"
//           // ];
//           // List<List<dynamic>> data;
//           // data = dasa!.map((e) {
//           //   // final total = ("123312");
//           //   return [
//           //     '${e.id}',
//           //     '${e.invoiceNo}',
//           //     '${e.total}',
//           //     '${e.totalPayment}',
//           //   ];
//           // }).toList();

//           ),
//     );

//     return pdf.save();
//   }
// }
