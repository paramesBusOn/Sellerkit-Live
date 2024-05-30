import 'dart:convert';

import '../../../DBModel/EnqTypeModel.dart';

class UserListModal {
List<UserListData>? userLtData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  UserListModal(
      {required this.userLtData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory UserListModal.fromJson(List<dynamic> jsons,int stcode) {
    if (jsons  != null && jsons.isNotEmpty) {
      var list = jsons as List;
      List<UserListData> dataList =
          list.map((data) => UserListData.fromJson(data)).toList();
      return UserListModal(
        userLtData: dataList,
        message: "sucess",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return UserListModal(
        userLtData: null,
        message: "failed",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory UserListModal.issues(Map<String,dynamic> jsons,int stcode) {
    return UserListModal(
        userLtData: null, message: jsons['respCode'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }

  factory UserListModal.error(String jsons,int stcode) {
    return UserListModal(
        userLtData: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class   UserListData {
  UserListData({
    required this.storeid,
    // required this.UserKey,
    required this.mngSlpcode,
    required this.userCode,
    required this.UserName,
    required this.color,
    required this.slpcode,
    required this.SalesEmpID
  });

  // int? UserKey;
  String? userCode;
  String? slpcode;
    String? mngSlpcode;
int? storeid;
  String? UserName;
  int? color;
  int?SalesEmpID;
  // int?EmployeeID;

  factory UserListData.fromJson(Map<String, dynamic> json) =>
   UserListData(
     //  UserKey: json['UserKey'] ??0,
     storeid: json["storeId"]??'',
     slpcode:json['slpCode']??'' ,
     mngSlpcode:json['reportingTo']??'' ,//reportingTo
     SalesEmpID: json['id'] ??0,
     userCode:json['userCode'],
     //  EmployeeID: json['EmployeeID'] ??0,
     //  UserCode: json['UserCode'] ?? '', ̰
     UserName: json['userName'] ?? '',
     color: 0
     );


  Map<String , Object?> toMap()=>{
  // UserListDBModel.userKey:UserKey,
  UserListDBModel.userCode:userCode,
  UserListDBModel.slpcode:slpcode,
  UserListDBModel.userName:UserName,
  UserListDBModel.managerSlp:mngSlpcode,
  UserListDBModel.salesEmpID:SalesEmpID,
  UserListDBModel.color:color,
  UserListDBModel.storeid:storeid
};
}