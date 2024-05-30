// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Models/PostQueryModel/NotificationModel/NotificationModel.dart';
import 'package:sellerkit/main.dart';

class NotificationUpdateApi {
  static Future<NofificationModel> getData({int? docEntry,String? deliveryDT,String? readDT,String? deviceCode}) async {
    int resCode = 500;
    try {
      log("LLL::"+Url.queryApi + 'Sellerkit_Flexi/v2/UpdateNotification?JobId=$docEntry');
      await config.getSetup(); 
      final response = await http.put(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/UpdateNotification?JobId=$docEntry'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location": '${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
             "sendTime": null,
  "deliveryTime": "${deliveryDT}",
  "readTime": "${readDT}"
          }));
          log("json::"+jsonEncode({
             "sendTime": null,
  "deliveryTime": "${deliveryDT}",
  "readTime": "${readDT}"
          }));
      resCode = response.statusCode;
      //  print("responce: ${json.decode(response.body)}");
      // log(jsonEncode({
      //        "docEntry": docEntry,
      //        "deliveryDT": "$deliveryDT",
      //        "readDT": "$readDT",
      //        "readDeviceCode": "$deviceCode"
      //     }));
      //  log("ProfileAPI4Update: " + json.decode(response.body));
      if (response.statusCode == 200) {
        return NofificationModel.fromJson(json.decode(response.body), response.statusCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return NofificationModel.error("Error", resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return NofificationModel.error(e.toString(), resCode);
    }
  }
}


// // ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:sellerkit/Services/URL/LocalUrl.dart';
// import '../../../Models/PostQueryModel/NotificationModel/NotificationModel.dart';
// import 'package:sellerkit/main.dart';

// class NotificationUpdateApi {
//   static Future<NofificationModel> getData({int? docEntry,String? deliveryDT,String? readDT,String? deviceCode}) async {
//     int resCode = 500;
//     try {
//       await config.getSetup(); final response = await http.post(Uri.parse(Url.queryApi + 'SellerKit/UpdNotify'),
//           headers: {
//             "content-type": "application/json",
//           },
//           body: jsonEncode({
//              "docEntry": docEntry,
//              "deliveryDT": "$deliveryDT",
//              "readDT": "$readDT",
//              "readDeviceCode": "$deviceCode"
//           }));
//       resCode = response.statusCode;
//        print("responce: ${json.decode(response.body)}");
//       // log(jsonEncode({
//       //        "docEntry": docEntry,
//       //        "deliveryDT": "$deliveryDT",
//       //        "readDT": "$readDT",
//       //        "readDeviceCode": "$deviceCode"
//       //     }));
//        log("ProfileAPI4: " + json.decode(response.body).toString());
//       if (response.statusCode == 200) {
//         return NofificationModel.fromJson(json.decode(response.body), resCode);
//       } else {
//         print("Error: ${json.decode(response.body)}");
//         return NofificationModel.error("Error", resCode);
//       }
//     } catch (e) {
//       print("Exception: " + e.toString());
//       return NofificationModel.error(e.toString(), resCode);
//     }
//   }
// }
