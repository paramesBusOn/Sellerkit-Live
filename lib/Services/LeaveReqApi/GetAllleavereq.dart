// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Models/LeavereqModel/GetAllreqmodel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../Models/LeavereqModel/leavereqgetmodel.dart';
// import 'package:sellerkit/main.dart';

class GetAllLeavereqApi {
  static Future<GetAllleavereqmodel> getData() async {
    int resCode = 500;
    try {
     log("URRRRL"+Url.queryApi + 'SkClientPortal/GetleaveRequests?UserCode=${ConstantValues.Usercode}');
           Config config = Config();

      await config.getSetup(); 
      final response = await http.get(
          Uri.parse(Url.queryApi + 'SkClientPortal/GetleaveRequests?UserCode=${ConstantValues.Usercode}'),
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
        return GetAllleavereqmodel.fromJson((response.body.toString()), response.statusCode);
        
      } else {
        print("chequeenqError: ${json.decode(response.body)}");
        return GetAllleavereqmodel.error("Error", resCode);
      }
    } catch (e) {
      print("chequeenqException: " + e.toString());
      return GetAllleavereqmodel.error(e.toString(), resCode);
    }
  }
}
