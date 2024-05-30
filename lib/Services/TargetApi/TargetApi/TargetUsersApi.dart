// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/TargetModel/TargetUsersModel.dart';

class GetTargetUsersApi {
  static Future<TargetUserModal> getData(
      // sapUserId,
      ) async {
    int resCode = 500;
    try {
      // http://91.203.133.224:81/api/Sellerkit_Flexi/v2/GetUserAuthReport?UserId=21
      log("URRRRRL:: " +
          Url.queryApi +
          'Sellerkit_Flexi/v2/GetUserAuthReport?UserId=${ConstantValues.UserId}');
      Config config = Config();

      await config.getSetup();
      final response = await http.post(
        Uri.parse(Url.queryApi +
            'Sellerkit_Flexi/v2/GetUserAuthReport?UserId=${ConstantValues.UserId}'),
        headers: {
          "content-type": "application/json",
          "Authorization": 'bearer ${ConstantValues.token}',
          "Location": '${ConstantValues.EncryptedSetup}'
        },
      );

      resCode = response.statusCode;
      log("GETTargetUsersRes code${response.statusCode}");

      // log("GETTargetUsersRes${json.decode(response.body)}");
      if (response.statusCode == 200) {
        return TargetUserModal.fromJson(json.decode(response.body), resCode);
      } else {
        log("Error: ${json.decode(response.body)}");
        return TargetUserModal.error('Error', resCode);
      }
    } catch (e) {
      log("Exception: " + e.toString());
      return TargetUserModal.error(e.toString(), resCode);
    }
  }
}
