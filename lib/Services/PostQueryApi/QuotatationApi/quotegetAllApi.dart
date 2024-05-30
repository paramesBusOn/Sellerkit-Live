


import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/QuoteModel/quotesgetallModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Constant/ConstantSapValues.dart';

class GetAllQuotesApi {
  static Future<GetAllQuotesModal> getData(
   
  ) async {
    int resCode = 500;
    try {
      
Config config = Config();
      log("URLL:"+Url.queryApi + 'Sellerkit_Flexi/v2/GetAllQuotes');
      final response = await http.post(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/GetAllQuotes'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
          body:jsonEncode({
            "listtype": "summary",
  "valuetype": "name",
  "fromperiod":null,
  "toperiod": null,
  "status": null
          })
         
          );
          
       
      resCode = response.statusCode;
      // print(response.statusCode.toString());
      log("Get Quotes"+response.body);
      if (response.statusCode == 200) {
        return GetAllQuotesModal.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return GetAllQuotesModal.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception11: " + e.toString());
      return GetAllQuotesModal.error(e.toString(), resCode);
    }
  }
}
// body: jsonEncode({
//             "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
//             "query": "exec SK_GET_LEADS '${ConstantValues.slpcode}'"
//           })