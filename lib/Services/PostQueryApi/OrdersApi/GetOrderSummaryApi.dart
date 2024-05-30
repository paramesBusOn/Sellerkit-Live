import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';

import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Models/PostQueryModel/OrdersCheckListModel/GetOrderSummary.dart';

class GetOrderSummaryApi {
  static Future<GetSummaryOrderModal> getData(
    sapUserId,
  ) async {
    int resCode = 500;
    try {
      
Config config = Config();
      await config.getSetup(); final response = await http.post(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/OrderSummary'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
           
  "listtype": "summary",
  "valuetype": "name",
  "fromperiod": null,
  "toperiod": null,
  "status": null
 

          })
          // body: jsonEncode({
          //   "constr":"Server=sathya.sellerkit.in;Database=SAPL;User Id=sa; Password=BusOn@123;",
          //   "query": "exec SK_GET_LEADS_SUMMARY '${ConstantValues.slpcode}'"
          // })
          );

      resCode = response.statusCode;
      // print(response.statusCode.toString());
      log("GetOrderSummary:"+response.body);
      if (response.statusCode == 200) {
        return GetSummaryOrderModal.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return GetSummaryOrderModal.error('Error', response.statusCode);
      }
    } catch (e) {
      print("Exception22: " + e.toString());
      return GetSummaryOrderModal.error(e.toString(), resCode);
    }
  }
}
// class GetLeadSummaryApi {
//   static Future<GetSummaryOrderModal> getData(
//     sapUserId,
//   ) async {
//     int resCode = 500;
//     try {
//       await config.getSetup(); final response = await http.post(Uri.parse(Url.queryApi + 'SellerKit'),
//           headers: {
//             "content-type": "application/json",
//           },
//           body: jsonEncode({
//             "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
//             "query": "exec SK_GET_LEADS_SUMMARY '${ConstantValues.slpcode}'"
//           }));

//       resCode = response.statusCode;
//       // print(response.statusCode.toString());
//       // print(json.decode(response.body));
//       if (response.statusCode == 200) {
//         return GetSummaryOrderModal.fromJson(
//             json.decode(response.body), resCode);
//       } else {
//         print("Error: ${json.decode(response.body)}");
//         return GetSummaryOrderModal.error('Error', resCode);
//       }
//     } catch (e) {
//       print("Exception: " + e.toString());
//       return GetSummaryOrderModal.error(e.toString(), resCode);
//     }
//   }
// }
