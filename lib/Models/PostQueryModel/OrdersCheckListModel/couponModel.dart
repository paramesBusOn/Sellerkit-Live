import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sellerkit/DBModel/order_filterdbmodel.dart';

class AllCouponModal {
  CouponModalDataheader? CouponModaldatageader;
 
  String message;
  bool? status;
  String? exception;
  int? stcode;
  AllCouponModal(
      {required this.CouponModaldatageader,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory AllCouponModal.fromJson(Map<String,dynamic> jsons, int stcode) {
    print("inside class" + jsons.toString());

    if (jsons != null || jsons.isNotEmpty) {
     
      
      return AllCouponModal(
          CouponModaldatageader: CouponModalDataheader.fromJson(jsons),
          message: "Sucess",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return AllCouponModal(
          CouponModaldatageader: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }
factory AllCouponModal.issues(Map<String,dynamic> jsons, int stcode) {
    return AllCouponModal(
        CouponModaldatageader: null,
        message: jsons['respCode'],
        status: null,
        stcode: stcode,
        exception: jsons['respDesc']);
  }
  factory AllCouponModal.error(String jsons, int stcode) {
    return AllCouponModal(
        CouponModaldatageader: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class CouponModalDataheader{
   List<GetAllcouponData>? Ordercheckdata;
   CouponModalDataheader({
    required this.Ordercheckdata
   });
factory CouponModalDataheader.fromJson(Map<String,dynamic> jsons,){
  if(jsons['data'] != null){
var list = json.decode(jsons['data']) as List;
      List<GetAllcouponData> dataList =
          list.map((data) => GetAllcouponData.fromJson(data)).toList();
  return CouponModalDataheader(
    Ordercheckdata: dataList
    );
  }else{
     return CouponModalDataheader(
    Ordercheckdata: null
    );
  }

}
}


class GetAllcouponData {
  int? DocEntry; //
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
 String? CouponCode;
 String? ApprovedBy;
 String? ApprovedOn;
 String? UtilisedOrderEntry;
 String? UtilisedOn;
 int? CreatedBy;
 String? CreatedOn;
 int? UpdatedBy;
 String? UpdatedOn;
 String? traceid;


  GetAllcouponData(
      {
        required this.AP,
        required this.ApprovedBy,
        required this.ApprovedOn,
        required this.AssignedTo,
        required this.Cost,
        required this.CouponCode,
        required this.CreatedBy,
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
        required this.UpdatedBy,
        required this.UpdatedOn,
        required this.UtilisedOn,
        required this.UtilisedOrderEntry,
        required this.traceid
     });

  factory GetAllcouponData.fromJson(Map<String, dynamic> json) {
    // print("inside data class"+json.toString());
   return  GetAllcouponData(
    AP: json['AP']??0.0, 
    ApprovedBy: json['ApprovedBy']??'', 
    ApprovedOn: json['ApprovedOn']??'', 
    AssignedTo: json['AssignedTo']??'', 
    Cost: json['Cost']??0.0, 
    CouponCode: json['CouponCode']??'', 
    CreatedBy: json['CreatedBy']??0, 
    CreatedOn: json['CreatedOn']??'', 
    CustomerCode: json['CustomerCode']??'', 
    CustomerMobile: json['CustomerMobile']??'', 
    CustomerName: json['CustomerName']??'', 
    DocEntry: json['DocEntry']??0, 
    FromDate: json['FromDate']??'', 
    ItemCode: json['ItemCode']??'', 
    ItemName: json['ItemName']??'', 
    MRP: json['MRP']??0.0, 
    Quantity: json['Quantity']??0.0, 
    RP: json['RP']??0.0, 
    RequestDate: json['RequestDate']??'', 
    SP: json['SP']??0.0, 
    SSP1: json['SSP1']??0.0, 
    SSP2: json['SSP2']??0.0, 
    SSP3: json['SSP3']??0.0, 
    SSP4: json['SSP4']??0.0, 
    SSP5: json['SSP5']??0.0, 
    Status: json['Status']??'', 
    StoreCode: json['StoreCode']??'', 
    ToDate: json['ToDate']??'', 
    UpdatedBy: json['UpdatedBy']??0, 
    UpdatedOn: json['UpdatedOn']??'', 
    UtilisedOn: json['UtilisedOn']??'', 
    UtilisedOrderEntry: json['UtilisedOrderEntry']??'', 
    traceid: json['traceid']??'');
  }
 
  // Map<String, dynamic> tojson() {
  //   Map<String, dynamic> map = {
  //     "OrderDocEntry": OrderDocEntry,
  //     "OrderNum": OrderNum,
  //     "U_ChkValue": ischecked == false?'No':'Yes'
  //   };
  //   return map;
  // }
}
