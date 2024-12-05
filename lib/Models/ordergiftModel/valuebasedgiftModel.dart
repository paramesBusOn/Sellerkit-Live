
import 'dart:convert';
import 'dart:developer';

class ValueBasedgiftDetails{
 ValueBasedgiftheader? itemdata;
  String message;
  bool? status;
  String? exception;
  int?stcode;
  ValueBasedgiftDetails(
      {required this.itemdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode
      });
  factory ValueBasedgiftDetails.fromJson(Map<String, dynamic> jsons,int stcode) {
    if (jsons != null && jsons.isNotEmpty) {
      
      return ValueBasedgiftDetails(
        itemdata: ValueBasedgiftheader.fromJson(jsons),
        message:"Success",
        status: true,
        stcode: stcode,
        exception:null
      );
    } else {
      return ValueBasedgiftDetails(
        itemdata: null,
        message: "Failure",
        status: false,
        stcode: stcode,
        exception:null
      );
    }
  }

  
factory ValueBasedgiftDetails.issues(Map<String,dynamic> jsons,int stcode) {
    return ValueBasedgiftDetails(
        itemdata: null, message: jsons['respCode'], status: null,   stcode: stcode,
        exception:jsons['respDesc']);
  }
  factory ValueBasedgiftDetails.error(String jsons,int stcode) {
    return ValueBasedgiftDetails(
        itemdata: null, message: 'Exception', status: null,   stcode: stcode,
        exception:jsons);
  }

}
class ValueBasedgiftheader{
  
  List<ValueBasedgiftData>? childdata;
  ValueBasedgiftheader({
    required this.childdata

  });
  factory ValueBasedgiftheader.fromJson(Map<String, dynamic> jsons) {
  //  if (jsons["data"] != null) {
      var list = json.decode(jsons["data"]) as List;
      if(list.isEmpty){
        return ValueBasedgiftheader(
       childdata: null, 
        );

      }
       else {
      List<ValueBasedgiftData> dataList =
          list.map((data) => ValueBasedgiftData.fromJson(data)).toList();
      return ValueBasedgiftheader(
        
        childdata: dataList, 
       );
   
   
      
    }

    
   }
  
}
class ValueBasedgiftData {
  ValueBasedgiftData({
   required this.BaseLine,
   required this.CreatedBy,
   required this.CreatedDateTime,
   required this.Id,
   required this.ItemCode,
   required this.ItemName,
   required this.LineNum,
   required this.MaxQty,
   required this.MinQty,
   required this.OfferSetup_Id,
   required this.Price,
   required this.UpdatedBy,
   required this.quantity,
    required this.GiftQty,
     required this.Allowpartialgift
    
  });
  int? Id;
  int? OfferSetup_Id;
  int? BaseLine;
  int? LineNum;
  String? ItemCode;
  String? ItemName;
  double? Price;
  int? MinQty;
  int? MaxQty;
  int? CreatedBy;
  String? CreatedDateTime;
  int? UpdatedBy;
  int? quantity;
  dynamic GiftQty;
  int? Allowpartialgift;
  
  factory ValueBasedgiftData.fromJson(Map<String, dynamic> json) =>
   ValueBasedgiftData(
    Allowpartialgift:json['Allowpartialgift'],
    GiftQty:json['GiftQty'],
    quantity:json['MinQty']??0, 
    BaseLine: json['BaseLine']??0, 
    CreatedBy: json['CreatedBy']??0, 
    CreatedDateTime: json['CreatedDateTime']??'', 
    Id: json['Id']??0, 
    ItemCode: json['ItemCode']??'', 
    ItemName: json['ItemName']??'', 
    LineNum: json['LineNum']??0, 
    MaxQty: json['MaxQty']??0, 
    MinQty: json['MinQty']??0, 
    OfferSetup_Id: json['OfferSetup_Id']??0, 
    Price: json['Price']??0.0, 
    UpdatedBy: json['UpdatedBy']??0
    );
    
}
