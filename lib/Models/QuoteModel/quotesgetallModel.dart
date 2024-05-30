import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

class GetAllQuotesModal {
  GetAllQuotesDataheader? Quotescheckdatageader;
 
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetAllQuotesModal(
      {required this.Quotescheckdatageader,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetAllQuotesModal.fromJson(Map<String,dynamic> jsons, int stcode) {
    print("inside class" + jsons.toString());

    if (jsons != null || jsons.isNotEmpty) {
     
      
      return GetAllQuotesModal(
          Quotescheckdatageader: GetAllQuotesDataheader.fromJson(jsons),
          message: "Sucess",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return GetAllQuotesModal(
          Quotescheckdatageader: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }
factory GetAllQuotesModal.issues(Map<String,dynamic> jsons, int stcode) {
    return GetAllQuotesModal(
        Quotescheckdatageader: null,
        message: jsons['respCode'],
        status: null,
        stcode: stcode,
        exception: jsons['respDesc']);
  }
  factory GetAllQuotesModal.error(String jsons, int stcode) {
    return GetAllQuotesModal(
        Quotescheckdatageader: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetAllQuotesDataheader{
   List<GetAllQuotesData>? Quotescheckdata;
   GetAllQuotesDataheader({
    required this.Quotescheckdata
   });
factory GetAllQuotesDataheader.fromJson(Map<String,dynamic> jsons,){
  if(jsons['data'] != null){
var list = json.decode(jsons['data']) as List;
      List<GetAllQuotesData> dataList =
          list.map((data) => GetAllQuotesData.fromJson(data)).toList();
  return GetAllQuotesDataheader(
    Quotescheckdata: dataList
    );
  }else{
     return GetAllQuotesDataheader(
    Quotescheckdata: null
    );
  }

}
}


class GetAllQuotesData {
  int? OrderDocEntry; //
  int? FollowupEntry;
  int? OrderNum;
  String? deliveryDueDate; 
  String? paymentDueDate;
  String? alternateMobileNo;
  String? contactName;
  String? customerEmail;
  String? companyName;
  String? pAN;
  String? gSTNo;
  String? customerPORef;
  String? bil_Address1;
  String? bil_Address2;
  String? bil_Address3;
  String? bil_Area;
  String? bil_City;
  String? bil_District;
  String? bil_State;
  String? bil_Country;
  String? bil_Pincode;
  String? del_Address1;
  String? Del_Address2;
  String? Del_Address3;
  String? Del_Area;
  String? Del_City;
  String? Del_District;
  String? Del_State;
  String? Del_Country;
  String? Del_Pincode;
  String? StoreCode;
  String? AssignedTo;
  String? DeliveryFrom;
  String? OrderStatus;
  String? CurrentStatus;
  String? DealID;
  int? BaseID;
  String? BaseType;
  String? BaseDocDate;
  double? GrossTotal;
  double? Discount;
  double? SubTotal;
  double? TaxAmount;
  double RoundOff;
  String? AttachURL1;
  String? AttachURL2;
  String? AttachURL3;

  String? Mobile; //
  String? CustomerName; //
  String? DocDate;
  // String? City;
  // String? NextFollowup;
  String? Product;
   String? createdon; //
  double? Value; //
  String? Status; //
  String? LastUpdateMessage; //
  String? LastUpdateTime; //
  String? enqid;
  String? leadid;
  int? isDelivered;
  int? isInvoiced;
  String? cusgroup;
  String? OrderType;
  


  GetAllQuotesData(
      {required this.OrderType,
        required this.cusgroup,
        required this.createdon,
        required this.isDelivered,
        required this.isInvoiced,
        required this.OrderDocEntry,
      required this.OrderNum,
      required this.Mobile,
      required this.CustomerName,
      required this.DocDate,
      required this.AssignedTo,
      required this.AttachURL1,
      required this.AttachURL2,
      required this.AttachURL3,
      required this.BaseDocDate,
      required this.BaseID,
      required this.BaseType,
      required this.CurrentStatus,
      required this.DealID,
      required this.Del_Address2,
      required this.Del_Address3,
      required this.Del_Area,
      required this.Del_City,
      required this.Del_Country,
      required this.Del_District,
      required this.Del_Pincode,
      required this.Del_State,
      required this.DeliveryFrom,
      required this.Discount,
      required this.FollowupEntry,
      required this.LastUpdateMessage,
      required this.GrossTotal,
      required this.LastUpdateTime,
      required this.OrderStatus,
      required this.Product,
      required this.RoundOff,
      required this.Status,
      required this.StoreCode,
      required this.SubTotal,
      required this.TaxAmount,
      required this.Value,
      required this.alternateMobileNo,
      required this.bil_Address1,
      required this.bil_Address2,
      required this.bil_Address3,
      required this.bil_Area,
      required this.bil_City,
      required this.bil_Country,
      required this.bil_District,
      required this.bil_Pincode,
      required this.bil_State,
      required this.companyName,
      required this.contactName,
      required this.customerEmail,
      required this.customerPORef,
      required this.del_Address1,
      required this.deliveryDueDate,
      required this.enqid,
      required this.gSTNo,
      required this.leadid,
      required this.pAN,
      required this.paymentDueDate,
      // required this.City,
      // required this.NextFollowup,
     });

  factory GetAllQuotesData.fromJson(Map<String, dynamic> json) {
    // print("inside data class"+json.toString());
   return  GetAllQuotesData(
     OrderType:json['OrderType']??'',
    cusgroup:json['CustomerGroup']??'',//
   
    createdon:json['CreatedOn']??'',
    isDelivered:json['isDelivered'],
    isInvoiced:json['isInvoiced'],
    OrderDocEntry: json['DocEntry'], //
    OrderNum: json['OrderNumber'], //
    Mobile: json['CustomerCode'], //
    CustomerName: json['CustomerName'], //
    DocDate: json['DocDate'], //
    AssignedTo: json['AssignedTo'], 
    AttachURL1: json['AttachURL1'], 
    AttachURL2: json['AttachURL2'], 
    AttachURL3: json['AttachURL3'], 
    BaseDocDate: json['BaseDocDate'], 
    BaseID: json['BaseID'], 
    BaseType: json['BaseType'], 
    CurrentStatus: json['CurrentStatus'], 
    DealID: json['DealID'], 
    Del_Address2: json['Del_Address2'], 
    Del_Address3: json['Del_Address3'], 
    Del_Area: json['Del_Area'], 
    Del_City: json['Del_City'], 
    Del_Country: json['Del_Country'], 
    Del_District: json['Del_District'], 
    Del_Pincode: json['Del_Pincode'], 
    Del_State: json['Del_State'], 
    DeliveryFrom: json['DeliveryFrom'], 
    Discount: json['Discount'], 
    FollowupEntry: json['DocEntry'], 
    LastUpdateMessage: json['OrderStatus'], 
    GrossTotal: json['GrossTotal'], 
    LastUpdateTime: json['UpdatedOn'], 
    OrderStatus: json['OrderStatus'], 
    Product: json['ItemName'], 
    RoundOff: json['RoundOff'], 
    Status: json['OrderStatus'], 
    StoreCode: json['StoreCode'], //
    SubTotal: json['SubTotal'], 
    TaxAmount: json['TaxAmount'], 
    Value: json['DocTotal'], 
    alternateMobileNo: json['AlternateMobileNo'], 
    bil_Address1: json['Bil_Address1'], 
    bil_Address2: json['Bil_Address2'], 
    bil_Address3: json['Bil_Address3'], 
    bil_Area: json['Bil_Area'], 
    bil_City: json['Bil_City'], 
    bil_Country: json['Bil_Country'], 
    bil_District: json['Bil_District'], 
    bil_Pincode: json['Bil_Pincode'], 
    bil_State: json['Bil_State'], 
    companyName: json['CompanyName'], //
    contactName: json['ContactName'], //
    customerEmail: json['CustomerEmail'], //
    customerPORef: json['CustomerPORef'], //
    del_Address1: json['Del_Address1'], 
    deliveryDueDate: json['DeliveryDueDate'], //
    enqid: json[''], 
    gSTNo: json['GSTNo'], 
    leadid: json[''], 
    pAN: json['PAN'], //
    paymentDueDate: json['PaymentDueDate'],//
    );
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
