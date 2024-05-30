import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sellerkit/DBModel/order_filterdbmodel.dart';

class SPupdateModal {
  SPupdateDataheader? updateDataheader;
 
  String message;
  bool? status;
  String? exception;
  int? stcode;
  SPupdateModal(
      {required this.updateDataheader,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory SPupdateModal.fromJson(Map<String,dynamic> jsons, int stcode) {
    print("inside class" + jsons.toString());

    if (jsons != null || jsons.isNotEmpty) {
     
      
      return SPupdateModal(
          updateDataheader: null,
          message: "Sucess",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return SPupdateModal(
          updateDataheader: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }
factory SPupdateModal.issues(Map<String,dynamic> jsons, int stcode) {
    return SPupdateModal(
        updateDataheader: null,
        message: jsons['respCode'],
        status: null,
        stcode: stcode,
        exception: jsons['respDesc']);
  }
  factory SPupdateModal.error(String jsons, int stcode) {
    return SPupdateModal(
        updateDataheader: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}
class SPupdateDataheader{

}