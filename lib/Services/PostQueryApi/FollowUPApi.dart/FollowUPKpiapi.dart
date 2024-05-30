// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/FollowUPModel.dart/FollowUPKPIModel.dart';

class FollowUPKPIApi {
  static Future<FollowUPKPIModel> getData() async {
    int resCode = 500;
    try {

Config config = Config();
      await config.getSetup(); final response = await http.post(
          Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/AllFollowupSummary'),
          headers: {
            "content-type": "application/json",
             "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
       
          },
         
          );
         
      resCode = response.statusCode;
     // print(response.statusCode.toString());
      log("followup kpi: "+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return FollowUPKPIModel.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return FollowUPKPIModel.issues(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return FollowUPKPIModel.error(e.toString(), resCode);
    }
  }
}
