

import 'dart:convert';
import 'dart:developer';

class GetAllleavereqmodel {
List<Getallleavereqdetails>? leavereqdetails;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  GetAllleavereqmodel(
      {required this.leavereqdetails,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory GetAllleavereqmodel.fromJson(String jsons,int stcode) {
    if ( jsons != null && jsons.isNotEmpty) {
      var list=json.decode(jsons)  as List;
      
       List<Getallleavereqdetails> dataList =
          list.map((data) => Getallleavereqdetails.fromJson(data)).toList();
      return GetAllleavereqmodel(
        leavereqdetails: dataList,
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
     
    }

     else {
      return GetAllleavereqmodel(
        leavereqdetails: null,
        message: "Error",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory GetAllleavereqmodel.error(String jsons,int stcode) {
    return GetAllleavereqmodel(
        leavereqdetails: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class Getallleavereqdetails {
  Getallleavereqdetails({
    required this.endDate,
    required this.halfDay,
    required this.id,
    required this.leaveRequestType,
    required this.leavetype,
    required this.noOfleaveReqDays,
    required this.reason,
    required this.reportingTo,
    required this.slpcode,
    required this.startDate,
    required this.status
   
  });
int? id;
String? slpcode;
String? reportingTo;
String? leaveRequestType;
String? leavetype;
String? startDate;
String? endDate;
String? halfDay;
int? noOfleaveReqDays;
String? reason;
int? status;


 
  
  
  factory Getallleavereqdetails.fromJson(Map<String, dynamic> json) =>
   Getallleavereqdetails(
    endDate: json['endDate'], 
    halfDay: json['halfDay'], 
    id: json['id'], 
    leaveRequestType: json['leaveRequestType'], 
    leavetype: json['leavetype'], 
    noOfleaveReqDays: json['noOfleaveReqDays'], 
    reason: json['reason'], 
    reportingTo: json['reportingTo'], 
    slpcode: json['slpCode'], 
    startDate: json['startDate'], 
    status: json['status']
    );
   
}