import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';

import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Models/PostQueryModel/OrdersCheckListModel/GetOrderCheckListModel.dart';

class GetOrderCheckListApi {
  static Future<OrdersCheckListModal> getData(
    sapUserId,
  ) async {
    int resCode = 500;
    try {   
Config config = Config();
      log("message11::"+Url.queryApi + 'SkClientPortal/GetallMaster?MasterTypeId=6');
      await config.getSetup(); final response = await http.get(Uri.parse(Url.queryApi + 'SkClientPortal/GetallMaster?MasterTypeId=6'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec SK_GET_LEAD_CHECKLIST '${ConstantValues.slpcode}'"
          // })
          );

      resCode = response.statusCode;
      log("ressta:"+response.statusCode.toString());
      log("rescheck:"+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return OrdersCheckListModal.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return OrdersCheckListModal.error('Error', resCode);
      }
    } catch (e) {
      print("Exception11: " + e.toString());
      return OrdersCheckListModal.error(e.toString(), resCode);
    }
  }
}



// class GetLeadCheckListApi {
//   static Future<OrdersCheckListModal> getData(
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
//         return OrdersCheckListModal.fromJson(
//             json.decode(response.body), resCode);
//       } else {
//         print("Error: ${json.decode(response.body)}");
//         return OrdersCheckListModal.error('Error', resCode);
//       }
//     } catch (e) {
//       print("Exception11: " + e.toString());
//       return OrdersCheckListModal.error(e.toString(), resCode);
//     }
//   }
// }