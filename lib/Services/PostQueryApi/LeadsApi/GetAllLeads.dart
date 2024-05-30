// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/GetAllLeadModel.dart';
import 'package:sellerkit/main.dart';

class GetAllLeadApi {
  static Future<GetAllLeadModal> getData(
    sapUserId,
  ) async {
    int resCode = 500;
    try {
      Config config = Config();

      log("token::" + ConstantValues.token.toString());
      log("Location::" + ConstantValues.EncryptedSetup.toString());
      log(" Location value::" + ConstantValues.headerSetup.toString());

      // log("URLL:"+);

      await config.getSetup();
      final response = await http.post(
          Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/GetAllLeads'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location": '${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
            "listtype": "summary",
            "valuetype": "name",
            "fromperiod": null,
            "toperiod": null,
            "status": null
          }));

      resCode = response.statusCode;
      // print(response.statusCode.toString());
      log("All LEADs::" + response.body.toString());
      if (response.statusCode == 200) {
        return GetAllLeadModal.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return GetAllLeadModal.error('Error', response.statusCode);
      }
    } catch (e) {
      print("Exception11: " + e.toString());
      return GetAllLeadModal.error(e.toString(), resCode);
    }
  }
}
// body: jsonEncode({
//             "constr":"Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
//             "query": "exec SK_GET_LEADS '${ConstantValues.slpcode}'"
//           })