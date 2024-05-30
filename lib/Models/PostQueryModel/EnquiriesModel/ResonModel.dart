import 'dart:convert';

class ResonModal {
List<ResonData>? userLtData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  ResonModal(
      {required this.userLtData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory ResonModal.fromJson(List<dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<ResonData> dataList =
          list.map((data) => ResonData.fromJson(data)).toList();
      return ResonModal(
        userLtData: dataList,
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return ResonModal(
        userLtData: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory ResonModal.error(String jsons,int stcode) {
    return ResonModal(
        userLtData: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class ResonData {
  ResonData({
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
    required this.updatedOn,
    required this.nextStatus
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
  int? nextStatus;



  factory ResonData.fromJson(Map<String, dynamic> json) =>
   ResonData(
    nextStatus:json["nextStatus"],
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
