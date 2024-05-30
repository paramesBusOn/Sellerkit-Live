// ignore_for_file: unnecessary_cast

import 'dart:convert';
import '../../../DBModel/EnqTypeModel.dart';

class EnqRefferesModal {
List<EnqRefferesData>? enqReffersdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  EnqRefferesModal(
      {required this.enqReffersdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory EnqRefferesModal.fromJson(List<dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<EnqRefferesData> dataList =
          list.map((data) => EnqRefferesData.fromJson(data)).toList();
      return EnqRefferesModal(
        enqReffersdata: dataList,
        message:"true",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return EnqRefferesModal(
        enqReffersdata: null,
        message: "false",
        status: false,
        stcode: stcode,
        exception:"Error"
      );
    }
  }

   factory EnqRefferesModal.issues(Map<String,dynamic> jsons,int stcode) {
    return EnqRefferesModal(
        enqReffersdata: null, message: jsons['respCode'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }

  factory EnqRefferesModal.error(String jsons,int stcode) {
    return EnqRefferesModal(
        enqReffersdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class EnqRefferesData {
  EnqRefferesData({
    required this.Code,
    required this.Name,


  });

  String? Code;
  String? Name;


  factory EnqRefferesData.fromJson(Map<String, dynamic> json) =>
   EnqRefferesData(
     Code: json['code'] ?? '',
     Name: json['description'] ?? '',
     );
   
   Map<String , Object?> toMap()=>{
  EnqTypeDBModel.code:Code,
  EnqTypeDBModel.name:Name,
};
}