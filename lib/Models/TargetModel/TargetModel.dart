import 'dart:convert';
import 'dart:developer';

class TargetModal {
  String? resCode;
  String? respType;
  String? respDesc;
  String? exception;
  int? stcode;
  TargetData? targetdata;

  TargetModal(
      {required this.resCode,
      required this.respDesc,
      required this.respType,
      this.targetdata,
      required this.exception,
      required this.stcode});

  factory TargetModal.fromJson(dynamic jsons, int stcode) {
    if (jsons['respType'].toString() == 'success') {
      return TargetModal(
          targetdata: TargetData.fromJson(jsonDecode(jsons['data'])),
          stcode: stcode,
          exception: null,
          resCode: jsons['resCode'],
          respDesc: jsons['respDesc'].toString(),
          respType: jsons['respType'].toString());
    } else {
      return TargetModal(
          targetdata: null,
          resCode: jsons['resCode'].toString(),
          respDesc: jsons['respDesc'].toString(),
          respType: jsons['respType'].toString(),
          stcode: stcode,
          exception: null);
    }
  }
  factory TargetModal.error(String jsons, int stcode) {
    return TargetModal(
      targetdata: null,
      resCode: null,
      respDesc: null,
      respType: null,
      stcode: stcode,
      exception: jsons,
    );
  }
}

class TargetData {
  List<TargetMasterData> targetMasterData;
  List<TargetLineData>? targetLineData;
  TargetData({
    required this.targetMasterData,
    this.targetLineData,
  });
  factory TargetData.fromJson(
    Map<String, dynamic> jsons,
  ) {
    var masList = jsons['TargetMaster'] as List;

    List<TargetMasterData> dataMasList =
        masList.map((data) => TargetMasterData.fromJson(data)).toList();

    var lineList = jsons['TargetLine'] as List;
    List<TargetLineData> dataLineList =
        lineList.map((data) => TargetLineData.fromJson(data)).toList();

    return TargetData(
      targetMasterData: dataMasList,
      targetLineData: dataLineList,
    );
  }

  Map<String, dynamic> toJson1() => {
        'TargetMaster': targetMasterData,
        'TargetLine': targetLineData,
      };
}

class TargetLineData {
  String period;
  String productGroup;
  String targetVal;
  String achVal;
  String ach_Perc;
  TargetLineData({
    required this.achVal,
    required this.ach_Perc,
    required this.period,
    required this.productGroup,
    required this.targetVal,
  });
  factory TargetLineData.fromJson(dynamic json) => TargetLineData(
      achVal: json['AchVal'],
      ach_Perc: json['Ach_Perc'],
      period: json['Period'],
      productGroup: json['ProductGroup'],
      targetVal: json['TargetVal']);
}

class TargetMasterData {
  String? period;
  String? targetQty;
  String? targetValue;
  String? achQty;
  String? achVal;
  String? achPer;
  String? expCloseQty;
  String? expCloseVal;
  String? expClosePerc;
  String? bTGQty;
  String? bTGValue;
  String? runRatePerc;
  String? runRateVal;

  TargetMasterData(
      {required this.achPer,
      required this.achQty,
      required this.achVal,
      required this.bTGQty,
      required this.bTGValue,
      required this.expClosePerc,
      required this.expCloseQty,
      required this.expCloseVal,
      required this.period,
      required this.runRatePerc,
      this.runRateVal,
      required this.targetQty,
      this.targetValue});

  factory TargetMasterData.fromJson(dynamic json) => TargetMasterData(
      achPer: json['Ach_Per'] ?? 0,
      achQty: json['Ach_Qty'] ?? 0,
      achVal: json['Ach_Val'] ?? 0,
      bTGQty: json['BTG_Qty'] ?? 0,
      bTGValue: json['BTG_Value'] ?? 0,
      expClosePerc: json['Exp_Close_Perc'] ?? 0,
      expCloseQty: json['Exp_Close_Qty'] ?? 0,
      expCloseVal: json['Exp_Close_Val'] ?? 0,
      period: json['Period'] ?? "",
      runRatePerc: json['RunRatePerc'] ?? 0,
      runRateVal: json['RunRateValue'] ?? "",
      targetQty: json['Target_Qty'] ?? 0,
      targetValue: json['Target_Value'] ?? 0);
  Map<String, dynamic> toJson2() => {
        'Ach_Per': achPer,
        'Ach_Qty': achQty,
        'Ach_Val': achVal,
        'BTG_Qty': bTGQty,
        'BTG_Value': bTGValue,
        'Exp_Close_Perc': expClosePerc,
        'Exp_Close_Qty': expCloseQty,
        'Exp_Close_Val': expCloseVal,
        'Period': period,
        'RunRatePerc': runRatePerc,
        'RunRateValue': runRateVal,
        'Target_Qty': targetQty,
        'Target_Value': targetValue,
      };
}












// class TargetModal {
//   List<TargetMasterData>? targetdata;
//   String? message;
//   bool? status;
  // String? exception;
  // int? stcode;
  // TargetModal(
  //     {required this.targetdata,
//       required this.message,
//       required this.status,
//       this.exception,
//       required this.stcode});
  // factory TargetModal.fromJson(List<dynamic> jsons, int stcode) {
  //   if (jsons != null && jsons.isNotEmpty) {
  //     var list = jsons as List;
  //     List<TargetMasterData> dataList =
  //         list.map((data) => TargetMasterData.fromJson(data)).toList();
  //     return TargetModal(
  //         targetdata: dataList,
  //         message: "Success",
  //         status: true,
  //         stcode: stcode,
  //         exception: null);
  //   } else {
  //     return TargetModal(
  //         targetdata: null,
  //         message: "Failure",
  //         status: false,
  //         stcode: stcode,
  //         exception: null);
  //   }
  // }

//   factory TargetModal.error(String jsons, int stcode) {
//     return TargetModal(
//         targetdata: null,
//         message: null,
//         status: null,
//         stcode: stcode,
//         exception: jsons);
//   }
// }

// class TargetMasterData {
  // String? tPeriod;
  // String? kPI1Title;
  // String? kPI1MainValue;
  // String? kPI1SubValue;
  // String? kPI2Title;
  // String? kPI2MainValue;
  // String? kPI2SubValue;
  // String? kPI3Title;
  // String? kPI3MainValue;
  // String? kPI3SubValue;
  // String? kPI4Title;
  // String? kPI4MainValue;
  // String? kPI4SubValue;
//   TargetMasterData({
//     required this.tPeriod,
//     required this.kPI1MainValue,
//     required this.kPI1SubValue,
//     required this.kPI1Title,
//     required this.kPI2MainValue,
//     required this.kPI2SubValue,
//     required this.kPI2Title,
//     required this.kPI3MainValue,
//     required this.kPI3SubValue,
//     required this.kPI3Title,
//     required this.kPI4MainValue,
//     required this.kPI4SubValue,
//     required this.kPI4Title,
//   });

  // factory TargetMasterData.fromJson(Map<String, dynamic> json) => TargetMasterData(
  //       tPeriod: json['tPeriod'] ?? "",
  //       kPI1MainValue: json['kpI_1_MainValue'] ?? "",
  //       kPI1SubValue: json['kpI_1_SubValue'] ?? "",
  //       kPI1Title: json['kpI_1_Title'] ?? "",
  //       kPI2MainValue: json['kpI_2_MainValue'] ?? "",
  //       kPI2SubValue: json['kpI_2_SubValue'] ?? "",
  //       kPI2Title: json['kpI_2_Title'] ?? "",
  //       kPI3MainValue: json['kpI_3_MainValue'] ?? "",
  //       kPI3SubValue: json['kpI_3_SubValue'] ?? "",
  //       kPI3Title: json['kpI_3_Title'] ?? "",
  //       kPI4MainValue: json['kpI_4_MainValue'] ?? "",
  //       kPI4SubValue: json['kpI_4_SubValue'] ?? "",
  //       kPI4Title: json['kpI_4_Title'] ?? "",
  //     );
// }
