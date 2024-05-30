// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:sellerkit/Constant/Configuration.dart';
// import 'package:sellerkit/Services/URL/LocalUrl.dart';
// import '../../../Constant/ConstantSapValues.dart';
// import '../../../Constant/DataBaseConfig.dart';
// import '../../../Models/PostQueryModel/EnquiriesModel/EnquiriesModel.dart';
// import '../../../Models/PostQueryModel/EnquiriesModel/ResonModel.dart';
// import '../../../Models/PostQueryModel/EnquiriesModel/UpdateEnqModel.dart';

// class UpdateEnqApi {
//   static Future<UpdateEnqModal> getData(
//       EnquiriesData enqdata, ResonData? reson, fromDate) async {
//     int resCode = 500;
//     try {
//       log("ININ" + Url.queryApi + 'SkClientPortal/PutEnquirys?EnquiryId=2');
//       Config config = new Config();
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
//             "u_AssignedTo": "${ConstantValues.slpcode}",
//             "u_ManagerSlp": "${ConstantValues.slpcode}",
//             "u_EnqStatus": "${reson.description}",
//             "u_EnqRefer": "FACEBOOKAD",
//             "createdby": 1,
//             "createdDate": "2023-08-11T09:23:27.523Z",
//             "updatedby": 1,
//             "updateddate": "${config.currentDate()}",
//             "u_Followupdate": "2023-08-11T09:23:27.523Z",
//             "closed": "Y"
           
//           }));

//       log("body" +
//           jsonEncode({
//             "id": enqdata.EnqID,
//             "customerCode": "5471847588",
//             "activity": "CCcustomer",
//             "activityType": "${reson.CODE}",
//             "potentialvalue": "${enqdata.PotentialValue}",
//             "u_Lookingfor": "Grinder",
//             "u_AssignedTo": "${ConstantValues.slpcode}",
//             "u_ManagerSlp": "${ConstantValues.slpcode}",
//             "u_EnqStatus": "${reson.description}",
//             "u_EnqRefer": "FACEBOOKAD",
//             "createdby": 1,
//             "createdDate": "2023-08-11T09:23:27.523Z",
//             "updatedby": 1,
//             "updateddate": "${config.currentDate()}",
//             "u_Followupdate": "2023-08-11T09:23:27.523Z",
//             "closed": "Y" //Curent DateTime
//           }));

//       resCode = response.statusCode;
//       // print(response.statusCode.toString());
//       print(json.decode(response.body));
//       if (response.statusCode == 200) {
//         log("updatestat" + response.statusCode.toString());
//         log("updateres" + json.decode(response.body).toString());
//         // Map data = json.decode(response.body);
//         return UpdateEnqModal.fromJson(json.decode(response.body), resCode);
//       } else {
//         print("Error: ${json.decode(response.body)}");
//         return UpdateEnqModal.error('Error', resCode);
//       }
//     } catch (e) {
//       print("Exception2: " + e.toString());
//       return UpdateEnqModal.error(e.toString(), resCode);
//     }
//   }
// }

// // Put
//   // body: jsonEncode({
//   //           "constr":
//   //               "Server=${DataBaseConfig.ip};Database=${DataBaseConfig.database};User Id=${DataBaseConfig.userId}; Password=${DataBaseConfig.password};",
//   //           "query": fromDate == null
//   //               ? "exec SK_SET_UPDATE_ENQUIRY_STATUS '$enqID','$reson',null"
//   //               : "exec SK_SET_UPDATE_ENQUIRY_STATUS '$enqID','$reson','$fromDate'"
//   //         }));
