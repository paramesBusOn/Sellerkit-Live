import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sellerkit/DBModel/order_filterdbmodel.dart';

class GetAllOrderModal {
  GetAllOrderDataheader? Ordercheckdatageader;
 
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetAllOrderModal(
      {required this.Ordercheckdatageader,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetAllOrderModal.fromJson(Map<String,dynamic> jsons, int stcode) {
    print("inside class" + jsons.toString());

    if (jsons != null || jsons.isNotEmpty) {
     
      
      return GetAllOrderModal(
          Ordercheckdatageader: GetAllOrderDataheader.fromJson(jsons),
          message: "Sucess",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return GetAllOrderModal(
          Ordercheckdatageader: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }
factory GetAllOrderModal.issues(Map<String,dynamic> jsons, int stcode) {
    return GetAllOrderModal(
        Ordercheckdatageader: null,
        message: jsons['respCode'],
        status: null,
        stcode: stcode,
        exception: jsons['respDesc']);
  }
  factory GetAllOrderModal.error(String jsons, int stcode) {
    return GetAllOrderModal(
        Ordercheckdatageader: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetAllOrderDataheader{
   List<GetAllOrderData>? Ordercheckdata;
   GetAllOrderDataheader({
    required this.Ordercheckdata
   });
factory GetAllOrderDataheader.fromJson(Map<String,dynamic> jsons,){
  if(jsons['data'] != null){
var list = json.decode(jsons['data']) as List;
      List<GetAllOrderData> dataList =
          list.map((data) => GetAllOrderData.fromJson(data)).toList();
  return GetAllOrderDataheader(
    Ordercheckdata: dataList
    );
  }else{
     return GetAllOrderDataheader(
    Ordercheckdata: null
    );
  }

}
}


class GetAllOrderData {
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
  String? OrderType;
  String? CustomerGroup;

  GetAllOrderData(
      {
        required this.CustomerGroup,
  required this.OrderType,
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

  factory GetAllOrderData.fromJson(Map<String, dynamic> json) {
    // print("inside data class"+json.toString());
   return  GetAllOrderData(
    CustomerGroup:json['CustomerGroup']??'',
     OrderType:json['OrderType'] ?? '' ,
    createdon:json['CreatedOn']??'',
    isDelivered:json['isDelivered'],
    isInvoiced:json['isInvoiced'],
    OrderDocEntry: json['DocEntry'], 
    OrderNum: json['OrderNumber'], 
    Mobile: json['CustomerCode'], 
    CustomerName: json['CustomerName'], 
    DocDate: json['DocDate'], 
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
    StoreCode: json['StoreCode'], 
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
    companyName: json['CompanyName'], 
    contactName: json['ContactName'], 
    customerEmail: json['CustomerEmail'], 
    customerPORef: json['CustomerPORef'], 
    del_Address1: json['Del_Address1'], 
    deliveryDueDate: json['DeliveryDueDate'], 
    enqid: json[''], gSTNo: json['GSTNo'], 
    leadid: json[''], 
    pAN: json['PAN'], 
    paymentDueDate: json['PaymentDueDate']);
  }
 Map<String, Object?> toMap() =>{
  OrderfilterDBcolumns.orderDocEntry:OrderDocEntry,
  OrderfilterDBcolumns.followupEntry :FollowupEntry,
  OrderfilterDBcolumns.orderNum:OrderNum,
  OrderfilterDBcolumns.deliveryDueDate:deliveryDueDate,
  OrderfilterDBcolumns.paymentDueDate:paymentDueDate,
  OrderfilterDBcolumns.alternateMobileNo:alternateMobileNo,
  OrderfilterDBcolumns.contactName:contactName,
  OrderfilterDBcolumns.companyName:companyName,
  OrderfilterDBcolumns.pAN:pAN,
  OrderfilterDBcolumns.gSTNo:gSTNo,
  OrderfilterDBcolumns.customerPORef:customerPORef,
  OrderfilterDBcolumns.bil_Address1 :bil_Address1,
  OrderfilterDBcolumns.bil_Address2 :bil_Address2 ,
  OrderfilterDBcolumns.bil_Address3:bil_Address3,
  OrderfilterDBcolumns.bil_Area:bil_Area,
  OrderfilterDBcolumns.bil_City:bil_City,
  OrderfilterDBcolumns.bil_District:bil_District,
  OrderfilterDBcolumns.bil_State:bil_State,
  OrderfilterDBcolumns.bil_Country:bil_Country,
  OrderfilterDBcolumns.bil_Pincode:bil_Pincode,
  OrderfilterDBcolumns.del_Address1:del_Address1,
  OrderfilterDBcolumns.del_Address2:Del_Address2,
  OrderfilterDBcolumns.del_Address3:Del_Address3,
  OrderfilterDBcolumns.Del_Area:Del_Area,
  OrderfilterDBcolumns.del_City:Del_City,
  OrderfilterDBcolumns.del_District:Del_District,
  OrderfilterDBcolumns.del_State:Del_State,
  OrderfilterDBcolumns.del_Country:Del_Country,
  OrderfilterDBcolumns.del_Pincode:Del_Pincode,
  OrderfilterDBcolumns.storeCode:StoreCode,
  OrderfilterDBcolumns.assignedTo:AssignedTo,
  OrderfilterDBcolumns.deliveryFrom:DeliveryFrom,
  OrderfilterDBcolumns.orderStatus:OrderStatus,
  OrderfilterDBcolumns.currentStatus:CurrentStatus,
  OrderfilterDBcolumns.dealID:DealID,
  OrderfilterDBcolumns.baseID:BaseID,
  OrderfilterDBcolumns.baseType:BaseType,
  OrderfilterDBcolumns.baseDocDate:BaseDocDate,
  OrderfilterDBcolumns.grossTotal:GrossTotal,
  OrderfilterDBcolumns.discount:Discount,
  OrderfilterDBcolumns.subTotal:SubTotal,
  OrderfilterDBcolumns.taxAmount:TaxAmount,
  OrderfilterDBcolumns.roundOff:RoundOff,
  OrderfilterDBcolumns.attachURL1:AttachURL1,
  OrderfilterDBcolumns.attachURL2:AttachURL2,
  OrderfilterDBcolumns.attachURL3:AttachURL3,
  OrderfilterDBcolumns.mobile:Mobile,
  OrderfilterDBcolumns.customerName:CustomerName,
  OrderfilterDBcolumns.docDate:DocDate,
  OrderfilterDBcolumns.product:Product,
  OrderfilterDBcolumns.createdon:createdon,
   OrderfilterDBcolumns.value:Value,
    OrderfilterDBcolumns.status:Status,
     OrderfilterDBcolumns.lastUpdateMessage:LastUpdateMessage,
      OrderfilterDBcolumns.lastUpdateTime:LastUpdateTime,
      OrderfilterDBcolumns.enqid:enqid,
      OrderfilterDBcolumns.leadid:leadid,
      OrderfilterDBcolumns.isDelivered:isDelivered,
      OrderfilterDBcolumns.isInvoiced:isInvoiced,
      OrderfilterDBcolumns.orderType:OrderType,
      OrderfilterDBcolumns.customerGroup:CustomerGroup,
     

 };
  // Map<String, dynamic> tojson() {
  //   Map<String, dynamic> map = {
  //     "OrderDocEntry": OrderDocEntry,
  //     "OrderNum": OrderNum,
  //     "U_ChkValue": ischecked == false?'No':'Yes'
  //   };
  //   return map;
  // }
}
