import 'dart:convert';

class KpiModel {
  bool? status;
  String? msg;
  KpiModelData? data;
  int? resCode;
  String? exception;
  KpiModel(
      {
      required this.status,
      required this.msg,
      this.data,
      required this.resCode,
      this.exception
      });

  factory KpiModel.fromJson(Map<String, dynamic> jsons, int rescode) {
    if (jsons != null &&jsons.isNotEmpty) {
      //  var list = jsonDecode(jsons["data"]) as List;

      // List<KpiModelData> dataList =
      //     list.map((data) => KpiModelData.fromJson(data)).toList();
      return KpiModel(
          status: true ,
          msg: "Success",
          data: KpiModelData.fromJson(jsons),
          resCode: rescode,
          exception: null
          );
    } else {
      return KpiModel(
          status: false ,
          msg: "Failure",
          data: null,
          resCode: rescode,
          exception: null
          );
    }
  }

  factory KpiModel.issue(int rescode,String excep) {
    return KpiModel(
        status: null, msg: null, data: null, resCode: rescode,
        exception: excep
        );
  }
}

class KpiModelData {
  int Enquiries;
  int OpenLeads;
  dynamic LeadConversion;
  int TodayFUP;
  int OverdueFUP;
  dynamic SalesConversion;
  dynamic NPS;
  int Sales;
  dynamic Target;
  dynamic Ach;
  dynamic DayTarget;
  int TillNow;
  dynamic RunRate;

  KpiModelData({
    required this.Enquiries,
    required this.OpenLeads,
    required this.LeadConversion,
    required this.TodayFUP,
    required this.OverdueFUP,
    required this.SalesConversion,
    required this.NPS,
    required this.Sales,
    required this.Target,
    required this.Ach,
    required this.DayTarget,
    required this.RunRate,
    required this.TillNow
  });

  factory KpiModelData.fromJson(Map<String, dynamic> json) {
    return KpiModelData(
      Enquiries: json["enquiries"],
      OpenLeads: json["openLeads"],
      LeadConversion: json["leadConversion"],
      TodayFUP:json['todayFUP'], 
      OverdueFUP:json['overdueFUP'], 
      SalesConversion:json['salesConversion'], 
      Ach: json['ach'], 
      DayTarget:json['dayTarget'],  
      NPS:json['nps'], 
      RunRate:json['runRate'], 
      Sales:json['sales'], 
      Target: json['target'], 
      TillNow: json['tillNow'] );
  }
}


