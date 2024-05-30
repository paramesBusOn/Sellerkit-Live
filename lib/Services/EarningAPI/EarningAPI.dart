import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../Models/EarningModel/EarningNewModel.dart';

class Earning1Api {
  static String userid = '';
  static Future<EarningNewModel1> getEarningData() async {
    int resCode = 500;
    try {
      log("message111:::"
          '${Url.queryApi}Sellerkit_Flexi/v2/GetReport_Incentive_Cur?UserId=$userid');
      Config config = Config();
      await config.getSetup();
      final response = await http.get(
        Uri.parse(
            '${Url.queryApi}Sellerkit_Flexi/v2/GetReport_Incentive_Cur?UserId=$userid'),
        headers: {
          "content-type": "application/json",
          "Authorization": 'bearer ${ConstantValues.token}',
          "Location": '${ConstantValues.EncryptedSetup}'
        },
      );
      log("Earnings1 sts ${response.statusCode.toString()}");

      resCode = response.statusCode;
      log("Earnings1Api ${response.body.toString()}");
      if (response.statusCode == 200) {
        return EarningNewModel1.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return EarningNewModel1.issue(json.decode(response.body), resCode);
      }
    } catch (e) {
      log("Exception: $e");
      return EarningNewModel1.error(e.toString(), resCode);
    }
  }
}
