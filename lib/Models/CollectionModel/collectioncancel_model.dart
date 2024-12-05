// ignore_for_file: file_names, unused_local_variable, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';


class ColectionCancellDetails {
  ColectionCancellDetails(
      {required this.respCode,
      // required this.datadetail,
      required this.respDesc,
      required this.respType,
      required this.stcode
      // required this.customertag
      });

  String? respType;
  String? respCode;
  String? respDesc;
  int? stcode;
  // CollectionDataIpayMaster? datadetail;

  factory ColectionCancellDetails.fromJson(
      Map<String, dynamic> jsons, int? stcode) {
    //  if (jsons["data"] != null) {
    // var list = json.decode(jsons["data"]) as Map<String,dynamic>;
    if ( jsons["data"] == null) {
      return ColectionCancellDetails(
          respCode: jsons['respCode'],
          // datadetail: null,
          respDesc: jsons['respDesc'],
          respType: jsons['respType'],
          stcode: stcode!);
    } else {
      // List<ColectionCancellDetails2> dataList =
      //     list.map((data) => ColectionCancellDetails2.fromJson(data)).toList();
      return ColectionCancellDetails(
          respCode: jsons['respCode'],
          // datadetail: CollectionDataIpayMaster.fromJson(list),
          respDesc: jsons['respDesc'],
          respType: jsons['respType'],
          stcode: stcode!);
    }
  }
  factory ColectionCancellDetails.issues(Map<String, dynamic> jsons, int stcode) {
    return ColectionCancellDetails(
        respCode: jsons['respCode'],
        // datadetail: null,
        respDesc: jsons['respDesc'],
        respType: jsons['respType'],
        stcode: stcode);
  }
  factory ColectionCancellDetails.error(String jsons, int stcode) {
    return ColectionCancellDetails(
        respCode: null,
        // datadetail: null,
        respDesc: jsons,
        respType: null,
        stcode: stcode);
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
