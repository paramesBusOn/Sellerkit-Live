// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/EnquiriesModel.dart';

class EnquiryApi {
  static Future<EnquiriesModal> getData(sapUserId,) async {
    int resCode = 500;
  //  print("Url.SLUrl: ${Url.queryApi}'SellerKit'");
  // log("exec sk_sp_inventory_master '$sapUserId'");
  
    try {
      
Config config = Config();
log("AANBHU"+ConstantValues.token);
      log("EnqApiUrl:"+ConstantValues.EncryptedSetup.toString());
      await config.getSetup(); 
      final response = await http.post(Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/GetAllEnquiries'),
          headers: {
              "content-type": "application/json",
             "Authorization": 'bearer '+ ConstantValues.token,
             "Location":'${ConstantValues.EncryptedSetup}'
            //"cookie": 'B1SESSION='+ ConstantValues.sapSessions,
          },
          body: jsonEncode({
           
    "listtype": "summary",
    "valuetype": "name",
    "fromperiod": null,
    "toperiod": null,
    "status": null

          })
          );

      resCode = response.statusCode;
      
      log("EnqApires:"+response.body.toString());
      log("EnqApires2222:"+json.decode(response.body).toString());
      if (response.statusCode == 200) {
        // log("stcode"+response.statusCode.toString());
        
        return EnquiriesModal.fromJson(
            json.decode(response.body),response.statusCode);
      } else {
        // log("Error: ${json.decode(response.body).toString()}");
        return EnquiriesModal.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("Exception222: " + e.toString());
      return EnquiriesModal.error(e.toString(), resCode);
    }
  }
}

//old code

// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:sellerkit/Constant/Configuration.dart';
// import 'package:sellerkit/Services/URL/LocalUrl.dart';
// import '../../../Constant/ConstantSapValues.dart';
// import '../../../Models/PostQueryModel/EnquiriesModel/EnquiriesModel.dart';

// class EnquiryApi {
//   static Future<EnquiriesModal> getData(sapUserId,) async {
//     int resCode = 500;
//   //  print("Url.SLUrl: ${Url.queryApi}'SellerKit'");
//   // log("exec sk_sp_inventory_master '$sapUserId'");
  
//     try {
      
// Config config = Config();
// log("AANBHU"+ConstantValues.token);
//       log("EnqApiUrl:"+Url.queryApi + 'SkClientPortal/Getallenquiry?slpcode=$sapUserId');
//       await config.getSetup(); 
//       final response = await http.get(Uri.parse(Url.queryApi + 'SkClientPortal/Getallenquiry?slpcode=$sapUserId'),
//           headers: {
//               "content-type": "application/json",
//              "Authorization": 'bearer '+ ConstantValues.token,
//              "Location":'${ConstantValues.EncryptedSetup}'
//             //"cookie": 'B1SESSION='+ ConstantValues.sapSessions,
//           },
//           // body: jsonEncode({
//           //   "constr":
//           //     "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
//           //   "query": "exec sk_get_enquiries '${ConstantValues.slpcode}'"
//           // })
//           );

//       resCode = response.statusCode;
      
//       log("EnqApires:"+response.body.toString());
//       if (response.statusCode == 200) {
//         log("stcode"+response.statusCode.toString());
//         // print(json.decode(response.body));
//         // Map data = json.decode(response.body);
//         // if(data["responce"]!= null){
//         // print(data["responce"]);
//         // print( json.decode(data["responce"]));
//         // }
//         return EnquiriesModal.fromJson(
//             json.decode(response.body),response.statusCode);
//       } else {
//         log("Error: ${json.decode(response.body).toString()}");
//         return EnquiriesModal.error('Error', response.statusCode);
//       }
//     } catch (e) {
//       log("Exception: " + e.toString());
//       return EnquiriesModal.error(e.toString(), resCode);
//     }
//   }
// }
