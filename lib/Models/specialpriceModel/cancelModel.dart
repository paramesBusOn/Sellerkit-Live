import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sellerkit/DBModel/order_filterdbmodel.dart';

class SPcancelModal {
  SPcancelDataheader? updateDataheader;
 
  String message;
  bool? status;
  String? exception;
  int? stcode;
  SPcancelModal(
      {required this.updateDataheader,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory SPcancelModal.fromJson(Map<String,dynamic> jsons, int stcode) {
    print("inside class" + jsons.toString());

    if (jsons != null || jsons.isNotEmpty) {
     
      
      return SPcancelModal(
          updateDataheader: null,
          message: "Sucess",
          status: true,
          stcode: stcode,
          exception: null);
    } else {
      return SPcancelModal(
          updateDataheader: null,
          message: "Failure",
          status: false,
          stcode: stcode,
          exception: null);
    }
  }
factory SPcancelModal.issues(Map<String,dynamic> jsons, int stcode) {
    return SPcancelModal(
        updateDataheader: null,
        message: jsons['respCode'],
        status: null,
        stcode: stcode,
        exception: jsons['respDesc']);
  }
  factory SPcancelModal.error(String jsons, int stcode) {
    return SPcancelModal(
        updateDataheader: null,
        message: 'Exception',
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}
class SPcancelDataheader{

}