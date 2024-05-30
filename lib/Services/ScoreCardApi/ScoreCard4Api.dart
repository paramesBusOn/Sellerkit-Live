import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'dart:convert';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Models/ScoreCardModel/ScoreCard4model.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import 'package:sellerkit/main.dart';

class ScoreCardApi4 {
  static Future<ScoreCard4Model> getScore4Data() async {
    int resCode = 500;
    try {
            Config config = Config();
          await config.getSetup();
           final response = await http.get(Uri.parse(Url.queryApi + "SkClientPortal/GET_SCORECARD_4?SlpCode=${ConstantValues.slpcode}"),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":
          //       "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec SK_GET_SCORECARD_4  '${ConstantValues.slpcode}'"
          // })
          );

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("ScoreCard4Api"+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return ScoreCard4Model.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return ScoreCard4Model.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return ScoreCard4Model.error(e.toString(), resCode);
    }
  }
}


//  body: jsonEncode({
//             "constr":
//                 "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
//             "query": "exec SK_GET_SCORECARD_4  '${ConstantValues.slpcode}'"
//           })