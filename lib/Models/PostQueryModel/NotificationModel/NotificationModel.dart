import 'dart:convert';


class NofificationModel{
String? status;
  String? responceMsg;
 String? exception;
  int? statuscode;
NofificationModel({
  required this.status,
  required this.responceMsg,
    required this.statuscode,
      required this.exception
});

 factory NofificationModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["status"] == "Success") {
      return NofificationModel(
          status: jsons["status"],
          responceMsg: jsons["responceMsg"],
          statuscode: stcode,
          exception: null);
    } else {
      return NofificationModel(
          status: jsons["status"],
          responceMsg: jsons["responceMsg"],
          statuscode: stcode,
          exception: null);
    }
  }
  factory NofificationModel.error(String jsons, int stcode) {
    return NofificationModel(
        status: null,
        responceMsg: null,
        statuscode: stcode,
        exception: jsons,
        );
  }
}