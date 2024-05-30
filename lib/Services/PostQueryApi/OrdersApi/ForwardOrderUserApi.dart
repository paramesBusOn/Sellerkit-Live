// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:sellerkit/Constant/Configuration.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../../Models/PostQueryModel/OrdersCheckListModel/ForwardOrderUserModel.dart';
import 'package:sellerkit/main.dart';

class ForwardOrderUserApi {
  static Future<ForwardOrderUser> getData(
    followupEntry,
     ForwardOrderUserData forwardLeadUserData
  ) async {
    log("url: "+Url.queryApi + 'SkClientPortal/Updateleadfollowlinecollection?leaddocentry=$followupEntry');
    // print("salesPersonEmpId: "+ forwardLeadUserData.nextUser .toString());
    // print("nextfollow: "+ forwardLeadUserData.nextFD .toString());

    List<dynamic> res =[];
    int resCode = 500;
    try {
      
Config config = Config();
      await config.getSetup(); final response = await http.post(
          Uri.parse(Url.queryApi + 'SkClientPortal/Updateleadfollowlinecollection?leaddocentry=$followupEntry'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,"Location":'${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode(
             {
               "id": 0,
  "docEntry": 0,
  "lineId": 0,
  "visOrder": 0,
  "object": "",
  "logInst": 0,
  "uUpdateType": "ManualLeadForward",
  "uUpdateDateTime": "${forwardLeadUserData.curentDate}",
  "uUpdatedBy": "${ConstantValues.slpcode}",
  "uFollowupMode": "others",
  "reasonType":'',
  "uReasonCode": "",
  "uNextFollowupDate": "${forwardLeadUserData.nextFD}",
  "uFeedback": "string",
  "uRef1": "string",
  "uRef2": "string",
  "uNextUser": "${forwardLeadUserData.nextUser}",
  "uRefDate": "2023-08-19T10:59:22.887Z"
    // "SK_LEADFOLLOW_LINECollection": [
    //     {
    //         "U_UpdateType": "ManualLeadForward",
    //         "U_UpdateDateTime": "${forwardLeadUserData.curentDate}",
    //         "U_UpdatedBy": "${ConstantValues.slpcode}",
    //         "U_FollowupMode": "Other",
    //         "U_ReasonCode": "01",
    //         "U_NextFollowupDate": "${forwardLeadUserData.nextFD}",
    //         "U_Feedback": null,
    //         "U_Ref1": null,
    //         "U_Ref2": null,
    //         "U_RefDate": null, 
    //         "U_NextUser": "${forwardLeadUserData.nextUser}"
    //     }
    // ]
}
              ));

log("Forwardleadsave"+jsonEncode({
     "id": 0,
  "docEntry": 0,
  "lineId": 0,
  "visOrder": 0,
  "object": "",
  "logInst": 0,
  "uUpdateType": "ManualLeadForward",
  "uUpdateDateTime": "${forwardLeadUserData.curentDate}",
  "uUpdatedBy": "${ConstantValues.slpcode}",
  "uFollowupMode": "others",
  "uReasonCode": "ENQR02",
  "uNextFollowupDate": "${forwardLeadUserData.nextFD}",
  "uFeedback": "string",
  "uRef1": "string",
  "uRef2": "string",
  "uNextUser": "${forwardLeadUserData.nextUser}",
  "uRefDate": "2023-08-19T10:59:22.887Z"
}));

      resCode = response.statusCode;
      print(response.statusCode.toString());
      print(json.decode(response.body));
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        res.add(resCode);
        res.add(response.body);

        return ForwardOrderUser.fromjson(resCode);
      } else {
        print("Error: ${json.decode(response.body)}");
         res.add(resCode);
        res.add(response.body);
        return ForwardOrderUser.issue(json.decode(response.body), resCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      res.add(resCode);
        res.add(e.toString());
        return ForwardOrderUser.fromjson(resCode);
    }
  }
// jsonEncode(
//              {
//     "SK_LEADFOLLOW_LINECollection": [
//         {
//             "U_UpdateType": "ManualLeadForward",
//             "U_UpdateDateTime": "${forwardLeadUserData.curentDate}",
//             "U_UpdatedBy": "${ConstantValues.slpcode}",
//             "U_FollowupMode": "Other",
//             "U_ReasonCode": "01",
//             "U_NextFollowupDate": "${forwardLeadUserData.nextFD}",
//             "U_Feedback": null,
//             "U_Ref1": null,
//             "U_Ref2": null,
//             "U_RefDate": null, 
//             "U_NextUser": "${forwardLeadUserData.nextUser}"
//         }
//     ]
// }
  static printn(  followupEntry,
     ForwardOrderUserData forwardLeadUserData){
         log(jsonEncode(
             // {"SalesPersonCode": salesPersonEmpId}
             {
     "SK_LEADFOLLOW_LINECollection": [
        {
            "U_UpdateType": "ManualLeadForward",
            "U_UpdateDateTime": "${forwardLeadUserData.curentDate}",
            "U_UpdatedBy": "${ConstantValues.slpcode}",
            "U_FollowupMode": "Other",
            "U_ReasonCode": "01",
            "U_NextFollowupDate": "${forwardLeadUserData.nextFD}",
            "U_Feedback": null,
            "U_Ref1": null,
            "U_Ref2": null,
            "U_RefDate": null,
            "U_NextUser": "${forwardLeadUserData.nextUser}"
        }
    ]
}
              ));
  }
}

class ForwardOrderUserData{
  String?  curentDate;
  String?  nextFD;
  int? nextUser;
  ForwardOrderUserData({
    this.curentDate,
    this.nextFD,
    this.nextUser
  });
}
