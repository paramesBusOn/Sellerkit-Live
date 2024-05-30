// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'dart:convert';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Models/NewProfileModel/ProfileUpdate1Model.dart';
import 'package:sellerkit/Models/NewProfileModel/ProfileUpdate2Model.dart';
// import 'package:sellerkit/main.dart';

class ProfileUpdateApi2 {
  static Future<ProfileUpdateModel2> getProfileUpdate2Data(
      String setfilepath) async {
    int resCode = 500;
    try {
            Config config = Config();

      await config.getSetup(); final response = await http.post(
          Uri.parse("http://216.48.186.108:19979/api/SellerKit"),

          // Url.queryApi + 'SellerKit'),

          headers: {
            "content-type": "application/json",
          },
          body: jsonEncode({
            "constr":
                "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
            "query":
                "exec SK_SET_PROFILE_PIC_PATH '${ConstantValues.slpcode}', '$setfilepath${ConstantValues.slpcode}.png'"
          }));
// ${ConstantValues.slpcode}
// sk_chn1_1
      resCode = response.statusCode;
      print(response.statusCode.toString());
      print("SK_SET_PROFILE_PIC_PATH: " + json.decode(response.body));
      // print("setfilepath:" '${setfilepath} ${ConstantValues.sapUserID}.png');
      print(
          "exec SK_SET_PROFILE_PIC_PATH '${ConstantValues.slpcode}', '${setfilepath}${ConstantValues.slpcode}.png'");
      if (response.statusCode == 200) {
        return ProfileUpdateModel2.fromJson(
            json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return ProfileUpdateModel2.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return ProfileUpdateModel2.error(e.toString(), resCode);
    }
  }
}
