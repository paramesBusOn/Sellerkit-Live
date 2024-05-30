import 'dart:convert';

class GenderModal {
List<GenderData>? genderLtData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  GenderModal(
      {required this.genderLtData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory GenderModal.fromJson(List<dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<GenderData> dataList =
          list.map((data) => GenderData.fromJson(data)).toList();
      return GenderModal(
        genderLtData: dataList,
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return GenderModal(
        genderLtData: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory GenderModal.error(String jsons,int stcode) {
    return GenderModal(
        genderLtData: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class GenderData {
  GenderData({
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



  factory GenderData.fromJson(Map<String, dynamic> json) =>
   GenderData(
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
