// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';

import '../../Constant/ConstantSapValues.dart';
import '../../Models/getvisitmodel/getvisitmodel.dart';
import '../URL/LocalUrl.dart';

class getvisitApi {
  static Future<getvisitmodel> getdata() async {
    int resCode = 500;
    try {
      Config config = Config();
      // config.getSetup();
      print("UPI::"+Url.queryApi +
              'Sellerkit_Flexi/v2/getAllVisitPlan');
      final response = await http.post(
          Uri.parse(Url.queryApi +
              'Sellerkit_Flexi/v2/getAllVisitPlan'),
          headers: {
            "content-type": "application/json",
            "authorization": 'bearer ' + ConstantValues.token,
            "Location": '${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
              "listtype": "all",
  "valuetype": "name",
  "fromperiod": null,
  "toperiod": null,
  "status": null
          })
          );
      log("getvist::" + response.statusCode.toString());

      log("getvist::" + response.body.toString());
      resCode = response.statusCode;
      if (response.statusCode == 200) {
        return getvisitmodel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        return getvisitmodel.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("error::" + e.toString());
      return getvisitmodel.error("${e.toString()}", resCode);
    }
  }
}
