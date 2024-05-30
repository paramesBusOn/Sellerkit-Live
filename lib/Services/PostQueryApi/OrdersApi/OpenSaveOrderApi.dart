// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:sellerkit/Constant/Configuration.dart';

import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/OrdersCheckListModel/ForwardOrderUserModel.dart';

class OpenSaveOrderApi {
  static Future<ForwardOrderUser> getData(
      leadDocEntry, ForwardOrderUserDataOpen forwardLeadUserData) async {
    int resCode = 500;
    try {
      
      
Config config = Config();
      log("url: " +
          Url.queryApi +
              'Sellerkit_Flexi/v2/OrderCancel');
      await config.getSetup(); final response = await http.post(
          Uri.parse(Url.queryApi +
              'Sellerkit_Flexi/v2/OrderCancel'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
             "docentry": leadDocEntry,
  "cancellationdate": "${forwardLeadUserData.curentDate}",
  "cancelledreason": "${forwardLeadUserData.ReasonCode}",
  "cancelledremarks": "${forwardLeadUserData.feedback}"
          }));

      log("opensaveleadbody" +
          jsonEncode({
             "docentry": leadDocEntry,
  "cancellationdate": "${forwardLeadUserData.curentDate}",
  "cancelledreason": "${forwardLeadUserData.ReasonCode}",
  "cancelledremarks": "${forwardLeadUserData.feedback}"
          }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      log("leadopen" + json.decode(response.body).toString());
      if (response.statusCode >= 200 && response.statusCode <= 200) {
        return ForwardOrderUser.fromjson(resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return ForwardOrderUser.issue(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      return ForwardOrderUser.fromjson(resCode);
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
  static printjson(leadDocEntry, ForwardOrderUserDataOpen forwardLeadUserData) {
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

class ForwardOrderUserDataOpen {
  String? curentDate;
  String? nextFD;
  String? updatedBy;
  String? followupMode;
  String? ReasonCode;
  String? feedback;

  ForwardOrderUserDataOpen(
      {this.curentDate,
      this.nextFD,
      this.ReasonCode,
      this.followupMode,
      this.updatedBy,
      this.feedback});
}
class ForwardQuoteUserDataOpen {
  String? curentDate;
  String? nextFD;
  String? updatedBy;
  String? followupMode;
  String? ReasonCode;
  String? feedback;

  ForwardQuoteUserDataOpen(
      {this.curentDate,
      this.nextFD,
      this.ReasonCode,
      this.followupMode,
      this.updatedBy,
      this.feedback});
}
