// ignore_for_file: unnecessary_new

import 'dart:developer';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'dart:convert';
import 'package:sellerkit/Constant/DataBaseConfig.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../Models/MenuAuthModel/MenuAuthModel.dart';
// import 'package:sellerkit/main.dart';

class MenuAuthApi {
   Future<MenuAuthModel> getOfferZone() async {
    int resCode = 500;
    try {
            // Config config = Config();
            // await config.getSetup(); 
            print("Menu Auth::"+"${Url.queryApi}SkClientPortal/GetMenuAuth?UserId=${ConstantValues.UserId}");
            final response = await http.get(Uri.parse("${Url.queryApi}SkClientPortal/GetMenuAuth?UserId=${ConstantValues.UserId}"),
          headers: {
            "content-type": "application/json",
             "Authorization": 'bearer ' + ConstantValues.token,
             "Location":'${ConstantValues.EncryptedSetup}'
          },
          // body: jsonEncode({
          //   "constr": "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
          //   "query": "EXEC [SK_COMMON].[dbo].[SK_MENU_AUTH] '${ConstantValues.userNamePM}'"
          // })
          );

          // log('datatata:  "query": "EXEC [SK_COMMON].[dbo].[SK_MENU_AUTH] "${ConstantValues.userNamePM}"');

      resCode = response.statusCode;
      // print("Menu Auth::"+response.body.toString());
      // log("MenuAuth:" + json.decode( response.body).toString());
      if (response.statusCode == 200) {
      //    ReceivePort port  = new ReceivePort();
      //  final islol =await Isolate.spawn<List<dynamic>>(deserialize, [port.sendPort,response.body,response.statusCode]);
      // MenuAuthModel menuAuth =await port.first;
      //  islol.kill(priority: Isolate.immediate);
       return MenuAuthModel.fromJson(json.decode(response.body), response.statusCode);
      } else {
      //  print("Error: ${json.decode(response.body)}");
        return MenuAuthModel.error('Error', resCode);
      }
    } catch (e) {
     print("Exception: $e");
      return MenuAuthModel.error(e.toString(), resCode);
    }
  }

  //      deserialize(List<dynamic> values){
  //   SendPort sendPort = values[0];
  //   String responce = values[1];
  //   int rescode = values[2];
  //   Map<String,dynamic> dataMap = jsonDecode(responce);
  //   var result = MenuAuthModel.fromJson(dataMap, rescode);
  //   sendPort.send(result);
  // }
}
