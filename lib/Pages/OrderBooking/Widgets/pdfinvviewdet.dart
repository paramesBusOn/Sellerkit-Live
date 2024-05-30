import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:open_file/open_file.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/GetOderDetailsQTHModel.dart';
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/OrderSavePostModel.dart';
import 'package:sellerkit/Services/customerdetApi/customerdetApi.dart';


class PdfInvoicePdfviewHelper {
//  static dynamic height;
//   static dynamic width;
  static List<GetOrderQTLData> data2 = [];
  
static customerdetData? customermodeldata;
  static List<GetOrderDeatilsQTHData>? orderMasterdata2 = [];
  static List<GetOrderDeatilsQTHData>? orderMasterdata = [];
   static String paymode = '';
// int i=0;
//  int pageNumber=i+1;
  // static List<InvoiceData>? dasa = [];
  String? date = '';
  static Future<TtfFont> loadFont() async {
    final ByteData data = await rootBundle.load('Assets/Ingeborg-Regular.ttf');
    final Uint8List bytes = data.buffer.asUint8List();
    return TtfFont(bytes.buffer.asByteData());
  }

  static Future<TtfFont> caliberFont() async {
    final ByteData data = await rootBundle.load('Assets/Calibri.ttf');
    final Uint8List bytes = data.buffer.asUint8List();
    return TtfFont(bytes.buffer.asByteData());
  }

  static Future<TtfFont> caliberFontbold() async {
    final ByteData data = await rootBundle.load('Assets/CalibriBold.ttf');
    final Uint8List bytes = data.buffer.asUint8List();
    return TtfFont(bytes.buffer.asByteData());
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static Future<Uint8List> generatePdf(
      PdfPageFormat format, String title) async {
    Config config = Config();
    final TtfFont font = await loadFont();
    final TtfFont Calibrifont = await caliberFont();
    final TtfFont Calibrifontbold = await caliberFontbold();
     final netImage =customermodeldata!.storeLogoUrl != null&& customermodeldata!.storeLogoUrl!.isNotEmpty? await networkImage(customermodeldata!.storeLogoUrl!):null;
   
    final pdf = Document(
      // pageFormat: PdfPageFormat.a4.copyWith(
      //     //  marginBottom: 0,
      //     //     marginLeft: 0,
      //     //     marginRight: PdfPageFormat.cm*0.07,
      //     //     marginTop: 0,
      //         width: PdfPageFormat.a4.width ,
      //     height: PdfPageFormat.a4.height ,

      //      ),
      pageMode: PdfPageMode.none,
    );
// for (int pageNumber = 1; pageNumber <= 10; pageNumber++) {
    pdf.addPage(MultiPage(
      maxPages: 100,
      pageFormat: PdfPageFormat.a4.copyWith(
        marginBottom: 0,
        marginLeft: 0,
        marginRight: PdfPageFormat.a4.width * 0.07,
        marginTop: 0,
        width: PdfPageFormat.a4.width,
        height: PdfPageFormat.a4.height,
      ),
      header: (context) {
        return buildHeader(
            orderMasterdata, font, Calibrifont, config, Calibrifontbold,netImage ??null);
      },
      build: (context) => [
        // SizedBox(height: 1 * PdfPageFormat.cm),
        // buildTitle(invoice),
        buildInvoice(data2, font, Calibrifont, config, Calibrifontbold),
        Padding(
          padding: EdgeInsets.only(left: PdfPageFormat.a4.width * 0.07),
          child: Divider(),
        ),

        buildTotal(orderMasterdata, font, Calibrifont, config, Calibrifontbold),
        buildcontainer(),
      ],
      footer: (context) => buildFooter(context, config, Calibrifont),
    ));
// }

    return pdf.save();
  }

  static Widget buildcontainer() => Expanded(
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(
                      color: PdfColor.fromHex("#750537"),
                      width: PdfPageFormat.a4.width * 0.07)))));

  static pw.Widget buildHeader(List<GetOrderDeatilsQTHData>? orderMasterdata, TtfFont font,
          TtfFont Calibrifont, Config config, TtfFont Calibrifontbold,ImageProvider? netImage) =>
      // Row(
      //   children: [
      //       Container(
      //    width: PdfPageFormat.a4.width*0.05,

      //    height:PdfPageFormat.a4.marginLeft*0.3,
      //             color: PdfColor.fromHex("#750537"),
      //  ),
      //             SizedBox(width: PdfPageFormat.a4.width*0.05),

      Container(
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(
                      color: PdfColor.fromHex("#750537"),
                      width: PdfPageFormat.a4.width * 0.07))),
          child: Padding(
              padding: EdgeInsets.only(left: PdfPageFormat.a4.width * 0.07),
              child: Column(
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(height: 1 * PdfPageFormat.cm),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: PdfColors.amber,
                            child: Text(
                              'ORDER',
                              style: TextStyle(
                                  font: font,
                                  // fontWeight:FontWeight.bold,
                                  //  fontStyle: P,
                                  fontSize: 40,
                                  color: PdfColor.fromHex("#750537")),
                            ),
                          ),


                          Container(
                            child: Row(children: [
 Container(
                            alignment: Alignment.centerRight,
                           width: PdfPageFormat.a4.width *0.4,
                            //  color: PdfColors.amber,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${customermodeldata!.cardName}',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        font: Calibrifontbold,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: PdfColor.fromHex("#750537")),
                                  ),
                                  
                                  Container(
                                    // color: PdfColors.amber,
                                    alignment: Alignment.centerRight,
                                    width: PdfPageFormat.a4.width * 0.4,
                                    child: Text(
                                      '${customermodeldata!.address1}, ${customermodeldata!.address2}, ${customermodeldata!.city}, ${customermodeldata!.state}, ${customermodeldata!.pincode}',
                                      textAlign: TextAlign.right,
                                      maxLines: 3,
                                      style: TextStyle(
                                        font: Calibrifont,
                                        //  fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // color: PdfColors.amber,
                                    alignment: Alignment.centerRight,
                                    width: PdfPageFormat.a4.width * 0.4,
                                    child: Text(
                                      ' GSTIN:${customermodeldata!.gstin}',
                                      textAlign: TextAlign.right,
                                      maxLines: 3,
                                      style: TextStyle(
                                        font: Calibrifont,
                                        //  fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        SizedBox(width: PdfPageFormat.a4.width *0.01),
                      
                        netImage !=null ?       Container(
                          height: PdfPageFormat.a4.height*0.07,
                          width: PdfPageFormat.a4.width *0.1,
                        child:pw.Image(netImage,fit: BoxFit.fill)
                      ):Container()
                            ])
                          ),
                         
                        ]),
                    SizedBox(height: 1 * PdfPageFormat.cm),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'TO:',
                                    style: TextStyle(
                                        font: Calibrifontbold,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: PdfColor.fromHex("#750537")),
                                  ),
                                  Text(
                                    '  ${orderMasterdata![0].CardName}',
                                    style: TextStyle(
                                      font: Calibrifont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                   Container(
                                    // color: PdfColors.amber,
                                    alignment: Alignment.centerLeft,
                                    width: PdfPageFormat.a4.width * 0.5,
                                    child: Text(
                                      '  ${orderMasterdata![0].CardCode}',
                                      textAlign: TextAlign.right,
                                      maxLines: 3,
                                      style: TextStyle(
                                        font: Calibrifont,
                                         decoration: TextDecoration.underline,
                                        color: PdfColors.blue,
                                        //  fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: PdfPageFormat.a4.width * 0.5,
                                    // color: PdfColors.amber,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '  ${orderMasterdata![0].Address1},${orderMasterdata![0].Address2}',
                                      textAlign: TextAlign.left,
                                      maxLines: 10,
                                      style: TextStyle(
                                        font: Calibrifont,
                                        // fontWeight:FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   width: width * 0.5,
                                  //   // color: PdfColors.amber,
                                  //   alignment:
                                  //       Alignment.centerLeft,
                                  //   child: Text(
                                  //     '',
                                  //     textAlign: TextAlign.left,
                                  //     maxLines: 10,
                                  //     style: TextStyle(
                                  //       // fontWeight:FontWeight.bold,
                                  //       fontSize: 15,
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(
                                    width: PdfPageFormat.a4.width * 0.5,
                                    // color: PdfColors.amber,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '  ${orderMasterdata![0].area},${orderMasterdata![0].City}',
                                      textAlign: TextAlign.left,
                                      maxLines: 10,
                                      style: TextStyle(
                                        font: Calibrifont,
                                        // fontWeight:FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   width: width * 0.5,
                                  //   // color: PdfColors.amber,
                                  //   alignment:
                                  //       Alignment.centerLeft,
                                  //   child: Text(
                                  //     '',
                                  //     textAlign: TextAlign.left,
                                  //     maxLines: 10,
                                  //     style: TextStyle(
                                  //       // fontWeight:FontWeight.bold,
                                  //       fontSize: 15,
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(
                                    width: PdfPageFormat.a4.width * 0.5,
                                    // color: PdfColors.amber,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '  ${orderMasterdata![0].state},${orderMasterdata![0].Pincode}',
                                      textAlign: TextAlign.left,
                                      maxLines: 10,
                                      style: TextStyle(
                                        font: Calibrifont,
                                        // fontWeight:FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: PdfPageFormat.a4.width * 0.5,
                                    // color: PdfColors.amber,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '  GSTIN: ${orderMasterdata![0].gst}',
                                      textAlign: TextAlign.left,
                                      maxLines: 10,
                                      style: TextStyle(
                                        font: Calibrifont,
                                        // fontWeight:FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          Container(
                              width: PdfPageFormat.a4.width * 0.3,
                              // color: PdfColors.amber,
                              child: Column(children: [
                                Row(children: [
                                  Container(
                                    width: PdfPageFormat.a4.width * 0.13,
                                    //  color: PdfColors.red,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Order No ',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        font: Calibrifontbold,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        //  color: PdfColor.fromHex("#750537")
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // width: PdfPageFormat.a4.width * 0.15,
                                    //  color: PdfColors.red,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      ': ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        font: Calibrifontbold,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        //  color: PdfColor.fromHex("#750537")
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: PdfPageFormat.a4.width * 0.15,
                                    //  alignment: Alignment.centerLeft,
                                    child: Text(
                                      '#${orderMasterdata![0].OrderNum}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        font: Calibrifont,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        //  color: PdfColor.fromHex("#750537")
                                      ),
                                    ),
                                  )
                                ]),
                                Row(children: [
                                  Container(
                                    width: PdfPageFormat.a4.width * 0.13,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Order Dt',
                                      style: TextStyle(
                                        font: Calibrifontbold,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // width: PdfPageFormat.a4.width * 0.15,
                                    //  color: PdfColors.red,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      ': ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        font: Calibrifontbold,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        //  color: PdfColor.fromHex("#750537")
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: PdfPageFormat.a4.width * 0.15,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${config.alignDate(orderMasterdata![0].OrderCreatedDate.toString())}',
                                      style: TextStyle(
                                        font: Calibrifont,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ]),
                                Row(children: [
                                  Container(
                                    width: PdfPageFormat.a4.width * 0.13,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Sales Person',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        font: Calibrifontbold,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        //  color: PdfColor.fromHex("#750537")
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // width: PdfPageFormat.a4.width * 0.15,
                                    //  color: PdfColors.red,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      ': ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        font: Calibrifontbold,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        //  color: PdfColor.fromHex("#750537")
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: PdfPageFormat.a4.width * 0.15,
                                    //  alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${ConstantValues.firstName}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        font: Calibrifont,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        //  color: PdfColor.fromHex("#750537")
                                      ),
                                    ),
                                  )
                                ]),
                                Row(children: [
                                  Container(
                                    width: PdfPageFormat.a4.width * 0.13,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Store',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        font: Calibrifontbold,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        //  color: PdfColor.fromHex("#750537")
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // width: PdfPageFormat.a4.width * 0.15,
                                    //  color: PdfColors.red,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      ': ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        font: Calibrifontbold,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        //  color: PdfColor.fromHex("#750537")
                                      ),
                                    ),
                                  ),
                                  Container(
                                    //  alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${orderMasterdata![0].StoreCode}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        font: Calibrifont,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        //  color: PdfColor.fromHex("#750537")
                                      ),
                                    ),
                                  )
                                ]),
                              ]))
                        ]),
                    // ])
                    SizedBox(height: 1 * PdfPageFormat.cm),
                  ])));

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }

  // static Widget buildTitle(TtfFont font,
  //         TtfFont Calibrifont, Config config) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Fist PDF',
  //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(height: 0.8 * PdfPageFormat.cm),
  //         Text(invoice.info.description),
  //         SizedBox(height: 0.8 * PdfPageFormat.cm),
  //       ],
  //     );

  static Widget buildInvoice(List<GetOrderQTLData> data2, TtfFont font,
      TtfFont Calibrifont, Config config, TtfFont Calibrifontbold) {
         int  i=1;
    final headers = [
      'S.No',
      'Description',
      'Qty',
      'Price',
      "Disc %",
      'Tax %',
      'Total',
    ];
     data2.sort((a, b) => b.BasePrice!.compareTo(a.BasePrice!));
    final data = data2.map((item) {

       double? mrpvalue;
      double? Discount;
      if(item.MRP! >0.00){
      double mrp2=double.parse(item.MRP!.toStringAsFixed(2));
 
 double tax2=double.parse(item.TaxCode!.toStringAsFixed(2));
      mrpvalue=mrp2 /(1+(tax2/100));
   log("mrpvalue::"+mrpvalue.toString());
     
      if(item.MRP! >0.00 ||item.Price! >0.00){
        // double mrp2=double.parse(item.MRP!.toStringAsFixed(2));
        double Price2=double.parse(item.Price!.toStringAsFixed(2));
         log("mrp"+mrp2.toString()+"Price2"+Price2.toString());
        
         Discount = ((mrp2 - Price2)/mrp2) * 100;
   
   log("Discount2222::"+Discount.toString());
      }else {
   Discount=0.00;
      log("Discount::"+Discount.toString());
      }
      if (mrpvalue.isNaN || mrpvalue.isInfinite) {
    mrpvalue = 0.0; 
  }
  if (Discount.isNaN || Discount.isInfinite) {
    Discount = 0.0; 
  }  
      }else{
        double mrp2=double.parse(item.BasePrice!.toStringAsFixed(2));
 
 double tax2=double.parse(item.TaxCode!.toStringAsFixed(2));
      mrpvalue=mrp2 /(1+(tax2/100));
   log("mrpvalue0000::"+mrpvalue.toString());
   
      if(item.MRP! >0.00 ||item.Price! >0.00){
        // double mrp2=double.parse(item.MRP!.toStringAsFixed(2));
        double Price2=double.parse(item.Price!.toStringAsFixed(2));
         log("mrp"+mrp2.toString()+"Price2"+Price2.toString());
        
         Discount = ((mrp2 - Price2)/mrp2) * 100;
   
   log("Discount2222::"+Discount.toString());
      }else {
   Discount=0.00;
      log("Discount::"+Discount.toString());
      }
      if (mrpvalue.isNaN || mrpvalue.isInfinite) {
    mrpvalue = 0.0; 
  }
  if (Discount.isNaN || Discount.isInfinite) {
    Discount = 0.0; 
  }
      }
      
      // final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
         i++,
        item.ItemName,
        item.Quantity!.toInt(),
      config.slpitCurrencypdf(mrpvalue.round().toStringAsFixed(2)) ,
       Discount.round().toStringAsFixed(2),
        item.TaxCode!.round().toStringAsFixed(2),
       config.slpitCurrencypdf (item.GrossLineTotal!.round().toStringAsFixed(2)),
      ];
    }).toList();

    return Container(
        decoration: BoxDecoration(
            border: Border(
                left: BorderSide(
                    color: PdfColor.fromHex("#750537"),
                    width: PdfPageFormat.a4.width * 0.07))),
        child: Padding(
            padding: EdgeInsets.only(left: PdfPageFormat.a4.width * 0.07),
            child: Table.fromTextArray(
              headers: headers,
              data: data,
              border: null,
              cellStyle: TextStyle(font: Calibrifont, fontSize: 10),
              headerStyle: TextStyle(
                  font: Calibrifontbold,
                  // fontWeight: FontWeight.bold,
                  color: PdfColors.white),
              headerDecoration:
                  BoxDecoration(color: PdfColor.fromHex("#750537")),
              cellHeight: 0.0,
              columnWidths: {
               0: FlexColumnWidth(PdfPageFormat.a4.width * 0.06),
                1: FlexColumnWidth(PdfPageFormat.a4.width * 0.2),
                2: FlexColumnWidth(PdfPageFormat.a4.width * 0.1),
                3: FlexColumnWidth(PdfPageFormat.a4.width * 0.1),
                4: FlexColumnWidth(PdfPageFormat.a4.width * 0.1),
                5: FlexColumnWidth(PdfPageFormat.a4.width * 0.1),
                6: FlexColumnWidth(PdfPageFormat.a4.width * 0.1),
              },
              headerAlignments: {
               0: Alignment.centerLeft,
                1: Alignment.center,
                2: Alignment.centerRight,
                3: Alignment.centerRight,
                4: Alignment.centerRight,
                5: Alignment.centerRight,
                6: Alignment.centerRight,
              },
              cellAlignments: {
                0: Alignment.topCenter,
                1: Alignment.centerLeft,
                2: Alignment.centerRight,
                3: Alignment.centerRight,
                4: Alignment.centerRight,
                5: Alignment.centerRight,
                6: Alignment.centerRight,
              },
            )));
//    Row(children: [
//  Container(
//              width: PdfPageFormat.a4.width*0.05,

//              height:PdfPageFormat.a4.marginLeft*0.3,
//                       color: PdfColor.fromHex("#750537"),
//            ),
//                       SizedBox(width: PdfPageFormat.a4.width*0.05),
//                       Column(children: [

    //                     ])
    //  ]);
  }

  static Widget buildTotal(List<GetOrderDeatilsQTHData>? orderMasterdata, TtfFont font,
      TtfFont Calibrifont, Config config, TtfFont Calibrifontbold) {
    //

    return
        //  Row(children: [
        //   Container(
        //            width: PdfPageFormat.a4.width*0.05,

        //            height:PdfPageFormat.a4.marginLeft*0.3,
        //                     color: PdfColor.fromHex("#750537"),
        //          ),
        //                     SizedBox(width: PdfPageFormat.a4.width*0.05),
        Container(
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                        color: PdfColor.fromHex("#750537"),
                        width: PdfPageFormat.a4.width * 0.07))),
            child: Padding(
                padding: EdgeInsets.only(left: PdfPageFormat.a4.width * 0.07),
                child: Column(children: [
                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // color:PdfColors.amber,
                            width: PdfPageFormat.a4.width * 0.50,
                            // color: PdfColors.amber,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text("Terms and Conditions",
                                          style: TextStyle(
                                            font: Calibrifontbold,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10,
                                          ))),
                                  Row(children: [
                                    Container(
                                        width: PdfPageFormat.a4.width * 0.15,
                                        // color: PdfColors.red,
                                        child: Text("Delivery Date",
                                            style: TextStyle(
                                              font: Calibrifontbold,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ))),
                                    Container(
                                        // width: PdfPageFormat.a4.width * 0.15,
                                        // color: PdfColors.red,
                                        child: Text(": ",
                                            style: TextStyle(
                                              font: Calibrifontbold,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ))),
                                    Container(
                                        width: PdfPageFormat.a4.width * 0.15,
                                        // color: PdfColors.red,
                                        child: Text(
                                            "${config.alignDate(orderMasterdata![0].deliveryduedate.toString())}",
                                            style: TextStyle(
                                              font: Calibrifont,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ))),
                                  ]),
                                  Row(children: [
                                    Container(
                                        width: PdfPageFormat.a4.width * 0.15,
                                        child: Text("Payment Due Date",
                                            style: TextStyle(
                                              font: Calibrifontbold,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ))),
                                    Container(
                                        //  width: PdfPageFormat.a4.width * 0.15,
                                        child: Text(": ",
                                            style: TextStyle(
                                              font: Calibrifontbold,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ))),
                                    Container(
                                        width: PdfPageFormat.a4.width * 0.15,
                                        child: Text(
                                            "${config.alignDate(orderMasterdata![0].PaymentDueDate.toString())}",
                                            style: TextStyle(
                                              font: Calibrifont,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ))),
                                  ]),
                                  Row(children: [
                                    Container(
                                        width: PdfPageFormat.a4.width * 0.15,
                                        child: Text("Mode of Payment",
                                            style: TextStyle(
                                              font: Calibrifontbold,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                            ))),
                                    Container(
                                        // width: PdfPageFormat.a4.width * 0.15,
                                        child: Text(": ",
                                            style: TextStyle(
                                              font: Calibrifont,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ))),
                                    Container(
                                        width: PdfPageFormat.a4.width * 0.15,
                                        child: Text("${paymode}",
                                            style: TextStyle(
                                              font: Calibrifont,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ))),
                                  ]),
                                ]),
                          ),
                          Container(
                              width: PdfPageFormat.a4.width * 0.25,
                              // color: PdfColors.pink,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: PdfPageFormat.a4.width * 0.20,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width:
                                                  PdfPageFormat.a4.width * 0.10,
                                              // color: PdfColors.amber,
                                              child: Text("  Sub Total",
                                                  style: TextStyle(
                                                    font: Calibrifontbold,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ))),
                                          Container(
                                              // width: PdfPageFormat.a4.width * 0.15,
                                              child: Text(": ",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    font: Calibrifontbold,

                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ))),
                                          Container(
                                              // color: PdfColors.red,
                                              width:
                                                  PdfPageFormat.a4.width * 0.13,
                                              child: Text(
                                                  "${ config.slpitCurrencypdf(orderMasterdata![0].GrossTotal!.round().toStringAsFixed(2))}",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    font: Calibrifont,
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ))),
                                          // Text(
                                          //     "${orderMasterdata![0].GrossTotal!.toStringAsFixed(2)}",
                                          //     style: TextStyle(
                                          //       font: Calibrifont,
                                          //       fontSize: 12,
                                          //     )),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        child: Row(children: [
                                      // Spacer(flex: 6),
                                      Container(
                                        width: PdfPageFormat.a4.width * 0.2,
                                        // color: PdfColors.red,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width: PdfPageFormat.a4.width *
                                                    0.10,
                                                child: Text("  Tax",
                                                    style: TextStyle(
                                                      font: Calibrifontbold,
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: 10,
                                                    ))),
                                            Container(
                                                //  width: PdfPageFormat.a4.width * 0.10,
                                                child: Text(": ",
                                                    style: TextStyle(
                                                      font: Calibrifontbold,
                                                      // fontWeight: FontWeight.bold,
                                                      fontSize: 10,
                                                    ))),
                                            Container(
                                              width:
                                                  PdfPageFormat.a4.width * 0.13,
                                              child: Text(
                                                  "${ config.slpitCurrencypdf(orderMasterdata![0].taxAmount!.round().toStringAsFixed(2))}",
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    font: Calibrifont,
                                                    fontSize: 10,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ])),
                                    Container(
                                        child: Row(children: [
                                      // Spacer(flex: 6),
                                      Container(
                                        width: PdfPageFormat.a4.width * 0.2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width: PdfPageFormat.a4.width *
                                                    0.10,
                                                child: Text("  Round off",
                                                    style: TextStyle(
                                                      font: Calibrifontbold,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10,
                                                    ))),
                                            Container(
                                                child: Text(": ",
                                                    style: TextStyle(
                                                      font: Calibrifontbold,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10,
                                                    ))),
                                            Container(
                                              width:
                                                  PdfPageFormat.a4.width * 0.13,
                                              child: Text(
                                                  "${config.slpitCurrencypdf(orderMasterdata![0].RoundOff!.abs().round().toStringAsFixed(2)) }",
                                                  // orderMasterdata![0].roundoff!.toStringAsFixed(2)
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                    font: Calibrifont,
                                                    fontSize: 10,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ])),
                                    Container(
                                        color: PdfColor.fromHex("#750537"),
                                        child: Row(children: [
                                          // Spacer(flex: 6),
                                          Container(
                                            width: PdfPageFormat.a4.width * 0.2,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    width:
                                                        PdfPageFormat.a4.width *
                                                            0.10,
                                                    child: Text("  Total",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            font:
                                                                Calibrifontbold,
                                                            fontSize: 10,
                                                            color: PdfColors
                                                                .white))),
                                                Container(
                                                    child: Text(": ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            font:
                                                                Calibrifontbold,
                                                            fontSize: 10,
                                                            color: PdfColors
                                                                .white))),
                                                Container(
                                                  width:
                                                      PdfPageFormat.a4.width *
                                                          0.13,
                                                  child: Text(
                                                      "${ config.slpitCurrencypdf(orderMasterdata![0].DocTotal!.round().toStringAsFixed(2))}",
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                        font: Calibrifont,
                                                        color: PdfColors.white,
                                                        fontSize: 10,
                                                      )),
                                                )
                                              ],
                                            ),
                                          ),
                                        ])),
                                  ])),
                        ]),
                  ),
                ])));

    //  ]) ;
  }

  static Widget buildFooter(context, Config config, TtfFont font) =>
//   Row(children: [
// Container(
//              width: PdfPageFormat.a4.width*0.05,

//              height:PdfPageFormat.a4.marginLeft*0.3,
//                       color: PdfColor.fromHex("#750537"),
//            ),
//                       SizedBox(width: PdfPageFormat.a4.width*0.05),
      Container(
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(
                      color: PdfColor.fromHex("#750537"),
                      width: PdfPageFormat.a4.width * 0.07))),
          child: Padding(
              padding: EdgeInsets.only(left: PdfPageFormat.a4.width * 0.07),
              child: Column(
                  // cc
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     
                      children: [
Text(
                        "Page ${context.pageNumber} of ${context.pagesCount}",
                        style:
                            TextStyle(font: font, fontSize: 10),
                        textAlign: TextAlign.start),
                         Text(
                                      '${ConstantValues.firstName}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        font: font,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        //  color: PdfColor.fromHex("#750537")
                                      ),
                                    ),
                         Container(
                      // width: PdfPageFormat.a4.width*0.7,
                      child:Text(
                        'This is a System Generated Document.Signature not Required',
                        textAlign: TextAlign.center,
                        style: TextStyle(font: font, fontSize: 7)),),
                        Text("${config.currentDatepdf()}",
                    textAlign: TextAlign.end,
                        style: TextStyle(
                            font: font, fontSize: 10)),
                    ]),
                   
                      SizedBox(height: 1 * PdfPageFormat.mm),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
 
                 
                    
                    
                  //     ]),
                  //  SizedBox(height: 1 * PdfPageFormat.mm),

                    // SizedBox(height: 1 * PdfPageFormat.mm),

                    // buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
                    //   ],
                    // )
                  ])));

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }
  // static Widget buildSupplierAddress(Supplier supplier) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
  //         SizedBox(height: 1 * PdfPageFormat.mm),
  //         Text(supplier.address),
  //       ],
  //     );
//  static Future<File> generatePdf(Invoice invoice ) async {
//     Config config = Config();
//       final TtfFont font = await loadFont();
//       final TtfFont Calibrifont= await caliberFont();
//     final pdf = Document();
//     final headers = [
//       'S.No',
//       'Description',
//       'Qty',
//       'Price',
//       'Tax %',
//       'Total',
//     ];

//     final data = invoice.items.map((item) {
//       // final total = item.unitPrice * item.quantity * (1 + item.vat);

//       return [
//         item.description,
//         // Utils.formatDate(item.date),
//         '${item.quantity}',
//         '\$ ${item.unitPrice}',
//         '${item.vat} %',
//         // '\$ ${total.toStringAsFixed(2)}',

//       ];
//     }).toList();
//     // final font = await PdfGoogleFonts.nunitoExtraLight();
//     // final width = width!;
//     // final height = height!;

//     pdf.addPage(
//       MultiPage(
//    maxPages: 100,

//           pageFormat: PdfPageFormat.a4.copyWith(
//            marginBottom: 0,
//               marginLeft: 0,
//               marginRight: PdfPageFormat.cm*0.07,
//               marginTop: 0,
//               width: PdfPageFormat.a4.width ,
//           height: PdfPageFormat.a4.height ,

//            ),
//           build: (context) =>
//           //  pages
//           [

//           //  initialpage()
//           Container(

//                             // alignment: Alignment.t,
//                             // width: double.infinity,
//                             // height: height*0.96,
//                             // color: PdfColors.amber,
//                             child:
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                               Container(
//                      width: PdfPageFormat.cm*0.07,

//                      height:PdfPageFormat.cm,
//                               color: PdfColor.fromHex("#750537"),
//                    ),
//                               SizedBox(width: PdfPageFormat.cm*0.07),
//                               Expanded(
//                                 // width: width*.,
//                                 // height:height* 0.80,
//                               // color: PdfColors.blue,
//                                 child:
//                                  Column(

//                                     children: [
//                                       SizedBox(height: 1 * PdfPageFormat.cm),
//                                      Row(
//                                       mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                                       children: [
//                                       Container(
//                                         alignment: Alignment.center,
//                                         // color: PdfColors.amber,
//                                         child: Text(
//                                        'ORDER',

//                                        style: TextStyle(
//                                        font: font,
//                                          // fontWeight:FontWeight.bold,
//                                         //  fontStyle: P,
//                                          fontSize: 40,
//                                           color: PdfColor.fromHex("#750537")
//                                        ),
//                                         ),
//                                       ),

//                                       Container(
//                                          alignment: Alignment.centerRight,
//                                         // width: width*0.5,
//                                         //  color: PdfColors.amber,
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.end,
//                                        children: [
//                                          Text(
//                                                        'BUSON DIGITAL SERVICE INDIA PVT LTD',
//                                                        textAlign: TextAlign.right,
//                                                        style: TextStyle(
//                                                         font: Calibrifont,
//                                                          fontWeight: FontWeight.bold,
//                                                          fontSize: 12,
//                                                           color: PdfColor.fromHex("#750537")
//                                                        ),
//                                                      ),
//                                                      Container(
//                                                       alignment: Alignment.centerRight,
//                                                      width: PdfPageFormat.cm*0.5,
//                                                      child:  Text(
//                                                        ' 206/3, 2nd Floor, Devarajan Center, Sathyamurthy Rd, Peranaidu Layout, Ram Nagar, Coimbatore, Tamil Nadu 641009',
//                                                        textAlign: TextAlign.right,
//                                                        maxLines: 3,
//                                                        style: TextStyle(
//                                                         font: Calibrifont,
//                                                         //  fontWeight: FontWeight.bold,
//                                                          fontSize: 12,

//                                                        ),
//                                                      ),
//                                                      ),

//                                                        ]
//                                         ),
//                                       ),
//                                      ]),

//                                       SizedBox(height: 1 * PdfPageFormat.cm),

//                                       Container(
//                                           // padding: EdgeInsets.all(height * 0.01),
//                                           width: double.infinity,
//                                           alignment: Alignment.center,
//                                           decoration: BoxDecoration(
//                                               // color: PdfColor.fromHex("#FF6347"),
//                                               // border: Border.all()
//                                               ),
//                                           child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.spaceBetween,
//                                               children: [

//                                                 SizedBox(height: 0.02 * PdfPageFormat.cm),
//                                                 Row(
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.spaceBetween,
//                                                     children: [
//                                                       Container(
//                                                         child:  Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment.start,
//                                                           children: [
//                                                             Text(
//                                                               'TO:',
//                                                               style: TextStyle(
//                                                                 font: Calibrifont,
//                                                                 fontWeight: FontWeight.bold,
//                                                                 fontSize: 12,
//                                                                color: PdfColor.fromHex("#750537")
//                                                               ),
//                                                             ),
//                                                             Text(
//                                                               '  ${orderMasterdata![0].CardName}',
//                                                               style: TextStyle(
//                                                                 font: Calibrifont,
//                                                                 fontWeight: FontWeight.bold,
//                                                                 fontSize: 12,
//                                                               ),
//                                                             ),
//                                                               Container(
//                                                                 width: PdfPageFormat.cm * 0.5,
//                                                                 // color: PdfColors.amber,
//                                                                 alignment:
//                                                                     Alignment.centerLeft,
//                                                                 child: Text(

//                                                                   '  ${orderMasterdata![0].bil_Address1},${orderMasterdata![0].bil_Address2}',
//                                                                   textAlign: TextAlign.left,
//                                                                   maxLines: 10,
//                                                                   style: TextStyle(
//                                                                     font: Calibrifont,
//                                                                     // fontWeight:FontWeight.bold,
//                                                                     fontSize: 12,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               // Container(
//                                                               //   width: width * 0.5,
//                                                               //   // color: PdfColors.amber,
//                                                               //   alignment:
//                                                               //       Alignment.centerLeft,
//                                                               //   child: Text(
//                                                               //     '',
//                                                               //     textAlign: TextAlign.left,
//                                                               //     maxLines: 10,
//                                                               //     style: TextStyle(
//                                                               //       // fontWeight:FontWeight.bold,
//                                                               //       fontSize: 15,
//                                                               //     ),
//                                                               //   ),
//                                                               // ),
//                                                               Container(
//                                                                 width: PdfPageFormat.cm * 0.5,
//                                                                 // color: PdfColors.amber,
//                                                                 alignment:
//                                                                     Alignment.centerLeft,
//                                                                 child: Text(
//                                                                   '  ${orderMasterdata![0].Bil_Area},${orderMasterdata![0].Bil_City}',
//                                                                   textAlign: TextAlign.left,
//                                                                   maxLines: 10,
//                                                                   style: TextStyle(
//                                                                     font: Calibrifont,
//                                                                     // fontWeight:FontWeight.bold,
//                                                                     fontSize: 12,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               // Container(
//                                                               //   width: width * 0.5,
//                                                               //   // color: PdfColors.amber,
//                                                               //   alignment:
//                                                               //       Alignment.centerLeft,
//                                                               //   child: Text(
//                                                               //     '',
//                                                               //     textAlign: TextAlign.left,
//                                                               //     maxLines: 10,
//                                                               //     style: TextStyle(
//                                                               //       // fontWeight:FontWeight.bold,
//                                                               //       fontSize: 15,
//                                                               //     ),
//                                                               //   ),
//                                                               // ),
//                                                               Container(
//                                                                 width: PdfPageFormat.cm * 0.5,
//                                                                 // color: PdfColors.amber,
//                                                                 alignment:
//                                                                     Alignment.centerLeft,
//                                                                 child: Text(
//                                                                   '  ${orderMasterdata![0].Bil_State},${orderMasterdata![0].Bil_Pincode}',
//                                                                   textAlign: TextAlign.left,
//                                                                   maxLines: 10,
//                                                                   style: TextStyle(
//                                                                     font: Calibrifont,
//                                                                     // fontWeight:FontWeight.bold,
//                                                                     fontSize: 12,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               Container(
//                                                                 width: PdfPageFormat.cm * 0.5,
//                                                                 // color: PdfColors.amber,
//                                                                 alignment:
//                                                                     Alignment.centerLeft,
//                                                                 child: Text(
//                                                                   '  GSTIN:',
//                                                                   textAlign: TextAlign.left,
//                                                                   maxLines: 10,
//                                                                   style: TextStyle(
//                                                                     font: Calibrifont,
//                                                                     // fontWeight:FontWeight.bold,
//                                                                     fontSize: 12,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                           ]),

//                                                       ),
//                                                    Container  (
//                                                     width: PdfPageFormat.cm*0.5,
//                                                     // color: PdfColors.amber,
//                                                     child:Column(
//                                                       children: [
//                                                          Row(children: [
//                   Container(
//                                                              alignment: Alignment.centerLeft,
// child:  Text(
//                                                           'Order No ',
//                                                           textAlign: TextAlign.right,
//                                                           style: TextStyle(
//                                                             font: Calibrifont,
//                                                             fontWeight: FontWeight.bold,
//                                                             fontSize: 12,
//                                                             //  color: PdfColor.fromHex("#750537")
//                                                           ),
//                                                         ),
//                                                           ),
//                                                         Container(
//                                                             //  alignment: Alignment.centerLeft,
// child:  Text(
//                                                           '#${orderMasterdata![0].DocNo}',
//                                                           textAlign: TextAlign.right,
//                                                           style: TextStyle(
//                                                             font: Calibrifont,
//                                                             // fontWeight: FontWeight.bold,
//                                                             fontSize: 12,
//                                                             //  color: PdfColor.fromHex("#750537")
//                                                           ),
//                                                         ),
//                                                           )
//                                                          ]),
//                                                         Row(children: [
// Container(
//                     alignment: Alignment.centerLeft,
//                    child: Text(
//                                                               'Order Dt:',
//                                                               style: TextStyle(
//                                                                 font: Calibrifont,
//                                                                 fontWeight: FontWeight.bold,
//                                                                 fontSize: 12,

//                                                               ),
//                                                             ),
// ),
// Container(
//                                                             alignment: Alignment.centerLeft,
//                                                             child: Text(
//                                                               ' ${config.alignDate(orderMasterdata![0].DocDate.toString())}',
//                                                               style: TextStyle(
//                                                                 font: Calibrifont,
//                                                                 // fontWeight: FontWeight.bold,
//                                                                 fontSize: 12,

//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ]),

//                                                       ]
//                                                     )
//                                                     )
//                                                     ]),
//                                                 //  SizedBox(height: 0.05 * PdfPageFormat.cm),

//                                                 // Text(
//                                                 //   '',
//                                                 //   style: TextStyle(
//                                                 //     fontWeight: FontWeight.bold,
//                                                 //     fontSize: 14,
//                                                 //   ),
//                                                 // ),
//                                                 SizedBox(height: 1 * PdfPageFormat.cm),

// Table.fromTextArray(
//                                                   headers: headers,
//                                                   data: data,
//                                                   border: null,
//                                                   cellStyle:  TextStyle(
//                                                     font: Calibrifont,
//                                                     fontSize: 12
//                                                   ),
//                                                   headerStyle: TextStyle(
//                                                     font: Calibrifont,
//                                                       fontWeight: FontWeight.bold
//                                                       ,
//                                                       color: PdfColors.white
//                                                       ),
//                                                   headerDecoration:
//                                                       BoxDecoration(

//                                                         color: PdfColor.fromHex("#750537")),
//                                                   cellHeight: 30,
//                                                   columnWidths: {
//                                                     0: FlexColumnWidth(PdfPageFormat.cm * 0.06),
//                                                     1: FlexColumnWidth(PdfPageFormat.cm * 0.2),
//                                                     2: FlexColumnWidth(PdfPageFormat.cm * 0.1),
//                                                      3: FlexColumnWidth(PdfPageFormat.cm * 0.1),
//                                                       4: FlexColumnWidth(PdfPageFormat.cm * 0.1),
//                                                        5: FlexColumnWidth(PdfPageFormat.cm * 0.1),
//                                                   },
//                                                   headerAlignments: {
//                                                     0: Alignment.centerLeft,
//                                                     1: Alignment.center,
//                                                     2: Alignment.centerRight,
//                                                     3: Alignment.centerRight,
//                                                     4:Alignment.centerRight,
//                                                     5:Alignment.centerRight,
//                                                   },
//                                                   cellAlignments: {
//                                                     0: Alignment.centerLeft,
//                                                     1: Alignment.centerLeft,
//                                                     2: Alignment.centerRight,
//                                                     3: Alignment.centerRight,
//                                                     4:Alignment.centerRight,
//                                                     5:Alignment.centerRight,
//                                                   },
//                                                 ),

//                                                 Divider(),
//                                               ])),
//                                               Container(
//                                           child: Row(children: [
//                                         Spacer(flex: 6),
//                                         Container(
//                                           width: PdfPageFormat.cm * 0.4,
//                                           // color: PdfColors.amber,
//                                           child: Row(
//                                             children: [
//                                               Expanded(
//                                                   child: Text("Sub Total",
//                                                       style: TextStyle(
//                                                         font: Calibrifont,
//                                                         fontWeight: FontWeight.bold,
//                                                         fontSize: 12,
//                                                       ))),
//                                               Text("${orderMasterdata![0].GrossTotal!.toStringAsFixed(2)}",
//                                                   style: TextStyle(
//                                                     font: Calibrifont,
//                                                     fontSize: 12,
//                                                   )),
//                                             ],
//                                           ),
//                                         ),
//                                       ])),
//                                       Container(
//                                           child: Row(children: [
//                                         Spacer(flex: 6),
//                                         Container(
//                                           width: PdfPageFormat.cm * 0.4,
//                                           child: Row(
//                                             children: [
//                                               Expanded(
//                                                   child: Text("Tax",
//                                                       style: TextStyle(
//                                                         font: Calibrifont,
//                                                         fontWeight: FontWeight.bold,
//                                                         fontSize: 12,
//                                                       ))),
//                                               Text("${orderMasterdata![0].TaxAmount!.toStringAsFixed(2)}",
//                                                   style: TextStyle(
//                                                     font: Calibrifont,
//                                                     fontSize: 12,
//                                                   )),
//                                             ],
//                                           ),
//                                         ),
//                                       ])),
//                                       Container(
//                                           child: Row(children: [
//                                         Spacer(flex: 6),
//                                         Container(
//                                           width: PdfPageFormat.cm * 0.4,
//                                           child: Row(
//                                             children: [
//                                               Expanded(
//                                                   child: Text("Round off",
//                                                       style: TextStyle(
//                                                         font: Calibrifont,
//                                                         fontWeight: FontWeight.bold,
//                                                         fontSize: 12,
//                                                       ))),
//                                               Text("${orderMasterdata![0].roundoff!.toStringAsFixed(2)}",
//                                                   style: TextStyle(
//                                                     font: Calibrifont,
//                                                     fontSize: 12,
//                                                   )),
//                                             ],
//                                           ),
//                                         ),
//                                       ])),

//                                       Container(
//                                           child: Row(children: [
//                                         Spacer(flex: 6),
//                                         Container(
//                                           width: PdfPageFormat.cm * 0.4,
//                                           child: Row(
//                                             children: [
//                                               Expanded(
//                                                   child: Text("Total",
//                                                       style: TextStyle(
//                                                          fontWeight: FontWeight.bold,
//                                                         font: Calibrifont,

//                                                         fontSize: 12,
//                                                       ))),
//                                               Text("${orderMasterdata![0].DocTotal!.toStringAsFixed(2)}",
//                                                   style: TextStyle(
//                                                     font: Calibrifont,
//                                                     fontSize: 12,
//                                                   )),
//                                             ],
//                                           ),
//                                         ),
//                                       ])),
//                                       // Container(
//                                       //     child: Row(
//                                       //   children: [
//                                       //     Spacer(flex: 6),

//                                       //   ],
//                                       // )),

//                                       // SizedBox(height: 20),
//                                       // Flexible(child: FlutterLogo())
//                                     ],
//                                      )

//                               )
//                             ])

//                            )

//          ]

//           ),
//     );

//     return saveDocument(name: 'my_invoice.pdf', pdf: pdf);
//   }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);
// Uint8List uint8list = await file.readAsBytes();
    return file;
  }
}
