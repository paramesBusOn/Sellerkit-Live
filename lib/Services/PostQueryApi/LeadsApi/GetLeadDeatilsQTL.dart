// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/GetLeadDetailsQTL.dart';
import 'package:sellerkit/main.dart';

class GetLeadQTLApi {
  static Future<GetLeadDetailsQTL> getData(
    docentry,
  ) async {
    int resCode = 500;
    try {
Config config = Config();

      await config.getSetup(); final response = await http.post(Uri.parse(Url.queryApi + 'SellerKit'),
          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
            "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query": "exec SK_GET_LEAD_DETAILS_QTL '${docentry}'"
          }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print("GetLeadQTLApi: "+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return GetLeadDetailsQTL.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return GetLeadDetailsQTL.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return GetLeadDetailsQTL.error(e.toString(), resCode);
    }
  }
}
