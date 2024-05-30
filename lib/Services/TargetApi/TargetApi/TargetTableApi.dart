import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Models/TargetModel/TargetTableModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import 'package:sellerkit/main.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/GetAllLeadModel.dart';

class GetTargetTableApi {
  static Future<TargetTableModal> getData(
      // sapUserId,
      ) async {
    int resCode = 500;
    try {
      log("URLLS"+Url.queryApi + 'SkClientPortal/GetTargetTab1?SlpCode=${ConstantValues.slpcode}');
            Config config = Config();
      await config.getSetup(); final response = await http.get(Uri.parse(Url.queryApi + 'SkClientPortal/GetTargetTab1?SlpCode=${ConstantValues.slpcode}'),
          // ('http://164.52.214.147:47182/api/SellerKit'),

          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":
          //       "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query":
          //       "Exec SK_GET_SALES_TARGET_TABLE1 '${ConstantValues.slpcode}'",
          // })
          );

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("Targettable: " + json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return TargetTableModal.fromJson(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return TargetTableModal.error('Error', resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return TargetTableModal.error(e.toString(), resCode);
    }
  }
}
