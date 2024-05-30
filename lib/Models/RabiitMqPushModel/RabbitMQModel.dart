import 'dart:convert';

class RabiitMqModel {
  String? message;
  int? status;
  String? exception;
  int? stcode;
  RabiitMqModel(
      {
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory RabiitMqModel.fromJson(Map<String, dynamic> jsons, int stcode) {
  
      return RabiitMqModel(
          message: jsons["message"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    
  }

  factory RabiitMqModel.error(String jsons, int stcode) {
    return RabiitMqModel(
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

