import 'dart:convert';

class GetOrderDetailsL {
  List<GetOrderDeatilsLData>? OrderDeatilsOrderData;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetOrderDetailsL(
      {required this.OrderDeatilsOrderData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetOrderDetailsL.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != "No data found" && jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<GetOrderDeatilsLData> dataList =
          list.map((data) => GetOrderDeatilsLData.fromJson(data)).toList();
      return GetOrderDetailsL(
          OrderDeatilsOrderData: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return GetOrderDetailsL(
          OrderDeatilsOrderData: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory GetOrderDetailsL.error(String jsons, int stcode) {
    return GetOrderDetailsL(
        OrderDeatilsOrderData: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetOrderDeatilsLData {
  String? FollowMode;
  String? Followup_Date_Time;
  String? Status;
  String? Feedback;
  int? FollowupEntry;
  int? OrderDocEntry;
  String? NextFollowup_Date;
  String? UpdatedBy;

  GetOrderDeatilsLData({
    required this.FollowMode,
    required this.Followup_Date_Time,
    required this.Status,
    required this.Feedback,
    required this.FollowupEntry,
    required this.OrderDocEntry,
    required this.NextFollowup_Date,
    required this.UpdatedBy
  });

  factory GetOrderDeatilsLData.fromJson(Map<String, dynamic> json) => GetOrderDeatilsLData(
        FollowMode: json['FollowMode']== 'Phone'?'Phone Call':
json['FollowMode']== 'Visit'?'Store Visit':json['FollowMode']== 'Text'?'Sms/WhatsApp':
json['FollowMode']== 'Other'?'Other':'',
        Followup_Date_Time: json['Followup_Date_Time'] ?? '',
        Status: json['Status'] ?? '',
        Feedback: json['Feedback'] ?? '',
        FollowupEntry: json['FollowupEntry'] ?? -1,
        OrderDocEntry: json['OrderDocEntry'] ?? -1,
        NextFollowup_Date: json['NextFollowup_Date'] ?? '',
        UpdatedBy: json['UpdatedBy'] ?? '',
      );
}
