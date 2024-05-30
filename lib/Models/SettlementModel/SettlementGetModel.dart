// ignore_for_file: file_names, unused_local_variable, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

class SettlementGetDetails {
  SettlementGetDetails(
      {required this.respCode,
      required this.datadetail,
      required this.respDesc,
      required this.respType,
      required this.stcode
      // required this.customertag
      });

  String? respType;
  String? respCode;
  String? respDesc;
  int? stcode;
  List<SettlementGetData>? datadetail;

  factory SettlementGetDetails.fromJson(
      Map<String, dynamic> jsons, int? stcode) {
    //  if (jsons["data"] != null) {
    // var list = json.decode(jsons["data"]) as Map<String, dynamic>;
    if (jsons["data"] == null) {
      return SettlementGetDetails(
          respCode: jsons['respCode'],
          datadetail: null,
          respDesc: jsons['respDesc'],
          respType: jsons['respType'],
          stcode: stcode!);
    } else {
      var list = json.decode(jsons["data"]) as List;

      List<SettlementGetData> dataList =
          list.map((data) => SettlementGetData.fromJson(data)).toList();

      return SettlementGetDetails(
          respCode: jsons['respCode'],
          datadetail: dataList,
          respDesc: jsons['respDesc'],
          respType: jsons['respType'],
          stcode: stcode!);
    }
  }
  factory SettlementGetDetails.issues(Map<String, dynamic> jsons, int stcode) {
    return SettlementGetDetails(
        respCode: jsons['respCode'],
        datadetail: null,
        respDesc: jsons['respDesc'],
        respType: jsons['respType'],
        stcode: stcode);
  }
  factory SettlementGetDetails.error(String jsons, int stcode) {
    return SettlementGetDetails(
        respCode: null,
        datadetail: null,
        respDesc: jsons,
        respType: null,
        stcode: stcode);
  }
}

class SettlementGetData {
  // String? caption;
  // double? target;
  // double? btg;
  // double? value;
  // int? column;
  // String? status;
  //
  int? docentry;
  int? DocNum;
  String? DocDate;
  String? CustomerCode;
  String? CustomerName;
  String? CustomerMobile;
  String? StoreCode;
  String? AssignedTo;
  double Amount;
  String? DocType;
  String? Mode;
  String? CancelledDate;
  String? CancelledBy;
  String? CancelledRemarks;
  int? CreatedBy;
  String? CreatedOn;
  int? UpdatedBy;
  String? UpdatedOn;
  String? traceid;
    bool? isselect;
double? totalAmount;
  String? ref;

  SettlementGetData({
    required this.docentry,
    required this.DocNum,
    required this.DocDate,
    required this.CustomerCode,
    required this.CustomerName,
    required this.CustomerMobile,
    required this.StoreCode,
    required this.AssignedTo,
    required this.Amount,
    required this.DocType,
    required this.Mode,
    required this.CancelledDate,
    required this.CancelledBy,
    required this.CancelledRemarks,
    required this.CreatedBy,
    required this.CreatedOn,
    required this.UpdatedBy,
    required this.UpdatedOn,
    required this.traceid,
         this.isselect,
         required this.totalAmount,
         required this.ref

  });

  factory SettlementGetData.fromJson(Map<String, dynamic> json) =>
      SettlementGetData(
        DocNum: json['DocNum']??0,
        DocDate: json['DocDate']??0,
        CustomerCode: json['CustomerCode']??'',
        CustomerName: json['CustomerName']??'',
        CustomerMobile: json['CustomerMobile']??'',
        StoreCode: json['StoreCode']??'',
        AssignedTo: json['AssignedTo']??'',
        Amount: json['Amount']??0.0,
        DocType: json['DocType']??'',
        Mode: json['Mode']??'',
        CancelledDate: json['CancelledDate']??'',
        CancelledBy: json['CancelledBy']??'',
        CancelledRemarks: json['CancelledRemarks']??'',
        CreatedBy: json['CreatedBy']??0,
        CreatedOn: json['CreatedOn']??'',
        UpdatedBy: json['UpdatedBy']??0,
        UpdatedOn: json['UpdatedOn']??'',
        totalAmount: json['TotalAmount']??0.0,
        traceid: json['traceid'], docentry: json['DocEntry']??0, ref:  json['Ref']??'',
      );
}
