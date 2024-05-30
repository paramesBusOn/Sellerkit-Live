import 'dart:convert';

import 'package:sellerkit/DBModel/EnqTypeModel.dart';

class GetLeadStatusModal {
  List<GetLeadStatusData>? leadcheckdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetLeadStatusModal(
      {required this.leadcheckdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetLeadStatusModal.fromJson(List<dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
     
    
      List<GetLeadStatusData> dataList =
          list.map((data) => GetLeadStatusData.fromJson(data)).toList();
       
      return GetLeadStatusModal(
          leadcheckdata: dataList,
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return GetLeadStatusModal(
          leadcheckdata: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory GetLeadStatusModal.issues(Map<String,dynamic> jsons, int stcode) {
    return GetLeadStatusModal(
        leadcheckdata: null,
        message: jsons["respCode"],
        status: null,
        stcode: stcode,
        exception: jsons["respDesc"]);
  }
  factory GetLeadStatusModal.error(String jsons, int stcode) {
    return GetLeadStatusModal(
        leadcheckdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetLeadStatusData {
  int? id;
  int? masterTypeId;

  String? code;
  String? name;
  int? statusType;
  int? status;

  GetLeadStatusData({
    required this.code,
    required this.name,
    required this.statusType,
    this.id,
    this.status,
    this.masterTypeId
  });

  factory GetLeadStatusData.fromJson(Map<String, dynamic> json) =>
      GetLeadStatusData(
        status:json['status'],
        id: json['id'],
        masterTypeId: json['masterTypeId'],
        code: json['code'] ?? '',
        name: json['description'] ?? '',
        statusType: json['nextStatus'] ?? '',
      );

  Map<String, Object?> toMap() => {
        LeadStatusReason.code: code,
        LeadStatusReason.name: name,
        LeadStatusReason.statusType: statusType,
      };
}
class namedata{
  String? name;
  namedata({
    required this.name,
  });
}
