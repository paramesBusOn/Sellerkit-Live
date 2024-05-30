import 'dart:convert';

class GetLeadDetailsQTL {
  List<GetLeadDeatilsQTLData>? leadDeatilsQTLData;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetLeadDetailsQTL(
      {required this.leadDeatilsQTLData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetLeadDetailsQTL.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != "No data found" && jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<GetLeadDeatilsQTLData> dataList =
          list.map((data) => GetLeadDeatilsQTLData.fromJson(data)).toList();
      return GetLeadDetailsQTL(
          leadDeatilsQTLData: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return GetLeadDetailsQTL(
          leadDeatilsQTLData: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory GetLeadDetailsQTL.error(String jsons, int stcode) {
    return GetLeadDetailsQTL(
        leadDeatilsQTLData: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetLeadDeatilsQTLData {
  int? LeadDocEntry;
  int? LeadNum;
  String? ItemCode;
  String? ItemName;
  double? Quantity;
  double? Price;

  GetLeadDeatilsQTLData({
    required this.LeadDocEntry,
    required this.LeadNum,
    required this.ItemCode,
    required this.ItemName,
    required this.Quantity,
    required this.Price,
  });

  factory GetLeadDeatilsQTLData.fromJson(Map<String, dynamic> json) => GetLeadDeatilsQTLData(
        LeadDocEntry: json['LeadDocEntry'] ?? -1,
        LeadNum: json['LeadNum'] ?? -1,
        ItemCode: json['ItemCode'] ?? '',
        ItemName: json['ItemName'] ?? '',
        Quantity: json['Quantity'] ?? 0.00,
        Price: json['Price'] ?? 0.00,
      );
}
