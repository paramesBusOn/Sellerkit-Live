// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

class QuickEnqPostModal {
  String? exception;
  int?stcode;
  String? resType;
  // Error? error ;
String? message;

  QuickEnqPostModal({
      this.exception,
      required this.stcode,
      required this.resType,
      // this.error,
      required this.message
      });
  factory QuickEnqPostModal.fromJson(Map<String, dynamic> jsons,int stcode) {
      return QuickEnqPostModal(
        stcode: stcode,
        exception:null,
        resType:jsons["respType"],
        // error: null,
        message:jsons['respDesc']
      );
  }

  factory QuickEnqPostModal.error(String jsons,int stcode) {
    return QuickEnqPostModal(
        stcode: stcode,
        exception:jsons,
        resType:null,
        // error: null,
        message: null
        );
  }

   factory QuickEnqPostModal.issue(Map<String, dynamic> jsons, int stcode) {
    return QuickEnqPostModal(
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