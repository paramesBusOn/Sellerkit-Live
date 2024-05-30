// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import 'package:sellerkit/main.dart';

import '../../Constant/ConstantSapValues.dart';
import '../../Models/siteinModel/getsiteinmodel.dart';

class GetsiteinApi {
  static Future<getsiteInModel> getData() async {
    int resCode = 500;
    try {
     log("URRRRL"+Url.queryApi + 'SkClientPortal/GetSitecheckin?Slpcode=${ConstantValues.slpcode}');
      // Config config = Config();
      // await config.getSetup(); 
      final response = await http.get(
          Uri.parse(Url.queryApi + 'SkClientPortal/GetSitecheckin?Slpcode=${ConstantValues.slpcode}'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
  //         body: jsonEncode({
            
  // "vistitplanId":sitein.visitid,
  // "siteChekInTime": "2023-09-29T05:35:28.847Z"

  //         })
          );

        
      resCode = response.statusCode;
      log(response.statusCode.toString());
      log("sk_get_check_customer111 "+json.decode(response.body).toString());
      if (response.statusCode == 200) {
         log("chequeenq:"+response.statusCode.toString());
        return getsiteInModel.fromJson(json.decode(response.body), response.statusCode);
        
      } else {
        // print("chequeenqError: ${json.decode(response.body)}");
        return getsiteInModel.error("Error", resCode);
      }
    } catch (e) {
      log("chequeenqExceptiongetsitein: " + e.toString());
      return getsiteInModel.error(e.toString(), resCode);
    }
  }
}
