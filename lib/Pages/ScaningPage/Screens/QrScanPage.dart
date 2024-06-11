import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sellerkit/Pages/ScaningPage/Screens/ItemDetailsPage.dart';

import 'ScreenShot.dart';

class QRCamera extends StatefulWidget {
  const QRCamera({Key? key}) : super(key: key);

  @override
  State<QRCamera> createState() => QRCameraState();
}

class QRCameraState extends State<QRCamera> {
  static bool qrscanned = false;
    MobileScannerController cameraController = MobileScannerController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mobile Scanner'),
          actions: [
            // IconButton(
            //   color: Colors.white,
            //   icon: ValueListenableBuilder(
            //     valueListenable: cameraController.torchState,
            //     builder: (context, state, child) {
            //       switch (state as TorchState) {
            //         case TorchState.off:
            //           return const Icon(Icons.flash_off, color: Colors.grey);
            //         case TorchState.on:
            //           return const Icon(Icons.flash_on, color: Colors.yellow);
            //       }
            //     },
            //   ),
            //   iconSize: 32.0,
            //   onPressed: () => cameraController.toggleTorch(),
            // ),
            // IconButton(
            //   color: Colors.white,
            //   icon: ValueListenableBuilder(
            //     valueListenable: cameraController.cameraFacingState,
            //     builder: (context, state, child) {
            //       switch (state as CameraFacing) {
            //         case CameraFacing.front:
            //           return const Icon(Icons.camera_front);
            //         case CameraFacing.back:
            //           return const Icon(Icons.camera_rear);
            //       }
            //     },
            //   ),
            //   iconSize: 32.0,
            //   onPressed: () => cameraController.switchCamera(),
            // ),
          ],
        ),
        body: MobileScanner(
          //  allowDuplicates: false,
            controller: cameraController,
            // onDetect: (barcode) {
            //     print('Failed to scan Barcode111111111');
            //   if (barcode.raw == null) {
            //     debugPrint('Failed to scan Barcode');
            //   } else {
            //     final String code = barcode.raw.toString();
            //       if (qrscanned == true) {
            //       log("outwardMain");
            //       outwardScan(code);
            //   }
            // }}
             onDetect: (capture) {
              cameraController.stop();
          final List<Barcode> barcodes = capture.barcodes;
        //  final Uint8List? image = capture.image;
          for (final barcode in barcodes) {
            // log('Barcode found! ${barcode.rawValue}');
             outwardScan(barcode.rawValue??'');
          }
        },
            ));
  }

  outwardScan(String code) {
    if(code.isNotEmpty){
   log("message $code");
    ScanningPageState.scannedData = code;
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDetailsPage()));
    // Navigator.pop(context);
    
    qrscanned = false;
    }
 
  }
}
