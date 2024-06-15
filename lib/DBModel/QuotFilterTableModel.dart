

import 'package:flutter/material.dart';

const String QuotFilterTable = "QuotationFilteDB";

class QuotFilterDBTable {
  // static const String id = "Id";
  static const String orderNum = "OrderNum";
  static const String assignTo = "AssignedTo";
  static const String custName = "CustomerName";
  static const String product = "Product";
  static const String quotDate = "QuotDate";
  static const String docTotal='DocTotal';
  static const String orderType = "OrderType";
  static const String lastUpdatedDate = "LastUpdatedDate";
  static const String OrderDocEntry = "OrderDocEntry"; //
  static const String FollowupEntry = "FollowupEntry";
  static const String deliveryDueDate = "DdeliveryDueDate";
  static const String paymentDueDate = "PaymentDueDate";
  static const String alternateMobileNo = "AlternateMobileNo";
  static const String contactName = "ContactName";
  static const String customerEmail = "CustomerEmail";
  static const String companyName = "CompanyName";
  static const String pAN = "PAN";
  static const String gSTNo = "GSTNo";
  static const String customerPORef = "CustomerPORef";
  static const String bil_Address1 = "Bil_Address1";
  static const String bil_Address2 = "Bil_Address2";
  static const String bil_Address3 = "Bil_Address3";
  static const String bil_Area = "Bil_Area";
  static const String bil_City = "Bil_City";
  static const String bil_District = "Bil_District";
  static const String bil_State = "Bil_State";
  static const String bil_Country = "Bil_Country";
  static const String bil_Pincode = "Bil_Pincode";
  static const String Del_Address1 = "Del_Address1";
  static const String Del_Address2 = "Del_Address2";
  static const String Del_Address3 = "Del_Address3";
  static const String Del_Area = "Del_Area";
  static const String Del_City = "Del_City";
  static const String Del_District = "Del_District";
  static const String Del_State = "Del_State";
  static const String Del_Country = "Del_Country";
  static const String Del_Pincode = "Del_Pincode";
  static const String StoreCode = "StoreCode";
  static const String vDeliveryFrom = "DeliveryFrom";
  static const String OrderStatus = "OrderStatus";
  static const String CurrentStatus = "CurrentStatus";
  static const String DealID = "DealID";
  static const String BaseID = "BaseID";
  static const String BaseType = "BaseType";
  static const String BaseDocDate = "BaseDocDate";
  static const String GrossTotal = "GrossTotal";
  static const String Discount = "Discount";
  static const String SubTotal = "SubTotal";
  static const String TaxAmount = "TaxAmount";
  static const String RoundOff = "RoundOff";
  static const String AttachURL1 = "AttachURL1";
  static const String AttachURL2 = "AttachURL2";
  static const String AttachURL3 = "AttachURL3";
  static const String Mobile = "Mobile"; //
  static const String DocDate = "DocDate";
  static const String createdon = "createdon"; //
  static const String LastUpdateMessage = "LastUpdateMessage"; //
  static const String LastUpdateTime = "LastUpdateTime"; //
  static const String enqid = "Enqid";
  static const String leadid = "Leadid";
  static const String isDelivered = "IsDelivered";
  static const String isInvoiced = "IsInvoiced";
  static const String cusgroup = "Cusgroup";
}

class QuotFilterModel {
  String? orderType;
  String? id;
  String? orderNum;
  String? assignTo;
  String? custName;
  String? product;
  String? quotDate;

  String? quotStatus;
  String? lastUpdatedDate;

  int? OrderDocEntry; //
  int? FollowupEntry;
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
  String? Del_Address1;
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
  double? RoundOff;
  String? AttachURL1;
  String? AttachURL2;
  String? AttachURL3;

  String? Mobile; //
  String? DocDate;

  String? Product;
  String? createdon; //
  double? docTotal; //
  String? Status; //
  String? LastUpdateMessage; //
  String? LastUpdateTime; //
  String? enqid;
  String? leadid;
  int? isDelivered;
  int? isInvoiced;
  String? cusgroup;
  String? OrderType;
  QuotFilterModel({
    this.custName,
    this.id,
    this.orderType,
    this.assignTo,
    this.lastUpdatedDate,
    this.orderNum,
    this.product,
    this.quotDate,
    this.quotStatus,
    this.cusgroup,
    this.createdon,
    this.isDelivered,
    this.isInvoiced,
    this.OrderDocEntry,
    this.Mobile,
    this.DocDate,
    this.AttachURL1,
    this.AttachURL2,
    this.AttachURL3,
    this.BaseDocDate,
    this.BaseID,
    this.BaseType,
    this.CurrentStatus,
    this.DealID,
    this.Del_Address2,
    this.Del_Address3,
    this.Del_Area,
    this.Del_City,
    this.Del_Country,
    this.Del_District,
    this.Del_Pincode,
    this.Del_State,
    this.DeliveryFrom,
    this.Discount,
    this.FollowupEntry,
    this.LastUpdateMessage,
    this.GrossTotal,
    this.LastUpdateTime,
    this.OrderStatus,
    this.Product,
    this.RoundOff,
    this.Status,
    this.StoreCode,
    this.SubTotal,
    this.TaxAmount,
    this.docTotal,
    this.alternateMobileNo,
    this.bil_Address1,
    this.bil_Address2,
    this.bil_Address3,
    this.bil_Area,
    this.bil_City,
    this.bil_Country,
    this.bil_District,
    this.bil_Pincode,
    this.bil_State,
    this.companyName,
    this.contactName,
    this.customerEmail,
    this.customerPORef,
    this.Del_Address1,
    this.deliveryDueDate,
    this.enqid,
    this.gSTNo,
    this.leadid,
    this.pAN,
    this.paymentDueDate,
  });

  Map<String, Object?> toMap() => {
        // QuotFilterDBTable.id: id,
        QuotFilterDBTable.custName: custName,
        QuotFilterDBTable.OrderStatus: OrderStatus,
        QuotFilterDBTable.lastUpdatedDate: lastUpdatedDate,
        QuotFilterDBTable.orderNum: orderNum,
        QuotFilterDBTable.product: product,
        QuotFilterDBTable.quotDate: quotDate,
        QuotFilterDBTable.createdon: createdon,
        QuotFilterDBTable.docTotal: docTotal,
        QuotFilterDBTable.orderType: orderType,
        QuotFilterDBTable.assignTo: assignTo,
        QuotFilterDBTable.AttachURL1: AttachURL1,
        QuotFilterDBTable.AttachURL2: AttachURL2,
        QuotFilterDBTable.AttachURL3: AttachURL3,
        QuotFilterDBTable.BaseDocDate: BaseDocDate,
        QuotFilterDBTable.BaseID: BaseID,
        QuotFilterDBTable.BaseType: BaseType,
        QuotFilterDBTable.CurrentStatus: CurrentStatus,
        QuotFilterDBTable.DealID: DealID,
        QuotFilterDBTable.Del_Address1: Del_Address1,
        QuotFilterDBTable.Del_Address2: Del_Address2,
        QuotFilterDBTable.Del_Address3: Del_Address3,
        QuotFilterDBTable.Del_Area: Del_Area,
        QuotFilterDBTable.Del_City: Del_City,
        QuotFilterDBTable.Del_Country: Del_Country,
        QuotFilterDBTable.Del_State: Del_State,
        QuotFilterDBTable.Del_Pincode: Del_Pincode,
        QuotFilterDBTable.Discount: Discount,
        QuotFilterDBTable.FollowupEntry: FollowupEntry,
        QuotFilterDBTable.GrossTotal: GrossTotal,
        QuotFilterDBTable.LastUpdateMessage: LastUpdateMessage,
        QuotFilterDBTable.Mobile: Mobile,
        QuotFilterDBTable.LastUpdateTime: LastUpdateTime,
        QuotFilterDBTable.OrderDocEntry: OrderDocEntry,
        QuotFilterDBTable.RoundOff: RoundOff,
        QuotFilterDBTable.StoreCode: StoreCode,
        QuotFilterDBTable.bil_Address1: bil_Address1,
        QuotFilterDBTable.bil_Address2: bil_Address2,
        QuotFilterDBTable.bil_Address3: bil_Address3,
        QuotFilterDBTable.bil_Area: bil_Area,
        QuotFilterDBTable.bil_City: bil_City,
        QuotFilterDBTable.bil_Country: bil_Country,
        QuotFilterDBTable.bil_State: bil_State,
        QuotFilterDBTable.bil_Pincode: bil_Pincode,
        QuotFilterDBTable.paymentDueDate: paymentDueDate,
        QuotFilterDBTable.pAN: pAN,
        QuotFilterDBTable.leadid: leadid,
        QuotFilterDBTable.isDelivered: isDelivered,
        QuotFilterDBTable.isInvoiced: isInvoiced,
        QuotFilterDBTable.companyName: companyName,
        QuotFilterDBTable.contactName: contactName,
        QuotFilterDBTable.gSTNo: gSTNo,
        QuotFilterDBTable.enqid: enqid,
      };
}
