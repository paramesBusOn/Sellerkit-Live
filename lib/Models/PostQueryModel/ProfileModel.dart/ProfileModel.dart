// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
class ProfileModel {
ProfileData? profileData;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  ProfileModel(
      {required this.profileData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory ProfileModel.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons !=null && jsons.isNotEmpty) {
      // var list = jsons as List;
      // log("jsonS"+jsons.toString());
      // List<ProfileData> dataList =
      //     list.map((data) => ProfileData.fromJson(data)).toList();
      return ProfileModel(
        profileData: ProfileData.fromJson(jsons),
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return ProfileModel(
        profileData: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }
  factory ProfileModel.issues(Map<String,dynamic> jsons,int stcode) {
    return ProfileModel(
        profileData: null, 
        message: jsons['respCode'], 
        status: null,   
        stcode: stcode,
        exception:jsons['respDesc']);
  }

 

  factory ProfileModel.error(String jsons,int stcode) {
    return ProfileModel(
        profileData: null, 
        message: 'Exception', 
        status: null,   
        stcode: stcode,
        exception:jsons);
  }
}

class ProfileData {
  ProfileData({
    required this.USER_CODE,
    required this.USERID,
    required this.firstName,
    required this.lastName,
    required this.Branch,
    required this.email,
    required this.mobile,
    required this.ProfilePic,
    required this.managerAppUser,
    required this.managerCompanyUserID,
    required this.managerMailID,
    required this.managerPhone,


  });
//"ManagerCompanyUserID\":\"sk_chn1_4\",\"ManagerAppUser\":\"ramesh\",\"ManagerMailID\":\"ramesh@buson.in\",\"ManagerPhone\":\"7305408333\"}]"
  String? USER_CODE;
  int? USERID;
  String? firstName;
  String? lastName;
  String? Branch;
  String? email;
  String? mobile;
  String? ProfilePic;
String? managerCompanyUserID;
String? managerAppUser;
String? managerMailID;
String? managerPhone;

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
   ProfileData(
     USERID: json['userTypeId'] ?? 0,
     USER_CODE: json['userCode'] ?? '',
     firstName: json['userName'] ?? '',
     lastName: json['lastName'] ?? '',
     Branch: json['userBranch'] ?? '',
     email: json['email'] ?? '',
     mobile: json['mobile'] ?? '',
     ProfilePic: json['profileUrl'] ?? '',
     managerAppUser: json['ManagerAppUser']??'',
     managerCompanyUserID: json['reportingTo'] ?? '',
     managerMailID: json['ManagerMailID']?? '',
     managerPhone: json['ManagerPhone']??'',
   );
}
