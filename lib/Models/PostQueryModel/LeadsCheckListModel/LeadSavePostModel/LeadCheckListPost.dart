// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

class LeadcheckListPostModal {
  String? exception;
  int?stcode;
  int? DocNum;
  String? CardCode;
  String? CardName;
  Error? error ;

 LeadcheckListPostModal({
      this.exception,
      required this.stcode,
      required this.DocNum,
       this.CardCode,
       this.CardName,
      this.error
      });
  factory LeadcheckListPostModal.fromJson(Map<String, dynamic> jsons,int stcode) {
      return LeadcheckListPostModal(
        stcode: stcode,
        exception:null,
        DocNum:jsons["DocNum"],
        error: null
      );
  }

  factory LeadcheckListPostModal.error(String jsons,int stcode) {
    return LeadcheckListPostModal(
        stcode: stcode,
        exception:jsons,
        DocNum:null,
        CardCode:null,
        CardName:null,
        error: null
        );
  }

   factory LeadcheckListPostModal.issue(Map<String, dynamic> jsons, int stcode) {
    return LeadcheckListPostModal(
        stcode: stcode,
        exception:null,
        DocNum:null,
        CardCode:null,
        CardName:null,
        error: jsons==null?null: Error.fromJson(jsons['error']),
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



class PostLead
{
  String?DocType;
  String?DocDate;
  String? CardCode;
  String? U_sk_Address1;
  String? U_sk_Address2;
  String? U_sk_Pincode;
  String? U_sk_City;
  String? U_sk_alternatemobile;
  String? U_sk_headcount;
  String? U_sk_budget;
  String? CardName;
  String? U_sk_email;
  String? U_sk_gender;
  String? U_sk_Agegroup;
  String? U_sk_cameas;
  String? U_sk_Referals;
  String? U_sk_NextFollowDt;
  String? U_sk_planofpurchase;
  List<DocumentLines>? docLine;

  PostLead({
 this.CardCode,
 this.DocDate,
 this.DocType,
 this.U_sk_Address1,
 this.U_sk_Address2,
 this.U_sk_Pincode,
 this.U_sk_City,
 this.U_sk_alternatemobile,
 this.U_sk_budget,
 this.U_sk_headcount,
 this.CardName,
 this.U_sk_Agegroup,
 this.U_sk_NextFollowDt,
 this.U_sk_Referals,
 this.U_sk_cameas,
 this.U_sk_email,
 this.U_sk_gender,
 this.U_sk_planofpurchase,
 this.docLine
  });

Map<String,dynamic> tojson(){
  Map<String,dynamic> map ={
     "DocType":DocType,
     "DocDate":DocDate,
     "CardCode":CardCode,
     "CardName":CardName,
     "U_sk_Address1":U_sk_Address1,
     "U_sk_Address2":U_sk_Address2,
     "U_sk_Pincode":U_sk_Pincode,
     "U_sk_City":U_sk_City,
     "U_sk_alternatemobile":U_sk_alternatemobile,
     "U_sk_email":U_sk_email,
     "U_sk_headcount":U_sk_headcount,
     "U_sk_budget":U_sk_budget,
     "U_sk_gender":U_sk_gender,
     "U_sk_Agegroup":U_sk_Agegroup,
     "U_sk_cameas":U_sk_cameas,
     "U_sk_Referals":U_sk_Referals,
     "U_sk_NextFollowDt":U_sk_NextFollowDt,
     "U_sk_planofpurchase":U_sk_planofpurchase,
      "DocumentLines": docLine!.map((e) => e.tojason()).toList()
  };
  return map;
}
}

class DocumentLines
{
  String? ItemCode;
  String? ItemDescription;
  double? Quantity;
  double? Price;
  String? TaxCode;
  String? TaxLiable;
  double? LineTotal;

  DocumentLines({
    required this.ItemCode,
    required this.ItemDescription,
    required this.Quantity,
    required this.LineTotal,
    required this.Price,
    required this.TaxCode,
    required this.TaxLiable
  });


  Map<String,dynamic> tojason(){
    Map<String,dynamic> map ={
       "ItemCode":ItemCode,
       "ItemDescription":ItemDescription,
       "Quantity":Quantity,
       "LineTotal":LineTotal,
       "Price":Price,
       "TaxCode":TaxCode,
       "TaxLiable":TaxLiable,

    };
    return map;
  }
  
}