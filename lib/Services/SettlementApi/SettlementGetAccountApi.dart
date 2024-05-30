// ignore_for_file: prefer_interpolation_to_compose_strings, unused_import

import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Models/SettlementModel/SettleGetAccountModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/GetLeadStatuModel.dart';
import 'package:sellerkit/main.dart';

class GetAccountDetailsApi {
 static Future<GetBAnkAccountModal> getData() async {
    int resCode = 500;
    try {
      final response = await http.get(
        Uri.parse(Url.queryApi + 'SkClientPortal/GetallMaster?MasterTypeId=22'),
        headers: {
          "content-type": "application/json",
          "Authorization": 'bearer ' + ConstantValues.token,
        },
      );
        print("responce bank: ${json.decode(response.body)}");
        print("stcode bank: ${response.statusCode}");

      resCode = response.statusCode;
     
      if (response.statusCode == 200) {
        return GetBAnkAccountModal.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return GetBAnkAccountModal.issues(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return GetBAnkAccountModal.error(e.toString(), resCode);
    }
  }
}
