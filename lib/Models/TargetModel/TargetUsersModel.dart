import 'dart:convert';
import 'dart:developer';

class TargetUserModal {
  String? resCode;
  String? respType;
  String? respDesc;
  String? exception;
  int? stcode;
  List<TargetUserDataModel>? targetuserDataList;

  TargetUserModal(
      {required this.resCode,
      required this.respDesc,
      required this.respType,
      this.targetuserDataList,
      required this.exception,
      required this.stcode});

  factory TargetUserModal.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons['respType'].toString() == 'Success') {
      var list = jsonDecode(jsons['data'].toString()) as List;

      // log('Userlist::$list');
      List<TargetUserDataModel> dataList =
          list.map((data) => TargetUserDataModel.fromJson(data)).toList();

      return TargetUserModal(
          targetuserDataList: dataList,
          stcode: stcode,
          exception: null,
          resCode: jsons['resCode'],
          respDesc: jsons['respDesc'].toString(),
          respType: jsons['respType'].toString());
    } else {
      return TargetUserModal(
          targetuserDataList: null,
          resCode: jsons['resCode'].toString(),
          respDesc: jsons['respDesc'].toString(),
          respType: jsons['respType'].toString(),
          stcode: stcode,
          exception: null);
    }
  }
  factory TargetUserModal.error(String jsons, int stcode) {
    return TargetUserModal(
      targetuserDataList: null,
      resCode: null,
      respDesc: null,
      respType: null,
      stcode: stcode,
      exception: jsons,
    );
  }
}

class TargetUserDataModel {
  String? name;
  int? id;
  TargetUserDataModel({this.id, this.name});
  factory TargetUserDataModel.fromJson(Map<String, dynamic> json) =>
      TargetUserDataModel(id: json['AuthUserId'], name: json['AuthUserName']);
}
