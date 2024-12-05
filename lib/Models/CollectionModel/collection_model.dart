// ignore_for_file: file_names, unused_local_variable, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';

// class CollectionGetList {
//   CollectionGetDetails? itemdata;
//   String message;
//   bool? status;
//   String? exception;
//   int? stcode;
//   CollectionGetList(
//       {required this.itemdata,
//       required this.message,
//       required this.status,
//       this.exception,
//       required this.stcode});
//   factory CollectionGetList.fromJson(Map<String, dynamic> jsons, int stcode) {
//     print("CollectionGetJson::"+jsons.toString());
//     if (jsons != null && jsons.isNotEmpty) {
//       // var list = json.decode(jsons) as Map<>;
//       // List<CollectionDataIpayMaster> dataList =
//       //     list.map((data) => CollectionDataIpayMaster.fromJson(data)).toList();
//       return CollectionGetList(
//           itemdata: CollectionGetDetails.fromJson(jsons),
//           message: "Success",
//           status: true,
//           stcode: stcode,
//           exception: null);
//     } else {
//       return CollectionGetList(
//           itemdata: null,
//           message: "Failure",
//           status: false,
//           stcode: stcode,
//           exception: null);
//     }
//   }
//   factory CollectionGetList.issues(Map<String, dynamic> jsons, int stcode) {
//     return CollectionGetList(
//         itemdata: null,
//         message: jsons['respCode'],
//         status: null,
//         stcode: stcode,
//         exception: jsons['respDesc']);
//   }
//   factory CollectionGetList.error(String jsons, int stcode) {
//     return CollectionGetList(
//         itemdata: null,
//         message: 'Exception',
//         status: null,
//         stcode: stcode,
//         exception: jsons);
//   }
// }

class CollectionGetDetails {
  CollectionGetDetails(
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
  CollectionGetDetails2? datadetail;

  factory CollectionGetDetails.fromJson(
      Map<String, dynamic> jsons, int? stcode) {
    //  if (jsons["data"] != null) {
    var list = json.decode(jsons["data"]) as Map<String, dynamic>;
    if (jsons["data"] == null) {
      return CollectionGetDetails(
          respCode: jsons['respCode'],
          datadetail: null,
          respDesc: jsons['respDesc'],
          respType: jsons['respType'],
          stcode: stcode!);
    } else {
      // List<CollectionGetDetails2> dataList =
      //     list.map((data) => CollectionGetDetails2.fromJson(data)).toList();
      return CollectionGetDetails(
          respCode: jsons['respCode'],
          datadetail: CollectionGetDetails2.fromJson(list),
          respDesc: jsons['respDesc'],
          respType: jsons['respType'],
          stcode: stcode!);
    }
  }
  factory CollectionGetDetails.issues(Map<String, dynamic> jsons, int stcode) {
    return CollectionGetDetails(
        respCode: jsons['respCode'],
        datadetail: null,
        respDesc: jsons['respDesc'],
        respType: jsons['respType'],
        stcode: stcode);
  }
  factory CollectionGetDetails.error(String jsons, int stcode) {
    return CollectionGetDetails(
        respCode: null,
        datadetail: null,
        respDesc: jsons,
        respType: null,
        stcode: stcode);
  }
}

class CollectionGetDetails2 {
  CollectionGetDetails2({required this.ipaymaster, required this.ipayDocLine});

  List<CollectionDataIpayMaster>? ipaymaster;
  List<CollectionDataIpayDocLine>? ipayDocLine;
  factory CollectionGetDetails2.fromJson(Map<String, dynamic> json) {
    // final Map<String, dynamic> json = jsonDecode(jsons);
    // return CollectionGetDetails2(
    //   ipaymaster: List<CollectionDataIpayMaster>.from(
    //     json['IPaymaster'].map((x) => CollectionDataIpayMaster.fromJson(x)),
    //   ),
    //   ipayDocLine: List<CollectionDataIpayDocLine>.from(
    //     json['IpayDoc'].map((x) => CollectionDataIpayDocLine.fromJson(x)),
    //   ),
    // );
    print('IPaymaster json' + json["IPaymaster"].toString());
    print('IpayDoc json' + json["IpayDoc"].toString());

    if (json["IPaymaster"] != null && json["IpayDoc"] != null) {
      var list = json["IPaymaster"] as List;
      var list2 = json["IpayDoc"] as List;
      List<CollectionDataIpayDocLine> dataList1 = list2
          .map((data) => CollectionDataIpayDocLine.fromJson(data))
          .toList();
      log("dataList1:::" + dataList1.length.toString());
      List<CollectionDataIpayMaster> dataList2 =
          list.map((data) => CollectionDataIpayMaster.fromJson(data)).toList();

      return CollectionGetDetails2(
          ipaymaster: dataList2, ipayDocLine: dataList1);
    } else {
      return CollectionGetDetails2(ipaymaster: null, ipayDocLine: null);
    }
  }
}

class CollectionDataIpayMaster {
  int? docentry;
  int? docNum;
  String? docDate;

  String? alternateMobileNo;
  String? contactName;
  String? customerName;
  String? customerGrooup;
  String? customercode;
  String? customerEmail;
  String? companyName;
  String? pAN;
  String? gSTNo;
  String? bil_Address1;
  String? bil_Address2;
  String? bil_Address3;
  String? bil_Area;
  String? bil_City;
  String? bil_District;
  String? bil_State;
  String? bil_Country;
  String? bil_Pincode;
//
  String? StoreCode;
  String? AssignedTo;
  String? Mobile;

  String? docstatus;
  int? visitid;
  double? amountpaid;
  double? cashamt;
  double? chqamt;
  String? chequedate;
  String? chequeref;
  String? chequeimg;
  double? neftamt;
  String? neftref;
  double? cardamt;
  String? cardref;
  String? cardslipImg;
  double? upiamt;
  String? upiref;

  int? onaccount;
//

  CollectionDataIpayMaster(
      {
      //
      required this.docentry,
      required this.docNum,
      required this.docDate,
//
      required this.cardref,
      required this.upiref,
      required this.customerGrooup,
      required this.customercode,
      required this.customerName,
      required this.Mobile,
      required this.AssignedTo,
      required this.StoreCode,
      required this.alternateMobileNo,
      required this.bil_Address1,
      required this.bil_Address2,
      required this.bil_Address3,
      required this.bil_Area,
      required this.bil_City,
      required this.bil_Country,
      required this.bil_District,
      required this.bil_Pincode,
      required this.bil_State,
      required this.companyName,
      required this.contactName,
      required this.customerEmail,
      required this.gSTNo,
      required this.pAN,
      //
      required this.docstatus,
      required this.visitid,
      required this.amountpaid,
      required this.cashamt,
      required this.chqamt,
      required this.chequedate,
      required this.chequeref,
      required this.chequeimg,
      required this.neftamt,
      required this.neftref,
      required this.cardamt,
      required this.cardslipImg,
      required this.upiamt,
      required this.onaccount});

  factory CollectionDataIpayMaster.fromJson(Map<String, dynamic> json) =>
      CollectionDataIpayMaster(
        docentry: json['DocEntry'] ?? 0, //
        alternateMobileNo: json['AlternateMobileNo'] ?? '', //
        contactName: json['ContactName'] ?? '', //
        customerName: json['CustomerName'] ?? '', //
        customerGrooup: json['CustomerGroup'] ?? '', //
        customercode: json['CustomerCode'] ?? '', //
        customerEmail: json['CustomerEmail'] ?? '', //
        companyName: json['CompanyName'] ?? '',
        pAN: json['PAN'] ?? '', //
        gSTNo: json['GSTNo'] ?? '', //
        bil_Address1: json['Bil_Address1'] ?? '', //
        bil_Address2: json['Bil_Address1'] ?? '', //
        bil_Address3: json['Bil_Address1'] ?? '', //
        bil_Area: json['Bil_Area'] ?? '', //
        bil_City: json['Bil_City'] ?? '',
        bil_District: json['Bil_District'] ?? '',
        bil_State: json['Bil_State'] ?? '',
        bil_Country: json['Bil_Country'] ?? '',
        bil_Pincode: json['Bil_Pincode'] ?? '',
        StoreCode: json['StoreCode'] ?? '',
        AssignedTo: json['AssignedTo'] ?? '',
        docstatus: json['DocStatus'] ?? '',
        visitid: json['VisitId'] ?? 0,
        amountpaid: json['AmountPaid'] ?? 0.00,
        cashamt: json['CashAmt'] ?? 0.0,
        chqamt: json['ChqAmt'] ?? 0.0,
        chequedate: json['ChequeDate'] ?? '',
        chequeref: json['ChequeRef'] ?? '',
        chequeimg: json['ChequeImg'] ?? '',
        neftamt: json['NeftAmt'] ?? 0.00,
        neftref: json['NeftRef'] ?? '',
        cardamt: json['CardAmt'] ?? 0.00,
        cardslipImg: json['CardSlipImg'] ?? '',
        upiamt: json['UPIAmt'] ?? 0.00,
        onaccount: json['OnAccount'] ?? 0,
        Mobile: json['CustomerMobile'] ?? '', 
        docNum: json['DocNum'] ?? 0,
        docDate: json['DocDate'] ?? '', 
        cardref: json['CardRef'] ?? '',
        upiref: json['UPIRef'] ?? '', //
      );
}

class CollectionDataIpayDocLine {
  int? docentry;
  int? linenum;
  int? outsid;
  String? transnum;
  String? transDate;
  String? transDueDate;
  String? transtype;
  String? transRef1;
  String? loanRef;
  String? collectionType;
  double? transAmount;
  double? penaltyAfterDue;
  double? collectionInc;

  double? totalAlreadyPaid;
  double? balanceToPayBef;
  double? sumApplied;

  CollectionDataIpayDocLine({
    required this.docentry,
    required this.linenum,
    required this.outsid,
    required this.transnum,
    required this.transDate,
    required this.transDueDate,
    required this.transtype,
    required this.transRef1,
    required this.loanRef,
    required this.collectionType,
    required this.transAmount,
    required this.penaltyAfterDue,
    required this.collectionInc,
    required this.totalAlreadyPaid,
    required this.balanceToPayBef,
    required this.sumApplied,
  });
  factory CollectionDataIpayDocLine.fromJson(Map<String, dynamic> json) =>
      CollectionDataIpayDocLine(
        docentry: json['DocEntry'] ?? 0,
        linenum: json['LineNum'] ?? 0,
        outsid: json['OutsID'] ?? 0,
        transnum: json['TransNum'] ?? '',
        transDate: json['TransDate'] ?? '',
        transDueDate: json['TransDueDate'] ?? '',
        transtype: json['TransType'] ?? '',
        transRef1: json['TransRef1'] ?? '',
        loanRef: json['LoanRef'] ?? '',
        collectionType: json['CollectionType'] ?? '',
        transAmount: json['TransAmount'] ?? 0.0,
        penaltyAfterDue: json['PenaltyAfterDue'] ?? 0.0,
        collectionInc: json['CollectionInc'] ?? 0.0,
        totalAlreadyPaid: json['TotalAlreadyPaid'] ?? 0.0,
        balanceToPayBef: json['BalanceToPayBef'] ?? 0.0,
        sumApplied: json['SumApplied'] ?? 0.0,
      );
}
///older code
// import 'dart:convert';

// class CollectionGetList {
// List<CollectionDataIpayMaster>? itemdata;
//   String message;
//   bool? status;
//   String? exception;
//   int?stcode;
//   CollectionGetList(
//       {required this.itemdata,
//       required this.message,
//       required this.status,
//       this.exception,
//       required this.stcode
//       });
//   factory CollectionGetList.fromJson(List< dynamic> jsons,int stcode) {
//     if (jsons != null && jsons.isNotEmpty) {
//       var list = jsons as List;
//       List<CollectionDataIpayMaster> dataList =
//           list.map((data) => CollectionDataIpayMaster.fromJson(data)).toList();
//       return CollectionGetList(
//         itemdata: dataList,
//         message: "Success",
//         status: true,
//         stcode: stcode,
//         exception:null
//       );
//     } else {
//       return CollectionGetList(
//         itemdata: null,
//         message:"Failure",
//         status: false,
//         stcode: stcode,
//         exception:null
//       );
//     }
//   }

//   factory CollectionGetList.error(String jsons,int stcode) {
//     return CollectionGetList(
//         itemdata: null, message: 'Exception', status: null,   stcode: stcode,
//         exception:jsons);
//   }
// }

// class CollectionDataIpayMaster {
//   CollectionDataIpayMaster({
//     required this.Mgr_UserName,
//     required this.EnqID,
//     required this.CardCode,
//     required this.Status,
//     required this.CardName,
//     required this.AssignedTo_User,
//     required this.EnqDate,
//     required this.Followup,
//     required this.Mgr_UserCode,
//     required this.AssignedTo_UserName,
//     required this.EnqType,
//      required this.Lookingfor,
//     required this.PotentialValue,
//     required this.Address_Line_1,
//     required this.Address_Line_2,
//     required this.Pincode,
//     required this.City,
//     required this.State,
//     required this.Country,
//     required this.Manager_Status_Tab,
//     required this.Slp_Status_Tab,
//      required this.email,
//     required this.referal,
//    // required this.customertag
//   });

//   int? EnqID;//
//   String? CardCode;//
//   String? CardName;//
//   String? EnqDate;//
//   String? Followup;//
//   String? Status;//
//   String? Mgr_UserCode;//
//   String? Mgr_UserName;//
//   String? AssignedTo_User;//
//   String? AssignedTo_UserName;//
//   String? EnqType;
//   String? Lookingfor;//
//   double? PotentialValue;//
//   String? Address_Line_1;//
//   String? Address_Line_2;//
//   String? Pincode;//
//   String? City;//
//   String? State;//
//   String? Country;//
//   String? Manager_Status_Tab;//
//   String? Slp_Status_Tab;//
//   String? email;//
//   String? referal;//
//  // String? customertag;
//  String? contactName;
//  String? altermobileNo;
//  String? customerGroup;

//   factory CollectionDataIpayMaster.fromJson(Map<String, dynamic> json) =>
//    CollectionDataIpayMaster(
//      EnqID: json['enqID'] ?? 0,
//      CardCode: json['cardCode'] ?? '',
//      Status: json['status'] ?? '',
//      CardName: json['cardName'] ?? '',
//      EnqDate: json['enqDate'] ?? '',
//      Followup: json['followup'] ?? '',
//      Mgr_UserCode: json['mgr_UserCode'] ?? '',
//      AssignedTo_UserName: json['assignedTo_UserName']?? '',
//      Mgr_UserName: json['mgr_UserName'] ?? '',
//      AssignedTo_User: json['assignedTo_User'] ?? '',
//      EnqType:json['EnqType']?? '',
//      Lookingfor: json['lookingfor'] ?? '',
//      PotentialValue: json['potentialValue'] ?? 0.00,
//      Address_Line_1: json['address_Line_1'] ?? '',
//      Address_Line_2: json['address_Line_2'] ?? '',
//      Pincode: json['pincode']?? '',
//      City: json['city'] ??'',
//      State: json['state'] ?? '',
//      Country:json['country']?? '',
//       Manager_Status_Tab: json['manager_Status_Tab'] ?? '',
//      Slp_Status_Tab: json['slp_Status_Tab'] ?? '',
//       email: json['email'] ??'',
//     referal: json['u_EnqRefer'] ??'',
//     // customertag:json['customertag'] ?? '',
//      );

// }

// //json
// //  {
// //         "enqID": 49,
// //         "cardCode": "9566580463",
// //         "status": "NEW ENQUIRY",
// //         "cardName": "anbu",
// //         "enqDate": "2023-11-10T15:59:39.7",
// //         "followup": null,
// //         "mgr_UserCode": "SLP001",
// //         "mgr_UserName": "Administrator",
// //         "assignedTo_User": "684",
// //         "assignedTo_UserName": "VELMURUGAN T",
// //         "lookingfor": "SA",
// //         "potentialValue": 0.00,
// //         "address_Line_1": null,
// //         "address_Line_2": null,
// //         "pincode": null,
// //         "city": null,
// //         "state": null,
// //         "country": null,
// //         "manager_Status_Tab": "Assigned",
// //         "slp_Status_Tab": "Open",
// //         "email": "annbu@gmail.com",
// //         "u_EnqRefer": "FACEBOOK AD"
// //     }
