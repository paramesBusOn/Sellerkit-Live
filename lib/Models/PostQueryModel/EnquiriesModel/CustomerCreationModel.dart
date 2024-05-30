// ignore_for_file: omit_local_variable_types


// ignore_for_file: omit_local_variable_types

import 'dart:convert';
import 'dart:developer';

class NewCustomerEnqValue{
String? CardCode;
String ?CardName;
 int? stcode;
 int? DocEntry;

  int? DocNo;
  String?U_sk_email;
  String?U_sk_NextFollowDt;
  datadetails? datali;
//  Error? error ;
String?exception;
String? message;
String ?odatametadata;
NewCustomerEnqValue({
  this.message,
  this.CardCode,
  this.CardName,
  this.datali,
// this.error,
required this.stcode,
this.exception,
this.odatametadata
});

 factory NewCustomerEnqValue.fromJson(Map<String, dynamic> jsons,int stcode) {
     if(jsons["data"] !=null){
      var list=json.decode(jsons["data"]as String) as Map<String,dynamic>;
      return NewCustomerEnqValue(
        stcode: stcode,
        exception:null,
        datali:datadetails.fromJson(list),

        );
      
     }else{
       return NewCustomerEnqValue(
        stcode: stcode,
        exception:null,
        datali:null,

        );

     }

    
 }

   factory NewCustomerEnqValue.issue(Map<String, dynamic> json,int? stcode) {
      return NewCustomerEnqValue(
        CardCode:null,
        CardName: null,
       odatametadata: null,
       stcode:stcode,
       message:json["respCode"]??'',
      //  error:json==null?null: Error.fromJson(json['error']),
       exception: json['respDesc']
          );
  }

     factory NewCustomerEnqValue.exception(String exp,int? stcode) {
      return NewCustomerEnqValue(
        CardCode:null,
        CardName: null,
       odatametadata: null,
       stcode:stcode,
      //  error:null,
       exception: exp
          );
  }
}

class datadetails{
  List<leadmaster>? leaddetail;
  List<LeadLine>? dataline;
  
  datadetails({
    required this.leaddetail,
    required this.dataline,
  });

   factory datadetails.fromJson(Map<String, dynamic> jsons) {
     if(jsons['LeadMaster'] != null && jsons['LeadLine'] !=null){
     var list =  jsons['LeadMaster'] as List; 
     var list2 =  jsons['LeadLine'] as List; 
     log("ghhhhhh::"+list.toString());
      List<leadmaster> dataList = list
          .map((enquiries) => leadmaster.fromJson(enquiries))
          .toList();
           List<LeadLine> dataList2 = list2
          .map((enquiries) => LeadLine.fromJson(enquiries))
          .toList();
      return datadetails(
       leaddetail:dataList,
       dataline:dataList2,
       
        // error: null
      );
      }else{
 return datadetails(
       
       leaddetail:null,
       dataline:null,
      );
      }
  }
}

class leadmaster{
int? DocEntry;
  String? CardCode;
  String? CardName;
  int? DocNo;
  String?U_sk_email;
  String?U_sk_NextFollowDt;

  leadmaster({
required this.DocEntry,
      required this.CardCode,
      required this.CardName,
      // this.error,
    required   this.DocNo,
      
    required  this.U_sk_email,
    required  this.U_sk_NextFollowDt
  });

  factory leadmaster.fromJson(Map<String, dynamic> jsons) {
    return leadmaster(
      DocEntry: jsons["LeadId"], 
      CardCode: jsons["CustomerCode"], 
      CardName: jsons["CustomerName"], 
      DocNo: jsons["LeadId"], 
      U_sk_email: jsons["CustomerEmail"], 
      U_sk_NextFollowDt: jsons["NextFollowupDate"]
      );

  }
}

//seconde
class LeadLine{
int? leadid;
  
  String? itemCode;
  String? itemName;

  LeadLine({

      // this.error,
    required   this.leadid,
      
    required  this.itemCode,
    required  this.itemName
  });

  factory LeadLine.fromJson(Map<String, dynamic> jsons) {
    return LeadLine(
      leadid: jsons["LeadId"], 
      itemCode: jsons["ItemCode"], 
      itemName: jsons["ItemName"], 
      
      );

  }
}


// class Error{
//   int? code;
//   Message?message;
//  Error({
//    this.code,
//   this.message
//  });

//   factory Error.fromJson(dynamic jsons) {
//     return Error(
//       code: jsons['code']as int,
//      message: Message.fromJson(jsons['message']),
//        );
//  }
// }

//  class Message{
//   String ?lang;
//   String ? value; 
//  Message({
//    this.lang,
//    this.value,
//  });

//   factory Message.fromJson(dynamic jsons) {
//     return Message(
//     //  groupCode: jsons['GroupCode'] as int, 
//       lang: jsons['lang']as String,
//       value: jsons['value'] as String,
   
//        );
//  }
//  }