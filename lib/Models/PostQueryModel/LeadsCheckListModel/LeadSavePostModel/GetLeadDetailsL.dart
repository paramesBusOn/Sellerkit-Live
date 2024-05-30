import 'dart:convert';
import 'dart:developer';

class GetLeadDetailsL {
  List<GetLeadDeatilsLData>? leadDeatilsLeadData;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  GetLeadDetailsL(
      {required this.leadDeatilsLeadData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory GetLeadDetailsL.fromJson(List<dynamic> jsons, int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      log("OUTOUT:"+jsons.toString());
      var list = jsons as List;
      List<GetLeadDeatilsLData> dataList =
          list.map((data) => GetLeadDeatilsLData.fromJson(data)).toList();
      return GetLeadDetailsL(
          leadDeatilsLeadData: dataList,
          message:"Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return GetLeadDetailsL(
          leadDeatilsLeadData: null,
          message:"Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

  factory GetLeadDetailsL.error(String jsons, int stcode) {
    return GetLeadDetailsL(
        leadDeatilsLeadData: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class GetLeadDeatilsLData {
  String? FollowMode;
  String? Followup_Date_Time;
  String? Status;
  String? Feedback;
  int? FollowupEntry;
  int? LeadDocEntry;
  String? NextFollowup_Date;
  String? UpdatedBy;

  GetLeadDeatilsLData({
    required this.FollowMode,
    required this.Followup_Date_Time,
    required this.Status,
    required this.Feedback,
    required this.FollowupEntry,
    required this.LeadDocEntry,
    required this.NextFollowup_Date,
    required this.UpdatedBy
  });

  factory GetLeadDeatilsLData.fromJson(Map<String, dynamic> json) => GetLeadDeatilsLData(
        FollowMode: json['followMode']== 'Phone'?'Phone Call':
        json['followMode']== 'Visit'?'Store Visit':json['followMode']== 'Text'?'Sms/WhatsApp':
        json['followMode']== 'Other'?'Other':'',
        Followup_Date_Time: json['followup_Date_Time'] ?? '',
        Status: json['status'] ?? '',
        Feedback: json['feedback'] ?? '',
        FollowupEntry: json['followupEntry'] ?? -1,
        LeadDocEntry: json['leadDocEntry'] ?? -1,
        NextFollowup_Date: json['nextFollowup_Date'] ?? '',
        UpdatedBy: json['updatedBy'] ?? '',
      );
}
