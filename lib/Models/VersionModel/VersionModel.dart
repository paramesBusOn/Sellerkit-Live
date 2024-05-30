// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_null_comparison

import 'dart:convert';

class VersionModel {
  List<VersionModelData>? itemdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  VersionModel(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory VersionModel.fromJson(List<dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      // print("object::" + jsons.toString());
      var list = jsons as List;
      List<VersionModelData> dataList =
          list.map((data) => VersionModelData.fromJson(data)).toList();
      return VersionModel(
          itemdata: dataList,
          message: "sucess",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return VersionModel(
          itemdata: null,
          message: "failed",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }
  factory VersionModel.issue(int rescode, Map<String, dynamic> exp) {
    return VersionModel(
         itemdata: null,
        message: exp['respCode'],
        status: null,
        stcode: rescode,
        exception: exp['respDesc']
       );
  }

  factory VersionModel.error(String jsons, int stcode) {
    return VersionModel(
        itemdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class VersionModelData {
  VersionModelData({
    required this.url,
    required this.content,
    required this.version,
  });

  String? url;
  String? content;
  String? version;

  factory VersionModelData.fromJson(Map<String, dynamic> json) =>
      VersionModelData(
        url: json['url'] ?? '',
        content: json['content'] ?? '',
        version: json['vertion'] ?? '',
      );
}
