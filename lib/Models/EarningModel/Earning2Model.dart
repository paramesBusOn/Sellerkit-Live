// import 'dart:convert';
// import 'dart:developer';

// class EarningModel2 {
//   EarningData2? earningtabledata;
//   String? resType;
//   String? respCode;
//   String? respDesc;
//   String? exception;
//   int? stcode;
//   EarningModel2(
//       {required this.earningtabledata,
//       required this.resType,
//       required this.respCode,
//       required this.respDesc,
//       this.exception,
//       required this.stcode});
//   factory EarningModel2.fromJson(dynamic jsons, int stscode) {
//     if (jsons['respType'] == 'success') {
//       log('message::${jsons['data']}');
//       log('stscodestscode:${jsons['respDesc']}');

//       return EarningModel2(
//         resType: jsons['respType'].toString(),
//         respCode: jsons['respCode'].toString(),
//         respDesc: jsons['respDesc'].toString(),
//         earningtabledata: EarningData2.fromJson(jsonDecode(jsons['data'])),
//         stcode: stscode,
//         exception: null,
//       );
//     } else {
//       return EarningModel2(
//           earningtabledata: null,
//           resType: jsons['respType'].toString(),
//           respCode: jsons['respCode'].toString(),
//           respDesc: jsons['respDesc'].toString(),
//           stcode: stscode,
//           exception: null);
//     }
//   }

//   factory EarningModel2.error(String jsons, int stcode) {
//     return EarningModel2(
//         earningtabledata: null,
//         resType: null,
//         respCode: null,
//         respDesc: null,
//         stcode: stcode,
//         exception: jsons);
//   }
// }

// class EarningData2 {
//   List<EarningDetailsData2> eraningDetData;
//   EarningData2({
//     required this.eraningDetData,
//   });

//   factory EarningData2.fromJson(
//     Map<String, dynamic> jsons,
//   ) {
//     log('xxxxx:');
//     log('yyyyy:::${jsons['IncentiveDetails'].toString()}');
//     List earningDet = jsons['IncentiveDetails'];

//     List<EarningDetailsData2> dataMasList =
//         earningDet.map((data) => EarningDetailsData2.fromJson(data)).toList();

//     return EarningData2(
//       eraningDetData: dataMasList,
//     );
//   }

//   Map<String, dynamic> toJson1() => {
//         'IncentiveDetails': eraningDetData,
//       };
// }
import 'dart:convert';
import 'dart:developer';

class EarningModel2 {
  String? resCode;
  String? respType;
  String? respDesc;
  String? exception;
  int? stcode;
  EarningData2? earningData2;

  EarningModel2(
      {required this.resCode,
      required this.respDesc,
      required this.respType,
      required this.earningData2,
      required this.exception,
      required this.stcode});

  factory EarningModel2.fromJson(dynamic jsons, int stcode) {
    if (jsons['respType'].toString() == 'success') {
      log('jsonDecode(jsons data)::${jsons['data'].toString()}');
      return EarningModel2(
        stcode: stcode,
        exception: null,
        resCode: jsons['resCode'],
        respDesc: jsons['respDesc'].toString(),
        respType: jsons['respType'].toString(),
        earningData2: EarningData2.fromJson(jsonDecode(jsons['data'])),
      );
    } else {
      return EarningModel2(
          earningData2: null,
          resCode: jsons['resCode'].toString(),
          respDesc: jsons['respDesc'].toString(),
          respType: jsons['respType'].toString(),
          stcode: stcode,
          exception: null);
    }
  }
  factory EarningModel2.error(String jsons, int stcode) {
    return EarningModel2(
      earningData2: null,
      resCode: null,
      respDesc: null,
      respType: null,
      stcode: stcode,
      exception: jsons,
    );
  }
}

class EarningData2 {
  List<EarningDetLineData> incentiveLineData;
  EarningData2({
    required this.incentiveLineData,
  });
  factory EarningData2.fromJson(
    Map<String, dynamic> jsons,
  ) {
    var masList = jsons['IncentiveDetails'] as List;
    log("messagemessage::${jsons['IncentiveDetails']}");

    List<EarningDetLineData> dataLineList =
        masList.map((data) => EarningDetLineData.fromJson(data)).toList();
    return EarningData2(incentiveLineData: dataLineList);
  }

  Map<String, dynamic> toJson1() => {
        'IncentiveDetails': incentiveLineData,
      };
}

class EarningDetLineData {
  String transDate;
  String description;
  double amount;

  EarningDetLineData({
    required this.transDate,
    required this.description,
    required this.amount,
  });
  factory EarningDetLineData.fromJson(dynamic json) {
    log('Llllllllll:${json['TransDate'].toString()}');

    return EarningDetLineData(
        transDate:
            json['TransDate'].isEmpty ? '' : json['TransDate'].toString(),
        description: json['Description'].toString(),
        amount: json['Amount']);
  }
  Map<String, dynamic> toJson2() => {
        'TransDate': transDate,
        'Description': description,
        'Amount': amount,
      };
}
// class EarningDetailsData2 {
//   String date;
//   String? transDetails;
//   double? amount;
//   EarningDetailsData2(
//       {required this.date, required this.transDetails, required this.amount});

//   factory EarningDetailsData2.fromJson(Map<String, dynamic> json) =>
//       EarningDetailsData2(
//           date: json['TransDate'].isEmpty ? '' : json['TransDate'].toString(),
//           transDetails: json['Description'] ?? "",
//           amount: json['Amount']);

  // Map<String, dynamic> toJson1() => {
  //       'TransDate': date,
  //       'Description': transDetails,
  //       'Amount': amount,
  //     };
// }
