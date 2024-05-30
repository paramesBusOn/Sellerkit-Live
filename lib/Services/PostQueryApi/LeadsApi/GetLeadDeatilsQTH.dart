// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsQTHModel.dart';
import 'package:sellerkit/main.dart';

class GetLeadQTHApi {
  static Future<GetLeadDetailsQTH> getData(
    docentry,
  ) async {
    int resCode = 500;
    log("docentry: "+docentry);
    try {
Config config = Config();

      log("UUUURL::"+Url.queryApi + 'Sellerkit_Flexi/v2/Leads?leadId=$docentry');
      await config.getSetup(); final response = await http.get(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/Leads?leadId=$docentry'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
         
          );
      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("GetLeadQTHApiaaaaaaassadada: "+response.body.toString());
      if (response.statusCode == 200) {
        return GetLeadDetailsQTH.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        // print("Error: ${json.decode(response.body).toString()}");
        return GetLeadDetailsQTH.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception11: " + e.toString());
      return GetLeadDetailsQTH.error(e.toString(), resCode);
    }
  }
}
