
import 'dart:convert';
import 'dart:developer';

import 'package:sellerkit/DBModel/enqtype_model.dart';

class ParticularpriceDetails{
 ParticularpriceDetailsheader? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  ParticularpriceDetails(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory ParticularpriceDetails.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      
      return ParticularpriceDetails(
        itemdata: ParticularpriceDetailsheader.fromJson(jsons),
        message:"Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return ParticularpriceDetails(
        itemdata: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  
factory ParticularpriceDetails.issues(Map<String,dynamic> jsons,int stcode) {
    return ParticularpriceDetails(
        itemdata: null, message: jsons['respCode'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }
  factory ParticularpriceDetails.error(String jsons,int stcode) {
    return ParticularpriceDetails(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }

}
class ParticularpriceDetailsheader{
  
  List<ParticularpriceData>? childdata;
  ParticularpriceDetailsheader({
    required this.childdata

  });
  factory ParticularpriceDetailsheader.fromJson(Map<String, dynamic> jsons) {
  //  if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      if(list.isEmpty){
        return ParticularpriceDetailsheader(
       childdata: null, 
        );

      }
       else {
      List<ParticularpriceData> dataList =
          list.map((data) => ParticularpriceData.fromJson(data)).toList();
      return ParticularpriceDetailsheader(
        
        childdata: dataList, 
       );
   
   
      
    }

    
   }
  
}
class ParticularpriceData {
  ParticularpriceData({
   
   required this. PriceList
    
  });
String? PriceList;


  factory ParticularpriceData.fromJson(Map<String, dynamic> json) =>
   ParticularpriceData(
    PriceList:json['PriceList']??'', 
    
    );
     Map<String, Object?> toMap() => {
        particularpriceDBModel.priceList: PriceList,
        
      };
    
}
