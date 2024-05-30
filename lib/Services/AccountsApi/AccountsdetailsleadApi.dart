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


class AccountsLeaddetailsApiNew {
  // int i
  static Future<AccountsLeadDetailsNew> getData(String number) async {
    int resCode = 500;
    // print("Url accounts: ${Url.queryApi}SellerKit");
    // print(ConstantValues.sapSessions);
    // print(DataBaseConfig.ip);
    // print(DataBaseConfig.database);

    try {
      Config config = Config();
      log("EnqAcc"+Url.queryApi+ 'SkClientPortal/getleadbyadmin?slpcode=$number');
      await config.getSetup(); final response = await http.get(Uri.parse(Url.queryApi+ 'SkClientPortal/getleadbyadmin?slpcode=$number'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
         
          );
      // log(jsonEncode({
      //   "constr":
      //       "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
      //   "query": "exec [SK_GET_CUSTOMER_LIST] '${ConstantValues.slpcode}','$i'"
      // }));
      resCode = response.statusCode;
      log("EnqAccstatuscode"+response.statusCode.toString());
      log("EnqAccresLead" + json.decode(response.body).toString());
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return AccountsLeadDetailsNew.fromJson(json.decode(response.body), resCode);
      } else {
        // print("Error: ${json.decode(response.body)}");
        // throw Exception("Error");
        return AccountsLeadDetailsNew.error('Error', resCode);
      }
    } catch (e) {
      log("Exception22: " + e.toString());
      //  throw Exception(e.toString());
      return AccountsLeadDetailsNew.error(e.toString(), resCode);
    }
  }
}
