import 'dart:convert';
import 'dart:developer';

class LoginVerificationModel {
  LoginVerificationDetails? datalist;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  // String? data;
  LoginVerificationModel(
      {required this.datalist,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode,
      // this.data
      });
  factory LoginVerificationModel.fromJson(
      Map<String, dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      return LoginVerificationModel(
          datalist: LoginVerificationDetails.fromJson(jsons['data']),
          message: jsons['msg'],
          status: jsons['status'],
          // data:jsons['data']??'',
          stcode: stcode,
          exception: null);
    } else {
      return LoginVerificationModel(
          datalist: null,
          message: jsons.toString(),
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory LoginVerificationModel.error(String jsons, int stcode) {
    return LoginVerificationModel(
        datalist: null,
        message: jsons,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class LoginVerificationDetails {
  LoginVerificationDetails({
    required this.fcm,
    required this.devicecode,
    required this.devicename
  });

  String? fcm;
  String? devicecode;
  String? devicename;

  factory LoginVerificationDetails.fromJson(Map<String, dynamic> json) =>
      LoginVerificationDetails(
        fcm: json['fcm'],
        devicecode: json['devicecode'],
         devicename:json['deviceName']??''
      );
}
