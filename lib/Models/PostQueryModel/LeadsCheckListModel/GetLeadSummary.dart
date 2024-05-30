import 'dart:convert';

class GetSummaryLeadModal {
 GetLeadHeader? leadSummaryheader;
 
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetSummaryLeadModal(
      {required this.leadSummaryheader,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetSummaryLeadModal.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      // var list =jsons as List;
      // List<SummaryLeadData> dataList =
      //     list.map((data) => SummaryLeadData.fromJson(data)).toList();
      return GetSummaryLeadModal(
          leadSummaryheader: GetLeadHeader.fromJson(jsons),
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return GetSummaryLeadModal(
          leadSummaryheader: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }
factory GetSummaryLeadModal.issues(Map<String,dynamic> jsons,int stcode) {
    return GetSummaryLeadModal(
        leadSummaryheader: null, message: jsons['respType'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }
  factory GetSummaryLeadModal.error(String jsons, int stcode) {
    return GetSummaryLeadModal(
       leadSummaryheader: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetLeadHeader {
  GetLeadHeader(
      {required this.respCode,
      required this.leadSumarydata,
      required this.respDesc,
      required this.respType

      // required this.customertag
      });

  String? respType;
  String? respCode;
  String? respDesc;
  List<SummaryLeadData>? leadSumarydata;

  factory GetLeadHeader.fromJson(Map<String, dynamic> jsons) {
    //  if (jsons["data"] != null) {
    var list = json.decode(jsons["data"]) as List;

    if (list.isEmpty) {
      return GetLeadHeader(
          respCode: jsons['respCode'],
          leadSumarydata: null,
          respDesc: jsons['respDesc'],
          respType: jsons['respType']);
    } else {
      
      List<SummaryLeadData> dataList =
          list.map((data) => SummaryLeadData.fromJson(data)).toList();
      return GetLeadHeader(
          respCode: jsons['respCode'],
          leadSumarydata: dataList,
          respDesc: jsons['respDesc'],
          respType: jsons['respType']);
    }
  }
}

class SummaryLeadData {

  String? Caption;
  String? Target;
  double? Value;
  String? btg;
  int? column;
  String? Status;

  SummaryLeadData({
    required this.btg,
 
    required this.Caption,
    required this.Target,
    required this.Value,
    required this.Status,
    required this.column
  });

  factory SummaryLeadData.fromJson(Map<String, dynamic> json) => SummaryLeadData(
        Caption: json['Caption'] ?? '',
        Target: json['Target'] ?? "",
        Value:json['Value'] ??0.00,
        Status: json['Status'] ?? '',
        column:json['column']??0,
        btg: json['BTG']??""
      );

  // Map<String, dynamic> tojson() {
  //   Map<String, dynamic> map = {
  //     "LeadDocEntry": LeadDocEntry,
  //     "LeadNum": LeadNum,
  //     "U_ChkValue": ischecked == false?'No':'Yes'
  //   };
  //   return map;
  // }
}
