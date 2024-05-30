import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Models/AddEnqModel/AddEnqModel.dart';

import 'package:sellerkit/Models/specialpriceModel/NewAddModel.dart';
import 'package:sellerkit/Models/specialpriceModel/SPupdateModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

class SpecialupdateApi {
  static Future<SPupdatePostModal> getdata(addspecialprice spadd) async {
    int resCode = 500;
    try {
      final response = await http.put(
          Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/SPLPRICE_UPDATE'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location": '${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
            "requestID": spadd.docentry,
            "fromDate": "${spadd.fromDate}",
            "toDate": "${spadd.toDate}",
            "customerCode": "${spadd.customerCode}",
            "customerName": "${spadd.customerName}",
            "customerMobile": "${spadd.customerMobile}",
            "itemCode": "${spadd.itemCode}",
            "itemName": "${spadd.itemName}",
            "quantity": spadd.quantity,
            "storeCode": ConstantValues.Storecode,
            "assignedTo": ConstantValues.Usercode,
            "rp": spadd.rp
          }));
      log("Adddata::" +
          jsonEncode({
            "requestID": spadd.docentry,
            "fromDate": "${spadd.fromDate}",
            "toDate": "${spadd.toDate}",
            "customerCode": "${spadd.customerCode}",
            "customerName": "${spadd.customerName}",
            "customerMobile": "${spadd.customerMobile}",
            "itemCode": "${spadd.itemCode}",
            "itemName": "${spadd.itemName}",
            "quantity": spadd.quantity,
            "storeCode": ConstantValues.Storecode,
            "assignedTo": ConstantValues.Usercode,
            "rp": spadd.rp
          }));
      log("json.decode(response.body)::" +
          json.decode(response.body).toString());
      resCode = response.statusCode;
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return SPupdatePostModal.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        return SPupdatePostModal.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception111: " + e.toString());
      return SPupdatePostModal.error(
            "${e.toString()}", resCode);
    }
  }
}
