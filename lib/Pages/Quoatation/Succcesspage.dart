// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/Screen.dart';
import 'package:sellerkit/Controller/QuotationController/newquotecontroller.dart';
import 'package:sellerkit/Models/QuoteModel/quotemodel.dart';
import 'package:sellerkit/Pages/OrderBooking/Widgets/Pdf.dart';
import 'package:sellerkit/Pages/OrderBooking/Widgets/pdfinv.dart';
import 'package:sellerkit/Pages/Quoatation/tabquote/widgets/pdfqoute.dart';
import '../../../Constant/ConstantRoutes.dart';
import '../../../Widgets/Appbar.dart';
import '../../../Widgets/Navi3.dart';

class QuotesSuccessPage extends StatefulWidget {
  QuotesSuccessPage({Key? key}) : super(key: key);

  @override
  State<QuotesSuccessPage> createState() => QuotesSuccessPageState();
}

class QuotesSuccessPageState extends State<QuotesSuccessPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   print("data doccc: "+ context.read<NewquoteController>().getsuccessRes.DocNo.toString());
    });
  }

  static QuoteSavePostModal? getsuccessRes;
  static String paymode = '';
  DateTime? currentBackPressTime;
  Config config = new Config();
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      print("object");
      Get.offAllNamed(ConstantRoutes.quotespage);
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
          appBar: appbar("New Quotes", scaffoldKey, theme, context),
          drawer: drawer3(context),
          body: Container(
            width: Screens.width(context),
            height: Screens.bodyheight(context),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("Assets/newleadsucess.png"),
                    fit: BoxFit.cover)),
            child: getsuccessRes == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
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
                                  "Quotation Created Successfully",
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
                                  "Quotes Entry #${getsuccessRes!.orderSavePostheader!.orderMasterdata![0].DocNo.toString()}",
                                  style: theme.textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                )),
                              ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.003,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.8,
                                //   color: Colors.blue,
                                child: Center(
                                    child: Text(
                                  "${getsuccessRes!.orderSavePostheader!.orderMasterdata![0].CardName}",
                                  style: theme.textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                )),
                              ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.003,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.8,
                                //   color: Colors.blue,
                                child: Center(
                                    child: Text(
                                  "${getsuccessRes!.orderSavePostheader!.orderMasterdata![0].CardCode}",
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
                              //       child: Text(
                              //     "${getsuccessRes!.U_sk_email}",
                              //     style: theme.textTheme.bodyText2,
                              //     textAlign: TextAlign.center,
                              //   )),
                              // ),
                              // SizedBox(
                              //   height: Screens.bodyheight(context) * 0.1,
                              // ),
                              Container(
                                  alignment: Alignment.center,
                                  width: Screens.width(context) * 0.8,
                                  height: Screens.padingHeight(context)*0.15,
                                  // color: Colors.blue, 
                                  child: 
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Wrap(
                                            spacing: 10.0, // width
                                            runSpacing: 8.0, // height
                                            children: listText(theme,
                                                getsuccessRes!.orderSavePostheader!.documentdata!)),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.03,
                              ),
                              // Container(
                              //   alignment: Alignment.center,
                              //   width: Screens.width(context) * 0.8,
                                
                              //   //   color: Colors.blue,
                              //   child: Center(
                              //       child: Text(
                              //     "Delivery Date " +
                              //         config
                              //             .aligndateorder(
                              //                 getsuccessRes!.orderSavePostheader!.orderMasterdata![0].U_sk_NextFollowDt!)
                                          
                              //   ,  style: theme.textTheme.bodyText2,
                              //     textAlign: TextAlign.center,
                              //   )),
                              // ),
                              // SizedBox(
                              //   height: Screens.bodyheight(context) * 0.01,
                              // ),
                             
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Container(),
                                  // Row(
                                  //   children: [
                                  //     Text("Set Reminder: "),
                                  //     FlutterSwitch(
                                  //         showOnOff: true,
                                  //         width: 60,
                                  //           height: 25,
                                  //           activeText: "On",
                                  //           inactiveText: "Off",
                                  //           activeColor: theme.primaryColor,
                                  //         value: context
                                  //             .watch<NewquoteController>()
                                  //             .reminderOn,
                                  //         onToggle: (val) {
                                  //           // context.read<LeadNewController>().switchremainder(val);
                                  //           //  print(val);
                                  //           // setState(() {
                                  //           //   switched = val;
                                  //           //   reqfinance = "Y";
                                  //           // });
                                  //           context
                                  //               .read<NewquoteController>()
                                  //               .setReminderOnMethod(val,"Remainder on Order  for ${getsuccessRes!.orderSavePostheader!.orderMasterdata![0].CardName}");
                                  //         }),
                                  //   ],
                                  // ),
                                  
                                  // Container(
                                  //   child: Row(
                                  //     children: [
                                  //       Text("Set Remainder For Delivery: "),
                                  //       FlutterSwitch(
                                  //           showOnOff: true,
                                  //           width: 60,
                                  //           height: 25,
                                  //           activeText: "On",
                                  //           inactiveText: "Off",
                                  //           activeColor: theme.primaryColor,
                                  //           value: context
                                  //               .watch<NewquoteController>()
                                  //               .remswitch,
                                  //           onToggle: (val) {
                                  //             context
                                  //                 .read<NewquoteController>()
                                  //                 .switchremainder(val);
                                  //             //  print(val);
                                  //             // setState(() {
                                  //             //   switched = val;
                                  //             //   reqfinance = "Y";
                                  //             // });
                                  //           })
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: Screens.bodyheight(context) * 0.01,
                              ),
                               InkWell(
                                onTap: ()async{
                                  //  final pdfFile = await PdfInvoicePdfHelper.generatePdf();
                                  pdfqoutesState.data=getsuccessRes!.orderSavePostheader!.documentdata!;
                                pdfqoutesState. orderMasterdata2=getsuccessRes!.orderSavePostheader!.orderMasterdata;
                               pdfqoutesState.paymode=paymode;
                                pdfqoutesState.customermodeldata=context
                                                .read<NewquoteController>()
                                                .customermodeldata;
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>pdfqoutes()));
                              //  PdfInvoicePdfHelper.openFile(pdfFile);
                                },
                                 child: Text(
                                  
                                  "Convert as Pdf",
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.blue
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
                                    Get.offAllNamed(ConstantRoutes.quotespage);
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
