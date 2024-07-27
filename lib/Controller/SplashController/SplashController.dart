import 'dart:developer';
import 'dart:io';

//import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sellerkit/Constant/Configuration.dart';

import '../../Constant/ConstantRoutes.dart';
import '../../Constant/Helper.dart';
import '../../Services/URL/LocalUrl.dart';

class SplashController extends ChangeNotifier
{
  Config config = new Config();
    becameAClient(BuildContext context) {
    config.msgDialog(context,
        "Please contact our support team..!!", "support@buson.in");
  }

  loginClicked()
  {
    Get.offAllNamed(ConstantRoutes.login);
  }

       setURL() async {
    String? getUrl = await HelperFunctions.getHostDSP();
    log("getUrl $getUrl");
  Url.queryApi = '${getUrl.toString()}/api/';
  }

//  Future<String?> initPlatformState() async {
//     String? deviceId;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       if (Platform.isAndroid) {
//         deviceId =  await PlatformDeviceId.getDeviceId;
//       } else if (Platform.isIOS) {
//         deviceId =  await PlatformDeviceId.getDeviceId;
//       }
     
//     } on PlatformException {
//       deviceId = 'Failed to get deviceId.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//    return deviceId;
//   }
}