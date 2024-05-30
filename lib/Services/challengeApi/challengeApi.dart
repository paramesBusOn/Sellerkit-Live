import 'dart:developer';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'dart:convert';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
// import 'package:sellerkit/main.dart';

import '../../Models/ChallengeModel/challengemodel.dart';

class ChallengeApi {
 static  Future<ChallengeModel> getdata() async {
    int resCode = 500;
    try {
      
      Config config = Config();
      await config.getSetup(); final response = await http.get(Uri.parse(Url.queryApi + 'SkClientPortal/Getchallenge/SlpCode?slpcode=${ConstantValues.slpcode}'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
         
          );

         
      resCode = response.statusCode;
      // print(response.statusCode.toString());
      log("chalenge:" + json.decode(response.body).toString());

      
      if (response.statusCode == 200) {
     
       return ChallengeModel.fromJson(json.decode(response.body), response.statusCode);
      } else {
       print("Error: ${json.decode(response.body)}");
        return ChallengeModel.error('Error', resCode);
      }
    } catch (e) {
     log("Exception: $e");
      return ChallengeModel.error(e.toString(), resCode);
    }
  }


}
