import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';


class UserdialApi {
  static Future<String> getdata() async {
    int resCode = 500;
    try {
      final response = await http.post(
          Uri.parse("https://obd-api.myoperator.co/obd-api-v1"),
          headers: {
            "content-type": "application/json",
            "x-api-key": 'oomfKA3I2K6TCJYistHyb7sDf0l0F6c8AZro5DJh',
          },
          body: jsonEncode({
            "company_id": "66275712a289e160",
                    "secret_token":"7026e44937b0bfb94949586355a5783c026bb363f3a1c825c4b2c26feb1c4fbb",
                    "type": "1", //1 for peer to peer
                    "user_id": "66275712a68e1594",
                    "number": "+917092571625",
                    "public_ivr_id": "664c6304e6bc3119",
                    "reference_id":"278617608akdjwiasd9", //e.g. abd9238dh21ss
                    "region": "BANGALORE",
                    "caller_id": "8062276114",
                    "group": "group-782"
          }));
      log("Adddata::" +
          jsonEncode({
            
          }));
      log("json.decode(response.body)::" +
          json.decode(response.body).toString());
      resCode = response.statusCode;
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return "success";
        // SPSavePostModal.fromJson(
        //     json.decode(response.body), response.statusCode);
      } else {
        return "";
        // SPSavePostModal.issue(
        //     json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception111: " + e.toString());
      return "";
      // SPSavePostModal.error(
      //       "${e.toString()}", resCode);
    }
  }
}
