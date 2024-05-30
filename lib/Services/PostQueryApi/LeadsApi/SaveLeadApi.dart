// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_new

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Models/PostQueryModel/LeadsCheckListModel/LeadSavePostModel/LeadSavePostModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
// import 'package:sellerkit/main.dart';

class LeadSavePostApi {
  static Future<LeadSavePostModal> getData(sapUserId, PostLead postLead) async {
    int resCode = 500;
    // log(Url.queryApi + 'SkClientPortal/Postlead'+ " .. ${ConstantValues.sapSessions} save lead api");
    try {
            Config config = Config();
      await config.getSetup(); 
      final response = await http.post(Uri.parse(Url.queryApi + 'SkClientPortal/Postlead'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode(postLead.tojson()));
        print("Encode savelead:"+jsonEncode(postLead.tojson()));
      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("REsleadPost:"+json.decode(response.body).toString());
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return LeadSavePostModal.fromJson(json.decode(response.body), response.statusCode);
        // return resCode;
      } else {
        //return resCode;
        print("Error: ${json.decode(response.body)}");
        return LeadSavePostModal.issue(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception111: " + e.toString());
      // return resCode;
      return LeadSavePostModal.error(e.toString(), resCode);
    }
  }

  static printData(PostLead postLead) {
    log(jsonEncode(postLead.tojson()));
  }
}




// class LeadSavePostApi {
//   static Future<LeadSavePostModal> getData(sapUserId, PostLead postLead) async {
//     int resCode = 500;
//     log(Url.SLUrl + 'Quotations' + " .. ${ConstantValues.sapSessions} save lead api");
//     try {
//       await config.getSetup(); final response = await http.post(Uri.parse(Url.SLUrl + 'Quotations'),
//           headers: {
//             "content-type": "application/json",
//             "cookie": 'B1SESSION=' + ConstantValues.sapSessions,
//           },
//           body: jsonEncode(postLead.tojson()));
//         log(jsonEncode(postLead.tojson()));
//       resCode = response.statusCode;
//       print(response.statusCode.toString());
//       log(json.decode(response.body).toString());
//       if (response.statusCode >= 200 && response.statusCode <= 210) {
//         return LeadSavePostModal.fromJson(json.decode(response.body.toString()), resCode);
//         // return resCode;
//       } else {
//         //return resCode;
//         print("Error: ${json.decode(response.body)}");
//         return LeadSavePostModal.issue(json.decode(response.body), resCode);
//       }
//     } catch (e) {
//       print("Exception: " + e.toString());
//       // return resCode;
//       return LeadSavePostModal.error(e.toString(), resCode);
//     }
//   }

//   static printData(PostLead postLead) {
//     log(jsonEncode(postLead.tojson()));
//   }
// }
