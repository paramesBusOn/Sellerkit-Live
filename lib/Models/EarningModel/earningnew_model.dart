import 'dart:convert';
import 'dart:developer';

class EarningNewModel1 {
  String? resCode;
  String? respType;
  String? respDesc;
  String? exception;
  int? stcode;
  EarningNewData? earningNewData;

  EarningNewModel1(
      {required this.resCode,
      required this.respDesc,
      required this.respType,
      this.earningNewData,
      required this.exception,
      required this.stcode});

  factory EarningNewModel1.fromJson(dynamic jsons, int stcode) {
    if (jsons['respType'].toString() == 'success') {
      return EarningNewModel1(
          earningNewData: EarningNewData.fromJson(jsonDecode(jsons['data'])),
          stcode: stcode,
          exception: null,
          resCode: jsons['resCode'],
          respDesc: jsons['respDesc'].toString(),
          respType: jsons['respType'].toString());
    } else {
      return EarningNewModel1(
          earningNewData: null,
          resCode: jsons['resCode'].toString(),
          respDesc: jsons['respDesc'].toString(),
          respType: jsons['respType'].toString(),
          stcode: stcode,
          exception: null);
    }
  }
  factory EarningNewModel1.issue(dynamic jsons, int stcode) {
    return EarningNewModel1(
      earningNewData: null,
      resCode: null,
      respDesc: null,
      respType: null,
      stcode: stcode,
      exception: jsons['respDesc'].toString(),
    );
  }
  factory EarningNewModel1.error(String e, int stcode) {
    return EarningNewModel1(
      earningNewData: null,
      resCode: null,
      respDesc: null,
      respType: null,
      stcode: stcode,
      exception: e.toString(),
    );
  }
}

class EarningNewData {
  List<EarningMasterData> incentiveMasterData;
  List<EarningLineData> incentiveLineData;
  EarningNewData({
    required this.incentiveMasterData,
    required this.incentiveLineData,
  });
  factory EarningNewData.fromJson(
    Map<String, dynamic> jsons,
  ) {
    var masList = jsons['IncentiveMaster'] as List;

    List<EarningMasterData> dataMasList =
        masList.map((data) => EarningMasterData.fromJson(data)).toList();

    var lineList = jsons['IncentiveLine'] as List;
    List<EarningLineData> dataLineList =
        lineList.map((data) => EarningLineData.fromJson(data)).toList();

    return EarningNewData(
      incentiveMasterData: dataMasList,
      incentiveLineData: dataLineList,
    );
  }

  Map<String, dynamic> toJson1() => {
        'TargetMaster': incentiveMasterData,
        'TargetLine': incentiveLineData,
      };
}

class EarningLineData {
  String transDate;
  String description;
  double amount;

  EarningLineData({
    required this.transDate,
    required this.description,
    required this.amount,
  });
  factory EarningLineData.fromJson(dynamic json) => EarningLineData(
      transDate: json['TransDate'],
      description: json['Description'],
      amount: json['Amount']);
}

class EarningMasterData {
  String? today;
  String? month;

  EarningMasterData({required this.today, this.month});

  factory EarningMasterData.fromJson(dynamic json) =>
      EarningMasterData(today: json['Today'] ?? '', month: json['MTD'] ?? '');
  Map<String, dynamic> toJson2() => {
        'Today': today,
        'MTD': month,
      };
}




// import 'dart:convert';

// class EarningNewModel12 {
//   List<EarningNewData2>? earningtabledata;
//   String? message;
//   bool? status;
//   String? exception;
//   int? stcode;
//   EarningNewModel12(
//       {required this.earningtabledata,
//       required this.message,
//       required this.status,
//       this.exception,
//       required this.stcode});
//   factory EarningNewModel12.fromJson(List< dynamic> jsons, int stcode) {
//     if (jsons != null && jsons.isNotEmpty) {
//       var list = jsons as List;
//       List<EarningNewData2> dataList =
//           list.map((data) => EarningNewData2.fromJson(data)).toList();
//       return EarningNewModel12(
//           earningtabledata: dataList,
//           message: "success",
//           status: true,
//           stcode: stcode,
//           exception: null);
//     } else {
//       return EarningNewModel12(
//           earningtabledata: null,
//           message: "Failure",
//           status: false,
//           stcode: stcode,
//           exception: null);
//     }
//   }

//   factory EarningNewModel12.error(String jsons, int stcode) {
//     return EarningNewModel12(
//         earningtabledata: null,
//         message: null,
//         status: null,
//         stcode: stcode,
//         exception: jsons);
//   }
// }

// class EarningNewData2 {
  
//   String? date;
//   String? transDetails;
//   double? amount;  
//   EarningNewData2({
   
//     required this.date,
//     required this.transDetails,
//     required this.amount
//   });

//   factory EarningNewData2.fromJson(Map<String, dynamic> json) => EarningNewData2(
       
//         date: json['date'],
//         transDetails: json['transDetails'] ?? "",
//         amount: json['amount'] 
//       );

// }
