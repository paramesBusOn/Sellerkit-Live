import 'dart:convert';

class AgeModal {
List<AgeData>? ageLtData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  AgeModal(
      {required this.ageLtData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory AgeModal.fromJson(List<dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<AgeData> dataList =
          list.map((data) => AgeData.fromJson(data)).toList();
      return AgeModal(
        ageLtData: dataList,
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return AgeModal(
        ageLtData: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory AgeModal.error(String jsons,int stcode) {
    return AgeModal(
        ageLtData: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class AgeData {
  AgeData({
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



  factory AgeData.fromJson(Map<String, dynamic> json) =>
   AgeData(
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
