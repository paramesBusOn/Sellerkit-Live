import 'dart:convert';

class GetSummaryOrderModal {
  GetOrderHeader? OrderSummaryheader;
  
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetSummaryOrderModal(
      {required this.OrderSummaryheader,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetSummaryOrderModal.fromJson(Map<String, dynamic> jsons, int stcode) {
          print("object1"+jsons.toString());

    if ( jsons != null) {
      print("object2"+jsons.toString());
      // var list = jsons as List;
      // List<SummaryOrderData> dataList =
      //     list.map((data) => SummaryOrderData.fromJson(data)).toList();
      return GetSummaryOrderModal(
          OrderSummaryheader:GetOrderHeader.fromJson(jsons) ,
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      print("object222"+jsons.toString());

      return GetSummaryOrderModal(
          OrderSummaryheader: null,
          message: "failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory GetSummaryOrderModal.error(String jsons, int stcode) {
    return GetSummaryOrderModal(
        OrderSummaryheader: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}
class GetOrderHeader{
List<SummaryOrderData>? OrderSumarydata;
GetOrderHeader({
required this.OrderSumarydata,
});
 factory GetOrderHeader.fromJson(Map<String, dynamic> jsons) {
    //  if (jsons["data"] != null) {
    var list = json.decode(jsons["data"]) as List;

    if (list.isEmpty) {
      return GetOrderHeader(
          
          OrderSumarydata: null,
          );
    } else {
      
      List<SummaryOrderData> dataList =
          list.map((data) => SummaryOrderData.fromJson(data)).toList();
      return GetOrderHeader(
          
          OrderSumarydata: dataList,
         );
    }
  }
}

class SummaryOrderData {

  String? Caption;
  String? Target;
  double Value;
  int? column;
  String? Status;
  String? BTG;

  SummaryOrderData({
 required this.BTG,
    required this.Caption,
    required this.Target,
    required this.Value,
    required this.Status,
    required this.column
  });

  factory SummaryOrderData.fromJson(Map<String, dynamic> json) { 
    print("object3"+json.toString());
    return SummaryOrderData(
        Caption: json['Caption'] ?? '',
        Target: json['Target'] ?? '',
        Value: json['Value'] ?? 0.00,
        Status: json['Status'] ?? '',
        column:json['column']??0,
        BTG: json['BTG']??"",
      );}

  // Map<String, dynamic> tojson() {
  //   Map<String, dynamic> map = {
  //     "OrderDocEntry": OrderDocEntry,
  //     "OrderNum": OrderNum,
  //     "U_ChkValue": ischecked == false?'No':'Yes'
  //   };
  //   return map;
  // }
}
