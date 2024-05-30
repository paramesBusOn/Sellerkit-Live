import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/PostQueryModel/OrdersCheckListModel/OrdersSavePostModel/OrderSavePostModel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/OrdersCheckListModel/ForwardOrderUserModel.dart';

class LostSaveLeadApi {
  static Future<ForwardOrderUser> getData(
      followDocEntry, ForwardOrderUserDataLost forwardLeadUserDataLost,PostOrder postLead) async {
    List<dynamic> res = [];
    int resCode = 500;
    try {
      
      
Config config = Config();
      log("AANBB" +
          Url.queryApi +
          'Sellerkit_Flexi/v2/OrderInvoice');
      await config.getSetup(); final response = await http.post(
          Uri.parse(Url.queryApi +
              'Sellerkit_Flexi/v2/OrderInvoice'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
           
  "docentry": int.parse(followDocEntry),
  "isinvoiced": 1,
  "invoicedate": "${forwardLeadUserDataLost.nextFD}",
  "invoiceno": "${forwardLeadUserDataLost.feedback}",
  "invoicetotal": forwardLeadUserDataLost.value,
  "invoiceurl1": postLead.attachmenturl1 ==null || postLead.attachmenturl1!.isEmpty?null: "${postLead.attachmenturl1}",
  "invoiceurl2": postLead.attachmenturl2 ==null || postLead.attachmenturl2!.isEmpty?null:  "${postLead.attachmenturl2}",

          }));

      log("ANBUUU"+jsonEncode({
        "docentry": int.parse(followDocEntry),
  "isinvoiced": 1,
  "invoicedate": "${forwardLeadUserDataLost.nextFD}",
  "invoiceno": "${forwardLeadUserDataLost.feedback}",
  "invoicetotal": forwardLeadUserDataLost.value,
  "invoiceurl1": postLead.attachmenturl1 ==null || postLead.attachmenturl1!.isEmpty?null: "${postLead.attachmenturl1}",
  "invoiceurl2": postLead.attachmenturl2 ==null || postLead.attachmenturl2!.isEmpty?null:  "${postLead.attachmenturl2}",

      }));
     

      resCode = response.statusCode;
      print(response.statusCode.toString());
      // print(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        // res.add(resCode);
        // res.add(response.body);
        return ForwardOrderUser.fromjson(resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        // res.add(resCode);
        // res.add(response.body);
        return ForwardOrderUser.issue(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      // res.add(resCode);
      // res.add(e.toString());
      return ForwardOrderUser.fromjson(resCode);
    }
  }

  static prinjson(
      followDocEntry, ForwardOrderUserDataLost forwardLeadUserDataLost) {
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

class ForwardOrderUserDataLost {
  String? curentDate;
  String? nextFD;
  String? updatedBy;
  String? followupMode;
  String? ReasonCode;
  String? feedback;
  double? value;

  ForwardOrderUserDataLost({
    this.value,
    this.curentDate,
    this.nextFD,
    this.ReasonCode,
    this.followupMode,
    this.updatedBy,
    this.feedback,
  });
}
