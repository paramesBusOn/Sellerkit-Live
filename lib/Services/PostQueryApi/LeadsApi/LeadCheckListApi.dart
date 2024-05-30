// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/GetLeadCheckListModel.dart';
// import 'package:sellerkit/main.dart';

class GetLeadCheckListApi {
  static Future<LeadsCheckListModal> getData(
    sapUserId,
  ) async {
    int resCode = 500;
    try {
      log("message11::" +
          Url.queryApi +
          'SkClientPortal/GetallMaster?MasterTypeId=6');
      Config config = new Config();
      await config.getSetup();
      final response = await http.get(
        Uri.parse(Url.queryApi + 'SkClientPortal/GetallMaster?MasterTypeId=6'),
        headers: {
          "content-type": "application/json",
          "Authorization": 'bearer ' + ConstantValues.token,
          "Location": '${ConstantValues.EncryptedSetup}'
        },
        // body: jsonEncode({
        //   "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
        //   "query": "exec SK_GET_LEAD_CHECKLIST '${ConstantValues.slpcode}'"
        // })
      );

      resCode = response.statusCode;
      // log("ressta:"+response.statusCode.toString());
      log("rescheckList::"+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return LeadsCheckListModal.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return LeadsCheckListModal.error('Error', resCode);
      }
    } catch (e) {
      print("Exception11: " + e.toString());
      return LeadsCheckListModal.error(e.toString(), resCode);
    }
  }
}



// class GetLeadCheckListApi {
//   static Future<LeadsCheckListModal> getData(
//     sapUserId,
//   ) async {
//     int resCode = 500;
//     try {
//       log("message11::"+Url.queryApi + 'SellerKit');
//       await config.getSetup(); final response = await http.post(Uri.parse(Url.queryApi + 'SellerKit'),
//           headers: {
//             "content-type": "application/json",
//           },
//           body: jsonEncode({
//             "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
//             "query": "exec SK_GET_LEAD_CHECKLIST '${ConstantValues.slpcode}'"
//           }));

//       resCode = response.statusCode;
//       print(response.statusCode.toString());
//       print(json.decode(response.body));
//       if (response.statusCode == 200) {
//         return LeadsCheckListModal.fromJson(
//             json.decode(response.body), resCode);
//       } else {
//         print("Error: ${json.decode(response.body)}");
//         return LeadsCheckListModal.error('Error', resCode);
//       }
//     } catch (e) {
//       print("Exception11: " + e.toString());
//       return LeadsCheckListModal.error(e.toString(), resCode);
//     }
//   }
// }