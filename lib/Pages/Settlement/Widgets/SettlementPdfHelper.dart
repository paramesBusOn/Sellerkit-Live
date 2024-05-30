import 'dart:io';
import 'dart:typed_data';
import 'package:open_file/open_file.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/customerdetApi/customerdetApi.dart';

class SettlementPdfHelper {
  static customerdetData? frmAddressmodeldata;
  static String? setDocfNum;
  static String? settlePayMode;
  static double? totalSumOfAp;
  static String? settledTo;
  static String? settledRef;
  static String? assignedTo;
  static String? settleDateTime;

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
    final pdf = Document(
      pageMode: PdfPageMode.none,
    );

    pdf.addPage(MultiPage(
      maxPages: 100,
      pageFormat: PdfPageFormat.a4.copyWith(
        marginBottom: 0,
        marginLeft: 0,
        marginRight: PdfPageFormat.a4.width * 0.07,
        marginTop: PdfPageFormat.a4.height * 0.0,
        width: PdfPageFormat.a4.width,
        height: PdfPageFormat.a4.height,
      ),
      header: (context) {
        return buildHeader(font, Calibrifont, config, Calibrifontbold);
      },
      build: (context) => [
        createLineTable(font, Calibrifont, config, Calibrifontbold),
        buildcontainer(font, Calibrifont, config, Calibrifontbold)
      ],
      footer: (context) => buildFooter(context, config, Calibrifont),
    ));

    return pdf.save();
  }

  static pw.Widget buildHeader(TtfFont font, TtfFont Calibrifont, Config config,
          TtfFont Calibrifontbold) =>
      Container(
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(
                      color: PdfColor.fromHex("#750537"),
                      width: PdfPageFormat.a4.width * 0.07))),
          child: Padding(
              padding: EdgeInsets.only(
                left: PdfPageFormat.a4.width * 0.07,
                top: PdfPageFormat.a4.height * 0.05,
              ),
              child: Column(children: [
                pw.SizedBox(height: 2 * PdfPageFormat.cm),
                Container(
                    // color: PdfColors.amber,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                frmAddressmodeldata == null ||
                                        frmAddressmodeldata!.cardName == null ||
                                        frmAddressmodeldata!.cardName == 'null'
                                    ? ''
                                    : '${frmAddressmodeldata!.cardName}',
                                style: TextStyle(
                                    font: Calibrifontbold,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: PdfColor.fromHex("#750537")),
                              ),
                              Container(
                                width: PdfPageFormat.a4.width * 0.5,
                                child: Text(
                                  '${frmAddressmodeldata == null || frmAddressmodeldata!.address1 == null || frmAddressmodeldata!.address1 == 'null' ? '' : frmAddressmodeldata!.address1}, ${frmAddressmodeldata == null || frmAddressmodeldata!.address2 == null || frmAddressmodeldata!.address2 == 'null' ? '' : frmAddressmodeldata!.address2}',
                                  maxLines: 3,
                                  style: TextStyle(
                                    font: Calibrifont,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Container(
                                width: PdfPageFormat.a4.width * 0.5,
                                child: Text(
                                  '${frmAddressmodeldata == null || frmAddressmodeldata!.city == null || frmAddressmodeldata!.city == 'null' ? '' : frmAddressmodeldata!.city}, ${frmAddressmodeldata == null || frmAddressmodeldata!.state == null || frmAddressmodeldata!.state == 'null' ? '' : frmAddressmodeldata!.state}-${frmAddressmodeldata == null || frmAddressmodeldata!.pincode == null || frmAddressmodeldata!.pincode == 'null' ? '' : frmAddressmodeldata!.pincode}',
                                  maxLines: 3,
                                  style: TextStyle(
                                    font: Calibrifont,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                              Container(
                                // color: PdfColors.lightBlue,
                                child: Text(
                                  frmAddressmodeldata == null ||
                                          frmAddressmodeldata!.gstin == null ||
                                          frmAddressmodeldata!.gstin == 'null'
                                      ? ''
                                      : '${frmAddressmodeldata!.gstin}',
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
                      Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Container(
                                // color: PdfColors.red,
                                // width: PdfPageFormat.a4.width * 0.5,
                                child: Text(
                              'Settlement',
                              style: TextStyle(
                                  font: Calibrifontbold,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: PdfColor.fromHex("#750537")),
                            )),
                            Container(
                              width: PdfPageFormat.a4.width * 0.13,
                              child: Text(
                                setDocfNum.toString(),
                                style: TextStyle(
                                  font: Calibrifont,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Container(
                              // width: PdfPageFormat.a4.width * 0.13,
                              child: Text(
                                settleDateTime.toString(),
                                style: TextStyle(
                                  font: Calibrifont,
                                  fontSize: 10,
                                ),
                              ),
                            )
                          ]))
                    ])),
                Container(),
                Container()
              ])));

  static Widget createLineTable(TtfFont font, TtfFont Calibrifont,
      Config config, TtfFont Calibrifontbold) {
    return Container(
      padding: EdgeInsets.only(
        left: PdfPageFormat.a4.width * 0.07,
      ),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: PdfColor.fromHex("#750537"),
                  width: PdfPageFormat.a4.width * 0.07))),
      child: Column(children: [
        pw.SizedBox(height: 2 * PdfPageFormat.cm),
        createTable(font, Calibrifont, config, Calibrifontbold),
        // Divider(),
        SizedBox(height: 6 * PdfPageFormat.mm),
      ]),
    );
  }

  static Widget createTable(TtfFont font, TtfFont Calibrifont, Config config,
      TtfFont Calibrifontbold) {
    List<TableRow> rows = [];
    rows.add(
      TableRow(children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          alignment: Alignment.centerLeft,
          child: Text(
            "User",
            style: TextStyle(
              font: Calibrifont,
              // fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
              assignedTo == null || assignedTo == 'null' || assignedTo!.isEmpty
                  ? ''
                  : assignedTo.toString(),
              textAlign: TextAlign.left,
              style: TextStyle(
                font: Calibrifont,
                fontSize: 10,
              )
              // textAlign: TextAlign.left,
              ),
        ),
      ]),
    );

    rows.add(
      TableRow(children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          alignment: Alignment.centerLeft,
          child: Text(
            "Amount to be Settled",
            style: TextStyle(
              font: Calibrifont,
              // fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            config.slpitCurrency22(totalSumOfAp!.toStringAsFixed(2)),
            style: TextStyle(
              font: Calibrifont,
              // fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
            // textAlign: TextAlign.left,
          ),
        ),
      ]),
    );
    rows.add(TableRow(children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        alignment: Alignment.centerLeft,
        child: Text(
          "Settlement Type",
          style: TextStyle(
            font: Calibrifont,
            // fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Text(
          settlePayMode!,
          style: TextStyle(
            font: Calibrifont,
            // fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          // textAlign: TextAlign.left,
        ),
      ),
    ]));
    rows.add(
      TableRow(children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            "Settlement Date Time",
            style: TextStyle(
              font: Calibrifont,
              // fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            settleDateTime.toString(),
            style: TextStyle(
              font: Calibrifont,
              // fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
            // textAlign: TextAlign.left,
          ),
        ),
      ]),
    );

    rows.add(
      TableRow(children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            "Settled To",
            style: TextStyle(
              font: Calibrifont,
              // fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            settledTo.toString(),
            style: TextStyle(
              font: Calibrifont,
              // fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
            // textAlign: TextAlign.left,
          ),
        ),
      ]),
    );
    rows.add(
      TableRow(children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          alignment: Alignment.centerLeft,
          child: Text(
            "Settlement Reference",
            style: TextStyle(
              font: Calibrifont,
              // fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Text(
            settledRef!,
            style: TextStyle(
              font: Calibrifont,
              // fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
            // textAlign: TextAlign.left,
          ),
        ),
      ]),
    );

    return Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        border: TableBorder.all(width: 0.5),
        columnWidths: {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(2),
          // 2: FlexColumnWidth(2),
          // 3: FlexColumnWidth(2),
          // 4: FlexColumnWidth(2.3),
          // 5: FlexColumnWidth(2.3),
        },
        children: rows);
  }

  static Widget buildcontainer(TtfFont font, TtfFont Calibrifont, Config config,
          TtfFont Calibrifontbold) =>
      Expanded(
          child: Container(
              padding: EdgeInsets.only(
                top: PdfPageFormat.a4.height * 0.06,
                left: PdfPageFormat.a4.width * 0.08,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: PdfColor.fromHex("#750537"),
                          width: PdfPageFormat.a4.width * 0.07))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Prepared By",
                            style: TextStyle(
                              font: Calibrifont,
                              // fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            assignedTo!,
                            style: TextStyle(
                              font: Calibrifont,
                              // fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(height: 0.5 * PdfPageFormat.cm),
                          Text(
                            "------------------------",
                            style: TextStyle(
                              font: Calibrifont,
                              // fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          )
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Acknowledged By",
                            style: TextStyle(
                              font: Calibrifont,
                              // fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(height: 0.5 * PdfPageFormat.cm),
                          Text(
                            "------------------------",
                            style: TextStyle(
                              font: Calibrifont,
                              // fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          )
                        ]),
                  ])));

  static Widget buildFooter(context, Config config, TtfFont font) => Container(
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: PdfColor.fromHex("#750537"),
                  width: PdfPageFormat.a4.width * 0.07))),
      child: Padding(
          padding: EdgeInsets.only(left: PdfPageFormat.a4.width * 0.07),
          child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Page ${context.pageNumber} of ${context.pagesCount}",
                          style: TextStyle(font: font, fontSize: 10),
                          textAlign: TextAlign.start),
                      Container(
                        // width: PdfPageFormat.a4.width*0.7,
                        child: Text(
                            assignedTo == null ||
                                    assignedTo == 'null' ||
                                    assignedTo!.isEmpty
                                ? ''
                                : assignedTo.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(font: font, fontSize: 7)),
                      ),
                      Container(
                        // width: PdfPageFormat.a4.width*0.7,
                        child: Text(
                            'This is a System Generated Document. Signature not Required',
                            textAlign: TextAlign.center,
                            style: TextStyle(font: font, fontSize: 7)),
                      ),
                      Text(config.currentDatepdf(),
                          textAlign: TextAlign.end,
                          style: TextStyle(font: font, fontSize: 7)),
                    ]),

                SizedBox(height: 1.5 * PdfPageFormat.mm),
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
}
