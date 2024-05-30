import 'dart:convert';

class TargetTableModal {
  List<TargetTableData>? targetcheckdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  TargetTableModal(
      {required this.targetcheckdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory TargetTableModal.fromJson(List< dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<TargetTableData> dataList =
          list.map((data) => TargetTableData.fromJson(data)).toList();
      return TargetTableModal(
          targetcheckdata: dataList,
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return TargetTableModal(
          targetcheckdata: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory TargetTableModal.error(String jsons, int stcode) {
    return TargetTableModal(
        targetcheckdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class TargetTableData {
  String? tPeriod;
  String? segment;
  double? target;
  double? achieved;
  double? ach;

  TargetTableData({
    required this.ach,
    required this.achieved,
    required this.segment,
    required this.tPeriod,
    required this.target,
  });

  factory TargetTableData.fromJson(Map<String, dynamic> json) =>
      TargetTableData(
        ach: json['achPercentage']??0.0,
        achieved: json['achieved']??0.0,
        segment: json['segment'] ?? "",
        tPeriod: json['tPeriod'] ?? "",
        target: json['target'] ??0.0,
      );
}
