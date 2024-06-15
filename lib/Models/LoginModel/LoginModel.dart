// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:convert';
import 'dart:math';

class LoginModel {
  String? loginstatus;
  String? loginMsg;
  LoginModelData? data;
  int? resCode;
  String? excep;
  String? token;

  List<LoginVerificationList>? loginVerifiList;

  LoginModel(
      {required this.loginstatus,
      required this.loginMsg,
      required this.loginVerifiList,
      this.data,
      this.excep,
      this.token,
      required this.resCode});

  factory LoginModel.fromJson(Map<String, dynamic> jsons,
      Map<String, dynamic> verifijsons, int rescode) {
    if (jsons != null) {
      print("AANBHHH+$verifijsons");
      var list = verifijsons['restrictionData'] as List;
      if(list.isEmpty){
       return LoginModel(
          loginstatus: "success",
          loginMsg: "success",
          data: LoginModelData.fromJson(jsons),
          excep: null,
          loginVerifiList: null,
          resCode: rescode,
           token: verifijsons['token']
          ); 
      }else{
List<LoginVerificationList> dataList =
          list.map((data) => LoginVerificationList.fromJson(data)).toList();
      //
      return LoginModel(
        loginstatus: "success",
        loginMsg: "success",
        data: LoginModelData.fromJson(jsons),
        loginVerifiList: dataList,
        resCode: rescode,
        excep: null,
         token: verifijsons['token']
      );
      }
      
    } else {
      return LoginModel(
          loginstatus: "failed",
          loginMsg: "failed",
          data: null,
          excep: null,
          loginVerifiList: null,
          resCode: rescode);
    }
  }

  factory LoginModel.issue(int rescode, Map<String, dynamic> exp) {
    return LoginModel(
        excep: exp['respDesc'],
        resCode: rescode,
        loginstatus: null,
        loginMsg: null,
        loginVerifiList: null,
        data: null);
  }

  factory LoginModel.issue2(int rescode, String exp) {
    return LoginModel(
        excep: exp,
        resCode: rescode,
        loginstatus: null,
        loginMsg: null,
        loginVerifiList: null,
        data: null);
  }

  factory LoginModel.error(int rescode, String exp) {
    return LoginModel(
        excep: exp,
        resCode: rescode,
        loginstatus: null,
        loginMsg: "Catch",
        loginVerifiList: null,
        data: null);
  }
}

class LoginModelData {
  String licenseKey;
  // String endPointUrl;
  // String sessionID;
  String UserID;
  // String userDB;
  // String dbUserName;
  // String dbPassword;
  String userType;
  String slpcode;
  String urlColumn;
  String tenantId;
  String devicecode;
  String userCode;
  String? storeid;
  String? storecode;

  LoginModelData(
      {required this.storeid,
      required this.licenseKey,
      required this.urlColumn,
      required this.tenantId,
      required this.UserID,
      required this.devicecode,
      required this.userCode,
      required this.storecode,
      // required this.dbPassword,
      required this.userType,
      required this.slpcode});

  factory LoginModelData.fromJson(Map<String, dynamic> json) {
    return LoginModelData(
        licenseKey: json["LicenseKey"] ?? '',
        urlColumn: json[
            "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"],
        tenantId: json["TenantId"],
        userCode: json['UserCode'],
        UserID: json['USerId'],
        devicecode: json['DeviceCode'],
        // dbPassword: json['dbPassword'],
        userType: json['UserTypeId'],
        slpcode: json['Slpcode'],
        storeid: json['StoreId'] ?? '',
        storecode: json['StoreCode']);
  }
  // {"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier":"DFG56","USerId":"3","TenantId":"cc45","DeviceCode":"","UserCode":"2233","UserTypeId":"1","LicenseKey":"","Slpcode":"EMP01"}
}

class LoginVerificationList {
  int? id;
  String? code;
  int? restrictionType;
  String? restrictionData;
  String? remarks;

  LoginVerificationList({
    required this.id,
    required this.code,
    required this.restrictionData,
    required this.restrictionType,
    required this.remarks,
  });

  factory LoginVerificationList.fromJson(Map<String, dynamic> json) {
    return LoginVerificationList(
      id: json["id"] ?? 0,
      code: json["code"] ?? '',
      restrictionType: json["restrictionType"] ?? 0,
      restrictionData: json['restrictionData'] ?? '',
      remarks: json['remarks'] ?? '',
    );
  }
  // {"http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier":"DFG56","USerId":"3","TenantId":"cc45","DeviceCode":"","UserCode":"2233","UserTypeId":"1","LicenseKey":"","Slpcode":"EMP01"}
}

class PostLoginData {
  String? deviceCode;
  String? licenseKey;
  String? username;
  String? password;
  String? fcmToken;
  String? ipaddress;
  String? ipName;
  String? latitude;
  String? langtitude;
      String? devicename;
}
