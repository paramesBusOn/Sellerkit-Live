import 'dart:convert';

class GetOrderDetailsQTL {
  List<GetOrderDeatilsQTLData>? OrderDeatilsQTLData;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetOrderDetailsQTL(
      {required this.OrderDeatilsQTLData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetOrderDetailsQTL.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != "No data found" && jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      List<GetOrderDeatilsQTLData> dataList =
          list.map((data) => GetOrderDeatilsQTLData.fromJson(data)).toList();
      return GetOrderDetailsQTL(
          OrderDeatilsQTLData: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return GetOrderDetailsQTL(
          OrderDeatilsQTLData: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory GetOrderDetailsQTL.error(String jsons, int stcode) {
    return GetOrderDetailsQTL(
        OrderDeatilsQTLData: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetOrderDeatilsQTLData {
  int? OrderDocEntry;
  int? OrderNum;
  String? ItemCode;
  String? ItemName;
  double? Quantity;
  double? Price;

  GetOrderDeatilsQTLData({
    required this.OrderDocEntry,
    required this.OrderNum,
    required this.ItemCode,
    required this.ItemName,
    required this.Quantity,
    required this.Price,
  });

  factory GetOrderDeatilsQTLData.fromJson(Map<String, dynamic> json) => GetOrderDeatilsQTLData(
        OrderDocEntry: json['OrderDocEntry'] ?? -1,
        OrderNum: json['OrderNum'] ?? -1,
        ItemCode: json['ItemCode'] ?? '',
        ItemName: json['ItemName'] ?? '',
        Quantity: json['Quantity'] ?? 0.00,
        Price: json['Price'] ?? 0.00,
      );
}
