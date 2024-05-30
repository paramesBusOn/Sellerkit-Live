// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

class EnqPostModal {
  String? exception;
  int?stcode;
  String? resType;
  // Error? error ;
String? message;

  EnqPostModal({
      this.exception,
      required this.stcode,
      required this.resType,
      // this.error,
      required this.message
      });
  factory EnqPostModal.fromJson(Map<String, dynamic> jsons,int stcode) {
      return EnqPostModal(
        stcode: stcode,
        exception:null,
        resType:jsons["respType"],
        // error: null,
        message:jsons['respDesc']
      );
  }

  factory EnqPostModal.error(String jsons,int stcode) {
    return EnqPostModal(
        stcode: stcode,
        exception:jsons,
        resType:null,
        // error: null,
        message: null
        );
  }

   factory EnqPostModal.issue(Map<String, dynamic> jsons, int stcode) {
    return EnqPostModal(
        stcode: stcode,
        exception:jsons['respDesc'],
        resType:jsons["respCode"]??'',
        // error: jsons==null?null: Error.fromJson(jsons['error']),
        message: null
        );
  }

  //json==null?null: Error.fromJson(json['error']),
}

class Error{
  int? code;
  Message?message;
 Error({
   this.code,
  this.message
 });

  factory Error.fromJson(dynamic jsons) {
    return Error(
      code: jsons['code']as int,
     message: Message.fromJson(jsons['message']),
       );
 }
}

 class Message{
  String ?lang;
  String ? value; 
 Message({
   this.lang,
   this.value,
 });

  factory Message.fromJson(dynamic jsons) {
    return Message(
    //  groupCode: jsons['GroupCode'] as int, 
      lang: jsons['lang']as String,
      value: jsons['value'] as String,
   
       );
 }
 }

// {
//     "respType": "error",
//     "respCode": "SK508",
//     "respDesc": "Enquiry - Invalid Referral Code",
//     "data": "[]"
// }