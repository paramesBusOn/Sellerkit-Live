// ignore_for_file: unused_import, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/ItemMasterModelNew.dart/ItemMasterNewModel.dart';
import '../../Models/AccountsModel/AccountsdetailsModel.dart';
// import 'package:sellerkit/main.dart';

class AccountsdetailsApiNew {
  // int i
  static Future<AccountsEnqDetailsNew> getData(String number) async {
    int resCode = 500;
    // print("Url accounts: ${Url.queryApi}SellerKit");
    // print(ConstantValues.sapSessions);
    // print(DataBaseConfig.ip);
    // print(DataBaseConfig.database);

    try {
      log("EnqAcc"+Url.queryApi+ 'SkClientPortal/GetENQuirybyCustomerCode?Customercode=$number');
      Config config = Config();
      // await config.getSetup();
       final response = await http.get(Uri.parse(Url.queryApi+ 'SkClientPortal/GetENQuirybyCustomerCode?Customercode=$number'),
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
      log("EnqAccstatuscode"+response.statusCode.toString());
      log("EnqAccresEnQ" + json.decode(response.body).toString());
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return AccountsEnqDetailsNew.fromJson(json.decode(response.body), resCode);
      } else {
        // print("Error: ${json.decode(response.body)}");
        // throw Exception("Error");
        return AccountsEnqDetailsNew.error('Error', resCode);
      }
    } catch (e) {
      log("Exception11: " + e.toString());
      //  throw Exception(e.toString());
      return AccountsEnqDetailsNew.error(e.toString(), resCode);
    }
  }
}
