import 'dart:convert';

import 'package:sellerkit/DBModel/stateDBModel.dart';

class stateDetails {
stateHeader? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  stateDetails(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory stateDetails.fromJson(Map<String,dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      // var list = jsons as List;
      // List<EnquiriesData> dataList =
      //     list.map((data) => EnquiriesData.fromJson(data)).toList();
      return stateDetails(
        itemdata: stateHeader.fromJson(jsons),
        message: "Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return stateDetails(
        itemdata: null,
        message:"Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }
factory stateDetails.issues(Map<String,dynamic> jsons,int stcode) {
    return stateDetails(
        itemdata: null, message: jsons['respType'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }
  factory stateDetails.error(String jsons,int stcode) {
    return stateDetails(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }
}

class stateHeader {
  stateHeader({
   required this.respCode,
   required this.datadetail,
   required this.respDesc,
   required this.respType

   // required this.customertag
  });

  String? respType;
    String? respCode;
    String? respDesc;
    List<stateHeaderData>? datadetail;

  factory stateHeader.fromJson(Map<String, dynamic> jsons) {
  //  if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      if(list.isEmpty){
        return stateHeader(
      respCode: jsons['respCode'], 
        datadetail: null, 
        respDesc: jsons['respDesc'], 
        respType: jsons['respType']
        );

      }
       else {
      List<stateHeaderData> dataList =
          list.map((data) => stateHeaderData.fromJson(data)).toList();
      return stateHeader(
        respCode: jsons['respCode'], 
        datadetail: dataList, 
        respDesc: jsons['respDesc'], 
        respType: jsons['respType']
        );
   
   
      
    }
   }
}

class stateHeaderData{

 String? statecode;
  String? stateName;//
  String? countrycode;//
  String? countryname;//
  


stateHeaderData({
required this.statecode,
required this.stateName,
required this.countrycode,
required this.countryname,

});
 factory stateHeaderData.fromJson(Map<String, dynamic> json) =>
   stateHeaderData(
     statecode: json['StateCode'] ?? 0,//
     stateName: json['StateName'] ?? '',//
     countrycode: json['CountryCode'] ?? '', //
     countryname: json['CountryName'] ?? '', //
     

    
     );

     Map<String, Object?> toMap() => {
        StateMasterDB.statecode: statecode,
        StateMasterDB.statename: stateName,
        StateMasterDB.cuntrycode: countrycode,
        StateMasterDB.countryname: countryname,
        
      };
}
