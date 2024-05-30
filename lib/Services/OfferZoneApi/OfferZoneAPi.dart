import 'dart:developer';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'dart:convert';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Models/OfferZone/OfferZoneModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
// import 'package:sellerkit/main.dart';

class OfferZoneApi1 {
   Future<OfferZoneModel> getOfferZone(int? storeid) async {
    int resCode = 500;
    try {
      // log("message"+"${Url.queryApi}SkClientPortal/getAllOffers?StoreId=$storeid");
            // Config config = Config();
      // await config.getSetup();
       final response = await http.get(Uri.parse("${Url.queryApi}SkClientPortal/getAllOffers?StoreId=$storeid"),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr":
          //       "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "exec SK_GET_OFFER_ZONE  '${ConstantValues.slpcode}'"
          // })
          );

      resCode = response.statusCode;
      // print(response.statusCode.toString());
      // log("offerZone:" +response.body.toString());
      if (response.statusCode == 200) {
      //    ReceivePort port  = new ReceivePort();
      //  final islol =await Isolate.spawn<List<dynamic>>(deserialize, [port.sendPort,response.body,response.statusCode]);
      // OfferZoneModel enquiryReferral =await port.first;
      //  islol.kill(priority: Isolate.immediate);
      //  return enquiryReferral;
       return OfferZoneModel.fromJson(
            json.decode(response.body), resCode);
      } else {
      //  print("Error: ${json.decode(response.body)}");
        return OfferZoneModel.error('Error', resCode);
      }
    } catch (e) {
     log("Exception: ${e.toString()}");
      return OfferZoneModel.error(e.toString(), resCode);
    }
  }

  //      deserialize(List<dynamic> values){
  //   SendPort sendPort = values[0];
  //   String responce = values[1];
  //   int rescode = values[2];
  //   Map<String,dynamic> dataMap = jsonDecode(responce);
  //   var result = OfferZoneModel.fromJson(dataMap, rescode);
  //   sendPort.send(result);
  // }
}
