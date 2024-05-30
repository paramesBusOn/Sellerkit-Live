// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations, unused_import

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import 'package:sellerkit/main.dart';
import '../../Constant/ConstantSapValues.dart';
import '../../Models/VersionModel/VersionModel.dart';

class VersionApi {
  static Future<VersionModel> getData() async {
    int resCode = 500;
    log(Url.queryApi + 'SkClientPortal/GetVertion');
    try {
      // Config config = Config();
      log("ANBU::"+ConstantValues.token.toString());
       log("ANBU::"+ConstantValues.EncryptedSetup.toString());
      // await config.getSetup();
      final response = await http.get(
        Uri.parse(Url.queryApi + 'SkClientPortal/GetVertion'),
        headers: {
          "content-type": "application/json",
          "Authorization": 'bearer ' + ConstantValues.token,
          "Location": '${ConstantValues.EncryptedSetup}'
        },
      );
      resCode = response.statusCode;
      //  print(response.statusCode.toString());
      // log("Version:" + response.body.toString());
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return VersionModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        // print("Error: ${json.decode(response.body)}");
        // throw Exception("Error");
        return VersionModel.issue(resCode,json.decode(response.body) );
      }
    } catch (e) {
      print("Exception: " + e.toString());
      //  throw Exception(e.toString());
      return VersionModel.error(e.toString(), resCode);
    }
  }
}
//PUT
// http://192.168.0.162:81/api/SkClientPortal/Putvertion?id=1
// postbody
// {
//   "id": 1,
//   "content": "Auto Update Enabled",
//   "url": "https://drive.google.com/file/d/1C7Ci0vw7OakEWNzNCw_czeozpN2wwH__/view?usp=share_link",
//   "vertion": "1.1.2"
// }