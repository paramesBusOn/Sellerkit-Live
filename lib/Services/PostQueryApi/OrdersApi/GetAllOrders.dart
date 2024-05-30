import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/OrdersCheckListModel/GetAllOrderModel.dart';
import 'package:sellerkit/main.dart';

class GetAllOrderApi {
  static Future<GetAllOrderModal> getData(
    sapUserId,
  ) async {
    int resCode = 500;
    try {
      
Config config = Config();
      log("URLL:"+Url.queryApi + 'Sellerkit_Flexi/v2/GetAllOrders');
      await config.getSetup(); final response = await http.post(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/GetAllOrders'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
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
      log("Get All Orders"+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return GetAllOrderModal.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return GetAllOrderModal.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception11: " + e.toString());
      return GetAllOrderModal.error(e.toString(), resCode);
    }
  }
}
// body: jsonEncode({
//             "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
//             "query": "exec SK_GET_LEADS '${ConstantValues.slpcode}'"
//           })