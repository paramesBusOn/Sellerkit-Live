

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Models/AddEnqModel/AddEnqModel.dart';
import 'package:sellerkit/Models/specialpriceModel/AprovergetModel.dart';

import 'package:sellerkit/Models/specialpriceModel/NewAddModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

class ApprovergetApi {
  static Future<getApproverModal> getdata(String? itemcode,String? rp) async {
    int resCode = 500;
    try {
      log(Url.queryApi + 'Sellerkit_Flexi/v2/Decision_User_Get/ItemCode/RP?itemCode=$itemcode&RP=$rp');
      final response = await http.get(
          Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/Decision_User_Get/ItemCode/RP?itemCode=$itemcode&RP=$rp'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location": '${ConstantValues.EncryptedSetup}'
          },
        );
      
      log("json.decode(response.body)::" +
          response.body);
      resCode = response.statusCode;
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return 
        getApproverModal.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        return 
        getApproverModal.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception111: " + e.toString());
      return 
      getApproverModal.error(
            "${e.toString()}", resCode);
    }
  }
}
