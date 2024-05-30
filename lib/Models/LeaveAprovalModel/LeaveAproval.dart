

import 'dart:convert';
import 'dart:developer';

class leaveApprovemodel {
List<leaveApprovedetails>? leaveapprovedetails;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  leaveApprovemodel(
      {required this.leaveapprovedetails,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory leaveApprovemodel.fromJson(dynamic jsons,int stcode) {
    if ( jsons != null && jsons.isNotEmpty) {
      var list=jsons as List;
      List<leaveApprovedetails> datalist=list.map((e) => leaveApprovedetails.fromJson(e)).toList();
      return leaveApprovemodel(
        leaveapprovedetails: datalist,
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
     
    }

     else {
      return leaveApprovemodel(
        leaveapprovedetails: null,
        message: "Error",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory leaveApprovemodel.error(String jsons,int stcode) {
    return leaveApprovemodel(
        leaveapprovedetails: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class leaveApprovedetails {
  leaveApprovedetails({
    required this.endDate,
    required this.halfDay,
    required this.id,
    required this.leaveRequestType,
    required this.leavetype,
    required this.noOfleaveReqDays,
    required this.reason,
    required this.reportingTo,
    required this.slpCode,
    required this.startDate,
    required this.status,
    required this.userCode,
    required this.userName
   
  });
int? id;
String? slpCode;
String? reportingTo;
String? leaveRequestType;
String? leavetype;
String? startDate;
String? endDate;
String? halfDay;
int? noOfleaveReqDays;
String? reason;
int? status;
String? userName;
String? userCode;

  
  
  
  factory leaveApprovedetails.fromJson(Map<String, dynamic> json) =>
   leaveApprovedetails(
    endDate: json['endDate'], 
    halfDay: json['halfDay'], 
    id: json['id'], 
    leaveRequestType: json['leaveRequestType'], 
    leavetype: json['leavetype'], 
    noOfleaveReqDays: json['noOfleaveReqDays'], 
    reason: json['reason'], 
    reportingTo: json['reportingTo'], 
    slpCode: json['slpCode'], 
    startDate: json['startDate'], 
    status: json['status'], 
    userCode: json['userCode'], 
    userName: json['userName']
    );
   
}