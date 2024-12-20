// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'dart:developer';

import 'package:sellerkit/Constant/constant_sapvalues.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/EnqTypeModel.dart';

class EnquiryTypeApi {
   Future<EnquiryTypeModal> getData(
    sapUserId,
  ) async {
    int resCode = 500;
    try {
      
// Config config = Config();
      // print(Url.queryApi + 'SkClientPortal/GetallMaster?MasterTypeId=2');
      // print("token:"+ConstantValues.token);
      // await config.getSetup();
       final stopwatch = Stopwatch()..start();
       final response = await http.get(Uri.parse(Url.queryApi + 'SkClientPortal/GetallMaster?MasterTypeId=2'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
            //"cookie": 'B1SESSION='+ ConstantValues.sapSessions,
          },
          // body: jsonEncode({
          //   "constr":
          //       "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec SK_GET_ENQUIRY_TYPE '${ConstantValues.slpcode}'"
          // })
          );

      resCode = response.statusCode;
      // print(response.statusCode.toString());
      // print("Enquiry Type"+response.body.toString());
      if (response.statusCode == 200) {
          stopwatch.stop();
    log('DB enquiryTypeApi ${stopwatch.elapsedMilliseconds} milliseconds');
    ConstantValues.enquiryTypeApi =stopwatch.elapsedMilliseconds.toString();
      //  ReceivePort port  = new ReceivePort();
      //  final islol =await Isolate.spawn<List<dynamic>>(deserialize, [port.sendPort,response.body,response.statusCode]);
      // EnquiryTypeModal enquiryTypeModal =await port.first;
      //  islol.kill(priority: Isolate.immediate);
      //  return enquiryTypeModal;
        return EnquiryTypeModal.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return EnquiryTypeModal.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
     print("Exception: " + e.toString());
      return EnquiryTypeModal.error(e.toString(), resCode);
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
