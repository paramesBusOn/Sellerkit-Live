// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Models/newNotificationModel/newnotifyModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import 'package:sellerkit/main.dart';

import '../../Constant/ConstantSapValues.dart';
import '../../Models/siteinModel/getsiteinmodel.dart';

class getNotificationApi {
  static Future<NewNotificationModel> getData() async {
    int resCode = 500;
    try {
     log("URRRRL"+Url.queryApi + 'Sellerkit_Flexi/v3/GetNotificationList');
      // Config config = Config();
      // await config.getSetup(); 
      final response = await http.get(
          Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v3/GetNotificationList'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
 
          );

        
      resCode = response.statusCode;
      log(response.statusCode.toString());
      log("sk_get_check_customer111 "+response.body.toString());
      if (response.statusCode == 200) {
         log("chequeenq:"+response.statusCode.toString());
        return NewNotificationModel.fromJson(json.decode(response.body), response.statusCode);
        
      } else {
        // print("chequeenqError: ${json.decode(response.body)}");
        return NewNotificationModel.error("Error", resCode);
      }
    } catch (e) {
      log("chequeenqExceptiongetsitein: " + e.toString());
      return NewNotificationModel.error(e.toString(), resCode);
    }
  }
}
