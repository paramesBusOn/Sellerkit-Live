// // ignore_for_file: unnecessary_new, non_constant_identifier_names

// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/cupertino.dart';
// import 'package:sellerkit/Constant/Configuration.dart';
// import 'package:sellerkit/Constant/ConstantSapValues.dart';
// import '../../Models/PostQueryModel/FollowUPModel.dart/FollowUPModel.dart';
// import '../../Models/PostQueryModel/FollowUPModel.dart/FollowUpModelNew1.dart';
// import '../../Services/PostQueryApi/FollowUPApi.dart/FollowUPListApi.dart';

// class FollowUPControllerOLD extends ChangeNotifier {
//   FollowUPControllerOLD() {
//     callFollowUPApi();
//   }
//   Config config = new Config();
//   bool isLoading = true;
//   bool get getisLoading => isLoading;

//   String excepMsg = '';
//   String get getexcepMsg => excepMsg;

//   List<FollowUPListData> fupListData = [];
//   List<FollowUPListData> get getfupListData => fupListData;

//   List<FlupMLHeader> flupMLHeader = [];
//   List<FlupMLHeader> flupMLHeader2 = [];

//   callFollowUPApi() {
//     FollowUPListApi.getData(ConstantValues.sapUserID).then((value) {
//       isLoading = false;
//       if (value.stcode! >= 200 && value.stcode! <= 210) {
//         if (value.followUPListData != null) {
//           fupListData = value.followUPListData!;
//           // createaMAp2(value.followUPListData!);
//           createaMAp3(value.followUPListData!);
//           getdataDistinct();
//           // mapToFollowUPHeader( value.followUPListData!);
//         } else if (value.followUPListData == null) {
//           excepMsg = 'Something went wrong try again...!!';
//         }
//       } else if (value.stcode! >= 400 && value.stcode! <= 410) {
//         excepMsg = 'Something went wrong try again...!!';
//       } else if (value.stcode == 500) {
//         if (value.exception == 'No route to host') {
//           excepMsg = 'Check your Internet Connection...!!';
//         } else {
//           excepMsg = 'Something went wrong try again...!!';
//         }
//       }
//       notifyListeners();
//     });
//   }

//   clearData() {
//     isLoading = true;
//     excepMsg = '';
//     notifyListeners();
//   }

//   List<FollowUPListData> flupchild = [];
//   mapToFollowUPHeader(List<FollowUPListData> followUPListData) {
//     log("followup data: " + followUPListData.length.toString());
//     for (int i = 0; i < followUPListData.length; i++) {
//       if (flupMLHeader.isEmpty) {
//         flupchild.add(FollowUPListData(
//             FollowupDate: followUPListData[i].FollowupDate,
//             LeadDocEntry: followUPListData[i].LeadDocEntry,
//             LeadDocNum: followUPListData[i].LeadDocNum,
//             FollowupEntry: followUPListData[i].FollowupEntry,
//             Phone: followUPListData[i].Phone,
//             Customer: followUPListData[i].Customer,
//             CretedDate: followUPListData[i].CretedDate,
//             LastFollowupDate: followUPListData[i].LastFollowupDate,
//             DocTotal: followUPListData[i].DocTotal,
//             Quantity: followUPListData[i].Quantity,
//             Product: followUPListData[i].Product,
//             LastFollowupStatus: followUPListData[i].LastFollowupStatus,
//             LastFollowup_Feedback: followUPListData[i].LastFollowup_Feedback,
//             CustomerInitialIcon: followUPListData[i].CustomerInitialIcon,
//             height: followUPListData[i].height));
//         flupMLHeader.add(FlupMLHeader(
//             FollwUPDate: followUPListData[i].FollowupDate,
//             flupchild: flupchild));
//       } else {
//         for (int j = 0; j < flupMLHeader.length; j++) {
//           if (flupMLHeader[j].FollwUPDate == followUPListData[i].FollowupDate) {
//             flupchild.add(FollowUPListData(
//                 FollowupDate: followUPListData[i].FollowupDate,
//                 LeadDocEntry: followUPListData[i].LeadDocEntry,
//                 LeadDocNum: followUPListData[i].LeadDocNum,
//                 FollowupEntry: followUPListData[i].FollowupEntry,
//                 Phone: followUPListData[i].Phone,
//                 Customer: followUPListData[i].Customer,
//                 CretedDate: followUPListData[i].CretedDate,
//                 LastFollowupDate: followUPListData[i].LastFollowupDate,
//                 DocTotal: followUPListData[i].DocTotal,
//                 Quantity: followUPListData[i].Quantity,
//                 Product: followUPListData[i].Product,
//                 LastFollowupStatus: followUPListData[i].LastFollowupStatus,
//                 LastFollowup_Feedback:
//                     followUPListData[i].LastFollowup_Feedback,
//                 CustomerInitialIcon: followUPListData[i].CustomerInitialIcon,
//                 height: followUPListData[i].height));
//             flupMLHeader.add(FlupMLHeader(
//                 FollwUPDate: followUPListData[i].FollowupDate,
//                 flupchild: flupchild));
//           } else {
//             flupchild.add(FollowUPListData(
//                 FollowupDate: followUPListData[i].FollowupDate,
//                 LeadDocEntry: followUPListData[i].LeadDocEntry,
//                 LeadDocNum: followUPListData[i].LeadDocNum,
//                 FollowupEntry: followUPListData[i].FollowupEntry,
//                 Phone: followUPListData[i].Phone,
//                 Customer: followUPListData[i].Customer,
//                 CretedDate: followUPListData[i].CretedDate,
//                 LastFollowupDate: followUPListData[i].LastFollowupDate,
//                 DocTotal: followUPListData[i].DocTotal,
//                 Quantity: followUPListData[i].Quantity,
//                 Product: followUPListData[i].Product,
//                 LastFollowupStatus: followUPListData[i].LastFollowupStatus,
//                 LastFollowup_Feedback:
//                     followUPListData[i].LastFollowup_Feedback,
//                 CustomerInitialIcon: followUPListData[i].CustomerInitialIcon,
//                 height: followUPListData[i].height));
//             flupMLHeader.add(FlupMLHeader(
//                 FollwUPDate: followUPListData[i].FollowupDate,
//                 flupchild: flupchild));
//           }
//         }
//       }
//     }
//     log("data list: " +
//         flupMLHeader.map((e) => e.tojson()).toList().toString());
//   }

//   createaMAp(List<FollowUPListData> followUPListData) {
//     var mapValue = {};
//     log("followup length data: " + followUPListData.length.toString());

//     for (int i = 0; i < followUPListData.length; i++) {
//       if (mapValue.isEmpty) {
//         mapValue.addAll({
//           followUPListData[i].FollowupDate: [
//             {
//               "LeadDocEntry": followUPListData[i].LeadDocEntry,
//               "LeadDocNum": followUPListData[i].LeadDocNum,
//               "FollowupEntry": followUPListData[i].FollowupEntry,
//               "Phone": followUPListData[i].Phone,
//               "Customer": followUPListData[i].Customer,
//               "CretedDate": followUPListData[i].CretedDate,
//               "LastFollowupDate": followUPListData[i].LastFollowupDate,
//               "DocTotal": followUPListData[i].DocTotal,
//               "Quantity": followUPListData[i].Quantity,
//               "Product": followUPListData[i].Product,
//               "LastFollowupStatus": followUPListData[i].LastFollowupStatus,
//               "CustomerInitialIcon": followUPListData[i].CustomerInitialIcon,
//               "height": followUPListData[i].height,
//             }
//           ]
//         });
//       } else {
//         mapValue.addAll({
//           followUPListData[i].FollowupDate: [
//             {
//               "LeadDocEntry": followUPListData[i].LeadDocEntry,
//               "LeadDocNum": followUPListData[i].LeadDocNum,
//               "FollowupEntry": followUPListData[i].FollowupEntry,
//               "Phone": followUPListData[i].Phone,
//               "Customer": followUPListData[i].Customer,
//               "CretedDate": followUPListData[i].CretedDate,
//               "LastFollowupDate": followUPListData[i].LastFollowupDate,
//               "DocTotal": followUPListData[i].DocTotal,
//               "Quantity": followUPListData[i].Quantity,
//               "Product": followUPListData[i].Product,
//               "LastFollowupStatus": followUPListData[i].LastFollowupStatus,
//               "CustomerInitialIcon": followUPListData[i].CustomerInitialIcon,
//               "height": followUPListData[i].height,
//             }
//           ]
//         });
//       }
//       var jsonEncoded = json.encode(mapValue);
//       log("Maped values: " + jsonEncoded.toString());
//     }
//   }

//   var mapValue = {};

//   createaMAp2(List<FollowUPListData> followUPListData) {
//     log("followup length data: " + followUPListData.length.toString());

//     for (int i = 0; i < followUPListData.length; i++) {
//       addValueToMap(mapValue, followUPListData[i].FollowupDate, {
//         "LeadDocEntry": followUPListData[i].LeadDocEntry,
//         "LeadDocNum": followUPListData[i].LeadDocNum,
//         "FollowupEntry": followUPListData[i].FollowupEntry,
//         "Phone": followUPListData[i].Phone,
//         "Customer": followUPListData[i].Customer,
//         "CretedDate": followUPListData[i].CretedDate,
//         "LastFollowupDate": followUPListData[i].LastFollowupDate,
//         "DocTotal": followUPListData[i].DocTotal,
//         "Quantity": followUPListData[i].Quantity,
//         "Product": followUPListData[i].Product,
//         "LastFollowupStatus": followUPListData[i].LastFollowupStatus,
//         "CustomerInitialIcon": followUPListData[i].CustomerInitialIcon,
//       });
//     }

//     var jsonEncoded = json.encode(mapValue);
//     log("Maped values: " + jsonEncoded.toString());
//   }

//     createaMAp3(List<FollowUPListData> followUPListData) {
//     log("followup length data: " + followUPListData.length.toString());

//     for (int i = 0; i < followUPListData.length; i++) {
//       addValueToMap2(mapValue, followUPListData[i].FollowupDate!, 
//         {
//            "Date":followUPListData[i].FollowupDate,
//             "List": [{
//         "LeadDocEntry": followUPListData[i].LeadDocEntry,
//         "LeadDocNum": followUPListData[i].LeadDocNum,
//         "FollowupEntry": followUPListData[i].FollowupEntry,
//         "Phone": followUPListData[i].Phone,
//         "Customer": followUPListData[i].Customer,
//         "CretedDate": followUPListData[i].CretedDate,
//         "LastFollowupDate": followUPListData[i].LastFollowupDate,
//         "DocTotal": followUPListData[i].DocTotal,
//         "Quantity": followUPListData[i].Quantity,
//         "Product": followUPListData[i].Product,
//         "LastFollowupStatus": followUPListData[i].LastFollowupStatus,
//         "CustomerInitialIcon": followUPListData[i].CustomerInitialIcon,
//       }]
//       }
//       );
//     }

//     var jsonEncoded = json.encode(mapValue);
//     log("Maped values33: " + jsonEncoded.toString());
//   }

//   void addValueToMap<K, V>(Map<dynamic, dynamic> map, K key, V value) =>
//       map.update(key, (list) => list..add(value), ifAbsent: () => [value]);

//         void addValueToMap2(Map<dynamic, dynamic> map,String key,dynamic values ) =>
//       map.update(key, (value) => value..add(values), ifAbsent: () => [values]);

//   List<FollowUPListData> fupListDatadistinct = [];
//   List<FollowUPListData> get getfupListDatadistinct => fupListDatadistinct;

//   List<String?> distinctData = [];
//   List<String?> get getdistinctData => distinctData;

//   getdataDistinct() {
//     List<FollowUPListData> istinct = [];
//     for (int i = 0; i < fupListData.length; i++) {
//       //     if(fupListData[i].FollowupDate == ){
//       //       fupListDatadistinct.add(
//       //         FollowUPListData(
//       //           FollowupDate: fupListData[i].FollowupDate,
//       //           LeadDocEntry: fupListData[i].LeadDocEntry,
//       //           LeadDocNum: fupListData[i].LeadDocNum,
//       //           FollowupEntry: fupListData[i].FollowupEntry,
//       //           Phone: fupListData[i].Phone,
//       //           Customer: fupListData[i].Customer,
//       //           CretedDate: fupListData[i].CretedDate,
//       //           LastFollowupDate: fupListData[i].LastFollowupDate,
//       //           DocTotal: fupListData[i].DocTotal,
//       //           Quantity: fupListData[i].Quantity,
//       //           Product: fupListData[i].Product,
//       //           LastFollowupStatus: fupListData[i].LastFollowupStatus,
//       //            LastFollowup_Feedback: fupListData[i].LastFollowup_Feedback,
//       //            CustomerInitialIcon: fupListData[i].CustomerInitialIcon,
//       //            height: fupListData[i].height)
//       //       );
//       //     }
//       distinctData = fupListData.map((e) => e.FollowupDate).toSet().toList();
//     }
//   }

//   var mapsnew = [
//     {
//       "Date": "2022-10-20T00:00:00",
//       "List": [
//         {
//           "LeadDocEntry": 7,
//           "LeadDocNum": 220200007,
//           "FollowupEntry": 4,
//           "Phone": "1234567890",
//           "Customer": "paramesh",
//           "CretedDate": "2022-10-20T00:00:00",
//           "LastFollowupDate": "2022-10-20T00:00:00",
//           "DocTotal": 30000.0,
//           "Quantity": "1",
//           "Product": "SONY ACCESSORIES HDMI CABL",
//           "LastFollowupStatus": "New Lead",
//           "CustomerInitialIcon": "PH",
//           "height": 120.0
//         },
//         {
//           "LeadDocEntry": 9,
//           "LeadDocNum": 220200009,
//           "FollowupEntry": 6,
//           "Phone": "8610659133",
//           "Customer": "parthi",
//           "CretedDate": "2022-10-20T00:00:00",
//           "LastFollowupDate": "2022-10-20T00:00:00",
//           "DocTotal": 60000.0,
//           "Quantity": "1",
//           "Product": "IPHONE MOBILE 12 64GB WHIT",
//           "LastFollowupStatus": "New Lead",
//           "CustomerInitialIcon": "PI",
//           "height": 120.0
//         }
//       ],
//     },
//     {
//       "Date": "2022-10-20T00:00:00",
//       "List": [
//         {
//           "LeadDocEntry": 8,
//           "LeadDocNum": 220200008,
//           "FollowupEntry": 5,
//           "Phone": "8610659137",
//           "Customer": "velu",
//           "CretedDate": "2022-10-20T00:00:00",
//           "LastFollowupDate": "2022-10-20T00:00:00",
//           "DocTotal": 20000.0,
//           "Quantity": "2",
//           "Product": "SONY ACCESSORIES SMART HOM",
//           "LastFollowupStatus": "New Lead",
//           "CustomerInitialIcon": "VU",
//           "height": 120.0
//         }
//       ]
//     }
//   ];
// }

