import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Models/leadexmodel/agemodel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/ResonModel.dart';

class AgeApi {
  static Future<AgeModal> getData(
    sapUserID,
  ) async {
    int resCode = 500;
    try {
      
Config config = Config();
      log("URL:"+Url.queryApi+'SkClientPortal/GetallMaster?MasterTypeId=12');
      await config.getSetup(); final response = await http.get(Uri.parse(Url.queryApi+'SkClientPortal/GetallMaster?MasterTypeId=12'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer '+ ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":
          //      "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec SK_GET_ENQUIRY_UPDATE_STATUS_LIST '${ConstantValues.slpcode}'"
          // })
          );

      resCode = response.statusCode;
      // print(response.statusCode.toString());
      
      if (response.statusCode == 200) {
        // log("ResonAgeApi:"+json.decode(response.body).toString());
        // Map data = json.decode(response.body);
        return AgeModal.fromJson(
            json.decode(response.body), resCode);
      } else {
        log("Errorreson: ${json.decode(response.body).toString()}");
        return AgeModal.error('Error', resCode);
      }
    } catch (e) {
      print("Exception1: " + e.toString());
      return AgeModal.error(e.toString(), resCode);
    }
  }
}
