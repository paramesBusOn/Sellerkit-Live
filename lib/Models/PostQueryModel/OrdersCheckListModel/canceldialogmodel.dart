import 'dart:convert';


class GetorderdialogModal {
  List<GetOrderdialogData>? orderdialogdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetorderdialogModal(
      {required this.orderdialogdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetorderdialogModal.fromJson(List<dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
     
    
      List<GetOrderdialogData> dataList =
          list.map((data) => GetOrderdialogData.fromJson(data)).toList();
       
      return GetorderdialogModal(
          orderdialogdata: dataList,
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return GetorderdialogModal(
          orderdialogdata: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory GetorderdialogModal.error(String jsons, int stcode) {
    return GetorderdialogModal(
        orderdialogdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetOrderdialogData {
  int? id;
  int? masterTypeId;

  String? code;
  String? name;
 

  GetOrderdialogData({
    required this.code,
    required this.name,
  
    this.id,
    this.masterTypeId
  });

  factory GetOrderdialogData.fromJson(Map<String, dynamic> json) =>
      GetOrderdialogData(
        id: json['id'],
        masterTypeId: json['masterTypeId'],
        code: json['code'] ?? '',
        name: json['description'] ?? '',
      );

//   Map<String, Object?> toMap() => {
//         LeadStatusReason.code: code,
//         LeadStatusReason.name: name,
//         LeadStatusReason.statusType: statusType,
//       };
}
class namedata{
  String? name;
  namedata({
    required this.name,
  });
}
