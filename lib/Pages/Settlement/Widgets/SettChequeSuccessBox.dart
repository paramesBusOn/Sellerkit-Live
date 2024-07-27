// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_string_interpolations

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/SettlementPdf.dart';
import 'package:sellerkit/Pages/Settlement/Widgets/SettlementPdfHelper.dart';
import '../../../Constant/ConstantRoutes.dart';
import '../../../Controller/CollectionController/NewCollectionEntryCotroller.dart';
import '../../../Controller/SettlementController/SettlementController.dart';
import '../../../Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/OrderCheckListPost.dart';
import '../../../Models/SettlementModel/SettlementPostModel.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class SettlementSuccessCheque extends StatefulWidget {
  SettlementSuccessCheque({Key? key,required this.settlemaster})
      : super(key: key);
  // final String? paymode;
  // final double? amount;
  SettlementPostData? settlemaster;
  @override
  State<SettlementSuccessCheque> createState() => SettlementSuccessChequeState();
}

class SettlementSuccessChequeState extends State<SettlementSuccessCheque> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   print("data doccc: "+ context.read<LeadNewController>().getsuccessRes.DocNo.toString());
    });
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("object");
      Get.offAllNamed(ConstantRoutes.newcustomerReg);
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
          // backgroundColor: Colors.grey[200],
          /// resizeToAvoidBottomInset: true,
          key: scaffoldKey,
          appBar: appbar("New Settlement", scaffoldKey,theme, context),
          drawer: drawer3(context),
          body: Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("Assets/newleadsucess.png"),
                    fit: BoxFit.cover)),
            child: Stack(
              children: [
                Positioned(
                  top: Screens.bodyheight(context) * 0.3,
                  child: Container(
                    alignment: Alignment.center,
                    width: Screens.width(context),
                    height: Screens.bodyheight(context) * 0.6,
                    //color: Colors.red,
                    padding: EdgeInsets.only(
                      left: Screens.width(context) * 0.1,
                      right: Screens.width(context) * 0.1,
                      // top: Screens.bodyheight(context)*0.02,
                      // bottom: Screens.bodyheight(context)*0.02
                    ),

                    // margin: EdgeInsets.symmetric(
                    //   horizontal:  Screens.width(context)*0.1,
                    //   // left: Screens.width(context)*0.1,
                    //   // right: Screens.width(context)*0.1,
                    //     ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: Screens.width(context) * 0.8,
                          //   color: Colors.blue,
                          child: Center(
                              child: Text(
                            "Settlement Created Successfully",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyText2
                                ?.copyWith(color: Colors.grey),
                          )),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.02,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: Screens.width(context) * 0.8,
                          //   color: Colors.blue,
                          child: Center(
                              child: Text(
                            "Settlement Receipt #${widget.settlemaster!.DocNum}",
                            style: theme.textTheme.bodyText2,
                            textAlign: TextAlign.center,
                          )),
                        ),
                        // SizedBox(
                        //   height: Screens.bodyheight(context) * 0.003,
                        // ),
                        // Container(
                        //   alignment: Alignment.center,
                        //   width: Screens.width(context) * 0.8,
                        //   //   color: Colors.blue,
                        //   child: Center(
                        //       child: Text(
                        //     "${context.read<NewCollectionContoller>().mycontroller[1].text.toString()}",
                        //     style: theme.textTheme.bodyText2,
                        //     textAlign: TextAlign.center,
                        //   )),
                        // ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.003,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: Screens.width(context) * 0.8,
                          //   color: Colors.blue,
                          child: Center(
                              child: Text(
                            "Cheque Amount Rs.${widget.settlemaster!.Amount.toStringAsFixed(2)}",
                            style: theme.textTheme.bodyText2,
                            textAlign: TextAlign.center,
                          )),
                        ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.003,
                        ),
                        // Container(
                        //   alignment: Alignment.center,
                        //   width: Screens.width(context) * 0.8,
                        //   //   color: Colors.blue,
                        //   child: Center(
                        //       child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       InkWell(
                        //         onTap: () async {
                        //           // final pdfFile =
                        //           //     await PdfInvoiceApi.generate(context.read<NewCollectionContoller>().invoice!);

                        //           // PdfApi.openFile(
                        //           //     pdfFile);
                        //           //  File file = new File.fromUri(Uri.parse(pdfFile.toString()));

                        //           // PDFDocument doc =
                        //           //     await PDFDocument.fromFile(pdfFile);
                        //           // ShowPdfs.document = doc;
                        //           // context
                        //           //     .read<NewCollectionContoller>()
                        //           //     .pdfMethod();
                        //           reporttState.dasa=context.read<NewCollectionContoller>().invoice;
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (_) => reportt()));
                        //         },
                        //         child: Text(
                        //           "Print Receipt ",
                        //           style: theme.textTheme.bodyText2!.copyWith(
                        //               decoration: TextDecoration.underline),
                        //           textAlign: TextAlign.center,
                        //         ),
                        //       ),
                        //       // IconButton(
                        //       //     onPressed: () async {
                        //       //       // direc: /data/user/0/com.buson.crm/cache
                        //       //       // final tempDir =
                        //       //       //     await getTemporaryDirectory();
                        //       //       // print("direc: " +
                        //       //       //     tempDir.path.toString() +
                        //       //       //     '/$title-$docNO.pdf');
                        //       //       // paths.add(
                        //       //       //     '${tempDir.path}/$title-$docNO.pdf');
                        //       //       // await Share.shareFiles(paths);
                        //       //       // paths.clear();
                        //       //     },
                        //       //     icon: Icon(
                        //       //       Icons.share,
                        //       //       color: Colors.black,
                        //       //     ))
                        //     ],
                        //   )),
                        // ),

                        SizedBox(
                          height: Screens.bodyheight(context) * 0.1,
                        ),
                        //    Container(
                        //   alignment: Alignment.center,
                        //   width: Screens.width(context) * 0.8,
                        //    // color: Colors.blue,
                        //   child: Center(
                        //     child: Wrap(
                        //         spacing: 20.0, // width
                        //         runSpacing: 8.0, // height
                        //         children: listText(theme,
                        //          getsuccessRes!.documentdata!)),
                        //   )
                        // ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.03,
                        ),
                        //  Container(
                        //   alignment: Alignment.center,
                        //   width: Screens.width(context) * 0.8,
                        //   //   color: Colors.blue,
                        //   child: Center(
                        //       child: Text(
                        //     "Delivery Date "+config.alignDate(getsuccessRes!.U_sk_NextFollowDt!).toString(),
                        //     style: theme.textTheme.bodyText2,
                        //     textAlign: TextAlign.center,
                        //   )),
                        // ),
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(),
                            // Container(
                            //   child: Row(
                            //     children: [
                            //       Text("Set Remainder For Delivery: "),
                            //        FlutterSwitch(
                            //         showOnOff: true,
                            //         width: 60,
                            //         height: 25,
                            //         activeText: "On",
                            //         inactiveText: "Off",
                            //         activeColor: theme.primaryColor,
                            //         value: context.watch<LeadNewController>().remswitch,
                            //         onToggle: (val) {
                            //           context.read<LeadNewController>().switchremainder(val);
                            //           //  print(val);
                            //           // setState(() {
                            //           //   switched = val;
                            //           //   reqfinance = "Y";
                            //           // });
                            //         })
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                          SizedBox(
                          height: Screens.bodyheight(context) * 0.05,
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              SettlementPdfHelper.setDocfNum =
                                 widget.settlemaster!.DocNum.toString();

                              SettlementPdfHelper.frmAddressmodeldata = context
                                  .read<SettlementController>()
                                  .frmAddmodeldata;

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SettlementPdf()));
                            },
                            child: Text(
                              "Convert as Pdf",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue),
                            ),
                          ),
                        ),
                      
                        SizedBox(
                          height: Screens.bodyheight(context) * 0.05,
                        ),

                        Container(
                          width: Screens.width(context),
                          height: Screens.bodyheight(context) * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.offAllNamed(ConstantRoutes.settlement);
                            },
                            child: Text("Done"),
                            // style: Elev,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  List<Widget> listText(ThemeData theme, List<DocumentLines> data) {
    return List.generate(
      data.length,
      (index) => Container(
          width: Screens.width(context),
          child: Text(data[index].ItemDescription.toString(),
              textAlign: TextAlign.center, style: theme.textTheme.bodyText2)),
    );
  }
}
