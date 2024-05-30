// ignore_for_file: unnecessary_null_comparison, unnecessary_cast

import 'dart:convert';

import '../../../DBModel/EnqTypeModel.dart';
// import '../../../DBModel/EnqTypeModel.dart';

class CustomerTagTypeModal {
  List<CustomerTagTypeData>? itemdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  CustomerTagTypeModal(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory CustomerTagTypeModal.fromJson(List<dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<CustomerTagTypeData> dataList =
          list.map((data) => CustomerTagTypeData.fromJson(data)).toList();
      return CustomerTagTypeModal(
          itemdata: dataList,
          message: "sucess",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return CustomerTagTypeModal(
          itemdata: null,
          message: "failed",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

 factory CustomerTagTypeModal.issues(Map<String,dynamic> jsons, int stcode) {
    return CustomerTagTypeModal(
        itemdata: null,
        message: jsons['respCode'],
        status: null,
        stcode: stcode,
        exception: jsons['respDesc']);
  }

  factory CustomerTagTypeModal.error(String jsons, int stcode) {
    return CustomerTagTypeModal(
        itemdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class CustomerTagTypeData {
  CustomerTagTypeData({
    required this.Code,
    required this.Name,
  });

  String? Code;
  String? Name;

  factory CustomerTagTypeData.fromJson(Map<String, dynamic> json) =>
      CustomerTagTypeData(
        Code: json['code'] ?? 00,
        Name: json['description'] ?? '',
      );

  Map<String, Object?> toMap() => {
        CusTagTypeDBModel.code: Code,
        CusTagTypeDBModel.name: Name,
      };
}
