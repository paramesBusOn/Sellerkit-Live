
import 'dart:convert';
import 'dart:developer';

import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/ConstantSapValues.dart';
import 'package:sellerkit/Models/PostQueryModel/ItemMasterModelNew.dart/itemviewModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import 'package:sellerkit/main.dart';
import '../../../Constant/DataBaseConfig.dart';
class ItemViewApiNew {
   final http.Client httpClient = http.Client();
  static Future<ItemviewNewModal> getData(String itemcode) async {
    int resCode = 500;
    log("Item Master Api::"+Url.queryApi + 'Sellerkit_Flexi/v3/Getitempricestocks?ItemCode=${Uri.encodeComponent(itemcode)}&UserId=${ConstantValues.UserId}');
    log('token::'+ConstantValues.token);
 
    try {
    //    final String url = Url.queryApi + 'Sellerkit_Flexi/v2/GetAllItemList?storeId=${ConstantValues.storeid}';
    // final Uri uri = Uri.parse(url);
           final stopwatch = Stopwatch()..start();
         
          final response = await http.get(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v3/Getitempricestocks?ItemCode=${Uri.encodeComponent(itemcode)}&UserId=${ConstantValues.UserId}')
        ,
        headers: {
          "content-type": "application/json",
          "Authorization": 'bearer ' + ConstantValues.token,
          "Location":'${ConstantValues.EncryptedSetup}'
          
        },
      );
      // log('location:: ${ConstantValues.EncryptedSetup}');
      // ignore: prefer_interpolation_to_compose_strings

      resCode = response.statusCode;
      // log(response.statusCode.toString());
      log("ItemView New:"+response.body.toString());
      if (response.statusCode == 200) {
         stopwatch.stop();
            log('API response.statusCode ${stopwatch.elapsedMilliseconds} milliseconds');
 
        // ReceivePort port = ReceivePort();
        // final isolate = await Isolate.spawn<List<dynamic>>(deserializePerson,
        //     [port.sendPort, response.body, response.statusCode]);
        // final person = await port.first;
        // isolate.kill(priority: Isolate.immediate);
        // ItemMasterNewModal itemMasterData = person;
        return ItemviewNewModal.fromJson(json.decode(response.body), response.statusCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return ItemviewNewModal.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {

      log("Exception2222555: "+e.toString());
      return ItemviewNewModal.error(e.toString(), resCode);
    }
  }

  
}