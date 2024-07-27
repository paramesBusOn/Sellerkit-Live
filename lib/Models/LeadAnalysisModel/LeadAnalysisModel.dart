import 'dart:convert';
import 'dart:developer';
import 'package:sellerkit/Controller/ReportsController/ReportsController.dart';
import 'package:sellerkit/DBModel/ReportsModel/LeadAnalysisModel.dart';
import '../../DBModel/ReportsModel/LeadAnalysViewDB.dart';
import '../../DBModel/ReportsModel/LeadQueryDB.dart';
import '../../DBModel/ReportsModel/LeadReportModel.dart';
import 'TestReportModel.dart';

class LeadAnalysisModel {
  LeadAnalysisModel(
      {required this.respCode,
      required this.datadetail,
      required this.respDesc,
      required this.respType,
      required this.stcode,
      required this.exception});

  String? respType;
  String? respCode;
  String? respDesc;
  int? stcode;
  String? exception;
  LeadAnalysisDataList? datadetail;

  factory LeadAnalysisModel.fromJson(dynamic jsons, int? stcode) {
    if (jsons["data"] == null) {
      return LeadAnalysisModel(
          respCode: jsons['respCode'],
          datadetail: null,
          exception: null,
          respDesc: jsons['respDesc'],
          respType: jsons['respType'],
          stcode: stcode!);
    } else {
      return LeadAnalysisModel(
          exception: null,
          respCode: jsons['respCode'],
          datadetail: LeadAnalysisDataList.fromJson(jsonDecode(jsons['data'])),
          respDesc: jsons['respDesc'],
          respType: jsons['respType'],
          stcode: stcode!);
    }
  }
  factory LeadAnalysisModel.issues(Map<String, dynamic> jsons, int stcode) {
    return LeadAnalysisModel(
        exception: null,
        respCode: jsons['respCode'],
        datadetail: null,
        respDesc: jsons['respDesc'],
        respType: jsons['respType'],
        stcode: stcode);
  }
  factory LeadAnalysisModel.error(String jsons, int stcode) {
    return LeadAnalysisModel(
        respCode: null,
        datadetail: null,
        exception: jsons,
        respDesc: null,
        respType: null,
        stcode: stcode);
  }
}

class LeadAnalysisDataList {
  List<LeadAnalysisMasterData> leadMasterData;
  List<LeadAnalysisReportData> leadReportData;
  List<LeadAnalysisViewData> leadViewData;
  List<LeadReportQueryData> leadQueryData;

  LeadAnalysisDataList(
      {required this.leadMasterData,
      required this.leadReportData,
      required this.leadQueryData,
      required this.leadViewData});
  factory LeadAnalysisDataList.fromJson(
    Map<String, dynamic> jsons,
  ) {
    var masterList = jsons["LeadMaster"] as List;
    List<LeadAnalysisMasterData> masterDataList = masterList
        .map((data) => LeadAnalysisMasterData.fromJson(data))
        .toList();
    var reportList = jsons["ReportList"] as List;
    List<LeadAnalysisReportData> reportDataList = [];
    if (reportList.length > 0) {
      List<String> columnNames = reportList[0].keys.toList();
      // print("object2::" + columnNames.toString());
      // log("reportListreportList::" + reportList.toList().toString());
      for (int i = 0; i < reportList.length; i++) {
        if (reportList[0].keys.contains(columnNames[0])) {
          // log("title::" + reportList[i].toString());
        }
        // log("object5::" + reportList[i].toString());
      }
      reportDataList = reportList
          .map((data) => LeadAnalysisReportData.fromJson(data, columnNames))
          .toList();
    }
    log('jsons ReportDescription::${jsons["ReportDescription"]}');
    var viewList = jsons["ReportDescription"] as List;

    List<LeadAnalysisViewData> reportViewDataList =
        viewList.map((data) => LeadAnalysisViewData.fromJson(data)).toList();
    var queryList = jsons["ReportQueryList"] as List;
    List<LeadReportQueryData> reportQueryList =
        queryList.map((data) => LeadReportQueryData.fromJson(data)).toList();

    return LeadAnalysisDataList(
      leadMasterData: masterDataList,
      leadReportData: reportDataList,
      leadViewData: reportViewDataList,
      leadQueryData: reportQueryList,
    );
  }
}

class LeadAnalysisMasterData {
  int leadId;
  String leadDate;
  String customerCode;
  String customerName;
  String customerMobile;
  String customerEmail;
  String companyName;
  String customerGroup;
  String storeCode;
  String storeName;
  String address1;
  String address2;
  String area;
  String city;
  String district;
  String state;
  String country;
  int pincode;
  String gender;
  String ageGroup;
  String cameAs;
  int headcount;
  double maxbudget;
  String assignedTo;
  String refferal;
  String interestLevel;
  String orderType;
  String purchasePlan;
  String nextFollowupDate;
  String dealDescription;
  String status;
  String lastFollowupStatus;
  String lastFollowupDate;
  String itemCode;
  String itemName;
  String brand;
  String category;
  String subCategory;
  double leadValue;
  int createdBy;
  String createdDate;
  int updatedBy;
  String updatedDate;
  String traceId;
  String customerCreatedOn;

  LeadAnalysisMasterData({
    required this.leadId,
    required this.leadDate,
    required this.customerCode,
    required this.customerName,
    required this.customerMobile,
    required this.customerEmail,
    required this.companyName,
    required this.customerGroup,
    required this.storeCode,
    required this.storeName,
    required this.address1,
    required this.address2,
    required this.area,
    required this.city,
    required this.district,
    required this.state,
    required this.country,
    required this.pincode,
    required this.gender,
    required this.ageGroup,
    required this.cameAs,
    required this.headcount,
    required this.maxbudget,
    required this.assignedTo,
    required this.refferal,
    required this.interestLevel,
    required this.orderType,
    required this.purchasePlan,
    required this.nextFollowupDate,
    required this.dealDescription,
    required this.status,
    required this.lastFollowupStatus,
    required this.lastFollowupDate,
    required this.itemCode,
    required this.itemName,
    required this.brand,
    required this.category,
    required this.subCategory,
    required this.leadValue,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
    required this.traceId,
    required this.customerCreatedOn,
  });

  factory LeadAnalysisMasterData.fromJson(dynamic json) {
    return LeadAnalysisMasterData(
      leadId: json["LeadId"] == null ? 0 : int.parse(json["LeadId"].toString()),
      leadDate: json["LeadDate"] ?? '',
      customerCode: json["CustomerCode"] ?? '',
      customerName: json["CustomerName"] ?? '',
      customerMobile: json["CustomerMobile"] ?? '',
      customerEmail: json["CustomerEmail"] ?? '',
      companyName: json["CompanyName"] ?? '',
      customerGroup: json["CustomerGroup"] ?? '',
      storeCode: json["StoreCode"] ?? '',
      storeName: json["StoreName"] ?? '',
      address1: json["Address1"] ?? '',
      address2: json["Address2"] ?? '',
      area: json["Area"] ?? '',
      city: json["City"] ?? '',
      district: json["District"] ?? '',
      state: json["State"] ?? '',
      country: json["Country"] ?? '',
      pincode:
          json["Pincode"] == null ? 0 : int.parse(json["Pincode"].toString()),
      gender: json["Gender"] ?? '',
      ageGroup: json["AgeGroup"] ?? '',
      cameAs: json["CameAs"] ?? '',
      headcount: json["Headcount"] ?? 0,
      maxbudget: json["Maxbudget"] ?? 0.0,
      assignedTo: json["AssignedTo"] ?? '',
      refferal: json["Refferal"] ?? '',
      interestLevel: json["InterestLevel"] ?? '',
      orderType: json["OrderType"] ?? '',
      purchasePlan: json["PurchasePlan"] ?? '',
      nextFollowupDate: json["NextFollowupDate"] ?? '',
      dealDescription: json["DealDescription"] ?? '',
      status: json["Status"] ?? '',
      lastFollowupStatus: json["LastFollowupStatus"] ?? '',
      lastFollowupDate: json["LastFollowupDate"] ?? '',
      itemCode: json["ItemCode"] ?? '',
      itemName: json["ItemName"] ?? '',
      brand: json["Brand"] ?? '',
      category: json["Category"] ?? '',
      subCategory: json["SubCategory"] ?? '',
      leadValue: json["LeadValue"] ?? 0.0,
      createdBy: json["CreatedBy"] ?? 0,
      createdDate: json["CreatedDate"] ?? '',
      updatedBy: json["UpdatedBy"] ?? 0,
      updatedDate: json["UpdatedDate"] ?? '',
      traceId: json["TraceId"] ?? '',
      customerCreatedOn: json["CustomerCreatedOn"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "LeadId": leadId,
        "LeadDate": leadDate,
        "CustomerCode": customerCode,
        "CustomerName": customerName,
        "CustomerMobile": customerMobile,
        "CustomerEmail": customerEmail,
        "CompanyName": companyName,
        "CustomerGroup": customerGroup,
        "StoreCode": storeCode,
        "StoreName": storeName,
        "Address1": address1,
        "Address2": address2,
        "Area": area,
        "City": city,
        "District": district,
        "State": state,
        "Country": country,
        "Pincode": pincode,
        "Gender": gender,
        "AgeGroup": ageGroup,
        "CameAs": cameAs,
        "Headcount": headcount,
        "Maxbudget": maxbudget,
        "AssignedTo": assignedTo,
        "Refferal": refferal,
        "InterestLevel": interestLevel,
        "OrderType": orderType,
        "PurchasePlan": purchasePlan,
        "NextFollowupDate": nextFollowupDate,
        "DealDescription": dealDescription,
        "Status": status,
        "LastFollowupStatus": lastFollowupStatus,
        "LastFollowupDate": lastFollowupDate,
        "ItemCode": itemCode,
        "ItemName": itemName,
        "Brand": brand,
        "Category": category,
        "SubCategory": subCategory,
        "LeadValue": leadValue,
        "CreatedBy": createdBy,
        "CreatedDate": createdDate,
        "UpdatedBy": updatedBy,
        "UpdatedDate": updatedDate,
        "TraceId": traceId,
        "CustomerCreatedOn": customerCreatedOn,
      };
  Map<String, Object?> toMap() => {
        LeadAnalysisDB.leadId: leadId,
        LeadAnalysisDB.leadDate: leadDate,
        LeadAnalysisDB.customerCode: customerCode,
        LeadAnalysisDB.customerName: customerName,
        LeadAnalysisDB.customerMobile: customerMobile,
        LeadAnalysisDB.customerEmail: customerEmail,
        LeadAnalysisDB.companyName: companyName,
        LeadAnalysisDB.customerGroup: customerGroup,
        LeadAnalysisDB.storeCode: storeCode,
        LeadAnalysisDB.storeName: storeName,
        LeadAnalysisDB.address1: address1,
        LeadAnalysisDB.address2: address2,
        LeadAnalysisDB.area: area,
        LeadAnalysisDB.city: city,
        LeadAnalysisDB.district: district,
        LeadAnalysisDB.state: state,
        LeadAnalysisDB.country: country,
        LeadAnalysisDB.pincode: pincode,
        LeadAnalysisDB.gender: gender,
        LeadAnalysisDB.ageGroup: ageGroup,
        LeadAnalysisDB.cameAs: cameAs,
        LeadAnalysisDB.headcount: headcount,
        LeadAnalysisDB.maxbudget: maxbudget,
        LeadAnalysisDB.assignedTo: assignedTo,
        LeadAnalysisDB.refferal: refferal,
        LeadAnalysisDB.interestLevel: interestLevel,
        LeadAnalysisDB.orderType: orderType,
        LeadAnalysisDB.purchasePlan: purchasePlan,
        LeadAnalysisDB.nextFollowupDate: nextFollowupDate,
        LeadAnalysisDB.dealDescription: dealDescription,
        LeadAnalysisDB.status: status,
        LeadAnalysisDB.lastFollowupStatus: lastFollowupStatus,
        LeadAnalysisDB.lastFollowupDate: lastFollowupDate,
        LeadAnalysisDB.itemCode: itemCode,
        LeadAnalysisDB.itemName: itemName,
        LeadAnalysisDB.brand: brand,
        LeadAnalysisDB.category: category,
        LeadAnalysisDB.subCategory: subCategory,
        LeadAnalysisDB.leadValue: leadValue,
        LeadAnalysisDB.createdBy: createdBy,
        LeadAnalysisDB.createdDate: createdDate,
        LeadAnalysisDB.updatedBy: updatedBy,
        LeadAnalysisDB.updatedDate: updatedDate,
        LeadAnalysisDB.traceId: traceId,
        LeadAnalysisDB.customerCreatedOn: customerCreatedOn,
      };
}

class LeadAnalysisReportData {
  String title;
  String value;
  String assignedTo;
  String customerGroup;
  String leadDate;
  String nextFollowupDate;
  String status;
  String orderType;
  String interestLevel;
  double leadValue;
  List<TestReportValues> testReport2 = [];

  LeadAnalysisReportData(
      {required this.assignedTo,
      required this.customerGroup,
      required this.interestLevel,
      required this.leadDate,
      required this.leadValue,
      required this.nextFollowupDate,
      required this.orderType,
      required this.status,
      required this.title,
      required this.value});
  factory LeadAnalysisReportData.fromJson(dynamic json, List<String> titles) {
    // print("object::${json[titles[0]]}");

    for (int i = 0; i < titles.length; i++) {
      ReportsController.insertTestValues.add(TestReportValues(
          reportValues: json[titles[i]].toString(),
          titleVal: titles[i].toString()));
      // print('Answser:' + titles[i].toString());
      // print('Answser:' + json[titles[i]].toString());
      // print("-----------------------");
    }
    return LeadAnalysisReportData(
      assignedTo: json["AssignedTo"],
      leadDate: json["LeadDate"] ?? '',
      customerGroup: json["CustomerGroup"] ?? '',
      leadValue: json["LeadValue"] == null
          ? 0
          : double.parse(json["LeadValue"].toString()),
      interestLevel: json["InterestLevel"] ?? '',
      orderType: json["OrderType"] ?? '',
      status: json["Status"] ?? '',
      nextFollowupDate: json["NextFollowupDate"] ?? '',
      title: json["NextFollowupDate"] ?? '',
      value: json["NextFollowupDate"] ?? '',
    );
  }
  Map<String, Object?> toMap() => {
        LeadAnalysisReportDB.assignedTo: assignedTo,
        LeadAnalysisReportDB.customerGroup: customerGroup,
        LeadAnalysisReportDB.interestLevel: interestLevel,
        LeadAnalysisReportDB.leadDate: leadDate,
        LeadAnalysisReportDB.leadValue: leadValue,
        LeadAnalysisReportDB.status: status,
        LeadAnalysisReportDB.orderType: orderType,
        LeadAnalysisReportDB.nextFollowupDate: nextFollowupDate,
      };
}

class LeadAnalysisViewData {
  int docEntry;
  String reportCode;
  String viewCode;
  String viewName;
  LeadAnalysisViewData({
    required this.docEntry,
    required this.reportCode,
    required this.viewName,
    required this.viewCode,
  });
  factory LeadAnalysisViewData.fromJson(dynamic json) {
    return LeadAnalysisViewData(
        docEntry: json['DocEntry'],
        reportCode: json['ReportCode'],
        viewName: json['ViewName'],
        viewCode: json['ViewCode']);
  }
  Map<String, Object?> toMap() => {
        LeadAnalysisViewDB.docEntry: docEntry,
        LeadAnalysisViewDB.reportCode: reportCode,
        LeadAnalysisViewDB.viewCode: viewCode,
        LeadAnalysisViewDB.viewName: viewName,
      };
}

//{\"ViewCode\":\"A100\",\"Chart_type\":\"Pie_Chart\",\"Query\":\"Select StoreCode as name , Sum(LeadValue) as value From LeadReport Where 1 =1 AND \"}
class LeadReportQueryData {
  String? viewCode;
  String? chartType;
  String? leadQuery;
  String kpiTitle;
  int? rowCode;
  String? queryExt;
  LeadReportQueryData(
      {this.chartType,
      this.rowCode,
      required this.kpiTitle,
      this.leadQuery,
      this.viewCode,
      required this.queryExt});
  factory LeadReportQueryData.fromJson(dynamic json) {
    return LeadReportQueryData(
        chartType: json['Chart_type'],
        rowCode: json['Row_Code'],
        kpiTitle:
            json['KPITitle'].toString().isNotEmpty || json['KPITitle'] != null
                ? json['KPITitle']
                : '',
        leadQuery: json['Query'],
        queryExt: json['QueryExt'],
        viewCode: json['ViewCode']);
  }
  Map<String, Object?> toMap() => {
        LeadAnalysisQueryDB.chartType: chartType,
        LeadAnalysisQueryDB.leadQuery: leadQuery,
        LeadAnalysisQueryDB.viewCode: viewCode,
        LeadAnalysisQueryDB.rowCode: rowCode,
        LeadAnalysisQueryDB.queryExt: queryExt,
        LeadAnalysisQueryDB.kpiTitle: kpiTitle,
      };
}
