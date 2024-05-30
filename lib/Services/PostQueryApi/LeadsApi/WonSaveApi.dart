// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/ForwardLeadUserModel.dart';

class WonSaveLeadApi {
  static Future<ForwardLeadUser> getData(
      followDocEntry, ForwardLeadUserDataWon forwardLeadUserDataWon) async {
    List<dynamic> res = [];
    int resCode = 500;
    try {
      Config config = Config();
      log("UUURL:" +
          Url.queryApi +
          'SkClientPortal/leadwon?leaddocentry=$followDocEntry');
      final response = await http.post(
          Uri.parse(Url.queryApi +
              'SkClientPortal/leadwon?leaddocentry=$followDocEntry'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location": '${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
            "id": 0,
            "docEntry": 0,
            "lineId": 0,
            "visOrder": 0,
            "object": "",
            "logInst": 0,
            "uUpdateType": "ManualWonFUP",
            "uUpdateDateTime": "${forwardLeadUserDataWon.curentDate}",
            "uUpdatedBy": "${forwardLeadUserDataWon.updatedBy}",
            "uFollowupMode":
                (forwardLeadUserDataWon.followupMode == 'Phone Call'
                    ? "Phone"
                    : forwardLeadUserDataWon.followupMode == 'Sms/WhatsApp'
                        ? "Text"
                        : forwardLeadUserDataWon.followupMode == 'Store Visit'
                            ? "Visit"
                            : "Other"),
            "reasonType": "${forwardLeadUserDataWon.ReasonCode}",
            "uReasonCode": "LST002",
            "uNextFollowupDate": "${forwardLeadUserDataWon.curentDate}",
            "uFeedback": "${forwardLeadUserDataWon.feedback}",
            "uRef1": "${forwardLeadUserDataWon.billRef}",
            "uRef2": "",
            "uNextUser": "",
            "uRefDate": "${forwardLeadUserDataWon.billDate}"
          }));

      log("ANBBBBU" +
          jsonEncode({
            "id": 0,
            "docEntry": 0,
            "lineId": 0,
            "visOrder": 0,
            "object": "",
            "logInst": 0,
            "uUpdateType": "ManualWonFUP",
            "uUpdateDateTime": "${forwardLeadUserDataWon.curentDate}",
            "uUpdatedBy": "${forwardLeadUserDataWon.updatedBy}",
            "uFollowupMode":
                (forwardLeadUserDataWon.followupMode == 'Phone Call'
                    ? "Phone"
                    : forwardLeadUserDataWon.followupMode == 'Sms/WhatsApp'
                        ? "Text"
                        : forwardLeadUserDataWon.followupMode == 'Store Visit'
                            ? "Visit"
                            : "Other"),
            "uReasonCode": "LST002",
            "uNextFollowupDate": "",
            "uFeedback": "${forwardLeadUserDataWon.feedback}",
            "uRef1": "${forwardLeadUserDataWon.billRef}",
            "uRef2": "",
            "uNextUser": "",
            "uRefDate": "${forwardLeadUserDataWon.billDate}"
          }));

      resCode = response.statusCode;
      // print(response.statusCode.toString());
      // log("AANBUBBB:"+json.decode(response.body).toString());
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        // res.add(resCode);
        // res.add(response.body);
        return ForwardLeadUser.issue(json.decode(response.body), resCode);
      } else {
        // print("Error: ${json.decode(response.body)}");
        // res.add(resCode);
        // res.add(response.body);
        return ForwardLeadUser.issue(json.decode(response.body), resCode);
      }
    } catch (e) {
      log("Exception11: " + e.toString());
      // res.add(resCode);
      // res.add(e.toString());
     return ForwardLeadUser.error(e.toString(), resCode);
    }
  }

//  body:
//                jsonEncode(
//              {
//     "SK_LEADFOLLOW_LINECollection": [
//         {
//             "U_UpdateType": "ManualWonFUP",
//             "U_UpdateDateTime": "${forwardLeadUserDataWon.curentDate}",
//             "U_UpdatedBy": "${forwardLeadUserDataWon.updatedBy}",
//             "U_FollowupMode":  (forwardLeadUserDataWon.followupMode =='Phone Call'?"Phone":
//                  forwardLeadUserDataWon.followupMode =='Sms/WhatsApp'?"Text":
//                  forwardLeadUserDataWon.followupMode =='Store Visit'?"Visit":"Other"),
//             "U_ReasonCode": "${forwardLeadUserDataWon.ReasonCode}",
//             "U_NextFollowupDate": null,
//             "U_Feedback": "${forwardLeadUserDataWon.feedback}",
//             "U_Ref1": "${forwardLeadUserDataWon.billRef}",
//             "U_Ref2":  null,
//             "U_RefDate": "${forwardLeadUserDataWon.billDate}",
//             "U_NextUser": null
//         }
//     ]
// }
//               )
  static prinjson(
      followDocEntry, ForwardLeadUserDataWon forwardLeadUserDataWon) {
    log(jsonEncode({
      "SK_LEADFOLLOW_LINECollection": [
        {
          "U_UpdateType": "ManualWonFUP",
          "U_UpdateDateTime": "${forwardLeadUserDataWon.curentDate}",
          "U_UpdatedBy": "${forwardLeadUserDataWon.updatedBy}",
          "U_FollowupMode": (forwardLeadUserDataWon.followupMode == 'Phone Call'
              ? "Phone"
              : forwardLeadUserDataWon.followupMode == 'Sms/WhatsApp'
                  ? "Text"
                  : forwardLeadUserDataWon.followupMode == 'Store Visit'
                      ? "Visit"
                      : "Other"),
          "U_ReasonCode": "${forwardLeadUserDataWon.ReasonCode}",
          "U_NextFollowupDate": null,
          "U_Feedback": "${forwardLeadUserDataWon.feedback}",
          "U_Ref1": "${forwardLeadUserDataWon.billRef}",
          "U_Ref2": null,
          "U_RefDate": "${forwardLeadUserDataWon.billDate}",
          "U_NextUser": null
        }
      ]
    }));
  }
}

class ForwardLeadUserDataWon {
  String? curentDate;
  String? nextFD;
  String? updatedBy;
  String? followupMode;
  String? ReasonCode;
  String? feedback;
  String? billRef;
  String? billDate;

  ForwardLeadUserDataWon(
      {this.curentDate,
      this.nextFD,
      this.ReasonCode,
      this.followupMode,
      this.updatedBy,
      this.feedback,
      this.billDate,
      this.billRef});
}
