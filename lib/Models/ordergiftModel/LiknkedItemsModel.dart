
import 'dart:convert';
import 'dart:developer';

class LinkeditemsDetails{
 Linkeditemsheader? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  LinkeditemsDetails(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory LinkeditemsDetails.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      
      return LinkeditemsDetails(
        itemdata: Linkeditemsheader.fromJson(jsons),
        message:"Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return LinkeditemsDetails(
        itemdata: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  
factory LinkeditemsDetails.issues(Map<String,dynamic> jsons,int stcode) {
    return LinkeditemsDetails(
        itemdata: null, message: jsons['respCode'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }
  factory LinkeditemsDetails.error(String jsons,int stcode) {
    return LinkeditemsDetails(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }

}
class Linkeditemsheader{
  
  List<LinkeditemsData>? childdata;
  Linkeditemsheader({
    required this.childdata

  });
  factory Linkeditemsheader.fromJson(Map<String, dynamic> jsons) {
  //  if (jsons["data"] != null) {
      var list = jsons["data"] as List;
      if(list.isEmpty){
        return Linkeditemsheader(
       childdata: null, 
        );

      }
       else {
      List<LinkeditemsData> dataList =
          list.map((data) => LinkeditemsData.fromJson(data)).toList();
      return Linkeditemsheader(
        
        childdata: dataList, 
       );
   
   
      
    }

    
   }
  
}
class LinkeditemsData {
  LinkeditemsData({
   required this.createdBy,
   required this.createdDatetime,
   required this.docEntry,
   required this.itemId,
   required this.linkedItemcode,
   required this.primaryItemcode,
   required this.tagName,
   required this.updatedBy,
   required this.updatedDatetime
    
  });
  int? docEntry;
  int? itemId;
  String? primaryItemcode;
  String? linkedItemcode;
  String? tagName;
  int? createdBy;
  String? createdDatetime;
  int? updatedBy;
  String? updatedDatetime;


  factory LinkeditemsData.fromJson(Map<String, dynamic> json) =>
   LinkeditemsData(
    createdBy: json['createdBy']??0, 
    createdDatetime: json['createdDatetime']??'', 
    docEntry: json['docEntry']??0, 
    itemId: json['itemId']??0, 
    linkedItemcode: json['linkedItemcode']??'', 
    primaryItemcode: json['primaryItemcode']??'', 
    tagName: json['tagName']??'', 
    updatedBy: json['updatedBy']??0, 
    updatedDatetime: json['updatedDatetime']??''
    );
    
}
