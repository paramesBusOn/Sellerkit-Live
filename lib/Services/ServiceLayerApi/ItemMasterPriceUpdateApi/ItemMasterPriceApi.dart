// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:sellerkit/Constant/ConstantSapValues.dart';
// import 'package:sellerkit/Services/URL/LocalUrl.dart';

// import '../../../Models/SerViceLayerModel/ItemMasterModel.dart/ItemMasterModel.dart';
// import '../../../Models/SerViceLayerModel/ItemMasterPriceUpdateModel/ItemMasterPriceUpdate.dart';

// class ItemMasterPriceUpdateApi {
//   static Future<ItemMasterPriceUpdateModal> getData(String Itemcode) async {
//     int resCode = 500;
//     print("Url.SLUrl: ${Url.SLUrl}");
//     try {
//       await config.getSetup(); final response = await http.get(

//         Uri.parse(Url.SLUrl+"Items('$Itemcode')?\$select=ItemCode,%20ItemName,U_Category,U_Brand,U_Division,U_Segment,Properties1,ItemPrices"
//         //"Itemss?\$select=ItemCode, ItemName,U_Category,U_Brand,U_Division,U_Segment"
//         ),
//          headers: {
//         "content-type": "application/json",
//         "cookie": 'B1SESSION='+ ConstantValues.sapSessions,
//         },
//         );
//       resCode = response.statusCode;
//         print(response.statusCode.toString());
//         print(json.decode(response.body));
//       if (response.statusCode == 200) {
//         // print(response.statusCode.toString());
//         // print(json.decode(response.body));
//         Map data = json.decode(response.body);
//         //if(data["responce"]!= null){
//          // print(data["responce"]);   
//          // print( json.decode(data["responce"]));
//   //   }
//         return ItemMasterPriceUpdateModal.fromJson(json.decode(response.body), resCode);
//       } else {
//         print("Error: ${json.decode(response.body)}");
//         return ItemMasterPriceUpdateModal.issue(json.decode(response.body),resCode);
//       }
//     } catch (e) {
//       print("Exception: "+e.toString());
//       return ItemMasterPriceUpdateModal.exception(e.toString(),resCode);
//     }
//   }
// }
