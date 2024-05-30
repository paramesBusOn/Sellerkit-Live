import 'dart:convert';
import 'dart:developer';

import '../../DBModel/CustomerModel.dart';

class CustomerDetails {
  List<CustomerData>? itemdata;
  String message;
  bool? status;
  String? exception;
  int? stcode;
  CustomerDetails(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory CustomerDetails.fromJson(List<dynamic> jsons, int stcode) {
    if (jsons != null) {
      var list = jsons as List;
      // log("listsL:"+list.toString());
      List<CustomerData> dataList =
          list.map((data) => CustomerData.fromJson(data)).toList();
      return CustomerDetails(
          itemdata: dataList,
          message: "Success",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return CustomerDetails(
          itemdata: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }

 factory CustomerDetails.issues(Map<String,dynamic> jsons, int stcode) {
    return CustomerDetails(
        itemdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons['respDesc']);
  }
  factory CustomerDetails.error(String jsons, int stcode) {
    return CustomerDetails(
        itemdata: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class CustomerData {
  CustomerData({
    required this.id,
    required this.cardcode,
    required this.cardname,
    required this.cantactName,
    required this.mobile,
    required this.alterMobileno,
    required this.email,
    required this.gst,
    required this.address1,
    required this.address2,
    required this.zipcode,
    required this.city,
    required this.state,
    required this.area,
    required this.tag,
  });

  int? id;
  String? cardcode;
  String? cardname;
  String? cantactName;
  String? mobile;
  String? alterMobileno;
  String? email;
  String? gst;
  String? address1;
  String? address2;
  String? zipcode;
  String? city;
  String? state;
  String? area;
  String? tag;

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
      id: json['id'] == null ? 0 : int.parse(json['id'].toString()),
      cardcode: json['customerCode'] ?? '',
      cardname: json['customerName'] ?? '',
      cantactName: json['contactName'] ?? '',
      mobile: json['mobileNo'] ?? '',
      alterMobileno: json['alternateMobileNo'] ?? '',
      address2: json['address2'] ?? '',
      email: json['email'] ?? '',
      gst: json['gstNo'] ?? '',
      address1: json['address1'] ?? '',
      zipcode: json['pinCode'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      area: json['address3'] ?? "",
      tag: json['tag'] ?? "");

  Map<String, Object?> toMap() => {
        CustomerMasterDB.id: id,
        CustomerMasterDB.cardcode: cardcode,
        CustomerMasterDB.cardname: cardname,
        CustomerMasterDB.cantactName: cantactName,
        CustomerMasterDB.mobile: mobile,
        CustomerMasterDB.alterMobileno: alterMobileno,
        CustomerMasterDB.email: email,
        CustomerMasterDB.gst: gst,
        CustomerMasterDB.address1: address1,
        CustomerMasterDB.address2: address2,
        CustomerMasterDB.zipcode: zipcode,
        CustomerMasterDB.city: city,
        CustomerMasterDB.state: state,
        CustomerMasterDB.area: area,
        CustomerMasterDB.tag: tag
      };
}
