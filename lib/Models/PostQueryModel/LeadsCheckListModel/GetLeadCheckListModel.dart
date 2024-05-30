import 'dart:convert';
import '../../../DBModel/EnqTypeModel.dart';

class LeadsCheckListModal {
  List<LeadCheckData>? leadcheckdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  LeadsCheckListModal(
      {required this.leadcheckdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory LeadsCheckListModal.fromJson(List< dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<LeadCheckData> dataList =
          list.map((data) => LeadCheckData.fromJson(data)).toList();
      return LeadsCheckListModal(
          leadcheckdata: dataList,
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return LeadsCheckListModal(
          leadcheckdata: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory LeadsCheckListModal.error(String jsons, int stcode) {
    return LeadsCheckListModal(
        leadcheckdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class LeadCheckData {
  LeadCheckData(
      { this.MasterTypeId,
       this.id,
      this.linenum,
       this.Code, 
       this.Name, 
       this.ischecked
      });
int? id;
int? MasterTypeId;
int? linenum;
  String? Code;
  String? Name;
  bool? ischecked;

  factory LeadCheckData.fromJson(Map<String, dynamic> json) => LeadCheckData(
      Code: json['code'] ?? '', Name: json['description'] ?? '', ischecked: false,
      id: json['id'],
      MasterTypeId: json['masterTypeId'],
      // linenum: json['lineId']
      );

  Map<String, dynamic> tojson() {
    Map<String, dynamic> map = {
      "id": 0,
      "docEntry": 0,
      "U_ChkCode": Code,
      "U_ChkName": Name,
      "U_ChkValue": ischecked == false?'No':'Yes',
      "lineId":linenum,
      "visOrder": 0,
      "object": "",
      "logInst": "",
    };
    return map;
  }

  Map<String, dynamic> tojson2() {
    Map<String, dynamic> map = {
     "id": 0,
    "visitActivitiesId": 0,
      "u_CheckCode": Code,
      "u_Checkvalue": ischecked == false?'No':'Yes',
      
    };
    return map;
  }

   Map<String, dynamic> tojson3() {
    Map<String, dynamic> map = {
    
      "u_CheckCode": Code,
      
      
    };
    return map;
  }
}


class leadcheccklist{
  
}