

// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/QuoteModel/quotesQth.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';

import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Constant/DataBaseConfig.dart';
import 'package:sellerkit/main.dart';

class GetQuotesQTHApi {
  static Future<GetQuotesDetailsQTH> getData(
    docentry,
  ) async {
    int resCode = 500;
    log("docentry: "+docentry);
    try {
      
Config config = Config();
      log("UUUURL::"+Url.queryApi + 'Sellerkit_Flexi/v2/QuotesbyId?QuotesId=$docentry');
      await config.getSetup(); final response = await http.get(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/QuotesbyId?QuotesId=$docentry'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec SK_GET_LEAD_DETAILS_QTH '${docentry}'"
          // })
          );
      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("GetLeadQTHApi: "+response.body);
      if (response.statusCode == 200) {
        return GetQuotesDetailsQTH.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        print("Error: ${json.decode(response.body).toString()}");
        return GetQuotesDetailsQTH.error(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception11: " + e.toString());
      return GetQuotesDetailsQTH.error(e.toString(), resCode);
    }
  }
}
