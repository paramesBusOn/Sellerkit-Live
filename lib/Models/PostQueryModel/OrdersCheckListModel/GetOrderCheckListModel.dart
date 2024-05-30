import 'dart:convert';
import '../../../DBModel/EnqTypeModel.dart';

class OrdersCheckListModal {
  List<OrderCheckData>? Ordercheckdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  OrdersCheckListModal(
      {required this.Ordercheckdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory OrdersCheckListModal.fromJson(List< dynamic> jsons, int stcode) {
    if (jsons != null) {
      var list = jsons as List;
      List<OrderCheckData> dataList =
          list.map((data) => OrderCheckData.fromJson(data)).toList();
      return OrdersCheckListModal(
          Ordercheckdata: dataList,
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return OrdersCheckListModal(
          Ordercheckdata: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory OrdersCheckListModal.error(String jsons, int stcode) {
    return OrdersCheckListModal(
        Ordercheckdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class OrderCheckData {
  OrderCheckData(
      {required this.MasterTypeId,
      required this.id,
      this.linenum,
      required this.Code, 
      required this.Name, 
      required this.ischecked
      });
int? id;
int? MasterTypeId;
int? linenum;
  String? Code;
  String? Name;
  bool? ischecked;

  factory OrderCheckData.fromJson(Map<String, dynamic> json) => OrderCheckData(
      Code: json['code'] ?? '', Name: json['description'] ?? '', ischecked: false,
      id: json['id'],
      MasterTypeId: json['masterTypeId'],
      // linenum: json['lineId']
      );

  Map<String, dynamic> tojson() {
    Map<String, dynamic> map = {
      "id": 0,
      "docEntry": 0,
      "U_ChkCode": Code,
      "U_ChkName": Name,
      "U_ChkValue": ischecked == false?'No':'Yes',
      "lineId":linenum,
      "visOrder": 0,
      "object": "",
      "logInst": "",
    };
    return map;
  }


  Map<String, dynamic> tojson2() {
    Map<String, dynamic> map = {
     "id": 0,
    "visitActivitiesId": 0,
      "u_CheckCode": Code,
      "u_Checkvalue": ischecked == false?'No':'Yes',
      
    };
    return map;
  }
}
