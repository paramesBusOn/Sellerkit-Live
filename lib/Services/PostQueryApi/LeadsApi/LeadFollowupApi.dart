import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../main.dart';

class LeadFollowupApi {
  static Future<int> getData(
      sapUserId, LeadFollowupApiData leadFollowupApiData, int docEntry) async {
    int resCode = 500;
    log(Url.queryApi + 'LEADFOLLOWUP');
    try {
Config config = Config();

      await config.getSetup(); final response = await http.post(Uri.parse(Url.queryApi + 'SkClientPortal/postleadfollow'),
          headers: {
            "content-type": "application/json",
             "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
            "docEntry": 0,
  "docNum": 1,
  "status": "O",
  "canceled": "N",
  "updateDate": "${config.currentDate()}",
  "createDate": "${config.currentDate()}",
  "creator": "",
            "Remark": "",
            "uLeadDocEntry": docEntry,
            "uLeadDocDate": "${leadFollowupApiData.date}",
            "skLeadfollowLines": [
              {
                 "id": 0,
      "docEntry": 0,
      "lineId":1,
      "visOrder": 0,
      "object": "",
      "logInst": 0,
                "uUpdateType": "NewLead", //h
                "uUpdateDateTime": "${leadFollowupApiData.date}",
                "uUpdatedBy": "$sapUserId",
                "uFollowupMode": "${leadFollowupApiData.name}", //hh
                "uReasonCode": "LST001", //hh
                "uNextFollowupDate": "${leadFollowupApiData.nextFollowUp}",
                "uFeedback": null,
                "uRef1": null,
                "uRef2": null,
                "uRefDate": null,
                "uNextUser": "$sapUserId",
                 "reasonType":"New Lead"
              }
            ]
          }));

          log("followupLead"+jsonEncode({
            "docEntry": 0,
  "docNum": 1,
  "status": "O",
  "canceled": "N",
  "updateDate": "${config.currentDate()}",
  "createDate": "${config.currentDate()}",
  "creator": "",
            "Remark": "",
            "uLeadDocEntry": docEntry,
            "uLeadDocDate": "${leadFollowupApiData.date}",
            "skLeadfollowLines": [
              {
                 "id": 0,
      "docEntry": 0,
      "lineId":1,
      "visOrder": 0,
      "object": "",
      "logInst": 0,
                "uUpdateType": "NewLead", //h
                "uUpdateDateTime": "${leadFollowupApiData.date}",
                "uUpdatedBy": "$sapUserId",
                "uFollowupMode": "${leadFollowupApiData.name}", //hh
                "uReasonCode": "LST001", //hh
                "uNextFollowupDate": "${leadFollowupApiData.nextFollowUp}",
                "uFeedback": null,
                "uRef1": null,
                "uRef2": null,
                "uRefDate": null,
                "uNextUser": "$sapUserId",
                "reasonType":"New Lead"
              }
            ]
          }));

      resCode = response.statusCode;
      // print(response.statusCode.toString());
     
      if (response.statusCode >= 200 && response.statusCode <= 210) {
         log("LEADFOLLOWUP resp: " +
          json.decode(response.body).toString());
        return response.statusCode;
        //LeadSavePostModal.fromJson(json.decode(response.body), resCode);
        // return resCode;
      } else {
        //return resCode;
        print("Error: ${json.decode(response.body)}");
        return response.statusCode;
        //LeadSavePostModal.issue(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      // return resCode;
      return 500;
      //LeadSavePostModal.error(e.toString(), resCode);
    }
  }
}

class LeadFollowupApiData {
  String? name;
  String? code;
  String? date;
  String? nextFollowUp;
  LeadFollowupApiData({this.code,this.name,this.date, this.nextFollowUp});
}
