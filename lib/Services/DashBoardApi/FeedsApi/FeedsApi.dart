// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/FeedsModel/FeedsModel.dart';

class FeedsApi {
  static Future<FeedsModal> getData(
    sapUserId,
  ) async {
    int resCode = 500;
    try {
      Config config = Config();
      log("URLLLLL"+Url.queryApi + 'SkClientPortal/GetfeedbyId?UserId=${DataBaseConfig.userId}');
      await config.getSetup(); 
      final response = await http.get(Uri.parse(Url.queryApi + 'SkClientPortal/GetfeedbyId?UserId=${DataBaseConfig.userId}'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec SK_GET_FEEDS_LIST '${ConstantValues.slpcode}'"
          // })
          );

          // log(jsonEncode({
          //   "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec SK_GET_FEEDS_LIST '${ConstantValues.sapUserID}'"
          // }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("Feeds: "+response.body.toString());
      if (response.statusCode == 200) {
        return FeedsModal.fromJson(
            json.decode(response.body), resCode);
      } else {
       print("ErrorExceptionFEED: ${json.decode(response.body)}");
        return FeedsModal.error('Error', resCode);
        //throw Exception();
      }
    } catch (e) {
     log("ExceptionFEED: " + e.toString());
      return FeedsModal.error(e.toString(), resCode);
     // throw Exception(e.toString());
    }
  }
}


// body: jsonEncode({
//             "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
//             "query": "exec SK_GET_FEEDS_LIST '${ConstantValues.slpcode}'"
//           })