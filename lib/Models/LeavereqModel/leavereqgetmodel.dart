

import 'dart:convert';
import 'dart:developer';

class leavereqgetmodel {
leavereqgetdetails? leavereqdetails;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  leavereqgetmodel(
      {required this.leavereqdetails,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory leavereqgetmodel.fromJson(Map<String,dynamic> jsons,int stcode) {
    if ( jsons != null && jsons.isNotEmpty) {
      return leavereqgetmodel(
        leavereqdetails: leavereqgetdetails.fromJson(jsons),
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
     
    }

     else {
      return leavereqgetmodel(
        leavereqdetails: null,
        message: "Error",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory leavereqgetmodel.error(String jsons,int stcode) {
    return leavereqgetmodel(
        leavereqdetails: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class leavereqgetdetails {
  leavereqgetdetails({
    required this.username,
    required this.managername,
    required this.managerslp
   
  });

  String? username;
  String? managername;
  String? managerslp;
  
  
  factory leavereqgetdetails.fromJson(Map<String, dynamic> json) =>
   leavereqgetdetails(
    username: json["userName"],
     managername: json["managername"],
     managerslp: json["managerSlp"]
     );
   
}