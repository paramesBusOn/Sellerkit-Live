import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'dart:convert';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Models/ScoreCardModel/ScoreCard2Model.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import 'package:sellerkit/main.dart';

class ScoreCardApi2 {
  static Future<ScoreCard2Model> getScore2Data() async {
    int resCode = 500;
    try {
      log("RERL"+Url.queryApi + "SkClientPortal/GET_SCORECARD_2?slpCode=${ConstantValues.slpcode}");
            Config config = Config();
      await config.getSetup();
       final response = await http.get(Uri.parse(Url.queryApi + "SkClientPortal/GET_SCORECARD_2?slpCode=${ConstantValues.slpcode}"),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":
          //       "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec SK_GET_SCORECARD_2  '${ConstantValues.slpcode}'"
          // })
          );

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("ScoreCard2Api"+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return ScoreCard2Model.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return ScoreCard2Model.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return ScoreCard2Model.error(e.toString(), resCode);
    }
  }
}


// body: jsonEncode({
//             "constr":
//                 "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
//             "query": "exec SK_GET_SCORECARD_2  '${ConstantValues.slpcode}'"
//           }));