import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';


class UserdialApi {
  static Future<String> getdata(String userid,String number) async {
    int resCode = 500;
    try {
      log("dhasd::"+Url.queryApi + 'Sellerkit_Flexi/v2/CallOperator?UserId=$userid&number=%2B$number');
      final response = await http.post(
          Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/CallOperator?UserId=$userid&number=%2B91$number'),
          headers: {
            "content-type": "application/json",
          "Authorization": 'bearer ' + ConstantValues.token,
          
          },
          );
      
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
