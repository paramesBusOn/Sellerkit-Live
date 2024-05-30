import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/WalkinModel.dart/WalkinModel.dart';
import '../../../main.dart';

class WalkinApi {
  static Future<WalkinModal> getData(
    sapUserId,
    purposeOFVisit,
    division,
    headcount
  ) async {
    int resCode = 500;
    log("exec SK_POST_NEWWALKIN '$sapUserId','$division','$headcount''URL::${Url.queryApi + 'SkClientPortal/PostWalkins'}'");
    try {
      await config.getSetup(); final response = await http.post(Uri.parse(Url.queryApi + 'SkClientPortal/PostWalkins'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
            "id": 0,
  "slpCode": "${ConstantValues.slpcode}",
  "purposeofvisit": "$purposeOFVisit",
  "division": "$division",
  "headCount": headcount,
  "u_branch": "CHEN1",
  "visitTime": "${config.currentDate()}"
             }));
             log("bodywalkin:"+jsonEncode({
            "id": 0,
  "slpCode": "${ConstantValues.slpcode}",
  "purposeofvisit": "$purposeOFVisit",
  "division": "$division",
  "headCount": headcount,
  "u_branch": "CHEN1",
  "visitTime": "${config.currentDate()}"
             })
             );

      resCode = response.statusCode;
      log(response.statusCode.toString());
      log("responsewalkin:"+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return WalkinModal.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return WalkinModal.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return WalkinModal.error(e.toString(), resCode);
    }
  }
}
//  body: jsonEncode({
//             "constr":
//                "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
//             "query": "exec SK_POST_NEWWALKIN '${ConstantValues.slpcode}','$purposeOFVisit','$division','$headcount'"
//           })