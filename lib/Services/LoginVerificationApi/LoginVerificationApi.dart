// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/LoginVerificationModel/LoginVerificationModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
// import 'package:sellerkit/main.dart';

class LoginVerificationApi {
  static Future<LoginVerificationModel> getData(String? fcm, String? devicecode,
      String? tenetId, int? typeid, String? usercode,String? password) async {
    int resCode = 500;
    try {
      log("URRRRL" + Url.queryApi + 'Sellerkit_Flexi/v2/Logout');

      final response =
          await http.post(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/Logout'),
              headers: {
                "content-type": "application/json",
              },
              body: jsonEncode({
                "userCode": "${usercode}",
                "fcmCode": "${fcm}",
                "deviceCode": "${devicecode}",
                "logoutTypeId": typeid,
                "tenantId": "${tenetId}",
                 "password": "${password}"
              }));
              log("message555555"+jsonEncode({
                "userCode": "${usercode}",
                "fcmCode": "${fcm}",
                "deviceCode": "${devicecode}",
                "logoutTypeId": typeid,
                "tenantId": "${tenetId}",
                "password": "${password}",
              }));
      log("Stcode:" + response.statusCode.toString());
      log("Bodylogout:" + response.body.toString());

      if (response.statusCode == 200) {
        //  log("chequeenq:"+response.statusCode.toString());
        return LoginVerificationModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        // log("chequeenqError: ${json.decode (response.body)}");
        return LoginVerificationModel.fromJson(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("chequeenqException: " + e.toString());
      return LoginVerificationModel.error(e.toString(), resCode);
    }
  }
}
