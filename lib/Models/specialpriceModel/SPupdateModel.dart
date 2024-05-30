import 'dart:convert';
import 'dart:math';

class SPupdatePostModal {
  List<SPupdatePostheader>? SPSavePostheader;
  String? exception;
  int? stcode;
  String? message;
  

  SPupdatePostModal(
      {this.exception,
      this.message,
      required this.stcode,
      required this.SPSavePostheader
     
      });
  factory SPupdatePostModal.fromJson(Map<String, dynamic> jsons, int stcode) {
      // print("jsons['body']"+jsons['body'].toString());
      // print("quT2s"+jsons['docEntry'].toString());

    if (jsons != null&&jsons.isNotEmpty) {
      // print("jsons['quT2s']"+jsons['quT2s'].toString());
      var list =json.decode(jsons['data'])  as List;
      List<SPupdatePostheader> dataList =
          list.map((enquiries) => SPupdatePostheader.fromJson(enquiries)).toList();
      return SPupdatePostModal(
        SPSavePostheader:dataList,
        stcode: stcode,
        exception: null,
        message: jsons['respCode']
       
        // error: null
      );
    } else {
      print("wrong site");
      return SPupdatePostModal(
        SPSavePostheader:null,
        stcode: stcode,
        exception: "Failure",
        message: jsons['respCode']
       
        // error: null
      );
    }
  }

  factory SPupdatePostModal.error(String jsons, int stcode) {
    return SPupdatePostModal(
       SPSavePostheader:null,
      stcode: stcode,
      exception: jsons,
      
      // error: null
    );
  }

  

  factory SPupdatePostModal.issue(Map<String, dynamic> jsons, int stcode) {
    return SPupdatePostModal(
       SPSavePostheader:null,
      stcode: stcode,
      exception: jsons["respDesc"],
      message: jsons['respCode']
      
     
      // error: jsons==null?null: Error.fromJson(jsons['error']),
    );
  }

  //json==null?null: Error.fromJson(json['error']),
}

class SPupdatePostheader{
  int? DocEntry;
  String? RequestDate;
  String? FromDate;
  String? ToDate;
  String? CustomerCode;
  String? CustomerName;
  String? CustomerMobile;
  String? ItemCode;
  String? ItemName;
  double? Quantity;
  String? StoreCode;
  String? AssignedTo;
  double? RP;
  double? AP;
  double? SP;
  double? SSP1;
  double? SSP2;
  double? SSP3;
  double? SSP4;
  double? SSP5;
  double? MRP;
  double? Cost;
  String? Status;
  String? CreatedOn;
  String? UpdatedOn;

SPupdatePostheader({
required this.AP,
required this.AssignedTo,
required this.Cost,
required this.CreatedOn,
required this.CustomerCode,
required this.CustomerMobile,
required this.CustomerName,
required this.DocEntry,
required this.FromDate,
required this.ItemCode,
required this.ItemName,
required this.MRP,
required this.Quantity,
required this.RP,
required this.RequestDate,
required this.SP,
required this.SSP1,
required this.SSP2,
required this.SSP3,
required this.SSP4,
required this.SSP5,
required this.Status,
required this.StoreCode,
required this.ToDate,
required this.UpdatedOn
});

factory SPupdatePostheader.fromJson(Map<String,dynamic> json)=>
SPupdatePostheader(
  AP: json["AP"]??0.0, 
  AssignedTo:json["AssignedTo"]??'' , 
  Cost: json["Cost"]??0.0, 
  CreatedOn: json["CreatedOn"]??'', 
  CustomerCode: json["CustomerCode"]??'', 
  CustomerMobile:json["CustomerMobile"]??'' , 
  CustomerName:json["CustomerName"] ??'', 
  DocEntry: json["DocEntry"]??0, 
  FromDate:json["FromDate"]??'' , 
  ItemCode:json["ItemCode"]??'' , 
  ItemName:json["ItemName"]??'' , 
  MRP:json["MRP"] ??0.0, 
  Quantity:json["Quantity"] ??0.0, 
  RP:json["RP"]??0.0 , 
  RequestDate:json["RequestDate"]??'' , 
  SP:json["SP"] ??0.0, 
  SSP1: json["SSP1"]??0.0, 
  SSP2:json["SSP2"] ??0.0, 
  SSP3:json["SSP3"] ??0.0, 
  SSP4:json["SSP4"] ??0.0, 
  SSP5:json["SSP5"] ??0.0, 
  Status: json["Status"]??'', 
  StoreCode:json["StoreCode"]??'' , 
  ToDate:json["ToDate"]??'' , 
  UpdatedOn:json["UpdatedOn"] ??''
  );
}