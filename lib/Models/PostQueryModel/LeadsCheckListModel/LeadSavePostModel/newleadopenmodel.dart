import 'dart:convert';

import 'package:sellerkit/DBModel/EnqTypeModel.dart';

class GetLeadopenModal {
  List<GetLeadopenData>? leadopendata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetLeadopenModal(
      {required this.leadopendata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetLeadopenModal.fromJson(List<dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
     
    
      List<GetLeadopenData> dataList =
          list.map((data) => GetLeadopenData.fromJson(data)).toList();
       
      return GetLeadopenModal(
          leadopendata: dataList,
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return GetLeadopenModal(
          leadopendata: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory GetLeadopenModal.error(String jsons, int stcode) {
    return GetLeadopenModal(
        leadopendata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetLeadopenData {
  int? id;
  int? masterTypeId;

  String? code;
  String? name;
 

  GetLeadopenData({
    required this.code,
    required this.name,
  
    this.id,
    this.masterTypeId
  });

  factory GetLeadopenData.fromJson(Map<String, dynamic> json) =>
      GetLeadopenData(
        id: json['id'],
        masterTypeId: json['masterTypeId'],
        code: json['code'] ?? '',
        name: json['description'] ?? '',
      );

//   Map<String, Object?> toMap() => {
//         LeadStatusReason.code: code,
//         LeadStatusReason.name: name,
//         LeadStatusReason.statusType: statusType,
//       };
}
class namedata{
  String? name;
  namedata({
    required this.name,
  });
}
