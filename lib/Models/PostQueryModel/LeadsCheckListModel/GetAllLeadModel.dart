import 'dart:convert';
import 'dart:developer';

import 'package:sellerkit/DBModel/lead_filterdbmodel.dart';

class GetAllLeadModal {
  GetLeadHeader? leadcheckheader;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetAllLeadModal(
      {required this.leadcheckheader,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetAllLeadModal.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      // log("dataList222"+jsons.toString());
      // var list = jsons as List;
      // List<GetAllLeadData> dataList =
      //     list.map((data) => GetAllLeadData.fromJson(data)).toList();
      // log("datatlist"+dataList.length.toString());
      return GetAllLeadModal(
          leadcheckheader: GetLeadHeader.fromJson(jsons),
          message: "Successs",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return GetAllLeadModal(
          leadcheckheader: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }
  factory GetAllLeadModal.issues(Map<String,dynamic> jsons, int stcode) {
    return GetAllLeadModal(
        leadcheckheader: null,
        message: jsons['respCode']??'',
        status: null,
        stcode: stcode,
        exception: jsons['respDesc']);
  }

  factory GetAllLeadModal.error(String jsons, int stcode) {
    return GetAllLeadModal(
        leadcheckheader: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetLeadHeader {
  GetLeadHeader(
      {
        // required this.respCode,
      required this.leadcheckdata,
      // required this.respDesc,
      // required this.respType

      // required this.customertag
      });

  // String? respType;
  // String? respCode;
  // String? respDesc;
  List<GetAllLeadData>? leadcheckdata;

  factory GetLeadHeader.fromJson(Map<String, dynamic> jsons) {
     if (jsons["data"] != null) {
    var list = json.decode(jsons["data"]) as List;

    if (list.isEmpty) {
      return GetLeadHeader(
          // respCode: jsons['respCode'],
          leadcheckdata: null,
          // respDesc: jsons['respDesc'],
          // respType: jsons['respType']
          );
    } else {
      
      List<GetAllLeadData> dataList =
          list.map((data) => GetAllLeadData.fromJson(data)).toList();
      return GetLeadHeader(
          // respCode: jsons['respCode'],
          leadcheckdata: dataList,
          // respDesc: jsons['respDesc'],
          // respType: jsons['respType']
          );
    }
     }else{
      return GetLeadHeader(
          // respCode: jsons['respCode'],
          leadcheckdata: null,
          // respDesc: jsons['respDesc'],
          // respType: jsons['respType']
          );
     }
  }
}

class GetAllLeadData {
  int? LeadDocEntry;
  int? FollowupEntry;
  int? LeadNum;
  String? Mobile;
  String? CustomerName;
  String? DocDate;
  String? City;
  String? NextFollowup;
  String? Product;
  double? Value;
  String? Status;
  String? LastUpdateMessage;
  String? LastUpdateTime;
  String? customermob;
  String? cusEmail;
  String? companyname;
  String? cusgroup;
  String? storecode;
  String? add1;
  String? add2;
  String? area;

  String? district;
  String? state;
  String? country;
  String? pincode;
  String? gender;
  String? agegroup;
  String? cameAs;
  int? headcount;
  double? maxbudget;
  String? assignedTo;
  String? refferal;
  String? purchasePlan;
  String? dealDescription;
  String? lastFollowupDate;

  int? createdBy;
  String? createdDate;
  int? updatedBy;
  String? updatedDate;
  String? traceId;
  int? isselected;
 String? InterestLevel;
  String? OrderType;
  GetAllLeadData({
     required this.InterestLevel,
  required this.OrderType,
    this.isselected,
    required this.LeadDocEntry,
    required this.LeadNum,
    required this.Mobile,
    required this.CustomerName,
    required this.DocDate,
    required this.City,
    required this.NextFollowup,
    required this.Product,
    required this.Value,
    required this.Status,
    required this.LastUpdateMessage,
    required this.LastUpdateTime,
    required this.FollowupEntry,
    required this.customermob,
    required this.cusEmail,
    required this.companyname,
    required this.cusgroup,
    required this.storecode,
    required this.add1,
    required this.add2,
    required this.area,
    required this.district,
    required this.state,
    required this.country,
    required this.pincode,
    required this.gender,
    required this.agegroup,
    required this.cameAs,
    required this.headcount,
    required this.maxbudget,
    required this.assignedTo,
    required this.refferal,
    required this.purchasePlan,
    required this.dealDescription,
    required this.lastFollowupDate,
   
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.traceId,
  });

  factory GetAllLeadData.fromJson(Map<String, dynamic> json) => GetAllLeadData(
    InterestLevel:json['InterestLevel'] ?? '' ,
    OrderType:json['OrderType'] ?? '' ,
        LeadDocEntry: json['LeadId'] ?? -1,
        LeadNum: json['LeadId'] ?? -1, //
        Mobile: json['CustomerCode'] ?? '', //
        CustomerName: json['CustomerName'] ?? '', //
        DocDate: json['docDate'] ?? '',
        City: json['City'] ?? '', //
        NextFollowup: json['NextFollowupDate'] ?? '', //
        Product: json['ItemName'] ?? '',//
        Value: json['LeadValue'] ?? -1,//
        Status: json['Status'] ?? '', //
        LastUpdateMessage: json['LastFollowupStatus'] ?? '', //
        LastUpdateTime: json['CreatedDate'] ?? '', //
        FollowupEntry: json['followupEntry']??0,
        customermob: json['CustomerMobile'],
        cusEmail: json['CustomerEmail']??'',
        companyname: json['CompanyName'],
        cusgroup: json['CustomerGroup'],
        storecode: json['StoreCode'],
        add1: json['Address1']??'',
        add2: json['Address2']??'',
        area: json['Area']??'',

        district: json['District']??'',
        state: json['State']??'',
        country: json['Country']??'',
        pincode: json['Pincode'].toString(),
        gender: json['Gender']??'',
        agegroup: json['AgeGroup']??'',
        cameAs: json['CameAs']??'',
        headcount: json['Headcount'],
        maxbudget: json['Maxbudget'],
        assignedTo: json['AssignedTo'],
        refferal: json['Refferal'],
        purchasePlan: json['PurchasePlan'],
        dealDescription: json['DealDescription'],
        lastFollowupDate: json['LastFollowupDate'],
        createdBy: json['CreatedBy'],
        createdDate: json['CreatedDate']??'',
        updatedBy: json['UpdatedBy'],
        updatedDate: json['UpdatedDate'],
        traceId: json['TraceId'],
      );



  Map<String, Object?> toMap() => {
    LeadfilterDBcolumns.leadDocEntry:LeadDocEntry,
    LeadfilterDBcolumns.followupEntry:FollowupEntry,
    LeadfilterDBcolumns.leadNum:LeadNum,
    LeadfilterDBcolumns.mobile:Mobile,
    LeadfilterDBcolumns.customerName:CustomerName,
    LeadfilterDBcolumns.docDate:DocDate,
    LeadfilterDBcolumns.city:City,
    LeadfilterDBcolumns.nextFollowup:NextFollowup,
    LeadfilterDBcolumns.product:Product,
    LeadfilterDBcolumns.value:Value,
    LeadfilterDBcolumns.status:Status,
    LeadfilterDBcolumns.lastUpdateMessage:LastUpdateMessage,
    LeadfilterDBcolumns.lastUpdateTime:LastUpdateTime,
    LeadfilterDBcolumns.customermob:customermob,
    LeadfilterDBcolumns.cusEmail:cusEmail,
    LeadfilterDBcolumns.companyname:companyname,
    LeadfilterDBcolumns.cusgroup:cusgroup,
    LeadfilterDBcolumns.storecode:storecode,
    LeadfilterDBcolumns.add1:add1,
    LeadfilterDBcolumns.add2:add2,
    LeadfilterDBcolumns.area:area,
    LeadfilterDBcolumns.district:district,
    LeadfilterDBcolumns.state:state,
    LeadfilterDBcolumns.country:country,
    LeadfilterDBcolumns.pincode:pincode,
    LeadfilterDBcolumns.gender:gender,
    LeadfilterDBcolumns.agegroup:agegroup,
    LeadfilterDBcolumns.cameAs:cameAs,
    LeadfilterDBcolumns.headcount:headcount,
    LeadfilterDBcolumns.maxbudget:maxbudget,
    LeadfilterDBcolumns.assignedTo:assignedTo,
    LeadfilterDBcolumns.refferal:refferal,
    LeadfilterDBcolumns.purchasePlan:purchasePlan,
    LeadfilterDBcolumns.dealDescription:dealDescription,
    LeadfilterDBcolumns.lastFollowupDate:lastFollowupDate,
    LeadfilterDBcolumns.createdBy:createdBy,
    LeadfilterDBcolumns.createdDate:createdDate,
    LeadfilterDBcolumns.updatedBy:updatedBy,
    LeadfilterDBcolumns.updatedDate:updatedDate,
    LeadfilterDBcolumns.traceId:traceId,
    LeadfilterDBcolumns.isselected:isselected,
    LeadfilterDBcolumns.interestLevel:InterestLevel,
    LeadfilterDBcolumns.orderType:OrderType,
    
  };


  // Map<String, dynamic> tojson() {
  //   Map<String, dynamic> map = {
  //     "LeadDocEntry": LeadDocEntry,
  //     "LeadNum": LeadNum,
  //     "U_ChkValue": ischecked == false?'No':'Yes'
  //   };
  //   return map;
  // }
}
