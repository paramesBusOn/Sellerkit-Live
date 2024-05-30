import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'dart:convert';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Models/ScoreCardModel/ScoreCard3Model.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import 'package:sellerkit/main.dart';

class ScoreCardApi3 {
  static Future<ScoreCard3Model> getScore2Data() async {
    int resCode = 500;
    try {
      Config config = Config();
      await config.getSetup();
      final response = await http.get(
        Uri.parse(Url.queryApi +
            "SkClientPortal/GET_SCORECARD_3?UserId=${DataBaseConfig.userId}"),
        headers: {
          "content-type": "application/json",
          "Authorization": 'bearer ' + ConstantValues.token,
          "Location": '${ConstantValues.EncryptedSetup}'
        },
        // body: jsonEncode({
        //   "constr":
        //       "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
        //   "query": "exec SK_GET_SCORECARD_3  '${ConstantValues.slpcode}'"
        // })
      );

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("ScoreCard3Api" + json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return ScoreCard3Model.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return ScoreCard3Model.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return ScoreCard3Model.error(e.toString(), resCode);
    }
  }
}

  // body: jsonEncode({
  //           "constr":
  //               "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
  //           "query": "exec SK_GET_SCORECARD_3  '${ConstantValues.slpcode}'"
  //         })