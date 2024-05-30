// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/CheckEnqCusDetailsModel.dart';

class CheckEnqDetailsApi {
  static Future<CheckEnqDetailsModel> getData(sapUserId, phoneNO) async {
    int resCode = 500;
    
Config config = Config();
    try {
      // print("ANBUU"+sapUserId.toString());      log("ANBUU"+phoneNO.toString());
    log(Url.queryApi + 'SkClientPortal/Chkenquiry?phone=$phoneNO&Slpcode=$sapUserId');
      await config.getSetup(); final response = await http.post(
          Uri.parse(Url.queryApi + 'SkClientPortal/Chkenquiry?phone=$phoneNO&Slpcode=$sapUserId'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec sk_get_check_customer '${phoneNO}','${ConstantValues.slpcode}'"
          // })
          );

          // log(jsonEncode({
          //   "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec sk_get_check_customer '${phoneNO}','${ConstantValues.slpcode}'"
          // }));
      resCode = response.statusCode;
      log('Anbustcode::'+response.statusCode.toString());
      log("sk_get_check_customer111 "+response.body.toString());
      if (response.statusCode == 200) {
         log("chequeenq:"+response.statusCode.toString());
        return CheckEnqDetailsModel.fromJson((response.body).toString(), response.statusCode);
        
      } else {
        // print("chequeenqError: ${json.decode(response.body)}");
        return CheckEnqDetailsModel.error("Error", resCode);
      }
    } catch (e) {
      print("chequeenqException: " + e.toString());
      return CheckEnqDetailsModel.error(e.toString(), resCode);
    }
  }
}
//  body: jsonEncode({
//             "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
//             "query": "exec sk_get_check_customer '${phoneNO}','${ConstantValues.slpcode}'"
//           }));
