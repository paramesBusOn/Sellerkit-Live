// ignore_for_file: unnecessary_new, prefer_interpolation_to_compose_strings

import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/GetUrlModel/GetUrlModel.dart';

class GetURLApi {
  static Future<GetUrlModel> getData(
String? CustomerId) async {
// await config.getSetup();
print("Api CustomerId::"+CustomerId.toString());
    int resCode = 500;
    try {
      print('Get Url Api::http://164.52.217.188:81/api/PortalAuthenticate/RegisterUser?TenantId=$CustomerId');
    final response = await http.post(Uri.parse('http://164.52.217.188:81/api/PortalAuthenticate/RegisterUser?TenantId=$CustomerId'),

        headers: {"Content-Type": "application/json"},

    );
print("get url body::"+response.body.toString());
      print("Status Code::" +response.statusCode.toString());
      resCode = response.statusCode;
      
      if (response.statusCode == 200) {
        // print("Error: ${response.body}");
        return GetUrlModel.fromJson(response.body, response.statusCode);
      } else {
        // print("Error: ${response.body}");
        return GetUrlModel.issue(response.statusCode,response.body );
      }
    } catch (e) {
      log("Exception: " + e.toString());
      return GetUrlModel.error(e.toString(), resCode);
    }
  }
}
