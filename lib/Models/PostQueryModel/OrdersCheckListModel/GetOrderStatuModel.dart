import 'dart:convert';

import 'package:sellerkit/DBModel/EnqTypeModel.dart';

class GetOrderStatusModal {
  List<GetOrderStatusData>? Ordercheckdata;
  String message;
  bool? status;
  String? exception; 
  int? stcode;
  GetOrderStatusModal(
      {required this.Ordercheckdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetOrderStatusModal.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<GetOrderStatusData> dataList =
          list.map((data) => GetOrderStatusData.fromJson(data)).toList();
      return GetOrderStatusModal(
          Ordercheckdata: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return GetOrderStatusModal(
          Ordercheckdata: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory GetOrderStatusModal.error(String jsons, int stcode) {
    return GetOrderStatusModal(
        Ordercheckdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetOrderStatusData {
  String? code;
  String? name;
  String? statusType;

  GetOrderStatusData({
    required this.code,
    required this.name,
    required this.statusType,
  });

  factory GetOrderStatusData.fromJson(Map<String, dynamic> json) =>
      GetOrderStatusData(
        code: json['Code'] ?? '',
        name: json['Name'] ?? '',
        statusType: json['StatusType'] ?? '',
      );

  Map<String, Object?> toMap() => {
        OrderStatusReason.code: code,
        OrderStatusReason.name: name,
        OrderStatusReason.statusType: statusType,
      };
}
