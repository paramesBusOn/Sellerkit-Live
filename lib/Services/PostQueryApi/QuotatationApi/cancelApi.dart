import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/QuoteModel/cancelmodel.dart';
import 'package:sellerkit/Services/PostQueryApi/OrdersApi/OpenSaveOrderApi.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:sellerkit/Constant/Configuration.dart';

import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/OrdersCheckListModel/ForwardOrderUserModel.dart';

class CancelApi {
  static Future<ForwardQuotesUser> getData(
      leadDocEntry, ForwardQuoteUserDataOpen forwardLeadUserData) async {
    int resCode = 500;
    try {
      
      
Config config = Config();
      log("url: " +
          Url.queryApi +
              'Sellerkit_Flexi/v2/Quotecancel');
      await config.getSetup(); final response = await http.post(
          Uri.parse(Url.queryApi +
              'Sellerkit_Flexi/v2/Quotecancel'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
             "docentry": leadDocEntry,
  "cancellationdate": "${forwardLeadUserData.curentDate}",
  "cancelledreason": "${forwardLeadUserData.ReasonCode}",
  "cancelledremarks": "${forwardLeadUserData.feedback}"
          }));

      log("opensaveleadbody" +
          jsonEncode({
             "docentry": leadDocEntry,
  "cancellationdate": "${forwardLeadUserData.curentDate}",
  "cancelledreason": "${forwardLeadUserData.ReasonCode}",
  "cancelledremarks": "${forwardLeadUserData.feedback}"
          }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("leadopen" + json.decode(response.body).toString());
      if (response.statusCode >= 200 && response.statusCode <= 200) {
        return ForwardQuotesUser.fromjson(resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return ForwardQuotesUser.issue(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return ForwardQuotesUser.fromjson(resCode);
    }
  }
}