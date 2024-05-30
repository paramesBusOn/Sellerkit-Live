import 'dart:convert';

class DayEndDetails {
  DayEndData? earning1data;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  DayEndDetails(
      {required this.earning1data,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory DayEndDetails.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      // var list = jsons as List;
      // List<DayEndData> dataList =
      //     list.map((data) => DayEndData.fromJson(data)).toList();
      return DayEndDetails(
          earning1data: DayEndData.fromJson(jsons),
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return DayEndDetails(
          earning1data: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory DayEndDetails.error(String jsons, int stcode) {
    return DayEndDetails(
        earning1data: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class DayEndData {
  int? monthEarning;
  int? todayEarning;
  DayEndData({
    required this.monthEarning,
    required this.todayEarning,
  });

  factory DayEndData.fromJson(Map<String, dynamic> json) => DayEndData(
        monthEarning: json['mtD_Earning'] ?? "",
        todayEarning: json['today_Earning'] ?? "",
      );
}
