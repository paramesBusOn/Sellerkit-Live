// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Models/LeaveAprovalModel/leaveaprovepos.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import '../../../Constant/ConstantSapValues.dart';
import '../../Models/LeavereqModel/leavereqgetmodel.dart';
import '../../Models/LeavereqModel/leavereqpostmodel.dart';
import '../../Models/postvisitmodel/postvisitplan.dart';
// import 'package:sellerkit/main.dart';

class LeavepostApproveApi {
  static Future<int> getData(int? leaveid,int? status) async {
    int resCode = 500;
    try {
     log("URRRRL"+Url.queryApi + 'SkClientPortal/UpdateLeaveRequest?LeaveId=$leaveid&status=$status');
      Config config = Config();

      await config.getSetup(); final response = await http.put(
          Uri.parse(Url.queryApi + 'SkClientPortal/UpdateLeaveRequest?LeaveId=$leaveid&status=$status'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location":'${ConstantValues.EncryptedSetup}'
          },
        
       
          );

  //        log("JSSSOOOON"+jsonEncode({
  //           "id": 0,
  // "slpCode": "${leavereqdet.slpcode}",
  // "reportingTo": "${leavereqdet.reportto}",
  // "leaveRequestType": "${leavereqdet.leavereqtype}",
  // "leavetype": "${leavereqdet.leavetype}",
  // "startDate": "${leavereqdet.startdate}",
  // "endDate": "${leavereqdet.enddate}",
  // "halfDay": "${leavereqdet.halfDay}",
  // "noOfleaveReqDays":leavereqdet. noofleavereq,
  // "reason": "${leavereqdet.reason}",
  // "status": 0
  //         }).toString());
      // resCode = response.statusCode;
      log("RESPONSE>>>>"+response.statusCode.toString());
      log("sk_get_check_customer111 "+response.body.toString());
      if (response.statusCode == 200) {
        //  log("chequeenq:"+response.statusCode.toString());
        return  response.statusCode;
        // leaveAproPostmodel.fromJson(json.decode(response.body), response.statusCode);
        
      } else {
        // log("chequeenqError: ${json.decode (response.body)}");
        return response.statusCode;
        //  leaveAproPostmodel.error("${response.body}", response.statusCode);
      }
    } catch (e) {
      print("chequeenqException: " + e.toString());
      return  resCode;
      // leaveAproPostmodel.error(e.toString(), resCode);
    }
  }
}
