// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/configModel/getconfigmodel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Constant/ConstantSapValues.dart';

class GetconfigApi {
  static Future<GetconfigModal> getData(
    sapUserId,
  ) async {
    int resCode = 500;
    try {
      
// Config config = Config();
      // print(Url.queryApi + 'SkClientPortal/GetallMaster?MasterTypeId=2');
      // print("token:"+ConstantValues.token);
      // await config.getSetup();
       final response = await http.get(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v3/GetConfig'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
            //"cookie": 'B1SESSION='+ ConstantValues.sapSessions,
          },
          
          );

      resCode = response.statusCode;
      // print(response.statusCode.toString());
      log("Enquiry Type"+response.body.toString());
      if (response.statusCode == 200) {
      
        return GetconfigModal.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        print("GetconfigApi: ${json.decode(response.body)}");
        return GetconfigModal.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
     print("GetconfigApiExc: " + e.toString());
      return GetconfigModal.error(e.toString(), resCode);
    }
  }

  //   deserialize(List<dynamic> values){
  //   SendPort sendPort = values[0];
  //   String responce = values[1];
  //   int rescode = values[2];
  //   Map<String,dynamic> dataMap = jsonDecode(responce);
  //   var result = EnquiryTypeModal.fromJson(dataMap, rescode);
  //   sendPort.send(result);
  // }
}
