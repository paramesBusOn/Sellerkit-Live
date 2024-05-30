import 'dart:convert';

import 'package:sellerkit/DBModel/EnqTypeModel.dart';

class GetBAnkAccountModal {
  List<GetBAnkAccountData>? accountkdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetBAnkAccountModal(
      {required this.accountkdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetBAnkAccountModal.fromJson(List<dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
     
    
      List<GetBAnkAccountData> dataList =
          list.map((data) => GetBAnkAccountData.fromJson(data)).toList();
       
      return GetBAnkAccountModal(
          accountkdata: dataList,
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return GetBAnkAccountModal(
          accountkdata: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory GetBAnkAccountModal.issues(Map<String,dynamic> jsons, int stcode) {
    return GetBAnkAccountModal(
        accountkdata: null,
        message: jsons["respCode"],
        status: null,
        stcode: stcode,
        exception: jsons["respDesc"]);
  }
  factory GetBAnkAccountModal.error(String jsons, int stcode) {
    return GetBAnkAccountModal(
        accountkdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetBAnkAccountData {
  int? id;
  int? masterTypeId;

  String? code;
  String? name;
  int? status;

  GetBAnkAccountData({
    required this.code,
    required this.name,
    this.id,
    this.status,
    this.masterTypeId
  });

  factory GetBAnkAccountData.fromJson(Map<String, dynamic> json) =>
      GetBAnkAccountData(
        status:json['status']??0,
        id: json['id']??0,
        masterTypeId: json['masterTypeId']??'',
        code: json['code'] ?? '',
        name: json['description'] ?? '',
      );

  Map<String, Object?> toMap() => {
        LeadStatusReason.code: code,
        LeadStatusReason.name: name,
      };
}
class namedata{
  String? name;
  namedata({
    required this.name,
  });
}
