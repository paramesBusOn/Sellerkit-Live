import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'dart:convert';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Models/ScoreCardModel/ScoreCard1mode.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import 'package:sellerkit/main.dart';

class ScoreCardApi1 {
  static Future<ScoreCard1Model> getScore1Data() async {
    int resCode = 500;
    try {
      log("RERL111"+Url.queryApi + "SkClientPortal/GET_SCORECARD_1?UserId=${DataBaseConfig.userId}");
            Config config = Config();
      await config.getSetup(); 
      final response = await http.get(Uri.parse(Url.queryApi + "SkClientPortal/GET_SCORECARD_1?UserId=${DataBaseConfig.userId}"),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":
          //       "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec SK_GET_SCORECARD_1  '${ConstantValues.slpcode}'"
          // })
          );

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("ScoreCard1"+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return ScoreCard1Model.fromJson(json.decode(response.body), resCode);
      } else {
        // print("Error: ${json.decode(response.body)}");
        return ScoreCard1Model.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return ScoreCard1Model.error(e.toString(), resCode);
    }
  }
}

//  body: jsonEncode({
//             "constr":
//                 "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
//             "query": "exec SK_GET_SCORECARD_1  '${ConstantValues.slpcode}'"
//           }));
