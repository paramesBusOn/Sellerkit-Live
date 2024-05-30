

import 'dart:convert';
import 'dart:developer';

class siteInModel {
siteInModelDetailsData? siteInModelDetail;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  siteInModel(
      {required this.siteInModelDetail,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory siteInModel.fromJson(Map<String,dynamic> jsons,int stcode) {
    if ( jsons != null && jsons.isNotEmpty) {
      return siteInModel(
        siteInModelDetail: siteInModelDetailsData.fromJson(jsons),
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
     
    }

     else {
      return siteInModel(
        siteInModelDetail: null,
        message: "Error",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }
factory siteInModel.issues(Map<String,dynamic> jsons,int stcode) {
    return siteInModel(
        siteInModelDetail: null, message: jsons['respCode'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }
  factory siteInModel.error(String jsons,int stcode) {
    return siteInModel(
        siteInModelDetail: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class siteInModelDetailsData {
  siteInModelDetailsData({
    required this.visitplanid,
    required this.sightcheckinTime
   
  });

  String? sightcheckinTime;
  int? visitplanid;
  
  
  factory siteInModelDetailsData.fromJson(Map<String, dynamic> json) =>
   siteInModelDetailsData(
    visitplanid: json["vistitplanId"],
     sightcheckinTime: json["siteChekInTime"]
     );
   
}