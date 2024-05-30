// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:developer';

class CollectionPostList {
  String? exception;
  int? stcode;
  String? resType;
  // Error? error ;
  String? message;
  CollectionGetDetails2? datadetail;

  CollectionPostList(
      {this.exception,
      required this.datadetail,
      required this.stcode,
      required this.resType,
      // this.error,
      required this.message});
  factory CollectionPostList.fromJson(Map<String, dynamic> jsons, int stcode) {
    var list = json.decode(jsons["data"]) as Map<String, dynamic>;

    return CollectionPostList(
        stcode: stcode,
        exception: null,
        resType: jsons["respType"],
        // error: null,
        message: jsons['respDesc'],
        datadetail: CollectionGetDetails2.fromJson(list)
        );
  }

  factory CollectionPostList.error(String jsons, int stcode) {
    return CollectionPostList(
        stcode: stcode,
        exception: jsons,
        resType: null,
        // error: null,
        message: null,
        datadetail: null
        );
  }

  factory CollectionPostList.issue(Map<String, dynamic> jsons, int stcode) {
    return CollectionPostList(
        stcode: stcode,
        exception: jsons['respDesc'],
        resType: jsons["respCode"] ?? '',
        // error: jsons==null?null: Error.fromJson(jsons['error']),
        message: null,
        datadetail: null
        );
  }

  //json==null?null: Error.fromJson(json['error']),
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
  String? cardslipImg;
  double? upiamt;
  int? onaccount;
//

  CollectionDataIpayMaster(
      {
      //
      required this.docentry,
      required this.docNum,
      required this.docDate,
//
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
        amountpaid: json['AmountPaid'] ?? 0.0,
        cashamt: json['CashAmt'] ?? 0.0,
        chqamt: json['ChqAmt'] ?? 0.0,
        chequedate: json['ChequeDate'] ?? '',
        chequeref: json['ChequeRef'] ?? '',
        chequeimg: json['ChequeImg'] ?? '',
        neftamt: json['NeftAmt'] ?? 0.0,
        neftref: json['NeftRef'] ?? '',
        cardamt: json['CardAmt'] ?? 0.0,
        cardslipImg: json['CardSlipImg'] ?? '',
        upiamt: json['UPIAmt'] ?? 0.0,
        onaccount: json['OnAccount'] ?? 0.0,
        Mobile: json['CustomerMobile'] ?? '', docNum: json['DocNum'] ?? 0,
        docDate: json['DocDate'] ?? '', //
      );
}

class CollectionGetDetails2 {
  CollectionGetDetails2({required this.ipaymaster, required this.IpaylineLine});

  List<CollectionDataIpayMaster>? ipaymaster;
  List<CollectionDataIpaylineLine>? IpaylineLine;
  factory CollectionGetDetails2.fromJson(Map<String, dynamic> json) {
    // final Map<String, dynamic> json = jsonDecode(jsons);
    // return CollectionGetDetails2(
    //   ipaymaster: List<CollectionDataIpayMaster>.from(
    //     json['IPaymaster'].map((x) => CollectionDataIpayMaster.fromJson(x)),
    //   ),
    //   IpaylineLine: List<CollectionDataIpaylineLine>.from(
    //     json['Ipayline'].map((x) => CollectionDataIpaylineLine.fromJson(x)),
    //   ),
    // );
    print('IPaymaster json' + json["IpayMaster"].toString());
    print('Ipayline json' + json["Ipayline"].toString());

    if (json["IpayMaster"] != null && json["Ipayline"] != null) {
      var list = json["IpayMaster"] as List;
      var list2 = json["Ipayline"] as List;
      List<CollectionDataIpaylineLine> dataList1 = list2
          .map((data) => CollectionDataIpaylineLine.fromJson(data))
          .toList();
      log("dataList1:::" + dataList1.length.toString());
      List<CollectionDataIpayMaster> dataList2 =
          list.map((data) => CollectionDataIpayMaster.fromJson(data)).toList();

      return CollectionGetDetails2(
          ipaymaster: dataList2, IpaylineLine: dataList1);
    } else {
      return CollectionGetDetails2(ipaymaster: null, IpaylineLine: null);
    }
  }
}

class CollectionDataIpaylineLine {
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

  CollectionDataIpaylineLine({
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
  factory CollectionDataIpaylineLine.fromJson(Map<String, dynamic> json) =>
      CollectionDataIpaylineLine(
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
