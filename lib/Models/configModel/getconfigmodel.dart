
// ignore_for_file: unnecessary_null_comparison, unnecessary_cast

import 'dart:convert';
import '../../../DBModel/EnqTypeModel.dart';

class GetconfigModal {
List<GetconfigData>? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  GetconfigModal(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory GetconfigModal.fromJson(List<dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list =jsons as List;
      List<GetconfigData> dataList =
          list.map((data) => GetconfigData.fromJson(data)).toList();
      return GetconfigModal(
        itemdata: dataList,
        message: "sucess",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return GetconfigModal(
        itemdata: null,
        message: "failed",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory GetconfigModal.issues(Map<String,dynamic> jsons,int stcode) {
    return GetconfigModal(
        itemdata: null, message: jsons['respCode'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }

  factory GetconfigModal.error(String jsons,int stcode) {
    return GetconfigModal(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class GetconfigData {
  GetconfigData({
    required this.config_Code,
    required this.config_value,


  });

  String? config_Code;
  String? config_value;


  factory GetconfigData.fromJson(Map<String, dynamic> json) =>
   GetconfigData(
     config_value: json['config_value'] ?? "",
     config_Code: json['config_Code'] ?? '',
     );
   
  
}
