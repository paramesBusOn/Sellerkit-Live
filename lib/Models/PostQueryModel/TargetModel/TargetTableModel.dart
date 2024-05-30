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
  factory TargetTableModal.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<TargetTableData> dataList =
          list.map((data) => TargetTableData.fromJson(data)).toList();
      return TargetTableModal(
          targetcheckdata: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return TargetTableModal(
          targetcheckdata: null,
          message: jsons["msg"],
          status: jsons["status"],
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
  String? target;
  String? achieved;
  String? ach;

  TargetTableData({
    required this.ach,
    required this.achieved,
    required this.segment,
    required this.tPeriod,
    required this.target,
  });

  factory TargetTableData.fromJson(Map<String, dynamic> json) =>
      TargetTableData(
        ach: json['Ach%'],
        achieved: json['Achieved'],
        segment: json['Segment'],
        tPeriod: json['TPeriod'],
        target: json['Target'],
      );
}
