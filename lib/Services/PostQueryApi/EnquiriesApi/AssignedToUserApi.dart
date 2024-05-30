// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/LoginApi/LoginApi.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Constant/DataBaseConfig.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/AssignedToUserModel.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/EnquiriesModel.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/ResonModel.dart';
import '../../../main.dart';

class AssignedToUserApi {
  static Future<AssignedToUserModal> getData(
      EnquiriesData enqdata, userKey,String update) async {
    int resCode = 500;
    try {
      log("UserKey:" + Url.queryApi + 'Sellerkit_Flexi/v2/EnquiryForward');
      await config.getSetup();
      final response = await http.post(
          Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/EnquiryForward'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location": '${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
            "enquiryid": enqdata.EnqID,
            "forwardto": userKey,
            "status": "$update",
            "lokkingfor": "${enqdata.Lookingfor}",
            "forwardremarks": "test",
            "followupdate": "${enqdata.Followup}",
            "visitrequiredon":enqdata.visitTime ==null||enqdata.visitTime =="null"||enqdata.visitTime!.isEmpty? null:"${enqdata.visitTime}"
          }));

      log("Forward: " +
          jsonEncode({
           "enquiryid": enqdata.EnqID,
            "forwardto": userKey,
            "status": "$update",
            "lokkingfor": "${enqdata.Lookingfor}",
            "forwardremarks": "test",
            "followupdate": "${enqdata.Followup}",
            "visitrequiredon":enqdata.visitTime ==null||enqdata.visitTime =="null"||enqdata.visitTime!.isEmpty? null:"${enqdata.visitTime}"
         
          }).toString());

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("FORwARDres" + json.decode(response.body).toString());
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return AssignedToUserModal.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return AssignedToUserModal.issues(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception1: " + e.toString());
      return AssignedToUserModal.error(e.toString(), resCode);
    }
  }
}



//old code

// ignore_for_file: prefer_interpolation_to_compose_strings

// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:sellerkit/Services/LoginApi/LoginApi.dart';
// import 'package:sellerkit/Services/URL/LocalUrl.dart';
// import '../../../Constant/ConstantSapValues.dart';
// import '../../../Constant/DataBaseConfig.dart';
// import '../../../Models/PostQueryModel/EnquiriesModel/AssignedToUserModel.dart';
// import '../../../Models/PostQueryModel/EnquiriesModel/EnquiriesModel.dart';
// import '../../../Models/PostQueryModel/EnquiriesModel/ResonModel.dart';
// import '../../../main.dart';

// class AssignedToUserApi {
//   static Future<AssignedToUserModal> getData(
//       EnquiriesData enqdata, userKey, ResonData? reson) async {
//     int resCode = 500;
//     try {
//       log("UserKey:" +
//           Url.queryApi +
//           'SkClientPortal/PutEnquirys?EnquiryId=${enqdata.EnqID}');
//       await config.getSetup();
//       final response = await http.put(
//           Uri.parse(Url.queryApi +
//               'SkClientPortal/PutEnquirys?EnquiryId=${enqdata.EnqID}'),
//           headers: {
//             "content-type": "application/json",
//             "Authorization": 'bearer ' + ConstantValues.token,
//             "Location": '${ConstantValues.EncryptedSetup}'
//           },
//           body: jsonEncode({
//             "id": enqdata.EnqID,
//             "customerCode": "5471847588",
//             "activity": "CCcustomer",
//             "activityType": "${reson!.CODE}",
//             "potentialvalue": "${enqdata.PotentialValue}",
//             "u_Lookingfor": "Grinder",
//             "u_AssignedTo": "$userKey",
//             "u_ManagerSlp": "${ConstantValues.slpcode}",
//             "u_EnqStatus": "${reson.description}",
//             "u_EnqRefer": "FACEBOOKAD",
//             "createdby": 1,
//             "createdDate": "2023-08-11T09:23:27.523Z",
//             "updatedby": 1,
//             "updateddate": "${config.currentDate()}",
//             "u_Followupdate": "2023-08-11T09:23:27.523Z",
//             "closed": "N"
//           }));

//       log("Forward: " +
//           jsonEncode({
//             "id": enqdata.EnqID,
//             "customerCode": "5471847588",
//             "activity": "CCcustomer",
//             "activityType": "${reson.CODE}",
//             "potentialvalue": "${enqdata.PotentialValue}",
//             "u_Lookingfor": "Grinder",
//             "u_AssignedTo": "$userKey",
//             "u_ManagerSlp": "${ConstantValues.slpcode}",
//             "u_EnqStatus": "${reson.description}",
//             "u_EnqRefer": "FACEBOOKAD",
//             "createdby": 1,
//             "createdDate": "2023-08-11T09:23:27.523Z",
//             "updatedby": 1,
//             "updateddate": "${config.currentDate()}",
//             "u_Followupdate": "2023-08-11T09:23:27.523Z",
//             "closed": "N"
//           }).toString());

//       resCode = response.statusCode;
//       print(response.statusCode.toString());
//       log("FORwARDres" + json.decode(response.body).toString());
//       if (response.statusCode == 200) {
//         // Map data = json.decode(response.body);
//         return AssignedToUserModal.fromJson(
//             json.decode(response.body), resCode);
//       } else {
//         print("Error: ${json.decode(response.body)}");
//         return AssignedToUserModal.error('Error', resCode);
//       }
//     } catch (e) {
//       print("Exception1: " + e.toString());
//       return AssignedToUserModal.error(e.toString(), resCode);
//     }
//   }
// }
