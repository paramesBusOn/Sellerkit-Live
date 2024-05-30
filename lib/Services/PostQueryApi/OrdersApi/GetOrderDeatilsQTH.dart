// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';

import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/GetOderDetailsQTHModel.dart';
import 'package:sellerkit/main.dart';

class GetOrderQTHApi {
  static Future<GetOrderDetailsQTH> getData(
    docentry,
  ) async {
    int resCode = 500;
    log("docentry: "+docentry);
    try {
      
Config config = Config();
      log("UUUURL::"+Url.queryApi + 'SkClientPortal/getOrderQUT2?Docentry=$docentry');
      await config.getSetup(); final response = await http.get(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/Order?OrderId=$docentry'),
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
      log("GetLeadQTHApiaaaaa: "+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return GetOrderDetailsQTH.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        print("Error: ${json.decode(response.body).toString()}");
        return GetOrderDetailsQTH.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception11: " + e.toString());
      return GetOrderDetailsQTH.error(e.toString(), resCode);
    }
  }
}
