import 'dart:convert';

class EarningModel1 {
  EarningData1? earning1data;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  EarningModel1(
      {required this.earning1data,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory EarningModel1.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      // var list = jsons as List;
      // List<EarningData1> dataList =
      //     list.map((data) => EarningData1.fromJson(data)).toList();
      return EarningModel1(
          earning1data: null,
          message: jsons['respCode'],
          status: true,
          stcode: stcode,
          exception: jsons['respDesc']);
    } else {
      return EarningModel1(
          earning1data: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }
  factory EarningModel1.issue(Map<String, dynamic> jsons, int stcode) {
    return EarningModel1(
        earning1data: null,
        message: jsons["respCode"] ?? '',
        status: null,
        stcode: stcode,
        exception: jsons['respDesc']);
  }
  factory EarningModel1.error(String jsons, int stcode) {
    return EarningModel1(
        earning1data: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class EarningData1 {
  int? monthEarning;
  int? todayEarning;
  EarningData1({
    required this.monthEarning,
    required this.todayEarning,
  });

  factory EarningData1.fromJson(Map<String, dynamic> json) => EarningData1(
        monthEarning: json['mtD_Earning'] ?? "",
        todayEarning: json['today_Earning'] ?? "",
      );
}
