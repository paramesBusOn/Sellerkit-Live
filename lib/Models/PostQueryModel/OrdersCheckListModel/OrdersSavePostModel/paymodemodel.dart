import 'dart:convert';

class PaymodeModal {
List<PaymodeModalData>? paymode;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  PaymodeModal(
      {required this.paymode,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory PaymodeModal.fromJson(List<dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<PaymodeModalData> dataList =
          list.map((data) => PaymodeModalData.fromJson(data)).toList();
      return PaymodeModal(
        paymode: dataList,
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return PaymodeModal(
        paymode: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory PaymodeModal.error(String jsons,int stcode) {
    return PaymodeModal(
        paymode: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class PaymodeModalData {
  PaymodeModalData({
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



  factory PaymodeModalData.fromJson(Map<String, dynamic> json) =>
   PaymodeModalData(
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
