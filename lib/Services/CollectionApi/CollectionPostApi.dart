// ignore_for_file: prefer_interpolation_to_compose_strings, non_constant_identifier_names, camel_case_types

import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'package:sellerkit/Constant/Configuration.dart';
import 'package:sellerkit/Services/URL/LocalUrl.dart';

import 'package:http/http.dart' as http;

import '../../Constant/ConstantSapValues.dart';
import '../../Models/CollectionModel/CollectionPostModel.dart';
// import 'package:sellerkit/main.dart';

class CollectionPostApi {
  static Future<CollectionPostList> getCollectionData(
      postCollectBody? getCollectionbody) async {
    // int resCode = 500;
    try {
      log('CollectionPost Body:' +
          jsonEncode({
            "customercode": getCollectionbody!.customerCode.isEmpty
                ? null
                : getCollectionbody.customerCode, //
            "customername": getCollectionbody.customerName.isEmpty
                ? null
                : getCollectionbody.customerName,
            "customermobile": getCollectionbody.Mobile.isEmpty
                ? null
                : getCollectionbody.Mobile,
            "alternatemobileno": getCollectionbody.alternateMobileNo.isEmpty
                ? null
                : getCollectionbody.alternateMobileNo,
            "contactname": getCollectionbody.contactName.isEmpty
                ? null
                : getCollectionbody.contactName,
            "customeremail": getCollectionbody.customerEmail.isEmpty
                ? null
                : getCollectionbody.customerEmail,
            "companyname": getCollectionbody.companyName.isEmpty
                ? null
                : getCollectionbody.companyName,
            "customergroup": getCollectionbody.customerGrooup, //
            "pan": getCollectionbody.pAN.isEmpty ? null : getCollectionbody.pAN,
            "gstno": getCollectionbody.gSTNo.isEmpty
                ? null
                : getCollectionbody.gSTNo,
            "bil_address1": getCollectionbody.bil_Address1.isEmpty
                ? null
                : getCollectionbody.bil_Address1,
            "bil_address2": getCollectionbody.bil_Address2.isEmpty
                ? null
                : getCollectionbody.bil_Address2,
            "bil_address3": getCollectionbody.bil_Address3.isEmpty
                ? null
                : getCollectionbody.bil_Address3,
            "bil_area": getCollectionbody.bil_Area.isEmpty
                ? null
                : getCollectionbody.bil_Area,
            "bil_city": getCollectionbody.bil_City.isEmpty
                ? null
                : getCollectionbody.bil_City,
            "bil_district": getCollectionbody.bil_District.isEmpty
                ? null
                : getCollectionbody.bil_District,
            "bil_state": getCollectionbody.bil_State.isEmpty
                ? null
                : getCollectionbody.bil_State,
            "bil_country": getCollectionbody.bil_Country.isEmpty
                ? null
                : getCollectionbody.bil_Country,
            "bil_pincode": getCollectionbody.bil_Pincode.isEmpty
                ? null
                : getCollectionbody.bil_Pincode,
            "storecode": getCollectionbody.StoreCode.isEmpty
                ? null
                : getCollectionbody.StoreCode,
            "assignedto": getCollectionbody.AssignedTo.isEmpty
                ? null
                : getCollectionbody.AssignedTo,

            "docstatus": "Open", //
            "visitid": getCollectionbody.visitid == null
                ? 0
                : getCollectionbody.visitid, //
            "amountpaid": getCollectionbody.amountpaid.isEmpty
                ? null
                : getCollectionbody.amountpaid, //
            "cashamt": getCollectionbody.cashamt, //
            "chqamt": getCollectionbody.chqamt, //
            "chequedate": getCollectionbody.chequedate.isEmpty
                ? null
                : getCollectionbody.chequedate, //
            "chequeref": getCollectionbody.chequeref.isEmpty
                ? null
                : getCollectionbody.chequeref, //
            "chequeimg": getCollectionbody.chequeimg.isEmpty
                ? null
                : getCollectionbody.chequeimg, //
            "neftamt": getCollectionbody.neftamt, //
            "neftref": getCollectionbody.neftref.isEmpty
                ? null
                : getCollectionbody.neftref, //
            "cardamt": getCollectionbody.cardamt, //
            "cardslipImg": getCollectionbody.cardslipImg.isEmpty
                ? null
                : getCollectionbody.cardslipImg, //
            "upiamt": getCollectionbody.upiamt, //
            "onaccount": getCollectionbody.onaccount, //
//
            "cardref": getCollectionbody.cardref!.isEmpty
                ? null
                : getCollectionbody.cardref,
            "upiref": getCollectionbody.upiref!.isEmpty
                ? null
                : getCollectionbody.upiref,
            "remarks": getCollectionbody.remarks!.isEmpty
                ? null
                : getCollectionbody.remarks,

            "ipaylines":
                getCollectionbody.ipaylaine.map((e) => e.tojason()).toList()
          }));
      Config config = Config();
      await config.getSetup();
      final response = await http.post(
          Uri.parse("${Url.queryApi}Sellerkit_Flexi/v2/IpayAdd"),
          headers: {
            "content-type": "application/json",
            "Authorization": 'bearer ' + ConstantValues.token,
            "Location": '${ConstantValues.EncryptedSetup}'
          },
          body: jsonEncode({
            "customercode": getCollectionbody.customerCode.isEmpty
                ? null
                : getCollectionbody.customerCode, //
            "customername": getCollectionbody.customerName.isEmpty
                ? null
                : getCollectionbody.customerName,
            "customermobile": getCollectionbody.Mobile.isEmpty
                ? null
                : getCollectionbody.Mobile,
            "alternatemobileno": getCollectionbody.alternateMobileNo.isEmpty
                ? null
                : getCollectionbody.alternateMobileNo,
            "contactname": getCollectionbody.contactName.isEmpty
                ? null
                : getCollectionbody.contactName,
            "customeremail": getCollectionbody.customerEmail.isEmpty
                ? null
                : getCollectionbody.customerEmail,
            "companyname": getCollectionbody.companyName.isEmpty
                ? null
                : getCollectionbody.companyName,
            "customergroup": getCollectionbody.customerGrooup, //
            "pan": getCollectionbody.pAN.isEmpty ? null : getCollectionbody.pAN,
            "gstno": getCollectionbody.gSTNo.isEmpty
                ? null
                : getCollectionbody.gSTNo,
            "bil_address1": getCollectionbody.bil_Address1.isEmpty
                ? null
                : getCollectionbody.bil_Address1,
            "bil_address2": getCollectionbody.bil_Address2.isEmpty
                ? null
                : getCollectionbody.bil_Address2,
            "bil_address3": getCollectionbody.bil_Address3.isEmpty
                ? null
                : getCollectionbody.bil_Address3,
            "bil_area": getCollectionbody.bil_Area.isEmpty
                ? null
                : getCollectionbody.bil_Area,
            "bil_city": getCollectionbody.bil_City.isEmpty
                ? null
                : getCollectionbody.bil_City,
            "bil_district": getCollectionbody.bil_District.isEmpty
                ? null
                : getCollectionbody.bil_District,
            "bil_state": getCollectionbody.bil_State.isEmpty
                ? null
                : getCollectionbody.bil_State,
            "bil_country": getCollectionbody.bil_Country.isEmpty
                ? null
                : getCollectionbody.bil_Country,
            "bil_pincode": getCollectionbody.bil_Pincode.isEmpty
                ? null
                : getCollectionbody.bil_Pincode,
            "storecode": getCollectionbody.StoreCode.isEmpty
                ? null
                : getCollectionbody.StoreCode,
            "assignedto": getCollectionbody.AssignedTo.isEmpty
                ? null
                : getCollectionbody.AssignedTo,

            "docstatus": "Open", //
            "visitid": getCollectionbody.visitid == null
                ? 0
                : getCollectionbody.visitid, //
            "amountpaid": getCollectionbody.amountpaid.isEmpty
                ? null
                : getCollectionbody.amountpaid, //
            "cashamt": getCollectionbody.cashamt, //
            "chqamt": getCollectionbody.chqamt, //
            "chequedate": getCollectionbody.chequedate.isEmpty
                ? null
                : getCollectionbody.chequedate, //
            "chequeref": getCollectionbody.chequeref.isEmpty
                ? null
                : getCollectionbody.chequeref, //
            "chequeimg": getCollectionbody.chequeimg.isEmpty
                ? null
                : getCollectionbody.chequeimg, //
            "neftamt": getCollectionbody.neftamt, //
            "neftref": getCollectionbody.neftref.isEmpty
                ? null
                : getCollectionbody.neftref, //
            "cardamt": getCollectionbody.cardamt, //
            "cardslipImg": getCollectionbody.cardslipImg.isEmpty
                ? null
                : getCollectionbody.cardslipImg, //
            "upiamt": getCollectionbody.upiamt, //
            "onaccount": getCollectionbody.onaccount, //
             "cardref": getCollectionbody.cardref!.isEmpty
                ? null
                : getCollectionbody.cardref,
            "upiref": getCollectionbody.upiref!.isEmpty
                ? null
                : getCollectionbody.upiref,
            "remarks": getCollectionbody.remarks!.isEmpty
                ? null
                : getCollectionbody.remarks,
            "ipaylines":
                getCollectionbody.ipaylaine.map((e) => e.tojason()).toList()
          }));
      response.statusCode;

      print('Collection ResponceCode:' + response.statusCode.toString());

      print('Collection Post Responce:' + response.body.toString());
      if (response.statusCode == 200) {
        return CollectionPostList.fromJson(
            json.decode(response.body.toString()), response.statusCode);
      } else {
        return CollectionPostList.issue(
            json.decode(response.body.toString()), response.statusCode);
      }
    } catch (e) {
      return CollectionPostList.error("$e", 500);
    }
  }
}

class postCollectBody {
  //
  String alternateMobileNo;
  String contactName;
  String customerName;
  String customerGrooup;
  String customerCode;
  String customerEmail;
  String companyName;
  String pAN;
  String gSTNo;
  String bil_Address1;
  String bil_Address2;
  String bil_Address3;
  String bil_Area;
  String bil_City;
  String bil_District;
  String bil_State;
  String bil_Country;
  String bil_Pincode;

  String StoreCode;
  String AssignedTo;
  String Mobile;
  String docstatus;
  int visitid;
  String amountpaid;
  double cashamt;
  double chqamt;
  String chequedate;
  String chequeref;
  String chequeimg;
  double neftamt;
  String neftref;
  double cardamt;
  String cardslipImg;
  double upiamt;
  String? onaccount;
  //
  String? cardref;
  String? upiref;
  String? remarks;

  List<Ipaylines> ipaylaine = [];
  postCollectBody(
      {required this.cardref,
      required this.upiref,
      required this.remarks,
      //
      required this.customerGrooup,
      required this.customerCode,
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
      required this.onaccount,
      required this.ipaylaine});
}

class Ipaylines {
  int? outsid;
  String? transnum;
  double? sumapplied;

  Ipaylines({
    required this.outsid,
    required this.transnum,
    required this.sumapplied,
  });

  Map<String, dynamic> tojason() {
    Map<String, dynamic> map = {
      "outsid": outsid,
      "transnum": transnum,
      "sumapplied": sumapplied,
    };
    return map;
  }
}
