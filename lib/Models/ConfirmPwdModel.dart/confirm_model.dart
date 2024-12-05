
import 'dart:convert';

class ConfirmPwdModel {
  // {respType: Success, respCode: SK200, respDesc: User Password Updated Succesfully, data: {id: 5, tenantId: BUS002, userTypeId: 50, userCode: 601, userName: SANGEETHA R, password: 1@123, deviceName: Redmi M2004J19C, deviceCode: QP1A.190711.020, fcmToken: cysDhMf7SWu8PwLHStf_uT:APA91bGb0Y5DfaQEhVB8nCO3k8hTvhAzbkP6qRgXmqWpVI6sVsGBsGV0BbYEZ1zqvwrcOaE1x67Ls3f1d4dnaz-eCUFmnn0noUu0F2gK5OhA4O3VjR7OCFgxZYsYciquQVzYaqmG4Z2k, storeId: 64, currentLicenseKey: 349D-49E0-FCF1-42E0, profileUrl: , licenseActivatedOn: 2023-10-09T00:00:00, licenseValidTill: 2024-12-31T00:00:00, mobile: 8526202466, email: , createdBy: 1, createdOn: 2023-10-07T00:00:00, updatedBy: 1, updatedOn: 2024-02-12T12:40:30.473, status: 1, isMobileUser: true, isPortalUser: false, reportingTo: Admin, slpCode: 601, userBranch: KMK1, restrictionType: 1, userBrandLists: [], userCategoryLists: [], userStoresLists: [], userRestrictionMappings: []}}

  String? respType;
  String? respCode;
  String? respDesc;
  int? statuscode;
  String? exception;
  ChangePwdData? data;
  ConfirmPwdModel(
      {required this.respCode,
      required this.respDesc,
      required this.respType,
      this.data,
      required this.exception,
      required this.statuscode});

  factory ConfirmPwdModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["respType"] == "Success") {
      return ConfirmPwdModel(
          exception: null,
          respCode: jsons["respCode"],
          respDesc: jsons['respDesc'],
          respType: jsons['respType'],
          // data: jsons['data'],
          statuscode: stcode);
    } else {
      return ConfirmPwdModel(
          respCode: null,
          respDesc: null,
          respType: null,
          exception: '',
          statuscode: stcode);
    }
  }
  factory ConfirmPwdModel.error(String jsons, int stcode) {
    return ConfirmPwdModel(
      respCode: null,
      respDesc: null,
      respType: null,
      statuscode: stcode,
      exception: jsons,
    );
  }
}

class ChangePwdData {
  String licenseKey;
  String fcmToken;
  String createdOn;
  String UserID;
  String updatedOn;
  String userName;
  String updatePassword;
  String userType;
  String slpcode;
  String? urlColumn;
  String tenantId;
  String devicecode;
  String userCode;
  String? storeid;
  String? reportingTo;

  ChangePwdData({
    required this.storeid,
    required this.userName,
    required this.licenseKey,
    this.urlColumn,
    required this.tenantId,
    required this.UserID,
    required this.devicecode,
    required this.userCode,
    required this.reportingTo,
    required this.createdOn,
    required this.fcmToken,
    required this.slpcode,
    required this.updatedOn,
    required this.userType,
    required this.updatePassword,
  });
  factory ChangePwdData.fromJson(dynamic json) {
    return ChangePwdData(
        licenseKey: json["currentLicenseKey"] ?? '',
        tenantId: json["tenantId"],
        userCode: json['userCode'],
        UserID: json['id'],
        userName: json[' userName'],
        devicecode: json['deviceCode'],
        userType: json['userTypeId'],
        slpcode: json['slpCode'],
        storeid: json['storeId'] ?? '',
        reportingTo: json['reportingTo'],
        createdOn: json['createdOn'],
        fcmToken: json['fcmToken'],
        updatedOn: json['updatedOn'],
        updatePassword: json['password']);
  }
}
// import 'dart:convert';


// class ConfirmPwdModel{
// String? status;
//   String? updateMsg;
//  String? exception;
//   int? statuscode;
// ConfirmPwdModel({
//   required this.status,
//   required this.updateMsg,
//     required this.statuscode,
//       required this.exception
// });

//  factory ConfirmPwdModel.fromJson(Map<String, dynamic> jsons, int stcode) {
//     if (jsons["status"] == "Success") {
//       return ConfirmPwdModel(
//           status: jsons["status"],
//           updateMsg: jsons["responceMsg"],
//           statuscode: stcode,
//           exception: null);
//     } else {
//       return ConfirmPwdModel(
//           status: null,
//           updateMsg: null,
//           statuscode: stcode,
//           exception: "No route to host");
//     }
//   }
//   factory ConfirmPwdModel.error(String jsons, int stcode) {
//     return ConfirmPwdModel(
//         status: null,
//         statuscode: stcode,
//         updateMsg: null,
//         exception: jsons,
//         );
//   }
// }

