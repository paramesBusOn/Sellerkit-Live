// // ignore_for_file: prefer_interpolation_to_compose_strings, duplicate_ignore

// import 'dart:convert';
// import 'dart:developer';

// import 'dart:isolate';
// import 'package:http/http.dart' as http;
// import 'package:sellerkit/Constant/constant_sapvalues.dart';

// import 'package:sellerkit/Services/URL/LocalUrl.dart';
// import 'package:sellerkit/main.dart';
// import '../../../Constant/DataBaseConfig.dart';
// import '../../../Models/PostQueryModel/ItemMasterModelNew.dart/ItemMasterNewModel.dart';

// class ItemMasterApiNew {
//   final http.Client httpClient = http.Client();
//   Future<ItemMasterNewModal> getData() async {
//     int resCode = 500;
//     log("Item Master Api::"+Url.queryApi + 'Sellerkit_Flexi/v2/GetallitembyUser?UserId=${DataBaseConfig.userId}');
//     log('token::'+ConstantValues.token);
 
//     try {
//       final String url = Url.queryApi + 'Sellerkit_Flexi/v2/GetallitembyUser?UserId=${DataBaseConfig.userId}';
//     final Uri uri = Uri.parse(url);
//            final stopwatch = Stopwatch()..start();
//           //  log("STAT:response.statusCode");
//           //  var url=Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/GetAllItemList?storeId=${ConstantValues.storeid}');
//           // await config.getSetup(); 
//           // final httppp=http.Client();
//           final http.Response response = await httpClient.get(uri,
//         headers: {
//           "content-type": "application/json",
//           "Authorization": 'bearer ' + ConstantValues.token,
//           "Location":'${ConstantValues.EncryptedSetup}'
          
//         },
//       );
     

//       resCode = response.statusCode;
//       // log(response.statusCode.toString());
//       // log("ItemMAster New:"+response.body.toString());
//       if (response.statusCode == 200) {
//          stopwatch.stop();
//             log('API response.statusCode ${stopwatch.elapsedMilliseconds} milliseconds');
 
//         return ItemMasterNewModal.fromJson(json.decode(response.body), response.statusCode);
//       } else {
//         print("Error: ${json.decode(response.body)}");
//         return ItemMasterNewModal.issues(json.decode(response.body), response.statusCode);
//       }
//     } catch (e) {

//       log("Exception2222555: "+e.toString());
//       return ItemMasterNewModal.error(e.toString(), resCode);
//     }
//   }

//   // void deserializePerson(List<dynamic> values) {
//   //   SendPort sendPort = values[0];
//   //   String responce = values[1]; //its hold the responce
//   //   //log("data:: "+ data.toString());//check this
//   //   //print("Data: "+data);
//   //   int statusCode = values[2];
//   //   // print("stttt: " + statusCode.toString());
//   //   Map<String, dynamic> dataMap = jsonDecode(responce.toString());
//   //   var datas = ItemMasterNewModal.fromJson(dataMap, statusCode);
//   //   sendPort.send(datas);
//   // }
// }


//textfile 

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/constant_sapvalues.dart';

import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Models/PostQueryModel/ItemMasterModelNew.dart/ItemMasterNewModel.dart';

class ItemMasterApiNew {
   final http.Client httpClient = http.Client();
  Future<ItemMasterNewModal> getData() async {
    int resCode = 500;
    log("Item Master Api::"+Url.queryApi + 'Sellerkit_Flexi/v2/Getallitemlistfile?storeId=${ConstantValues.storeid}');
    log('token::'+ConstantValues.token);
 
    try {
    //    final String url = Url.queryApi + 'Sellerkit_Flexi/v2/GetAllItemList?storeId=${ConstantValues.storeid}';
    // final Uri uri = Uri.parse(url);
           final stopwatch = Stopwatch()..start();
         
          final  response = await http.get(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/Getallitemlistfile?StoreId=${ConstantValues.storeid}')
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
      // log("ItemMAster New:"+response.body.toString());
      if (response.statusCode == 200) {
           String csvData = response.body;
       List<dynamic> responcedata = await jsonconvertexample(response.body);
      //  log("responcedata::"+responcedata.toString());
         stopwatch.stop();
            log('API response.statusCode ${stopwatch.elapsedMilliseconds} milliseconds');
 ConstantValues.ItemMasApi =stopwatch.elapsedMilliseconds.toString();
        // ReceivePort port = ReceivePort();
        // final isolate = await Isolate.spawn<List<dynamic>>(deserializePerson,
        //     [port.sendPort, response.body, response.statusCode]);
        // final person = await port.first;
        // isolate.kill(priority: Isolate.immediate);
        // ItemMasterNewModal itemMasterData = person;
        return ItemMasterNewModal.fromJson(responcedata, response.statusCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return ItemMasterNewModal.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {

      log("Exception2222555item: "+e.toString());
      return ItemMasterNewModal.error(e.toString(), resCode);
    }
  }

  static List<Map<String, dynamic>> jsonconvertexample(String tabularData) {
    // tabularData = tabularData.replaceAll('\u00A0', ' '); 
    // tabularData = tabularData.replaceAll(RegExp(r'[^\x00-\x7F]'), '');
  List<String> lines = tabularData.split('\n');
  List<String> headers = lines[0].split('\t');

  List<Map<String, dynamic>> jsonList = [];
  
  for (int i = 1; i < lines.length; i++) {
    List<String> values = lines[i].split('\t');
    if (values.length == headers.length) {
      Map<String, dynamic> jsonItem = {};
      for (int j = 0; j < headers.length; j++) {
        jsonItem[headers[j]] =  values[j];
        // values[j].contains('.') ? double.tryParse(values[j]) ?? values[j] :
      }
      jsonList.add(jsonItem);
    }
  }
  // log("jsonList::"+jsonList.toString());
  return jsonList;
}
}




//old itemMaster by store id
// ignore_for_file: prefer_interpolation_to_compose_strings, duplicate_ignore

// import 'dart:convert';
// import 'dart:developer';

// import 'package:http/http.dart' as http;
// import 'package:sellerkit/Constant/constant_sapvalues.dart';

// import 'package:sellerkit/Services/URL/LocalUrl.dart';
// import '../../../Models/PostQueryModel/ItemMasterModelNew.dart/ItemMasterNewModel.dart';

// class ItemMasterApiNew {
//    final http.Client httpClient = http.Client();
//   Future<ItemMasterNewModal> getData() async {
//     int resCode = 500;
//     log("Item Master Api::"+Url.queryApi + 'Sellerkit_Flexi/v2/GetAllItemList?storeId=${ConstantValues.storeid}');
//     log('token::'+ConstantValues.token);
 
//     try {
//     //    final String url = Url.queryApi + 'Sellerkit_Flexi/v2/GetAllItemList?storeId=${ConstantValues.storeid}';
//     // final Uri uri = Uri.parse(url);
//            final stopwatch = Stopwatch()..start();
         
//           final  response = await http.get(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/GetAllItemList?storeId=${ConstantValues.storeid}')
//         ,
//         headers: {
//           "content-type": "application/json",
//           "Authorization": 'bearer ' + ConstantValues.token,
//           "Location":'${ConstantValues.EncryptedSetup}'
          
//         },
//       );
//       // log('location:: ${ConstantValues.EncryptedSetup}');
//       // ignore: prefer_interpolation_to_compose_strings

//       resCode = response.statusCode;
//       // log(response.statusCode.toString());
//       // log("ItemMAster New:"+response.body.toString());
//       if (response.statusCode == 200) {
//          stopwatch.stop();
//             log('API response.statusCode ${stopwatch.elapsedMilliseconds} milliseconds');
//  ConstantValues.ItemMasApi =stopwatch.elapsedMilliseconds.toString();
//         // ReceivePort port = ReceivePort();
//         // final isolate = await Isolate.spawn<List<dynamic>>(deserializePerson,
//         //     [port.sendPort, response.body, response.statusCode]);
//         // final person = await port.first;
//         // isolate.kill(priority: Isolate.immediate);
//         // ItemMasterNewModal itemMasterData = person;
//         return ItemMasterNewModal.fromJson(json.decode(response.body), response.statusCode);
//       } else {
//         print("Error: ${json.decode(response.body)}");
//         return ItemMasterNewModal.issues(json.decode(response.body), response.statusCode);
//       }
//     } catch (e) {

//       log("Exception2222555: "+e.toString());
//       return ItemMasterNewModal.error(e.toString(), resCode);
//     }
//   }

  
// }
