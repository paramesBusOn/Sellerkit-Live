import 'dart:convert';
import 'dart:developer';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Models/LeadAnalysisModel/LeadAnalysisModel.dart';
import 'package:sellerkit/Models/SettlementModel/SettlementGetModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:http/http.dart' as http;

// import 'package:sellerkit/main.dart';

class LeadAnalysisApi {
  static Future<LeadAnalysisModel> getdata() async {
    int resCode = 500;
    try {
      Config config = Config();
      await config.getSetup();
      final response = await http.get(
        Uri.parse(
            "${Url.queryApi}Sellerkit_Flexi/v2/GetLeadReport?UserId=${ConstantValues.UserId}"),
        headers: {
          "content-type": "application/json",
          "Authorization": 'bearer ${ConstantValues.token}',
        },
      );
      response.statusCode;
      log("settle Get:${response.body}");
      if (response.statusCode == 200) {
        return LeadAnalysisModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        return LeadAnalysisModel.issues(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("LeadAnalysis exception:$e");

      return LeadAnalysisModel.error("$e", resCode);
    }
  }
}
