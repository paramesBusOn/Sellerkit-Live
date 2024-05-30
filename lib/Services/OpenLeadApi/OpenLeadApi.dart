import 'dart:developer';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'dart:convert';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../Models/OpenLeadModel.dart/OpenLeadModel.dart';
// import 'package:sellerkit/main.dart';

class OpenLeadApi {
 static  Future<OpenLeadModel> getOfferZone() async {
    int resCode = 500;
    try {
      log("INININ");
            Config config = Config();

      await config.getSetup(); final response = await http.get(Uri.parse(Url.queryApi + 'SkClientPortal/GetOPenLeads?slpcode=${ConstantValues.slpcode}'),
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

          // log( jsonEncode({
          //   "constr":
          //       "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec [dbo].[SK_GET_OPEN_LEADS_REPORT]  '${ConstantValues.slpcode}'"
          // }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("offerZone:" + json.decode(response.body).toString());

      // log( jsonEncode({
      //       "constr":
      //           "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
      //       "query": "exec [dbo].[SK_GET_OPEN_LEADS_REPORT]  '${ConstantValues.slpcode}'"
      //     }));
      if (response.statusCode == 200) {
      //    ReceivePort port  = new ReceivePort();
      //  final islol =await Isolate.spawn<List<dynamic>>(deserialize, [port.sendPort,response.body,response.statusCode]);
      // OpenLeadModel openLead =await port.first;
      //  islol.kill(priority: Isolate.immediate);
       return OpenLeadModel.fromJson(json.decode(response.body), response.statusCode);
      } else {
      //  print("Error: ${json.decode(response.body)}");
        return OpenLeadModel.error('Error', resCode);
      }
    } catch (e) {
   //   print("Exception: $e");
      return OpenLeadModel.error(e.toString(), resCode);
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
