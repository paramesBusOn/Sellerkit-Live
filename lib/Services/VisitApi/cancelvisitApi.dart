import 'dart:convert';

import 'package:flutter/material.dart';

import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/VisitPlanModel/cancelmodel.dart';

import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:sellerkit/Constant/Configuration.dart';

import '../../../Constant/ConstantSapValues.dart';

class CancelVisitApi {
  static Future<cancelModel> getData(
    leadDocEntry,
  ) async {
    int resCode = 500;
    try {
      Config config = Config();
      log("url: " + Url.queryApi + 'Sellerkit_Flexi/v2/CancelVisitplan?visitid=$leadDocEntry');
      await config.getSetup();
      final response = await http.post(
        Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/CancelVisitplan?visitid=$leadDocEntry'),
        headers: {
          "content-type": "application/json",
          "Authorization": 'bearer ' + ConstantValues.token,
          "Location": '${ConstantValues.EncryptedSetup}'
        },
      );

      
      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("leadopen" + json.decode(response.body).toString());
      if (response.statusCode >= 200 && response.statusCode <= 200) {
        return cancelModel.fromJson(response.statusCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return cancelModel.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return cancelModel.error(e.toString(),resCode);
    }
  }
}
