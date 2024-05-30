import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/ItemMasterModelNew.dart/ItemMasterNewModel.dart';
import '../../Models/AccountsModel/AccountsModel.dart';
// import 'package:sellerkit/main.dart';

class AccountsApiNew {
  // int i
  static Future<AccountsDetails> getData() async {
    int resCode = 500;
    log(Url.queryApi+ 'Sellerkit_Flexi/v2/AllCustomers');
    // print(ConstantValues.sapSessions);
    // print(DataBaseConfig.ip);
    // print(DataBaseConfig.database);

    try {
      Config config = Config();
      await config.getSetup(); 
      final response = await http.post(Uri.parse(Url.queryApi+ 'Sellerkit_Flexi/v2/AllCustomers'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":
          //       "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query":
          //       "exec [SK_GET_CUSTOMER_LIST] '${ConstantValues.slpcode}','$i'"
          // })
          );
      // log(jsonEncode({
      //   "constr":
      //       "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
      //   "query": "exec [SK_GET_CUSTOMER_LIST] '${ConstantValues.slpcode}','$i'"
      // }));
      resCode = response.statusCode;
      log("statuscode"+response.statusCode.toString());
      log("Accountsres" + json.decode(response.body).toString());
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return AccountsDetails.fromJson(json.decode(response.body), response.statusCode);
      } else {
        // print("Error: ${json.decode(response.body)}");
        // throw Exception("Error");
        return AccountsDetails.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("Exception: " + e.toString());
      //  throw Exception(e.toString());
      return AccountsDetails.error(e.toString(), resCode);
    }
  }
}
