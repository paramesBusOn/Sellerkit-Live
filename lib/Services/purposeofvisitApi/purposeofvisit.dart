
// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import 'package:sellerkit/main.dart';

import '../../Constant/ConstantSapValues.dart';
import '../../Models/purposeofvistModel/purposeofvisitmodel.dart';


class purposeofvisitApi {
 static  Future<purposeofvisit> getOfferZone() async {
    int resCode = 500;
    try {
      log("INININ");
        Config config = Config();
        // await config.getSetup();
        final response = await http.get(Uri.parse(Url.queryApi + 'SkClientPortal/GetallMaster?MasterTypeId=9'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":
          //       "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec [dbo].[SK_GET_OPEN_LEADS_REPORT]  '${ConstantValues.slpcode}'"
          // })
          );

          

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("purposeofvisit:" + json.decode(response.body).toString());

     
      if (response.statusCode == 200) {
     
       return purposeofvisit.fromJson(json.decode(response.body), response.statusCode);
      } else {
      //  print("Error: ${json.decode(response.body)}");
        return purposeofvisit.error('Error', resCode);
      }
    } catch (e) {
     log("Exception: ${e.toString()}");
      return purposeofvisit.error(e.toString(), resCode);
    }
  }

  //      deserialize(List<dynamic> values){
  //   SendPort sendPort = values[0];
  //   String responce = values[1];
  //   int rescode = values[2];
  //   Map<String,dynamic> dataMap = jsonDecode(responce);
  //   var result = OpenLeadModel.fromJson(dataMap, rescode);
  //   sendPort.send(result);
  // }
}