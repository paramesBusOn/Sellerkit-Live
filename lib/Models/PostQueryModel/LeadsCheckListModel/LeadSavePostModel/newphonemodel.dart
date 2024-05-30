import 'dart:convert';

import 'package:sellerkit/DBModel/EnqTypeModel.dart';

class GetLeadphoneModal {
  List<GetLeadPhoneData>? leadphonedata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetLeadphoneModal(
      {required this.leadphonedata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetLeadphoneModal.fromJson(List<dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
     
    
      List<GetLeadPhoneData> dataList =
          list.map((data) => GetLeadPhoneData.fromJson(data)).toList();
       
      return GetLeadphoneModal(
          leadphonedata: dataList,
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return GetLeadphoneModal(
          leadphonedata: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory GetLeadphoneModal.error(String jsons, int stcode) {
    return GetLeadphoneModal(
        leadphonedata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetLeadPhoneData {
  int? id;
  int? masterTypeId;

  String? code;
  String? name;

  GetLeadPhoneData({
    required this.code,
    required this.name,
    this.id,
    this.masterTypeId
  });

  factory GetLeadPhoneData.fromJson(Map<String, dynamic> json) =>
      GetLeadPhoneData(
        id: json['id'],
        masterTypeId: json['masterTypeId'],
        code: json['code'] ?? '',
        name: json['description'] ?? '',
      );

  // Map<String, Object?> toMap() => {
  //       LeadStatusReason.code: code,
  //       LeadStatusReason.name: name,
  //       LeadStatusReason.statusType: statusType,
  //     };
}
class namedata{
  String? name;
  namedata({
    required this.name,
  });
}
