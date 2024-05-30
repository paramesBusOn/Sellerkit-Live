// ignore_for_file: unnecessary_null_comparison, unnecessary_cast

import 'dart:convert';

import '../../../DBModel/EnqTypeModel.dart';
// import '../../../DBModel/EnqTypeModel.dart';

class OrderTypeModal {
  List<OrderTypeData>? itemdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  OrderTypeModal(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory OrderTypeModal.fromJson(List<dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<OrderTypeData> dataList =
          list.map((data) => OrderTypeData.fromJson(data)).toList();
      return OrderTypeModal(
          itemdata: dataList,
          message: "sucess",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return OrderTypeModal(
          itemdata: null,
          message: "failed",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

 factory OrderTypeModal.issues(Map<String,dynamic> jsons, int stcode) {
    return OrderTypeModal(
        itemdata: null,
        message: jsons['respCode'],
        status: null,
        stcode: stcode,
        exception: jsons['respDesc']);
  }

  factory OrderTypeModal.error(String jsons, int stcode) {
    return OrderTypeModal(
        itemdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class OrderTypeData {
  OrderTypeData({
    required this.Code,
    required this.Name,
  });

  String? Code;
  String? Name;

  factory OrderTypeData.fromJson(Map<String, dynamic> json) =>
      OrderTypeData(
        Code: json['code'] ?? 00,
        Name: json['description'] ?? '',
      );

  Map<String, Object?> toMap() => {
        OrderTypeDBModel.code: Code,
        OrderTypeDBModel.name: Name,
      };
}
