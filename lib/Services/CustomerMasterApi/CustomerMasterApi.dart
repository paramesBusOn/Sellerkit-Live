// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
// import '../../../Constant/DataBaseConf  ountsModel.dart';
import '../../Models/CustomerMasterModel/CustomerMasterModel.dart';
// import 'package:sellerkit/main.dart';

class CustomerMasterApiNew {
  // int i
   Future<CustomerDetails> getData() async {
    int resCode = 500;
    // print("Url accounts: ${Url.queryApi}SellerKit");
    // print(ConstantValues.sapSessions);
    // print(DataBaseConfig.ip);
    // print(DataBaseConfig.database);

    try {
        // Config config = Config();
      // await config.getSetup(); 
      final response = await http.get(
        Uri.parse(Url.queryApi + 'SkClientPortal/GetAllCustomers'),
        //
        headers: {
          "content-type": "application/json",
          "Authorization": 'bearer ' + ConstantValues.token,
          "Location":'${ConstantValues.EncryptedSetup}'
        },
        //
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
      // log("statuscode"+response.statusCode.toString());
      log("Customer Master::" + response.body.toString());
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return CustomerDetails.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        // print("Error: ${json.decode(response.body)}");
        // throw Exception("Error");
        return CustomerDetails.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("Exception: " + e.toString());
      //  throw Exception(e.toString());
      return CustomerDetails.error(e.toString(), resCode);
    }
  }
}
