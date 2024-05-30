import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/GetLeadSummary.dart';
import 'package:sellerkit/main.dart';

class GetLeadSummaryApi {
  static Future<GetSummaryLeadModal> getData(
    sapUserId,
  ) async {
    int resCode = 500;
    try {
Config config = Config();

      await config.getSetup(); final response = await http.post(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/GetLeadSummary'),
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
          );

      resCode = response.statusCode;
      // print(response.statusCode.toString());
      log("GetLeadSummaryLead:"+response.body.toString());
      if (response.statusCode == 200) {
        return GetSummaryLeadModal.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return GetSummaryLeadModal.issues(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception22: " + e.toString());
      return GetSummaryLeadModal.error(e.toString(), resCode);
    }
  }
}
// class GetLeadSummaryApi {
//   static Future<GetSummaryLeadModal> getData(
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
//         return GetSummaryLeadModal.fromJson(
//             json.decode(response.body), resCode);
//       } else {
//         print("Error: ${json.decode(response.body)}");
//         return GetSummaryLeadModal.error('Error', resCode);
//       }
//     } catch (e) {
//       print("Exception: " + e.toString());
//       return GetSummaryLeadModal.error(e.toString(), resCode);
//     }
//   }
// }
