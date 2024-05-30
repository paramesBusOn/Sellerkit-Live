// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';
import 'package:http/http.dart' as http;

import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/EnqRefferesModel.dart';
import '../../URL/LocalUrl.dart';

class EnquiryRefferesApi {
  Future<EnqRefferesModal> getData(
    sapUserId,
  ) async {
    int resCode = 500;
    // print("Url.SLUrl: ${Url.queryApi}'SellerKit'");
    // log("exec SK_GET_ENQUIRY_REFERS '$sapUserId'");
    try {
      
// Config config = Config();
      // print(Url.queryApi + 'SkClientPortal/GetallMaster?MasterTypeId=3');
      // print("token:" + ConstantValues.token);
      // await config.getSetup();
       final response = await http.get(
        Uri.parse(Url.queryApi + 'SkClientPortal/GetallMaster?MasterTypeId=3'),
        headers: {
          "content-type": "application/json",
          "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          //"cookie": 'B1SESSION='+ ConstantValues.sapSessions,
        },
        // body: jsonEncode({
        //   "constr":
        //      "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
        //   "query": "exec SK_GET_ENQUIRY_REFERS '${ConstantValues.slpcode}'"
        // })
      );

      resCode = response.statusCode;
      // print(response.statusCode.toString());
      // print("SK_GET_ENQUIRY_REFERS"+response.body.toString());
      if (response.statusCode == 200) {
        //     ReceivePort port  = new ReceivePort();
        //  final islol =await Isolate.spawn<List<dynamic>>(deserialize, [port.sendPort,response.body,response.statusCode]);
        // EnqRefferesModal enquiryReferral =await port.first;
        //  islol.kill(priority: Isolate.immediate);
        //  return enquiryReferral;
        // log("Enqreftype: ${json.decode(response.body).toString()}");
        return EnqRefferesModal.fromJson(jsonDecode(response.body), response.statusCode);
      } else {
        // log("Enqreftypeerror: ${json.decode(response.body).toString()}");
        return EnqRefferesModal.issues(jsonDecode(response.body), response.statusCode);
      }
    } catch (e) {
      log("Exceptionenqref: " + e.toString());
      return EnqRefferesModal.error(e.toString(), resCode);
    }
  }

  //     deserialize(List<dynamic> values){
  //   SendPort sendPort = values[0];
  //   String responce = values[1];
  //   int rescode = values[2];
  //   Map<String,dynamic> dataMap = jsonDecode(responce);
  //   var result = EnqRefferesModal.fromJson(dataMap, rescode);
  //   sendPort.send(result);
  // }
}
