import 'dart:convert';

class KpiModel {
  bool? status;
  String? msg;
  List<KpiModelData2>? data;
  String? resCode;
  int? stsCode;

  String? exception;
  KpiModel(
      {required this.status,
      required this.msg,
      required this.data,
      required this.resCode,
      required this.stsCode,
      this.exception});

  factory KpiModel.fromJson(Map<String, dynamic> jsons, int stsCode) {
    if (jsons["data"] != null && jsons.isNotEmpty) {
      var list = jsonDecode(jsons["data"]) as List;

      List<KpiModelData2> dataList =
          list.map((data) => KpiModelData2.fromJson(data)).toList();
      return KpiModel(
          status: true,
          msg: "Success",
          stsCode: stsCode,
          data: dataList,
          resCode: jsons['respCode'],
          exception: null);
    } else {
      return KpiModel(
          status: false,
          msg: "Failure",
          data: null,
          stsCode: stsCode,
          resCode: jsons['respCode'],
          exception: null);
    }
  }

  factory KpiModel.issue(int rescode, String excep) {
    return KpiModel(
        status: null,
        msg: null,
        data: null,
        stsCode: rescode,
        resCode: null,
        exception: excep);
  }
}
// {
//     "respType": "Success",
//     "respCode": "SK100",
//     "respDesc": "Access Granted",
//     "data": "[{"WidgetCode":"C01","KPICode":"KP01","Userid":214,"DisplayName":"Open Enquiries","Severity":"High","MainValue":"163","SubValue":null},{"WidgetCode":"C02","KPICode":"KP02","Userid":214,"DisplayName":"Open Leads","Severity":"High","MainValue":"204","SubValue":null},
//{"WidgetCode":"C03","KPICode":"KP03","Userid":214,"DisplayName":"Enquiry Conversion Ratio","Severity":"High","MainValue":"19.54%","SubValue":null},{"WidgetCode":"C04","KPICode":"KP04","Userid":214,"DisplayName":"Today Followup","Severity":"High","MainValue":"0","SubValue":null},{"WidgetCode":"C05","KPICode":"KP05","Userid":214,"DisplayName":"Overdue Followup","Severity":"High","MainValue":"198","SubValue":null},{"WidgetCode":"C06","KPICode":"KP06","Userid":214,"DisplayName":"Sales Conversion","Severity":"High","MainValue":"14.56","SubValue":null},{"WidgetCode":"C07","KPICode":"KP07","Userid":214,"DisplayName":"Sales MTD","Severity":"Mid","MainValue":"Rs. 14.27 Cr","SubValue":null},{"WidgetCode":"C08","KPICode":"KP08","Userid":214,"DisplayName":"Target","Severity":"Mid","MainValue":"Rs.1.00 Lacs","SubValue":null},{"WidgetCode":"C09","KPICode":"KP09","Userid":214,"DisplayName":"Achievement","Severity":"Mid","MainValue":"0.00%","SubValue":null},{"WidgetCode":"C10","KPICode":"KP10","Userid":214,"DisplayName":"Day Target","Severity":"Mid","MainValue":"Rs. 5.26 K","SubValue":null},{"WidgetCode":"C11","KPICode":"KP11","Userid":214,"DisplayName":"Today Achievement","Severity":"Mid","MainValue":"0.00%","SubValue":null},
//{"WidgetCode":"C12","KPICode":"KP12","Userid":214,"DisplayName":"Run Rate","Severity":"High","MainValue":"157.89%","SubValue":null}

class KpiModelData2 {
  int userId;
  String widgetCode;
  String kpiCode;
  String displayName;
  String severity;
  String mainValue;
  String subValue;

  KpiModelData2(
      {required this.displayName,
      required this.kpiCode,
      required this.mainValue,
      required this.severity,
      required this.subValue,
      required this.userId,
      required this.widgetCode});

  factory KpiModelData2.fromJson(Map<String, dynamic> json) {
    return KpiModelData2(
        displayName: json['DisplayName'] != null ? json['DisplayName'] : '',
        kpiCode: json['KPICode'] != null ? json['KPICode'] : '',
        mainValue:
            // '300',
            json['MainValue'] != null ? json['MainValue'] : '',
        severity: json['Severity'] != null ? json['Severity'] : '',
        subValue: json['SubValue'] != null ? json['SubValue'] : '',
        userId: json['Userid'] != null ? json['Userid'] : 0,
        widgetCode: json['WidgetCode'] != null ? json['WidgetCode'] : '');
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

  KpiModelData(
      {required this.Enquiries,
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
      required this.TillNow});

  factory KpiModelData.fromJson(Map<String, dynamic> json) {
    return KpiModelData(
        Enquiries: json["enquiries"],
        OpenLeads: json["openLeads"],
        LeadConversion: json["leadConversion"],
        TodayFUP: json['todayFUP'],
        OverdueFUP: json['overdueFUP'],
        SalesConversion: json['salesConversion'],
        Ach: json['ach'],
        DayTarget: json['dayTarget'],
        NPS: json['nps'],
        RunRate: json['runRate'],
        Sales: json['sales'],
        Target: json['target'],
        TillNow: json['tillNow']);
  }
}
