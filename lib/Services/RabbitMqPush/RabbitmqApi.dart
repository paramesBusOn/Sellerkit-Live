// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/LeadSavePostModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/AddEnqModel/AddEnqModel.dart';
import '../../Constant/DataBaseConfig.dart';
import '../../Models/RabiitMqPushModel/RabbitMQModel.dart';

class RaabitMQApi {
  static Future<RabiitMqModel> getData(PatchExCus patch,
      [PostLead? postLead]) async {
    int resCode = 500;
    log(Url.queryApi + "SellerKit/SendToRabbitNQ");
    Map<String, dynamic> data = {
      "CardCode": "${patch.CardCode}",
      "CardName": "${patch.CardName}",
      "CardType": "cCustomer",
      "SalesPersonCode": "${ConstantValues.slpcode}",
      "LanguageCode": 8,
      "U_Address1": "${patch.U_Address1}",
      "U_Address2": "${patch.U_Address2}",
      "U_City": "${patch.U_City}",
      "U_Pincode": "${patch.U_Pincode}",
      "U_State": patch.U_State == null ? null : "${patch.U_State}",
      "U_Country": patch.U_Country == null ? null : "${patch.U_Country}",
      "U_Facebook": patch.U_Facebook == null ? null : "${patch.U_Facebook}",
      "U_EMail": "${patch.U_EMail}",
      "U_Type": "${patch.U_Type}"
    };
    // print("$data");
    // String rpdata = jsonEncode(data).toString().replaceAll('"',"'");
    // print("rpstring string : "+ rpdata.toString());
    // print("data string encoded : "+ jsonEncode(rpdata));
    try {
      final response =
          await http.post(Uri.parse(Url.queryApi + "SellerKit/SendToRabbitNQ"),
              headers: {
                "content-type": "application/json",
                // "cookie": 'B1SESSION=' + ConstantValues.sapSessions,
              },
              body: jsonEncode({
                "hostName": "${DataBaseConfig.ip}",
                "userName": "buson",
                "password": "BusOn123",
                "exchangeName": "SAP",
                "routeKey": "HO01",
                "sapurl": "${Url.SLUrl}",
                "sapActionType": "BusinessPartners",
                "companyDB": "${DataBaseConfig.userId}",
                "sapUser": "SK_CHN1_COMMON",
                "sapPsw": "Mani@1234",
                "payload": jsonEncode(data)
              }));

      log("reabitt: " +
          jsonEncode({
            "hostName": "${DataBaseConfig.ip}",
            "userName": "buson",
            "password": "BusOn123",
            "exchangeName": "SAP",
            "routeKey": "HO01",
            "sapurl": "${Url.SLUrl}",
            "sapActionType": "BusinessPartners",
            "companyDB": "${DataBaseConfig.userId}",
            "sapUser": "SK_CHN1_COMMON",
            "sapPsw": "Mani@1234",
            "payload": jsonEncode(data)
          }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return RabiitMqModel.fromJson(
            json.decode(response.body.toString()), resCode);
      } else if (response.statusCode >= 400 && response.statusCode <= 410) {
        print("Error: ${json.decode(response.body)}");
        // throw Exception("Error");

        return RabiitMqModel.error(json.decode(response.body), resCode);
      } else {
        // throw Exception("Error");
        return RabiitMqModel.error('', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      //throw Exception(e.toString());
      return RabiitMqModel.error(e.toString(), resCode);
    }
  }
}
