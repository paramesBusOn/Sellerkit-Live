

import 'dart:convert';
import 'dart:developer';

class getsiteInModel {
List<getsiteInModelData>? getsiteInDetail;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  getsiteInModel(
      {
        required this.getsiteInDetail,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory getsiteInModel.fromJson(List<dynamic> jsons,int stcode) {
    if ( jsons != null && jsons.isNotEmpty) {
       var list = jsons as List;
      List<getsiteInModelData> dataList =
          list.map((data) => getsiteInModelData.fromJson(data)).toList();
      return getsiteInModel(
        getsiteInDetail: dataList,
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
     
    }

     else {
      return getsiteInModel(
        getsiteInDetail: null,
        message: "Error",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  factory getsiteInModel.error(String jsons,int stcode) {
    return getsiteInModel(
        getsiteInDetail: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class getsiteInModelData {
  getsiteInModelData({
    required this.visitplan,
    required this.customercode,
    required this.visitactivites,
    required this.assignslpcode,
    required this.closed,
    required this.meetingtime,
    required this.visitstatus,
    required this.customername,
    required this.purposeofvisit
   
  });
String? customername;
  String? customercode;
  int? visitplan;
  visitActivites? visitactivites;
  String? assignslpcode;
  String? meetingtime;
  String? visitstatus;
  String? closed;
  String? purposeofvisit;
  
  factory getsiteInModelData.fromJson(Map<String, dynamic> json) {
 if(json["vIsitActivites"] != null ){
  return getsiteInModelData(
    visitplan: json["vIsitPlan"],
     customercode: json["customerCode"],
     visitactivites:visitActivites.fromJson(json["vIsitActivites"]) ,
     assignslpcode: json["assignedSlpCode"],
     meetingtime: json["meetingTime"],
     visitstatus: json["visitStatus"],
     closed: json["closed"],
     customername: json["customerName"],
     purposeofvisit: json["purposeofVisit"]

     );
   }else{
    return getsiteInModelData(
    visitplan: null,
     customercode: null,
     visitactivites: null,
     assignslpcode: null,
     meetingtime: null,
     visitstatus: null,
     closed: null,
     customername: null,
     purposeofvisit: null

     );
   }
   }
}
class visitActivites{
  int? id;
  int? visitplanid;
  String? sitecheckintime;
  String? sitecheckouttime;
  String? lookingfor;
  String? visitoutcomes;
  String? attcachmenturl;
  String? nextvisit;
  int? converttoeenq;
  String? visitplan;
  List<dynamic> visitchecklist;
  visitActivites({
    required this.attcachmenturl,
    required this.converttoeenq,
    required this.id,
    required this.lookingfor,
    required this.nextvisit,
    required this.sitecheckintime,
    required this.sitecheckouttime,
    required this.visitchecklist,
    required this.visitoutcomes,
    required this.visitplan,
    required this.visitplanid
  });

factory visitActivites.fromJson(Map<String,dynamic> json){
 
  return visitActivites(
    attcachmenturl: json['attachmenturl'], 
    converttoeenq: json['convertToEnquiry'], 
    id: json['id'], 
    lookingfor: json['lookingFor'], 
    nextvisit: json['nextVisit'], 
    sitecheckintime: json['siteChekInTime'], 
    sitecheckouttime: json['siteChekOutTime'], 
    visitchecklist: List<dynamic>.from(json["visitCheckList"]), 
    visitoutcomes: json['visitOutComes'], 
    visitplan: json['vistPlan'], 
    visitplanid: json['vistitplanId']
    );

}

}

class visitlist{
  
}