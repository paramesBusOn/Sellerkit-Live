// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Models/SettlementModel/SettlementGetModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:http/http.dart' as http;

// import 'package:sellerkit/main.dart';

class SettlementGetApi {
  static Future<SettlementGetDetails> getdata() async {
    int resCode = 500;
    try {
      Config config = Config();
      await config.getSetup();
      final response = await http.post(
          Uri.parse("${Url.queryApi}Sellerkit_Flexi/v2/SettleGet"),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
          },
          body: jsonEncode({
            "listtype": "summary",
            "valuetype": "name",
            "fromperiod": null,
            "toperiod": null,
            "status": null
          }));
      response.statusCode;
      log("settle Get:" + response.body.toString());
      if (response.statusCode == 200) {
        return SettlementGetDetails.fromJson(
            json.decode(response.body.toString()), response.statusCode);
      } else {
        return SettlementGetDetails.issues(
            json.decode(response.body.toString()), response.statusCode);
      }
    } catch (e) {
      log("collection exception:" + e.toString());

      return SettlementGetDetails.error("$e", resCode);
    }
  }
}

class getCollectBody {
  String? listtype;
  String? valuetype;
  String? fromperiod;
  String? toperiod;
  String? status;
  String? userid;

  getCollectBody(
      {required this.listtype,
      required this.valuetype,
      required this.fromperiod,
      required this.toperiod,
      required this.status,
      required this.userid});
}
