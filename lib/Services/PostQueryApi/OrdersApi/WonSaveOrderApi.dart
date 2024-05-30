// ignore_for_file: unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/OrderSavePostModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';

import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Models/PostQueryModel/OrdersCheckListModel/ForwardOrderUserModel.dart';
import 'package:sellerkit/main.dart';

class WonSaveOrderApi {
  static Future<ForwardOrderUser> getData(
      followDocEntry, ForwardOrderUserDataWon forwardLeadUserDataWon,PostOrder postLead) async {
    // List<dynamic> res = [];
    int resCode = 500;
    try {
      log("ConstantValues.token::"+ConstantValues.token.toString());
      // log("ConstantValues.EncryptedSetup::"+ConstantValues.EncryptedSetup.toString());
      Config config = Config();
      log("UUURL:" +
          Url.queryApi +
          'Sellerkit_Flexi/v2/OrderDelivery');
      await config.getSetup();
      final response = await http.post(
          Uri.parse(
              Url.queryApi + 'Sellerkit_Flexi/v2/OrderDelivery'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location": '${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
            "docentry": int.parse(followDocEntry),
            "isdelivered": 1,
            "deliverydate": "${forwardLeadUserDataWon.billDate}",
            "deliveryno": "${forwardLeadUserDataWon.billRef}",
            "deliveryurl1":postLead.attachmenturl1 ==null || postLead.attachmenturl1!.isEmpty?null: "${postLead.attachmenturl1}",
            "deliveryurl2":postLead.attachmenturl2 ==null || postLead.attachmenturl2!.isEmpty?null:  "${postLead.attachmenturl2}",
          }));

      log("ANBBBBU" +
          jsonEncode({
            "docentry": int.parse(followDocEntry),
            "isdelivered": 1,
            "deliverydate": "${forwardLeadUserDataWon.billDate}",
            "deliveryno": "${forwardLeadUserDataWon.billRef}",
            "deliveryurl1":postLead.attachmenturl1 ==null || postLead.attachmenturl1!.isEmpty?null: "${postLead.attachmenturl1}",
            "deliveryurl2":postLead.attachmenturl2 ==null || postLead.attachmenturl2!.isEmpty?null:  "${postLead.attachmenturl2}",
         
          }));

      resCode = response.statusCode;
     log("Response Status Code: ${response.statusCode}");
log("Response Body: ${response.body}");
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        // res.add(resCode);
        // res.add(response.body);
        return ForwardOrderUser.fromjson(response.statusCode);
      }
      //  else if (response.statusCode >= 400 && response.statusCode <= 410) {
      //   // print("Error: ${response.body}");
      //   // res.add(resCode);
      //   // res.add(response.body);
      //   return ForwardOrderUser.issue(
      //       json.decode(response.body)  , response.statusCode);
      // } 
      else {
        //  print("Error: ${json.decode(response.body)}");
        return ForwardOrderUser.issue(
          json.decode(response.body) ,response.statusCode);
      }
    } catch (e) {
      log("Exception11: " + e.toString());
      // res.add(resCode);
      // res.add(e.toString());
      return ForwardOrderUser.error(e.toString(), resCode);
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
      followDocEntry, ForwardOrderUserDataWon forwardLeadUserDataWon) {
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
          // "U_Feedback": "${forwardLeadUserDataWon.feedback}",
          "U_Ref1": "${forwardLeadUserDataWon.billRef}",
          "U_Ref2": null,
          "U_RefDate": "${forwardLeadUserDataWon.billDate}",
          "U_NextUser": null
        }
      ]
    }));
  }
}

class ForwardOrderUserDataWon {
  String? curentDate;
  // String? nextFD;
  String? updatedBy;
  String? followupMode;
  String? ReasonCode;
  // String? feedback;
  String? billRef;
  String? billDate;

  ForwardOrderUserDataWon(
      {this.curentDate,
      // this.nextFD,
      this.ReasonCode,
      this.followupMode,
      this.updatedBy,
      // this.feedback,
      this.billDate,
      this.billRef});
}
