

import 'dart:convert';
import 'dart:developer';

class NewNotificationModel {
List<NEWnotifyData>? getsiteInDetail;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  NewNotificationModel(
      {
        required this.getsiteInDetail,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory NewNotificationModel.fromJson(Map<String,dynamic> jsons,int stcode) {
    if ( jsons['data'] != null ) {
       var list = jsons['data'] as List;
      List<NEWnotifyData> dataList =
          list.map((data) => NEWnotifyData.fromJson(data)).toList();
      return NewNotificationModel(
        getsiteInDetail: dataList,
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
     
    }

     else {
      return NewNotificationModel(
        getsiteInDetail: null,
        message: "Error",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory NewNotificationModel.error(String jsons,int stcode) {
    return NewNotificationModel(
        getsiteInDetail: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class NEWnotifyData {
  NEWnotifyData({
    
    required this.sendTime,
    required this.userId,
    required this.body,
    required this.title,
    required this.id,
    required this.notifyUrl
   
  });
String? title;
  String? body;
  int? userId;
  int? id;
  String? sendTime;
  String? notifyUrl;
 
  
  factory NEWnotifyData.fromJson(Map<String, dynamic> json) {
 
  return NEWnotifyData(
    notifyUrl:json['notifyUrl']??'',
    id:json["id"]??0 ,
    title: json["title"]??'',
     body: json["body"]??'',
     userId:json["userId"]??0,
     sendTime: json["sendTime"]??'',
     

     );
   
   }
}
