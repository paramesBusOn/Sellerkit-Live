import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Models/leadexmodel/cameasmodel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/ResonModel.dart';

class CameAsApi {
  static Future<CameAsModal> getData(
    sapUserID,
  ) async {
    int resCode = 500;
    try {
      
Config config = Config();
      log("URL:"+Url.queryApi+'SkClientPortal/GetallMaster?MasterTypeId=13');
      await config.getSetup(); final response = await http.get(Uri.parse(Url.queryApi+'SkClientPortal/GetallMaster?MasterTypeId=13'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer '+ ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
         
          );

      resCode = response.statusCode;
      // print(response.statusCode.toString());
      
      if (response.statusCode == 200) {
        log("ResonApi:"+json.decode(response.body).toString());
      
        return CameAsModal.fromJson(
            json.decode(response.body), resCode);
      } else {
        log("Errorreson: ${json.decode(response.body).toString()}");
        return CameAsModal.error('Error', resCode);
      }
    } catch (e) {
      print("Exception1: " + e.toString());
      return CameAsModal.error(e.toString(), resCode);
    }
  }
}
