// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/ForwardLeadUserModel.dart';

class AllSaveLeadApi {
  static Future<ForwardLeadUser> getData(
      leadDocEntry, ForwardLeadUserDataOpen forwardLeadUserData) async {
    int resCode = 500;
    try {
      // log("url: " + Url.queryApi + 'Sellerkit_Flexi/v2/FollowupUpdate');
      final response = await http.post(
          Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/FollowupUpdate'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location": '${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
           "leadid": leadDocEntry,
            "followupdate": forwardLeadUserData.curentDate == null|| forwardLeadUserData.curentDate!.isEmpty 
                   
                ? null
                : "${forwardLeadUserData.curentDate}",
            "followupmode": forwardLeadUserData.followupMode == null|| forwardLeadUserData.followupMode!.isEmpty 
                   
                ? null
                : "${forwardLeadUserData.followupMode}",
            "status":forwardLeadUserData.status == null|| forwardLeadUserData.status!.isEmpty 
                    
                ? null
                : "${forwardLeadUserData.status}",
            "reasoncode":forwardLeadUserData.ReasonCode == null|| forwardLeadUserData.ReasonCode!.isEmpty 
                    
                ? null
                : "${forwardLeadUserData.ReasonCode}",
                "planofpurchase": forwardLeadUserData.Purchasedate == null||forwardLeadUserData.Purchasedate==''|| forwardLeadUserData.Purchasedate!.isEmpty 
                    
                ? null
                : "${forwardLeadUserData.Purchasedate}",
            "nextfollowupdate":  forwardLeadUserData.nextFD == null||
            forwardLeadUserData.nextFD!.isEmpty 
                   
                ? null
                : "${forwardLeadUserData.nextFD}",
            "feedback":forwardLeadUserData.feedback == null|| forwardLeadUserData.feedback!.isEmpty 
                    
                ? null
                : "${forwardLeadUserData.feedback}",
            "ref1": forwardLeadUserData.billRef == null|| forwardLeadUserData.billRef!.isEmpty 
                   
                ? null
                : "${forwardLeadUserData.billRef}",
            "ref2": null,
            "nextuser": forwardLeadUserData.nextUser == null||forwardLeadUserData.nextUser!.isEmpty 
                    
                ? null
                : "${forwardLeadUserData.nextUser}",
            "refdate":forwardLeadUserData.billDate == null|| forwardLeadUserData.billDate!.isEmpty 
                    
                ? null
                : "${forwardLeadUserData.billDate}",
            "reasontype":forwardLeadUserData.Reasoname == null|| forwardLeadUserData.Reasoname!.isEmpty 
                    
                ? null
                : "${forwardLeadUserData.Reasoname}",
            "isvisitplanrequired":0,
            "visittime":forwardLeadUserData.visitdate==null||forwardLeadUserData.visitdate!.isEmpty?null: "${forwardLeadUserData.visitdate}",
            "purposeofvisit": 0,
            "remindon": null
          }));

      log("opensaveleadbody::" +
          jsonEncode({
             "leadid": leadDocEntry,
            "followupdate": forwardLeadUserData.curentDate == null|| forwardLeadUserData.curentDate!.isEmpty 
                   
                ? null
                : "${forwardLeadUserData.curentDate}",
            "followupmode": forwardLeadUserData.followupMode == null|| forwardLeadUserData.followupMode!.isEmpty 
                   
                ? null
                : "${forwardLeadUserData.followupMode}",
            "status":forwardLeadUserData.status == null|| forwardLeadUserData.status!.isEmpty 
                    
                ? null
                : "${forwardLeadUserData.status}",
            "reasoncode":forwardLeadUserData.ReasonCode == null|| forwardLeadUserData.ReasonCode!.isEmpty 
                    
                ? null
                : "${forwardLeadUserData.ReasonCode}",
                "planofpurchase": forwardLeadUserData.Purchasedate == null||forwardLeadUserData.Purchasedate==''|| forwardLeadUserData.Purchasedate!.isEmpty 
                    
                ? null
                : "${forwardLeadUserData.Purchasedate}",
            "nextfollowupdate":  forwardLeadUserData.nextFD == null||
            forwardLeadUserData.nextFD!.isEmpty 
                   
                ? null
                : "${forwardLeadUserData.nextFD}",
            "feedback":forwardLeadUserData.feedback == null|| forwardLeadUserData.feedback!.isEmpty 
                    
                ? null
                : "${forwardLeadUserData.feedback}",
            "ref1": forwardLeadUserData.billRef == null|| forwardLeadUserData.billRef!.isEmpty 
                   
                ? null
                : "${forwardLeadUserData.billRef}",
            "ref2": null,
            "nextuser": forwardLeadUserData.nextUser == null||forwardLeadUserData.nextUser!.isEmpty 
                    
                ? null
                : "${forwardLeadUserData.nextUser}",
            "refdate":forwardLeadUserData.billDate == null|| forwardLeadUserData.billDate!.isEmpty 
                    
                ? null
                : "${forwardLeadUserData.billDate}",
            "reasontype":forwardLeadUserData.Reasoname == null|| forwardLeadUserData.Reasoname!.isEmpty 
                    
                ? null
                : "${forwardLeadUserData.Reasoname}",
            "isvisitplanrequired":0,
            "visittime":forwardLeadUserData.visitdate==null||forwardLeadUserData.visitdate!.isEmpty?null: "${forwardLeadUserData.visitdate}",
            "purposeofvisit": 0,
            "remindon": null
          }).toString());

      resCode = response.statusCode;
      log("AAA::"+response.statusCode.toString());
       log("AAA333::"+json.decode(response.body).toString());
      
      if (response.statusCode >= 200 && response.statusCode <= 200) {
        return ForwardLeadUser.fromjson(response.statusCode,json.decode(response.body));
      } else {
        // print("Error: ${json.decode(response.body)}");
        return ForwardLeadUser.issue(json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return ForwardLeadUser.error(e.toString(),resCode);
    }
  }

// body: jsonEncode({
//                 "SK_LEADFOLLOW_LINECollection": [
//                   {
//                     "U_UpdateType": "ManualOpenFUP",
//                     "U_UpdateDateTime": "${forwardLeadUserData.curentDate}",
//                     "U_UpdatedBy": "${forwardLeadUserData.updatedBy}",
//                     "U_FollowupMode": (forwardLeadUserData.followupMode ==
//                             'Phone Call'
//                         ? "Phone"
//                         : forwardLeadUserData.followupMode == 'Sms/WhatsApp'
//                             ? "Text"
//                             : forwardLeadUserData.followupMode == 'Store Visit'
//                                 ? "Visit"
//                                 : "Other"),
//                     "U_ReasonCode": "${forwardLeadUserData.ReasonCode}",
//                     "U_NextFollowupDate": "${forwardLeadUserData.nextFD}",
//                     "U_Feedback": "${forwardLeadUserData.feedback}",
//                     "U_Ref1": null,
//                     "U_Ref2": null,
//                     "U_RefDate": null,
//                     "U_NextUser": null
//                   }]
//               })
  static printjson(leadDocEntry, ForwardLeadUserDataOpen forwardLeadUserData) {
    log(jsonEncode({
      "SK_LEADFOLLOW_LINECollection": [
        {
          "U_UpdateType": "ManualOpenFUP",
          "U_UpdateDateTime": "${forwardLeadUserData.curentDate}",
          "U_UpdatedBy": "${forwardLeadUserData.updatedBy}",
          "U_FollowupMode": (forwardLeadUserData.followupMode == 'Phone Call'
              ? "Phone"
              : forwardLeadUserData.followupMode == 'Sms/WhatsApp'
                  ? "Text"
                  : forwardLeadUserData.followupMode == 'Store Visit'
                      ? "Visit"
                      : "Other"),
          "U_ReasonCode": "${forwardLeadUserData.ReasonCode}",
          "U_NextFollowupDate": "${forwardLeadUserData.nextFD}",
          "U_Feedback": "${forwardLeadUserData.feedback}",
          "U_Ref1": null,
          "U_Ref2": null,
          "U_RefDate": null,
          "U_NextUser": null
        }
      ]
    }));
  }
}

// class OpenSaveLeadApi {
//   static Future<ForwardLeadUser> getData(
//       leadDocEntry, ForwardLeadUserDataOpen forwardLeadUserData) async {
//     int resCode = 500;
//     try {
//       log("url: " +
//           Url.SLUrl +
//           'SkClientPortal/Updateleadfollowlinecollection?leaddocentry=$leadDocEntry');
//       final response = await http.post(
//           Uri.parse(Url.queryApi +
//               'SkClientPortal/Updateleadfollowlinecollection?leaddocentry=$leadDocEntry'),
//           headers: {
//             "content-type": "application/json",
//             "Authorization": 'bearer ' + ConstantValues.token,
//             "Location": '${ConstantValues.EncryptedSetup}'
//           },
//           body: jsonEncode({
//             "id": 0,
//             "docEntry": leadDocEntry,
//             "lineId": 0,
//             "visOrder": 0,
//             "object": "",
//             "logInst": 0,
//             "uUpdateType": "ManualOpenFUP",
//             "uUpdateDateTime": "${forwardLeadUserData.curentDate}",
//             "uUpdatedBy": "${forwardLeadUserData.updatedBy}",
//             "uFollowupMode": (forwardLeadUserData.followupMode == 'Phone Call'
//                 ? "Phone"
//                 : forwardLeadUserData.followupMode == 'Sms/WhatsApp'
//                     ? "Text"
//                     : forwardLeadUserData.followupMode == 'Store Visit'
//                         ? "Visit"
//                         : "Other"),
//             "reasonType": "${forwardLeadUserData.ReasonCode}",
//             "uReasonCode": "LST001",
//             "uNextFollowupDate": "${forwardLeadUserData.nextFD}",
//             "uFeedback": "",
//             "uRef1": "",
//             "uRef2": "",
//             "uNextUser": "",
//             "uRefDate": "2023-08-19T10:59:22.887Z"
//           }));

//       log("opensaveleadbody" +
//           jsonEncode({
//             "id": 0,
//             "docEntry": leadDocEntry,
//             "lineId": 0,
//             "visOrder": 0,
//             "object": "",
//             "logInst": 0,
//             "uUpdateType": "ManualOpenFUP",
//             "uUpdateDateTime": "${forwardLeadUserData.curentDate}",
//             "uUpdatedBy": "${forwardLeadUserData.updatedBy}",
//             "uFollowupMode": (forwardLeadUserData.followupMode == 'Phone Call'
//                 ? "Phone"
//                 : forwardLeadUserData.followupMode == 'Sms/WhatsApp'
//                     ? "Text"
//                     : forwardLeadUserData.followupMode == 'Store Visit'
//                         ? "Visit"
//                         : "Other"),
//             "reasonType": "${forwardLeadUserData.ReasonCode}",
//             "uReasonCode": "LST001",
//             "uNextFollowupDate": "${forwardLeadUserData.nextFD}",
//             "uFeedback": "",
//             "uRef1": "",
//             "uRef2": "",
//             "uNextUser": "",
//             "uRefDate": "2023-08-19T10:59:22.887Z"
//           }));

//       resCode = response.statusCode;
//       print(response.statusCode.toString());
//       log("leadopen" + json.decode(response.body).toString());
//       if (response.statusCode >= 200 && response.statusCode <= 200) {
//         return ForwardLeadUser.fromjson(resCode);
//       } else {
//         print("Error: ${json.decode(response.body)}");
//         return ForwardLeadUser.issue(json.decode(response.body), resCode);
//       }
//     } catch (e) {
//       print("Exception: " + e.toString());
//       return ForwardLeadUser.fromjson(resCode);
//     }
//   }

// // body: jsonEncode({
// //                 "SK_LEADFOLLOW_LINECollection": [
// //                   {
// //                     "U_UpdateType": "ManualOpenFUP",
// //                     "U_UpdateDateTime": "${forwardLeadUserData.curentDate}",
// //                     "U_UpdatedBy": "${forwardLeadUserData.updatedBy}",
// //                     "U_FollowupMode": (forwardLeadUserData.followupMode ==
// //                             'Phone Call'
// //                         ? "Phone"
// //                         : forwardLeadUserData.followupMode == 'Sms/WhatsApp'
// //                             ? "Text"
// //                             : forwardLeadUserData.followupMode == 'Store Visit'
// //                                 ? "Visit"
// //                                 : "Other"),
// //                     "U_ReasonCode": "${forwardLeadUserData.ReasonCode}",
// //                     "U_NextFollowupDate": "${forwardLeadUserData.nextFD}",
// //                     "U_Feedback": "${forwardLeadUserData.feedback}",
// //                     "U_Ref1": null,
// //                     "U_Ref2": null,
// //                     "U_RefDate": null,
// //                     "U_NextUser": null
// //                   }]
// //               })
//   static printjson(leadDocEntry, ForwardLeadUserDataOpen forwardLeadUserData) {
//     log(jsonEncode({
//       "SK_LEADFOLLOW_LINECollection": [
//         {
//           "U_UpdateType": "ManualOpenFUP",
//           "U_UpdateDateTime": "${forwardLeadUserData.curentDate}",
//           "U_UpdatedBy": "${forwardLeadUserData.updatedBy}",
//           "U_FollowupMode": (forwardLeadUserData.followupMode == 'Phone Call'
//               ? "Phone"
//               : forwardLeadUserData.followupMode == 'Sms/WhatsApp'
//                   ? "Text"
//                   : forwardLeadUserData.followupMode == 'Store Visit'
//                       ? "Visit"
//                       : "Other"),
//           "U_ReasonCode": "${forwardLeadUserData.ReasonCode}",
//           "U_NextFollowupDate": "${forwardLeadUserData.nextFD}",
//           "U_Feedback": "${forwardLeadUserData.feedback}",
//           "U_Ref1": null,
//           "U_Ref2": null,
//           "U_RefDate": null,
//           "U_NextUser": null
//         }
//       ]
//     }));
//   }
// }
// class OpenSaveLeadApi {
//   static Future<ForwardLeadUser> getData(
//       leadDocEntry, ForwardLeadUserDataOpen forwardLeadUserData) async {
//     int resCode = 500;
//     try {
//       log("url: "+Url.SLUrl + 'LEADFOLLOWUP($leadDocEntry)');
//       final response =
//           await http.patch(Uri.parse(Url.SLUrl + 'LEADFOLLOWUP($leadDocEntry)'),
//               headers: {
//                 "content-type": "application/json",
//                 "cookie": 'B1SESSION=' + ConstantValues.sapSessions,
//               },
//               body: jsonEncode({
//                 "SK_LEADFOLLOW_LINECollection": [
//                   {
//                     "U_UpdateType": "ManualOpenFUP",
//                     "U_UpdateDateTime": "${forwardLeadUserData.curentDate}",
//                     "U_UpdatedBy": "${forwardLeadUserData.updatedBy}",
//                     "U_FollowupMode": (forwardLeadUserData.followupMode ==
//                             'Phone Call'
//                         ? "Phone"
//                         : forwardLeadUserData.followupMode == 'Sms/WhatsApp'
//                             ? "Text"
//                             : forwardLeadUserData.followupMode == 'Store Visit'
//                                 ? "Visit"
//                                 : "Other"),
//                     "U_ReasonCode": "${forwardLeadUserData.ReasonCode}",
//                     "U_NextFollowupDate": "${forwardLeadUserData.nextFD}",
//                     "U_Feedback": "${forwardLeadUserData.feedback}",
//                     "U_Ref1": null,
//                     "U_Ref2": null,
//                     "U_RefDate": null,
//                     "U_NextUser": null
//                   }]
//               }));

//       log(jsonEncode({
//                 "SK_LEADFOLLOW_LINECollection": [
//                   {
//                     "U_UpdateType": "ManualOpenFUP",
//                     "U_UpdateDateTime": "${forwardLeadUserData.curentDate}",
//                     "U_UpdatedBy": "${forwardLeadUserData.updatedBy}",
//                     "U_FollowupMode": (forwardLeadUserData.followupMode ==
//                             'Phone Call'
//                         ? "Phone"
//                         : forwardLeadUserData.followupMode == 'Sms/WhatsApp'
//                             ? "Text"
//                             : forwardLeadUserData.followupMode == 'Store Visit'
//                                 ? "Visit"
//                                 : "Other"),
//                     "U_ReasonCode": "${forwardLeadUserData.ReasonCode}",
//                     "U_NextFollowupDate": "${forwardLeadUserData.nextFD}",
//                     "U_Feedback": "${forwardLeadUserData.feedback}",
//                     "U_Ref1": null,
//                     "U_Ref2": null,
//                     "U_RefDate": null,
//                     "U_NextUser": null
//                   }
//                 ]
//               }));
//       //  jsonEncode({
//       //   "U_sk_FollowupType": (followup =='Phone Call'?"Phone":
//       //   followup =='Sms/WhatsApp'?"Test":followup =='Store Visit'?"Visit":"Other"),
//       //   "U_sk_UpdateType": "Followup",
//       //   "U_sk_LostReason": "$status",
//       //   "U_sk_NextFollowDt" : "$nextFollowUpDate" ,
//       //   "Comments": "$feedback"
//       // }));

//       resCode = response.statusCode;
//       print(response.statusCode.toString());
//       print(json.decode(response.body));
//       if (response.statusCode >= 200 && response.statusCode <= 200) {
//         return ForwardLeadUser.fromjson(resCode);
//       } else {
//         print("Error: ${json.decode(response.body)}");
//         return ForwardLeadUser.issue(json.decode(response.body), resCode);
//       }
//     } catch (e) {
//       print("Exception: " + e.toString());
//       return ForwardLeadUser.fromjson(resCode);
//     }
//   }

//   static printjson(leadDocEntry, ForwardLeadUserDataOpen forwardLeadUserData) {
//     log(jsonEncode({
//        "SK_LEADFOLLOW_LINECollection": [
//                   {
//                     "U_UpdateType": "ManualOpenFUP",
//                     "U_UpdateDateTime": "${forwardLeadUserData.curentDate}",
//                     "U_UpdatedBy": "${forwardLeadUserData.updatedBy}",
//                     "U_FollowupMode": (forwardLeadUserData.followupMode ==
//                             'Phone Call'
//                         ? "Phone"
//                         : forwardLeadUserData.followupMode == 'Sms/WhatsApp'
//                             ? "Text"
//                             : forwardLeadUserData.followupMode == 'Store Visit'
//                                 ? "Visit"
//                                 : "Other"),
//                     "U_ReasonCode": "${forwardLeadUserData.ReasonCode}",
//                     "U_NextFollowupDate": "${forwardLeadUserData.nextFD}",
//                     "U_Feedback": "${forwardLeadUserData.feedback}",
//                     "U_Ref1": null,
//                     "U_Ref2": null,
//                     "U_RefDate": null,
//                     "U_NextUser": null
//                   }
//                 ]
//     }));
//   }
// }

class ForwardLeadUserDataOpen {
  String? curentDate;
  String? nextFD;
  String? updatedBy;
  String? followupMode;
  String? ReasonCode;
  String? Purchasedate;
  String? feedback;
  String? Reasoname;
  String? nextUser;
  String? status;
  //won

  String? billRef;
  String? visitdate;
  String? billDate;
  int? visitreq;

  ForwardLeadUserDataOpen(
      {
        this.Purchasedate,
        this.visitreq,this.curentDate,
      this.nextFD,
      this.visitdate,
      this.ReasonCode,
      this.followupMode,
      this.updatedBy,
      this.feedback,
      this.nextUser,
      this.status,
      this.Reasoname,
      //won

      this.billDate,
      this.billRef});
}
