

import 'dart:convert';
import 'dart:developer';

class siteoutmodel {
List<siteInModelDetailsData>? siteInModelDetail;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  siteoutmodel(
      {required this.siteInModelDetail,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory siteoutmodel.fromJson(Map<String,dynamic> jsons,int stcode) {
    if ( jsons != null && jsons.isNotEmpty) {
       var list = json.decode(jsons['data']) as List;
      List<siteInModelDetailsData> dataList =
          list.map((data) => siteInModelDetailsData.fromJson(data)).toList();
      return siteoutmodel(
        siteInModelDetail: dataList,
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
     
    }

     else {
      return siteoutmodel(
        siteInModelDetail: null,
        message: "Error",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }
factory siteoutmodel.issues(Map<String,dynamic> jsons,int stcode) {
    return siteoutmodel(
        siteInModelDetail: null, message: jsons['respCode'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }
  factory siteoutmodel.error(String jsons,int stcode) {
    return siteoutmodel(
        siteInModelDetail: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class siteInModelDetailsData {
  siteInModelDetailsData({
    required this.visitplanid,
    required this.sightcheckinTime,
    required this.CustomerCode,
    required this.CustomerName,
    required this.CustomerMobile,
    required this.CustomerEmail,
    required this.ContactPerson,
    required this.Address1,
    required this.Address2,
    required this.Area,
    required this.City,
    required this.State,
    required this.Country,
    required this.Pincode,
    // required this. cusgroup
    
   
  });

  String? sightcheckinTime;
  int? visitplanid;
  String? CustomerCode;
  String? CustomerName;
  String? CustomerMobile;
  String? CustomerEmail;
  String? ContactPerson;
  String? Address1;
  String? Address2;
  String? Area;
  String? City;
  String? State;
  String? Country;
  String? Pincode;
  // String? cusgroup;


  
  
  factory siteInModelDetailsData.fromJson(Map<String, dynamic> json) =>
   siteInModelDetailsData(
    visitplanid: json['VisitID'], 
    sightcheckinTime: json['']??'', 
    CustomerCode: json['CustomerCode']??'', 
    CustomerName: json['CustomerName']??'', 
    CustomerMobile: json['CustomerMobile']??'', 
    CustomerEmail: json['CustomerEmail']??'', 
    ContactPerson: json['ContactPerson']??'', 
    Address1: json['Address1']??'', 
    Address2: json['Address2']??'', 
    Area: json['Area']??'', 
    City: json['City']??'', 
    State: json['State']??'', 
    Country: json['Country']??'', 
    Pincode: json['Pincode'].toString(),
    // cusgroup:json['Pincode'].toString(),
   
    );
   
}