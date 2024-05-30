// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Models/TargetModel/TargetModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';

class GetTargetApi {
  static String? slpId;
  static Future<TargetModal> getData(
      // sapUserId,
      ) async {
    int resCode = 500;
    try {
      log("URRRRRL" +
          Url.queryApi +
          'Sellerkit_Flexi/v2/TargetReport/$slpId');
      Config config = Config();

      await config.getSetup();
      final response = await http.get(
        Uri.parse(Url.queryApi +
            'Sellerkit_Flexi/v2/TargetReport/$slpId'),
        headers: {
          "content-type": "application/json",
          "Authorization": 'bearer ${ConstantValues.token}',
          "Location": '${ConstantValues.EncryptedSetup}'
        },
      );

      resCode = response.statusCode;
      log("GETTargetRes${json.decode(response.body)}");
      if (response.statusCode == 200) {
        return TargetModal.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return TargetModal.fromJson(
            json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return TargetModal.error(e.toString(), resCode);
    }
  }
}
