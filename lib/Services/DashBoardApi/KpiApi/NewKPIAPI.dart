// ignore_for_file: unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/KpiModel/KpiModelList.dart';
import '../../URL/LocalUrl.dart';
// import 'package:sellerkit/main.dart';

class NewKpiApi {
  // static String? deviceId;
  static Future<KpiModel> sampleDetails() async {
    try {
      //91.203.133.224:81/api/Sellerkit_Flexi/v2/LOADKPI?UserId=14&widgetcode=all
      log("KPIURL::" +
          Url.queryApi +
          "Sellerkit_Flexi/v2/LOADKPI?UserId=${ConstantValues.UserId}&widgetcode=all");
      Config config = Config();
      // await config.getSetup();
      final response = await http.post(
        Uri.parse(Url.queryApi +
            "Sellerkit_Flexi/v2/LOADKPI?UserId=${ConstantValues.UserId}&widgetcode=all"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'bearer ' + ConstantValues.token,
          "Location": '${ConstantValues.EncryptedSetup}'
        },
        // body: jsonEncode({
        //   "constr": "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
        //   "query": "EXEC SK_DASHBOARD_KPI '${ConstantValues.slpcode}'"
        // })
      );
      log("KPIRES:::" + response.statusCode.toString());

      log("KPIRES:::" + json.decode(response.body).toString());
      if (response.statusCode == 200) {
        //  print(json.decode(response.body));
        return KpiModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        //  throw Exception("Error");
        print("ERRORRRRR");
        return KpiModel.issue(response.statusCode, '');
      }
    } catch (e) {
      log("ExceptionKPI" + e.toString());
      //  throw Exception(e.toString());
      return KpiModel.issue(500, '${e.toString()}');
    }
  }
}
