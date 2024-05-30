// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:sellerkit/Constant/ConstantSapValues.dart';
// import 'package:sellerkit/Services/URL/LocalUrl.dart';

// import '../../../Models/SerViceLayerModel/ItemMasterModel.dart/ItemMasterModel.dart';

// class ItemMasterApi {
//   static Future<ItemModal> getData(String url) async {
//     int resCode = 500;
//     print("Url.SLUrl: ${Url.SLUrl}");
//     try {
//       await config.getSetup(); final response = await http.get(

//         Uri.parse(Url.SLUrl+ url
//         //"Itemss?\$select=ItemCode, ItemName,U_Category,U_Brand,U_Division,U_Segment"
//         ),
//          headers: {
//         "content-type": "application/json",
//         "cookie": 'B1SESSION='+ ConstantValues.sapSessions,
//         },
//         );
//       resCode = response.statusCode;
//       if (response.statusCode == 200) {
//         // print(response.statusCode.toString());
//         // print(json.decode(response.body));
//         Map data = json.decode(response.body);
//         if(data["responce"]!= null){
//          // print(data["responce"]);   
//          // print( json.decode(data["responce"]));
//      }
//         return ItemModal.fromJson(json.decode(response.body), resCode);
//       } else {
//         print("Error: ${json.decode(response.body)}");
//         return ItemModal.issue(json.decode(response.body),resCode);
//       }
//     } catch (e) {
//       print("Exception: "+e.toString());
//       return ItemModal.exception(e.toString(),resCode);
//     }
//   }


// }
