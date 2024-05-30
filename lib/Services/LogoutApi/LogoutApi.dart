// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'package:http/http.dart' as http;
import '../../Constant/ConstantSapValues.dart';
import '../URL/LocalUrl.dart';
import 'package:sellerkit/main.dart';

class LogoutAPi {
  static Future<int> getData() async {
    int resCode = 500;
    try {
      await config.getSetup(); final response = await http.post(
        Uri.parse("${Url.SLUrl}Logout"),
        headers: {
          "Content-Type": "application/json",
          // "cookie": 'B1SESSION=' + ConstantValues.sapSessions,
        },
      );

      resCode = response.statusCode;
      print("resCode: " + resCode.toString());
      if (response.statusCode >= 200 && response.statusCode <= 205) {
        return resCode;
      } else {
        print("Error: error");
        return resCode;
      }
    } catch (e) {
      print(e.toString());
      return resCode;
    }
  }
}
