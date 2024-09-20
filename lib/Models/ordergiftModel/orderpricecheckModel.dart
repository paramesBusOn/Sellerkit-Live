
import 'dart:convert';
import 'dart:developer';

class OrderpriceDetails{
 Orderpriceheader? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  OrderpriceDetails(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory OrderpriceDetails.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      
      return OrderpriceDetails(
        itemdata: Orderpriceheader.fromJson(jsons),
        message:"Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return OrderpriceDetails(
        itemdata: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  
factory OrderpriceDetails.issues(Map<String,dynamic> jsons,int stcode) {
    return OrderpriceDetails(
        itemdata: null, message: jsons['respCode'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }
  factory OrderpriceDetails.error(String jsons,int stcode) {
    return OrderpriceDetails(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }

}
class Orderpriceheader{
  
  List<OrderPricecheckData>? childdata;
  Orderpriceheader({
    required this.childdata

  });
  factory Orderpriceheader.fromJson(Map<String, dynamic> jsons) {
  //  if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      if(list.isEmpty){
        return Orderpriceheader(
       childdata: null, 
        );

      }
       else {
      List<OrderPricecheckData> dataList =
          list.map((data) => OrderPricecheckData.fromJson(data)).toList();
      return Orderpriceheader(
        
        childdata: dataList, 
       );
   
   
      
    }

    
   }
  
}
class OrderPricecheckData {
  OrderPricecheckData({
   
   required this. validity
    
  });
String? validity;


  factory OrderPricecheckData.fromJson(Map<String, dynamic> json) =>
   OrderPricecheckData(
    validity:json['validity']??'', 
    
    );
    
}
