// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/database_config.dart';
import '../../../Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/GetOrderDetailsQTL.dart';
import 'package:sellerkit/main.dart';

class GetLeadQTLApi {
  static Future<GetOrderDetailsQTL> getData(
    docentry,
  ) async {
    int resCode = 500;
    try {
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
        return GetOrderDetailsQTL.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return GetOrderDetailsQTL.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return GetOrderDetailsQTL.error(e.toString(), resCode);
    }
  }
}
