import 'dart:convert';

class CameAsModal {
List<CameAsData>? camaAsData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  CameAsModal(
      {required this.camaAsData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory CameAsModal.fromJson(List<dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<CameAsData> dataList =
          list.map((data) => CameAsData.fromJson(data)).toList();
      return CameAsModal(
        camaAsData: dataList,
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return CameAsModal(
        camaAsData: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory CameAsModal.error(String jsons,int stcode) {
    return CameAsModal(
        camaAsData: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class CameAsData {
  CameAsData({
    required this.CODE,
    required this.color,
    required this.createdBy,
    required this.createdOn,
    required this.description,
    required this.id,
    required this.mastertypeid,
    required this.parentMasterId,
    required this.status,
    required this.updatedBy,
    required this.updatedOn
  });

  String? CODE;
  int? color;
  int? id;
  int? mastertypeid;
  String? description;
  int? parentMasterId;
  int? status;
  int? createdBy;
  String? createdOn;
  int? updatedBy;
  String? updatedOn; 



  factory CameAsData.fromJson(Map<String, dynamic> json) =>
   CameAsData(
    CODE: json['code'], 
    color: 0, 
    createdBy: json['createdBy'], 
    createdOn: json['createdOn']??'', 
    description: json['description'], 
    id: json['id'], 
    mastertypeid: json['masterTypeId'], 
    parentMasterId: json['parentMasterId'], 
    status: json['status'], 
    updatedBy: json['updatedBy'], 
    updatedOn: json['updatedOn']
    );
   
}
