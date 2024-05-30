// ignore_for_file: unnecessary_null_comparison, unnecessary_cast

import 'dart:convert';

import '../../../DBModel/EnqTypeModel.dart';
// import '../../../DBModel/EnqTypeModel.dart';

class LevelofModal {
  List<LevelofData>? itemdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  LevelofModal(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory LevelofModal.fromJson(List<dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<LevelofData> dataList =
          list.map((data) => LevelofData.fromJson(data)).toList();
      return LevelofModal(
          itemdata: dataList,
          message: "sucess",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return LevelofModal(
          itemdata: null,
          message: "failed",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

 factory LevelofModal.issues(Map<String,dynamic> jsons, int stcode) {
    return LevelofModal(
        itemdata: null,
        message: jsons['respCode'],
        status: null,
        stcode: stcode,
        exception: jsons['respDesc']);
  }

  factory LevelofModal.error(String jsons, int stcode) {
    return LevelofModal(
        itemdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class LevelofData {
  LevelofData({
    required this.Code,
    required this.Name,
  });

  String? Code;
  String? Name;

  factory LevelofData.fromJson(Map<String, dynamic> json) =>
      LevelofData(
        Code: json['code'] ?? 00,
        Name: json['description'] ?? '',
      );

  Map<String, Object?> toMap() => {
        CusLevelDBModel.code: Code,
        CusLevelDBModel.name: Name,
      };
}
