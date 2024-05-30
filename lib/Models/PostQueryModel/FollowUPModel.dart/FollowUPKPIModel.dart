// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

class FollowUPKPIModel {
FollowUPKPIheader? followUPKPIheadr;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  FollowUPKPIModel(
      {required this.followUPKPIheadr,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory FollowUPKPIModel.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons != null) {
      // var list = json.decode(jsons["data"]) as List;
      // List<FollowUPKPIData> dataList =
      //     list.map((data) => FollowUPKPIData.fromJson(data)).toList();
      return FollowUPKPIModel(
        followUPKPIheadr: FollowUPKPIheader.fromJson(jsons),
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return FollowUPKPIModel(
        followUPKPIheadr: null,
        message:"Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }
  factory FollowUPKPIModel.issues(Map<String,dynamic> jsons,int stcode) {
    return FollowUPKPIModel(
        followUPKPIheadr: null, message: jsons['respType'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }

  factory FollowUPKPIModel.error(String jsons,int stcode) {
    return FollowUPKPIModel(
        followUPKPIheadr: null, 
        message: 'Exception', 
        status: null,   
        stcode: stcode,
        exception:jsons);
  }
}
class FollowUPKPIheader{
 List<FollowUPKPIData>? followUPKPIData; 
 FollowUPKPIheader({
required this.followUPKPIData,
 });
 factory FollowUPKPIheader.fromJson(Map<String, dynamic> jsons) {
   var list = json.decode(jsons["data"]) as List;
   log("list::"+list.length.toString());
   if (list.isEmpty) {
    return FollowUPKPIheader(
      followUPKPIData: null
    );
   }else{
     List<FollowUPKPIData> dataList =
          list.map((data) => FollowUPKPIData.fromJson(data)).toList();
          log("dataList..."+dataList.length.toString());
          return FollowUPKPIheader(
           followUPKPIData: dataList,
          );
   }

 }
}

class FollowUPKPIData {
  FollowUPKPIData({
    required this.OverdueKPI_Head_1,
    required this.OverdueKPI_Line_1,
    required this.OverdueKPI_Line_2,
   


  });

  String? OverdueKPI_Head_1;
  String? OverdueKPI_Line_1;
  String? OverdueKPI_Line_2;
  


  factory FollowUPKPIData.fromJson(Map<String, dynamic> json) =>
   FollowUPKPIData(
     OverdueKPI_Head_1: json['Status'] ?? '',
     OverdueKPI_Line_1: json['Line1']??'',
     OverdueKPI_Line_2: json['Line2']??'',
    

     );
}
