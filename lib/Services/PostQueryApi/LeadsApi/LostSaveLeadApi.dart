import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/LeadsCheckListModel/ForwardLeadUserModel.dart';
import 'package:sellerkit/main.dart';

class LostSaveLeadApi {
  static Future<ForwardLeadUser> getData(
      followDocEntry, ForwardLeadUserDataLost forwardLeadUserDataLost) async {
    List<dynamic> res = [];
    int resCode = 500;
    try {
      Config config = Config();

      log("AANBB" +
          Url.queryApi +
          'SkClientPortal/leadlost?leaddocentry=$followDocEntry');
      await config.getSetup();
      final response = await http.post(
          Uri.parse(Url.queryApi +
              'SkClientPortal/leadlost?leaddocentry=$followDocEntry'),
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
            "uUpdateType": "ManualLostFUP",
            "uUpdateDateTime": "${forwardLeadUserDataLost.curentDate}",
            "uUpdatedBy": "${forwardLeadUserDataLost.updatedBy}",
            "uFollowupMode":
                (forwardLeadUserDataLost.followupMode == 'Phone Call'
                    ? "Phone"
                    : forwardLeadUserDataLost.followupMode == 'Sms/WhatsApp'
                        ? "Text"
                        : forwardLeadUserDataLost.followupMode == 'Store Visit'
                            ? "Visit"
                            : "Other"),
            "reasonType": "${forwardLeadUserDataLost.ReasonCode}",
            "uReasonCode": "LST003",
            "uNextFollowupDate": "${forwardLeadUserDataLost.curentDate}",
            "uFeedback": "${forwardLeadUserDataLost.feedback}",
            "uRef1": "",
            "uRef2": "",
            "uNextUser": "",
            "uRefDate": "${forwardLeadUserDataLost.curentDate}"
          }));

      log(jsonEncode({
        "id": 0,
        "docEntry": 0,
        "lineId": 0,
        "visOrder": 0,
        "object": "",
        "logInst": 0,
        "uUpdateType": "ManualLostFUP",
        "uUpdateDateTime": "${forwardLeadUserDataLost.curentDate}",
        "uUpdatedBy": "${forwardLeadUserDataLost.updatedBy}",
        "uFollowupMode": (forwardLeadUserDataLost.followupMode == 'Phone Call'
            ? "Phone"
            : forwardLeadUserDataLost.followupMode == 'Sms/WhatsApp'
                ? "Text"
                : forwardLeadUserDataLost.followupMode == 'Store Visit'
                    ? "Visit"
                    : "Other"),
        "reasonType": "${forwardLeadUserDataLost.ReasonCode}",
        "uReasonCode": "LST003",
        "uNextFollowupDate": "${forwardLeadUserDataLost.curentDate}",
        "uFeedback": "${forwardLeadUserDataLost.feedback}",
        "uRef1": "",
        "uRef2": "",
        "uNextUser": "",
        "uRefDate": "${forwardLeadUserDataLost.curentDate}"
      }));
      // jsonEncode({
      //   "U_sk_FollowupType": (followup =='Phone Call'?"Phone":
      //   followup =='Sms/WhatsApp'?"Test":followup =='Store Visit'?"Visit":"Other"),
      //   "U_sk_UpdateType": "ManualLost",
      //   "U_sk_LostReason": "$reason",
      //   "Comments": "$feedback"
      // }));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      // print(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        // res.add(resCode);
        // res.add(response.body);
      return ForwardLeadUser.issue(json.decode(response.body), resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        // res.add(resCode);
        // res.add(response.body);
        return ForwardLeadUser.issue(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      // res.add(resCode);
      // res.add(e.toString());
     return ForwardLeadUser.error(e.toString(), resCode);
    }
  }

  static prinjson(
      followDocEntry, ForwardLeadUserDataLost forwardLeadUserDataLost) {
    log(jsonEncode({
      "SK_LEADFOLLOW_LINECollection": [
        {
          "U_UpdateType": "ManualLostFUP",
          "U_UpdateDateTime": "${forwardLeadUserDataLost.curentDate}",
          "U_UpdatedBy": "${forwardLeadUserDataLost.updatedBy}",
          "U_FollowupMode":
              (forwardLeadUserDataLost.followupMode == 'Phone Call'
                  ? "Phone"
                  : forwardLeadUserDataLost.followupMode == 'Sms/WhatsApp'
                      ? "Text"
                      : forwardLeadUserDataLost.followupMode == 'Store Visit'
                          ? "Visit"
                          : "Other"),
          "U_ReasonCode": "${forwardLeadUserDataLost.ReasonCode}",
          "U_NextFollowupDate": null,
          "U_Feedback": "${forwardLeadUserDataLost.feedback}",
          "U_Ref1": null,
          "U_Ref2": null,
          "U_RefDate": null,
          "U_NextUser": null
        }
      ]
    }));
  }
}

class ForwardLeadUserDataLost {
  String? curentDate;
  String? nextFD;
  String? updatedBy;
  String? followupMode;
  String? ReasonCode;
  String? feedback;

  ForwardLeadUserDataLost({
    this.curentDate,
    this.nextFD,
    this.ReasonCode,
    this.followupMode,
    this.updatedBy,
    this.feedback,
  });
}
