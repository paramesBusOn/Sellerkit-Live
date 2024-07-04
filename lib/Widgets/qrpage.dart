import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:sellerkit/Constant/ConstantRoutes.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Controller/LeadController/LeadNewController.dart';
import 'package:sellerkit/Controller/OrderController/OrderNewController.dart';
import 'package:sellerkit/Controller/PriceListController/PriceListController.dart';
import 'package:sellerkit/Controller/QuotationController/newquotecontroller.dart';
import 'package:sellerkit/Controller/StockAvailabilityController/StockListController.dart';
import 'package:sellerkit/Controller/specialpricecontroller/newpagecontroller.dart';

class qrscanner extends StatefulWidget {
   qrscanner({Key? key}) : super(key: key);

  @override
  State<qrscanner> createState() => qrscannerState();
}

class qrscannerState extends State<qrscanner> {
  static bool orderscan=false;
  static bool leadscan=false;
  static bool quotescan=false;
  static bool stockscan=false;
  static bool pricelistscan=false;
  static bool spreqscan=false;
 
  
    
  MobileScannerController cameraController =MobileScannerController(detectionSpeed :DetectionSpeed.noDuplicates);
  OrderNewController? orderNewController;
  List<Barcode> barcodes=[];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      barcodes.clear(); 

    });
   log("barcodes:::"+barcodes.toString());
    
  }
  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.back();
      return Future.value(true);
    } else {
      return Future.value(true);
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onbackpress,
      child: Scaffold(
        appBar: AppBar(
          // leading: GestureDetector(
          //   onTap: (){
          //     Get.back();
          //   },
          //   child: Icon(Icons.arrow_back,color: Colors.amber,)),
          title:Text("Mobile Scanner"), 
          ),
          body: GestureDetector(
            onHorizontalDragUpdate: (details) {
                  // Check if the user is swiping from left to right
                  print(details.primaryDelta);
                  if (details.primaryDelta! > ConstantValues.slidevalue!) {
                    setState(() {
                      Navigator.pop(context);
                      // Get.offAllNamed(ConstantRoutes.ordertab);
                    });
                  }
                },
            child: MobileScanner(
              controller: cameraController,
             onDetect: (capture){
                 barcodes=capture.barcodes;
                for(var barcode in barcodes){
                  if(orderscan ==true){
                
                context.read<OrderNewController>().Scancode=barcode.rawValue ??'';
                Navigator.pop(context);
                orderscan=false;
                context.read<OrderNewController>().scanneddataget(context);
                  }else if(leadscan ==true){
                  
                context.read<LeadNewController>().Scancode=barcode.rawValue ??'';
                Navigator.pop(context);
                leadscan=false;
                context.read<LeadNewController>().scanneddataget(context);
                  }else if(quotescan ==true){
                  
                context.read<NewquoteController>().Scancode=barcode.rawValue ??'';
                Navigator.pop(context);
                quotescan =false;
                context.read<NewquoteController>().scanneddataget(context);
                  }else if(stockscan ==true){
                  
                context.read<StockListController>().Scancode=barcode.rawValue ??'';
                Navigator.pop(context);
                stockscan =false;
                context.read<StockListController>().scanneddataget(context);
                  }
                  else if(pricelistscan ==true){
                  
                context.read<PriceListController>().Scancode=barcode.rawValue ??'';
                Navigator.pop(context);
                pricelistscan =false;
                context.read<PriceListController>().scanneddataget(context);
                  }
                  else if(spreqscan ==true){
                  
                context.read<NewpriceController>().Scancode=barcode.rawValue ??'';
                Navigator.pop(context);
                spreqscan =false;
                context.read<NewpriceController>().scanneddataget(context);
                  }
                // context.read<OrderNewController>().scanneddataget(barcode.rawValue ??'',context);
                }
                
             }, 
            ),
          ),
    
      ),
    );
  }
}