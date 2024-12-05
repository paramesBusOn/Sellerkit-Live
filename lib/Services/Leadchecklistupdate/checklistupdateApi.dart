// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations, avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sellerkit/Models/ChecklistupdateModel/Checklistupdatemodel.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';
import 'package:uuid/uuid.dart';
import '../../../Constant/Configuration.dart';

import 'package:sellerkit/Constant/constant_sapvalues.dart';
import '../../../Models/AddEnqModel/addenq_model.dart';
import '../../../Models/PostQueryModel/EnquiriesModel/CustomerCreationModel.dart';

class ChecklistupdateApi {
  static Future<ChecklistupdateModel> getData(
    List<tabchecklistdata> tabchecklist
      // sapUserId, PatchExCus patch, List<LeadCheckData> leadCheckData,
      // [PostLead? postLead]
      ) async {
    int resCode = 500;
    log(Url.queryApi + 'Sellerkit_Flexi/v2/LeadChecklistUpdate');

    try {
      log("Token::" + ConstantValues.token.toString());
      log("Token::" + ConstantValues.EncryptedSetup.toString());
      Config config = Config();
      // await config.getSetup();
      final response = await http.post(
          Uri.parse(Url.queryApi + 'Sellerkit_Flexi/v2/LeadChecklistUpdate'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location": '${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode(
          tabchecklist.map((e) => e.tojson3()).toList()
          ));
      print("body chckupdate:" +
          jsonEncode(
               tabchecklist.map((e) => e.tojson3()).toList()
          ).toString());
      resCode = response.statusCode;
      print("New Customer ::" + response.statusCode.toString());
      log("New Customer response::" + json.decode(response.body).toString());
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        log("datain");
        return 
        ChecklistupdateModel.fromjson(response.statusCode,
            json.decode(response.body), );
      } else if (response.statusCode >= 400 && response.statusCode <= 410) {
        // log("Error: ${json.decode(response.body).toString()}");
        // throw Exception("Error");

        return 
        ChecklistupdateModel.issue(
            json.decode(response.body), response.statusCode);
      } else {
        // throw Exception("Error");
        return 
        ChecklistupdateModel.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      print("Exception: " + e.toString());
      //throw Exception(e.toString());
      return 
      ChecklistupdateModel.error(e.toString(), resCode);
    }
  }
}

class tabchecklistdata{
  int? leadId;
  int? lineNum;
  String? checkListCode;
  String? checkListValue;
  int? createdBy;
  String? createdDateTime;
  int? updatedBy;
  String? updatedDateTime;
  String? traceId;

tabchecklistdata({
  required this.checkListCode,
  required this.checkListValue,
   this.createdBy,
  required this.createdDateTime,
  required this.leadId,
  required this.lineNum,
   this.traceId,
   this.updatedBy,
  required this.updatedDateTime

});


 Map<String, dynamic> tojson3() {
    Map<String, dynamic> map = {
    
    "leadId": leadId,
            "lineNum": lineNum,
            "checkListCode": checkListCode,
            "checkListValue": checkListValue,
            "createdBy": ConstantValues.UserId,
            "createdDateTime": createdDateTime,
            "updatedBy": ConstantValues.UserId,
            "updatedDateTime": updatedDateTime,
            "traceId": Uuid().v4()
      
    };
    return map;
  }

}
