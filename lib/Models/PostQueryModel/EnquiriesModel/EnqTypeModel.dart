// ignore_for_file: unnecessary_null_comparison, unnecessary_cast

import 'dart:convert';
import '../../../DBModel/EnqTypeModel.dart';

class EnquiryTypeModal {
List<EnquiryTypeData>? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  EnquiryTypeModal(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory EnquiryTypeModal.fromJson(List<dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list =jsons as List;
      List<EnquiryTypeData> dataList =
          list.map((data) => EnquiryTypeData.fromJson(data)).toList();
      return EnquiryTypeModal(
        itemdata: dataList,
        message: "sucess",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return EnquiryTypeModal(
        itemdata: null,
        message: "failed",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory EnquiryTypeModal.issues(Map<String,dynamic> jsons,int stcode) {
    return EnquiryTypeModal(
        itemdata: null, message: jsons['respCode'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }

  factory EnquiryTypeModal.error(String jsons,int stcode) {
    return EnquiryTypeModal(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class EnquiryTypeData {
  EnquiryTypeData({
    required this.Code,
    required this.Name,


  });

  String? Code;
  String? Name;


  factory EnquiryTypeData.fromJson(Map<String, dynamic> json) =>
   EnquiryTypeData(
     Code: json['code'] ?? 00,
     Name: json['description'] ?? '',
     );
   
   Map<String , Object?> toMap()=>{
  EnqTypeDBModel.code:Code,
  EnqTypeDBModel.name:Name,
};
}
